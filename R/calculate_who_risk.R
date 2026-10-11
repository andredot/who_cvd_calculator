#' @title WHO CVD Risk Calculator
#' @description
#' Calculate 10-year cardiovascular disease (CVD) risk using the 2019 WHO
#' risk prediction models. This package implements both laboratory-based and
#' non-laboratory-based models, recalibrated for 21 global regions.
#'
#' @references
#' Kaptoge S, Pennells L, De Bacquer D, et al. World Health Organization
#' cardiovascular disease risk charts: revised models to estimate risk in 21

#' global regions. Lancet Glob Health. 2019;7(10):e1332-e1345.
#' doi:10.1016/S2214-109X(19)30318-3
#'
#' @keywords internal
"_PACKAGE"

#' Calculate WHO 10-Year CVD Risk (Laboratory-Based Model)
#'
#' @description
#' Calculates the 10-year risk of cardiovascular disease (fatal and non-fatal
#' myocardial infarction and stroke) using the WHO laboratory-based model.
#' This model requires total cholesterol measurement.
#'
#' @param age Numeric vector. Age in years (valid range: 40-80).
#' @param sex Character vector. Sex: "male" or "female".
#' @param sbp Numeric vector. Systolic blood pressure in mmHg.
#' @param cholesterol Numeric vector. Total cholesterol in mmol/L.
#'   To convert from mg/dL to mmol/L, divide by 38.67.
#' @param smoking Logical vector. Current smoking status (TRUE = current smoker).
#' @param diabetes Logical vector. History of diabetes (TRUE = diabetic).
#' @param region Character vector. WHO/GBD region name. One of the 21 global
#'   regions (see \code{\link{get_regions}} for valid values). If NULL and
#'   \code{country} is provided, region will be determined automatically.
#' @param country Character vector. ISO 3166-1 alpha-3 country code (e.g., "USA",
#'   "GBR", "IND"). Used to determine region if \code{region} is NULL.
#'   See \code{\link{get_country_codes}} for valid values.
#' @param recalibration Character. Level of recalibration: \code{"region"}
#'   (default) uses the 21 GBD region parameters behind the published WHO risk
#'   charts; \code{"country"} uses country-specific parameters and requires
#'   \code{country}. Countries without country-specific estimates fall back to
#'   their region with a warning.
#' @param year Integer vector. Calendar year of the recalibration target
#'   population (1990-2017, default 2017). Years up to 2015 use the 5-year
#'   period they fall in (1990, 1995, ..., 2015).
#'
#' @return Numeric vector of 10-year CVD risk as a proportion (0-1).
#'   Multiply by 100 to get percentage.
#'
#' @details
#' The model uses Cox proportional hazards regression with the following
#' predictors:
#' \itemize{
#'   \item Age (with interactions for all other predictors)
#'   \item Total cholesterol
#'   \item Systolic blood pressure
#'   \item Diabetes status
#'   \item Current smoking status
#' }
#'
#' Risk is calculated separately for myocardial infarction/CHD death and stroke,
#' then combined assuming independence of the two outcomes:
#' \deqn{P_{CVD} = 1 - (1 - P_{MI}) \times (1 - P_{stroke})}
#'
#' Each endpoint risk is first computed from the derivation model,
#' \eqn{P = 1 - S_0^{\exp(LP)}}, using the baseline survival \eqn{S_0} of the
#' derivation cohort, and then recalibrated on the complementary log-log scale:
#' \deqn{P_{cal} = 1 - \exp(-\exp(c + s \log(-\log(1 - P))))}
#' where the intercept \eqn{c} and slope \eqn{s} are specific to region (or
#' country), sex, endpoint and year. These parameters were fitted by the
#' authors to GBD 2017 incidence rates and NCD-RisC risk factor levels and are
#' taken from their Stata implementation (\code{whocvdrisk}).
#'
#' @section Centering Values:
#' Variables are centered at:
#' \itemize{
#'   \item Age: 60 years
#'   \item Systolic blood pressure: 120 mmHg
#'   \item Total cholesterol: 6 mmol/L
#' }
#'
#' @examples
#' # Single calculation
#' calculate_who_risk(
#'   age = 55,
#'   sex = "male",
#'   sbp = 140,
#'   cholesterol = 5.5,
#'   smoking = TRUE,
#'   diabetes = FALSE,
#'   region = "western_europe"
#' )
#'
#' # Using country code instead of region
#' calculate_who_risk(
#'   age = 60,
#'   sex = "female",
#'   sbp = 130,
#'   cholesterol = 6.0,
#'   smoking = FALSE,
#'   diabetes = TRUE,
#'   country = "ITA"
#' )
#'
#' # Country-specific instead of region-level recalibration
#' calculate_who_risk(
#'   age = 45,
#'   sex = "male",
#'   sbp = 140,
#'   cholesterol = 5.5,
#'   smoking = TRUE,
#'   diabetes = FALSE,
#'   country = "GBR",
#'   recalibration = "country"
#' )
#'
#' # Vectorized calculation
#' calculate_who_risk(
#'   age = c(45, 55, 65),
#'   sex = c("male", "female", "male"),
#'   sbp = c(120, 140, 160),
#'   cholesterol = c(5.0, 6.0, 7.0),
#'   smoking = c(FALSE, TRUE, FALSE),
#'   diabetes = c(FALSE, FALSE, TRUE),
#'   country = c("USA", "GBR", "IND")
#' )
#'
#' @seealso
#' \code{\link{calculate_who_risk_nonlab}} for the non-laboratory-based model,
#' \code{\link{get_regions}} for available regions,
#' \code{\link{get_country_codes}} for country code lookup.
#'
#' @export
calculate_who_risk <- function(age, sex, sbp, cholesterol, smoking, diabetes,
                               region = NULL, country = NULL,
                               recalibration = c("region", "country"),
                               year = 2017) {
  recalibration <- match.arg(recalibration)

  # Input validation and recycling
  n <- max(length(age), length(sex), length(sbp), length(cholesterol),
           length(smoking), length(diabetes), length(year),
           if (!is.null(region)) length(region) else 0,
           if (!is.null(country)) length(country) else 0)

  age <- rep_len(age, n)
  sex <- rep_len(tolower(sex), n)
  sbp <- rep_len(sbp, n)
  cholesterol <- rep_len(cholesterol, n)
  smoking <- rep_len(as.logical(smoking), n)
  diabetes <- rep_len(as.logical(diabetes), n)
  year <- rep_len(year, n)

  region_country <- .resolve_region_country(region, country, n, recalibration)
  region <- region_country$region
  country <- region_country$country

  # Validate inputs
  .validate_inputs(age, sex, sbp, cholesterol, smoking, diabetes, region)

  # Center variables
  age_c <- age - 60
  sbp_c <- sbp - 120
  chol_c <- cholesterol - 6

  # Uncalibrated risks from the derivation model
  p_chd <- .uncalibrated_risk(.get_lab_coef, "mi_chd", sex, age_c, sbp_c,
                              chol_c, "chol", smoking, diabetes)
  p_stroke <- .uncalibrated_risk(.get_lab_coef, "stroke", sex, age_c, sbp_c,
                                 chol_c, "chol", smoking, diabetes)

  risk <- .calibrated_cvd_risk(p_chd, p_stroke, "lab", sex, region, country,
                               recalibration, year)

  return(risk)
}


#' Calculate WHO 10-Year CVD Risk (Non-Laboratory-Based Model)
#'
#' @description
#' Calculates the 10-year risk of cardiovascular disease using the WHO
#' non-laboratory-based model. This model uses BMI instead of cholesterol
#' and does not require diabetes status, making it suitable for resource-limited
#' settings where laboratory testing may not be available.
#'
#' @param age Numeric vector. Age in years (valid range: 40-80).
#' @param sex Character vector. Sex: "male" or "female".
#' @param sbp Numeric vector. Systolic blood pressure in mmHg.
#' @param bmi Numeric vector. Body mass index in kg/m².
#' @param smoking Logical vector. Current smoking status (TRUE = current smoker).
#' @param region Character vector. WHO/GBD region name. One of the 21 global
#'   regions (see \code{\link{get_regions}} for valid values). If NULL and
#'   \code{country} is provided, region will be determined automatically.
#' @param country Character vector. ISO 3166-1 alpha-3 country code.
#' @param recalibration Character. Level of recalibration: \code{"region"}
#'   (default) uses the 21 GBD region parameters behind the published WHO risk
#'   charts; \code{"country"} uses country-specific parameters and requires
#'   \code{country}. Countries without country-specific estimates fall back to
#'   their region with a warning.
#' @param year Integer vector. Calendar year of the recalibration target
#'   population (1990-2017, default 2017). Years up to 2015 use the 5-year
#'   period they fall in (1990, 1995, ..., 2015).
#'
#' @return Numeric vector of 10-year CVD risk as a proportion (0-1).
#'
#' @details
#' This model is designed for use in resource-limited settings where laboratory
#' measurements (cholesterol, glucose) may not be readily available. It uses
#' BMI as a proxy for metabolic risk.
#'
#' \strong{Important limitations:}
#' \itemize{
#'   \item The non-laboratory model tends to underestimate risk in people with
#'         diabetes because diabetes is a strong predictor not included in this model.
#'   \item For individuals identified as high risk (>10%) by this model, laboratory-based
#'         assessment is recommended.
#' }
#'
#' @section Centering Values:
#' Variables are centered at:
#' \itemize{
#'   \item Age: 60 years
#'   \item Systolic blood pressure: 120 mmHg
#'   \item BMI: 25 kg/m²
#' }
#'
#' @examples
#' # Single calculation
#' calculate_who_risk_nonlab(
#'   age = 55,
#'   sex = "male",
#'   sbp = 140,
#'   bmi = 28,
#'   smoking = TRUE,
#'   region = "south_asia"
#' )
#'
#' # Using country code
#' calculate_who_risk_nonlab(
#'   age = 60,
#'   sex = "female",
#'   sbp = 135,
#'   bmi = 26,
#'   smoking = FALSE,
#'   country = "KEN"
#' )
#'
#' @seealso
#' \code{\link{calculate_who_risk}} for the laboratory-based model.
#'
#' @export
calculate_who_risk_nonlab <- function(age, sex, sbp, bmi, smoking,
                                      region = NULL, country = NULL,
                                      recalibration = c("region", "country"),
                                      year = 2017) {
  recalibration <- match.arg(recalibration)

  # Input validation and recycling
  n <- max(length(age), length(sex), length(sbp), length(bmi), length(smoking),
           length(year),
           if (!is.null(region)) length(region) else 0,
           if (!is.null(country)) length(country) else 0)

  age <- rep_len(age, n)
  sex <- rep_len(tolower(sex), n)
  sbp <- rep_len(sbp, n)
  bmi <- rep_len(bmi, n)
  smoking <- rep_len(as.logical(smoking), n)
  year <- rep_len(year, n)

  region_country <- .resolve_region_country(region, country, n, recalibration)
  region <- region_country$region
  country <- region_country$country

  # Validate inputs
  .validate_inputs_nonlab(age, sex, sbp, bmi, smoking, region)

  # Center variables
  age_c <- age - 60
  sbp_c <- sbp - 120
  bmi_c <- bmi - 25

  # Uncalibrated risks from the derivation model
  p_chd <- .uncalibrated_risk(.get_nonlab_coef, "mi_chd", sex, age_c, sbp_c,
                              bmi_c, "bmi", smoking)
  p_stroke <- .uncalibrated_risk(.get_nonlab_coef, "stroke", sex, age_c, sbp_c,
                                 bmi_c, "bmi", smoking)

  risk <- .calibrated_cvd_risk(p_chd, p_stroke, "nonlab", sex, region, country,
                               recalibration, year)

  return(risk)
}


#' Get Available Region Names
#'
#' @description
#' Returns a character vector of valid WHO/GBD region names that can be used
#' with the risk calculation functions.
#'
#' @return Character vector of 21 GBD region names.
#'
#' @examples
#' get_regions()
#'
#' @export
get_regions <- function() {
  c(
    "north_africa_middle_east",
    "central_subsaharan_africa",
    "eastern_subsaharan_africa",
    "southern_subsaharan_africa",
    "western_subsaharan_africa",
    "southern_latin_america",
    "high_income_north_america",
    "caribbean",
    "andean_latin_america",
    "central_latin_america",
    "tropical_latin_america",
    "east_asia",
    "south_asia",
    "southeast_asia",
    "central_asia",
    "high_income_asia_pacific",
    "western_europe",
    "central_europe",
    "eastern_europe",
    "oceania",
    "australasia"
  )
}


#' Get Country Code to Region Mapping
#'
#' @description
#' Returns a named vector mapping ISO 3166-1 alpha-3 country codes to their
#' corresponding WHO/GBD regions.
#'
#' @param country Optional character vector of country codes to look up.
#'   If NULL (default), returns the complete mapping.
#'
#' @return If \code{country} is NULL, returns a named character vector where
#'   names are country codes and values are region names. If \code{country}
#'   is provided, returns the corresponding region(s).
#'
#' @examples
#' # Get all mappings
#' head(get_country_codes())
#'
#' # Look up specific countries
#' get_country_codes(c("USA", "GBR", "IND"))
#'
#' @export
get_country_codes <- function(country = NULL) {
  mapping <- .get_country_mapping()

  if (is.null(country)) {
    return(mapping)
  }

  country <- toupper(country)
  result <- mapping[country]
  names(result) <- country
  return(result)
}


#' Map Country Code to Region
#'
#' @description
#' Utility function to map ISO 3166-1 alpha-3 country codes to WHO/GBD regions.
#'
#' @param country Character vector of ISO 3166-1 alpha-3 country codes.
#'
#' @return Character vector of region names.
#'
#' @examples
#' country_to_region(c("USA", "DEU", "JPN"))
#'
#' @export
country_to_region <- function(country) {
  .map_country_to_region(toupper(country))
}
