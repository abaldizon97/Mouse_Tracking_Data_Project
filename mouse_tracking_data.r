library(readr)
library(dplyr)
library(tidyverse)
library(rstatix)
library(ggplot2)
library(mousetrap)

# save raw data from mousetra package
raw_data <- KH2017_raw

# create mousetrap object using mt_import_mousetrap
mt_data <- mt_import_mousetrap(
    raw_data = raw_data,
    xpos_label = "xpos_",
    ypos_label = "ypos_",
    timestamps_label = "timestamps_"
) %>%
    # remap the coordinates so that the trajectories go to the right
    mt_remap_symmetric() %>%
    # set the start coordinates the same for all trajectories
    mt_align_start(start = c(0, 0)) %>%
    # time normalize trajectories to 101 equally sized time steps
    mt_time_normalize() %>%
    # only keep the correct trials
    mt_subset(correct == 1)

# view the structure of the mousetrap object
str(mt_data)

# mousetrap object now has:
# data, trajectories, and tn_trajectories (time-normalized)

mt_data <- mt_data %>%
    mt_measures() %>%
    mt_derivatives() %>%
    mt_sample_entropy()

write.csv(mt_data$measures, paste0(getwd(), "/measures.csv"))
