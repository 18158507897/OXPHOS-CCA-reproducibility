# 05_fluke_sensitivity_FROZEN.R
# The prior analysis produced the following frozen liver-fluke sensitivity results:
# Overall:        N=115, deaths=64, HR/SD=0.7532625, P=0.0156584
# Fluke-negative: N=65,  deaths=25, HR/SD=0.7156887, P=0.1899809
# Fluke-positive: N=50,  deaths=39, HR/SD=0.9061745, P=0.4806136
# Score-by-fluke interaction P reported in the manuscript audit: 0.426.
#
# Patient-level fluke labels were not present in the recovered final 115-row score file.
# Therefore this script does not reconstruct or alter subgroup membership.
# The exact saved subgroup output is read and printed below.

x <- read.csv("../audit_outputs/GSE89749_OXPHOS_fluke_sensitivity.csv",
              stringsAsFactors=FALSE)
print(x)
interaction_P <- 0.426
print(interaction_P)
