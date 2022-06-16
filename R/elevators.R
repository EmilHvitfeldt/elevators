#' Elevators in NYC
#'
#' A data set containing information of a subset of the elevators in NYC. The
#' data set has been filtered to contain active elevators with non-missing
#' speed.
#'
#'
#' @format A data frame with `r nrow(elevators)` rows and `r ncol(elevators)`
#' variables:
#'
#' \describe{
#'   \item{device_number}{Unique identify number for the elevator}
#'   \item{bin}{Building Identification Number}
#'   \item{borough}{Regional subdivisions of NYC. One of "Manhattan", "Bronx",
#'   "Brooklyn", "Queens", or "Staten Island"}
#'   \item{tax_block}{Id for tax block. Smaller than borough}
#'   \item{tax_lot}{Id for tax block. Smaller than tax_block}
#'   \item{house_number}{House number, very poorly parsed. Use with caution}
#'   \item{street_name}{Street name, very poorly parsed. Use with caution}
#'   \item{zip_code}{Zip code, formatted to 5 digits. 0 and 99999 are marked as
#'   NA}
#'   \item{device_type}{Type of device. Most common type is "Passenger Elevator"}
#'   \item{lastper_insp_date}{Date, refers to the last periodic inspection by
#'   the Department of Buildings. These dates will no longer be accurate, as
#'   they were collected by November 2015}
#'   \item{approval_date}{Date of approval for elevator}
#'   \item{manufacturer}{Name of manufacturer, poorly cleaned. Most assigned NA}
#'   \item{travel_distance}{Distance travelled, not cleaned. Mixed formats}
#'   \item{speed_fpm}{Speed in feet/minute}
#'   \item{capacity_lbs}{Capacity in lbs}
#'   \item{car_buffer_type}{Buffer type. A buffer is a device designed to stop
#'   a descending car or counterweight beyond its normal limit and to soften
#'   the force with which the elevator runs into the pit during an emergency.
#'   Takes values "Oil", "Spring", and NA}
#'   \item{governor_type}{Governor type, An overspeed governor is an elevator
#'   device which acts as a stopping mechanism in case the elevator runs beyond
#'   its rated speed}
#'   \item{machine_type}{Machine type, labels unknown.}
#'   \item{safety_type}{Safety type, labels unknown.}
#'   \item{mode_operation}{Operation mode, labels unknown.}
#'   \item{floor_from}{Lowest floor, not cleaned. Mixed formats}
#'   \item{floor_to}{Highest floor, not cleaned. Mixed formats}
#'   \item{latitude}{Latitude of elevator}
#'   \item{longitude}{Longitude of elevator}
#'   ...
#' }
#'
#' @source \url{https://github.com/datanews/elevators}
"elevators"

#' Elevators in NYC
#'
#' A raw data set containing information of the elevators in NYC.
#'
#'
#' @format A data frame with `r nrow(elevators_raw)` rows and
#' `r ncol(elevators_raw)` variables:
#'
#' @source \url{https://github.com/datanews/elevators}
"elevators_raw"
