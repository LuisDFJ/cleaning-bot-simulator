function M = line_equation( P1, P2 )
    m = P2 - P1;
    c = m(1) * P1(1) + m(2) * P1(2);
    M = [ m(1), m(2), -c ];
end