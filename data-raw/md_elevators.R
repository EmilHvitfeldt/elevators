## code to prepare `md_elevators` dataset goes here

library(readxl)
library(dplyr)
library(purrr)

sheet <- "data-raw/evcounties.xlsx"

elevators <- map_dfr(excel_sheets(sheet)[-1], read_xlsx, path = sheet, col_names = names(read_xlsx(sheet, 2))) |>
  janitor::clean_names()

elevators

ag_elevators <- read_xlsx(sheet, 1) |>
  janitor::clean_names() |>
  select(-owner_contact_2) |>
  rename(owner_contact_2 = inspection_type,
         inspection_type = last_inpection_date,
         last_inpection_date = x16)

md_elevators <- bind_rows(elevators, ag_elevators) |>
  rename(last_inspection_date = last_inpection_date) |>
  filter(location_name != "Location Name")

usethis::use_data(md_elevators, overwrite = TRUE, compress = "xz")
