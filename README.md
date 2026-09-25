# OXPHOS-CCA reproducibility package — FINAL v1.2.0

This repository accompanies the manuscript **“Cross-cohort evaluation of an oxidative phosphorylation transcriptional score in cholangiocarcinoma.”**

## What v1.1.0 contains

This release preserves the frozen v1.0.0 patient-level derived datasets and survival analyses and adds manuscript-aligned plotting scripts for the final Kaplan–Meier panels and forest plots.

Final analysis cohorts:
- **TCGA-CHOL:** 33 primary solid tumors (sample type 01), 18 deaths.
- **GSE89749:** 115 tumors with usable overall survival, 64 deaths.
- Prespecified pathway: **MSigDB HALLMARK_OXIDATIVE_PHOSPHORYLATION (200 genes)**.
- Primary survival estimand: continuous OXPHOS score per 1 SD.
- Median split: secondary descriptive analysis.

## Important provenance limitation

The exact verbatim historical scripts that transformed the original raw expression files into the final OXPHOS patient-level scores were not recovered. They are **not reconstructed or represented as original code** in this release.

Instead, the repository provides:
1. the frozen patient-level derived datasets used in the final analyses;
2. R scripts that reproduce the final Cox and log-rank analyses from those datasets;
3. frozen mapping, preprocessing-sensitivity, and liver-fluke audit outputs;
4. audit-note scripts documenting the historical score-construction specification; and
5. plotting code recovered/reconstructed from the saved final R analysis session for the manuscript figures.

This distinction is intentional and prevents newly written preprocessing code from being misrepresented as historical source code.

## Final manuscript targets

| Cohort / analysis | HR | 95% CI | P |
|---|---:|---:|---:|
| TCGA continuous per SD | 1.1681 | 0.7475–1.8254 | 0.4951 |
| TCGA high vs low | 1.1252 | 0.4268–2.9663 | 0.8115 |
| TCGA adjusted per SD | 1.6429 | 0.9062–2.9785 | 0.1019 |
| GSE89749 continuous per SD | 0.7533 | 0.5986–0.9479 | 0.01566 |
| GSE89749 high vs low | 0.5180 | 0.3118–0.8607 | 0.0097 (log-rank) |

## Figure 2 time units

The frozen GSE89749 derived table stores survival time in **months**. The final manuscript Figure 2B displays time in **days**, using `months × 30.4375`. This is a linear unit conversion for visualization and therefore does not change the Cox hazard ratio or log-rank P value. The TCGA table already stores overall survival in days.

Final risk tables used in Figure 2:
- TCGA Low: 16, 8, 6, 2, 0; High: 17, 13, 4, 1, 0 at 0, 500, 1000, 1500, 2000 days.
- GSE89749 Low: 57, 19, 10, 3, 1; High: 58, 28, 12, 7, 2 at 0, 600, 1200, 1800, 2400 days.

## Directory structure

- `code/00_run_all_reproducible.R` — runs all reproducible analyses/plots based on frozen inputs.
- `code/01_TCGA_CHOL_final33_survival.R` — TCGA survival models.
- `code/02_GSE89749_final115_survival.R` — GSE89749 survival models.
- `code/03_Figure2_KM_FINAL.R` — final Figure 2A/2B KM curves and risk tables.
- `code/04_Figure3_cross_cohort_forest.R` — cross-cohort forest plot.
- `code/05_Figure4_preprocessing_sensitivity.R` — preprocessing sensitivity forest plot.
- `code/06_fluke_sensitivity_FROZEN.R` — frozen liver-fluke sensitivity output.
- `code/07_*` and `08_*` — provenance/audit notes for unrecovered upstream preprocessing code.
- `data_derived/` — frozen patient-level derived data.
- `audit_outputs/` — frozen statistical and preprocessing audit outputs.
- `figures/` — destination for generated manuscript figures.

## R packages

Required: `survival`, `ggplot2`, `gridExtra`. (`grid` is part of base R.)

## Recommended run order

Open R with the working directory set to `code/`, then run:

```r
source("00_run_all_reproducible.R")
```

or run scripts 01–06 individually.

## Reproducibility scope

This repository reproduces the **final statistical analyses and manuscript figures from the frozen derived data**. It does not claim end-to-end reconstruction from raw TCGA/GEO expression files because the exact historical upstream preprocessing scripts were not recovered.


## Final manuscript figure files

The `figures/` directory also contains the four **final manuscript-aligned PNG files**:
- `Figure1_FINAL_workflow.png`
- `Figure2_FINAL_KM_panels_A_B.png`
- `Figure3_FINAL_cross_cohort_forest.png`
- `Figure4_FINAL_preprocessing_sensitivity.png`

These are the finalized versions embedded in the latest manuscript and supersede earlier visual drafts.
