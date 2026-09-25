# 03_GSE89749_preprocessing_audit_README.R
# IMPORTANT:
# This file records the preprocessing specification used in the prior analysis.
# It intentionally does NOT invent missing historical source code.
#
# Frozen prior-analysis specification:
# 1) Platform: Illumina HumanHT-12 v4.
# 2) Hallmark set: HALLMARK_OXIDATIVE_PHOSPHORYLATION, 200 genes.
# 3) Mapping audit: 179 direct symbols + 21 historical-symbol harmonizations = 200/200.
# 4) Expression processing used for the final score:
#       log2 transformation
#       quantile normalization
#       tumor-level expression matrix
#       gene-wise standardization
#       sample-wise mean across the same 200-gene Hallmark OXPHOS set
# 5) The final audited patient-level score is in:
#       ../data_derived/GSE89749_OXPHOS_validation.csv
# 6) Multiple preprocessing variants were audited. Their exact saved results are in:
#       ../audit_outputs/GSE89749_recalculation_sensitivity.csv
#       ../audit_outputs/GSE89749_recalculated_scores.csv
# 7) Unnormalized signal did not reproduce the final association.
#
# The exact verbatim historical preprocessing script was not present in the recovered
# project files. Therefore no replacement preprocessing code is inserted here.
# This protects the record from silently changing the prior analysis.
