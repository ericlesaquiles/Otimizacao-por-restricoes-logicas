# Modelo de Peso nas Asas
restricoes += [P_w_surf >= P_P_coeff2 * S,
               P_w_strc**2. >= P_P_coeff1**2./ tau**2. *
               (N_ult**2. * A ** 3. * ((P_0+V_f_fuse*g*rho_f) * P * S)),
               P_w >= P_w_surf + P_w_strc]

return restricoes
