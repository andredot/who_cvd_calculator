# Generate tests/testthat/fixtures/stata_reference.csv: an independent
# re-implementation of the whocvdrisk Stata code (whocvdrisk.ado +
# whocvdrisk_erfc_score_v03.ado), evaluated on random inputs.
# Usage: python3 data-raw/stata_reference_cases.py whocvdrisk_t10_calparms_gbd_sens0.dta out.csv
import sys, numpy as np, pandas as pd
d=pd.read_stata(sys.argv[1], convert_categoricals=False)
rng=np.random.default_rng(1)
ctry=d[(~d.ccode.str.contains('GBDR'))&d.cal1_m1_cons_ep_chdmi.notna()&(d.year==1990)].ccode.unique()
n=2000
df=pd.DataFrame(dict(age=rng.uniform(40,80,n).round(1),sex=rng.integers(1,3,n),sbp=rng.uniform(100,200,n).round(),tc=rng.uniform(3,9,n).round(1),bmi=rng.uniform(18,40,n).round(1),smk=rng.integers(0,2,n),dm=rng.integers(0,2,n),ccode=rng.choice(ctry,n),year=rng.integers(1990,2018,n),cal=rng.choice(['cal1','cal2'],n)))
def calyr(y): return 5*(y//5) if y<=2015 else y
out=[]
for r in df.itertuples():
    a=r.age-60; s=r.sbp-120; c=r.tc-6; b=r.bmi-25; smk=r.smk; dm=r.dm
    if r.sex==1:
        l1c=0.0719227*a+0.2284944*c+0.0132183*s+0.6410114*dm+0.5638109*smk-0.0045806*a*c-0.0001576*a*s-0.0124966*a*dm-0.0182545*a*smk
        l1s=0.0986578*a+0.029526*c+0.0222629*s+0.6268712*dm+0.4981217*smk+0.00142*a*c-0.0004147*a*s-0.026302*a*dm-0.0150561*a*smk
        p1c=1-0.9540108**np.exp(l1c); p1s=1-0.9849257**np.exp(l1s)
        l2c=0.073593*a+0.0337219*b+0.0133937*s+0.5954767*smk-0.0010432*a*b-0.0001837*a*s-0.0200831*a*smk
        l2s=0.097674*a+0.0159518*b+0.0227294*s+0.4999862*smk-0.0003516*a*b-0.0004374*a*s-0.0153895*a*smk
        p2c=1-0.9544258**np.exp(l2c); p2s=1-0.9848260**np.exp(l2s)
    else:
        l1c=0.1020713*a+0.2050377*c+0.015823*s+1.070358*dm+1.053223*smk-0.0051932*a*c-0.0001378*a*s-0.0234174*a*dm-0.0332666*a*smk
        l1s=0.1056632*a+0.0257782*c+0.0206278*s+0.8581998*dm+0.7443627*smk-0.0021387*a*c-0.0004897*a*s-0.0209826*a*dm-0.0200822*a*smk
        p1c=1-0.9894159**np.exp(l1c); p1s=1-0.9890569**np.exp(l1s)
        l2c=0.1049418*a+0.0257616*b+0.016726*s+1.093132*smk-0.0006537*a*b-0.0001966*a*s-0.0343739*a*smk
        l2s=0.1046105*a+0.0036406*b+0.0216741*s+0.7399405*smk-0.0000129*a*b-0.0005311*a*s-0.0203997*a*smk
        p2c=1-0.9887124**np.exp(l2c); p2s=1-0.9885706**np.exp(l2s)
    row=d[(d.ccode==r.ccode)&(d.sex==r.sex)&(d.year==calyr(r.year))].iloc[0]
    f=lambda p,m,ep: 1-np.exp(-np.exp(row[f'{r.cal}_m{m}_cons_{ep}']+row[f'{r.cal}_m{m}_slope_{ep}']*np.log(-np.log(1-p))))
    out.append((1-(1-f(p1c,1,'ep_chdmi'))*(1-f(p1s,1,'ep_crbv')), 1-(1-f(p2c,2,'ep_chdmi'))*(1-f(p2s,2,'ep_crbv'))))
df['ref_lab'],df['ref_nonlab']=zip(*out)
df=df.head(200)
df['sex']=df.sex.map({1:'male',2:'female'})
df['recalibration']=df.cal.map({'cal1':'country','cal2':'region'})
df=df.rename(columns={'tc':'cholesterol','smk':'smoking','dm':'diabetes','ccode':'country'})
cols=['age','sex','sbp','cholesterol','bmi','smoking','diabetes','country','year','recalibration','ref_lab','ref_nonlab']
df[cols].to_csv(sys.argv[2],index=False,float_format='%.12g')
