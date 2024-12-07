
%1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vive(juan, casa(120), almagro).
vive(nico, departamento(3, 2), almagro).
vive(alf, departamento(3, 1), almagro).
vive(julian, loft(2000), almagro).
vive(vale, departamento(4, 1), flores).
vive(fer, casa(110), flores).


vive(ejemplo, casa(110), recoleta).

%2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
barrioCopado(Barrio) :-
    vive(_, _, Barrio),
    forall(vive(Persona, _, Barrio), vivepropiedadCopada(Persona)).

%3%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

barrioCaro(Barrio):-
    vive(_,_,Barrio),
    forall(vive(Persona,_,Barrio),not(viveBarato(Persona))).

vivepropiedadCopada(Persona) :-
    vive(Persona, casa(Metros), _),
    Metros > 100.

vivepropiedadCopada(Persona) :-
    vive(Persona, departamento(Ambientes, _), _),
    Ambientes > 3.

vivepropiedadCopada(Persona) :-
    vive(Persona, departamento(_, Banos), _),
    Banos > 1.

vivepropiedadCopada(Persona) :-
    vive(Persona, loft(Anio), _),
    Anio > 2015.


viveBarato(Persona) :-
    vive(Persona,loft(Anio),_),
    Anio < 2005.

viveBarato(Persona) :-
    vive(Persona, casa(Metros),_),
    Metros<90.

viveBarato(Persona):-
    vive(Persona, departamento(Ambientes,_),_),
    Ambientes<3.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tasacion(juan,150000).
tasacion(nico,80000).
tasacion(alf,75000).
tasacion(julian,140000).
tasacion(vale,95000).
tasacion(fer,60000).

sublista([], []).
sublista([_|Cola], Sublista) :- sublista(Cola, Sublista).
sublista([Cabeza|Cola], [Cabeza|Sublista]) :- sublista(Cola, Sublista).

%%Calculo lo que va a gastar
sumarTasaciones([], 0).
sumarTasaciones([Persona|Cola], Suma) :-
    tasacion(Persona, Valor),
    sumarTasaciones(Cola, SumaResto),
    Suma is Valor + SumaResto.

comprar(Plata, Propiedades, Sobrante) :-
    findall(Persona, tasacion(Persona, _), ListaPropiedades),
    sublista(ListaPropiedades, Propiedades), %Todas las combinaciones de propiedades                 
    Propiedades \= [],                                   
    sumarTasaciones(Propiedades, CostoTotal),             
    Sobrante is Plata - CostoTotal,                          
    Sobrante >= 0.                                           
% Solución en Prolog
