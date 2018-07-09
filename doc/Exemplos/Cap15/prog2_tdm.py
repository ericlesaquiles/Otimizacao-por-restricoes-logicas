# Modelo de Impulso e Arrasto
C_D_fuse = CDA0 / S
C_D_wpar = k * C_f * S_wetratio
C_D_ind  = C_l ** 2 / (np.pi * A * e)
restricoes += [P_f >= CEUE * T_voo * D,
               D >= 0.5 * rho * S * C_D * V ** 2,
               C_D >= C_D_fuse + C_D_wpar + C_D_ind,
               V_f_fuse <= 10*units('m')*CDA0,
               Re <= (rho / mu) * V * (S / A) ** 0.5,
               C_f >= 0.074 / Re ** 0.2]
