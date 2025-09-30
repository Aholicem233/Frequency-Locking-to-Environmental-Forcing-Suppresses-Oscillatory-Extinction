function F = findpo(yout, t, tmax)
% Poincaré section function


B = yout(:,1);
I = yout(:,2);
P = yout(:,3);

% === Use the average value of P as the cross-sectional value ===
section_value_P = mean(P); 

B_section = [];
I_section = [];
P_section = [];

for i = 2:length(P)-1
    if P(i-1) < section_value_P && P(i) >= section_value_P
        B_section = [B_section; B(i)];
        I_section = [I_section; I(i)];
        P_section = [P_section; P(i)]; 
    end
end

% ===Visualization===
figure;

if ~isempty(B_section) && ~isempty(I_section)
    plot(B_section, I_section, 'ro', 'MarkerSize', 3.5, 'MarkerFaceColor', 'r');
else
    plot(0,0,'ko'); 
end
xlabel('B');
ylabel('I');

box on;

F.B_section = B_section;
F.I_section = I_section;
F.P_section = P_section;
F.section_value_P = section_value_P;
end