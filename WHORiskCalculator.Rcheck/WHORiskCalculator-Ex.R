pkgname <- "WHORiskCalculator"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
base::assign(".ExTimings", "WHORiskCalculator-Ex.timings", pos = 'CheckExEnv')
base::cat("name\tuser\tsystem\telapsed\n", file=base::get(".ExTimings", pos = 'CheckExEnv'))
base::assign(".format_ptime",
function(x) {
  if(!is.na(x[4L])) x[1L] <- x[1L] + x[4L]
  if(!is.na(x[5L])) x[2L] <- x[2L] + x[5L]
  options(OutDec = '.')
  format(x[1L:3L], digits = 7L)
},
pos = 'CheckExEnv')

### * </HEADER>
library('WHORiskCalculator')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("calculate_who_risk")
### * calculate_who_risk

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: calculate_who_risk
### Title: Calculate WHO 10-Year CVD Risk (Laboratory-Based Model)
### Aliases: calculate_who_risk

### ** Examples

# Single calculation
calculate_who_risk(
  age = 55,
  sex = "male",
  sbp = 140,
  cholesterol = 5.5,
  smoking = TRUE,
  diabetes = FALSE,
  region = "western_europe"
)

# Using country code instead of region
calculate_who_risk(
  age = 60,
  sex = "female",
  sbp = 130,
  cholesterol = 6.0,
  smoking = FALSE,
  diabetes = TRUE,
  country = "ITA"
)

# Vectorized calculation
calculate_who_risk(
  age = c(45, 55, 65),
  sex = c("male", "female", "male"),
  sbp = c(120, 140, 160),
  cholesterol = c(5.0, 6.0, 7.0),
  smoking = c(FALSE, TRUE, FALSE),
  diabetes = c(FALSE, FALSE, TRUE),
  country = c("USA", "GBR", "IND")
)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("calculate_who_risk", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("calculate_who_risk_nonlab")
### * calculate_who_risk_nonlab

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: calculate_who_risk_nonlab
### Title: Calculate WHO 10-Year CVD Risk (Non-Laboratory-Based Model)
### Aliases: calculate_who_risk_nonlab

### ** Examples

# Single calculation
calculate_who_risk_nonlab(
  age = 55,
  sex = "male",
  sbp = 140,
  bmi = 28,
  smoking = TRUE,
  region = "south_asia"
)

# Using country code
calculate_who_risk_nonlab(
  age = 60,
  sex = "female",
  sbp = 135,
  bmi = 26,
  smoking = FALSE,
  country = "KEN"
)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("calculate_who_risk_nonlab", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("country_to_region")
### * country_to_region

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: country_to_region
### Title: Map Country Code to Region
### Aliases: country_to_region

### ** Examples

country_to_region(c("USA", "DEU", "JPN"))




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("country_to_region", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("get_country_codes")
### * get_country_codes

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: get_country_codes
### Title: Get Country Code to Region Mapping
### Aliases: get_country_codes

### ** Examples

# Get all mappings
head(get_country_codes())

# Look up specific countries
get_country_codes(c("USA", "GBR", "IND"))




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("get_country_codes", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("get_regions")
### * get_regions

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: get_regions
### Title: Get Available Region Names
### Aliases: get_regions

### ** Examples

get_regions()




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("get_regions", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
