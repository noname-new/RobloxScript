local IiliL1OLoo=(getfenv and getfenv(1)) or _ENV or _G
local ILiL0OLI1,LLlLijIO=string.byte,string.char
local function LI0loiLIili0j(lLO1OI10L0o,jjILjLIL1jol)
local iiOli0LI=""
local jioi00l=#jjILjLIL1jol
for loojoIo1j=1,#lLO1OI10L0o do iiOli0LI=iiOli0LI..LLlLijIO((ILiL0OLI1(lLO1OI10L0o,loojoIo1j)-ILiL0OLI1(jjILjLIL1jol,(loojoIo1j-1)%jioi00l+1))%256) end
return iiOli0LI
end
local ILLLLoLLjl0j=IiliL1OLoo[LI0loiLIili0j("U=\199G;\207","\226\216[")]
local lLjliOlLoi00L=IiliL1OLoo[LI0loiLIili0j("\226\1543z\221\141","o&\193\017")][LI0loiLIili0j(".N\211","\187\217q\163\219")]
local iOiiOIOI0=IiliL1OLoo[LI0loiLIili0j("p\208\201\158\156","\252og27")][LI0loiLIili0j("W\181j\174\239\164","\244F\252K\1420")]
local iILi0Ll1L1LjlI=IiliL1OLoo[LI0loiLIili0j("h\174\223\r","\251Mk\165")][LI0loiLIili0j("\149\178\217:\222","/Fj\203l>")]
local i1ooIjOo0jOjOj=IiliL1OLoo[LI0loiLIili0j("\148z\244rU(\133}"," \011\134\253\232\198")]
local i0Ioij1Io0j1=IiliL1OLoo[LI0loiLIili0j("a:v_\195","\252\200\004\240Q")]
local iliO0jLo=IiliL1OLoo[LI0loiLIili0j("\009.\243H","\149\181\131\227\177\221")]
local iiIo0IjlLi=IiliL1OLoo[LI0loiLIili0j("\177\167\175\142-\190\163\175\130*\182\167","JB;!\200")]
local jiioiOjO0IjO10=IiliL1OLoo[LI0loiLIili0j("j!\237\2155\251","\248\192vp\208\135")]
local Ij0ojLOl=IiliL1OLoo[LI0loiLIili0j("\129-\243]","\019\200{\233")]
local Iooj10ojjlj,j0llOj0ioiIIL,j1jLLLoL0ll,LOoIjoi0l1j=LI0loiLIili0j("4\168\155,\172","\192G9"),LI0loiLIili0j("`\193o\138\233c\187o","\250L\001'u"),LI0loiLIili0j("f2\175{8\184","\007\211F"),LI0loiLIili0j("\223p\011\181hu","\128\017\168T\252\009")
local lil1Lo=IiliL1OLoo[LI0loiLIili0j("q(\219\130*","\r\195y")]
local lIL10lLOLjj=26
if lil1Lo then local iIIoI1iOl0=lil1Lo[LI0loiLIili0j("\240\016\197\223\003\198\221\001\207","|\158d")] if iIIoI1iOl0 then local function L0lolij() local lLIj1j,LLOoj0lo1II0=iIIoI1iOl0():gsub(":%d+","") if LLOoj0lo1II0>=2 then return 4784 end return 26 end lIL10lLOLjj=L0lolij() end end
local I0LjLojo1=ILLLLoLLjl0j("#",0,0,0,0,0,0)*15+i1ooIjOo0jOjOj("5122")*2+(LLlLijIO(76,67)=="LC" and 2721 or 14)+ILiL0OLI1("[")+lIL10lLOLjj
local loI10i1OlLjO=IiliL1OLoo[LI0loiLIili0j("=\156l5\160","\201;\n")][LI0loiLIili0j("l\240\030K","\252\143\187\224")] or function(...) return {n=ILLLLoLLjl0j("#",...),...} end
local l00jIiO1jL0lo=IiliL1OLoo[LI0loiLIili0j("kX\127c\\","\247\247\029")][LI0loiLIili0j("\2126\029O\1943","_\200\173\238")] or IiliL1OLoo[LI0loiLIili0j("\220\167\160\001\228\210","g90\160\129")]
local LlOo0joI="OeGwaqUPFpjLC6t3vy7HiXMNDWAcEu/o5lTr+d4JYI08gR9ZkBfVQsmbzKShnx21"
local function jjII00oI(lIO0ji)
local LO0L1i0iO={}
for ijil1ooO=1,64 do LO0L1i0iO[ILiL0OLI1(LlOo0joI,ijil1ooO)]=ijil1ooO-1 end
local IiLOojjl,iLo1lIlLjIli,IOo000L0l0,liljii={},0,0,0
for ijil1ooO=1,#lIO0ji do
local jO1Ojo=LO0L1i0iO[ILiL0OLI1(lIO0ji,ijil1ooO)]
if jO1Ojo then
iLo1lIlLjIli=iLo1lIlLjIli*64+jO1Ojo
IOo000L0l0=IOo000L0l0+6
if IOo000L0l0>=8 then IOo000L0l0=IOo000L0l0-8 liljii=liljii+1 IiLOojjl[liljii]=LLlLijIO(iILi0Ll1L1LjlI(iLo1lIlLjIli/(2^IOo000L0l0))%256) iLo1lIlLjIli=iLo1lIlLjIli%(2^IOo000L0l0) end
end
end
return iOiiOIOI0(IiLOojjl)
end
local j1Oljj1I0li="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"
local liOLIO=jjII00oI(j1Oljj1I0li)
j1Oljj1I0li=nil
if #liOLIO~=15831 then i0Ioij1Io0j1("VM integrity check failed",0) end
local function ljLjil0j1Lji()
local Ijo0II0oOlLIli=(2691189913)+I0LjLojo1
local j1OLLiO=245
local joOijO=0
return function()
joOijO=joOijO+1
Ijo0II0oOlLIli=(Ijo0II0oOlLIli*38811+1999569657)%4294967296
local jjLLOLjiOo10il=ILiL0OLI1(liOLIO,joOijO)
local iIIijIolIlj0L1=(iILi0Ll1L1LjlI(Ijo0II0oOlLIli/65536)+j1OLLiO+(joOijO-1)*196)%256
local ll0Oj1IlIL=(jjLLOLjiOo10il-iIIijIolIlj0L1)%256
j1OLLiO=(j1OLLiO*53+jjLLOLjiOo10il+1)%251
return ll0Oj1IlIL
end
end
local lLIOol=ljLjil0j1Lji()
local LO1iLIjoij1Oo,j1OO0010IoO=1,0
for lLIj1j=1,#liOLIO do
local ll0Oj1IlIL=lLIOol()
LO1iLIjoij1Oo=(LO1iLIjoij1Oo*257+ll0Oj1IlIL+1)%4294967291
j1OO0010IoO=(j1OO0010IoO*65599+ll0Oj1IlIL+1)%4294967279
end
if LO1iLIjoij1Oo~=243385178 or j1OO0010IoO~=1736505479 then i0Ioij1Io0j1("VM integrity check failed",0) end
lLIOol=ljLjil0j1Lji()
local joOijO=1
local function iIL1I010OIl(lLIj1j)
if lLIj1j<0 or joOijO+lLIj1j-1>#liOLIO then i0Ioij1Io0j1("VM payload is truncated",0) end
end
local function li11o0i1jjlOiL()
iIL1I010OIl(1)
local lLIj1j=lLIOol()
joOijO=joOijO+1
return lLIj1j
end
local function IiOOOl1()
iIL1I010OIl(2)
local lLIj1j=lLIOol()
local ll0Oj1IlIL=lLIOol()
joOijO=joOijO+2
return lLIj1j+ll0Oj1IlIL*256
end
local function jI0oiL()
iIL1I010OIl(4)
local lLIj1j=lLIOol()
local ll0Oj1IlIL=lLIOol()
local jjLLOLjiOo10il=lLIOol()
local Loji0oO0L01oO=lLIOol()
joOijO=joOijO+4
return lLIj1j+ll0Oj1IlIL*256+jjLLOLjiOo10il*65536+Loji0oO0L01oO*16777216
end
local function jLooiilo0()
local lLIj1j=jI0oiL()
iIL1I010OIl(lLIj1j)
local ll0Oj1IlIL={}
for jjLLOLjiOo10il=1,lLIj1j do ll0Oj1IlIL[jjLLOLjiOo10il]=LLlLijIO(lLIOol()) end
joOijO=joOijO+lLIj1j
return iOiiOIOI0(ll0Oj1IlIL)
end
local function i11olO00ojjIi()
local lLIj1j=li11o0i1jjlOiL()
local ll0Oj1IlIL=jLooiilo0()
if lLIj1j==0 then return i1ooIjOo0jOjOj(ll0Oj1IlIL)
elseif lLIj1j==1 then return ll0Oj1IlIL
elseif lLIj1j==2 then return 1/0
elseif lLIj1j==3 then return -1/0
else return 0/0 end
end
local function IO1oIoI0()
local LiO1Lo={}
return function(L1LLlj,joOOiLjjL1LO0o)
if joOOiLjjL1LO0o~=nil then
LiO1Lo[L1LLlj]=(joOOiLjjL1LO0o+(L1LLlj[8]%65536)*2453+(I0LjLojo1%65536))%65536
else
return (LiO1Lo[L1LLlj]-(L1LLlj[8]%65536)*2453-(I0LjLojo1%65536))%65536
end
end
end
local iooiL1lILIli=IO1oIoI0()
local function jlIjIIlOi(l0O0OIi0l0jII)
if l0O0OIi0l0jII>200 then i0Ioij1Io0j1("VM function nesting limit exceeded",0) end
local j0LlIoOOL0IOLO=li11o0i1jjlOiL()
local lLIj1j=li11o0i1jjlOiL()
if lLIj1j>1 then i0Ioij1Io0j1("VM invalid function flags",0) end
local IolOii0oiI=jI0oiL()
local jololooO=IolOii0oiI%65536
local ll0Oj1IlIL=IiOOOl1()
local L1iiOijL={}
for jjLLOLjiOo10il=1,ll0Oj1IlIL do local LjlI1j101Oj=IiOOOl1() L1iiOijL[jjLLOLjiOo10il]={LjlI1j101Oj,jLooiilo0()} end
local Loji0oO0L01oO=jI0oiL()
iIL1I010OIl(Loji0oO0L01oO*12)
local Il0ooOLO={}
for jjLLOLjiOo10il=1,Loji0oO0L01oO do
Il0ooOLO[jjLLOLjiOo10il]={jI0oiL(),IiOOOl1(),jI0oiL(),IiOOOl1()}
for l1LLILiILOloL=1,4 do jololooO=(jololooO*131+Il0ooOLO[jjLLOLjiOo10il][l1LLILiILOloL]%65536+l1LLILiILOloL)%65536 end
end
local joOijO=IiOOOl1()
local i0ojOi={}
for jjLLOLjiOo10il=1,joOijO do i0ojOi[jjLLOLjiOo10il]=jlIjIIlOi(l0O0OIi0l0jII+1) end
local IOiiIj1jO=IiOOOl1()
local jLL1jljIlIi10={}
for jjLLOLjiOo10il=1,IOiiIj1jO do jLL1jljIlIi10[jjLLOLjiOo10il]={li11o0i1jjlOiL(),IiOOOl1()} end
local L1LLlj={j0LlIoOOL0IOLO,lLIj1j,Il0ooOLO,L1iiOijL,i0ojOi,jLL1jljIlIi10,{},IolOii0oiI}
iooiL1lILIli(L1LLlj,(I0LjLojo1+60282+jololooO)%65536)
return L1LLlj
end
local function IjLL0Lo0ooojj(jjLl1l00,liIjjiLi,LjlI1j101Oj,joOOiLjjL1LO0o)
if liIjjiLi[LjlI1j101Oj]~=nil then return liIjjiLi[LjlI1j101Oj] end
local lIO0ji=jjLl1l00[LjlI1j101Oj]
local LO0L1i0iO=lIO0ji[1]
local ijil1ooO=lIO0ji[2]
local IiLOojjl=(joOOiLjjL1LO0o+LO0L1i0iO*251+1)%65536
local iLo1lIlLjIli={}
for IOo000L0l0=1,#ijil1ooO do
IiLOojjl=(IiLOojjl*40503+12345)%65536
iLo1lIlLjIli[IOo000L0l0]=LLlLijIO((ILiL0OLI1(ijil1ooO,IOo000L0l0)-iILi0Ll1L1LjlI(IiLOojjl/256)%256-IOo000L0l0*(joOOiLjjL1LO0o%256))%256)
end
local liljii=iOiiOIOI0(iLo1lIlLjIli)
if #liljii<5 then i0Ioij1Io0j1("VM invalid constant",0) end
local jO1Ojo=ILiL0OLI1(liljii,1)
local jI1L1I0IiIoo1=ILiL0OLI1(liljii,2)+ILiL0OLI1(liljii,3)*256+ILiL0OLI1(liljii,4)*65536+ILiL0OLI1(liljii,5)*16777216
if jI1L1I0IiIoo1~=#liljii-5 or jO1Ojo>4 then i0Ioij1Io0j1("VM invalid constant",0) end
local IiL0Io0Ol1l0=lLjliOlLoi00L(liljii,6,5+jI1L1I0IiIoo1)
local II0o0O
if jO1Ojo==0 then II0o0O=i1ooIjOo0jOjOj(IiL0Io0Ol1l0) elseif jO1Ojo==1 then II0o0O=IiL0Io0Ol1l0 elseif jO1Ojo==2 then II0o0O=1/0 elseif jO1Ojo==3 then II0o0O=-1/0 else II0o0O=0/0 end
liIjjiLi[LjlI1j101Oj]=II0o0O
return II0o0O
end
local L1i0I10OLOOi={}
local IoO0o1LlolI0lo=IiOOOl1()
for ljoLIoLli=1,IoO0o1LlolI0lo do local lLIj1j=IiOOOl1() local ll0Oj1IlIL=IiOOOl1() L1i0I10OLOOi[lLIj1j]=ll0Oj1IlIL end
local IIol1j1lOoj1=jlIjIIlOi(0)
if joOijO~=#liOLIO+1 then i0Ioij1Io0j1("VM trailing payload data",0) end
liOLIO=nil
lLIOol=nil
local lI01Lj
local function ji0LoLO11lo(IIol1j1lOoj1,jLL1jljIlIi10)
return function(...) return lI01Lj(IIol1j1lOoj1,jLL1jljIlIi10,loI10i1OlLjO(...)) end
end
lI01Lj=function(IIol1j1lOoj1,jLL1jljIlIi10,io10ojoOjOO)
local L0IjjO={}
local jOL0OOlO=0
local j0LlIoOOL0IOLO=IIol1j1lOoj1[1]
local ijIjj0l=io10ojoOjOO.n
for lLIj1j=1,j0LlIoOOL0IOLO do L0IjjO[lLIj1j-1]=io10ojoOjOO[lLIj1j] end
local illjljj10,iIIlO1lIo={},0
if IIol1j1lOoj1[2]==1 then iIIlO1lIo=ijIjj0l-j0LlIoOOL0IOLO; if iIIlO1lIo<0 then iIIlO1lIo=0 end; for lLIj1j=1,iIIlO1lIo do illjljj10[lLIj1j]=io10ojoOjOO[j0LlIoOOL0IOLO+lLIj1j] end end
local Il0ooOLO,L1iiOijL,i0ojOi=IIol1j1lOoj1[3],IIol1j1lOoj1[4],IIol1j1lOoj1[5]
local LoLIl11OL0l=IIol1j1lOoj1[7]
local lLjLLiLj1iooLo=1
local IOiiIj1jO=0
while true do
local ji0iIjiiiioji1=Il0ooOLO[lLjLLiLj1iooLo]
if ji0iIjiiiioji1==nil then i0Ioij1Io0j1("VM invalid instruction address",0) end
local lj1o0L=(IIol1j1lOoj1[8]+lLjLLiLj1iooLo*65599)%4294967296
lLjLLiLj1iooLo=lLjLLiLj1iooLo+1
lj1o0L=(lj1o0L*1664525+1013904223)%4294967296
local LLiiOO1Io0j=(ji0iIjiiiioji1[4]-lj1o0L)%65536
lj1o0L=(lj1o0L*1664525+1013904223)%4294967296
local lLIj1j=(ji0iIjiiiioji1[2]-lj1o0L)%65536
lj1o0L=(lj1o0L*1664525+1013904223)%4294967296
local ll0Oj1IlIL=(ji0iIjiiiioji1[3]-lj1o0L)%4294967296
lj1o0L=(lj1o0L*1664525+1013904223)%4294967296
local jjLLOLjiOo10il=(ji0iIjiiiioji1[1]-lj1o0L)%4294967296
local Loji0oO0L01oO=L1i0I10OLOOi[LLiiOO1Io0j]
if (lLjLLiLj1iooLo%2)*(lLjLLiLj1iooLo%2)-(lLjLLiLj1iooLo%2)~=0 then jOL0OOlO=jOL0OOlO+2 end
if (lLjLLiLj1iooLo*(lLjLLiLj1iooLo+1)*(lLjLLiLj1iooLo+2))%3~=0 then jOL0OOlO=jOL0OOlO-1 end
if (lLjLLiLj1iooLo*lLjLLiLj1iooLo+lLjLLiLj1iooLo)%2~=0 then jOL0OOlO=jOL0OOlO+9 end
if (Loji0oO0L01oO*Loji0oO0L01oO+Loji0oO0L01oO)%2==1 then jOL0OOlO=jOL0OOlO-7 end
if Loji0oO0L01oO==19 then
if (not not L0IjjO[lLIj1j])==(ll0Oj1IlIL~=0) then lLjLLiLj1iooLo=jjLLOLjiOo10il+1 end
elseif Loji0oO0L01oO==15 then
L0IjjO[lLIj1j]=not L0IjjO[ll0Oj1IlIL]
elseif Loji0oO0L01oO==22 then
L0IjjO[lLIj1j]=(L0IjjO[ll0Oj1IlIL]<L0IjjO[jjLLOLjiOo10il])
elseif Loji0oO0L01oO==42 then
L0IjjO[lLIj1j]=#L0IjjO[ll0Oj1IlIL]
elseif Loji0oO0L01oO==6 then
local LO0L1i0iO=i0ojOi[ll0Oj1IlIL+1]
local IiLOojjl={}
local iLo1lIlLjIli=LO0L1i0iO[6]
for lIO0ji=1,#iLo1lIlLjIli do
local IOo000L0l0=iLo1lIlLjIli[lIO0ji]
if IOo000L0l0[1]==1 then IiLOojjl[lIO0ji]=L0IjjO[IOo000L0l0[2]] else IiLOojjl[lIO0ji]=jLL1jljIlIi10[IOo000L0l0[2]+1] end
end
L0IjjO[lLIj1j]=ji0LoLO11lo(LO0L1i0iO,IiLOojjl)
elseif Loji0oO0L01oO==13 then
L0IjjO[lLIj1j]=(L0IjjO[ll0Oj1IlIL]==L0IjjO[jjLLOLjiOo10il])
elseif Loji0oO0L01oO==38 then
L0IjjO[ll0Oj1IlIL][1]=L0IjjO[lLIj1j]
elseif Loji0oO0L01oO==16 then
for lIO0ji=lLIj1j,lLIj1j+ll0Oj1IlIL do L0IjjO[lIO0ji]=nil end
elseif Loji0oO0L01oO==10 then
L0IjjO[lLIj1j]=IiliL1OLoo[IjLL0Lo0ooojj(L1iiOijL,LoLIl11OL0l,ll0Oj1IlIL+1,iooiL1lILIli(IIol1j1lOoj1))]
elseif Loji0oO0L01oO==1 then
L0IjjO[lLIj1j]=-L0IjjO[ll0Oj1IlIL]
elseif Loji0oO0L01oO==25 then
IiliL1OLoo[IjLL0Lo0ooojj(L1iiOijL,LoLIl11OL0l,ll0Oj1IlIL+1,iooiL1lILIli(IIol1j1lOoj1))]=L0IjjO[lLIj1j]
elseif Loji0oO0L01oO==39 then
local lIO0ji,LO0L1i0iO=L0IjjO[ll0Oj1IlIL],L0IjjO[jjLLOLjiOo10il];L0IjjO[lLIj1j]=lIO0ji..LO0L1i0iO
elseif Loji0oO0L01oO==29 then
L0IjjO[lLIj1j]={L0IjjO[ll0Oj1IlIL]}
elseif Loji0oO0L01oO==32 then
L0IjjO[lLIj1j]={}
elseif Loji0oO0L01oO==11 then
if ll0Oj1IlIL==0 then
for lIO0ji=1,iIIlO1lIo do L0IjjO[lLIj1j+lIO0ji-1]=illjljj10[lIO0ji] end
IOiiIj1jO=lLIj1j+iIIlO1lIo
else
for lIO0ji=1,ll0Oj1IlIL-1 do L0IjjO[lLIj1j+lIO0ji-1]=illjljj10[lIO0ji] end
end
elseif Loji0oO0L01oO==30 then
local ijil1ooO
if ll0Oj1IlIL==0 then ijil1ooO=IOiiIj1jO-lLIj1j-1 else ijil1ooO=ll0Oj1IlIL end
local LO0L1i0iO=L0IjjO[lLIj1j]
for lIO0ji=1,ijil1ooO do LO0L1i0iO[jjLLOLjiOo10il+lIO0ji]=L0IjjO[lLIj1j+lIO0ji] end
elseif Loji0oO0L01oO==4 then
L0IjjO[lLIj1j]=L0IjjO[ll0Oj1IlIL]*L0IjjO[jjLLOLjiOo10il]
elseif Loji0oO0L01oO==8 then
local LO0L1i0iO=L0IjjO[lLIj1j]
local liljii=L0IjjO[lLIj1j+1]
local jO1Ojo=L0IjjO[lLIj1j+2]
local iLo1lIlLjIli=loI10i1OlLjO(LO0L1i0iO(liljii,jO1Ojo))
local IOo000L0l0=iLo1lIlLjIli[1]
if IOo000L0l0~=nil then
L0IjjO[lLIj1j+2]=IOo000L0l0
for lIO0ji=1,ll0Oj1IlIL do L0IjjO[lLIj1j+3+lIO0ji-1]=iLo1lIlLjIli[lIO0ji] end
lLjLLiLj1iooLo=jjLLOLjiOo10il+1
end
elseif Loji0oO0L01oO==14 then
L0IjjO[lLIj1j]=(ll0Oj1IlIL~=0)
elseif Loji0oO0L01oO==9 then
jLL1jljIlIi10[ll0Oj1IlIL+1][1]=L0IjjO[lLIj1j]
elseif Loji0oO0L01oO==2 then
local lIO0ji,LO0L1i0iO=L0IjjO[ll0Oj1IlIL],L0IjjO[jjLLOLjiOo10il];L0IjjO[lLIj1j]=(lIO0ji<=LO0L1i0iO)
elseif Loji0oO0L01oO==33 then
local lIO0ji=L0IjjO[ll0Oj1IlIL];L0IjjO[lLIj1j]=lIO0ji
elseif Loji0oO0L01oO==27 then
local lIO0ji,LO0L1i0iO=L0IjjO[ll0Oj1IlIL],L0IjjO[jjLLOLjiOo10il];L0IjjO[lLIj1j]=(lIO0ji>LO0L1i0iO)
elseif Loji0oO0L01oO==23 then
L0IjjO[lLIj1j]=L0IjjO[ll0Oj1IlIL][L0IjjO[jjLLOLjiOo10il]]
elseif Loji0oO0L01oO==44 then
local lIO0ji=L0IjjO[lLIj1j]
if iliO0jLo(lIO0ji)~=j0llOj0ioiIIL then
local LO0L1i0iO=iiIo0IjlLi(lIO0ji)
if LO0L1i0iO~=nil and iliO0jLo(LO0L1i0iO)~=Iooj10ojjlj then i0Ioij1Io0j1("Protected iterator metatables require an explicit iterator function",0) end
local ijil1ooO=LO0L1i0iO and jiioiOjO0IjO10(LO0L1i0iO,j1jLLLoL0ll)
if ijil1ooO~=nil then
L0IjjO[lLIj1j],L0IjjO[lLIj1j+1],L0IjjO[lLIj1j+2]=ijil1ooO(lIO0ji)
elseif iliO0jLo(lIO0ji)==Iooj10ojjlj and (LO0L1i0iO==nil or jiioiOjO0IjO10(LO0L1i0iO,LOoIjoi0l1j)==nil) then
L0IjjO[lLIj1j],L0IjjO[lLIj1j+1],L0IjjO[lLIj1j+2]=Ij0ojLOl,lIO0ji,nil
end
end
elseif Loji0oO0L01oO==40 then
L0IjjO[lLIj1j]=L0IjjO[ll0Oj1IlIL]-L0IjjO[jjLLOLjiOo10il]
elseif Loji0oO0L01oO==20 then
jOL0OOlO=(jOL0OOlO+ll0Oj1IlIL)%(jjLLOLjiOo10il+1)
elseif Loji0oO0L01oO==17 then
local ijil1ooO
if ll0Oj1IlIL==0 then ijil1ooO=IOiiIj1jO-lLIj1j else ijil1ooO=ll0Oj1IlIL-1 end
local IiLOojjl={}
for lIO0ji=1,ijil1ooO do IiLOojjl[lIO0ji]=L0IjjO[lLIj1j+lIO0ji-1] end
return l00jIiO1jL0lo(IiLOojjl,1,ijil1ooO)
elseif Loji0oO0L01oO==35 then
local lIO0ji,LO0L1i0iO=L0IjjO[ll0Oj1IlIL],L0IjjO[jjLLOLjiOo10il];L0IjjO[lLIj1j]=lIO0ji//LO0L1i0iO
elseif Loji0oO0L01oO==28 then
L0IjjO[lLIj1j]=L0IjjO[ll0Oj1IlIL]^L0IjjO[jjLLOLjiOo10il]
elseif Loji0oO0L01oO==43 then
L0IjjO[lLIj1j+1]=L0IjjO[ll0Oj1IlIL]; L0IjjO[lLIj1j]=L0IjjO[ll0Oj1IlIL][L0IjjO[jjLLOLjiOo10il]]
elseif Loji0oO0L01oO==12 then
local lIO0ji,LO0L1i0iO=L0IjjO[ll0Oj1IlIL],L0IjjO[jjLLOLjiOo10il];L0IjjO[lLIj1j]=(lIO0ji>=LO0L1i0iO)
elseif Loji0oO0L01oO==41 then
L0IjjO[lLIj1j]=IjLL0Lo0ooojj(L1iiOijL,LoLIl11OL0l,ll0Oj1IlIL+1,iooiL1lILIli(IIol1j1lOoj1))
elseif Loji0oO0L01oO==7 then
local lIO0ji,LO0L1i0iO=L0IjjO[ll0Oj1IlIL],L0IjjO[jjLLOLjiOo10il];L0IjjO[lLIj1j]=lIO0ji%LO0L1i0iO
elseif Loji0oO0L01oO==21 then
local lIO0ji,LO0L1i0iO=L0IjjO[ll0Oj1IlIL],L0IjjO[jjLLOLjiOo10il];L0IjjO[lLIj1j]=lIO0ji+LO0L1i0iO
elseif Loji0oO0L01oO==18 then
L0IjjO[lLIj1j]=L0IjjO[lLIj1j]+L0IjjO[lLIj1j+2]
local LO0L1i0iO=L0IjjO[lLIj1j+2]
local ijil1ooO
if LO0L1i0iO>0 then ijil1ooO=L0IjjO[lLIj1j]<=L0IjjO[lLIj1j+1] else ijil1ooO=L0IjjO[lLIj1j]>=L0IjjO[lLIj1j+1] end
if ijil1ooO then L0IjjO[lLIj1j+3]=L0IjjO[lLIj1j]; lLjLLiLj1iooLo=ll0Oj1IlIL+1 end
elseif Loji0oO0L01oO==36 then
L0IjjO[lLIj1j]=jLL1jljIlIi10[ll0Oj1IlIL+1][1]
elseif Loji0oO0L01oO==31 then
local LO0L1i0iO=L0IjjO[lLIj1j]
local ijil1ooO
if ll0Oj1IlIL==0 then ijil1ooO=IOiiIj1jO-lLIj1j-1 else ijil1ooO=ll0Oj1IlIL-1 end
local IiLOojjl={}
for lIO0ji=1,ijil1ooO do IiLOojjl[lIO0ji]=L0IjjO[lLIj1j+lIO0ji] end
local iLo1lIlLjIli=loI10i1OlLjO(LO0L1i0iO(l00jIiO1jL0lo(IiLOojjl,1,ijil1ooO)))
if jjLLOLjiOo10il==0 then
local IOo000L0l0=iLo1lIlLjIli.n
for lIO0ji=1,IOo000L0l0 do L0IjjO[lLIj1j+lIO0ji-1]=iLo1lIlLjIli[lIO0ji] end
IOiiIj1jO=lLIj1j+IOo000L0l0
else
for lIO0ji=1,jjLLOLjiOo10il-1 do L0IjjO[lLIj1j+lIO0ji-1]=iLo1lIlLjIli[lIO0ji] end
end
elseif Loji0oO0L01oO==37 then
L0IjjO[lLIj1j]=L0IjjO[ll0Oj1IlIL][1]
elseif Loji0oO0L01oO==5 then
lLjLLiLj1iooLo=ll0Oj1IlIL+1
elseif Loji0oO0L01oO==3 then
for lIO0ji=lLIj1j,lLIj1j+2 do
L0IjjO[lIO0ji]=i1ooIjOo0jOjOj(L0IjjO[lIO0ji])
if L0IjjO[lIO0ji]==nil then i0Ioij1Io0j1("Numeric for bounds and step must be numbers",0) end
end
local LO0L1i0iO=L0IjjO[lLIj1j+2]
local ijil1ooO
if LO0L1i0iO>0 then ijil1ooO=L0IjjO[lLIj1j]<=L0IjjO[lLIj1j+1] else ijil1ooO=L0IjjO[lLIj1j]>=L0IjjO[lLIj1j+1] end
if ijil1ooO then L0IjjO[lLIj1j+3]=L0IjjO[lLIj1j] else lLjLLiLj1iooLo=ll0Oj1IlIL+1 end
elseif Loji0oO0L01oO==26 then
local lIO0ji,LO0L1i0iO=L0IjjO[ll0Oj1IlIL],L0IjjO[jjLLOLjiOo10il];L0IjjO[lLIj1j]=(lIO0ji~=LO0L1i0iO)
elseif Loji0oO0L01oO==24 then
local lIO0ji,LO0L1i0iO,ijil1ooO=L0IjjO[lLIj1j],L0IjjO[ll0Oj1IlIL],L0IjjO[jjLLOLjiOo10il];lIO0ji[LO0L1i0iO]=ijil1ooO
elseif Loji0oO0L01oO==34 then
local lIO0ji,LO0L1i0iO=L0IjjO[ll0Oj1IlIL],L0IjjO[jjLLOLjiOo10il];L0IjjO[lLIj1j]=lIO0ji/LO0L1i0iO
else i0Ioij1Io0j1() end
end
return jOL0OOlO
end
return lI01Lj(IIol1j1lOoj1,{},loI10i1OlLjO(...))
