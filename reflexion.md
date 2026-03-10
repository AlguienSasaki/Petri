# Reflexión

para empezar, hay varias cosas que noté y me gustaría discutir

Las lista de pares: 
Son faciles de definir pero tambien son lentas para buscar (se debe recorrer toda la lista para hallar un preset).

El mapa de adyacencia: Es mucho más rápido ( Con niveles $(O(1)$ o $O(\log(n) ))$ ) para encontrar el postset, pero ocupa un poco más de memoria. En este caso no es tan visible, pero es vital tenerlo en cuenta.

En la Lista (ex1l): Es costoso porque por cada transición se debe volver a recorrer toda la lista para calcular su preset. Por ahora no se nota, pero en caso de contar con una lista bastante mas grande, esto se volvería demasiado lento ($O(T \times F)$ donde $T$ es transiciones y $F$ es flujo).

En el Mapa (ex1m): Aunque el postset es rápido, el enablement sigue requiriendo de calcular el preset. En un mapa de adyacencia estándar (donde la llave es el origen), calcular el preset sigue siendo una búsqueda inversa bastante costosa.

Finalmente, para que el enablement sea eficiente, lo ideal sería una representación de "Mapa Inverso" donde las llaves sean las transiciones y los valores sean sus presets.
