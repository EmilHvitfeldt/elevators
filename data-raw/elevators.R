## code to prepare `elevators` dataset goes here
library(tidyverse)

elevators_raw <- read_csv(
  "data-raw/elevators.csv",
  col_types = cols(
    BIN = col_character(),
    TAX_BLOCK = col_character(),
    TAX_LOT = col_character(),
    ZIP_CODE = col_character()
  )
)
usethis::use_data(elevators_raw, overwrite = TRUE)

unparsable <- function(x) {
  x <- suppressWarnings(parse_number(x))
  unique(attr(x, "problems")$actual)
}

elevators <- elevators_raw %>%
  filter(!DV_SPEED_FPM %in% unparsable(DV_SPEED_FPM)) %>%
  mutate(DV_SPEED_FPM = parse_number(DV_SPEED_FPM)) %>%
  mutate(across(c(DV_LASTPER_INSP_DATE, DV_APPROVAL_DATE, DV_STATUS_DATE), lubridate::ymd, quiet = TRUE)) %>%
  filter(!is.na(DV_SPEED_FPM), !is.na(DV_STATUS_DATE), !is.na(Borough)) %>%
  select(-`Device Status`, -`...27`) %>%
  rename_all(str_remove, "DV_") %>%
  rename_all(tolower) %>%
  rename(device_type = `device type`) %>%
  filter(device_status_description == "ACTIVE") %>%
  select(-device_status_description, -lastper_insp_disp) %>%
  mutate(zip_code = str_sub(zip_code, 1, 5)) %>%
  mutate(zip_code = if_else(zip_code %in% c("0", "99999"), NA_character_, zip_code)) %>%
  mutate(device_type = str_remove(device_type, " +\\(.*")) %>%
  mutate(borough = factor(borough)) %>%
  mutate(manufacturer = case_when(
    str_detect(manufacturer, "^OTIS") ~ "Otis",
    str_detect(manufacturer, "^OTES") ~ "Otis",
    str_detect(manufacturer, "^OITS") ~ "Otis",
    str_detect(manufacturer, "^ORIS") ~ "Otis",
    str_detect(manufacturer, "^OSIT") ~ "Otis",
    str_detect(manufacturer, "^OTI") ~ "Otis",
    str_detect(manufacturer, "^OTIUS") ~ "Otis",
    str_detect(manufacturer, "^A B C") ~ "MISSING",
    str_detect(manufacturer, "^A( |\\.|\\/|\\-)? ?B") ~ "A. B. See",
    str_detect(manufacturer, "^ADVAN") ~ "Advance",
    str_detect(manufacturer, "^ALLSTATE") ~ "Allstate",
    str_detect(manufacturer, "^A(RM|MR)O{1,2}U?A?R") ~ "Armor",
    str_detect(manufacturer, "^BR?(A|U)R?LINGTON") ~ "Burlington",
    str_detect(manufacturer, "^BERGE?N") ~ "BP Elevator",
    str_detect(manufacturer, "^C(UR|RU)TIS") ~ "Curtis",
    str_detect(manufacturer, "^DOVER") ~ "Dover",
    str_detect(manufacturer, "^DONER") ~ "Doner",
    str_detect(manufacturer, "^ELT") ~ "Eltech",
    str_detect(manufacturer, "^EMB") ~ "Embassy",
    str_detect(manufacturer, "^EC") ~ "Economy",
    str_detect(manufacturer, "^EMP") ~ "Empire",
    str_detect(manufacturer, "^FLY") ~ "Flynn-Hill",
    str_detect(manufacturer, "^GUR") ~ "Gurney",
    str_detect(manufacturer, "^HEI") ~ "Heights",
    str_detect(manufacturer, "^HAR?N?DWIC") ~ "Hardwick",
    str_detect(manufacturer, "^K(IE|EI)") ~ "Kiesling",
    str_detect(manufacturer, "^KOPP") ~ "Koppel",
    str_detect(manufacturer, "^MILLA") ~ "Millar",
    str_detect(manufacturer, "^A\\.J") ~ "A. J.",
    str_detect(manufacturer, "^AMERICAN") ~ "American",
    str_detect(manufacturer, "^NEW YORK") ~ "New York",
    str_detect(manufacturer, "^NY") ~ "New York",
    str_detect(manufacturer, "^WATSON") ~ "Watson",
    str_detect(manufacturer, "^WEST") ~ "Westinghouse Electric Company",
    str_detect(manufacturer, "^STALL?E?Y") ~ "Staley Electric",
    str_detect(manufacturer, "^SEAB(E|U)RG") ~ "Seaberg Inc.",
    str_detect(manufacturer, "^SCHINDLER") ~ "Schindler",
    str_detect(manufacturer, "^SCHINNDLER") ~ "Schindler",
    str_detect(manufacturer, "^SCHNDLER") ~ "Schindler",
    str_detect(manufacturer, "^SCINDLER") ~ "Schindler",
    str_detect(manufacturer, "^SERGE") ~ "Serge",
    str_detect(manufacturer, "^REEDY") ~ "Reedy",
    str_detect(manufacturer, "^ROM") ~ "Roma",
    str_detect(manufacturer, "^REP") ~ "Republic",
    str_detect(manufacturer, "^LU") ~ "LU/LA Elevators",
    str_detect(manufacturer, "^TURNBULL") ~ "Turnbull",
    str_detect(manufacturer, "^WARNER") ~ "Warner",
    str_detect(manufacturer, "^VENUS") ~ "Venus",
    str_detect(manufacturer, "^MRL") ~ "MRL",
    str_detect(manufacturer, "^(TO )?REPLACE") ~ "MISSING",
    str_detect(manufacturer, "^EBN") ~ "MISSING",
    str_detect(manufacturer, "^EA") ~ "MISSING",
    TRUE ~ NA_character_
  )) %>%
  mutate(car_buffer_type = case_when(
    car_buffer_type == "O" ~ "Oil",
    car_buffer_type == "S" ~ "Spring",
    TRUE ~ NA_character_
  )) %>%
  select(-status_date)

usethis::use_data(elevators, overwrite = TRUE)
