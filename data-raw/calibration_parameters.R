# =============================================================================
# Build internal recalibration parameters (R/sysdata.rda)
# =============================================================================
#
# Source: the authors' Stata implementation `whocvdrisk` (S Kaptoge, L Pennells,
# Cardiovascular Epidemiology Unit, University of Cambridge), installable with
#   net install whocvdrisk, from("https://raw.githubusercontent.com/skkceu/stata/main")
#
# The file whocvdrisk_t10_calparms_gbd_sens0.dta holds the fitted 10-year
# recalibration intercepts (cons) and slopes on the complementary log-log scale,
# by country / GBD region, sex and calendar year (GBD 2017 rates):
#
#   calibrated = 1 - exp(-exp(cons + slope * log(-log(1 - uncalibrated))))
#
# Variable naming in the Stata file: cal<i>_m<j>_<parm>_<ep>
#   i   = 1 country-specific, 2 GBD region
#   j   = 1 laboratory model, 2 non-laboratory model
#   ep  = ep_chdmi (CHD/MI), ep_crbv (stroke)
#
# Run from the package root:  Rscript data-raw/calibration_parameters.R

url <- paste0("https://raw.githubusercontent.com/skkceu/stata/main/",
              "whocvdrisk_t10_calparms_gbd_sens0.dta")
dta <- tempfile(fileext = ".dta")
utils::download.file(url, dta, mode = "wb")
raw <- as.data.frame(haven::zap_labels(haven::read_dta(dta)))

source("R/calculate_who_risk.R")
regions <- get_regions()

# Keep the 21 GBD regions (gbdregid 1-21) and their countries; drop the
# super-region aggregates (gbdregid > 100)
raw <- raw[raw$gbdregid %in% 1:21, ]
raw$region <- regions[raw$gbdregid]
raw$sex <- c("male", "female")[raw$sex]
is_region_row <- grepl("GBDR", raw$ccode)

parm_cols <- function(i) {
  out <- c()
  for (m in c(lab = 1, nonlab = 2)) {
    for (ep in c(chd = "ep_chdmi", stroke = "ep_crbv")) {
      for (p in c("cons", "slope")) {
        out <- c(out, sprintf("cal%d_m%d_%s_%s", i, m, p, ep))
      }
    }
  }
  names(out) <- c(t(outer(
    c("lab_chd", "lab_stroke", "nonlab_chd", "nonlab_stroke"),
    c("cons", "slope"), paste, sep = "_"
  )))
  out
}

build <- function(rows, level, code, i) {
  cols <- parm_cols(i)
  out <- data.frame(
    level = level,
    code = code,
    sex = rows$sex,
    year = as.integer(rows$year),
    stringsAsFactors = FALSE
  )
  for (nm in names(cols)) out[[nm]] <- as.numeric(rows[[cols[nm]]])
  out
}

region_parms <- build(raw[is_region_row, ], "region",
                      raw$region[is_region_row], 2)
country_parms <- build(raw[!is_region_row, ], "country",
                       raw$ccode[!is_region_row], 1)
# Countries without country-specific estimates for a given year
country_parms <- country_parms[stats::complete.cases(country_parms), ]

.calibration_parameters <- rbind(region_parms, country_parms)
.calibration_parameters <- .calibration_parameters[
  order(.calibration_parameters$level, .calibration_parameters$code,
        .calibration_parameters$sex, .calibration_parameters$year), ]
rownames(.calibration_parameters) <- NULL

save(.calibration_parameters, file = "R/sysdata.rda", compress = "xz",
     version = 2)
