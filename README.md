# James Woodworth Prairie Remnant Prairie Study (2022–2023)

Data analysis and visualization for Junior Francois’s study of remnant prairie greenhouse gas fluxes and soil carbon stocks at the James Woodworth Prairie (JWP), University of Illinois Chicago. Supervised by Gavin McNicol (ecoϕlab).

## About

Chamber-based CO₂ and CH₄ fluxes (N₂O excluded due to poor GC precision) collected across microtopographic zones in 2022–2023, with ancillary soil moisture, temperature, plant cover, texture, and C/N data. Includes QA/QC, flux calculations, statistical modeling (linear models + Tukey HSD, decision trees), bulk density prediction, and soil organic carbon stock estimation.

Primary use: Junior Francois research / MS thesis.

## Repository structure

- `data/` — Per-date flux CSVs, chamber volumes/temperatures, and summary workbook  
- `env-data/` — Compiled environmental data (soil, plants, meteorology)  
- `tidy-data/` — Processed outputs (tidy fluxes, outliers, model results, SOC stocks)  
- `flux-analysis.Rmd` — Main analysis notebook (data wrangling → QA/QC → stats → SOC stocks → figures)  
- `junior_predicted_bd.R` — Bulk density prediction script  
- `table-s8.csv` — Supplementary table  

## Key outputs

- Tidy flux dataset and outlier flags  
- Zone- and time-resolved CO₂/CH₄ flux summaries and model results  
- SOC stocks (per layer and to ~100 cm) by zone  
- Figures for flux distributions, environmental drivers, soil texture, and carbon stocks  

## Notes

Flux processing upstream of this analysis (GC peak heights → ppm → chamber fluxes) is handled in the companion pipeline repository.
