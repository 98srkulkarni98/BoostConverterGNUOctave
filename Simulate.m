function y = Simulate(t,x0,Hop,Aon,Aoff,Bu,uz,Bl,il)

  Hop_on=Hop(1,1);
  Hop_off=Hop(2,1);
  Hop_p=Hop(3,1);

  on_flag=1;
  off_flag=0;
  first_itr=1;
  itr_count =0;
  new_t=[];
  y=[];
  while itr_count < round(length(t)/Hop_p)
      if(on_flag == 1)
        change_in_time = t(itr_count*Hop_p+1:itr_count*Hop_p+Hop_on,1);
        ## new_t = cat(1,new_t,change_in_time);

        ## Solve ODE in change_int_time
        y1 = lsode (@(x,t)f(x,t,Aon,Bu,uz,Bl,il), x0, change_in_time);
        y=cat(1,y,y1);

        ## Update of initial vector for next integration
        x0=[y(end,1);y(end,2)];

        on_flag=0;off_flag=1;
      endif
      if(off_flag==1)
        change_in_time = t(itr_count*Hop_p+Hop_on+1:(itr_count+1)*Hop_p,1);
        ## new_t = cat(1,new_t,change_in_time);

        ## Solve ODE in change_int_time
        y1 = lsode (@(x,t)f(x,t,Aoff,Bu,uz,Bl,il), x0, change_in_time);
        y=cat(1,y,y1);

        ## Update of initial vector for next integration
        x0=[y(end,1);y(end,2)];

        off_flag=0;on_flag=1;
      endif

    itr_count=itr_count+1;
  endwhile


