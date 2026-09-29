class Plant{
  final String nombre;
  final String precio;
  final String rutaImagen;
  final String categorias;

  const Plant({
    required this.nombre,
    required this.precio,
    required this.rutaImagen,
    required this.categorias,
  });
}

const List<Plant> plantasDemo = [
  Plant(
    nombre: 'Monstera',
    precio: '\$20.00',
    rutaImagen: 'ImgPlants/01-montera-deliciosa.png',
    categorias: 'Interior',
  ),
  Plant(
    nombre: 'Ficus',
    precio: '\$15.00',
    rutaImagen: 'ImgPlants/02-ficus-lyrata.png',
    categorias: 'Exterior',
  ),
  Plant(
    nombre: 'Sansevieria',
    precio: '\$25.00',
    rutaImagen: 'ImgPlants/03-sansevieria-trifasciata.png',
    categorias: 'Interior',
  ),
  Plant(
    nombre: 'Spathiphyllum',
    precio: '\$18.00',
    rutaImagen: 'ImgPlants/04-spathiphyllum.png',
    categorias: 'Interior',
  ),
  Plant(
    nombre: 'Calathea',
    precio: '\$12.00',
    rutaImagen: 'ImgPlants/05-calathea-orbifolia.png',
    categorias: 'Exterior',
  ),
];