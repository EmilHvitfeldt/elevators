## code to prepare `elevators` dataset goes here
library(tidyverse)

elevators_raw <- read_csv(
  "data-raw/elevators.csv",
  col_types = cols(BIN = col_character())
)
usethis::use_data(elevators_raw, overwrite = TRUE)

elevators <- elevators_raw %>%
  mutate(DV_SPEED_FPM = parse_number(DV_SPEED_FPM)) %>%
  mutate(across(c(DV_LASTPER_INSP_DATE, DV_APPROVAL_DATE, DV_STATUS_DATE), lubridate::ymd)) %>%
  filter(!is.na(DV_SPEED_FPM)) %>%
  select(-`Device Status`, -`...27`) %>%
  rename_all(str_remove, "DV_") %>%
  rename_all(tolower)

usethis::use_data(elevators, overwrite = TRUE)
