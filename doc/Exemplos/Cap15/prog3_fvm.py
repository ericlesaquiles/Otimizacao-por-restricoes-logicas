# Modelo de Volume de Combustível
with SignomialsEnabled():
    restricoes +=[V_c == P_c / g / rho_c,
                   V_c_wing**2 <= 0.0009*S**3/A*tau**2, 
                   # linear em b e tau, quadratico em chord
                   V_c_disp <= V_c_wing + V_c_fuse, #[SP]
                   V_c_disp >= V_c]
