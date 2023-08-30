sets
p /1*5/
r /1*5/
d /1*5/
k /1*5/
g /1*5/
w /1*5/
n /1*5/
s /1*5/
;

parameters
pen_sc1 /10/
pen_sc2 /10/
pen_sc3 /10/
pen_sc4 /10/
pen_sc5 /10/
pen_sc6 /10/
pen_sc7 /10/
pen_sc8 /10/
pen_sc9 /10/
qq(r)
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
;

binary variables
s_sc1_nd(p,r,n)
s_sc1_dr(r,n)
s_sc2(p,r,n)
s_sc3(p,r,n,k)
s_sc4(p,r,n)
s_sc5(p,n)
s_sc6(p,r,n)
s_sc7(p,r,n)
s_sc8(p,r,n,k)
t(p,r,n)
x(p,r,n)
y(r,n)
pr(p,r)
;

$onecho > valuerm.txt
par=qq   rng=qq!    rdim=1 cdim=0
par=ad   rng=ad!    rdim=1 cdim=0
par=dd   rng=dd!    rdim=1 cdim=0
par=los   rng=los!    rdim=1 cdim=0
par=age   rng=age!    rdim=1 cdim=0
par=prf   rng=prf!    rdim=1 cdim=1
par=rrf   rng=rrf!    rdim=1 cdim=1
par=min_age   rng=min_age!    rdim=1 cdim=0
par=max_age   rng=max_age!    rdim=1 cdim=0
par=pg   rng=pg!    rdim=1 cdim=1
par=rg   rng=rg!    rdim=1 cdim=1
par=rd   rng=rd!    rdim=1 cdim=1
par=rrt   rng=rrt!    rdim=1 cdim=1
par=prt   rng=prt!    rdim=1 cdim=1
par=preq   rng=preq!    rdim=1 cdim=0
par=single   rng=single!    rdim=1 cdim=0
par=psn   rng=psn!    rdim=2 cdim=1
par=rs   rng=rs!    rdim=1 cdim=1
par=srpref   rng=srpref!    rdim=1 cdim=1
par=pprefrf   rng=pprefrf!    rdim=1 cdim=1
par=adm_plan   rng=adm_plan!    rdim=1 cdim=1
$offecho

$call GDXXRW.EXE values10.xlsx  @valuerm.txt
$GDXIN values10.gdx
$load qq,ad,dd,los,age,min_age,max_age,prf,rrf,pg,rg,rd,rrt,prt,preq,single,psn,rs,srpref,pprefrf,adm_plan
$GDXIN

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
;

equations
obj
co1_1
co1_2
co1_3
co1_4
co1_5
co1_6
co1_7
co1_8
co1_9
co2
co3
co4
co5
co6
co7
co8
co9
co10
co11
co12
co13
co14
co15
co16
co29
co30
;

obj.. z=e=s1+s2+s3+s4+s5+s6+s7+s8+s9;

co1_1.. s1=e=sum((p,n,r),s_sc1_nd(p,r,n)+s_sc1_dr(r,n))*pen_sc1;

co1_2.. s2=e=sum((p,r,n),s_sc2(p,r,n)*pen_sc2);

co1_3.. s3=e=sum((p,r,n,k),s_sc3(p,r,n,k)*pen_sc3);

co1_4.. s4=e=sum((p,r,n),s_sc4(p,r,n)*pen_sc4);

co1_5.. s5=e=sum((p,n),s_sc5(p,n)*pen_sc5);

co1_6.. s6=e=sum((p,r,n),s_sc6(p,r,n)*pen_sc6);

co1_7.. s7=e=sum((p,r,n),s_sc7(p,r,n)*pen_sc7);

co1_8.. s8=e=sum((p,r,n,k),s_sc8(p,r,n,k)*pen_sc8);

co1_9.. s9=e=sum((p,r,n),t(p,r,n)*pen_sc9);

co2(r,n)..  sum(p,x(p,r,n))=l=qq(r);

co3(p,n)..  sum(r,x(p,r,n))=e=adm_plan(p,n);

co4(p,n)..  sum(r,x(p,r,n))=l=1;

co5(p,r,n,g)..  pg(p,g)*x(p,r,n)=l=rg(r,g)+s_sc1_nd(p,r,n);

co6(p,r,n).. x(p,r,n)=l=y(r,n)+s_sc1_dr(r,n);

co7(p,r,n).. x(p,r,n)=l=(1-y(r,n))+s_sc1_dr(r,n);

co8(p,r,n,d).. age(p)=g=min_age(d)*x(p,r,n)+(min_age(d)-age(p))*s_sc2(p,r,n);

co9(p,r,n,d)..   age(p)*x(p,r,n)=l=max_age(d)*2+(age(p)-max_age(d))*s_sc2(p,r,n);

co10(p,r,n,k)..   prf(p,k)*x(p,r,n)=l=rrf(r,k)+s_sc3(p,r,n,k);

co11(p,r,n,w)..   rrt(r,w)*x(p,r,n)=l=prt(p,w)+s_sc5(p,n);

co12(p,r,n)..     preq(p)*x(p,r,n)=l=single(r)+s_sc4(p,r,n);

co13(p,r,n,s)..   psn(p,s,n)*x(p,r,n)=l=rs(r,s)+s_sc6(p,r,n);

co14(p,r,n,s)..   srpref(r,s)*x(p,r,n)=l=1+s_sc7(p,r,n);

co15(p,r,n,k)..   pprefrf(p,k)*x(p,r,n)=l=rrf(r,k)+s_sc8(p,r,n,k);

co16(p,r,n)$(ord(n)<>ad(p))..   t(p,r,n)=g=x(p,r,n)-x(p,r,n-1);

co29(p,r).. sum(n,x(p,r,n))=e=los(p)*pr(p,r);

co30(p).. sum(r,pr(p,r))=l=1;

model problem
/
obj
co1_1
co1_2
co1_3
co1_4
co1_5
co1_6
co1_7
co1_8
co1_9
co2
co3
co4
co5
co6
co7
co8
co9
co10
co11
co12
co13
co14
co15
co16
*co29
*co30
/;

solve problem using mip min z;

display
z.l
s1.l
s2.l
s3.l
s4.l
s5.l
s6.l
s7.l
s8.l
s9.l
s_sc1_nd.l
s_sc1_dr.l
s_sc2.l
s_sc3.l
s_sc4.l
s_sc5.l
s_sc6.l
s_sc7.l
s_sc8.l
t.l
x.l
y.l
pen_sc1
pen_sc2
pen_sc3
pen_sc4
pen_sc5
pen_sc6
pen_sc7
pen_sc8
pen_sc9
qq
ad
dd
los
age
min_age
max_age
prf
rrf
pg
rrt
prt
preq
single
psn
rs
srpref
pprefrf
adm_plan
rd
;

