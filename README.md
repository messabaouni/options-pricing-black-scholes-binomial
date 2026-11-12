# Option Pricing: Black-Scholes and Binomial Trees

Coursework for *Quantitative Finance* (MESIO UPC-UB, 2025), written in R.
It implements European option pricing in two ways and shows that the binomial tree converges to the Black-Scholes price as the number of steps grows.

- **Black-Scholes** closed-form price for calls and puts
- **Cox-Ross-Rubinstein binomial tree**, with `u = exp(σ√Δt)`, `d = 1/u` and risk-neutral probability `p = (e^{rΔt} − d)/(u − d)`
- Convergence plots for a call (S=K=100, r=5%, σ=20%, T=1) and a put (S=K=80, r=3%, σ=10%, T=1)

## Structure
```
R/options.R               pricing functions
R/convergence_example.R   generates the convergence plots into figures/
slides/                   presentation source (R Markdown, in Spanish)
docs/slides.html          rendered presentation
```

## Usage
```r
source("R/options.R")
black_scholes(100, 100, 0.05, 1, 0.2, "call")
binomial_option_price(100, 100, 0.05, 1, 0.2, steps = 500, type = "call")
```
Requires R with `ggplot2` for the plots. Run `Rscript R/convergence_example.R` from the repository root.

## What the results show
A binomial tree prices an option by stepping the asset price up or down at each time step and discounting back from expiry. With few steps the price oscillates around the Black-Scholes value, and as steps increase the tree price converges to the closed-form value. The plots in the slides (`docs/slides.html`) show this for a call and a put.

## Authors
Mohammed Essabaouni and Joel Bravo
