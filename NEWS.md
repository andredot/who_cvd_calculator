# WHORiskCalculator 1.1.0

## Breaking changes

* **Corrected recalibration.** Results change considerably from 1.0.0, and
  1.1.0 results should be used instead. Version 1.0.0 replaced the
  derivation baseline survival with a 10-year risk built from regional age-band
  incidence rates. Because the linear predictor already includes age and age
  interactions, this counted age twice: risk was underestimated at younger ages
  and overestimated at older ages (e.g. UK male smoker, SBP 140 mmHg, total
  cholesterol 5.5 mmol/L: about 1% at age 45 and 58% at age 75, against 7% and
  29% now). Risks are now calculated as in the published method (Kaptoge et al.
  2019) and the authors' Stata program `whocvdrisk`:
  1. uncalibrated risk from the derivation model, `1 - S0^exp(LP)`;
  2. recalibration on the complementary log-log scale,
     `1 - exp(-exp(cons + slope * log(-log(1 - risk))))`, using the authors'
     parameters for each region, sex, endpoint, model and year;
  3. combination of CHD/MI and stroke risks assuming independence.

  Thanks to the user who reported the issue and pointed to the authors'
  Stata implementation.
* Baseline survival values now use the authors' full precision, with separate
  values for the laboratory and non-laboratory models.
* South Sudan (`SSD`) now maps to Eastern Sub-Saharan Africa (previously
  North Africa and Middle East), matching the authors' GBD region assignment.

## New features

* New `recalibration` argument in `calculate_who_risk()` and
  `calculate_who_risk_nonlab()`:
  * `"region"` (default): WHO/GBD region-level recalibration, reproducing the
    published WHO risk charts and the default output of `whocvdrisk`.
  * `"country"`: country-level recalibration (requires `country`). Countries
    without country-specific estimates fall back to region level with a
    warning.
* New `year` argument (1990-2017, default 2017) to choose the calendar year of
  the recalibration target population.
* Guam (`GUM`) and the Northern Mariana Islands (`MNP`) added to Oceania.
* New "Recalibration" section in the help pages and README.

## Internal

* Recalibration parameters are stored in `R/sysdata.rda`, built from the
  authors' Stata data file by `data-raw/calibration_parameters.R`. The
  incidence-rate tables used by 1.0.0 have been removed.
* Risk calculations are fully vectorized (no per-row `mapply()`).
* Added a testthat suite checking results against an independent
  re-implementation of the authors' Stata code (both models, region- and
  country-level recalibration, all years).
* Package now depends on R (>= 2.10) because of the internal data.

# WHORiskCalculator 1.0.0

* Initial CRAN submission.
