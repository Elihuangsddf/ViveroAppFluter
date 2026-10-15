class Plant {
  final String nombre;
  final String precio;
  final String rutaImagen;
  final String categorias;
  // Términos alternativos para encontrar esta planta en la búsqueda.
  final List<String> palabrasClave;

  const Plant({
    required this.nombre,
    required this.precio,
    required this.rutaImagen,
    required this.categorias,
    // Una planta puede omitir palabras clave sin afectar al catálogo.
    this.palabrasClave = const [],
  });
}

const List<Plant> plantasDemo = [
  // Las plantas de interior se muestran al elegir "Interior".
  Plant(
    nombre: 'Monstera',
    precio: '\$20.00',
    rutaImagen: 'ImgPlants/01-monstera-deliciosa.png',
    categorias: 'Interior',
    palabrasClave: ['costilla de adan', 'hojas grandes', 'sombra'],
  ),
  Plant(
    nombre: 'Ficus',
    precio: '\$15.00',
    rutaImagen: 'ImgPlants/02-ficus-lyrata.png',
    categorias: 'Interior',
    palabrasClave: ['ficus lyrata', 'hoja de violin', 'luz indirecta'],
  ),
  Plant(
    nombre: 'Sansevieria',
    precio: '\$25.00',
    rutaImagen: 'ImgPlants/03-sansevieria-trifasciata.png',
    categorias: 'Interior',
    palabrasClave: ['lengua de suegra', 'resistente', 'sombra'],
  ),
  Plant(
    nombre: 'Spathiphyllum',
    precio: '\$18.00',
    rutaImagen: 'ImgPlants/04-spathiphyllum.png',
    categorias: 'Interior',
    palabrasClave: ['cuna de moises', 'lirio de paz', 'flor blanca'],
  ),
  Plant(
    nombre: 'Calathea',
    precio: '\$12.00',
    rutaImagen: 'ImgPlants/05-calathea-orbifolia.png',
    categorias: 'Interior',
    palabrasClave: ['calatea', 'hojas decorativas', 'sombra'],
  ),
  // Los precios nuevos quedan pendientes hasta contar con precios reales.
  Plant(
    nombre: 'Pothos dorado',
    precio: '\$62.00',
    rutaImagen: 'ImgPlants/07-pothos-dorado.png',
    categorias: 'Interior',
    palabrasClave: ['potus', 'enredadera', 'luz indirecta'],
  ),
  Plant(
    nombre: 'Zamioculcas zamiifolia',
    precio: '\$25.00',
    rutaImagen: 'ImgPlants/08-zamioculcas-zamiifolia.png',
    categorias: 'Interior',
    palabrasClave: ['planta zz', 'resistente', 'sombra'],
  ),
  Plant(
    nombre: 'Philodendron Brasil',
    precio: '\$30.00',
    rutaImagen: 'ImgPlants/09-philodendron-brasil.png',
    categorias: 'Interior',
    palabrasClave: ['filodendro', 'enredadera', 'hojas verdes'],
  ),
  Plant(
    nombre: 'Anthurium andraeanum',
    precio: '\$20.00',
    rutaImagen: 'ImgPlants/10-anthurium-andraeanum.png',
    categorias: 'Interior',
    palabrasClave: ['anturio', 'flor roja', 'luz indirecta'],
  ),
  Plant(
    nombre: 'Orquídea Phalaenopsis',
    precio: '\$35.00',
    rutaImagen: 'ImgPlants/11-orquidea-phalaenopsis.png',
    categorias: 'Interior',
    palabrasClave: ['orquidea', 'flor', 'luz indirecta'],
  ),
  Plant(
    nombre: 'Helecho de Boston',
    precio: '\$12.00',
    rutaImagen: 'ImgPlants/23-helecho-boston.png',
    categorias: 'Interior',
    palabrasClave: ['helecho', 'humedad', 'sombra'],
  ),
  Plant(
    nombre: 'Bonsái Ficus Ginseng',
    precio: '\$25.00',
    rutaImagen: 'ImgPlants/24-bonsai-ficus-ginseng.png',
    categorias: 'Interior',
    palabrasClave: ['bonsai', 'ficus', 'arbol pequeno'],
  ),
  Plant(
    nombre: 'Begonia maculata',
    precio: '\$18.00',
    rutaImagen: 'ImgPlants/30-begonia-maculata.png',
    categorias: 'Interior',
    palabrasClave: ['begonia', 'hojas con puntos', 'luz indirecta'],
  ),
  // Estas plantas aparecen al elegir "Exterior"; "Todas" muestra ambos grupos.
  Plant(
    nombre: 'Aloe vera',
    precio: '\$12.00',
    rutaImagen: 'ImgPlants/06-aloe-vera.png',
    categorias: 'Exterior',
    palabrasClave: ['sabila', 'suculenta', 'sol'],
  ),
  Plant(
    nombre: 'Lavanda',
    precio: '\$14.00',
    rutaImagen: 'ImgPlants/12-lavanda.png',
    categorias: 'Exterior',
    palabrasClave: ['aromatica', 'flores moradas', 'sol'],
  ),
  Plant(
    nombre: 'Romero',
    precio: '\$15.00',
    rutaImagen: 'ImgPlants/13-romero.png',
    categorias: 'Exterior',
    palabrasClave: ['aromatica', 'hierba', 'sol'],
  ),
  Plant(
    nombre: 'Albahaca',
    precio: '\$10.00',
    rutaImagen: 'ImgPlants/14-albahaca.png',
    categorias: 'Exterior',
    palabrasClave: ['aromatica', 'hierba', 'cocina'],
  ),
  Plant(
    nombre: 'Menta',
    precio: '\$10.00',
    rutaImagen: 'ImgPlants/15-menta.png',
    categorias: 'Exterior',
    palabrasClave: ['aromatica', 'hierba', 'hierbabuena'],
  ),
  Plant(
    nombre: 'Girasol',
    precio: '\$10.00',
    rutaImagen: 'ImgPlants/16-girasol.png',
    categorias: 'Exterior',
    palabrasClave: ['flor amarilla', 'sol', 'jardin'],
  ),
  Plant(
    nombre: 'Rosa',
    precio: '\$20.00',
    rutaImagen: 'ImgPlants/17-rosa.png',
    categorias: 'Exterior',
    palabrasClave: ['rosal', 'flor', 'jardin'],
  ),
  Plant(
    nombre: 'Tulipán',
    precio: '\$25.00',
    rutaImagen: 'ImgPlants/18-tulipan.png',
    categorias: 'Exterior',
    palabrasClave: ['tulipan', 'flor', 'bulbo'],
  ),
  Plant(
    nombre: 'Ave del paraíso',
    precio: '\$30.00',
    rutaImagen: 'ImgPlants/19-ave-del-paraiso.png',
    categorias: 'Exterior',
    palabrasClave: ['strelitzia', 'flor tropical', 'sol'],
  ),
  Plant(
    nombre: 'Planta de jade',
    precio: '\$35.00',
    rutaImagen: 'ImgPlants/20-planta-jade.png',
    categorias: 'Exterior',
    palabrasClave: ['crassula', 'suculenta', 'sol'],
  ),
  Plant(
    nombre: 'Echeveria',
    precio: '\$40.00',
    rutaImagen: 'ImgPlants/21-echeveria.png',
    categorias: 'Exterior',
    palabrasClave: ['suculenta', 'roseta', 'sol'],
  ),
  Plant(
    nombre: 'Cactus barril dorado',
    precio: '\$45.00',
    rutaImagen: 'ImgPlants/22-cactus-barril-dorado.png',
    categorias: 'Exterior',
    palabrasClave: ['cactus', 'biznaga', 'sol'],
  ),
  Plant(
    nombre: 'Bambú',
    precio: '\$50.00',
    rutaImagen: 'ImgPlants/25-bambu.png',
    categorias: 'Exterior',
    palabrasClave: ['bambu', 'canas', 'jardin'],
  ),
  Plant(
    nombre: 'Olivo',
    precio: '\$62.00',
    rutaImagen: 'ImgPlants/26-olivo.png',
    categorias: 'Exterior',
    palabrasClave: ['oliva', 'arbol', 'sol'],
  ),
  Plant(
    nombre: 'Arce japonés',
    precio: '\$75.00',
    rutaImagen: 'ImgPlants/27-arce-japones.png',
    categorias: 'Exterior',
    palabrasClave: ['arce', 'arbol', 'jardin'],
  ),
  Plant(
    nombre: 'Buganvilla',
    precio: '\$25.00',
    rutaImagen: 'ImgPlants/28-buganvilla.png',
    categorias: 'Exterior',
    palabrasClave: ['bugambilia', 'enredadera', 'flor'],
  ),
  Plant(
    nombre: 'Caléndula',
    precio: '\$15.00',
    rutaImagen: 'ImgPlants/29-calendula.png',
    categorias: 'Exterior',
    palabrasClave: ['calendula', 'flor naranja', 'jardin'],
  ),
];
