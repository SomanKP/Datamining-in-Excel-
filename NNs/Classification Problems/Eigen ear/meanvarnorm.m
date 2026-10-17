function [res]=meanvarnorm(a,md,vd)
m=mean(a);
v=sqrt(var(a));
vd=sqrt(vd);
delta=abs((a-m)*vd/v);
res=ones(1,length(a))*md;
[p]=quantiz(a,m);
%p=p';
p=p*2-1;
size(p)
size(delta)
size(res)
res=res+p.*delta;
end