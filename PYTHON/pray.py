def tryyy(y_train):
    p = d = q = range(0, 2)

    pdq = list(itertools.product(p, d, q))
    seasonal_pdq = [(x[0], x[1], x[2], 12) for x in list(itertools.product(p, d, q))]

    best_aic = np.inf
    best_params = None
    best_seasonal_params = None
    
    for pdq_params in pdq:
        for seasonal_params in seasonal_pdq:
            try:
                model = SARIMAX(y_train,
                                order=pdq_params,
                                seasonal_order=seasonal_params)
                result = model.fit()
                print("SARIMAX({}x{})-AIC: {}".format(pdq_params, seasonal_params, result.aic))
                
                if result.aic < best_aic:
                    best_aic = result.aic
                    best_params = pdq_params
                    best_seasonal_params = seasonal_params
            except:
                continue
                
    return best_params, best_seasonal_params

best_params, best_seasonal_params = tryyy(y_train)
print(best_params)




##


def tryyy(y_train):
    p = d = q = range(0, 3)  # Expand range for more options

    pdq = list(itertools.product(p, d, q))
    seasonal_pdq = [(x[0], x[1], x[2], 12) for x in list(itertools.product(p, d, q))]

    # Additional parameters for optimization
    trends = ['n', 'c', 't', 'ct']
    initialization_methods = ['css', 'innovations']
    solvers = ['lbfgs', 'bfgs', 'powell']
    max_iter = [50, 100, 200]
    alphas = [0.0, 0.1, 0.5, 1.0]
    l1_ratios = [0.0, 0.25, 0.5, 0.75, 1.0]
    exog = None  # Add exogenous variables if available

    best_aic = np.inf
    best_params = None
    best_seasonal_params = None
    best_trend = None
    best_initialization_method = None
    best_solver = None
    best_max_iter = None
    best_alpha = None
    best_l1_ratio = None

    for trend in trends:
        for initialization_method in initialization_methods:
            for solver in solvers:
                for max_iter in max_iters:
                    for alpha in alphas:
                        for l1_ratio in l1_ratios:
                            for pdq_params in pdq:
                                for seasonal_params in seasonal_pdq:
                                    try:
                                        model = SARIMAX(y_train,
                                                        order=pdq_params,
                                                        seasonal_order=seasonal_params,
                                                        trend=trend,
                                                        initialization_method=initialization_method,
                                                        solver=solver,
                                                        max_iter=max_iter,
                                                        alpha=alpha,
                                                        l1_ratio=l1_ratio,
                                                        exog=exog)
                                        result = model.fit()
                                        print("SARIMAX({}x{})-AIC: {}".format(pdq_params, seasonal_params, result.aic))

                                        if result.aic < best_aic:
                                            best_aic = result.aic
                                            best_params = pdq_params
                                            best_seasonal_params = seasonal_params
                                            best_trend = trend
                                            best_initialization_method = initialization_method
                                            best_solver = solver
                                            best_max_iter = max_iter
                                            best_alpha = alpha
                                            best_l1_ratio = l1_ratio
                                    except:
                                        continue

    return best_params, best_seasonal_params, best_trend, best_initialization_method, best_solver, best_max_iter, best_alpha, best_l1_ratio

best_params, best_seasonal_params, best_trend, best_initialization_method, best_solver, best_max_iter, best_alpha, best_l1_ratio = tryyy(y_train)
print("Best Parameters:")
print("  (p, d, q):", best_params)
print("  (P, D, Q, s):", best_seasonal_params)
print("  Trend:", best_trend)
print("  Initialization Method:", best_initialization_method)
print("  Solver:", best_solver)
print("  Max Iterations:", best_max_iter)
print("  Alpha:", best_alpha)
print("  L1 Ratio:", best_l1_ratio)
