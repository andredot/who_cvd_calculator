# Reference values come from an independent re-implementation of the authors'
# Stata program `whocvdrisk` (see data-raw/stata_reference_cases.py).

test_that("lab model matches the authors' Stata implementation", {
  ref <- read.csv(test_path("fixtures", "stata_reference.csv"),
                  stringsAsFactors = FALSE)
  for (level in c("region", "country")) {
    r <- ref[ref$recalibration == level, ]
    risk <- calculate_who_risk(
      age = r$age, sex = r$sex, sbp = r$sbp, cholesterol = r$cholesterol,
      smoking = r$smoking == 1, diabetes = r$diabetes == 1,
      country = r$country, recalibration = level, year = r$year
    )
    expect_equal(risk, r$ref_lab, tolerance = 1e-9)
  }
})

test_that("non-lab model matches the authors' Stata implementation", {
  ref <- read.csv(test_path("fixtures", "stata_reference.csv"),
                  stringsAsFactors = FALSE)
  for (level in c("region", "country")) {
    r <- ref[ref$recalibration == level, ]
    risk <- calculate_who_risk_nonlab(
      age = r$age, sex = r$sex, sbp = r$sbp, bmi = r$bmi,
      smoking = r$smoking == 1, country = r$country,
      recalibration = level, year = r$year
    )
    expect_equal(risk, r$ref_nonlab, tolerance = 1e-9)
  }
})

test_that("UK male smoker example gives expected risks", {
  age <- c(45, 75)
  region_risk <- calculate_who_risk(age, "male", 140, 5.5, TRUE, FALSE,
                                    country = "GBR")
  country_risk <- calculate_who_risk(age, "male", 140, 5.5, TRUE, FALSE,
                                     country = "GBR", recalibration = "country")
  expect_equal(region_risk, c(0.0704820390, 0.2891418160), tolerance = 1e-8)
  expect_equal(country_risk, c(0.0938483894, 0.3934534526), tolerance = 1e-8)
})

test_that("region and country arguments give the same region-level risk", {
  expect_identical(
    calculate_who_risk(55, "female", 130, 6, FALSE, TRUE, country = "ITA"),
    calculate_who_risk(55, "female", 130, 6, FALSE, TRUE,
                       region = "western_europe")
  )
})

test_that("years map to recalibration periods", {
  r <- function(year) {
    calculate_who_risk(60, "male", 140, 6, TRUE, FALSE,
                       region = "south_asia", year = year)
  }
  expect_identical(r(2003), r(2000))
  expect_identical(r(2014), r(2010))
  expect_false(identical(r(2016), r(2017)))
  expect_error(r(1989), "between 1990 and 2017")
  expect_error(r(2018), "between 1990 and 2017")
})

test_that("country recalibration falls back to region when unavailable", {
  expect_warning(
    risk <- calculate_who_risk_nonlab(60, "male", 140, 27, TRUE,
                                      country = "SSD",
                                      recalibration = "country"),
    "SSD"
  )
  expect_identical(
    risk,
    calculate_who_risk_nonlab(60, "male", 140, 27, TRUE,
                              region = "eastern_subsaharan_africa")
  )
})

test_that("country recalibration requires a country", {
  expect_error(
    calculate_who_risk(60, "male", 140, 6, TRUE, FALSE,
                       region = "western_europe", recalibration = "country"),
    "'country' must be provided"
  )
})

test_that("vectorized results match element-wise results", {
  args <- list(age = c(45, 55, 65), sex = c("male", "female", "male"),
               sbp = c(120, 140, 160), cholesterol = c(5, 6, 7),
               smoking = c(FALSE, TRUE, FALSE),
               diabetes = c(FALSE, FALSE, TRUE),
               country = c("USA", "GBR", "IND"))
  vec <- do.call(calculate_who_risk, args)
  single <- vapply(seq_along(vec), function(i) {
    do.call(calculate_who_risk, lapply(args, `[`, i))
  }, numeric(1))
  expect_identical(vec, single)
})

test_that("country mapping matches the authors' GBD regions", {
  expect_identical(country_to_region(c("SSD", "GUM", "MNP")),
                   c("eastern_subsaharan_africa", "oceania", "oceania"))
})
