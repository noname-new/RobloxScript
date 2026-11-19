local iO1il0jLI1l=(getfenv and getfenv(1)) or _ENV or _G
local LilL0ILLj01lO,LjjiLOoo0L0O=string.byte,string.char
local function ILII0000i(iOoIOj,j10ollL0IL1)
local il100oOiLooo0=""
local jli0L1OIjij1lo=#j10ollL0IL1
for l1oiO1i=1,#iOoIOj do il100oOiLooo0=il100oOiLooo0..LjjiLOoo0L0O((LilL0ILLj01lO(iOoIOj,l1oiO1i)-LilL0ILLj01lO(j10ollL0IL1,(l1oiO1i-1)%jli0L1OIjij1lo+1))%256) end
return il100oOiLooo0
end
local iILj1oLoO=iO1il0jLI1l[ILII0000i("J\137\248\015:\152","\215$\140\170")]
local LjLlLIL=iO1il0jLI1l[ILII0000i("\150\002\136\015\145\245","#\142\022\166")][ILII0000i("\163\241\182","0|T\215\247")]
local IjOI0lo0ol0=iO1il0jLI1l[ILII0000i("\176\201*\136\225","<h\200\028|<")][ILII0000i("\006\197t\210\233A","\163V\006o\136\205_")]
local L10lLliojLO=iO1il0jLI1l[ILII0000i("i\249\158d","\252\152*")][ILII0000i("\018\132\180\027\138","\172\024E")]
local L1jj0jo=iO1il0jLI1l[ILII0000i("\135\245\161\128\019Zx\248","\019\1343\011\166\248")]
local il11IiOO0Il=iO1il0jLI1l[ILII0000i("\196\203\190\169|","_YL:\n!\229")]
local lOiiO0O=iO1il0jLI1l[ILII0000i("\175\212\2531",";[\141\204\142")]
local iOIijIIOO10=iO1il0jLI1l[ILII0000i("B\206\180_\141m\006O\202\162^\141","\219i@\242(\249\165")]
local ij1iLL0LoIo1=iO1il0jLI1l[ILII0000i("q\225\024f _","\255\128\161\255\187\235\015")]
local lI0LI0jjjI0=iO1il0jLI1l[ILII0000i("~>|\021","\016\217\004\161")]
local jioillLL,lj0loIi1Il00jo,jiloL0O1lI,jjLLOO11i0=ILII0000i("\235\249\166\144$","w\152D$\191\239"),ILII0000i("x$(\r\134\024)\024","\018\175\186\170"),ILII0000i(")9\031Q\184F","\202\218\182\221S\212\145"),ILII0000i("\156\229v\247\160\158","=\134\019\15042>")
local II1OlI=iO1il0jLI1l[ILII0000i("\029\196q)\014","\185_\015\180\167#\230")]
local loL0LlOll=93
if II1OlI then local jI1IojlOl=II1OlI[ILII0000i("\026\233N\200\251\008\216P\208","\166w\237e\150")] if jI1IojlOl then local function i1ilLl00lL() local loLjOi1,llOoOL1Oo=jI1IojlOl():gsub(":%d+","") if llOoOL1Oo>=2 then return 6885 end return 93 end loL0LlOll=i1ilLl00lL() end end
local j1IOOilO0IiLO=(LjjiLOoo0L0O(79,73)=="OI" and 8636 or 13)+iILj1oLoO("#",0,0,0,0)*27+LilL0ILLj01lO("q")+loL0LlOll+L1jj0jo("1561")*6
local LjIo0j=iO1il0jLI1l[ILII0000i("Rnn\238\161","\222\r\012\130<\025K")][ILII0000i("C\170\187=","\211IX\210")] or function(...) return {n=iILj1oLoO("#",...),...} end
local L1IojOiOji=iO1il0jLI1l[ILII0000i("\190\254\165t\130","J\157C\008\029\175\155")][ILII0000i("#\205\197|Y]","\174_U\027\246\242")] or iO1il0jLI1l[ILII0000i("H\190\221\143t\022","\211Pm.\017\171")]
local LI1OL1j00="TnzrmFdNUa3SBfyuxJw0CZ+1eK/DtLiAEX8k2Ws9R4lHIbqV6GQghO7PvpYcMo5j"
local function i01O0Ij0ii00l(jjoOoO)
local LoLjI1iolL11l={}
for LLO1OL0Oo=1,64 do LoLjI1iolL11l[LilL0ILLj01lO(LI1OL1j00,LLO1OL0Oo)]=LLO1OL0Oo-1 end
local LIj0lj01j,lIlOilj1lIjlL,IIj0Oo0Ol00I,lOooj10L={},0,0,0
for LLO1OL0Oo=1,#jjoOoO do
local jLILOi=LoLjI1iolL11l[LilL0ILLj01lO(jjoOoO,LLO1OL0Oo)]
if jLILOi then
lIlOilj1lIjlL=lIlOilj1lIjlL*64+jLILOi
IIj0Oo0Ol00I=IIj0Oo0Ol00I+6
if IIj0Oo0Ol00I>=8 then IIj0Oo0Ol00I=IIj0Oo0Ol00I-8 lOooj10L=lOooj10L+1 LIj0lj01j[lOooj10L]=LjjiLOoo0L0O(L10lLliojLO(lIlOilj1lIjlL/(2^IIj0Oo0Ol00I))%256) lIlOilj1lIjlL=lIlOilj1lIjlL%(2^IIj0Oo0Ol00I) end
end
end
return IjOI0lo0ol0(LIj0lj01j)
end
local joL0oOL1j1O="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"
local iILliljLLIi=i01O0Ij0ii00l(joL0oOL1j1O)
joL0oOL1j1O=nil
if #iILliljLLIi~=15857 then il11IiOO0Il("VM integrity check failed",0) end
local function lIljO00iii0Il0()
local lj0jLl1oI=(625602623)+j1IOOilO0IiLO
local looj0j1jl=35
local llLjijioOL01L=0
return function()
llLjijioOL01L=llLjijioOL01L+1
lj0jLl1oI=(lj0jLl1oI*62965+3768439529)%4294967296
local IlOjlj=LilL0ILLj01lO(iILliljLLIi,llLjijioOL01L)
local j0ji0ojjjlOI=(L10lLliojLO(lj0jLl1oI/65536)+looj0j1jl+(llLjijioOL01L-1)*198)%256
local I1LlO10lO0=(IlOjlj-j0ji0ojjjlOI)%256
looj0j1jl=(looj0j1jl*53+IlOjlj+1)%251
return I1LlO10lO0
end
end
local L1IIllojjiO=lIljO00iii0Il0()
local ii10L1lI,jO0OiIiiOlI1Oi=1,0
for loLjOi1=1,#iILliljLLIi do
local I1LlO10lO0=L1IIllojjiO()
ii10L1lI=(ii10L1lI*257+I1LlO10lO0+1)%4294967291
jO0OiIiiOlI1Oi=(jO0OiIiiOlI1Oi*65599+I1LlO10lO0+1)%4294967279
end
if ii10L1lI~=1690878102 or jO0OiIiiOlI1Oi~=3903797612 then il11IiOO0Il("VM integrity check failed",0) end
L1IIllojjiO=lIljO00iii0Il0()
local llLjijioOL01L=1
local function Li1joOO0OojjO(loLjOi1)
if loLjOi1<0 or llLjijioOL01L+loLjOi1-1>#iILliljLLIi then il11IiOO0Il("VM payload is truncated",0) end
end
local function i1LIoojo0jo()
Li1joOO0OojjO(1)
local loLjOi1=L1IIllojjiO()
llLjijioOL01L=llLjijioOL01L+1
return loLjOi1
end
local function IlIloI1LiLiL()
Li1joOO0OojjO(2)
local loLjOi1=L1IIllojjiO()
local I1LlO10lO0=L1IIllojjiO()
llLjijioOL01L=llLjijioOL01L+2
return loLjOi1+I1LlO10lO0*256
end
local function I01jIO01Lo()
Li1joOO0OojjO(4)
local loLjOi1=L1IIllojjiO()
local I1LlO10lO0=L1IIllojjiO()
local IlOjlj=L1IIllojjiO()
local jlOo1LI1LO=L1IIllojjiO()
llLjijioOL01L=llLjijioOL01L+4
return loLjOi1+I1LlO10lO0*256+IlOjlj*65536+jlOo1LI1LO*16777216
end
local function loOL0lI0I()
local loLjOi1=I01jIO01Lo()
Li1joOO0OojjO(loLjOi1)
local I1LlO10lO0={}
for IlOjlj=1,loLjOi1 do I1LlO10lO0[IlOjlj]=LjjiLOoo0L0O(L1IIllojjiO()) end
llLjijioOL01L=llLjijioOL01L+loLjOi1
return IjOI0lo0ol0(I1LlO10lO0)
end
local function LlLOoL0O()
local loLjOi1=i1LIoojo0jo()
local I1LlO10lO0=loOL0lI0I()
if loLjOi1==0 then return L1jj0jo(I1LlO10lO0)
elseif loLjOi1==1 then return I1LlO10lO0
elseif loLjOi1==2 then return 1/0
elseif loLjOi1==3 then return -1/0
else return 0/0 end
end
local function L01ljLi()
local lLiIj1o0o10L0l={}
return function(i0OjoIo1jjI,iIj0oijLL)
if iIj0oijLL~=nil then
lLiIj1o0o10L0l[i0OjoIo1jjI]=(iIj0oijLL+(i0OjoIo1jjI[8]%65536)*37026+(j1IOOilO0IiLO%65536))%65536
else
return (lLiIj1o0o10L0l[i0OjoIo1jjI]-(i0OjoIo1jjI[8]%65536)*37026-(j1IOOilO0IiLO%65536))%65536
end
end
end
local Liii10i0L0=L01ljLi()
local function liLlOjoL1Ooi(IoI0lojjllIi)
if IoI0lojjllIi>200 then il11IiOO0Il("VM function nesting limit exceeded",0) end
local ij1lI1OO1=i1LIoojo0jo()
local loLjOi1=i1LIoojo0jo()
if loLjOi1>1 then il11IiOO0Il("VM invalid function flags",0) end
local i1j0iiojO10=I01jIO01Lo()
local ILL1oO=i1j0iiojO10%65536
local I1LlO10lO0=IlIloI1LiLiL()
local lOjOj1jlji1OL={}
for IlOjlj=1,I1LlO10lO0 do local I00l1i1=IlIloI1LiLiL() lOjOj1jlji1OL[IlOjlj]={I00l1i1,loOL0lI0I()} end
local jlOo1LI1LO=I01jIO01Lo()
Li1joOO0OojjO(jlOo1LI1LO*12)
local LloIijI1l={}
for IlOjlj=1,jlOo1LI1LO do
LloIijI1l[IlOjlj]={I01jIO01Lo(),IlIloI1LiLiL(),IlIloI1LiLiL(),I01jIO01Lo()}
for iII1OO1010i=1,4 do ILL1oO=(ILL1oO*131+LloIijI1l[IlOjlj][iII1OO1010i]%65536+iII1OO1010i)%65536 end
end
local llLjijioOL01L=IlIloI1LiLiL()
local lLjl0iL={}
for IlOjlj=1,llLjijioOL01L do lLjl0iL[IlOjlj]=liLlOjoL1Ooi(IoI0lojjllIi+1) end
local IjjOloiLLOOoj=IlIloI1LiLiL()
local iIlo1O1lOlLI={}
for IlOjlj=1,IjjOloiLLOOoj do iIlo1O1lOlLI[IlOjlj]={i1LIoojo0jo(),IlIloI1LiLiL()} end
local i0OjoIo1jjI={ij1lI1OO1,loLjOi1,LloIijI1l,lOjOj1jlji1OL,lLjl0iL,iIlo1O1lOlLI,{},i1j0iiojO10}
Liii10i0L0(i0OjoIo1jjI,(j1IOOilO0IiLO+23012+ILL1oO)%65536)
return i0OjoIo1jjI
end
local function iLLjIl0L1j(IiIOiILOjO,jIo0Ooijo,I00l1i1,iIj0oijLL)
if jIo0Ooijo[I00l1i1]~=nil then return jIo0Ooijo[I00l1i1] end
local jjoOoO=IiIOiILOjO[I00l1i1]
local LoLjI1iolL11l=jjoOoO[1]
local LLO1OL0Oo=jjoOoO[2]
local LIj0lj01j=(iIj0oijLL+LoLjI1iolL11l*251+1)%65536
local lIlOilj1lIjlL={}
for IIj0Oo0Ol00I=1,#LLO1OL0Oo do
LIj0lj01j=(LIj0lj01j*40503+12345)%65536
lIlOilj1lIjlL[IIj0Oo0Ol00I]=LjjiLOoo0L0O((LilL0ILLj01lO(LLO1OL0Oo,IIj0Oo0Ol00I)-L10lLliojLO(LIj0lj01j/256)%256-IIj0Oo0Ol00I*(iIj0oijLL%256))%256)
end
local lOooj10L=IjOI0lo0ol0(lIlOilj1lIjlL)
if #lOooj10L<5 then il11IiOO0Il("VM invalid constant",0) end
local jLILOi=LilL0ILLj01lO(lOooj10L,1)
local iiij1OIlOL=LilL0ILLj01lO(lOooj10L,2)+LilL0ILLj01lO(lOooj10L,3)*256+LilL0ILLj01lO(lOooj10L,4)*65536+LilL0ILLj01lO(lOooj10L,5)*16777216
if iiij1OIlOL~=#lOooj10L-5 or jLILOi>4 then il11IiOO0Il("VM invalid constant",0) end
local llOl0Iiiij=LjLlLIL(lOooj10L,6,5+iiij1OIlOL)
local jj1LlOl0l
if jLILOi==0 then jj1LlOl0l=L1jj0jo(llOl0Iiiij) elseif jLILOi==1 then jj1LlOl0l=llOl0Iiiij elseif jLILOi==2 then jj1LlOl0l=1/0 elseif jLILOi==3 then jj1LlOl0l=-1/0 else jj1LlOl0l=0/0 end
jIo0Ooijo[I00l1i1]=jj1LlOl0l
return jj1LlOl0l
end
local l1O0LLo={}
local loOjlLjojo=IlIloI1LiLiL()
for LjIlO10iOo=1,loOjlLjojo do local loLjOi1=IlIloI1LiLiL() local I1LlO10lO0=IlIloI1LiLiL() l1O0LLo[loLjOi1]=I1LlO10lO0 end
local IL1lj0O=liLlOjoL1Ooi(0)
if llLjijioOL01L~=#iILliljLLIi+1 then il11IiOO0Il("VM trailing payload data",0) end
iILliljLLIi=nil
L1IIllojjiO=nil
local L1i1lojoL
local function Il0IiOio(IL1lj0O,iIlo1O1lOlLI)
return function(...) return L1i1lojoL(IL1lj0O,iIlo1O1lOlLI,LjIo0j(...)) end
end
L1i1lojoL=function(IL1lj0O,iIlo1O1lOlLI,j00OojL)
local ILi1oOOOi={}
local Iii1li=0
local ij1lI1OO1=IL1lj0O[1]
local IlIoojOiLOO1=j00OojL.n
for loLjOi1=1,ij1lI1OO1 do ILi1oOOOi[loLjOi1-1]=j00OojL[loLjOi1] end
local Loi1li1L,j1iOlIj={},0
if IL1lj0O[2]==1 then j1iOlIj=IlIoojOiLOO1-ij1lI1OO1; if j1iOlIj<0 then j1iOlIj=0 end; for loLjOi1=1,j1iOlIj do Loi1li1L[loLjOi1]=j00OojL[ij1lI1OO1+loLjOi1] end end
local LloIijI1l,lOjOj1jlji1OL,lLjl0iL=IL1lj0O[3],IL1lj0O[4],IL1lj0O[5]
local i0OiiO=IL1lj0O[7]
local Ilj0Ol1ojLiLo=1
local IjjOloiLLOOoj=0
while true do
local l1jiIl1jLoj=LloIijI1l[Ilj0Ol1ojLiLo]
if l1jiIl1jLoj==nil then il11IiOO0Il("VM invalid instruction address",0) end
local jLlIi0ioiLi1ji=(IL1lj0O[8]+Ilj0Ol1ojLiLo*65599)%4294967296
Ilj0Ol1ojLiLo=Ilj0Ol1ojLiLo+1
jLlIi0ioiLi1ji=(jLlIi0ioiLi1ji*1664525+1013904223)%4294967296
local lI1O0Oj=(l1jiIl1jLoj[2]-jLlIi0ioiLi1ji)%65536
jLlIi0ioiLi1ji=(jLlIi0ioiLi1ji*1664525+1013904223)%4294967296
local loLjOi1=(l1jiIl1jLoj[3]-jLlIi0ioiLi1ji)%65536
jLlIi0ioiLi1ji=(jLlIi0ioiLi1ji*1664525+1013904223)%4294967296
local I1LlO10lO0=(l1jiIl1jLoj[4]-jLlIi0ioiLi1ji)%4294967296
jLlIi0ioiLi1ji=(jLlIi0ioiLi1ji*1664525+1013904223)%4294967296
local IlOjlj=(l1jiIl1jLoj[1]-jLlIi0ioiLi1ji)%4294967296
local jlOo1LI1LO=l1O0LLo[lI1O0Oj]
if (jlOo1LI1LO*jlOo1LI1LO+jlOo1LI1LO)%2==1 then Iii1li=Iii1li-2 end
if (jlOo1LI1LO*jlOo1LI1LO)%4==2 then Iii1li=Iii1li+3 end
if (Ilj0Ol1ojLiLo%2)*(Ilj0Ol1ojLiLo%2)-(Ilj0Ol1ojLiLo%2)~=0 then Iii1li=Iii1li+9 end
if jlOo1LI1LO==23 then
for jjoOoO=loLjOi1,loLjOi1+I1LlO10lO0 do ILi1oOOOi[jjoOoO]=nil end
elseif jlOo1LI1LO==38 then
ILi1oOOOi[loLjOi1]=(ILi1oOOOi[I1LlO10lO0]<ILi1oOOOi[IlOjlj])
elseif jlOo1LI1LO==34 then
local jjoOoO=iLLjIl0L1j(lOjOj1jlji1OL,i0OiiO,I1LlO10lO0+1,Liii10i0L0(IL1lj0O));local LoLjI1iolL11l=ILi1oOOOi[loLjOi1];iO1il0jLI1l[jjoOoO]=LoLjI1iolL11l
elseif jlOo1LI1LO==41 then
ILi1oOOOi[loLjOi1]=(I1LlO10lO0~=0)
elseif jlOo1LI1LO==36 then
ILi1oOOOi[loLjOi1]=iIlo1O1lOlLI[I1LlO10lO0+1][1]
elseif jlOo1LI1LO==20 then
ILi1oOOOi[loLjOi1]=#ILi1oOOOi[I1LlO10lO0]
elseif jlOo1LI1LO==10 then
iIlo1O1lOlLI[I1LlO10lO0+1][1]=ILi1oOOOi[loLjOi1]
elseif jlOo1LI1LO==33 then
ILi1oOOOi[loLjOi1]=not ILi1oOOOi[I1LlO10lO0]
elseif jlOo1LI1LO==16 then
local jjoOoO,LoLjI1iolL11l=ILi1oOOOi[I1LlO10lO0],ILi1oOOOi[IlOjlj];ILi1oOOOi[loLjOi1]=(jjoOoO~=LoLjI1iolL11l)
elseif jlOo1LI1LO==18 then
if I1LlO10lO0==0 then
for jjoOoO=1,j1iOlIj do ILi1oOOOi[loLjOi1+jjoOoO-1]=Loi1li1L[jjoOoO] end
IjjOloiLLOOoj=loLjOi1+j1iOlIj
else
for jjoOoO=1,I1LlO10lO0-1 do ILi1oOOOi[loLjOi1+jjoOoO-1]=Loi1li1L[jjoOoO] end
end
elseif jlOo1LI1LO==37 then
ILi1oOOOi[loLjOi1]=(ILi1oOOOi[I1LlO10lO0]>=ILi1oOOOi[IlOjlj])
elseif jlOo1LI1LO==21 then
local jjoOoO,LoLjI1iolL11l=ILi1oOOOi[I1LlO10lO0],ILi1oOOOi[IlOjlj];ILi1oOOOi[loLjOi1]=jjoOoO..LoLjI1iolL11l
elseif jlOo1LI1LO==2 then
Ilj0Ol1ojLiLo=I1LlO10lO0+1
elseif jlOo1LI1LO==4 then
ILi1oOOOi[loLjOi1]=ILi1oOOOi[I1LlO10lO0]
elseif jlOo1LI1LO==15 then
local jjoOoO,LoLjI1iolL11l,LLO1OL0Oo=ILi1oOOOi[loLjOi1],ILi1oOOOi[I1LlO10lO0],ILi1oOOOi[IlOjlj];jjoOoO[LoLjI1iolL11l]=LLO1OL0Oo
elseif jlOo1LI1LO==9 then
Iii1li=(Iii1li+I1LlO10lO0)%(IlOjlj+1)
elseif jlOo1LI1LO==35 then
local LoLjI1iolL11l=ILi1oOOOi[loLjOi1]
local lOooj10L=ILi1oOOOi[loLjOi1+1]
local jLILOi=ILi1oOOOi[loLjOi1+2]
local lIlOilj1lIjlL=LjIo0j(LoLjI1iolL11l(lOooj10L,jLILOi))
local IIj0Oo0Ol00I=lIlOilj1lIjlL[1]
if IIj0Oo0Ol00I~=nil then
ILi1oOOOi[loLjOi1+2]=IIj0Oo0Ol00I
for jjoOoO=1,I1LlO10lO0 do ILi1oOOOi[loLjOi1+3+jjoOoO-1]=lIlOilj1lIjlL[jjoOoO] end
Ilj0Ol1ojLiLo=IlOjlj+1
end
elseif jlOo1LI1LO==8 then
ILi1oOOOi[loLjOi1+1]=ILi1oOOOi[I1LlO10lO0]; ILi1oOOOi[loLjOi1]=ILi1oOOOi[I1LlO10lO0][ILi1oOOOi[IlOjlj]]
elseif jlOo1LI1LO==43 then
ILi1oOOOi[loLjOi1]=ILi1oOOOi[I1LlO10lO0]-ILi1oOOOi[IlOjlj]
elseif jlOo1LI1LO==1 then
local jjoOoO,LoLjI1iolL11l=ILi1oOOOi[I1LlO10lO0],ILi1oOOOi[IlOjlj];ILi1oOOOi[loLjOi1]=(jjoOoO==LoLjI1iolL11l)
elseif jlOo1LI1LO==24 then
local LLO1OL0Oo
if I1LlO10lO0==0 then LLO1OL0Oo=IjjOloiLLOOoj-loLjOi1-1 else LLO1OL0Oo=I1LlO10lO0 end
local LoLjI1iolL11l=ILi1oOOOi[loLjOi1]
for jjoOoO=1,LLO1OL0Oo do LoLjI1iolL11l[IlOjlj+jjoOoO]=ILi1oOOOi[loLjOi1+jjoOoO] end
elseif jlOo1LI1LO==19 then
local jjoOoO,LoLjI1iolL11l=ILi1oOOOi[I1LlO10lO0],ILi1oOOOi[IlOjlj];ILi1oOOOi[loLjOi1]=(jjoOoO<=LoLjI1iolL11l)
elseif jlOo1LI1LO==12 then
ILi1oOOOi[loLjOi1]={ILi1oOOOi[I1LlO10lO0]}
elseif jlOo1LI1LO==40 then
local jjoOoO,LoLjI1iolL11l=ILi1oOOOi[I1LlO10lO0],ILi1oOOOi[IlOjlj];ILi1oOOOi[loLjOi1]=(jjoOoO>LoLjI1iolL11l)
elseif jlOo1LI1LO==32 then
local jjoOoO,LoLjI1iolL11l=ILi1oOOOi[I1LlO10lO0],ILi1oOOOi[IlOjlj];ILi1oOOOi[loLjOi1]=jjoOoO/LoLjI1iolL11l
elseif jlOo1LI1LO==26 then
if (not not ILi1oOOOi[loLjOi1])==(I1LlO10lO0~=0) then Ilj0Ol1ojLiLo=IlOjlj+1 end
elseif jlOo1LI1LO==3 then
ILi1oOOOi[loLjOi1]=iLLjIl0L1j(lOjOj1jlji1OL,i0OiiO,I1LlO10lO0+1,Liii10i0L0(IL1lj0O))
elseif jlOo1LI1LO==13 then
local LoLjI1iolL11l=ILi1oOOOi[loLjOi1]
local LLO1OL0Oo
if I1LlO10lO0==0 then LLO1OL0Oo=IjjOloiLLOOoj-loLjOi1-1 else LLO1OL0Oo=I1LlO10lO0-1 end
local LIj0lj01j={}
for jjoOoO=1,LLO1OL0Oo do LIj0lj01j[jjoOoO]=ILi1oOOOi[loLjOi1+jjoOoO] end
local lIlOilj1lIjlL=LjIo0j(LoLjI1iolL11l(L1IojOiOji(LIj0lj01j,1,LLO1OL0Oo)))
if IlOjlj==0 then
local IIj0Oo0Ol00I=lIlOilj1lIjlL.n
for jjoOoO=1,IIj0Oo0Ol00I do ILi1oOOOi[loLjOi1+jjoOoO-1]=lIlOilj1lIjlL[jjoOoO] end
IjjOloiLLOOoj=loLjOi1+IIj0Oo0Ol00I
else
for jjoOoO=1,IlOjlj-1 do ILi1oOOOi[loLjOi1+jjoOoO-1]=lIlOilj1lIjlL[jjoOoO] end
end
elseif jlOo1LI1LO==11 then
ILi1oOOOi[loLjOi1]=ILi1oOOOi[I1LlO10lO0]*ILi1oOOOi[IlOjlj]
elseif jlOo1LI1LO==28 then
local jjoOoO,LoLjI1iolL11l=ILi1oOOOi[I1LlO10lO0],ILi1oOOOi[IlOjlj];ILi1oOOOi[loLjOi1]=jjoOoO^LoLjI1iolL11l
elseif jlOo1LI1LO==27 then
ILi1oOOOi[loLjOi1]=ILi1oOOOi[loLjOi1]+ILi1oOOOi[loLjOi1+2]
local LoLjI1iolL11l=ILi1oOOOi[loLjOi1+2]
local LLO1OL0Oo
if LoLjI1iolL11l>0 then LLO1OL0Oo=ILi1oOOOi[loLjOi1]<=ILi1oOOOi[loLjOi1+1] else LLO1OL0Oo=ILi1oOOOi[loLjOi1]>=ILi1oOOOi[loLjOi1+1] end
if LLO1OL0Oo then ILi1oOOOi[loLjOi1+3]=ILi1oOOOi[loLjOi1]; Ilj0Ol1ojLiLo=I1LlO10lO0+1 end
elseif jlOo1LI1LO==6 then
ILi1oOOOi[loLjOi1]=ILi1oOOOi[I1LlO10lO0]//ILi1oOOOi[IlOjlj]
elseif jlOo1LI1LO==31 then
local LoLjI1iolL11l=lLjl0iL[I1LlO10lO0+1]
local LIj0lj01j={}
local lIlOilj1lIjlL=LoLjI1iolL11l[6]
for jjoOoO=1,#lIlOilj1lIjlL do
local IIj0Oo0Ol00I=lIlOilj1lIjlL[jjoOoO]
if IIj0Oo0Ol00I[1]==1 then LIj0lj01j[jjoOoO]=ILi1oOOOi[IIj0Oo0Ol00I[2]] else LIj0lj01j[jjoOoO]=iIlo1O1lOlLI[IIj0Oo0Ol00I[2]+1] end
end
ILi1oOOOi[loLjOi1]=Il0IiOio(LoLjI1iolL11l,LIj0lj01j)
elseif jlOo1LI1LO==7 then
ILi1oOOOi[I1LlO10lO0][1]=ILi1oOOOi[loLjOi1]
elseif jlOo1LI1LO==25 then
ILi1oOOOi[loLjOi1]={}
elseif jlOo1LI1LO==42 then
ILi1oOOOi[loLjOi1]=ILi1oOOOi[I1LlO10lO0][1]
elseif jlOo1LI1LO==14 then
local LLO1OL0Oo
if I1LlO10lO0==0 then LLO1OL0Oo=IjjOloiLLOOoj-loLjOi1 else LLO1OL0Oo=I1LlO10lO0-1 end
local LIj0lj01j={}
for jjoOoO=1,LLO1OL0Oo do LIj0lj01j[jjoOoO]=ILi1oOOOi[loLjOi1+jjoOoO-1] end
return L1IojOiOji(LIj0lj01j,1,LLO1OL0Oo)
elseif jlOo1LI1LO==22 then
local jjoOoO,LoLjI1iolL11l=ILi1oOOOi[I1LlO10lO0],ILi1oOOOi[IlOjlj];ILi1oOOOi[loLjOi1]=jjoOoO+LoLjI1iolL11l
elseif jlOo1LI1LO==5 then
local jjoOoO,LoLjI1iolL11l=ILi1oOOOi[I1LlO10lO0],ILi1oOOOi[IlOjlj];ILi1oOOOi[loLjOi1]=jjoOoO%LoLjI1iolL11l
elseif jlOo1LI1LO==39 then
local jjoOoO=iLLjIl0L1j(lOjOj1jlji1OL,i0OiiO,I1LlO10lO0+1,Liii10i0L0(IL1lj0O));ILi1oOOOi[loLjOi1]=iO1il0jLI1l[jjoOoO]
elseif jlOo1LI1LO==44 then
for jjoOoO=loLjOi1,loLjOi1+2 do
ILi1oOOOi[jjoOoO]=L1jj0jo(ILi1oOOOi[jjoOoO])
if ILi1oOOOi[jjoOoO]==nil then il11IiOO0Il("Numeric for bounds and step must be numbers",0) end
end
local LoLjI1iolL11l=ILi1oOOOi[loLjOi1+2]
local LLO1OL0Oo
if LoLjI1iolL11l>0 then LLO1OL0Oo=ILi1oOOOi[loLjOi1]<=ILi1oOOOi[loLjOi1+1] else LLO1OL0Oo=ILi1oOOOi[loLjOi1]>=ILi1oOOOi[loLjOi1+1] end
if LLO1OL0Oo then ILi1oOOOi[loLjOi1+3]=ILi1oOOOi[loLjOi1] else Ilj0Ol1ojLiLo=I1LlO10lO0+1 end
elseif jlOo1LI1LO==29 then
local jjoOoO=ILi1oOOOi[loLjOi1]
if lOiiO0O(jjoOoO)~=lj0loIi1Il00jo then
local LoLjI1iolL11l=iOIijIIOO10(jjoOoO)
if LoLjI1iolL11l~=nil and lOiiO0O(LoLjI1iolL11l)~=jioillLL then il11IiOO0Il("Protected iterator metatables require an explicit iterator function",0) end
local LLO1OL0Oo=LoLjI1iolL11l and ij1iLL0LoIo1(LoLjI1iolL11l,jiloL0O1lI)
if LLO1OL0Oo~=nil then
ILi1oOOOi[loLjOi1],ILi1oOOOi[loLjOi1+1],ILi1oOOOi[loLjOi1+2]=LLO1OL0Oo(jjoOoO)
elseif lOiiO0O(jjoOoO)==jioillLL and (LoLjI1iolL11l==nil or ij1iLL0LoIo1(LoLjI1iolL11l,jjLLOO11i0)==nil) then
ILi1oOOOi[loLjOi1],ILi1oOOOi[loLjOi1+1],ILi1oOOOi[loLjOi1+2]=lI0LI0jjjI0,jjoOoO,nil
end
end
elseif jlOo1LI1LO==17 then
local jjoOoO,LoLjI1iolL11l=ILi1oOOOi[I1LlO10lO0],ILi1oOOOi[IlOjlj];ILi1oOOOi[loLjOi1]=jjoOoO[LoLjI1iolL11l]
elseif jlOo1LI1LO==30 then
ILi1oOOOi[loLjOi1]=-ILi1oOOOi[I1LlO10lO0]
else il11IiOO0Il() end
end
return Iii1li
end
return L1i1lojoL(IL1lj0O,{},LjIo0j(...))
