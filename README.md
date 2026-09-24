# OXPHOS CCA reproducibility package — FROZEN

Purpose
-------
This package preserves the FINAL analysis state used for the Scientific Reports manuscript:
- TCGA-CHOL: 33 primary solid tumors (sample type 01), 18 deaths.
- GSE89749: 115 tumors with usable OS, 64 deaths.
- Prespecified MSigDB Hallmark OXPHOS set: 200 genes.
- Continuous Cox is the primary survival analysis; cohort-specific median split is descriptive.
- TCGA exploratory adjustment: age + early/advanced stage.
- GSE89749 liver-fluke sensitivity analysis retained as an audit output.

Important provenance note
-------------------------
The exact verbatim historical raw-expression preprocessing scripts were NOT present among the
recovered project files. To avoid silently changing the prior analysis, this package does NOT
invent replacement preprocessing code and does NOT rerun the old 41-case analysis.

Instead it contains:
1. the exact final patient-level derived datasets recovered from the analysis;
2. R scripts that rerun the final survival models from those frozen datasets;
3. the saved mapping/preprocessing/sensitivity audit outputs;
4. audit-note R files documenting the exact preprocessing specification used previously.

This distinction is deliberate: it preserves the prior analysis record without pretending that
newly written code is the original historical script.

Run order
---------
From the `code/` directory:
1. Rscript 01_TCGA_CHOL_final33_survival.R
2. Rscript 02_GSE89749_final115_survival.R
3. Inspect 03_GSE89749_preprocessing_audit_README.R
4. Inspect 04_TCGA_score_construction_audit_README.R
5. Rscript 05_fluke_sensitivity_FROZEN.R

Required R package
------------------
survival

Final manuscript targets
------------------------
TCGA continuous: HR 1.1681 (0.7475–1.8254), P=0.4951
TCGA high vs low: HR 1.1252 (0.4268–2.9663), P=0.8115
TCGA adjusted: HR 1.6429 (0.9062–2.9785), P=0.1019
GSE89749 continuous: HR 0.7533 (0.5986–0.9479), P=0.01566
GSE89749 high vs low: HR 0.5180 (0.3118–0.8607), log-rank P=0.0097

Do not mix in the older 41-case TCGA analysis.
