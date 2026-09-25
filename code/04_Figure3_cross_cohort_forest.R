# 04_Figure3_cross_cohort_forest.R
library(ggplot2)

x <- read.csv("../audit_outputs/OXPHOS_final_statistical_results.csv", stringsAsFactors=FALSE)
x$label <- c("TCGA: continuous per SD", "TCGA: high vs low", "TCGA: adjusted per SD",
             "GSE89749: continuous per SD", "GSE89749: high vs low")
x$label <- factor(x$label, levels = rev(x$label))

p <- ggplot(x, aes(HR, label)) +
  geom_vline(xintercept=1, linetype="dashed", linewidth=0.5) +
  geom_errorbarh(aes(xmin=CI_low, xmax=CI_high), height=0.18, linewidth=0.55) +
  geom_point(size=2.2) +
  scale_x_log10() +
  labs(x="Hazard ratio (95% CI)", y=NULL) +
  theme_classic(base_size=10)

dir.create("../figures", showWarnings=FALSE)
ggsave("../figures/Figure3_cross_cohort_forest.pdf", p, width=7.2, height=4.6)
ggsave("../figures/Figure3_cross_cohort_forest.tiff", p, width=7.2, height=4.6,
       dpi=600, compression="lzw")
