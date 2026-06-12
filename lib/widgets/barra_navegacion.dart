import 'package:flutter/material.dart';

const Color kAmazonAzul = Color(0xFF232F3E);
const Color kAmazonNaranja = Color(0xFFFF9900);

class BarraNavegacion extends StatelessWidget {
  final int indiceActual;
  final Function(int) onTap;

  const BarraNavegacion({
    super.key,
    required this.indiceActual,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        color: kAmazonAzul,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildBotonNav(0, Icons.home, 'Inicio'),
          _buildBotonNav(1, Icons.search, 'Buscar'),
          _buildBotonNav(2, Icons.favorite_border, 'Favoritos'),
          _buildBotonNav(3, Icons.shopping_cart_outlined, 'Carrito'),
          _buildBotonNav(4, Icons.person_outline, 'Perfil'),
        ],
      ),
    );
  }

  Widget _buildBotonNav(int indice, IconData icono, String label) {
    final bool estaActivo = indice == indiceActual;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(indice),
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Indicador activo
              if (estaActivo)
                Container(
                  width: 4,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 4),
                  decoration: const BoxDecoration(
                    color: kAmazonNaranja,
                    shape: BoxShape.circle,
                  ),
                )
              else
                const SizedBox(height: 8),
              Icon(
                icono,
                color: estaActivo ? kAmazonNaranja : Colors.white60,
                size: 24,
              ),
              const SizedBox(height: 3),
              Text(
                label,
                style: TextStyle(
                  color: estaActivo ? kAmazonNaranja : Colors.white60,
                  fontSize: 10,
                  fontWeight:
                      estaActivo ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}