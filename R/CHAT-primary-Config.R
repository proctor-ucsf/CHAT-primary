#-----------------------------
# CHAT-primary-Config.R
#
# configuration file for
# the CHAT primary analyses
#-----------------------------


#-----------------------------
# load packages
#-----------------------------

# environment
library(here)
library(renv)

# data processing
library(tidyverse)
library(data.table)
library(lubridate)

# data visualization
library(cowplot) # for ggdraw
library(kableExtra)
library(scales)
library(table1)
library(ggspatial)
library(patchwork)

# data documentation
library(janitor)
library(codebook) # for codebook generation
library(labelled) # for adding labels to datasets
library(hablar)
library(labelled)
library(roperators)

# analysis
library(sandwich)
library(lmtest)
library(epitools)
library(zeallot)
# library(epiR)

# spatial
library(leaflet)
library(mapview)
library(geodata)
library(ggmap)
library(sf)
# library(ggsn) # for scale bars and north symbols
# library(rnaturalearth) # for africa country outlines

# parallel computing
library(foreach)
library(doParallel)
registerDoParallel(detectCores() - 1)

# osfr data download
library(osfr)

#-----------------------------
# unmasked
# treatment assignments
#-----------------------------
Az <- c("BB","DD","EE","GG")
Pl <- c("AA","CC","FF","HH")

#-----------------------------
# custom color palettes
#-----------------------------
# safe color blind palette
# http://jfly.iam.u-tokyo.ac.jp/color/
# http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/
# Reference: Bang Wong, Nature Methods 2011: https://www.nature.com/articles/nmeth.1618
cbpal <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

#-----------------------------
# define project directory paths
#-----------------------------
raw_data_folder <- here("~/library/cloudstorage/box-box/Burkina Faso/CHAT/data/raw/")
data_folder <- here("~/library/cloudstorage/box-box/Burkina Faso/CHAT/data/")

