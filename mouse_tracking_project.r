library(mousetrap)
library(readr)
library(dplyr)
library(tidyverse)
library(rstatix)
library(grid)
library(ggplot2)

mt_data <- mt_import_mousetrap(
    raw_data = data,
    xpos_label = "xpos_",
    ypos_label = "ypos_",
    timestamps_label = "timestamps_"
) %>%
mt_remap_symmetric() %>%
mt_align_start(start = c(0, 0)) %>%
mt_time_normalize() %>%
mt_subset(correct == 1)



# produce measures for data

mt_data <- mt_measures(
    mt_data,
    use = "tn_trajectories"
)