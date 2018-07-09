# Modelo de peso e empuxo
restricoes += [P >= P_0 + P_a + P_f,
               P_0 + P_a + 0.5 * P_f <=
               0.5 * rho * S * C_l * V ** 2,
               P <= 0.5 * rho * S * C_lmax * V_min ** 2,
               T_voo >= Dist / V,
               LoD == C_L/C_D]
