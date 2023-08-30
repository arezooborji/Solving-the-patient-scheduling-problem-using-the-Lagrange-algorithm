********* Base Model ********
Set
Scenario
/
scen1
scen2
scen3
/
;

sets
p /1*30/
r /1*20/
n /1*15/
k /1*10/
d /1*10/
w /1*10/
s /1*10/
g /1*10/



;
Parameters
Prob(Scenario)
/
scen1 0.3
scen2 0.4
scen3 0.3
/;
parameter ad(p,Scenario);

parameters
pen_sc1 /5/
pen_sc2 /10/
pen_sc3 /5/
pen_sc4 /10/
pen_sc5 /0.8/
pen_sc6 /1/
pen_sc7 /1/
pen_sc8 /2/
pen_sc9 /11/
q(r)
*ad(p)
dd(p)
los(p)
age(p)
min_age(d)
max_age(d)
prf(p,k)
rrf(r,k)
pg(p,g)
rg(r,g)
rrt(r,w)
prt(p,w)
preq(p)
single(r)
psn(p,s,n)
rs(r,s)
srpref(r,s)
pprefrf(p,k)
adm_plan(p,n)
rd(r,d)
ps(p,s)
;
q(r)=5;

ad(p,'scen2')=1;
ad(p,'scen1')=1.2*ad(p,'scen2');
ad(p,'scen3')=1.8*ad(p,'scen2');
dd(p)=100;
*los(p)=dd(p)- ad(p);
age(p)= uniform(45,60);
min_age(d)=45;
max_age(d)=60;
prf(p,k)=1;
rrf(r,k)=1;
pg(p,g)=2;
rg(r,g)=1;
rrt(r,w)=2;
prt(p,w)=1;
preq(p)=1;
single(r)=1;
psn(p,s,n)=2;
rs(r,s)=1.6;
srpref(r,s)=1.5;
pprefrf(p,k)=2;
adm_plan(p,n)=1;
ps(p,s)=1;

loop(Scenario,
los(p)=dd(p)- ad(p,Scenario);
);
table rd(r,d)
         1       2
1        1
2                1
;
binary variables
s_sc1_nd(p,r,n)
s_sc1_dr(r,n)
s_sc2(p,r,n)
s_sc3(p,r,n,k)
s_sc4(p,r,n)
s_sc5(p,n)
s_sc6(p,r,n)
s_sc8(p,r,n,k)
t(p,r,n,Scenario)
x(p,r,n)
y(r,n)
pr(p,r)
;

positive variable
s_sc7(p,r,n)
;
variables
z
s1
s2
s3
s4
s5
s6
s7
s8
s9(Scenario)
*pr(p,r)
;

equations
e1
e2
e4
e5
e6
e7
e8
e9
e10
e11(r,n)
e12(p,n)
e13(p,n)
e14(p,r,n,g)
e15(p,r,n)
e17(p,r,n,d)
e18(p,r,n,d)
e19(p,r,n,k)
e20(p,r,n,w)
e21(p,r,n)
e22(p,r,n,s)
e23(p,r,n,s)
e24(p,r,n,k)
e25
e26(p,r)
e27 (p)
;

e1..   z=e=-1*(sum(Scenario,prob(Scenario)*(s1+s3+s4+s5+s6+s7+s8+s9(Scenario))));
e2..     s1=e=sum((p,n,r),(s_sc1_nd(p,r,n)+s_sc1_dr(r,n))*pen_sc1);
e4..     s3=e=sum((p,r,n,k),s_sc3(p,r,n,k)*pen_sc3);
e5..     s4=e=sum((p,r,n),s_sc4(p,r,n)*pen_sc4);
e6..     s5=e=sum((p,n),s_sc5(p,n)*pen_sc5);
e7..     s6=e=sum((p,r,n),s_sc6(p,r,n)*pen_sc6);
e8..     s7=e=sum((p,r,n),s_sc7(p,r,n)*pen_sc7);
e9..     s8=e=sum((p,r,n,k),s_sc8(p,r,n,k)*pen_sc8);

e10(Scenario)..    s9(Scenario)=e=sum((p,r,n),t(p,r,n,Scenario)*pen_sc9);

e11(r,n)..       sum(p,x(p,r,n))=l=q(r);

e12(p,n)..       sum(r,x(p,r,n))=e=adm_plan(p,n);

e13(p,n)..       sum(r,x(p,r,n))=l=1;

e14(p,r,n,g)..   pg(p,g)*x(p,r,n)=l=rg(r,g)+s_sc1_nd(p,r,n);

e15(p,r,n)..     x(p,r,n)=l=y(r,n)+s_sc1_dr(r,n);

e17(p,r,n,d)..   age(p)=g=min_age(d)*x(p,r,n)+(min_age(d)-age(p))*s_sc2(p,r,n);

e18(p,r,n,d)..   age(p)=l=max_age(d)+(age(p)-max_age(d))*s_sc2(p,r,n);

e19(p,r,n,k)..   prf(p,k)*x(p,r,n)=l=rrf(r,k)+s_sc3(p,r,n,k);

e20(p,r,n,w)..   rrt(r,w)*x(p,r,n)=l=prt(p,w)+s_sc5(p,n);

e21(p,r,n)..     preq(p)*x(p,r,n)=l=single(r)+s_sc4(p,r,n);

e22(p,r,n,s)..   ps(p,s)*x(p,r,n)=l=rs(r,s)+s_sc6(p,r,n);

e23(p,r,n,s)..   srpref(r,s)*x(p,r,n)=l=1+s_sc7(p,r,n);

e24(p,r,n,k)..   pprefrf(p,k)*x(p,r,n)=l=rrf(r,k)+s_sc8(p,r,n,k);

e25(p,r,n,Scenario)$(ord(n)<>ad(p,Scenario))..     t(p,r,n,Scenario)=g=x(p,r,n)-x(p,r,n-1);

e26(p,r)..sum(n,x(p,r,n))=l=Los(p)*pr(p,r);

e27(p)..sum(r,pr(p,r))=l=1;

model  Patient_Admission_Scheduling
/
e1
e2
e4
e5
e6
e7
e8
e9
e10
e11
e12
e13
e14
e15
e17
e18
e19
e20
e21
e22
e23
e24
e25
e26
e27
/
;

option optca=0;
option optcr=0;

*solve Patient_Admission_Scheduling using mip max z;

*---------------------------------------------------------------------
* Lagrangian dual
* Let assign be the complicating constraint
*---------------------------------------------------------------------

sets
iter /1*1/
;

parameters
u14(p,r,n,g)
u23(p,r,n,s)
u24(p,r,n,k)
u25(p,r,n,Scenario)
u14_previous(p,r,n,g)
u23_previous(p,r,n,s)
u24_previous(p,r,n,k)
u25_previous(p,r,n,Scenario)
results(iter,*)
gama1(p,r,n,g)
gama2(p,r,n,s)
gama3(p,r,n,k)
gama4(p,r,n,Scenario)
gamma1
gamma2
gamma3
gamma4
deltau14(p,r,n,g)
deltau23(p,r,n,s)
deltau24(p,r,n,k)
deltau25(p,r,n,Scenario)
results(iter,*)
deltau
;

variable
bound
;

equation
LR 'lagrangian relaxation'
test
;

scalars
noimprovement /0/
bestbound /+INF/
continue /1/
m /1/
stepsize /0.5/
lowerbound /-20000/
theta /0.5/
u14hat
u23hat
u24hat
u25hat
;

u25hat = 0;

LR.. bound =e=-1*(sum(Scenario,prob(Scenario)*(s1+s3+s4+s5+s6+s7+s8+s9(Scenario))))
-sum((p,r,n,g),u14(p,r,n,g)*(pg(p,g)*x(p,r,n)-rg(r,g)-s_sc1_nd(p,r,n)))
-sum((p,r,n,s),u23(p,r,n,s)*(srpref(r,s)*x(p,r,n)-1-s_sc7(p,r,n)))
-sum((p,r,n,k),u24(p,r,n,k)*(pprefrf(p,k)*x(p,r,n)-rrf(r,k)-s_sc8(p,r,n,k)))
-sum((p,r,n,Scenario)$(ord(n)<>ad(p,Scenario)),u25(p,r,n,Scenario)*(-1*t(p,r,n,Scenario)+x(p,r,n)-x(p,r,n-1)))
;

test.. bound =l= 10000000000;

model dual
/
test
LR
e1
e2
e4
e5
e6
e7
e8
e9
e10
e11
e12
e13
*e14
e15
e17
e18
e19
e20
e21
e22
*e23
*e24
*e25
e26
e27
/;

*---------------------------------------------------------------------
* subgradient iterations
*---------------------------------------------------------------------

u14(p,r,n,g)=0.1;
u23(p,r,n,s)=0;
u24(p,r,n,k)=2;
u25(p,r,n,Scenario)$(ord(n)<>ad(p,Scenario))=3.25;

loop(iter$continue,

option mip=cplex;
solve dual maximazing bound using mip;
if (bound.l < bestbound,
bestbound = bound.l;
display bestbound;
noimprovement = 0;
else
noimprovement = noimprovement + 1;
if (noimprovement >= m,
stepsize = stepsize/2;
noimprovement = 0;
);
);

results(iter,'bound')=bound.l;

gama1(p,r,n,g) = (pg(p,g)*x.l(p,r,n)-rg(r,g)-s_sc1_nd.l(p,r,n));
gama2(p,r,n,s) = (srpref(r,s)*x.l(p,r,n)-1-s_sc7.l(p,r,n));
gama3(p,r,n,k) = (pprefrf(p,k)*x.l(p,r,n)-rrf(r,k)-s_sc8.l(p,r,n,k));
gama4(p,r,n,Scenario)$(ord(n)<>ad(p,Scenario)) = (-1*t.l(p,r,n,Scenario)+x.l(p,r,n)-x.l(p,r,n-1));

stepsize = theta*(bound.l-lowerbound)/sqr(sum((p,r,n,g,Scenario,k,s),gama1(p,r,n,g)+gama2(p,r,n,s)+gama3(p,r,n,k)+gama4(p,r,n,Scenario)));

results(iter,'stepsize') = stepsize;

u14_previous(p,r,n,g)=u14(p,r,n,g);
u23_previous(p,r,n,s)=u23(p,r,n,s);
u24_previous(p,r,n,k)=u24(p,r,n,k);
u25_previous(p,r,n,Scenario)$(ord(n)<>ad(p,Scenario))=u25(p,r,n,Scenario)$(ord(n)<>ad(p,Scenario));

u14(p,r,n,g) = max(0, u14(p,r,n,g)+stepsize*gama1(p,r,n,g));
u23(p,r,n,s) = max(0, u23(p,r,n,s)+stepsize*gama2(p,r,n,s));
u24(p,r,n,k) = max(0, u24(p,r,n,k)+stepsize*gama3(p,r,n,k));
u25(p,r,n,Scenario)$(ord(n)<>ad(p,Scenario)) =
max(-100000, u25(p,r,n,Scenario)$(ord(n)<>ad(p,Scenario))+stepsize*gama4(p,r,n,Scenario)$(ord(n)<>ad(p,Scenario)));

deltau14(p,r,n,g) = abs(u14_previous(p,r,n,g)-u14(p,r,n,g));
deltau23(p,r,n,s) = abs(u23_previous(p,r,n,s)-u23(p,r,n,s));
deltau24(p,r,n,k) = abs(u24_previous(p,r,n,k)-u24(p,r,n,k));
deltau25(p,r,n,Scenario)$(ord(n)<>ad(p,Scenario)) = abs(u25_previous(p,r,n,Scenario)$(ord(n)<>ad(p,Scenario))-u25(p,r,n,Scenario)$(ord(n)<>ad(p,Scenario)));
deltau = abs(sum((p,r,n,g,Scenario,k,s),
deltau14(p,r,n,g)
+deltau23(p,r,n,s)
+deltau24(p,r,n,k)
+deltau25(p,r,n,Scenario)$(ord(n)<>ad(p,Scenario))));

u14hat = sum((p,r,n,g),u14(p,r,n,g))/(card(p)*card(r)*card(n)*card(g));
u23hat = sum((p,r,n,s),u23(p,r,n,s))/(card(p)*card(r)*card(n)*card(s));
u24hat = sum((p,r,n,k),u24(p,r,n,k))/(card(p)*card(r)*card(n)*card(k));
u25hat = sum((p,r,n,Scenario)$(ord(n)<>ad(p,Scenario)),u25(p,r,n,Scenario))/(card(p)*card(r)*card(n)*card(Scenario));

gamma1 = sum((p,r,n,g),gama1(p,r,n,g));
gamma2 = sum((p,r,n,s),gama2(p,r,n,s));
gamma3 = sum((p,r,n,k),gama3(p,r,n,k));
gamma4 = sum((p,r,n,Scenario)$(ord(n)<>ad(p,Scenario)),gama4(p,r,n,Scenario));

results(iter,'u14hat') = u14hat;
results(iter,'u23hat') = u23hat;
results(iter,'u24hat') = u24hat;
results(iter,'u25hat') = u25hat;

results(iter,'deltau') = deltau;

results(iter, 'z') = z.l;
results(iter, 'gamma1') = gamma1;
results(iter, 'gamma2') = gamma2;
results(iter, 'gamma3') = gamma3;
results(iter, 'gamma4') = gamma4;

if(gamma1<=0 and gamma2<=0 and gamma3<=0 and gamma4<=0,
lowerbound = max(z.l,lowerbound);
);

results(iter, 'LB') = lowerbound;
);

display  gama4, bound.l, results, u25;
*u14hat, u23hat, u24hat ,

execute_unload 'output.gdx';






