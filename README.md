# WHOrisk: WHO Cardiovascular Disease Risk Calculator

An R package implementing the 2019 WHO cardiovascular disease (CVD) risk prediction models for 21 global regions.

## Overview

This package calculates 10-year risk of cardiovascular disease (fatal and non-fatal myocardial infarction and stroke) using the WHO risk charts published in The Lancet Global Health (2019).

**Reference:** \> Kaptoge S, Pennells L, De Bacquer D, et al. World Health Organization cardiovascular disease risk charts: revised models to estimate risk in 21 global regions. *Lancet Glob Health*. 2019;7(10):e1332-e1345. [doi:10.1016/S2214-109X(19)30318-3](doi:10.1016/S2214-109X(19)30318-3){.uri}

## Features

-   **Two models available:**
    -   Laboratory-based model (requires cholesterol measurement)
    -   Non-laboratory-based model (uses BMI instead, suitable for resource-limited settings)
-   **Fully vectorized** for efficient batch calculations
-   **Zero dependencies** - uses only base R
-   **Automatic country-to-region mapping** using ISO 3166-1 alpha-3 country codes
-   **21 global regions** with region-specific recalibration, plus optional country-specific recalibration
-   **Matches the authors' implementation**: recalibration parameters taken from the authors' Stata program [`whocvdrisk`](https://github.com/skkceu/stata)

## Installation

``` r
# Install from source
install.packages("WHOrisk", repos = NULL, type = "source")

# Or using devtools
devtools::install_local("path/to/WHOrisk")
```

## Usage

### Laboratory-Based Model

``` r
library(WHOrisk)

# Single patient calculation using region
risk <- calculate_who_risk(
  age = 55,
  sex = "male",
  sbp = 140,
  cholesterol = 5.5,  # mmol/L
  smoking = TRUE,
  diabetes = FALSE,
  region = "western_europe"
)
print(paste0("10-year CVD risk: ", round(risk * 100, 1), "%"))

# Using country code instead of region
risk <- calculate_who_risk(
  age = 60,
  sex = "female",
  sbp = 130,
  cholesterol = 6.0,
  smoking = FALSE,
  diabetes = TRUE,
  country = "ITA"  # Italy -> western_europe
)

# Vectorized calculation for multiple patients
risks <- calculate_who_risk(
  age = c(45, 55, 65, 75),
  sex = c("male", "female", "male", "female"),
  sbp = c(120, 140, 160, 150),
  cholesterol = c(5.0, 6.0, 7.0, 5.5),
  smoking = c(FALSE, TRUE, FALSE, FALSE),
  diabetes = c(FALSE, FALSE, TRUE, TRUE),
  country = c("USA", "GBR", "IND", "JPN")
)
```

### Non-Laboratory-Based Model

For settings where cholesterol measurement is not available:

``` r
risk <- calculate_who_risk_nonlab(
  age = 55,
  sex = "male",
  sbp = 140,
  bmi = 28,
  smoking = TRUE,
  region = "south_asia"
)
```

### Recalibration Options

By default, risks are recalibrated to the 21 GBD regions for 2017, as in the published WHO risk charts. Country-specific recalibration and earlier calendar years are also available:

``` r
# Country-specific recalibration (requires `country`)
calculate_who_risk(
  age = 45, sex = "male", sbp = 140, cholesterol = 5.5,
  smoking = TRUE, diabetes = FALSE,
  country = "GBR", recalibration = "country"
)

# Recalibrate to an earlier year (1990-2017; years up to 2015 use 5-year periods)
calculate_who_risk_nonlab(
  age = 55, sex = "female", sbp = 135, bmi = 26, smoking = FALSE,
  country = "KEN", year = 2005
)
```

A few territories (e.g. South Sudan, American Samoa, Guam) have no country-specific estimates; these fall back to their region with a warning.

### Utility Functions

``` r
# Get list of valid regions
get_regions()

# Get country code mappings
get_country_codes()

# Look up specific countries
get_country_codes(c("USA", "GBR", "IND"))

# Map country to region
country_to_region(c("FRA", "DEU", "ITA"))  # All return "western_europe"
```

## Model Details

### Variables and Centering

| Variable          | Laboratory Model | Non-Lab Model | Centered At |
|-------------------|------------------|---------------|-------------|
| Age               | ✓                | ✓             | 60 years    |
| Systolic BP       | ✓                | ✓             | 120 mmHg    |
| Total Cholesterol | ✓                | \-            | 6 mmol/L    |
| BMI               | \-               | ✓             | 25 kg/m²    |
| Smoking           | ✓                | ✓             | \-          |
| Diabetes          | ✓                | \-            | \-          |

### Valid Ranges

-   **Age:** 40-80 years (model derivation range)
-   **Systolic BP:** Typically 70-250 mmHg
-   **Cholesterol:** 2-12 mmol/L (divide mg/dL by 38.67)
-   **BMI:** 12-60 kg/m²

### 21 Global Regions

| Region Code                  | Description                  |
|------------------------------|------------------------------|
| `north_africa_middle_east`   | North Africa and Middle East |
| `central_subsaharan_africa`  | Central Sub-Saharan Africa   |
| `eastern_subsaharan_africa`  | Eastern Sub-Saharan Africa   |
| `southern_subsaharan_africa` | Southern Sub-Saharan Africa  |
| `western_subsaharan_africa`  | Western Sub-Saharan Africa   |
| `southern_latin_america`     | Southern Latin America       |
| `high_income_north_america`  | High-income North America    |
| `caribbean`                  | Caribbean                    |
| `andean_latin_america`       | Andean Latin America         |
| `central_latin_america`      | Central Latin America        |
| `tropical_latin_america`     | Tropical Latin America       |
| `east_asia`                  | East Asia                    |
| `south_asia`                 | South Asia                   |
| `southeast_asia`             | Southeast Asia               |
| `central_asia`               | Central Asia                 |
| `high_income_asia_pacific`   | High-income Asia Pacific     |
| `western_europe`             | Western Europe               |
| `central_europe`             | Central Europe               |
| `eastern_europe`             | Eastern Europe               |
| `oceania`                    | Oceania                      |
| `australasia`                | Australasia                  |

## Algorithm

The model calculates separate 10-year risks for: 1. Myocardial infarction / CHD death 2. Stroke

These are combined assuming independence:

```         
P(CVD) = 1 - (1 - P(MI)) × (1 - P(Stroke))
```

Each endpoint risk is first calculated from the derivation (ERFC) Cox model, using the baseline survival of the derivation cohort:

```         
P(event) = 1 - S₀^exp(LP)
```

Where: - `S₀` = 10-year baseline survival of the derivation cohort (sex- and endpoint-specific) - `LP` = linear predictor including main effects and age interactions

Each endpoint risk is then recalibrated on the complementary log-log scale:

```         
P_calibrated = 1 - exp(-exp(cons + slope × ln(-ln(1 - P))))
```

The intercepts (`cons`) and slopes (`slope`) are specific to region (or country), sex, endpoint and year. They were fitted by the model's authors to GBD 2017 incidence rates and NCD-RisC risk factor levels, and are taken from their Stata implementation (`net install whocvdrisk, from("https://raw.githubusercontent.com/skkceu/stata/main")`). See `data-raw/calibration_parameters.R` for how they are extracted.

## Cholesterol Unit Conversion

The model uses mmol/L. To convert from mg/dL:

``` r
cholesterol_mmol <- cholesterol_mg_dl / 38.67
```

## Limitations

1.  **Age range:** Model was derived for ages 40-80. Extrapolation outside this range is less reliable.

2.  **Non-laboratory model:** Does not include diabetes, so may underestimate risk in diabetic patients.

3.  **Calibration:** Based on GBD 2017 estimates; actual risk may vary within a country or population.

4.  **Risk factors not included:** Family history, ethnicity, HDL cholesterol, triglycerides, etc.

## License

MIT License. See LICENSE file for details.

The underlying risk models are from the WHO CVD Risk Chart Working Group. The recalibration parameters are from the `whocvdrisk` Stata program by Stephen Kaptoge and Lisa Pennells (Cardiovascular Epidemiology Unit, University of Cambridge).
