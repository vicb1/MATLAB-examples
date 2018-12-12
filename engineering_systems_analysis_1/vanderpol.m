
function dy = vanderpol(t, y)
 dy = [y(2); -20*(y(1)^2-1)*y(2) - y(1)];
end

