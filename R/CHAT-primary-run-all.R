
#-----------------------------------
# This script runs all scripts in
# the primary analysis for the
# CHAT trial
#
# 
#-----------------------------------
library(here)
here::here()


#-----------------------------------
# Download public datasets
#-----------------------------------
source(here::here("R/0-CHAT-Download-Public-Data.R"))

#-----------------------------------
# CONSORT Flow
#-----------------------------------
rmarkdown::render(here::here("R/1-CHAT-consort.Rmd"),
                  output_file = here::here("output/1-CHAT-consort.html"))

#-----------------------------------
# Baseline Balance
#-----------------------------------
rmarkdown::render(here::here("R/2-CHAT-baseline-balance.Rmd"),
                  output_file = here::here("output/2-CHAT-baseline-balance.html"))

#-----------------------------------
# Treatment Coverage
#-----------------------------------
rmarkdown::render(here::here("R/3-CHAT-treatmentcoverage.Rmd"),
                  output_file = here::here("output/3-CHAT-treatmentcoverage.html"))

#-----------------------------------
# Primary analysis - mortality
#-----------------------------------
rmarkdown::render(here::here("R/4-CHAT-mortality.Rmd"),
                  output_file = here::here("output/4-CHAT-mortality.html"))

#-----------------------------------
# Subgroup analyses - mortality
#-----------------------------------
rmarkdown::render(here::here("R/5-CHAT-Mortality-Subgroup.Rmd"),
                  output_file = here::here("output/5-CHAT-Mortality-Subgroup.html"))


#-----------------------------------
# Adverse events
#-----------------------------------
rmarkdown::render(here::here("R/6-CHAT-AdverseEvents.Rmd"),
                             output_file = here::here("output/6-CHAT-AdverseEvents.html"))

#-----------------------------------
# Overview map
# Note: requires GPS coordinates,
# will not run on publicly available
# data!
#-----------------------------------
rmarkdown::render(here::here("R/7-CHAT-Map.Rmd"),
                  output_file = here::here("output/7-CHAT-Map.html"))


#-----------------------------------
# Supplementary analyses
#-----------------------------------
rmarkdown::render(here::here("R/8-CHAT-supplementary.Rmd"),
                  output_file = here::here("output/8-CHAT-supplementary.html"))


#-----------------------------------
# Supplementary analyses, adjusted estimates
#-----------------------------------
rmarkdown::render(here::here("R/9-CHAT-mortality-suppl-adj-analysis.Rmd"),
                  output_file = here::here("output/9-CHAT-mortality-suppl-adj-analysis.html"))


#-----------------------------------
# Supplementary analysis, 
# coefficient of variation
#-----------------------------------
rmarkdown::render(here::here("R/10-CHAT-mortality-coeff-variation.Rmd"),
                  output_file = here::here("output/10-CHAT-mortality-coeff-variation.html"))



