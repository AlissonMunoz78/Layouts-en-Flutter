import 'package:flutter/material.dart';
import '../models/producto.dart';

const Color kAmazonAzul = Color(0xFF232F3E);
const Color kAmazonNaranja = Color(0xFFFF9900);

class ProductoDetalleScreen extends StatefulWidget {
  final Producto producto;

  const ProductoDetalleScreen({super.key, required this.producto});

  @override
  State<ProductoDetalleScreen> createState() => _ProductoDetalleScreenState();
}

class _ProductoDetalleScreenState extends State<ProductoDetalleScreen> {
  bool _esFavorito = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImagenConStack(context),
            _buildInformacion(context),
          ],
        ),
      ),
    );
  }

  Widget _buildImagenConStack(BuildContext context) {
    return SizedBox(
      height: 350,
      width: double.infinity,
      child: Stack(
        children: [
          // Imagen de fondo
          SizedBox(
            height: 350,
            width: double.infinity,
            child: Image.asset(
              widget.producto.imagenUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[200],
                  child: Icon(
                    Icons.image_not_supported,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                );
              },
            ),
          ),

          // Degradado inferior sobre la imagen
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.5),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Badge descuento - esquina superior izquierda
          Positioned(
            top: 50,
            left: 16,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFCC0C39),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                '20% OFF',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),

          // Botón volver
          Positioned(
            top: 90,
            left: 16,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: kAmazonAzul,
                  size: 20,
                ),
              ),
            ),
          ),

          // Ícono favorito - esquina superior derecha
          Positioned(
            top: 50,
            right: 16,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _esFavorito = !_esFavorito;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Icon(
                  _esFavorito ? Icons.favorite : Icons.favorite_border,
                  color: _esFavorito ? const Color(0xFFCC0C39) : Colors.grey,
                  size: 22,
                ),
              ),
            ),
          ),

          // Botón agregar al carrito flotante
          Positioned(
            bottom: 16,
            right: 16,
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        '${widget.producto.nombre} agregado al carrito'),
                    backgroundColor: kAmazonAzul,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              icon: const Icon(Icons.add_shopping_cart, size: 18),
              label: const Text(
                'Agregar al carrito',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: kAmazonNaranja,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: 18, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInformacion(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categoría
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: kAmazonNaranja.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                  color: kAmazonNaranja.withValues(alpha: 0.4)),
            ),
            child: Text(
              widget.producto.categoria,
              style: const TextStyle(
                color: kAmazonAzul,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Nombre
          Text(
            widget.producto.nombre,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F1111),
            ),
          ),
          const SizedBox(height: 8),

          // Estrellas
          Row(
            children: [
              ...List.generate(
                5,
                (i) => Icon(
                  i < 4 ? Icons.star : Icons.star_half,
                  size: 18,
                  color: kAmazonNaranja,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                '4.5 (128 reseñas)',
                style: TextStyle(
                  color: Color(0xFF007185),
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          const Divider(),

          // Precio
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'Precio: ',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              Text(
                '\$${widget.producto.precio.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFB12704),
                ),
              ),
            ],
          ),
          const Text(
            '✓ Envío gratis con Prime',
            style: TextStyle(
              color: Color(0xFF007600),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),

          const Divider(),

          // Descripción
          const Text(
            'Sobre este producto',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F1111),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.producto.descripcion,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF565959),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 24),

          // Botón comprar ahora
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('¡Compra realizada con éxito!'),
                    backgroundColor: Color(0xFF007600),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kAmazonNaranja,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 2,
              ),
              child: const Text(
                'Comprar ahora',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Botón agregar al carrito secundario
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        '${widget.producto.nombre} agregado al carrito'),
                    backgroundColor: kAmazonAzul,
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: kAmazonAzul,
                side: const BorderSide(color: kAmazonAzul),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Agregar al carrito',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}