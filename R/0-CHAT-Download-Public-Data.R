#-----------------------------
# CHAT-Download-Public-Data.R
#
# Download publicly available datasets
# from the Open Science Framework
# https://osf.io/4eg83/
#
# datasets are saved in:
# CHAT-Primary-Analysis/data
#-----------------------------


#-----------------------------
# preamble - source config file
#-----------------------------
library(here)
source(here("R/CHAT-primary-Config.R"))

#-----------------------------
# Download data from osf.io
#-----------------------------

# 1. CHAT_child_census_public.rds
# CHAT child level census data
# https://osf.io/tyqr6
CHAT_child_census_public <- osf_retrieve_file("tyqr6") %>%
  osf_download(path=here("data"), conflicts = "overwrite", progress = TRUE)

# 2. CHAT_child_census_wide_public.rds
# CHAT child level census data in wide format
# https://osf.io/mfde9
CHAT_child_census_wide_public <- osf_retrieve_file("mfde9") %>%
  osf_download(path=here("data"), conflicts = "overwrite", progress = TRUE)

# 3. CHAT_child_phase_public.rds
# CHAT child level census data in wide format
# https://osf.io/jkz7v
CHAT_child_phase_public <- osf_retrieve_file("jkz7v") %>%
  osf_download(path=here("data"), conflicts = "overwrite", progress = TRUE)

# 4. CHAT_cluster_age_public.rds
# CHAT child level census data in wide format
# https://osf.io/sdbmv
CHAT_cluster_age_public <- osf_retrieve_file("sdbmv") %>%
  osf_download(path=here("data"), conflicts = "overwrite", progress = TRUE)

# 5. CHAT_cluster_gender_public.rds
# CHAT child level census data in wide format
# https://osf.io/7gcd9
CHAT_cluster_gender_public <- osf_retrieve_file("7gcd9") %>%
  osf_download(path=here("data"), conflicts = "overwrite", progress = TRUE)

# 6. CHAT_cluster_phase_public.rds
# CHAT child level census data in wide format
# https://osf.io/z4tv2
CHAT_cluster_phase_public <- osf_retrieve_file("z4tv2") %>%
  osf_download(path=here("data"), conflicts = "overwrite", progress = TRUE)

# 7. CHAT_cluster_phaseyear_public.rds
# CHAT child level census data in wide format
# https://osf.io/jegkr
CHAT_cluster_phaseyear_public <- osf_retrieve_file("jegkr") %>%
  osf_download(path=here("data"), conflicts = "overwrite", progress = TRUE)

# 8. CHAT_cluster_public.rds
# CHAT child level census data in wide format
# https://osf.io/n5r3t
CHAT_cluster_public <- osf_retrieve_file("n5r3t") %>%
  osf_download(path=here("data"), conflicts = "overwrite", progress = TRUE)

# 9. CHAT_iaes_public.rds
# CHAT child level census data in wide format
# https://osf.io/gp39x
CHAT_iaes_public <- osf_retrieve_file("gp39x") %>%
  osf_download(path=here("data"), conflicts = "overwrite", progress = TRUE)

# 10. CHAT_precensus_public.rds
# CHAT child level census data in wide format
# https://osf.io/mfjx4
CHAT_precensus_public <- osf_retrieve_file("mfjx4") %>%
  osf_download(path=here("data"), conflicts = "overwrite", progress = TRUE)

# 11. CHAT_tx_alloc_public.rds
# CHAT child level census data in wide format
# https://osf.io/p2j4f
CHAT_tx_alloc_public <- osf_retrieve_file("p2j4f") %>%
  osf_download(path=here("data"), conflicts = "overwrite", progress = TRUE)


#-----------------------------
# session info
#-----------------------------
sessionInfo()

