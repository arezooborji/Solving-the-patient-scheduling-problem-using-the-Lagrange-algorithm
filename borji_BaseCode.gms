********* Base Model ********

sets
p /1*5/
r /1*2/
n /1*3/
k /1*1/
d /1*2/
w /1*2/
s /1*2/
g /1*2/


;
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
ad(p)
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
ad(p)=1;
dd(p)=4;
los(p)=dd(p)- ad(p);
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
t(p,r,n)
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
s9
pr(p,r)


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
e25(p,r,n)
e26(p,r)
e27 (p)
;




e1..   z=e=s1+s3+s4+s5+s6+s7+s8+s9;
e2..     s1=e=sum((p,n,r),(s_sc1_nd(p,r,n)+s_sc1_dr(r,n))*pen_sc1);
e4..     s3=e=sum((p,r,n,k),s_sc3(p,r,n,k)*pen_sc3);
e5..     s4=e=sum((p,r,n),s_sc4(p,r,n)*pen_sc4);
e6..     s5=e=sum((p,n),s_sc5(p,n)*pen_sc5);
e7..     s6=e=sum((p,r,n),s_sc6(p,r,n)*pen_sc6);
e8..     s7=e=sum((p,r,n),s_sc7(p,r,n)*pen_sc7);
e9..     s8=e=sum((p,r,n,k),s_sc8(p,r,n,k)*pen_sc8);
e10..    s9=e=sum((p,r,n),t(p,r,n)*pen_sc9);
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
e25(p,r,n)$(ord(n)<>ad(p))..     t(p,r,n)=g=x(p,r,n)-x(p,r,n-1);
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
option optca=0;
option optcr=0;

solve Patient_Admission_Scheduling using mip min z;
display
s_sc1_nd.l
s_sc1_dr.l
s_sc2.l
s_sc3.l
s_sc4.l
s_sc5.l
s_sc6.l
s_sc8.l
t.l
x.l
y.l
pr.l
s_sc7.l
z.l
s1.l
s3.l
s4.l
s5.l
s6.l
s7.l
s8.l
s9.l
Los
;

