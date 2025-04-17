function xdot = f (x, t, A, Bu, uz, Bl, il)

  xdot = zeros (2,1);

  xdot = A*[x(1);x(2)]+Bu*uz+Bl*il;

endfunction
