/* Termodinámica Aplicada: una animación por tema */
(function(){var M=window.MANIM;if(!M)return;var U=M.util,C=M.C,nf=U.nf,lerp=U.lerp,ease=U.ease,seg=U.seg,clamp=U.clamp,RG=U.RG,W=640;
function itp(X,Y,x){if(x<=X[0])return Y[0];for(var i=1;i<X.length;i++)if(x<=X[i])return lerp(Y[i-1],Y[i],(x-X[i-1])/(X[i]-X[i-1]));return Y[Y.length-1];}
var TT=[0,50,100,150,200,250,300,350,374],LVG=[2.31,1.08,0.22,-0.41,-0.90,-1.30,-1.66,-2.06,-2.5],LVF=[-3,-2.99,-2.98,-2.96,-2.94,-2.9,-2.85,-2.76,-2.5],
 SF=[0,0.70,1.31,1.84,2.33,2.79,3.25,3.78,4.41],SG=[9.16,8.08,7.35,6.84,6.43,6.07,5.70,5.21,4.41];
function dome(A,fx,gx){var p=[];for(var T=0;T<=374;T+=2)p.push([A.X(fx(T)),A.Y(T)]);for(var T2=374;T2>=0;T2-=2)p.push([A.X(gx(T2)),A.Y(T2)]);return p;}

/* T1 calentamiento a presión constante en el diagrama T-v */
function lv(T){return itp(TT,LVF,T);}function lg(T){return itp(TT,LVG,T);}
function path1(s){var o=3.2;if(s<1)return [o-3.0+0.02*s,lerp(20,100,s)];if(s<2)return [o+lerp(lv(100),lg(100),s-1),100];return [o+lg(100)+(s-2)*0.55,100+(s-2)*200];}
M.reg('ta-t1',M.tray({title:'Agua: calentamiento a presión constante (diagrama T–v)',H:560,dur:18,s:[0,3],lin:true,ax:{xr:[0,4.4],yr:[0,400],xt:[0.2,1.2,2.2,3.2,4.2],yt:[100,200,300,374],xf:function(v){return '10'+['⁻³','⁻²','⁻¹','⁰','¹'][Math.round(v-0.2)];},yd:0,xl:'v (m³/kg)',yl:'T (°C)'},h:310,path:path1,
 extra:function(D,A){U.clipA(D,A,function(){D.path(dome(A,function(T){return lv(T)+3.2;},function(T){return lg(T)+3.2;}),C.f,2,RG(C.f,.08));});D.dot(A.X(0.7),A.Y(374),5,C.hl);D.text('punto crítico',A.X(0.7)+8,A.Y(374)-6,{s:14,c:C.hl});D.text('mezcla',A.X(1.9),A.Y(60),{s:15,c:C.f,a:'center'});},
 read:function(s){if(s<1)return ['líquido comprimido','T = '+nf(lerp(20,100,s),0)+' °C   (p = 1 atm)'];if(s<2){var x=(Math.pow(10,lerp(lv(100),lg(100),s-1))-0.001)/(1.673-0.001);return ['mezcla líquido-vapor a 100 °C','título x = '+nf(x,2)];}return ['vapor sobrecalentado','T = '+nf(100+(s-2)*200,0)+' °C'];},
 caps:[[6,'A 1 atm el agua líquida se calienta casi sin cambiar de volumen hasta los 100 °C (líquido saturado).'],[12,'Dentro de la campana coexisten líquido y vapor a temperatura constante. El título x es la fracción de masa que ya es vapor: <i>v = v<sub>f</sub> + x·(v<sub>g</sub> − v<sub>f</sub>)</i>.'],[99,'Cuando x = 1 todo es vapor saturado; si se sigue calentando, la temperatura vuelve a subir: vapor sobrecalentado. (Eje v en escala logarítmica.)']]}));

/* T2 gas ideal: isotermas */
M.reg('ta-t2',M.curva({title:'Gas ideal: p·v = R·T',H:560,dur:18,p:[300,900],ax:{xr:[0,1.05],yr:[0,600],xt:[0.25,0.5,0.75,1],yt:[200,400,600],xd:2,yd:0,xl:'v (m³/kg)',yl:'p (kPa)'},h:300,
 curvas:[{f:function(v,T){return v<0.05?NaN:0.287*T/v;},c:'m'}],
 extra:function(D,A,T){var v=0.6;D.dot(A.X(v),A.Y(0.287*T/v),7,C.hl);D.line(A.X(v),A.Y(0),A.X(v),A.Y(0.287*T/v),C.hl,1.2,[4,3]);},
 read:function(T){return ['aire: R = 0,287 kJ/(kg·K)    T = '+nf(T,0)+' K','a v = 0,6 m³/kg:  p = RT/v = '+nf(0.287*T/0.6,0)+' kPa'];},
 caps:[[6,'Para un gas ideal <i>p·v = R·T</i>. A temperatura constante, p y v son inversamente proporcionales: cada isoterma es una hipérbola.'],[12,'Al subir T la isoterma se aleja de los ejes: a volumen fijo, la presión crece proporcionalmente a la temperatura absoluta.'],[99,'El modelo funciona bien con presiones bajas frente a la crítica y temperaturas altas. Cerca de la saturación hace falta el factor Z o tablas.']]}));

/* T3 proceso politrópico y trabajo */
M.reg('ta-t3',M.base({title:'Sistema cerrado: trabajo en un proceso politrópico',H:560,dur:18,caps:[[6,'En una expansión cuasiestática el trabajo es el área bajo la curva en el diagrama p–V: <i>W = ∫p dV</i>.'],[12,'Para un proceso politrópico <i>pV<sup>n</sup> = cte</i>: n = 0 isobaro, n = 1 isotermo, n = k adiabático.'],[99,'Cuanto mayor es n, más cae la presión durante la expansión y menor es el trabajo: <i>W = (p₂V₂ − p₁V₁)/(1 − n)</i>.']]},
 function(D,t){var n=lerp(0,1.6,U.pp(t,18)),p1=500,V1=0.1,V2=0.4,A=U.axes(D,{xr:[0,0.45],yr:[0,550],xt:[0.1,0.2,0.3,0.4],yt:[100,200,300,400,500],xd:1,yd:0,xl:'V (m³)',yl:'p (kPa)'},{x:80,y:96,w:480,h:300,grid:true});
  var f=function(V){return p1*Math.pow(V1/V,n);},pts=[[A.X(V1),A.Y(0)]];for(var i=0;i<=100;i++){var V=lerp(V1,V2,i/100);pts.push([A.X(V),A.Y(f(V))]);}pts.push([A.X(V2),A.Y(0)]);D.path(pts,null,0,RG(C.m,.22));
  U.plotf(D,A,function(V){return V<V1||V>V2?NaN:f(V);},C.m,3);D.dot(A.X(V1),A.Y(p1),6,C.f);D.dot(A.X(V2),A.Y(f(V2)),6,C.f);D.text('1',A.X(V1)-12,A.Y(p1)+4,{s:16,c:C.f});D.text('2',A.X(V2)+8,A.Y(f(V2))-6,{s:16,c:C.f});
  var Wk=Math.abs(n-1)<1e-3?p1*V1*Math.log(V2/V1):(f(V2)*V2-p1*V1)/(1-n);
  U.readout(D,['n = '+nf(n,2)+(Math.abs(n-1.4)<0.04?' (adiabático, aire)':Math.abs(n-1)<0.04?' (isotermo)':n<0.04?' (isobaro)':''),'W = '+nf(Wk,1)+' kJ   p_{2} = '+nf(f(V2),0)+' kPa'],468);}));

/* T4 tobera */
M.reg('ta-t4',M.base({title:'Sistema abierto: la tobera convierte entalpía en velocidad',H:560,dur:18,caps:[[6,'En una tobera adiabática sin trabajo el balance de energía queda <i>h₁ + c₁²/2 = h₂ + c₂²/2</i>.'],[12,'Al estrecharse el conducto el fluido se acelera: la entalpía que pierde se convierte en energía cinética.'],[99,'Con Δh = 200 kJ/kg y entrada lenta, la salida alcanza <i>c₂ = √(2·Δh) ≈ 632 m/s</i>. Un difusor hace exactamente lo contrario.']]},
 function(D,t){var x0=70,x1=570,cy=230,hw=function(x){var u=(x-x0)/(x1-x0);return lerp(90,30,ease(u));};var top=[],bot=[];for(var x=x0;x<=x1;x+=5){top.push([x,cy-hw(x)]);bot.push([x,cy+hw(x)]);}
  D.path(top,C.ax,3);D.path(bot,C.ax,3);var XS=[],X=x0;while(X<x1){XS.push(X);X+=0.6*90/hw(X);}for(var k=0;k<36;k++){var ph=((t*0.1+k/36)%1),Xp=XS[Math.floor(ph*XS.length)],yy=cy+((k*37)%11-5)/5.5*hw(Xp)*0.85;D.dot(Xp,yy,3,C.m,0.85);}
  var dh=200,frac=seg(t,1,14),h=dh*frac,c=Math.sqrt(2*h*1000+50*50);
  D.text('1',x0,cy-110,{s:18,c:C.f,a:'center'});D.text('2',x1,cy-50,{s:18,c:C.f,a:'center'});
  var xb=x0+frac*(x1-x0);D.line(xb,cy-hw(xb)-6,xb,cy+hw(xb)+6,C.hl,2,[4,3]);
  U.readout(D,['sección x: h_{1} − h = '+nf(h,0)+' kJ/kg','c = √(c_{1}² + 2(h_{1} − h)) = '+nf(c,0)+' m/s'],420);}));

/* T5 máquina térmica de Carnot */
M.reg('ta-t5',M.base({title:'Segundo principio: el rendimiento máximo',H:580,dur:18,caps:[[6,'Una máquina térmica toma Q<sub>H</sub> de un foco caliente, produce trabajo W y cede obligatoriamente Q<sub>L</sub> a un foco frío.'],[12,'El rendimiento máximo posible (máquina reversible de Carnot) solo depende de las temperaturas: <i>η = 1 − T<sub>L</sub>/T<sub>H</sub></i>.'],[99,'Por eso las centrales buscan temperaturas de entrada cada vez más altas: es la única forma de que una parte mayor del calor se convierta en trabajo.']]},
 function(D,t){var TH=lerp(400,1500,U.pp(t,18)),TL=300,eta=1-TL/TH,cx=W/2,QH=100,Wk=QH*eta,QL=QH-Wk,k=0.55;
  D.rect(cx-160,80,320,50,C.bad,RG(C.bad,.2),2);D.text('foco caliente  T_{H} = '+nf(TH,0)+' K',cx,112,{s:17,a:'center',c:C.bad});
  D.rect(cx-160,430,320,50,C.f,RG(C.f,.2),2);D.text('foco frío  T_{L} = 300 K',cx,462,{s:17,a:'center',c:C.f});
  D.dot(cx,280,52,RG(C.m,.15));D.ring(cx,280,52,C.m,2.4);D.text('máquina',cx,286,{s:16,a:'center',c:C.m});
  D.line(cx,132,cx,226,C.bad,QH*k*0.5+2);D.head(cx,230,Math.PI/2,C.bad,16);D.text('Q_{H} = 100',cx+40,180,{s:16,c:C.bad});
  D.line(cx,334,cx,424,C.f,QL*k*0.5+2);D.head(cx,428,Math.PI/2,C.f,16);D.text('Q_{L} = '+nf(QL,0),cx+40,385,{s:16,c:C.f});
  D.line(cx+54,280,cx+200,280,C.ok,Math.max(2,Wk*k*0.5));D.head(cx+210,280,0,C.ok,16);D.text('W = '+nf(Wk,0),cx+140,260,{s:16,c:C.ok,a:'center'});
  U.readout(D,['η_{Carnot} = 1 − T_{L}/T_{H} = '+nf(eta*100,1)+' %'],530);}));

/* T6 ciclo de Carnot en T-s */
M.reg('ta-t6',M.base({title:'Entropía: el ciclo de Carnot en el diagrama T–s',H:560,dur:18,caps:[[6,'En el diagrama T–s el calor intercambiado en un proceso reversible es el área bajo la curva: <i>Q = ∫T ds</i>.'],[12,'Carnot: absorción isoterma a T<sub>H</sub>, expansión adiabática reversible (s constante), cesión isoterma a T<sub>L</sub> y compresión isentrópica.'],[99,'El área encerrada es el trabajo neto; el rectángulo bajo T<sub>L</sub> es el calor cedido. De ahí sale directamente <i>η = 1 − T<sub>L</sub>/T<sub>H</sub></i>.']]},
 function(D,t){var A=U.axes(D,{xr:[0,4],yr:[0,1000],xt:[1,3],yt:[300,800],xd:0,yd:0,xl:'s (kJ/kg·K)',yl:'T (K)'},{x:80,y:96,w:480,h:300,grid:true}),P=[[1,800],[3,800],[3,300],[1,300],[1,800]],u=seg(t,1,10)*4,p=[[A.X(1),A.Y(800)]];
  for(var i=0;i<4;i++){var a=clamp(u-i,0,1);if(a<=0)break;p.push([A.X(lerp(P[i][0],P[i+1][0],a)),A.Y(lerp(P[i][1],P[i+1][1],a))]);}
  if(t>10.5){D.rect(A.X(1),A.Y(800),A.X(3)-A.X(1),A.Y(300)-A.Y(800),null,RG(C.ok,.3));D.rect(A.X(1),A.Y(300),A.X(3)-A.X(1),A.Y(0)-A.Y(300),null,RG(C.f,.18));D.text('W_{neto}',A.X(2),A.Y(550),{s:19,a:'center',c:C.ok,bold:true});D.text('Q_{L}',A.X(2),A.Y(150),{s:18,a:'center',c:C.f});}
  D.path(p,C.m,3);var last=p[p.length-1];D.dot(last[0],last[1],6,C.m);[['1',1,800,-14,-8],['2',3,800,8,-8],['3',3,300,8,18],['4',1,300,-14,18]].forEach(function(q){D.text(q[0],A.X(q[1])+q[3],A.Y(q[2])+q[4],{s:16,c:C.f});});
  U.readout(D,['Q_{H} = 800·2 = 1600 kJ/kg    Q_{L} = 300·2 = 600 kJ/kg','η = 1000/1600 = 62,5 % = 1 − 300/800'],468);}));

/* T7 ciclo Brayton: rendimiento frente a relación de compresión */
M.reg('ta-t7',M.traza({title:'Turbina de gas: rendimiento del ciclo Brayton',H:560,dur:16,x0:1,x1:30,ax:{xr:[0,31],yr:[0,0.7],xt:[5,10,15,20,25,30],yt:[0.2,0.4,0.6],xd:0,yd:1,xl:'r_{p}',yl:'η'},h:300,f:function(r){return 1-Math.pow(r,-0.4/1.4);},
 read:function(r){return ['r_{p} = p_{2}/p_{1} = '+nf(r,1),'η = 1 − r_{p}^{−(k−1)/k} = '+nf((1-Math.pow(r,-0.4/1.4))*100,1)+' %'];},
 caps:[[5,'En el ciclo Brayton ideal (compresión y expansión isentrópicas, aporte de calor a presión constante) el rendimiento solo depende de la relación de presiones.'],[10,'Al principio subir r<sub>p</sub> mejora mucho el rendimiento; después la mejora es cada vez menor.'],[99,'En la práctica la temperatura máxima que soportan los álabes limita r<sub>p</sub>: hay una relación óptima para el trabajo neto. Regenerar e interrefrigerar ayudan.']]}));

/* T8 ciclo Otto en p-V */
var r8=8,k8=1.4,V1=1,V2=V1/r8,p1=100,p2=p1*Math.pow(r8,k8),p3=p2*2.4,p4=p3/Math.pow(r8,k8);
function otto(s){if(s<1){var V=lerp(V1,V2,s);return [V,p1*Math.pow(V1/V,k8)];}if(s<2)return [V2,lerp(p2,p3,s-1)];if(s<3){var V3=lerp(V2,V1,s-2);return [V3,p3*Math.pow(V2/V3,k8)];}return [V1,lerp(p4,p1,s-3)];}
M.reg('ta-t8',M.tray({title:'Motor alternativo: el ciclo Otto',H:560,dur:18,s:[0,4],lin:true,ax:{xr:[0,1.1],yr:[0,4800],xt:[0.125,0.5,1],yt:[1000,2000,3000,4000],xf:function(v){return v===1?'V_{1}':v===0.125?'V_{2}':'';},yd:0,xl:'V',yl:'p (kPa)'},h:310,path:otto,
 read:function(s){var n=['1→2 compresión adiabática','2→3 combustión a volumen constante','3→4 expansión adiabática (carrera de trabajo)','4→1 escape: cesión de calor a V constante'][Math.min(3,Math.floor(s))];return [n,'r = V_{1}/V_{2} = 8    η = 1 − r^{1−k} = '+nf((1-Math.pow(r8,1-k8))*100,1)+' %'];},
 caps:[[6,'El ciclo Otto ideal modela el motor de gasolina: dos adiabáticas y dos procesos a volumen constante.'],[12,'El trabajo neto es el área encerrada: lo que da la expansión menos lo que cuesta la compresión.'],[99,'El rendimiento solo depende de la relación de compresión: <i>η = 1 − 1/r<sup>k−1</sup></i>. El límite lo pone la detonación de la mezcla.']]}));

/* T9 ciclo de refrigeración en p-h */
var R9=[[250,0.25],[400,0.25],[430,1.2],[250,1.2],[250,0.25]];
M.reg('ta-t9',M.base({title:'Refrigeración por compresión de vapor (diagrama p–h)',H:580,dur:18,caps:[[6,'El refrigerante se evapora a baja presión absorbiendo calor del espacio frío (4→1) y el compresor lo lleva a alta presión (1→2).'],[12,'En el condensador cede calor al ambiente (2→3) y la válvula de expansión lo devuelve a baja presión sin intercambiar energía (3→4, h constante).'],[99,'Eficiencia: <i>COP = q<sub>L</sub>/w = (h₁ − h₄)/(h₂ − h₁)</i>. Aquí 150/30 = 5: se extraen 5 kJ de calor por cada kJ de trabajo.']]},
 function(D,t){var A=U.axes(D,{xr:[150,470],yr:[0,1.6],xt:[200,250,300,350,400,450],yt:[0.25,1.2],xd:0,yd:2,xl:'h (kJ/kg)',yl:'p (MPa)'},{x:80,y:96,w:480,h:300,grid:true});
  var dl=function(p){return 180+p*60;},dg=function(p){return 395+p*15-p*p*25;},pd=[];for(var p=0;p<=1.45;p+=0.02)pd.push([A.X(dl(p)),A.Y(p)]);for(var q=1.45;q>=0;q-=0.02)pd.push([A.X(dg(q)),A.Y(q)]);D.path(pd,C.f,1.8,RG(C.f,.07));
  var u=seg(t,1,15)*4,s=[[A.X(R9[0][0]),A.Y(R9[0][1])]],N=['evaporador','compresor','condensador','válvula'];for(var i=0;i<4;i++){var a=clamp(u-i,0,1);if(a<=0)break;s.push([A.X(lerp(R9[i][0],R9[i+1][0],a)),A.Y(lerp(R9[i][1],R9[i+1][1],a))]);}
  D.path(s,C.m,3);var L=s[s.length-1];D.dot(L[0],L[1],6,C.m);[['4',250,0.25,-6,22],['1',400,0.25,8,22],['2',430,1.2,8,-8],['3',250,1.2,-16,-8]].forEach(function(z){D.text(z[0],A.X(z[1])+z[3],A.Y(z[2])+z[4],{s:16,c:C.hl,bold:true});});
  var k=Math.min(3,Math.floor(u));U.readout(D,[N[k]+'    COP = (400 − 250)/(430 − 400) = 5'],468);}));

/* T10 carta psicrométrica: enfriamiento y deshumidificación */
function ps(T){return 0.6108*Math.exp(17.27*T/(T+237.3));}function ws(T,phi){var p=(phi||1)*ps(T);return 622*p/(101.3-p);}
var W0=ws(30,0.6),Tdp=(function(){var lo=0,hi=30;for(var i=0;i<40;i++){var m=(lo+hi)/2;if(ws(m)>W0)hi=m;else lo=m;}return (lo+hi)/2;})();
function p10(s){if(s<1)return [lerp(30,Tdp,s),W0];var T=lerp(Tdp,14,s-1);return [T,ws(T)];}
M.reg('ta-t10',M.tray({title:'Psicrometría: enfriar y deshumidificar aire',H:560,dur:18,s:[0,2],lin:true,ax:{xr:[0,36],yr:[0,30],xt:[10,20,30],yt:[10,20,30],xd:0,yd:0,xl:'T (°C)',yl:'ω (g/kg)'},h:310,path:p10,
 extra:function(D,A){[0.2,0.4,0.6,0.8].forEach(function(f){U.plotf(D,A,function(T){return ws(T,f);},C.mut,1,0.5);});U.plotf(D,A,function(T){return ws(T);},C.f,2.4);D.text('φ = 100 %',A.X(26),A.Y(ws(26))-8,{s:14,c:C.f,a:'right'});D.text('60 %',A.X(34),A.Y(ws(34,0.6))-4,{s:13,c:C.mut});},
 read:function(s){var P=p10(s),phi=622*0+(P[1]/ws(P[0]))*100;return ['T = '+nf(P[0],1)+' °C    ω = '+nf(P[1],1)+' g/kg    φ ≈ '+nf(Math.min(100,phi),0)+' %',s<1?'enfriamiento sensible (ω constante)':'condensación: sale agua del aire'];},
 caps:[[6,'Aire a 30 °C y 60 % de humedad relativa se enfría en una batería fría. Mientras no se condensa, la humedad absoluta ω no cambia.'],[12,'Al llegar a la curva de saturación (temperatura de rocío, unos 21 °C) el aire ya no admite más vapor.'],[99,'Si se sigue enfriando, el vapor sobrante condensa y el estado baja por la curva de saturación: el aire sale más seco. Luego suele recalentarse.']]}));

/* T11 combustión del metano con exceso de aire */
M.reg('ta-t11',M.barras({title:'Combustión: productos del metano con exceso de aire',H:560,dur:18,p:[0,1],n:4,xs:function(i){return i+0.5;},ax:{xr:[0,4],yr:[0,0.8],xt:[],yt:[0.2,0.4,0.6,0.8],yd:1,xl:'',yl:'fracción molar'},h:300,
 val:function(i,e){var m=[1,2,2*e,7.52*(1+e)],s=m[0]+m[1]+m[2]+m[3];return m[i]/s;},col:function(i){return ['hl','f','ok','mut'][i];},lab:function(i){return ['CO₂','H₂O','O₂','N₂'][i];},
 read:function(e){return ['CH₄ + 2(1+e)(O₂ + 3,76N₂) → CO₂ + 2H₂O + 2e·O₂ + 7,52(1+e)N₂','exceso de aire e = '+nf(e*100,0)+' %    dosado relativo λ = '+nf(1+e,2)];},
 caps:[[6,'Con aire estequiométrico (e = 0) todo el oxígeno se consume: los productos son CO₂, H₂O y el nitrógeno que acompaña al aire.'],[12,'Al añadir exceso de aire aparece O₂ sobrante y aumenta el N₂: los productos se diluyen y la fracción de CO₂ baja.'],[99,'Un poco de exceso asegura la combustión completa; demasiado enfría la llama y se pierde calor por chimenea.']]}));
})();
