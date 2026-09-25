# 05_Figure4_preprocessing_sensitivity.R
# Plots the seven frozen GSE89749 preprocessing sensitivity estimates.
library(ggplot2)

x <- read.csv("../audit_outputs/GSE89749_recalculation_sensitivity.csv", stringsAsFactors=FALSE)
x$variant <- factor(x$variant, levels=rev(x$variant))

p <- ggplot(x, aes(HR_per_SD, variant)) +
  geom_vline(xintercept=1, linetype="dashed", linewidth=0.5) +
  geom_errorbarh(aes(xmin=CI_low, xmax=CI_high), height=0.18, linewidth=0.55) +
  geom_point(size=2.2) +
  labs(x="Hazard ratio per 1-SD OXPHOS score (95% CI)", y=NULL) +
  theme_classic(base_size=9)

dir.create("../figures", showWarnings=FALSE)
ggsave("../figures/Figure4_preprocessing_sensitivity.pdf", p, width=8.2, height=5.2)
ggsave("../figures/Figure4_preprocessing_sensitivity.tiff", p, width=8.2, height=5.2,
       dpi=600, compression="lzw")
