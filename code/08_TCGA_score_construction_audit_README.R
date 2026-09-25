# 04_TCGA_score_construction_audit_README.R
# IMPORTANT:
# This file records the TCGA score-construction specification used in the prior analysis.
# It intentionally does NOT invent missing historical source code.
#
# Frozen prior-analysis specification:
# 1) TCGA-CHOL restricted to primary solid tumor samples (sample type 01).
# 2) Usable overall-survival data -> final N=33, deaths=18.
# 3) Fixed prespecified gene set:
#       HALLMARK_OXIDATIVE_PHOSPHORYLATION (200 genes)
# 4) TCGA expression scale:
#       log2(TPM + 1)
# 5) Each OXPHOS gene was standardized across the tumor-only cohort.
# 6) Sample OXPHOS score = mean of standardized values across the fixed gene set.
# 7) Continuous score was standardized to 1 SD for Cox regression.
# 8) Median split was descriptive; no outcome-optimized cut-off was used.
#
# Exact final patient-level variables and score are preserved in:
#       ../data_derived/TCGA_tumor_only_final_survival.csv
#       ../data_derived/TCGA_tumor_only_survival_recalc_33.csv
#
# The exact verbatim historical raw-expression preprocessing script was not present
# in the recovered project files. No substitute code is fabricated here.
