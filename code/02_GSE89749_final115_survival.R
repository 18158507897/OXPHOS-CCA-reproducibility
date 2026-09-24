# 02_GSE89749_final115_survival.R
# FROZEN REPRODUCTION OF THE FINAL GSE89749 SURVIVAL ANALYSIS.
# Reads the exact audited 115-case score/survival table from the prior analysis.
#
# Expected manuscript results:
# N=115, deaths=64
# continuous OXPHOS per SD: HR 0.7533, 95% CI 0.5986-0.9479, P=0.01566
# median high vs low: HR 0.5180, 95% CI 0.3118-0.8607; log-rank P=0.0097

library(survival)

dat <- read.csv("../data_derived/GSE89749_OXPHOS_validation.csv",
                check.names=FALSE, stringsAsFactors=FALSE)

stopifnot(nrow(dat) == 115)
stopifnot(sum(dat$event, na.rm=TRUE) == 64)

# Preserve audited final variables exactly.
dat$score_sd <- as.numeric(dat$score_sd)
dat$high <- as.integer(dat$high)

fit_cont <- coxph(Surv(time, event) ~ score_sd, data=dat)
print(summary(fit_cont))

fit_group <- coxph(Surv(time, event) ~ high, data=dat)
print(summary(fit_group))

km <- survfit(Surv(time, event) ~ high, data=dat)
print(km)
lr <- survdiff(Surv(time, event) ~ high, data=dat)
logrank_p <- 1 - pchisq(lr$chisq, df=1)
print(logrank_p)

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
  cbind(analysis="continuous_per_SD", extract_cox(fit_cont,"score_sd")),
  cbind(analysis="high_vs_low", extract_cox(fit_group,"high"))
)
out$logrank_P <- c(NA, logrank_p)
write.csv(out, "../audit_outputs/GSE89749_R_rerun_results.csv", row.names=FALSE)
