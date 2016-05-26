
##### EJEMPLO DE USO DE 'ggtree'


## Cargar paquetes que se utilizarán
library(ggplot2)
library(ggtree)
library(ape)

## Importar datos ejemplo para trabajar
carex <- read.tree("../data/carex.nhx")

### Visualización del árbol

## Graficar el árbol
ggtree(carex, aes(x, y)) + geom_tree() + theme_tree()

## Cambiar el color, tipo y tamaño de línea
ggtree(carex, color = "darkblue", size = 1, linetype = "dotted")

## Cambiar la posición de la raíz del árbol
ggtree(carex, ladderize=FALSE)

## Si sólo quiero ver la topología del árbol, pido No mostrar la longitud de las ramas
ggtree(carex, branch.length="none")

## Cambiar el diseño del árbol y agregar título (varios ejemplos)
ggtree(carex, layout = "slanted") + 
  ggtitle("(Phylogram) Slanted layout")

ggtree(carex, layout = "circular") + 
  ggtitle("(Phylogram) Circular layout")

ggtree(carex, layout = "circular", branch.length = "none") + 
  ggtitle("(Cladogram) Circular layout")

ggtree(carex, branch.length = "none") + 
  ggtitle("(Cladocram) Rectancular layout")

## Plotear el árbol desenraizado
ggtree(carex, layout = "unrooted") + 
  ggtitle("Unrooted layout")

## Mostrar la escala del árbol, especificando su posición y color
ggtree(carex) + 
  geom_treescale(x = 0, y = 12, color = "red")

## Mostrar la escala del árbol pero añadiendo eje x
ggtree(carex) + theme_tree2()

## Mostrar nodos internos y puntas en el árbol
# Sólo nodos internos
ggtree(carex) + 
  geom_nodepoint(aes(shape = isTip, color = isTip), size = 3)

# Sólo puntas
ggtree(carex) + 
  geom_tippoint(aes(shape = isTip, color = isTip), size = 3)

# Mostrar nodos internos y puntas 
ggtree(carex) + 
  geom_point(aes(shape=isTip, color=isTip), size = 3)

# Otra opción más bonita
p <- ggtree(carex) + 
  geom_nodepoint(color = "green", alpha = 1/4, size = 10)
p

p + geom_tippoint(color="orange", shape = 8, size = 3)

## Mostrar tip labels
p + geom_tiplab(size = 3, color = "darkblue")

# En árboles circulares y sin enraizar, se pueden rotar las etiquetas de acuerdo al ángulo de las ramas
ggtree(carex, layout = "circular") + 
  geom_tiplab(aes(angle = angle))

## Cambiar la posición de las etiquetas con base en la longitud de la rama
p + geom_tiplab(aes(x = branch), size = 3, color = "blue", vjust = -0.5)

## Se puede aplicar algún diseño creado previamente (aquí, el del árbol 'p') a otro árbol, en este caso, a un árbol cualquiera de 50 ramas
p %<% rtree(50)

## Definir el color del lienzo del árbol y visualizar varios árboles juntos
multiplot(
  ggtree(carex, color = "red") + theme_tree("steelblue"),
  ggtree(carex, color = "white") + theme_tree("black"),
  ncol = 2)

### Manipulación de árboles

## Mostrar el numero de nodos del árbol
ggtree(carex) + 
  geom_text2(aes(subset = !isTip, label = node), hjust = -0.3) +
  geom_tiplab()

## Mostrar sólo un clado de un árbol, especifico el nodo del clado que quiero ver
viewClade(p + geom_tiplab(), node = 15)

## Selecciona un grupo de clados, manipular la vista del árbol, resaltar el clado seleccionado
tree <- groupClade(carex, node = c(13, 12))
ggtree(tree, aes(color = group, linetype = group)) +
  geom_tiplab(aes(subset=(group==2)))

## Colapsar un clado
cp <- ggtree(carex) %>% 
  collapse(node = 13)
cp + geom_point2(aes(subset = (node==13)), size = 5, shape = 23, fill = "steelblue")

## Resaltar un clado y disminur el tamaño de un clado 
multiplot(
  ggtree(carex) + geom_hilight(13, "yellow"),
  ggtree(carex) %>% 
    scaleClade(13, scale = 0.3) + 
    geom_hilight(13, "yellow"),
  ncol = 2
)

### Anotación de árboles

## Poner etiquetas a los clados
p + geom_cladelabel(node = 13, label = "test label") +
  geom_cladelabel(node = 17, label = "another clade")

## Alinear las etiquetas y cambiar su color
p + geom_cladelabel(node = 13, label = "test label", align = TRUE, geom = "label", angle = 270, hjust = "center", color = "red") +
  geom_cladelabel(node = 17, label = "another clade", align = TRUE, angle = 270, hjust = "center", barsize = 1.5, color = "blue")

## Resaltar varios clados
ggtree(carex) + 
  geom_hilight(node = 13, fill = "yellow", alpha = 0.5) +
  geom_hilight(node = 17, fill = "green", alpha = 0.5)
