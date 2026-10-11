# WHORiskCalculator 1.1.0

* **Corrected recalibration** (thanks to a user report). Risks are now calculated
  as in the published method (Kaptoge et al. 2019) and the authors' Stata
  program `whocvdrisk`: the uncalibrated risk uses the derivation cohort's
  baseline survival and is then recalibrated on the complementary log-log scale,
  `1 - exp(-exp(cons + slope * log(-log(1 - risk))))`, with the authors'
  region-, sex- and endpoint-specific parameters. Before this release the
  baseline survival was replaced by a 10-year risk built from regional age-band
  incidence rates, which counted age twice: it underestimated risk at younger
  ages and overestimated it at older ages. **Results change considerably from
  1.0.0.**
* Baseline survival values now use the authors' full precision, with separate
  values for the laboratory and non-laboratory models.
* New `recalibration` argument: `"region"` (default, as in the published charts)
  or `"country"` for country-specific recalibration.
* New `year` argument (1990-2017, default 2017) to choose the calendar year
  of recalibration.
* South Sudan (`SSD`) now maps to Eastern Sub-Saharan Africa, and Guam (`GUM`)
  and the Northern Mariana Islands (`MNP`) are added to Oceania, matching the
  authors' GBD region assignment.
* Risk calculations are now fully vectorized (no per-row `mapply`).
* Added a testthat suite that checks results against the authors' Stata
  implementation.

# WHORiskCalculator 1.0.0

* Initial CRAN submission.
