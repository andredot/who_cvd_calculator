# WHORiskCalculator: WHO Cardiovascular Disease Risk Calculator

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
-   **21 global regions** with region-level recalibration by default (as in the published WHO risk charts), plus optional country-level recalibration
-   **Matches the authors' implementation**: recalibration parameters taken from the authors' Stata program [`whocvdrisk`](https://github.com/skkceu/stata)

## Installation

``` r
# From CRAN
install.packages("WHORiskCalculator")

# Development version from GitHub
# install.packages("remotes")
remotes::install_github("andredot/who_cvd_calculator")
```

## Usage

### Laboratory-Based Model

``` r
library(WHORiskCalculator)

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

### Recalibration: Region (Default) or Country

Both functions take a `recalibration` argument:

| `recalibration` | Parameters used | Matches | Requires |
|-----------------|-----------------|---------|----------|
| `"region"` (default) | One set per WHO/GBD region, sex and year | Published WHO risk charts; default output of the authors' Stata program | `region` or `country` |
| `"country"` | One set per country, sex and year | Country-specific (`cal1`) output of the authors' Stata program | `country` |

**Region-level (default).** Use this to get chart-equivalent risks. If you pass `country`, it is only used to find the region, so all countries in a region get the same result.

**Country-level (optional).** Use this when you want estimates recalibrated to a specific country's GBD 2017 incidence rates and NCD-RisC risk factor levels. Results can differ substantially from region-level ones:

``` r
# 45-year-old male smoker, UK, SBP 140 mmHg, total cholesterol 5.5 mmol/L
calculate_who_risk(45, "male", 140, 5.5, smoking = TRUE, diabetes = FALSE,
                   country = "GBR")                            # region:  ~7.0%
calculate_who_risk(45, "male", 140, 5.5, smoking = TRUE, diabetes = FALSE,
                   country = "GBR", recalibration = "country") # country: ~9.4%
```

| Age | Region-level (Western Europe) | Country-level (United Kingdom) |
|-----|-------------------------------|--------------------------------|
| 45  | 7.0%                          | 9.4%                           |
| 55  | 11.5%                         | 15.6%                          |
| 65  | 18.5%                         | 25.2%                          |
| 75  | 28.9%                         | 39.3%                          |

Country-specific estimates are not available for South Sudan (`SSD`), the US Virgin Islands (`VIR`), American Samoa (`ASM`), Guam (`GUM`) and the Northern Mariana Islands (`MNP`), nor for Greenland (`GRL`), Bermuda (`BMU`) and Puerto Rico (`PRI`) before 2015. For these, the region-level parameters are used and a warning is issued.

**Calendar year.** `year` (default 2017, as in the charts) selects the year of the recalibration target population. Parameters exist for 1990, 1995, 2000, 2005, 2010, 2015, 2016 and 2017; other years up to 2015 use the 5-year period they fall in (e.g. 2003 uses 2000).

``` r
calculate_who_risk_nonlab(
  age = 55, sex = "female", sbp = 135, bmi = 26, smoking = FALSE,
  country = "KEN", recalibration = "country", year = 2010
)
```

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

Risk is calculated separately for (a) myocardial infarction / CHD death and (b) stroke, in three steps, following Kaptoge et al. (2019) and the authors' Stata implementation:

1.  **Uncalibrated risk** from the derivation (ERFC) Cox model:

    ```
    P = 1 - S₀^exp(LP)
    ```

    where `S₀` is the 10-year baseline survival of the derivation cohort (specific to sex, endpoint and model) and `LP` is the linear predictor, including main effects and age interactions.

2.  **Recalibration** on the complementary log-log scale:

    ```
    P_cal = 1 - exp(-exp(cons + slope × ln(-ln(1 - P))))
    ```

    The intercept `cons` and slope `slope` are specific to region (or country, with `recalibration = "country"`), sex, endpoint, model and year. The authors fitted them to GBD 2017 incidence rates and NCD-RisC risk factor levels; this package takes them from their Stata program (`net install whocvdrisk, from("https://raw.githubusercontent.com/skkceu/stata/main")`). See `data-raw/calibration_parameters.R` for how they are extracted.

3.  **Combination**, assuming independence of the two endpoints:

    ```
    P(CVD) = 1 - (1 - P_cal(MI)) × (1 - P_cal(Stroke))
    ```

## Cholesterol Unit Conversion

The model uses mmol/L. To convert from mg/dL:

``` r
cholesterol_mmol <- cholesterol_mg_dl / 38.67
```

## Limitations

1.  **Age range:** Model was derived for ages 40-80. Extrapolation outside this range is less reliable.

2.  **Non-laboratory model:** Does not include diabetes, so may underestimate risk in diabetic patients.

3.  **Calibration:** Based on GBD 2017 estimates; actual risk may vary within a country or population. Because the models are recalibrated to contemporary populations, they may not be well suited to historically collected data (use `year` with care).

4.  **Risk factors not included:** Family history, ethnicity, HDL cholesterol, triglycerides, etc.

## License

MIT License. See LICENSE file for details.

The underlying risk models are from the WHO CVD Risk Chart Working Group. The recalibration parameters are from the `whocvdrisk` Stata program by Stephen Kaptoge and Lisa Pennells (Cardiovascular Epidemiology Unit, University of Cambridge).
