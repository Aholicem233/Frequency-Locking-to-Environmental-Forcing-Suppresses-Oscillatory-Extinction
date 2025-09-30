function dydt = fluctuate_1B(t, y, A,f,r, K0, a, Omega,alpha, delta)

    B = y(1);     
    I = y(2);    
    P = y(3);
    thre = 1e-8;
    B(B<thre) = 0;
    P(P<thre) = 0;
    I(I<thre) = 0;
    K = A*K0*sin(2*pi*t*f)+K0;
    N = sum(I)+sum(B);
    dBdt = r .* (1 - N/K) .* B - a .* B .* P;
    dIdt = a .* B .* P - alpha .* I;
    sum_bI = alpha * sum(I);
    sum_aB = sum(a .*B) * P;
    dPdt = Omega*sum_bI - sum_aB - delta * P;
    dydt = [dBdt; dIdt; dPdt];
end