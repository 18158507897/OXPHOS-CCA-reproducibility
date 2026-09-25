# 03_Figure2_KM_FINAL.R
# Reconstructs the final manuscript Figure 2A/2B from frozen patient-level data.
# GSE89749 survival time is stored in months in the frozen derived table and is
# converted to days (30.4375 days/month) ONLY for Figure 2 display. This linear
# unit conversion does not alter Cox HRs or log-rank P values.

library(survival)
library(ggplot2)
library(grid)
library(gridExtra)

dir.create("../figures", showWarnings = FALSE)

make_km_panel <- function(dat, time_col, event_col, high_col, breaks, xmax,
                          x_label, annotation_x, output_stem,
                          time_multiplier = 1, y_label = "Survival   probability") {
  dat$plot_time <- as.numeric(dat[[time_col]]) * time_multiplier
  dat$event2 <- as.integer(dat[[event_col]])
  dat$group <- factor(ifelse(as.integer(dat[[high_col]]) == 1, "High", "Low"),
                      levels = c("Low", "High"))

  fit <- survfit(Surv(plot_time, event2) ~ group, data = dat)
  cox <- coxph(Surv(plot_time, event2) ~ group, data = dat)
  cs <- summary(cox)
  hr <- cs$conf.int[1, "exp(coef)"]
  lo <- cs$conf.int[1, "lower .95"]
  hi <- cs$conf.int[1, "upper .95"]
  lr <- survdiff(Surv(plot_time, event2) ~ group, data = dat)
  p_lr <- 1 - pchisq(lr$chisq, df = 1)

  ss <- summary(fit)
  curve <- data.frame(time = ss$time, surv = ss$surv,
                      group = sub("group=", "", ss$strata))
  curve <- rbind(data.frame(time = c(0,0), surv = c(1,1),
                            group = c("Low","High")), curve)
  curve$group <- factor(curve$group, levels = c("Low","High"))

  rs <- summary(fit, times = breaks, extend = TRUE)
  risk <- data.frame(time = rs$time,
                     group = sub("group=", "", rs$strata),
                     n = rs$n.risk)
  risk$group <- factor(risk$group, levels = c("High","Low"))

  ann <- sprintf("HR = %.2f (95%% CI %.2f–%.2f)\nLog-rank P = %.3f",
                 hr, lo, hi, p_lr)

  p_main <- ggplot(curve, aes(time, surv, linetype = group, group = group)) +
    geom_step(linewidth = 0.65) +
    scale_linetype_manual(values = c(Low = "solid", High = "dashed"),
                          breaks = c("Low","High")) +
    scale_x_continuous(breaks = breaks, limits = c(0, xmax), expand = c(0,0)) +
    scale_y_continuous(breaks = seq(0,1,0.2), limits = c(0,1.05)) +
    annotate("text", x = annotation_x, y = 0.18, label = ann,
             hjust = 0, size = 3.5) +
    labs(x = NULL, y = y_label, linetype = "OXPHOS score") +
    theme_classic(base_size = 10) +
    theme(axis.title.x = element_blank(),
          axis.title.y = element_text(size = 10, margin = margin(r = 12)),
          axis.text = element_text(size = 9),
          legend.position = c(0.84, 0.88),
          legend.title = element_text(size = 10, face = "bold"),
          legend.text = element_text(size = 9),
          legend.background = element_blank(),
          plot.margin = margin(10,15,3,18))

  p_risk <- ggplot(risk, aes(time, group, label = n)) +
    geom_text(size = 3.5) +
    scale_x_continuous(breaks = breaks, limits = c(0, xmax), expand = c(0,0)) +
    labs(title = "Number at risk", x = x_label, y = NULL) +
    coord_cartesian(clip = "off") +
    theme_classic(base_size = 10) +
    theme(plot.title = element_text(size = 10, face = "bold", hjust = 0),
          axis.text.y = element_text(size = 9, margin = margin(r = 25)),
          axis.text.x = element_text(size = 9),
          axis.title.x = element_text(size = 10, margin = margin(t = 8)),
          axis.title.y = element_blank(), axis.line.y = element_blank(),
          axis.ticks.y = element_blank(), legend.position = "none",
          plot.margin = margin(0,15,8,35))

  final <- arrangeGrob(p_main, p_risk, ncol = 1, heights = c(3.7, 1.15))
  ggsave(paste0("../figures/", output_stem, ".pdf"), final,
         width = 7.5, height = 6.2, units = "in")
  ggsave(paste0("../figures/", output_stem, ".tiff"), final,
         width = 7.5, height = 6.2, units = "in", dpi = 600, compression = "lzw")
  write.csv(risk, paste0("../audit_outputs/", output_stem, "_number_at_risk.csv"), row.names = FALSE)
  invisible(list(plot = final, risk = risk, HR = hr, CI = c(lo,hi), logrank_P = p_lr))
}

tcga <- read.csv("../data_derived/TCGA_tumor_only_final_survival.csv", check.names=FALSE)
stopifnot(nrow(tcga)==33, sum(tcga$os_event)==18)
res_A <- make_km_panel(tcga, "os_days", "os_event", "high",
                       c(0,500,1000,1500,2000), 2050,
                       "Overall survival (days)", 250,
                       "Figure2A_TCGA_CHOL_FINAL")

gse <- read.csv("../data_derived/GSE89749_OXPHOS_validation.csv", check.names=FALSE)
stopifnot(nrow(gse)==115, sum(gse$event)==64)
res_B <- make_km_panel(gse, "time", "event", "high",
                       c(0,600,1200,1800,2400), 2500,
                       "Overall survival (days)", 300,
                       "Figure2B_GSE89749_FINAL", time_multiplier = 30.4375)

print(res_A$risk)
print(res_B$risk)
