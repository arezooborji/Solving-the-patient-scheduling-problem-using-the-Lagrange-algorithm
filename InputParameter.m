function Param = InpuParameter()

    p = 1:5;
    r = 1:5;
    d = 1:5;
    k = 1:5;
    g = 1:2;
    w = 1:5;
    n = 1:5;
    s = 1:5;

    pen_sc1 = 10;
    pen_sc2 = 10;
    pen_sc3 = 10;
    pen_sc4 = 10;
    pen_sc5 = 10;
    pen_sc6 = 10;
    pen_sc7 = 10;
    pen_sc8 = 10;
    pen_sc9 = 10;  
    
    Q = [5 6 8 9 10];
    AD = [10	15	20	15	18];
    DD = [5	6	8	9	10];
    LOS = [5	6	8	9	10];
    Age = [38	26	34	30	41];
    Min_Age = [15	15	15	15	15];
    Max_Age = [80	80	80	80	80];
    PRF =[0	0	0	1	0
0	0	1	1	0
1	0	1	0	0
0	0	1	1	0
0	0	1	1	0
];

RRF = [0	0	0	1	0
0	0	1	1	0
1	0	1	0	0
0	0	1	1	0
0	0	1	1	0
];

PG = [1	0
1	0
1	0
0	1
0	1
];

RG = [1	0
1	0
1	0
0	1
0	1];

RRT = [0	0	0	1	0
0	0	1	1	0
1	0	1	0	0
0	0	1	1	0
0	0	1	1	0
];

PRT = [0	0	0	1	0
0	0	1	1	0
1	0	1	0	0
0	0	1	1	0
0	0	1	1	0
];

PREQ = [0	0	1	0	0
];

SINGLE = [0	0	1	0	0
];    

PSN(1,:,:) = [0	1	1	0	0
0	1	1	1	0
0	1	0	1	0
1	0	0	0	1
1	0	0	0	0
];

PSN(2,:,:) = [0	1	0	1	0
1	1	1	1	0
1	1	0	1	1
1	1	1	1	1
0	0	0	1	1
];

PSN(3,:,:) = [1	0	1	1	0
1	1	0	0	1
1	0	1	1	0
0	0	0	0	0
0	1	1	1	0
];

PSN(4,:,:) = [0	0	0	0	0
1	1	0	1	0
1	1	0	1	1
0	1	1	0	1
0	0	0	1	1
];

PSN(5,:,:) = [1	1	0	1	0
0	1	0	0	1
1	0	0	1	1
0	1	0	1	0
1	0	1	1	0
];

RS = [0	1	1	0	0
0	1	1	1	0
0	1	0	1	0
1	0	0	0	1
1	0	0	0	0
];

SRPref = [0	1	1	0	0
0	1	1	1	0
0	1	0	1	0
1	0	0	0	1
1	0	0	0	0
];

PPrefRF = [0	1	1	0	0
0	1	1	1	0
0	1	0	1	0
1	0	0	0	1
1	0	0	0	0
];

Adm_Plan = [0	1	1	0	0
0	1	1	1	0
0	1	0	1	0
1	0	0	0	1
1	0	0	0	0
];

RD = [0	1	1	0	0
0	1	1	1	0
0	1	0	1	0
1	0	0	0	1
1	0	0	0	0
];

pr = [0	1	0	1	1
0	0	0	1	0
1	1	1	1	0
1	0	0	1	1
1	1	0	0	1
];

    Param.Q = Q;
    Param.AD = AD;
    Param.DD = DD;
    Param.LOS = LOS;
    Param.Age = Age;
    Param.Min_Age = Min_Age;
    Param.Max_Age = Max_Age;
    Param.PRF = PRF;
    Param.RRF = RRF;
    Param.PG = PG;
    Param.RG = RG;
    Param.RRT = RRT;
    Param.PRT = PRT;
    Param.PREQ = PREQ;
    Param.SINGLE = SINGLE;
    Param.PSN = PSN;
    Param.RS = RS;
    Param.SRPref = SRPref;
    Param.PPrefRF = PPrefRF;
    Param.Adm_Plan = Adm_Plan;
    Param.RD = RD;
    Param.pr = pr;
     
    Param.pen_sc1 = pen_sc1;
    Param.pen_sc2 = pen_sc2;
    Param.pen_sc3 = pen_sc3;
    Param.pen_sc4 = pen_sc4;
    Param.pen_sc5 = pen_sc5;
    Param.pen_sc6 = pen_sc6;
    Param.pen_sc7 = pen_sc7;
    Param.pen_sc8 = pen_sc8;
    Param.pen_sc9 = pen_sc9; 
    
    Param.p = p;
    Param.r = r;
    Param.d = d;
    Param.k = k;
    Param.g = g;
    Param.w = w;
    Param.n = n;
    Param.s = s;
        
end