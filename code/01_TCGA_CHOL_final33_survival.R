# 01_TCGA_CHOL_final33_survival.R
# FROZEN REPRODUCTION OF THE FINAL 33-PATIENT TCGA-CHOL SURVIVAL ANALYSIS.
# This script does NOT redefine the score or cohort. It reads the audited final dataset
# produced during the prior analysis and reruns the reported survival models.
#
# Expected manuscript results:
# N=33, deaths=18
# continuous OXPHOS per SD: HR 1.1681, 95% CI 0.7475-1.8254, P=0.4951
# median high vs low: HR 1.1252, 95% CI 0.4268-2.9663, P=0.8115
# adjusted OXPHOS per SD: HR 1.6429, 95% CI 0.9062-2.9785, P=0.1019

library(survival)

dat <- read.csv("../data_derived/TCGA_tumor_only_final_survival.csv",
                check.names = FALSE, stringsAsFactors = FALSE)

stopifnot(nrow(dat) == 33)
stopifnot(sum(dat$os_event, na.rm=TRUE) == 18)

# Preserve the final audited variables exactly.
dat$score_z <- as.numeric(dat$score_z)
dat$high <- as.integer(dat$high)
dat$age_years <- as.numeric(dat$age_years)
dat$stage_advanced <- as.integer(dat$stage_advanced == "Advanced")
stopifnot(!anyNA(dat$stage_advanced))

# Primary continuous Cox analysis (per 1-SD OXPHOS score)
fit_cont <- coxph(Surv(os_days, os_event) ~ score_z, data=dat)
print(summary(fit_cont))

# Prespecified descriptive median split already stored in the frozen audit dataset.
fit_group <- coxph(Surv(os_days, os_event) ~ high, data=dat)
print(summary(fit_group))

# Kaplan-Meier / two-sided log-rank
km <- survfit(Surv(os_days, os_event) ~ high, data=dat)
print(km)
lr <- survdiff(Surv(os_days, os_event) ~ high, data=dat)
logrank_p <- 1 - pchisq(lr$chisq, df=1)
print(logrank_p)

# Exploratory adjusted model used in the final manuscript:
# age + binary early/advanced stage.
fit_adj <- coxph(Surv(os_days, os_event) ~ score_z + age_years + stage_advanced,
                 data=dat)
print(summary(fit_adj))

# Export exact rerun summaries
extract_cox <- function(fit, term) {
  s <- summary(fit)
  i <- match(term, rownames(s$coefficients))
  data.frame(
    term=term,
    HR=s$conf.int[i,"exp(coef)"],
    CI_low=s$conf.int[i,"lower .95"],
    CI_high=s$conf.int[i,"upper .95"],
    P=s$coefficients[i,"Pr(>|z|)"]
  )
}
out <- rbind(
  cbind(analysis="continuous_per_SD", extract_cox(fit_cont,"score_z")),
  cbind(analysis="high_vs_low", extract_cox(fit_group,"high")),
  cbind(analysis="adjusted_per_SD", extract_cox(fit_adj,"score_z"))
)
write.csv(out, "../audit_outputs/TCGA_R_rerun_results.csv", row.names=FALSE)
