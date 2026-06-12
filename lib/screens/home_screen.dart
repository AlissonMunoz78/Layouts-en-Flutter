import 'package:flutter/material.dart';
import '../models/producto.dart';
import '../widgets/producto_card.dart';
import '../widgets/barra_navegacion.dart';

// Colores estilo Amazon
const Color kAmazonAzul = Color(0xFF232F3E);
const Color kAmazonNaranja = Color(0xFFFF9900);
const Color kAmazonAmarillo = Color(0xFFF3A847);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _indiceNavegacion = 0;
  String _categoriaSeleccionada = 'Todos';
  final List<String> _categorias = [
    'Todos',
    'Electrónica',
    'Fotografía',
    'Accesorios'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: _buildContenidoPrincipal(),
          ),
          BarraNavegacion(
            indiceActual: _indiceNavegacion,
            onTap: (indice) {
              setState(() {
                _indiceNavegacion = indice;
              });
            },
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return AppBar(
      backgroundColor: kAmazonAzul,
      elevation: 0,
      title: Row(
        children: [
          const Icon(Icons.store, color: kAmazonNaranja),
          const SizedBox(width: 8),
          const Text(
            'Mi Tienda',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: kAmazonNaranja.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${screenWidth.toInt()}px',
              style: const TextStyle(
                color: kAmazonNaranja,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildContenidoPrincipal() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 900) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSidebar(),
              Expanded(
                child: _buildScrollableContent(mostrarCategorias: false),
              ),
            ],
          );
        }
        return _buildScrollableContent(mostrarCategorias: true);
      },
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 220,
      height: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            color: kAmazonAzul,
            child: const Text(
              'Departamentos',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          ..._categorias.map((categoria) {
            final bool estaSeleccionada = categoria == _categoriaSeleccionada;
            return InkWell(
              onTap: () {
                setState(() {
                  _categoriaSeleccionada = categoria;
                });
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: estaSeleccionada
                      ? kAmazonNaranja.withValues(alpha: 0.1)
                      : Colors.transparent,
                  border: estaSeleccionada
                      ? const Border(
                          left: BorderSide(color: kAmazonNaranja, width: 4),
                        )
                      : null,
                ),
                child: Row(
                  children: [
                    Icon(
                      _getIconoCategoria(categoria),
                      size: 20,
                      color: estaSeleccionada ? kAmazonNaranja : Colors.grey[700],
                    ),
                    const SizedBox(width: 10),
                    Text(
                      categoria,
                      style: TextStyle(
                        color: estaSeleccionada
                            ? kAmazonAzul
                            : Colors.grey[800],
                        fontWeight: estaSeleccionada
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  IconData _getIconoCategoria(String categoria) {
    switch (categoria) {
      case 'Electrónica':
        return Icons.devices;
      case 'Fotografía':
        return Icons.camera_alt;
      case 'Accesorios':
        return Icons.keyboard;
      default:
        return Icons.grid_view;
    }
  }

  Widget _buildScrollableContent({required bool mostrarCategorias}) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEncabezado(),
          const SizedBox(height: 16),
          if (mostrarCategorias) ...[
            _buildCategorias(),
            const SizedBox(height: 16),
          ],
          Row(
            children: [
              const Text(
                'Productos Destacados',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kAmazonAzul,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: kAmazonNaranja,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${productosEjemplo.length} items',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildGridProductos(),
        ],
      ),
    );
  }

  Widget _buildEncabezado() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Row(
            children: [
              Expanded(child: _buildBannerPrincipal()),
              const SizedBox(width: 12),
              Expanded(child: _buildBannerSecundario()),
            ],
          );
        }
        return _buildBannerPrincipal();
      },
    );
  }

  Widget _buildBannerPrincipal() {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [kAmazonAzul, Color(0xFF37475A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '¡Ofertas de Temporada!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Hasta 50% de descuento',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 14),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kAmazonNaranja,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Ver ofertas',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 20,
            bottom: 20,
            child: Icon(
              Icons.local_offer,
              size: 80,
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerSecundario() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: kAmazonAmarillo.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kAmazonNaranja.withValues(alpha: 0.4)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.local_shipping, size: 44, color: kAmazonAzul),
            const SizedBox(height: 8),
            const Text(
              'Envío Gratis',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: kAmazonAzul,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'En compras +\$50',
              style: TextStyle(color: Colors.grey[700], fontSize: 13),
            ),
            const SizedBox(height: 10),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: kAmazonNaranja,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Más info',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorias() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categorias.length,
        itemBuilder: (context, index) {
          final categoria = _categorias[index];
          final esSeleccionado = categoria == _categoriaSeleccionada;
          return Container(
            margin: const EdgeInsets.only(right: 10),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _categoriaSeleccionada = categoria;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    esSeleccionado ? kAmazonNaranja : Colors.white,
                foregroundColor:
                    esSeleccionado ? Colors.white : kAmazonAzul,
                elevation: esSeleccionado ? 2 : 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: esSeleccionado
                        ? kAmazonNaranja
                        : Colors.grey[300]!,
                  ),
                ),
              ),
              child: Text(
                categoria,
                style: const TextStyle(fontSize: 13),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGridProductos() {
    return LayoutBuilder(
      builder: (context, constraints) {
        int columnas;
        double childAspectRatio;

        if (constraints.maxWidth >= 1200) {
          columnas = 4;
          childAspectRatio = 0.72;
        } else if (constraints.maxWidth >= 900) {
          columnas = 3;
          childAspectRatio = 0.72;
        } else if (constraints.maxWidth >= 600) {
          columnas = 3;
          childAspectRatio = 0.68;
        } else {
          columnas = 2;
          childAspectRatio = 0.62;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columnas,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: productosEjemplo.length,
          itemBuilder: (context, index) {
            return ProductoCard(producto: productosEjemplo[index]);
          },
        );
      },
    );
  }
}