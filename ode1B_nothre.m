function dydt = ode1B_nothre(t, y, r, K, a, Omega,alpha, delta)

    B = y(1);     % 
    I = y(2);     % 
    P = y(3);
    N = sum(I)+sum(B);
    dBdt = r .* (1 - N/K) .* B - a .* B .* P;
    dIdt = a .* B .* P - alpha .* I;
    sum_bI = alpha * sum(I);
    sum_aB = sum(a .*B) * P;
    dPdt = Omega*sum_bI - sum_aB - delta * P;
    dydt = [dBdt; dIdt; dPdt];
end
