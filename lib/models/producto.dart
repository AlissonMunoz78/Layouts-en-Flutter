class Producto {
  final String id;
  final String nombre;
  final String descripcion;
  final double precio;
  final String imagenUrl;
  final String categoria;

  Producto({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.imagenUrl,
    required this.categoria,
  });
}

List<Producto> productosEjemplo = [
  Producto(
    id: '1',
    nombre: 'Laptop Pro',
    descripcion: 'Laptop de alto rendimiento con procesador de última generación',
    precio: 1299.99,
    imagenUrl: 'assets/images/laptop.jpg',
    categoria: 'Electrónica',
  ),
  Producto(
    id: '2',
    nombre: 'Auriculares BT',
    descripcion: 'Auriculares inalámbricos con cancelación de ruido',
    precio: 89.99,
    imagenUrl: 'assets/images/headphones.jpg',
    categoria: 'Electrónica',
  ),
  Producto(
    id: '3',
    nombre: 'Smartwatch',
    descripcion: 'Reloj inteligente deportivo con GPS integrado',
    precio: 249.99,
    imagenUrl: 'assets/images/smartwatch.jpg',
    categoria: 'Electrónica',
  ),
  Producto(
    id: '4',
    nombre: 'Cámara Digital',
    descripcion: 'Cámara profesional 4K con lente intercambiable',
    precio: 599.99,
    imagenUrl: 'assets/images/camera.jpg',
    categoria: 'Fotografía',
  ),
  Producto(
    id: '5',
    nombre: 'Teclado Mecánico',
    descripcion: 'Teclado gaming RGB con switches mecánicos',
    precio: 129.99,
    imagenUrl: 'assets/images/keyboard.jpg',
    categoria: 'Accesorios',
  ),
  Producto(
    id: '6',
    nombre: 'Mouse Inalámbrico',
    descripcion: 'Mouse ergonómico con sensor de alta precisión',
    precio: 49.99,
    imagenUrl: 'assets/images/mouse.jpg',
    categoria: 'Accesorios',
  ),
];