black_scholes <- function(S, K, r, T, sigma, type = "call") {
  d1 <- (log(S / K) + (r + 0.5 * sigma^2) * T) / (sigma * sqrt(T))
  d2 <- d1 - sigma * sqrt(T)
  if (type == "call") {
    S * pnorm(d1) - K * exp(-r * T) * pnorm(d2)
  } else {
    K * exp(-r * T) * pnorm(-d2) - S * pnorm(-d1)
  }
}

# Cox-Ross-Rubinstein binomial tree (European option)
binomial_option_price <- function(S, K, r, T, sigma, steps, type = "call") {
  dt <- T / steps
  u <- exp(sigma * sqrt(dt))
  d <- 1 / u
  p <- (exp(r * dt) - d) / (u - d)
  asset_prices <- S * u^(0:steps) * d^(steps - 0:steps)
  option_values <- if (type == "call") pmax(asset_prices - K, 0) else pmax(K - asset_prices, 0)
  for (j in (steps - 1):0) {
    for (i in 0:j) {
      option_values[i + 1] <- exp(-r * dt) * (p * option_values[i + 2] + (1 - p) * option_values[i + 1])
    }
  }
  option_values[1]
}
