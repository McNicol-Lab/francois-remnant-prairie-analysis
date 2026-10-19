# James Woodworth Prairie Remnant Prairie Study (2022–2023)

Data analysis and visualization for Junior Francois’s study of remnant prairie greenhouse gas fluxes and soil carbon stocks at the James Woodworth Prairie (JWP), University of Illinois Chicago. Supervised by Gavin McNicol (ecoϕlab).

## About

This repository takes per-date chamber flux data (concentration slopes in ppm min⁻¹) and converts them to areal GHG fluxes using the ideal gas law, then performs QA/QC, statistical analysis, and soil carbon stock estimation.

Chamber-based CO₂ and CH₄ fluxes (N₂O excluded due to poor GC precision) were measured across microtopographic zones in 2022–2023, with ancillary soil moisture, temperature, plant cover, texture, and C/N data.

Primary use: Junior Francois research / MS thesis.

## Key processing steps (in `flux-analysis.Rmd`)

1. **Data import and cleaning** — Combine per-date flux CSVs containing `slope_ppm_min`, standardize zones, and apply initial injection/slope QA/QC.
2. **Chamber metadata** — Join chamber volumes (`vol_m3`) and temperatures (K); fill missing values with means.
3. **Flux calculation (ideal gas law)** — Convert ppm min⁻¹ slopes to areal fluxes:  
   \[
   n_{\text{per ppm}} = \frac{P V}{R T} \times 10^{-6}, \quad
   F = n_{\text{per ppm}} \times \frac{\text{slope}}{60} / A
   \]
   with \(P = 1\) atm, \(R = 8.205736 \times 10^{-5}\) m³ atm mol⁻¹ K⁻¹, and chamber area from a 25.4 cm diameter. CO₂ reported in µmol m⁻² s⁻¹; CH₄ in nmol m⁻² s⁻¹.
4. **Secondary QA/QC** — Remove N₂O entirely; flag/remove extreme CH₄ outliers.
5. **Statistical analysis** — Linear models and Tukey HSD by zone, year, and month; decision trees for environmental drivers.
6. **Carbon stocks** — Integrate soil texture and C/N data, predict bulk density, and calculate SOC stocks (g cm⁻³ and Mg ha⁻¹) by depth and profile.

## Repository structure

- `data/` — Per-date flux CSVs (`slope_ppm_min`), chamber volumes/temperatures, and summary workbook  
- `env-data/` — Compiled environmental data (soil, plants, meteorology)  
- `tidy-data/` — Processed outputs (tidy fluxes, outliers, model results, SOC stocks)  
- `flux-analysis.Rmd` — Main notebook (import → ideal-gas flux conversion → QA/QC → stats → SOC stocks → figures)  
- `junior_predicted_bd.R` — Bulk density prediction script  
- `table-s8.csv` — Supplementary table  

## Key outputs

- Tidy areal flux dataset (`tidy-fluxes-all.csv`) with units, chamber metadata, and QC flags  
- Zone- and time-resolved CO₂/CH₄ flux summaries and model results  
- SOC stocks (per layer and to ~100 cm) by zone  
- Figures for flux distributions, environmental drivers, soil texture, and carbon stocks  

## Notes

Upstream GC processing (peak heights → calibrated ppm) is handled separately. This repository begins at the concentration-slope stage and performs the conversion to chamber fluxes via the ideal gas law.
