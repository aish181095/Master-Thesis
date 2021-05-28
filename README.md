# Using SIDARTHE model to study the epidemic evolution and analyse different strategies to contain the COVID 19 spread in Italy.


italy_data_phase - Import and divide the data based on the phase
sidartheode.m and Curvefit_model.m files- Implementing the SIDARTHE model 
fitting_code.m - Curve fitting optimisation function for 100 start values
regression_co-efficient - Goodness of fit for the fitted model compared to actual cases
parameter_distribution.m - Generate parameter distributions for each model parameter and calculate the 97.5% Confidence intervals.
sensitivity_analysis.m - Analyse sensitivity of parameter devaition on model equilibria
plots.m - Generate plots for model fit, parameter distribution.
strategies_implemented.m - Different control strategies implemented using Curvefit_model.m(Acquired immunity) and Sidarthe_analysis ( Lockdown and mass testing policies)

Batch scripts :- covidparameter.sh and param_dist.sh were used to run the fitting_code.m and the parameter_distribution.m scripts on the RWTH Compute Cluster, RWTH Aachen University. 
