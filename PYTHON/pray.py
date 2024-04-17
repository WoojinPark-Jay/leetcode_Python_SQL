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
