
<!-- README.md is generated from README.Rmd. Please edit that file -->

# elevators <img src="man/figures/logo.png" align="right" height="280" />

<!-- badges: start -->
<!-- badges: end -->

This data package contains a data set of the registered elevator devices
in New York City provided by the Department of Buildings in response to
a September 2015 FOIL request.

## Installation

You can install the development version of elevators like so:

``` r
remotes::install_github("emilhvitfeldt/elevators")
```

## Examples

One of the fundamental characteristics about elevators is how fast they
can go, and how much they can carry

``` r
library(elevators)
library(ggplot2)

elevators |>
  ggplot(aes(speed_fpm, capacity_lbs)) +
  geom_point(alpha = 0.1)
```

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />

In addition to `borough`, there are a number of geographical variables
can would be useful to explore

``` r
elevators |>
  ggplot(aes(longitude, latitude, color = borough)) +
  coord_map() +
  geom_point(alpha = 0.1) +
  theme_minimal()
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" />

We can also see where the different tall buildings are in Manhattan

``` r
library(tidyverse)

elevators |>
  filter(borough == "Manhattan") |>
  mutate(floors = str_extract(floor_to, "\\d+"),
         floors = as.numeric(floors)) |>
  filter(!is.na(floors), floors < 100, floors > 0) |>
  ggplot(aes(longitude, latitude, color = floors)) +
  geom_point(alpha = 0.05) +
  scale_color_viridis_c() +
  theme_minimal() +
  facet_wrap(~ cut_width(floors, width = 10, boundary = 0))
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" />
