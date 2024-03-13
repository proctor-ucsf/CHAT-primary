# CHAT-primary

Primary outcome analysis for the CHAT trial

## Description

This repository includes R code to run all of the analysis for the paper:

Oldenburg et al. (2024) Mass Azithromycin Distribution to Prevent Child Mortality in Burkina Faso: The CHAT Randomized Clinical Trial. *JAMA.* 2024;331(6):482--490. <https://jamanetwork.com/journals/jama/fullarticle/2814883>

This work was funded by the Bill & Melinda Gates Foundation (grant OPP1187628), and was registered under clinical trial [NCT03676764](https://clinicaltrials.gov/study/NCT03676764)

Should you have any questions about the files in this repository, please contact Ben Arnold at UCSF ([ben.arnold\@ucsf.edu](mailto:ben.arnold@ucsf.edu){.email}) or the corresponding author for the paper.

## Linked Repositories and Additional Resources

### Open Science Framework

This GitHub repository is mirrored on the Open Science Framework (OSF). The OSF project page includes additional study-related resources, including the compiled HTML computational notebooks created from the `.Rmd` files, and the final analysis datasets.

<https://osf.io/4eg83/>

## Software Information

Following: <https://www.nature.com/documents/nr-software-policy.pdf>

### System Requirements

All analyses were run using R software version 4.3.2 on macOS Monterey using the RStudio IDE (<https://www.rstudio.com>).

`> sessionInfo()`

`R version 4.3.2 (2023-10-31)`

`Platform: aarch64-apple-darwin20 (64-bit)`

`Running under: macOS Monterey 12.6`

### Installation Guide and Instructions for Use (Desktop)

You can download and install R from CRAN: <https://cran.r-project.org>

You can download and install RStudio from their website: <https://www.rstudio.com>

All R packages required to run the analyses are sourced in the file `CHAT-primary-Config.R`.

To reproduce all analyses in the paper, we recommend that you:

1.  Clone the GitHub repository to your computer

For example, in the location on your computer where you would like to clone the repository, you could type into the Terminal command:

`git clone https://github.com/proctor-ucsf/CHAT-primary.git`

2.  Recreate the exact package environment using the `renv` package.

You can do this by opening the R project file ([CHAT-primary-analysis.Rproj](https://github.com/proctor-ucsf/CHAT-primary/blob/main/CHAT-primary-analysis.Rproj)) in RStudio, loading the `renv` package, and typing `renv::restore()` to restore the package environment from the projects [renv.lock](https://github.com/proctor-ucsf/CHAT-primary/blob/main/renv.lock) file.

3.  All of the analysis scripts should run smoothly (scripts `1-xx.Rmd` to `10-xx.Rmd`) EXCEPT for `7-CHAT-Map.Rmd`, which relies on confidential GPS information. All other scripts will run smoothly. They will save HTML file output in the /output directory.

### Additional details

You can run the `.Rmd` notebook scripts one-by-one or you can compile [`CHAT-primary-run-all.R`](https://github.com/proctor-ucsf/CHAT-primary/blob/main/R/CHAT-primary-run-all.R), which is the file we used to run the final analyses (e.g., from the command line `R CMD BATCH CHAT-primary-run-all.R &`).

### License

This project is covered by the CC0 1.0 Universal license.
