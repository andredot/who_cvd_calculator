# =============================================================================
# Internal Helper Functions for WHO CVD Risk Calculator
# =============================================================================

#' Get Country to Region Mapping
#' @noRd
.get_country_mapping <- function() {
  c(
    # North Africa and Middle East
    "DZA" = "north_africa_middle_east", "EGY" = "north_africa_middle_east",
    "LBY" = "north_africa_middle_east", "MAR" = "north_africa_middle_east",
    "SDN" = "north_africa_middle_east",
    "TUN" = "north_africa_middle_east", "AFG" = "north_africa_middle_east",
    "ARE" = "north_africa_middle_east", "BHR" = "north_africa_middle_east",
    "IRN" = "north_africa_middle_east", "IRQ" = "north_africa_middle_east",
    "JOR" = "north_africa_middle_east", "KWT" = "north_africa_middle_east",
    "LBN" = "north_africa_middle_east", "OMN" = "north_africa_middle_east",
    "PSE" = "north_africa_middle_east", "QAT" = "north_africa_middle_east",
    "SAU" = "north_africa_middle_east", "SYR" = "north_africa_middle_east",
    "TUR" = "north_africa_middle_east", "YEM" = "north_africa_middle_east",
    
    # Central Sub-Saharan Africa
    "AGO" = "central_subsaharan_africa", "CAF" = "central_subsaharan_africa",
    "COD" = "central_subsaharan_africa", "COG" = "central_subsaharan_africa",
    "GAB" = "central_subsaharan_africa", "GNQ" = "central_subsaharan_africa",
    
    # Eastern Sub-Saharan Africa
    "BDI" = "eastern_subsaharan_africa", "COM" = "eastern_subsaharan_africa",
    "DJI" = "eastern_subsaharan_africa", "ERI" = "eastern_subsaharan_africa",
    "ETH" = "eastern_subsaharan_africa", "KEN" = "eastern_subsaharan_africa",
    "MDG" = "eastern_subsaharan_africa", "MOZ" = "eastern_subsaharan_africa",
    "MWI" = "eastern_subsaharan_africa", "RWA" = "eastern_subsaharan_africa",
    "SOM" = "eastern_subsaharan_africa", "SSD" = "eastern_subsaharan_africa",
    "TZA" = "eastern_subsaharan_africa",
    "UGA" = "eastern_subsaharan_africa", "ZMB" = "eastern_subsaharan_africa",
    
    # Southern Sub-Saharan Africa
    "BWA" = "southern_subsaharan_africa", "LSO" = "southern_subsaharan_africa",
    "NAM" = "southern_subsaharan_africa", "SWZ" = "southern_subsaharan_africa",
    "ZAF" = "southern_subsaharan_africa", "ZWE" = "southern_subsaharan_africa",
    
    # Western Sub-Saharan Africa
    "BEN" = "western_subsaharan_africa", "BFA" = "western_subsaharan_africa",
    "CIV" = "western_subsaharan_africa", "CMR" = "western_subsaharan_africa",
    "CPV" = "western_subsaharan_africa", "GHA" = "western_subsaharan_africa",
    "GIN" = "western_subsaharan_africa", "GMB" = "western_subsaharan_africa",
    "GNB" = "western_subsaharan_africa", "LBR" = "western_subsaharan_africa",
    "MLI" = "western_subsaharan_africa", "MRT" = "western_subsaharan_africa",
    "NER" = "western_subsaharan_africa", "NGA" = "western_subsaharan_africa",
    "SEN" = "western_subsaharan_africa", "SLE" = "western_subsaharan_africa",
    "STP" = "western_subsaharan_africa", "TCD" = "western_subsaharan_africa",
    "TGO" = "western_subsaharan_africa",
    
    # Southern Latin America
    "ARG" = "southern_latin_america", "CHL" = "southern_latin_america",
    "URY" = "southern_latin_america",
    
    # High-income North America
    "CAN" = "high_income_north_america", "GRL" = "high_income_north_america",
    "USA" = "high_income_north_america",
    
    # Caribbean
    "ATG" = "caribbean", "BHS" = "caribbean", "BLZ" = "caribbean",
    "BMU" = "caribbean", "BRB" = "caribbean", "CUB" = "caribbean",
    "DMA" = "caribbean", "DOM" = "caribbean", "GRD" = "caribbean",
    "GUY" = "caribbean", "HTI" = "caribbean", "JAM" = "caribbean",
    "LCA" = "caribbean", "PRI" = "caribbean", "SUR" = "caribbean",
    "TTO" = "caribbean", "VCT" = "caribbean", "VIR" = "caribbean",
    
    # Andean Latin America
    "BOL" = "andean_latin_america", "ECU" = "andean_latin_america",
    "PER" = "andean_latin_america",
    
    # Central Latin America
    "COL" = "central_latin_america", "CRI" = "central_latin_america",
    "GTM" = "central_latin_america", "HND" = "central_latin_america",
    "MEX" = "central_latin_america", "NIC" = "central_latin_america",
    "PAN" = "central_latin_america", "SLV" = "central_latin_america",
    "VEN" = "central_latin_america",
    
    # Tropical Latin America
    "BRA" = "tropical_latin_america", "PRY" = "tropical_latin_america",
    
    # East Asia
    "CHN" = "east_asia", "PRK" = "east_asia", "TWN" = "east_asia",
    
    # South Asia
    "BGD" = "south_asia", "BTN" = "south_asia", "IND" = "south_asia",
    "NPL" = "south_asia", "PAK" = "south_asia",
    
    # Southeast Asia
    "IDN" = "southeast_asia", "KHM" = "southeast_asia", "LAO" = "southeast_asia",
    "LKA" = "southeast_asia", "MDV" = "southeast_asia", "MMR" = "southeast_asia",
    "MYS" = "southeast_asia", "PHL" = "southeast_asia", "THA" = "southeast_asia",
    "TLS" = "southeast_asia", "VNM" = "southeast_asia", "MUS" = "southeast_asia",
    "SYC" = "southeast_asia",
    
    # Central Asia
    "ARM" = "central_asia", "AZE" = "central_asia", "GEO" = "central_asia",
    "KAZ" = "central_asia", "KGZ" = "central_asia", "MNG" = "central_asia",
    "TJK" = "central_asia", "TKM" = "central_asia", "UZB" = "central_asia",
    
    # High-income Asia Pacific
    "BRN" = "high_income_asia_pacific", "JPN" = "high_income_asia_pacific",
    "KOR" = "high_income_asia_pacific", "SGP" = "high_income_asia_pacific",
    
    # Western Europe
    "AND" = "western_europe", "AUT" = "western_europe", "BEL" = "western_europe",
    "CHE" = "western_europe", "CYP" = "western_europe", "DEU" = "western_europe",
    "DNK" = "western_europe", "ESP" = "western_europe", "FIN" = "western_europe",
    "FRA" = "western_europe", "GBR" = "western_europe", "GRC" = "western_europe",
    "IRL" = "western_europe", "ISL" = "western_europe", "ISR" = "western_europe",
    "ITA" = "western_europe", "LUX" = "western_europe", "MLT" = "western_europe",
    "NLD" = "western_europe", "NOR" = "western_europe", "PRT" = "western_europe",
    "SWE" = "western_europe",
    
    # Central Europe
    "ALB" = "central_europe", "BGR" = "central_europe", "BIH" = "central_europe",
    "CZE" = "central_europe", "HRV" = "central_europe", "HUN" = "central_europe",
    "MKD" = "central_europe", "MNE" = "central_europe", "POL" = "central_europe",
    "ROU" = "central_europe", "SRB" = "central_europe", "SVK" = "central_europe",
    "SVN" = "central_europe",
    
    # Eastern Europe
    "BLR" = "eastern_europe", "EST" = "eastern_europe", "LTU" = "eastern_europe",
    "LVA" = "eastern_europe", "MDA" = "eastern_europe", "RUS" = "eastern_europe",
    "UKR" = "eastern_europe",
    
    # Oceania
    "FJI" = "oceania", "FSM" = "oceania", "KIR" = "oceania", "MHL" = "oceania",
    "PNG" = "oceania", "SLB" = "oceania", "TON" = "oceania", "VUT" = "oceania",
    "WSM" = "oceania", "ASM" = "oceania", "GUM" = "oceania", "MNP" = "oceania",
    
    # Australasia
    "AUS" = "australasia", "NZL" = "australasia"
  )
}


#' Map Country Codes to Regions
#' @noRd
.map_country_to_region <- function(country) {
  mapping <- .get_country_mapping()
  regions <- mapping[country]
  
  if (any(is.na(regions))) {
    unknown <- country[is.na(regions)]
    stop("Unknown country code(s): ", paste(unique(unknown), collapse = ", "),
         "\nUse get_country_codes() to see valid codes.")
  }
  
  return(unname(regions))
}


#' Resolve Region and Country Arguments
#' @noRd
.resolve_region_country <- function(region, country, n, recalibration) {
  if (is.null(region) && is.null(country)) {
    stop("Either 'region' or 'country' must be provided.")
  }
  if (recalibration == "country" && is.null(country)) {
    stop("'country' must be provided when recalibration = \"country\".")
  }

  if (!is.null(country)) {
    country <- rep_len(toupper(country), n)
    if (is.null(region)) {
      region <- .map_country_to_region(country)
    }
  } else {
    country <- rep_len(NA_character_, n)
  }

  list(region = rep_len(region, n), country = country)
}


#' Validate Inputs for Laboratory-Based Model
#' @noRd
.validate_inputs <- function(age, sex, sbp, cholesterol, smoking, diabetes, region) {
  # Age validation
 if (any(age < 40 | age > 80, na.rm = TRUE)) {
    warning("Age values outside valid range (40-80). Results may be unreliable.")
  }
  if (any(is.na(age))) {
    stop("Missing values in 'age' are not allowed.")
  }
  
  # Sex validation
  valid_sex <- c("male", "female")
  if (!all(sex %in% valid_sex)) {
    stop("Invalid 'sex' values. Must be 'male' or 'female'.")
  }
  
  # SBP validation
  if (any(sbp < 70 | sbp > 250, na.rm = TRUE)) {
    warning("SBP values outside typical range (70-250 mmHg). Check input data.")
  }
  if (any(is.na(sbp))) {
    stop("Missing values in 'sbp' are not allowed.")
  }
  
  # Cholesterol validation
  if (any(cholesterol < 2 | cholesterol > 12, na.rm = TRUE)) {
    warning("Cholesterol values outside typical range (2-12 mmol/L). Check input data.")
  }
  if (any(is.na(cholesterol))) {
    stop("Missing values in 'cholesterol' are not allowed.")
  }
  
  # Boolean validations
  if (any(is.na(smoking))) {
    stop("Missing values in 'smoking' are not allowed.")
  }
  if (any(is.na(diabetes))) {
    stop("Missing values in 'diabetes' are not allowed.")
  }
  
  # Region validation
  valid_regions <- get_regions()
  if (!all(region %in% valid_regions)) {
    invalid <- unique(region[!region %in% valid_regions])
    stop("Invalid region(s): ", paste(invalid, collapse = ", "),
         "\nUse get_regions() to see valid region names.")
  }
  
  invisible(TRUE)
}


#' Validate Inputs for Non-Laboratory-Based Model
#' @noRd
.validate_inputs_nonlab <- function(age, sex, sbp, bmi, smoking, region) {
  # Age validation
  if (any(age < 40 | age > 80, na.rm = TRUE)) {
    warning("Age values outside valid range (40-80). Results may be unreliable.")
  }
  if (any(is.na(age))) {
    stop("Missing values in 'age' are not allowed.")
  }
  
  # Sex validation
  valid_sex <- c("male", "female")
  if (!all(sex %in% valid_sex)) {
    stop("Invalid 'sex' values. Must be 'male' or 'female'.")
  }
  
  # SBP validation
  if (any(sbp < 70 | sbp > 250, na.rm = TRUE)) {
    warning("SBP values outside typical range (70-250 mmHg). Check input data.")
  }
  if (any(is.na(sbp))) {
    stop("Missing values in 'sbp' are not allowed.")
  }
  
  # BMI validation
  if (any(bmi < 12 | bmi > 60, na.rm = TRUE)) {
    warning("BMI values outside typical range (12-60 kg/m2). Check input data.")
  }
  if (any(is.na(bmi))) {
    stop("Missing values in 'bmi' are not allowed.")
  }
  
  # Smoking validation
  if (any(is.na(smoking))) {
    stop("Missing values in 'smoking' are not allowed.")
  }
  
  # Region validation
  valid_regions <- get_regions()
  if (!all(region %in% valid_regions)) {
    invalid <- unique(region[!region %in% valid_regions])
    stop("Invalid region(s): ", paste(invalid, collapse = ", "),
         "\nUse get_regions() to see valid region names.")
  }
  
  invisible(TRUE)
}


#' Get Model Coefficients for Laboratory-Based Model
#' @noRd
.get_lab_coef <- function(outcome, sex) {
  coef_data <- list(
    mi_chd = list(
      male = list(
        log_hr_age = 0.0719227,
        log_hr_chol = 0.2284944,
        log_hr_sbp = 0.0132183,
        log_hr_diabetes = 0.6410114,
        log_hr_smoking = 0.5638109,
        log_hr_chol_age = -0.0045806,
        log_hr_sbp_age = -0.0001576,
        log_hr_diabetes_age = -0.0124966,
        log_hr_smoking_age = -0.0182545,
        baseline_survival = 0.9540108
      ),
      female = list(
        log_hr_age = 0.1020713,
        log_hr_chol = 0.2050377,
        log_hr_sbp = 0.015823,
        log_hr_diabetes = 1.070358,
        log_hr_smoking = 1.053223,
        log_hr_chol_age = -0.0051932,
        log_hr_sbp_age = -0.0001378,
        log_hr_diabetes_age = -0.0234174,
        log_hr_smoking_age = -0.0332666,
        baseline_survival = 0.9894159
      )
    ),
    stroke = list(
      male = list(
        log_hr_age = 0.0986578,
        log_hr_chol = 0.029526,
        log_hr_sbp = 0.0222629,
        log_hr_diabetes = 0.6268712,
        log_hr_smoking = 0.4981217,
        log_hr_chol_age = 0.00142,
        log_hr_sbp_age = -0.0004147,
        log_hr_diabetes_age = -0.026302,
        log_hr_smoking_age = -0.0150561,
        baseline_survival = 0.9849257
      ),
      female = list(
        log_hr_age = 0.1056632,
        log_hr_chol = 0.0257782,
        log_hr_sbp = 0.0206278,
        log_hr_diabetes = 0.8581998,
        log_hr_smoking = 0.7443627,
        log_hr_chol_age = -0.0021387,
        log_hr_sbp_age = -0.0004897,
        log_hr_diabetes_age = -0.0209826,
        log_hr_smoking_age = -0.0200822,
        baseline_survival = 0.9890569
      )
    )
  )
  
  return(coef_data[[outcome]][[sex]])
}


#' Get Model Coefficients for Non-Laboratory-Based Model
#' @noRd
.get_nonlab_coef <- function(outcome, sex) {
  coef_data <- list(
    mi_chd = list(
      male = list(
        log_hr_age = 0.073593,
        log_hr_bmi = 0.0337219,
        log_hr_sbp = 0.0133937,
        log_hr_smoking = 0.5954767,
        log_hr_bmi_age = -0.0010432,
        log_hr_sbp_age = -0.0001837,
        log_hr_smoking_age = -0.0200831,
        baseline_survival = 0.9544258
      ),
      female = list(
        log_hr_age = 0.1049418,
        log_hr_bmi = 0.0257616,
        log_hr_sbp = 0.016726,
        log_hr_smoking = 1.093132,
        log_hr_bmi_age = -0.0006537,
        log_hr_sbp_age = -0.0001966,
        log_hr_smoking_age = -0.0343739,
        baseline_survival = 0.9887124
      )
    ),
    stroke = list(
      male = list(
        log_hr_age = 0.097674,
        log_hr_bmi = 0.0159518,
        log_hr_sbp = 0.0227294,
        log_hr_smoking = 0.4999862,
        log_hr_bmi_age = -0.0003516,
        log_hr_sbp_age = -0.0004374,
        log_hr_smoking_age = -0.0153895,
        baseline_survival = 0.9848260
      ),
      female = list(
        log_hr_age = 0.1046105,
        log_hr_bmi = 0.0036406,
        log_hr_sbp = 0.0216741,
        log_hr_smoking = 0.7399405,
        log_hr_bmi_age = -0.0000129,
        log_hr_sbp_age = -0.0005311,
        log_hr_smoking_age = -0.0203997,
        baseline_survival = 0.9885706
      )
    )
  )
  
  return(coef_data[[outcome]][[sex]])
}




#' Uncalibrated 10-Year Risk from the Derivation (ERFC) Model
#'
#' Computes 1 - S0^exp(LP) for one endpoint, using the sex-specific
#' coefficients and baseline survival of the derivation cohort.
#' @noRd
.uncalibrated_risk <- function(coef_fun, outcome, sex, age_c, sbp_c, x_c,
                               x_name, smoking, diabetes = NULL) {
  risk <- numeric(length(sex))
  for (s in c("male", "female")) {
    idx <- sex == s
    if (!any(idx)) next
    b <- coef_fun(outcome, s)
    a <- age_c[idx]
    x <- x_c[idx]
    sbp <- sbp_c[idx]
    smk <- as.numeric(smoking[idx])

    lp <- b$log_hr_age * a +
      b[[paste0("log_hr_", x_name)]] * x +
      b$log_hr_sbp * sbp +
      b$log_hr_smoking * smk +
      b[[paste0("log_hr_", x_name, "_age")]] * x * a +
      b$log_hr_sbp_age * sbp * a +
      b$log_hr_smoking_age * smk * a

    if (!is.null(diabetes)) {
      dm <- as.numeric(diabetes[idx])
      lp <- lp + b$log_hr_diabetes * dm + b$log_hr_diabetes_age * dm * a
    }

    risk[idx] <- 1 - b$baseline_survival^exp(lp)
  }
  risk
}


#' Recalibrate Risk on the Complementary Log-Log Scale
#'
#' calibrated = 1 - exp(-exp(cons + slope * log(-log(1 - risk))))
#' @noRd
.recalibrate <- function(risk, cons, slope) {
  1 - exp(-exp(cons + slope * log(-log(1 - risk))))
}


#' Map Calendar Year to the Recalibration Period
#'
#' Parameters are available for 1990, 1995, ..., 2015, 2016 and 2017; years up
#' to 2015 use the 5-year period they fall in (as in the authors' Stata code).
#' @noRd
.calibration_year <- function(year) {
  if (any(is.na(year))) {
    stop("Missing values in 'year' are not allowed.")
  }
  if (any(year < 1990 | year > 2017)) {
    stop("'year' must be between 1990 and 2017 (GBD 2017 recalibration).")
  }
  year <- floor(year)
  as.integer(ifelse(year <= 2015, 5 * floor(year / 5), year))
}


#' Look Up Recalibration Parameters
#'
#' Returns a data frame with the cons/slope columns of
#' `.calibration_parameters` for each observation. With
#' `recalibration = "country"`, observations whose country has no
#' country-specific estimate fall back to their region, with a warning.
#' @noRd
.get_calibration <- function(sex, region, country, recalibration, year) {
  parms <- .calibration_parameters
  keys <- paste(parms$level, parms$code, parms$sex, parms$year)
  calyear <- .calibration_year(year)

  row <- match(paste("region", region, sex, calyear), keys)

  if (recalibration == "country") {
    row_country <- match(paste("country", country, sex, calyear), keys)
    missing <- is.na(row_country)
    if (any(missing)) {
      warning("No country-specific recalibration available for: ",
              paste(unique(paste0(country[missing], " (", calyear[missing], ")")),
                    collapse = ", "),
              ". Using region-level recalibration instead.")
    }
    row <- ifelse(missing, row, row_country)
  }

  parms[row, , drop = FALSE]
}


#' Calculate Recalibrated CVD Risk
#'
#' Calibrates CHD/MI and stroke risks separately and combines them assuming
#' independence: 1 - (1 - p_chd) * (1 - p_stroke).
#' @noRd
.calibrated_cvd_risk <- function(p_chd, p_stroke, model, sex, region, country,
                                 recalibration, year) {
  cal <- .get_calibration(sex, region, country, recalibration, year)

  p_chd <- .recalibrate(p_chd, cal[[paste0(model, "_chd_cons")]],
                        cal[[paste0(model, "_chd_slope")]])
  p_stroke <- .recalibrate(p_stroke, cal[[paste0(model, "_stroke_cons")]],
                           cal[[paste0(model, "_stroke_slope")]])

  1 - (1 - p_chd) * (1 - p_stroke)
}
