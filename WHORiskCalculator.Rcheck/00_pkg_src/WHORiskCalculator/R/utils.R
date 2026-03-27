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
    "SSD" = "north_africa_middle_east", "SDN" = "north_africa_middle_east",
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
    "SOM" = "eastern_subsaharan_africa", "TZA" = "eastern_subsaharan_africa",
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
    "WSM" = "oceania", "ASM" = "oceania",
    
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


#' Get Region-Specific Incidence Rates
#' @noRd
.get_incidence <- function(region, outcome, sex, age) {
  # Get the age group index (5-year bands starting at 40)
  age_idx <- pmax(1, pmin(8, floor((age - 40) / 5) + 1))
  
  # Get incidence data for the region
  inc_data <- .get_incidence_data()
  
  if (!region %in% names(inc_data)) {
    stop("Incidence data not available for region: ", region)
  }
  
  inc_region <- inc_data[[region]][[outcome]][[sex]]
  return(inc_region[age_idx])
}


#' Get Incidence Data (stored internally)
#' @noRd
.get_incidence_data <- function() {
  # Returns the incidence rates per 100,000 person-years
  # Structure: region -> outcome (mi/stroke) -> sex -> age-specific rates
  list(
    north_africa_middle_east = list(
      mi = list(
        male = c(61, 105, 172, 273, 424, 634, 905, 1240),
        female = c(18, 34, 63, 113, 192, 313, 489, 734)
      ),
      stroke = list(
        male = c(52, 91, 152, 246, 386, 589, 871, 1252),
        female = c(36, 63, 106, 173, 277, 430, 651, 963)
      )
    ),
    central_subsaharan_africa = list(
      mi = list(
        male = c(27, 44, 69, 104, 153, 218, 302, 407),
        female = c(10, 17, 29, 47, 73, 110, 162, 231)
      ),
      stroke = list(
        male = c(68, 104, 153, 218, 303, 410, 541, 697),
        female = c(51, 79, 118, 171, 242, 333, 449, 592)
      )
    ),
    eastern_subsaharan_africa = list(
      mi = list(
        male = c(31, 50, 78, 117, 172, 245, 340, 459),
        female = c(11, 19, 32, 51, 79, 120, 175, 250)
      ),
      stroke = list(
        male = c(74, 113, 166, 236, 328, 444, 587, 756),
        female = c(55, 85, 127, 184, 261, 360, 485, 639)
      )
    ),
    southern_subsaharan_africa = list(
      mi = list(
        male = c(52, 84, 131, 199, 292, 419, 584, 794),
        female = c(19, 33, 56, 92, 145, 221, 328, 473)
      ),
      stroke = list(
        male = c(88, 134, 197, 281, 391, 530, 700, 904),
        female = c(65, 101, 151, 219, 310, 428, 576, 760)
      )
    ),
    western_subsaharan_africa = list(
      mi = list(
        male = c(25, 41, 63, 95, 139, 198, 274, 370),
        female = c(9, 16, 27, 44, 68, 103, 151, 216)
      ),
      stroke = list(
        male = c(63, 97, 142, 202, 280, 379, 500, 645),
        female = c(47, 73, 109, 158, 224, 309, 416, 548)
      )
    ),
    southern_latin_america = list(
      mi = list(
        male = c(44, 73, 116, 178, 265, 385, 543, 746),
        female = c(11, 21, 38, 66, 111, 178, 277, 417)
      ),
      stroke = list(
        male = c(30, 51, 83, 130, 199, 296, 428, 603),
        female = c(20, 35, 59, 95, 149, 227, 338, 490)
      )
    ),
    high_income_north_america = list(
      mi = list(
        male = c(71, 116, 182, 277, 408, 584, 812, 1097),
        female = c(21, 38, 67, 115, 188, 298, 455, 673)
      ),
      stroke = list(
        male = c(27, 47, 79, 128, 201, 308, 456, 659),
        female = c(20, 35, 59, 97, 155, 241, 365, 538)
      )
    ),
    caribbean = list(
      mi = list(
        male = c(74, 119, 186, 282, 414, 591, 820, 1106),
        female = c(28, 48, 82, 134, 211, 323, 478, 687)
      ),
      stroke = list(
        male = c(55, 92, 147, 229, 345, 505, 718, 994),
        female = c(43, 72, 117, 184, 281, 418, 604, 852)
      )
    ),
    andean_latin_america = list(
      mi = list(
        male = c(26, 43, 68, 104, 155, 226, 319, 440),
        female = c(9, 16, 28, 47, 76, 119, 181, 268)
      ),
      stroke = list(
        male = c(25, 42, 69, 109, 167, 249, 361, 510),
        female = c(19, 33, 54, 87, 136, 207, 308, 445)
      )
    ),
    central_latin_america = list(
      mi = list(
        male = c(52, 85, 134, 205, 304, 439, 616, 841),
        female = c(17, 30, 53, 89, 144, 225, 341, 501)
      ),
      stroke = list(
        male = c(33, 56, 91, 143, 218, 323, 465, 653),
        female = c(25, 43, 71, 113, 176, 266, 391, 560)
      )
    ),
    tropical_latin_america = list(
      mi = list(
        male = c(61, 99, 155, 235, 347, 498, 695, 943),
        female = c(20, 35, 61, 101, 163, 254, 383, 562)
      ),
      stroke = list(
        male = c(43, 72, 116, 181, 275, 406, 583, 815),
        female = c(32, 54, 89, 141, 219, 330, 484, 692)
      )
    ),
    east_asia = list(
      mi = list(
        male = c(44, 72, 114, 174, 258, 373, 523, 714),
        female = c(14, 25, 44, 74, 121, 190, 290, 431)
      ),
      stroke = list(
        male = c(97, 159, 251, 383, 567, 816, 1140, 1549),
        female = c(63, 105, 169, 264, 401, 591, 846, 1180)
      )
    ),
    south_asia = list(
      mi = list(
        male = c(111, 172, 258, 375, 529, 727, 972, 1265),
        female = c(43, 68, 106, 160, 235, 336, 469, 639)
      ),
      stroke = list(
        male = c(70, 111, 170, 253, 367, 518, 712, 955),
        female = c(52, 84, 131, 199, 293, 422, 592, 811)
      )
    ),
    southeast_asia = list(
      mi = list(
        male = c(61, 99, 155, 236, 349, 502, 703, 958),
        female = c(22, 38, 66, 109, 176, 274, 414, 607)
      ),
      stroke = list(
        male = c(91, 147, 228, 343, 502, 714, 988, 1331),
        female = c(63, 103, 163, 250, 373, 541, 765, 1054)
      )
    ),
    central_asia = list(
      mi = list(
        male = c(137, 217, 333, 494, 713, 1001, 1369, 1823),
        female = c(38, 66, 112, 184, 291, 449, 673, 981)
      ),
      stroke = list(
        male = c(121, 192, 294, 438, 633, 892, 1222, 1633),
        female = c(81, 131, 206, 313, 464, 670, 942, 1292)
      )
    ),
    high_income_asia_pacific = list(
      mi = list(
        male = c(24, 40, 64, 100, 152, 224, 322, 451),
        female = c(6, 11, 20, 35, 58, 94, 148, 226)
      ),
      stroke = list(
        male = c(44, 74, 119, 186, 283, 418, 601, 843),
        female = c(24, 42, 70, 113, 177, 269, 398, 574)
      )
    ),
    western_europe = list(
      mi = list(
        male = c(49, 81, 129, 199, 298, 434, 616, 850),
        female = c(10, 19, 34, 60, 102, 166, 262, 402)
      ),
      stroke = list(
        male = c(26, 45, 75, 121, 190, 291, 433, 628),
        female = c(16, 28, 48, 80, 129, 202, 308, 458)
      )
    ),
    central_europe = list(
      mi = list(
        male = c(87, 140, 218, 330, 486, 697, 973, 1323),
        female = c(21, 37, 65, 110, 181, 288, 444, 665)
      ),
      stroke = list(
        male = c(62, 103, 165, 257, 389, 573, 822, 1150),
        female = c(39, 66, 109, 174, 271, 411, 605, 869)
      )
    ),
    eastern_europe = list(
      mi = list(
        male = c(178, 281, 431, 638, 921, 1295, 1775, 2373),
        female = c(44, 77, 132, 217, 346, 536, 807, 1182)
      ),
      stroke = list(
        male = c(117, 186, 287, 427, 620, 875, 1203, 1611),
        female = c(73, 119, 187, 286, 425, 615, 868, 1195)
      )
    ),
    oceania = list(
      mi = list(
        male = c(99, 155, 235, 346, 495, 690, 936, 1238),
        female = c(42, 68, 109, 168, 253, 369, 524, 724)
      ),
      stroke = list(
        male = c(97, 152, 230, 339, 486, 678, 920, 1218),
        female = c(72, 114, 175, 261, 379, 537, 739, 994)
      )
    ),
    australasia = list(
      mi = list(
        male = c(53, 88, 140, 216, 323, 471, 667, 920),
        female = c(13, 24, 43, 74, 123, 197, 306, 461)
      ),
      stroke = list(
        male = c(22, 38, 64, 104, 165, 254, 380, 554),
        female = c(16, 28, 48, 79, 127, 199, 303, 451)
      )
    )
  )
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
        baseline_survival = 0.954
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
        baseline_survival = 0.989
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
        baseline_survival = 0.985
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
        baseline_survival = 0.989
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
        baseline_survival = 0.954
      ),
      female = list(
        log_hr_age = 0.1049418,
        log_hr_bmi = 0.0257616,
        log_hr_sbp = 0.016726,
        log_hr_smoking = 1.093132,
        log_hr_bmi_age = -0.0006537,
        log_hr_sbp_age = -0.0001966,
        log_hr_smoking_age = -0.0343739,
        baseline_survival = 0.989
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
        baseline_survival = 0.985
      ),
      female = list(
        log_hr_age = 0.1046105,
        log_hr_bmi = 0.0036406,
        log_hr_sbp = 0.0216741,
        log_hr_smoking = 0.7399405,
        log_hr_bmi_age = -0.0000129,
        log_hr_sbp_age = -0.0005311,
        log_hr_smoking_age = -0.0203997,
        baseline_survival = 0.989
      )
    )
  )
  
  return(coef_data[[outcome]][[sex]])
}


#' Calculate Laboratory-Based Risk for Single Observation
#' @noRd
.calculate_lab_risk_single <- function(age_c, sbp_c, chol_c, smoking, diabetes,
                                        sex, region, age_raw) {
  
  # Get coefficients for MI/CHD
  coef_mi <- .get_lab_coef("mi_chd", sex)
  
  # Calculate linear predictor for MI/CHD
  lp_mi <- coef_mi$log_hr_age * age_c +
    coef_mi$log_hr_chol * chol_c +
    coef_mi$log_hr_sbp * sbp_c +
    coef_mi$log_hr_diabetes * as.numeric(diabetes) +
    coef_mi$log_hr_smoking * as.numeric(smoking) +
    coef_mi$log_hr_chol_age * chol_c * age_c +
    coef_mi$log_hr_sbp_age * sbp_c * age_c +
    coef_mi$log_hr_diabetes_age * as.numeric(diabetes) * age_c +
    coef_mi$log_hr_smoking_age * as.numeric(smoking) * age_c
  
  # Get coefficients for Stroke
  coef_stroke <- .get_lab_coef("stroke", sex)
  
  # Calculate linear predictor for Stroke
  lp_stroke <- coef_stroke$log_hr_age * age_c +
    coef_stroke$log_hr_chol * chol_c +
    coef_stroke$log_hr_sbp * sbp_c +
    coef_stroke$log_hr_diabetes * as.numeric(diabetes) +
    coef_stroke$log_hr_smoking * as.numeric(smoking) +
    coef_stroke$log_hr_chol_age * chol_c * age_c +
    coef_stroke$log_hr_sbp_age * sbp_c * age_c +
    coef_stroke$log_hr_diabetes_age * as.numeric(diabetes) * age_c +
    coef_stroke$log_hr_smoking_age * as.numeric(smoking) * age_c
  
  # Get region-specific incidence
  inc_mi <- .get_incidence(region, "mi", sex, age_raw)
  inc_stroke <- .get_incidence(region, "stroke", sex, age_raw)
  
  # Calculate recalibration factors
  # Using the recalibration approach from the supplementary methods
  # The 10-year risk is calculated using region-specific baseline hazards
  
  # Calculate 10-year cumulative incidence (approximate using annual rates)
  # Converting incidence per 100,000 to probability
  annual_rate_mi <- inc_mi / 100000
  annual_rate_stroke <- inc_stroke / 100000
  
  # Apply hazard ratios to get individual risk
  # Using the formula: risk = 1 - S0^exp(LP)
  # Where S0 is recalibrated based on regional incidence
  
  # Baseline survival recalibrated to region
  # The baseline survival from derivation data is adjusted using ratio of
  # regional to derivation incidence
  
  # Simplified recalibration: use 10-year cumulative incidence
  p_mi_baseline <- 1 - exp(-10 * annual_rate_mi)
  p_stroke_baseline <- 1 - exp(-10 * annual_rate_stroke)
  
  # Apply hazard ratio
  # For Cox model: P(t) = 1 - S0(t)^exp(LP)
  # We approximate S0 from regional baseline probability
  s0_mi <- 1 - p_mi_baseline
  s0_stroke <- 1 - p_stroke_baseline
  
  # Individual probabilities
  p_mi <- 1 - s0_mi^exp(lp_mi)
  p_stroke <- 1 - s0_stroke^exp(lp_stroke)
  
  # Bound probabilities
  p_mi <- pmax(0, pmin(1, p_mi))
  p_stroke <- pmax(0, pmin(1, p_stroke))
  
  # Combined CVD risk (assuming independence)
  p_cvd <- 1 - (1 - p_mi) * (1 - p_stroke)
  
  return(p_cvd)
}


#' Calculate Non-Laboratory-Based Risk for Single Observation
#' @noRd
.calculate_nonlab_risk_single <- function(age_c, sbp_c, bmi_c, smoking,
                                           sex, region, age_raw) {
  
  # Get coefficients for MI/CHD
  coef_mi <- .get_nonlab_coef("mi_chd", sex)
  
  # Calculate linear predictor for MI/CHD
  lp_mi <- coef_mi$log_hr_age * age_c +
    coef_mi$log_hr_bmi * bmi_c +
    coef_mi$log_hr_sbp * sbp_c +
    coef_mi$log_hr_smoking * as.numeric(smoking) +
    coef_mi$log_hr_bmi_age * bmi_c * age_c +
    coef_mi$log_hr_sbp_age * sbp_c * age_c +
    coef_mi$log_hr_smoking_age * as.numeric(smoking) * age_c
  
  # Get coefficients for Stroke
  coef_stroke <- .get_nonlab_coef("stroke", sex)
  
  # Calculate linear predictor for Stroke
  lp_stroke <- coef_stroke$log_hr_age * age_c +
    coef_stroke$log_hr_bmi * bmi_c +
    coef_stroke$log_hr_sbp * sbp_c +
    coef_stroke$log_hr_smoking * as.numeric(smoking) +
    coef_stroke$log_hr_bmi_age * bmi_c * age_c +
    coef_stroke$log_hr_sbp_age * sbp_c * age_c +
    coef_stroke$log_hr_smoking_age * as.numeric(smoking) * age_c
  
  # Get region-specific incidence
  inc_mi <- .get_incidence(region, "mi", sex, age_raw)
  inc_stroke <- .get_incidence(region, "stroke", sex, age_raw)
  
  # Calculate 10-year risk using same approach as lab model
  annual_rate_mi <- inc_mi / 100000
  annual_rate_stroke <- inc_stroke / 100000
  
  p_mi_baseline <- 1 - exp(-10 * annual_rate_mi)
  p_stroke_baseline <- 1 - exp(-10 * annual_rate_stroke)
  
  s0_mi <- 1 - p_mi_baseline
  s0_stroke <- 1 - p_stroke_baseline
  
  p_mi <- 1 - s0_mi^exp(lp_mi)
  p_stroke <- 1 - s0_stroke^exp(lp_stroke)
  
  p_mi <- pmax(0, pmin(1, p_mi))
  p_stroke <- pmax(0, pmin(1, p_stroke))
  
  p_cvd <- 1 - (1 - p_mi) * (1 - p_stroke)
  
  return(p_cvd)
}
