# Travis's code:

# ---------------------------------------
# Function: mk.nbpll.full()
# Code to conduct NB-1 without stratifying theta between arms
# Define a function called mk.nbpll.full that calculates the log-likelihood
# for a negative binomial regression model based on the input parameters and data.
# ---------------------------------------

mk.nbpll.full <- function(dset,show.info=FALSE) {
  if (show.info) {
    return(c("b0","b1","theta","qq"))
  }
  # Check if any of the input parameters (pars) contain missing values (NAs).
  function(pars) {
    if (any(is.na(pars))) {
      # Print the parameter values containing NA for debugging purposes.
      print(pars)
      stop("pars contains NA")
    }
    
    # Extract the number of deaths (yi) and person-years (ti) from the input dataset (dset).
    yi <- dset$ndeaths
    ti <- dset$person_years
    
    # Assign the input parameters (pars) to individual variables for easier access.
    b0 <- pars[1]
    b1 <- pars[2]
    theta <- pars[3]
    # W.Green: P = 1 for NB1; P = 2 for NB2
    qq <- pars[4]
    pp <- qq
    
    # Calculate the log-predicted rate (lpred) using the linear model with parameters b0 and b1.
    lpred <- b0 + b1*ti
    
    # Check for invalid values in the log-predicted rate, theta, and any non-finite values.
    if (any(lpred<0) || any(!is.finite(lpred)) || !is.finite(theta)) {
      -1e302
    } else {
      # If all values are valid, calculate lambda (mean of the negative binomial distribution) and tle (over-dispersion parameter).
      lambda <- lpred*ti
      tle <- theta*lambda^(2-pp)
      
      # Compute the log-likelihood using a negative binomial distribution (dnbinom)
      # based on the input parameters and the data from dset.
      # Return the sum of the log-probabilities by setting log=TRUE in dnbinom.
      sum(dnbinom(yi,mu=lambda,size=tle,log=TRUE))
    }
  }
}

# ---------------------------------------
# do.reg()
# Define a function called do.reg 
# that estimates the parameters of a model 
# and computes the log-likelihood.
# ---------------------------------------
do.reg <- function(dset,b0=NA,b1=NA,theta=NA,qq=NA,lf.generator=mk.nbll.full) {
  # Define a vector with the standard names of the parameters: 
  # "b0", "b1", "theta", and "qq".
  standard.names <- c("b0","b1","theta","qq")
  
  # Calculate the overall mort rate
  ovav <- sum(dset$ndeaths)/sum(dset$person_years)
  
  # Create the log-likelihood function fn using the lf.generator function and the input dataset.
  # mk.nbpll.full()
  fn <- lf.generator(dset)
  
  # Create vectors of assumed fixed base parameters, transformation functions (for optimization), and
  # inverse transformation functions (for converting transformed parameters back to the original scale).
  assumed.fixed.base <- c(b0,b1,theta,qq) 
  trans.base <- list(exp,function(x)x,exp,exp)    # these are not links, just for optimization convenience
  inv.base <- list(log,function(x)x,log,log)
  propo.init.base <- unlist(Map(function(f,x)f(x),inv.base,c(ovav,0,1,1)))
  
  # Retrieve the names of parameters used in the log-likelihood function.
  given.vars <- retrieve.variables(lf.generator)
  
  # Restrict to only the parameters used in the log-likelihood function,
  # and assign them to assumed.fixed, trans, inv, and propo.init.
  c(assumed.fixed,trans,inv,propo.init) %<-% 
    names.restrict(all.names=standard.names,
                   given.names=given.vars,
                   list(assumed.fixed.base,trans.base,inv.base,propo.init.base))
  
  # Count the number of estimated parameters (NA values in assumed.fixed).
  n.est <- sum(is.na(assumed.fixed))
  
  # If there are estimated parameters, perform optimization to find their values.
  if (n.est>0) {
    # Transform the assumed fixed parameters to their respective transformed scales.
    transformed.assumed.fixed <- unlist(Map(function(f,x)f(x),inv,assumed.fixed))
    
    # Create an optimization function opt.fn, 
    # which takes transformed parameters and returns the log-likelihood.
    opt.fn <- function(pars) { 
      full.pars <- transformed.assumed.fixed
      if (length(pars)!=n.est) {
        stop("bad pars length")
      }
      full.pars[is.na(full.pars)] <- pars
      fn(unlist(Map(function(f,x)f(x),trans,full.pars)))    # back transform them to the original scale
    }
    
    # Prepare initial parameter values for optimization.
    init <- propo.init[is.na(assumed.fixed)]
    if (n.est==1) {
      est.index <- which(is.na(assumed.fixed))
      if (length(est.index)) {
        stop("bad est.index")
      }
      
      # If there is only one estimated parameter, use optimize for optimization.
      if (est.index==1) {
        pint <- c(-9,-1)
      } else if (est.index==2) {
        pint <- c(-1e4,1e4)   # we won't actually do much with this--untested
      } else if (est.index==3) {
        pint <- c(-1,8)   # note the poisson case will not be handled gracefully here
      } else if (est.index==4) {
        stop("not implemented")
      } else {
        stop("bad")
      } 
      
      # Use optimize to find the maximum of the log-likelihood.
      ans <- optimize(opt.fn,interval=pint,maximum=TRUE)
      full.pars <- transformed.assumed.fixed
      full.pars[is.na(full.pars)] <- ans$maximum
      o <- ans$objective
    } else {
      # If there are multiple estimated parameters, use optim for optimization.
      ans <- optim(init,opt.fn,control=list(fnscale=-1))
      full.pars <- transformed.assumed.fixed
      full.pars[is.na(full.pars)] <- ans$par
      o <- ans$value
    } 
    
    # Back-transform the estimated parameters to the original scale.
    est <- unlist(Map(function(f,x)f(x),trans,full.pars))
    degf <- n.est
  } else {
    # If no parameters are estimated, use the assumed fixed parameters.
    est <- assumed.fixed
    degf <- 0
    # Calculate the log-likelihood using the assumed fixed parameters.
    o <- fn(assumed.fixed)
  }
  
  # Return a list with the estimation results: estimated parameters (estimate),
  # degrees of freedom (deg.f), and log-likelihood value (loglik).
  list(estimate=est,deg.f=degf,loglik=o)
}

# ---------------------------------------
# retrieve.variables()
# ---------------------------------------
retrieve.variables <- function(likelihood.function.maker) {
  curnames <- likelihood.function.maker(show.info=TRUE)
  # Return the vector of parameter names.
  curnames
}



# ---------------------------------------
# names.restrict()
# ---------------------------------------
names.restrict <- function(all.names, given.names, base.lists) {
  
  # Check if there are any duplicates in the given.names.
  if (max(table(given.names)) > 1) {
    stop("duplicate in given.names")
  }
  
  # Check if given.names is a character vector.
  if (!is.character(given.names)) {
    stop("given.names not character")
  }
  
  # Check if given.names contains any empty strings.
  if (any(nchar(given.names) == 0)) {
    stop("given.names contains empty string")
  }
  
  # Check if all names in given.names are present in all.names.
  if (length(setdiff(given.names, all.names)) == 0) {
    nl <- length(given.names)
    index.map <- rep(NA, nl)
    
    # Create an index map that maps each name in given.names to its corresponding index in all.names.
    for (ii in 1:nl) {
      index.map[ii] <- which(all.names == given.names[ii])
    }
  } else {
    stop("given.names contains name not in all.names")
  }
  
  ans <- list()
  # Restrict each base list in base.lists to the subset of names specified in given.names.
  for (ii in 1:length(base.lists)) {
    cur.list <- base.lists[[ii]][index.map]
    ans[[ii]] <- cur.list
  }
  
  # Return the restricted lists as a list.
  ans
}


# ---------------------------------------
# IRR(): Define the bootstrap function to calculate IRR
# ---------------------------------------

IRR_IRD <- function(d) {
  az_person_years <- sum(d$person_years[d$tx == "Azithromycin"])
  pl_person_years <- sum(d$person_years[d$tx == "Placebo"])
  az_deaths <- sum(d$ndeaths[d$tx == "Azithromycin"])
  pl_deaths <- sum(d$ndeaths[d$tx == "Placebo"])
  irr <- (az_deaths / az_person_years) / (pl_deaths / pl_person_years)
  ird <- 1000*((az_deaths / az_person_years) - (pl_deaths / pl_person_years))
  return(c(irr, ird))
}

