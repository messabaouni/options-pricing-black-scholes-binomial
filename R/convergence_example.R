source("R/options.R")
library(ggplot2)

plot_convergence <- function(S, K, r, T, sigma, type, max_steps = 100) {
  steps <- 1:max_steps
  tree <- sapply(steps, function(n) binomial_option_price(S, K, r, T, sigma, n, type))
  bs <- black_scholes(S, K, r, T, sigma, type)
  ggplot(data.frame(steps, tree), aes(steps, tree)) +
    geom_line(color = "steelblue", linewidth = 1) +
    geom_hline(yintercept = bs, linetype = "dashed", color = "darkred", linewidth = 1) +
    labs(title = paste("Binomial tree convergence to Black-Scholes (", type, ")", sep = ""),
         x = "Number of steps", y = "Option price") +
    theme_minimal()
}

dir.create("figures", showWarnings = FALSE)
ggsave("figures/convergence_call.png", plot_convergence(100, 100, 0.05, 1, 0.20, "call"), width = 7, height = 5)
ggsave("figures/convergence_put.png", plot_convergence(80, 80, 0.03, 1, 0.10, "put"), width = 7, height = 5)
