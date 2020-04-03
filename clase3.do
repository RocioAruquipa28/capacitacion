*** Clase 3*** (MEMO)
* nota (Para realizar un test previamente se debe realizar la regresion)
*codigos post-estimacion 
webuse nhanes2
reg bmi age female##region
reg, coeflegend 

*Test para los coeficientes
*test confunto de John
*comparamos la significancia de las variables (Test F)
test 2.region 3.region 4.region
test 1.female#2.region 1.female#3.region 1.female#4.region
* si es igual a 0 o se acerca se rechaza la hipotesis nula, entonces las variables son significativas 

*otra forma que testea todas las posibles conmbinaciones
testparm i.region#i.female

*test de maxima verosimilitud para comparar modelos, nos permite ver si el modelo con interacciones es mejor que sin interacciones
*regresion sin interacciones
estimates store m1
reg bmi age i.female i.region
est store m2

*este comando nos permite comparar dos modelos
* si es 0 se rechaza la hipotesis nula
lrtest m1 m2 
estimates restore m1 

*test para ver igualdad de los coeficientes

************************** otro test****************
estimates restore m1 
estat ic

estimates restore m2 
estat ic
****************************************************

*test para ver igualdad de coeficientes ()
estimates store m1
test 3.region#1.female=4.region#1.female

*el comando lincom nos permite comparar coeficientes
lincom 3.region#1.female - 4.region#1.female

*el comando contrast, este comando nos permite ver si todas las interacciones en sus combinaciones los coeficientes son iguales
contrast region@female, effects 
*contrast region@female, effects mcompare(bonferroni)

*predicciones
* lo que se hace con margins 
estimates store m1
margins 
margins region 
margins region female

margins region#female
* tambien se puede graficar:
marginsplot

*nos dice para todas las categorias de la variable
margins, over(female)

*Para variables continua continua
sum vitaminc, detail

reg bmi c.age##c.vitaminc i.female i.region
reg, coeflegend 

lincom vitaminc+c.vitaminc#c.age*49
lincom age + c.age#c.vitaminc*1

*cuando son variables continuas se debe poner en que valores queremos

margins, at(age=(20(25)70) vitaminc=(.2(.6)2))
margins, dydx(vitaminc) at(age=(20(10)70))
marginsplot, yline(0)
