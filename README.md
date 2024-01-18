# Healthy-Lifestyle-manuscript
********************************************************************************
*SYSTEM REQUIREMENTS
********************************************************************************

Windows: Windows 11*, Windows 10*, Windows Server 2022, 2019, 2016, 2012R2*
  * Stata requires 64-bit Windows for x86-64 processors made by Intel® or AMD 
    (Core i3 equivalent or better). 

Mac: macOS 11.0 (Big Sur) or newer for Macs with Apple Silicon and macOS 10.13 
    (High Sierra) or newer for Macs with Intel processors

Linux: Any 64-bit (Core i3 equivalent or better) running Linux
    Minimum requirements include the GNU C library (glibc) 2.17 or better 
    and libcurl4

StataMP requires 4 GB of memory and 2 GB of disk space. 

********************************************************************************
*INSTALLATION
********************************************************************************

A StataMP 18 license can be purchased from https://www.stata.com/order/. See
https://www.stata.com/install-guide/ an installation guide. Installation time
is usually under 5 minutes. 

********************************************************************************
*TO RUN DO FILE ON SIMULATED DATASET
********************************************************************************

1. Download and save "Healthy_Lifestyle.do" and "sample_dataset_clean.dta".
2. Open "Healthy_Lifestyle.do" which will initialise Stata and open a new Do
  File Editor window. 
3. In the Results window, go to File -> change working directory, and 
  set working directory to the folder where "sample_dataset_clean" is saved.
4. Press the "Execute" button in the left upper left hand corner of the Do File
  Editor window. 

********************************************************************************
*EXPECTED OUTPUT (Run time: 1-2 minutes)
********************************************************************************

. *Load sample dataset
. use sample_dataset_clean, clear

. 
. ********************************************************************************
. *DERIVE AGE AND TIME VARIABLES
. ********************************************************************************
. 
. *Create variable for time in 10 year intervals 
. gen time10 = time/10 

. 
. *Centre age at 65 years
. gen age65 = age-65

. 
. ********************************************************************************
. *MEMORY
. ********************************************************************************
. 
. ***Independent assocations between each behaviour and 10-year memory decline
. foreach var of varlist beh1 beh2 {
  2.         mixed zmem ///
>                 i.`var' ///
>                 i.`var'##c.time10##c.time10 ///
>                 ///
>                 c.time10##c.time10##c.age65 i.country i.edu i.gender c.age65 ///
>                 i.diabe i.cancr i.lung i.heart i.hchol i.hbp i.psy ///
>                 c.wealth5 ///
>                 ///
>                 || id: time10, cov(uns)
  3.         
.         *Decline over 10 years
.         lincom 1.`var'#c.time10 + 1.`var'#c.time10#c.time10
  4. }
note: time10 omitted because of collinearity.
note: age65 omitted because of collinearity.

Performing EM optimization ...

Performing gradient-based optimization: 
Iteration 0:   log likelihood =  25927.334  
Iteration 1:   log likelihood =  25932.632  
Iteration 2:   log likelihood =  25932.646  
Iteration 3:   log likelihood =  25932.646  

Computing standard errors ...

Mixed-effects ML regression                     Number of obs     =     11,130
Group variable: id                              Number of groups  =      2,000
                                                Obs per group:
                                                              min =          1
                                                              avg =        5.6
                                                              max =          8
                                                Wald chi2(22)     =   1.80e+06
Log likelihood =  25932.646                     Prob > chi2       =     0.0000

-------------------------------------------------------------------------------------------
                     zmem | Coefficient  Std. err.      z    P>|z|     [95% conf. interval]
--------------------------+----------------------------------------------------------------
                     beh1 |
                   1.Yes  |   .0323224    .001806    17.90   0.000     .0287827    .0358621
                   time10 |   .0014222      .0031     0.46   0.646    -.0046537    .0074981
                          |
            beh1#c.time10 |
                   1.Yes  |   .0016752   .0033249     0.50   0.614    -.0048414    .0081918
                          |
        c.time10#c.time10 |   .0015294   .0021302     0.72   0.473    -.0026456    .0057044
                          |
   beh1#c.time10#c.time10 |
                   1.Yes  |  -.0014792   .0022826    -0.65   0.517     -.005953    .0029945
                          |
                   time10 |          0  (omitted)
                    age65 |  -.0428594   .0000905  -473.54   0.000    -.0430367    -.042682
                          |
         c.time10#c.age65 |   .0000226   .0001536     0.15   0.883    -.0002785    .0003237
                          |
c.time10#c.time10#c.age65 |    .000028   .0001038     0.27   0.787    -.0001754    .0002314
                          |
                  country |
             2.Country 2  |  -.1249823   .0020694   -60.39   0.000    -.1290383   -.1209263
             3.Country 3  |   .0807414   .0017797    45.37   0.000     .0772533    .0842296
             4.Country 4  |   .0282007   .0024082    11.71   0.000     .0234807    .0329207
                          |
                      edu |
             2.Secondary  |   .2947807   .0015637   188.51   0.000     .2917158    .2978455
    3.Tertiary and above  |    .583256   .0019272   302.64   0.000     .5794787    .5870334
                          |
                   gender |
                 1.Woman  |   -.000529   .0013306    -0.40   0.691    -.0031369    .0020789
                    age65 |          0  (omitted)
                          |
                    diabe |
                   1.Yes  |   -.053393   .0009051   -58.99   0.000     -.055167    -.051619
                          |
                    cancr |
                   1.Yes  |    .054885   .0010558    51.99   0.000     .0528157    .0569542
                          |
                     lung |
                   1.Yes  |  -.0240604    .000941   -25.57   0.000    -.0259047    -.022216
                          |
                    heart |
                   1.Yes  |  -.0722768   .0007363   -98.17   0.000    -.0737198   -.0708337
                          |
                    hchol |
                   1.Yes  |   .0117271   .0007328    16.00   0.000     .0102909    .0131634
                          |
                      hbp |
                   1.Yes  |  -.0208541   .0006584   -31.67   0.000    -.0221446   -.0195635
                          |
                      psy |
                   1.Yes  |   .0134414   .0012233    10.99   0.000     .0110438    .0158389
                  wealth5 |    .045951   .0001368   335.78   0.000     .0456828    .0462193
                    _cons |  -.3564862   .0021262  -167.66   0.000    -.3606536   -.3523189
-------------------------------------------------------------------------------------------

------------------------------------------------------------------------------
  Random-effects parameters  |   Estimate   Std. err.     [95% conf. interval]
-----------------------------+------------------------------------------------
id: Unstructured             |
                 var(time10) |   .0000492   .0000116      .0000309    .0000781
                  var(_cons) |   .0007748   .0000314      .0007157    .0008387
           cov(time10,_cons) |   9.40e-06   .0000142     -.0000184    .0000372
-----------------------------+------------------------------------------------
               var(Residual) |   .0003359   5.54e-06      .0003252    .0003469
------------------------------------------------------------------------------
LR test vs. linear model: chi2(3) = 8190.63               Prob > chi2 = 0.0000

Note: LR test is conservative and provided only for reference.

 ( 1)  [zmem]1.beh1#c.time10 + [zmem]1.beh1#c.time10#c.time10 = 0

------------------------------------------------------------------------------
        zmem | Coefficient  Std. err.      z    P>|z|     [95% conf. interval]
-------------+----------------------------------------------------------------
         (1) |    .000196   .0013387     0.15   0.884    -.0024278    .0028198
------------------------------------------------------------------------------
note: time10 omitted because of collinearity.
note: age65 omitted because of collinearity.

Performing EM optimization ...

Performing gradient-based optimization: 
Iteration 0:   log likelihood =  26782.509  
Iteration 1:   log likelihood =  26788.541  
Iteration 2:   log likelihood =  26788.568  
Iteration 3:   log likelihood =  26788.568  

Computing standard errors ...

Mixed-effects ML regression                     Number of obs     =     11,130
Group variable: id                              Number of groups  =      2,000
                                                Obs per group:
                                                              min =          1
                                                              avg =        5.6
                                                              max =          8
                                                Wald chi2(22)     =   2.52e+06
Log likelihood =  26788.568                     Prob > chi2       =     0.0000

-------------------------------------------------------------------------------------------
                     zmem | Coefficient  Std. err.      z    P>|z|     [95% conf. interval]
--------------------------+----------------------------------------------------------------
                     beh2 |
                   1.Yes  |  -.0543077     .00117   -46.42   0.000     -.056601   -.0520145
                   time10 |  -.0006721   .0024599    -0.27   0.785    -.0054934    .0041491
                          |
            beh2#c.time10 |
                   1.Yes  |  -.0051373   .0028702    -1.79   0.073    -.0107629    .0004882
                          |
        c.time10#c.time10 |  -.0019024   .0017377    -1.09   0.274    -.0053082    .0015034
                          |
   beh2#c.time10#c.time10 |
                   1.Yes  |   .0039129    .001958     2.00   0.046     .0000753    .0077505
                          |
                   time10 |          0  (omitted)
                    age65 |  -.0422231    .000066  -639.28   0.000    -.0423525   -.0420936
                          |
         c.time10#c.age65 |   4.32e-06   .0001521     0.03   0.977    -.0002939    .0003025
                          |
c.time10#c.time10#c.age65 |   .0000278    .000103     0.27   0.787     -.000174    .0002296
                          |
                  country |
             2.Country 2  |  -.1280833    .001349   -94.95   0.000    -.1307272   -.1254393
             3.Country 3  |   .0863167    .001166    74.03   0.000     .0840315     .088602
             4.Country 4  |   .0330603   .0015753    20.99   0.000     .0299729    .0361478
                          |
                      edu |
             2.Secondary  |   .2937771   .0010215   287.60   0.000     .2917751    .2957792
    3.Tertiary and above  |   .5788096   .0012634   458.15   0.000     .5763335    .5812857
                          |
                   gender |
                 1.Woman  |  -.0009402   .0008681    -1.08   0.279    -.0026417    .0007613
                    age65 |          0  (omitted)
                          |
                    diabe |
                   1.Yes  |  -.0537088   .0008477   -63.36   0.000    -.0553702   -.0520473
                          |
                    cancr |
                   1.Yes  |   .0546731   .0009786    55.87   0.000      .052755    .0565911
                          |
                     lung |
                   1.Yes  |  -.0240243   .0008734   -27.51   0.000    -.0257361   -.0223126
                          |
                    heart |
                   1.Yes  |  -.0717685    .000689  -104.16   0.000     -.073119   -.0704181
                          |
                    hchol |
                   1.Yes  |   .0119107   .0006776    17.58   0.000     .0105826    .0132388
                          |
                      hbp |
                   1.Yes  |  -.0205068   .0006082   -33.72   0.000    -.0216988   -.0193147
                          |
                      psy |
                   1.Yes  |   .0140246   .0011298    12.41   0.000     .0118103     .016239
                  wealth5 |   .0459078   .0001352   339.50   0.000     .0456428    .0461729
                    _cons |  -.2982178   .0013318  -223.91   0.000    -.3008281   -.2956074
-------------------------------------------------------------------------------------------

------------------------------------------------------------------------------
  Random-effects parameters  |   Estimate   Std. err.     [95% conf. interval]
-----------------------------+------------------------------------------------
id: Unstructured             |
                 var(time10) |   .0000491   .0000115       .000031    .0000778
                  var(_cons) |   .0002748   .0000154      .0002463    .0003067
           cov(time10,_cons) |   9.79e-06   .0000104     -.0000105    .0000301
-----------------------------+------------------------------------------------
               var(Residual) |   .0003356   5.52e-06       .000325    .0003466
------------------------------------------------------------------------------
LR test vs. linear model: chi2(3) = 3683.77               Prob > chi2 = 0.0000

Note: LR test is conservative and provided only for reference.

 ( 1)  [zmem]1.beh2#c.time10 + [zmem]1.beh2#c.time10#c.time10 = 0

------------------------------------------------------------------------------
        zmem | Coefficient  Std. err.      z    P>|z|     [95% conf. interval]
-------------+----------------------------------------------------------------
         (1) |  -.0012244   .0011682    -1.05   0.295     -.003514    .0010652
------------------------------------------------------------------------------

. 
. 
. ***Association between lifestyle and 10-year memory decline (ref: lifestyle 4)
. mixed zmem ///
>         ib4.lifestyle ///
>         ib4.lifestyle##c.time10##c.time10 ///
>         ///
>         c.time10##c.time10##c.age65 i.country i.edu i.gender c.age65 ///
>         i.diabe i.cancr i.lung i.heart i.hchol i.hbp i.psy ///
>         c.wealth5 ///
>         ///
>         || id: time10, cov(uns)
note: time10 omitted because of collinearity.
note: age65 omitted because of collinearity.

Performing EM optimization ...

Performing gradient-based optimization: 
Iteration 0:   log likelihood =  28584.687  
Iteration 1:   log likelihood =  28620.133  
Iteration 2:   log likelihood =  28621.631  
Iteration 3:   log likelihood =  28621.639  
Iteration 4:   log likelihood =  28621.639  (backed up)

Computing standard errors ...

Mixed-effects ML regression                     Number of obs     =     11,130
Group variable: id                              Number of groups  =      2,000
                                                Obs per group:
                                                              min =          1
                                                              avg =        5.6
                                                              max =          8
                                                Wald chi2(28)     =   8.15e+06
Log likelihood =  28621.639                     Prob > chi2       =     0.0000

---------------------------------------------------------------------------------------------
                       zmem | Coefficient  Std. err.      z    P>|z|     [95% conf. interval]
----------------------------+----------------------------------------------------------------
                  lifestyle |
                   1.No No  |   .0065779   .0013657     4.82   0.000     .0039011    .0092547
                  2.No Yes  |  -.0205133   .0012499   -16.41   0.000     -.022963   -.0180636
                  3.Yes No  |   .0666997   .0009647    69.14   0.000     .0648089    .0685904
                            |
                     time10 |  -.0029527   .0022389    -1.32   0.187    -.0073408    .0014354
                            |
         lifestyle#c.time10 |
                   1.No No  |   .0015598   .0045931     0.34   0.734    -.0074426    .0105622
                  2.No Yes  |  -.0003544   .0041742    -0.08   0.932    -.0085356    .0078268
                  3.Yes No  |   .0051215   .0031661     1.62   0.106    -.0010841     .011327
                            |
          c.time10#c.time10 |   .0019835   .0016653     1.19   0.234    -.0012804    .0052474
                            |
lifestyle#c.time10#c.time10 |
                   1.No No  |   -.001423   .0031689    -0.45   0.653    -.0076339     .004788
                  2.No Yes  |   .0007622   .0028504     0.27   0.789    -.0048244    .0063488
                  3.Yes No  |  -.0038442   .0021463    -1.79   0.073    -.0080509    .0003624
                            |
                     time10 |          0  (omitted)
                      age65 |  -.0425045   .0000467  -909.49   0.000    -.0425961   -.0424129
                            |
           c.time10#c.age65 |  -.0000248   .0001467    -0.17   0.866    -.0003122    .0002627
                            |
  c.time10#c.time10#c.age65 |    .000042   .0000989     0.42   0.672     -.000152    .0002359
                            |
                    country |
               2.Country 2  |   -.125953   .0005707  -220.71   0.000    -.1270716   -.1248345
               3.Country 3  |   .0900258   .0004961   181.45   0.000     .0890533    .0909982
               4.Country 4  |   .0363183   .0006729    53.97   0.000     .0349994    .0376373
                            |
                        edu |
               2.Secondary  |   .2929835   .0004348   673.88   0.000     .2921313    .2938356
      3.Tertiary and above  |   .5743899   .0005452  1053.61   0.000     .5733214    .5754584
                            |
                     gender |
                   1.Woman  |  -.0002441   .0003675    -0.66   0.507    -.0009644    .0004762
                      age65 |          0  (omitted)
                            |
                      diabe |
                     1.Yes  |  -.0541906   .0005928   -91.41   0.000    -.0553525   -.0530287
                            |
                      cancr |
                     1.Yes  |   .0538295   .0006629    81.21   0.000     .0525303    .0551287
                            |
                       lung |
                     1.Yes  |  -.0230645   .0005945   -38.80   0.000    -.0242296   -.0218994
                            |
                      heart |
                     1.Yes  |  -.0714091   .0004829  -147.88   0.000    -.0723556   -.0704627
                            |
                      hchol |
                     1.Yes  |   .0113482   .0004566    24.85   0.000     .0104533    .0122432
                            |
                        hbp |
                     1.Yes  |  -.0206429   .0004126   -50.03   0.000    -.0214516   -.0198341
                            |
                        psy |
                     1.Yes  |   .0149679   .0007531    19.88   0.000     .0134919    .0164439
                    wealth5 |   .0458333    .000124   369.71   0.000     .0455903    .0460762
                      _cons |  -.3484196   .0007995  -435.81   0.000    -.3499865   -.3468526
---------------------------------------------------------------------------------------------

------------------------------------------------------------------------------
  Random-effects parameters  |   Estimate   Std. err.     [95% conf. interval]
-----------------------------+------------------------------------------------
id: Unstructured             |
                 var(time10) |   .0000861   .0000102      .0000683    .0001087
                  var(_cons) |   9.94e-06   2.83e-06      5.68e-06    .0000174
           cov(time10,_cons) |  -.0000293   5.69e-06     -.0000404   -.0000181
-----------------------------+------------------------------------------------
               var(Residual) |   .0003178   4.66e-06      .0003088     .000327
------------------------------------------------------------------------------
LR test vs. linear model: chi2(3) = 175.70                Prob > chi2 = 0.0000

Note: LR test is conservative and provided only for reference.

. 
. **Differences in 10-year decline between lifestyles
. forval i=1/3 {
  2.         di "Lifestyle `i' vs. lifestyle 4"
  3.         lincom `i'.lifestyle#c.time10 + `i'.lifestyle#c.time10#c.time10
  4. }
Lifestyle 1 vs. lifestyle 4

 ( 1)  [zmem]1.lifestyle#c.time10 + [zmem]1.lifestyle#c.time10#c.time10 = 0

------------------------------------------------------------------------------
        zmem | Coefficient  Std. err.      z    P>|z|     [95% conf. interval]
-------------+----------------------------------------------------------------
         (1) |   .0001369   .0018881     0.07   0.942    -.0035637    .0038374
------------------------------------------------------------------------------
Lifestyle 2 vs. lifestyle 4

 ( 1)  [zmem]2.lifestyle#c.time10 + [zmem]2.lifestyle#c.time10#c.time10 = 0

------------------------------------------------------------------------------
        zmem | Coefficient  Std. err.      z    P>|z|     [95% conf. interval]
-------------+----------------------------------------------------------------
         (1) |   .0004078    .001733     0.24   0.814    -.0029889    .0038044
------------------------------------------------------------------------------
Lifestyle 3 vs. lifestyle 4

 ( 1)  [zmem]3.lifestyle#c.time10 + [zmem]3.lifestyle#c.time10#c.time10 = 0

------------------------------------------------------------------------------
        zmem | Coefficient  Std. err.      z    P>|z|     [95% conf. interval]
-------------+----------------------------------------------------------------
         (1) |   .0012772   .0013259     0.96   0.335    -.0013214    .0038759
------------------------------------------------------------------------------

. 
. 
. ********************************************************************************
. *FLUENCY
. ********************************************************************************
. 
. ***Independent assocations between each behaviour and 10-year memory decline
. foreach var of varlist beh1 beh2 {
  2.         mixed zverb ///
>                 i.`var' ///
>                 i.`var'##c.time10 ///
>                 ///
>                 c.time10##c.age65 i.country i.edu i.gender c.age65 ///
>                 i.diabe i.cancr i.lung i.heart i.hchol i.hbp i.psy ///
>                 c.wealth5 ///
>                 ///
>                 || id: time10, cov(uns)
  3.         
.         *Difference in decline over 10 years
.         lincom 1.`var'#c.time10 
  4. }
note: time10 omitted because of collinearity.
note: age65 omitted because of collinearity.

Performing EM optimization ...

Performing gradient-based optimization: 
Iteration 0:   log likelihood =  25362.509  
Iteration 1:   log likelihood =  25372.866  
Iteration 2:   log likelihood =  25372.937  
Iteration 3:   log likelihood =  25372.937  

Computing standard errors ...

Mixed-effects ML regression                     Number of obs     =     11,130
Group variable: id                              Number of groups  =      2,000
                                                Obs per group:
                                                              min =          1
                                                              avg =        5.6
                                                              max =          8
                                                Wald chi2(19)     =  965470.83
Log likelihood =  25372.937                     Prob > chi2       =     0.0000

---------------------------------------------------------------------------------------
                zverb | Coefficient  Std. err.      z    P>|z|     [95% conf. interval]
----------------------+----------------------------------------------------------------
                 beh1 |
               1.Yes  |   .0570866   .0021585    26.45   0.000      .052856    .0613172
               time10 |   .0026249   .0014001     1.87   0.061    -.0001194    .0053691
                      |
        beh1#c.time10 |
               1.Yes  |   .0014773   .0009669     1.53   0.127    -.0004178    .0033725
                      |
               time10 |          0  (omitted)
                age65 |   -.030606   .0001082  -282.78   0.000    -.0308181   -.0303939
                      |
     c.time10#c.age65 |   .0000805   .0000439     1.83   0.067    -5.51e-06    .0001666
                      |
              country |
         2.Country 2  |  -.0272855   .0026741   -10.20   0.000    -.0325267   -.0220443
         3.Country 3  |   .0414463   .0022999    18.02   0.000     .0369386    .0459541
         4.Country 4  |   .2221289   .0031111    71.40   0.000     .2160313    .2282265
                      |
                  edu |
         2.Secondary  |   .2784668   .0020205   137.82   0.000     .2745068    .2824268
3.Tertiary and above  |     .55987   .0024886   224.97   0.000     .5549924    .5647476
                      |
               gender |
             1.Woman  |  -.0005503   .0017195    -0.32   0.749    -.0039206    .0028199
                age65 |          0  (omitted)
                      |
                diabe |
               1.Yes  |  -.0606897   .0009102   -66.68   0.000    -.0624737   -.0589058
                      |
                cancr |
               1.Yes  |    .029014   .0010644    27.26   0.000     .0269279    .0311001
                      |
                 lung |
               1.Yes  |  -.0068494   .0009492    -7.22   0.000    -.0087098    -.004989
                      |
                heart |
               1.Yes  |  -.0662591    .000743   -89.18   0.000    -.0677153   -.0648029
                      |
                hchol |
               1.Yes  |    .029477   .0007429    39.68   0.000      .028021     .030933
                      |
                  hbp |
               1.Yes  |  -.0088197   .0006694   -13.18   0.000    -.0101317   -.0075078
                      |
                  psy |
               1.Yes  |  -.0217655    .001234   -17.64   0.000    -.0241841   -.0193469
              wealth5 |   .0466233   .0001381   337.69   0.000     .0463527    .0468939
                _cons |  -.2942902   .0026266  -112.04   0.000    -.2994382   -.2891422
---------------------------------------------------------------------------------------

------------------------------------------------------------------------------
  Random-effects parameters  |   Estimate   Std. err.     [95% conf. interval]
-----------------------------+------------------------------------------------
id: Unstructured             |
                 var(time10) |   .0000195    .000011      6.43e-06    .0000592
                  var(_cons) |   .0013735   .0000505      .0012781    .0014761
           cov(time10,_cons) |   4.77e-06   .0000173     -.0000291    .0000386
-----------------------------+------------------------------------------------
               var(Residual) |    .000346   5.70e-06       .000335    .0003573
------------------------------------------------------------------------------
LR test vs. linear model: chi2(3) = 11589.13              Prob > chi2 = 0.0000

Note: LR test is conservative and provided only for reference.

 ( 1)  [zverb]1.beh1#c.time10 = 0

------------------------------------------------------------------------------
       zverb | Coefficient  Std. err.      z    P>|z|     [95% conf. interval]
-------------+----------------------------------------------------------------
         (1) |   .0014773   .0009669     1.53   0.127    -.0004178    .0033725
------------------------------------------------------------------------------
note: time10 omitted because of collinearity.
note: age65 omitted because of collinearity.

Performing EM optimization ...

Performing gradient-based optimization: 
Iteration 0:   log likelihood =    25678.6  
Iteration 1:   log likelihood =  25689.171  
Iteration 2:   log likelihood =  25689.257  
Iteration 3:   log likelihood =  25689.257  

Computing standard errors ...

Mixed-effects ML regression                     Number of obs     =     11,130
Group variable: id                              Number of groups  =      2,000
                                                Obs per group:
                                                              min =          1
                                                              avg =        5.6
                                                              max =          8
                                                Wald chi2(19)     =   1.04e+06
Log likelihood =  25689.257                     Prob > chi2       =     0.0000

---------------------------------------------------------------------------------------
                zverb | Coefficient  Std. err.      z    P>|z|     [95% conf. interval]
----------------------+----------------------------------------------------------------
                 beh2 |
               1.Yes  |  -.0654601   .0016324   -40.10   0.000    -.0686596   -.0622607
               time10 |  -.0051727   .0011848    -4.37   0.000    -.0074949   -.0028505
                      |
        beh2#c.time10 |
               1.Yes  |  -.0006209   .0008463    -0.73   0.463    -.0022795    .0010377
                      |
               time10 |          0  (omitted)
                age65 |  -.0297072    .000093  -319.37   0.000    -.0298895   -.0295249
                      |
     c.time10#c.age65 |   .0000847   .0000437     1.94   0.053    -9.73e-07    .0001704
                      |
              country |
         2.Country 2  |  -.0321787   .0022801   -14.11   0.000    -.0366476   -.0277099
         3.Country 3  |   .0461615   .0019708    23.42   0.000     .0422988    .0500241
         4.Country 4  |   .2258903   .0026596    84.93   0.000     .2206776    .2311029
                      |
                  edu |
         2.Secondary  |   .2774467   .0017253   160.81   0.000     .2740652    .2808282
3.Tertiary and above  |   .5562197   .0021294   261.21   0.000     .5520461    .5603933
                      |
               gender |
             1.Woman  |  -.0014873   .0014674    -1.01   0.311    -.0043635    .0013888
                age65 |          0  (omitted)
                      |
                diabe |
               1.Yes  |  -.0609293    .000899   -67.78   0.000    -.0626912   -.0591674
                      |
                cancr |
               1.Yes  |   .0290506    .001049    27.69   0.000     .0269947    .0311065
                      |
                 lung |
               1.Yes  |  -.0068693   .0009358    -7.34   0.000    -.0087033   -.0050352
                      |
                heart |
               1.Yes  |  -.0660446   .0007338   -90.00   0.000    -.0674828   -.0646064
                      |
                hchol |
               1.Yes  |   .0298915   .0007322    40.82   0.000     .0284563    .0313267
                      |
                  hbp |
               1.Yes  |  -.0086118   .0006595   -13.06   0.000    -.0099045   -.0073192
                      |
                  psy |
               1.Yes  |  -.0213692   .0012154   -17.58   0.000    -.0237514   -.0189871
              wealth5 |   .0465958   .0001378   338.09   0.000     .0463257    .0468659
                _cons |    -.20957   .0019952  -105.04   0.000    -.2134805   -.2056595
---------------------------------------------------------------------------------------

------------------------------------------------------------------------------
  Random-effects parameters  |   Estimate   Std. err.     [95% conf. interval]
-----------------------------+------------------------------------------------
id: Unstructured             |
                 var(time10) |   .0000195    .000011      6.46e-06    .0000591
                  var(_cons) |   .0009762   .0000377      .0009051     .001053
           cov(time10,_cons) |   6.64e-06   .0000148     -.0000225    .0000357
-----------------------------+------------------------------------------------
               var(Residual) |    .000346   5.70e-06       .000335    .0003574
------------------------------------------------------------------------------
LR test vs. linear model: chi2(3) = 9452.09               Prob > chi2 = 0.0000

Note: LR test is conservative and provided only for reference.

 ( 1)  [zverb]1.beh2#c.time10 = 0

------------------------------------------------------------------------------
       zverb | Coefficient  Std. err.      z    P>|z|     [95% conf. interval]
-------------+----------------------------------------------------------------
         (1) |  -.0006209   .0008463    -0.73   0.463    -.0022795    .0010377
------------------------------------------------------------------------------

. 
. 
. ***Association between lifestyle and 10-year fluency decline (ref: lifestyle 4)
. mixed zverb ///
>         ib4.lifestyle ///
>         ib4.lifestyle##c.time10 ///
>         ///
>         c.time10##c.age65 i.country i.edu i.gender c.age65 ///
>         i.diabe i.cancr i.lung i.heart i.hchol i.hbp i.psy ///
>         c.wealth5 ///
>         ///
>         || id: time10, cov(uns)
note: time10 omitted because of collinearity.
note: age65 omitted because of collinearity.

Performing EM optimization ...

Performing gradient-based optimization: 
Iteration 0:   log likelihood =  28466.833  
Iteration 1:   log likelihood =  28498.062  
Iteration 2:   log likelihood =  28498.854  
Iteration 3:   log likelihood =  28498.921  
Iteration 4:   log likelihood =  28498.922  

Computing standard errors ...

Mixed-effects ML regression                     Number of obs     =     11,130
Group variable: id                              Number of groups  =      2,000
                                                Obs per group:
                                                              min =          1
                                                              avg =        5.6
                                                              max =          8
                                                Wald chi2(23)     =   5.63e+06
Log likelihood =  28498.922                     Prob > chi2       =     0.0000

---------------------------------------------------------------------------------------
                zverb | Coefficient  Std. err.      z    P>|z|     [95% conf. interval]
----------------------+----------------------------------------------------------------
            lifestyle |
             1.No No  |  -.0208948   .0011124   -18.78   0.000    -.0230751   -.0187144
            2.No Yes  |  -.0281195   .0010058   -27.96   0.000    -.0300909   -.0261481
            3.Yes No  |   .0902001   .0007733   116.64   0.000     .0886844    .0917158
                      |
               time10 |  -.0004205   .0007424    -0.57   0.571    -.0018756    .0010346
                      |
   lifestyle#c.time10 |
             1.No No  |  -.0004658   .0013552    -0.34   0.731     -.003122    .0021904
            2.No Yes  |  -.0016486   .0012291    -1.34   0.180    -.0040576    .0007605
            3.Yes No  |   .0001811   .0009358     0.19   0.847    -.0016532    .0020153
                      |
               time10 |          0  (omitted)
                age65 |  -.0301964   .0000363  -832.36   0.000    -.0302675   -.0301253
                      |
     c.time10#c.age65 |   .0000804   .0000422     1.91   0.057    -2.29e-06    .0001631
                      |
              country |
         2.Country 2  |  -.0284235   .0005545   -51.26   0.000    -.0295104   -.0273366
         3.Country 3  |   .0524189   .0004848   108.13   0.000     .0514687     .053369
         4.Country 4  |   .2314142   .0006567   352.41   0.000     .2301272    .2327012
                      |
                  edu |
         2.Secondary  |    .275672   .0004247   649.07   0.000     .2748396    .2765044
3.Tertiary and above  |   .5478503   .0005325  1028.83   0.000     .5468066     .548894
                      |
               gender |
             1.Woman  |  -.0005365   .0003585    -1.50   0.135    -.0012391    .0001662
                age65 |          0  (omitted)
                      |
                diabe |
               1.Yes  |  -.0615404   .0005579  -110.30   0.000     -.062634   -.0604469
                      |
                cancr |
               1.Yes  |   .0292998   .0006228    47.04   0.000     .0280791    .0305204
                      |
                 lung |
               1.Yes  |  -.0069079   .0005586   -12.37   0.000    -.0080028   -.0058131
                      |
                heart |
               1.Yes  |   -.065655   .0004591  -143.02   0.000    -.0665548   -.0647553
                      |
                hchol |
               1.Yes  |   .0300055   .0004341    69.13   0.000     .0291547    .0308562
                      |
                  hbp |
               1.Yes  |  -.0091805   .0003988   -23.02   0.000    -.0099622   -.0083988
                      |
                  psy |
               1.Yes  |  -.0192883   .0007064   -27.31   0.000    -.0206728   -.0179038
              wealth5 |   .0466715   .0001261   370.24   0.000     .0464244    .0469186
                _cons |   -.269914   .0007226  -373.53   0.000    -.2713303   -.2684977
---------------------------------------------------------------------------------------

------------------------------------------------------------------------------
  Random-effects parameters  |   Estimate   Std. err.     [95% conf. interval]
-----------------------------+------------------------------------------------
id: Unstructured             |
                 var(time10) |   .0000166   9.39e-06      5.45e-06    .0000503
                  var(_cons) |   3.59e-06   3.92e-06      4.22e-07    .0000306
           cov(time10,_cons) |  -7.71e-06   6.16e-06     -.0000198    4.35e-06
-----------------------------+------------------------------------------------
               var(Residual) |   .0003452   5.06e-06      .0003355    .0003553
------------------------------------------------------------------------------
LR test vs. linear model: chi2(3) = 4.51                  Prob > chi2 = 0.2116

Note: LR test is conservative and provided only for reference.

. 
. **Differences in 10-year decline between lifestyles
. forval i=1/3 {
  2.         di "Lifestyle `i' vs. lifestyle 4"
  3.         lincom `i'.lifestyle#c.time10 
  4. }
Lifestyle 1 vs. lifestyle 4

 ( 1)  [zverb]1.lifestyle#c.time10 = 0

------------------------------------------------------------------------------
       zverb | Coefficient  Std. err.      z    P>|z|     [95% conf. interval]
-------------+----------------------------------------------------------------
         (1) |  -.0004658   .0013552    -0.34   0.731     -.003122    .0021904
------------------------------------------------------------------------------
Lifestyle 2 vs. lifestyle 4

 ( 1)  [zverb]2.lifestyle#c.time10 = 0

------------------------------------------------------------------------------
       zverb | Coefficient  Std. err.      z    P>|z|     [95% conf. interval]
-------------+----------------------------------------------------------------
         (1) |  -.0016486   .0012291    -1.34   0.180    -.0040576    .0007605
------------------------------------------------------------------------------
Lifestyle 3 vs. lifestyle 4

 ( 1)  [zverb]3.lifestyle#c.time10 = 0

------------------------------------------------------------------------------
       zverb | Coefficient  Std. err.      z    P>|z|     [95% conf. interval]
-------------+----------------------------------------------------------------
         (1) |   .0001811   .0009358     0.19   0.847    -.0016532    .0020153
------------------------------------------------------------------------------

. 
. 
end of do-file
