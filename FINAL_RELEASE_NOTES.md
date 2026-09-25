# FINAL RELEASE NOTES — v1.2.0

This package is the manuscript-aligned final GitHub upload bundle.

## Final figures included
- Figure 1: final study workflow used in the latest manuscript.
- Figure 2: final Kaplan–Meier panels A and B, including final risk tables.
  - TCGA-CHOL: Low 16 / High 17; HR 1.13 (95% CI 0.43–2.97), P = 0.811.
  - GSE89749: Low 57 / High 58; HR 0.52 (95% CI 0.31–0.86), log-rank P = 0.010.
  - GSE89749 risk table: Low 57,19,10,3,1; High 58,28,12,7,2.
- Figure 3: final cross-cohort forest plot.
- Figure 4: final seven-strategy preprocessing sensitivity plot.

The four PNG files in `figures/` were taken directly from the latest manuscript
`OXPHOS_CCA_Scientific_Reports_MANUSCRIPT(1).docx`, so the GitHub visual files
match the manuscript version rather than an earlier plotting draft.

## Frozen analysis cohorts
- TCGA-CHOL: 33 primary tumors, 18 deaths.
- GSE89749: 115 tumors, 64 deaths.
- Hallmark OXPHOS: 200 genes.

## Provenance
The historical raw-expression preprocessing scripts were not recovered and are
not represented as original historical code. The package preserves frozen
patient-level derived data, reproducible downstream survival scripts, audit
outputs, sensitivity analyses, and the final manuscript figures.
