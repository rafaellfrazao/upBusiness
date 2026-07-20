import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  final List<Pizza> _pizzas = [
    Pizza(
      id: 1,
      name: 'Margherita',
      description: 'Molho de tomate, mozzarella, manjericão fresco',
      price: 45.00,
      imageUrl: '🍕',
      category: 'Tradicional',
    ),
    Pizza(
      id: 2,
      name: 'Calabresa',
      description: 'Molho de tomate, mozzarella, calabresa, cebola',
      price: 48.00,
      imageUrl: '🍕',
      category: 'Tradicional',
    ),
    Pizza(
      id: 3,
      name: 'Quatro Queijos',
      description: 'Molho de tomate, mozzarella, provolone, parmesão, gorgonzola',
      price: 52.00,
      imageUrl: '🍕',
      category: 'Especial',
    ),
    Pizza(
      id: 4,
      name: 'Portuguesa',
      description: 'Molho de tomate, mozzarella, presunto, ovos, cebola, azeitona',
      price: 50.00,
      imageUrl: '🍕',
      category: 'Tradicional',
    ),
    Pizza(
      id: 5,
      name: 'Frango com Catupiry',
      description: 'Molho de tomate, mozzarella, frango desfiado, catupiry',
      price: 55.00,
      imageUrl: '🍕',
      category: 'Especial',
    ),
    Pizza(
      id: 6,
      name: 'Pepperoni',
      description: 'Molho de tomate, mozzarella, pepperoni',
      price: 54.00,
      imageUrl: '🍕',
      category: 'Especial',
    ),
    Pizza(
      id: 7,
      name: 'Vegetariana',
      description: 'Molho de tomate, mozzarella, berinjela, abobrinha, pimentão',
      price: 49.00,
      imageUrl: '🍕',
      category: 'Vegetariana',
    ),
    Pizza(
      id: 8,
      name: 'Chocolate',
      description: 'Chocolate ao leite, morangos, canela',
      price: 58.00,
      imageUrl: '🍕',
      category: 'Doce',
    ),
  ];

  final Map<int, int> _cart = {};

  double get _totalPrice {
    double total = 0;
    _cart.forEach((pizzaId, quantity) {
      final pizza = _pizzas.firstWhere((p) => p.id == pizzaId);
      total += pizza.price * quantity;
    });
    return total;
  }

  int get _totalItems => _cart.values.fold(0, (sum, qty) => sum + qty);

  void _addToCart(Pizza pizza) {
    setState(() {
      _cart[pizza.id] = (_cart[pizza.id] ?? 0) + 1;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${pizza.name} adicionada ao carrinho!'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _removeFromCart(int pizzaId) {
    setState(() {
      if (_cart[pizzaId] != null && _cart[pizzaId]! > 0) {
        _cart[pizzaId] = _cart[pizzaId]! - 1;
        if (_cart[pizzaId] == 0) {
          _cart.remove(pizzaId);
        }
      }
    });
  }

  void _openWhatsApp() async {
    if (_totalItems == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Adicione pizzas ao carrinho primeiro!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    String message = 'Olá! Gostaria de fazer um pedido:\n\n';
    _cart.forEach((pizzaId, quantity) {
      final pizza = _pizzas.firstWhere((p) => p.id == pizzaId);
      message += '$quantity x ${pizza.name} - R\$ ${(pizza.price * quantity).toStringAsFixed(2)}\n';
    });
    message += '\nTotal: R\$ ${_totalPrice.toStringAsFixed(2)}';

    final whatsappUrl = Uri.parse('https://wa.me/5511999999999?text=${Uri.encodeComponent(message)}');
    
    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Não foi possível abrir o WhatsApp'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 700,
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF0D0D0D), Color(0xFF1A0A0A), Color(0xFF2D1010)],
                      ),
                    ),
                  ),
                  Positioned(
                    top: -150,
                    right: -150,
                    child: Container(
                      width: 500,
                      height: 500,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            const Color(0xFFFF6B35).withOpacity(0.4),
                            const Color(0xFFF7931E).withOpacity(0.15),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -100,
                    left: -100,
                    child: Container(
                      width: 400,
                      height: 400,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            const Color(0xFFF7931E).withOpacity(0.25),
                            const Color(0xFFFF6B35).withOpacity(0.1),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    left: -80,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            const Color(0xFFFF6B35).withOpacity(0.15),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: 0.15,
                    child: Image.network(
                      'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=1920&q=80',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container();
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.black.withOpacity(0.45),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(40, 70, 40, 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.2),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFFFF6B35), Color(0xFFF7931E)],
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFFF6B35).withOpacity(0.5),
                                      blurRadius: 24,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: const Text(
                                  '🍕',
                                  style: TextStyle(fontSize: 28),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Row(
                                children: [
                                  Text(
                                    'UB',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 32,
                                      letterSpacing: -1,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'up business',
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFFFF6B35),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 32,
                                      letterSpacing: -1,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 14,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.15),
                                    width: 1.5,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.phone,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      '(11) 99999-9999',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              GestureDetector(
                                onTap: _openCartDrawer,
                                child: Stack(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(14),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.15),
                                          width: 1.5,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.shopping_bag_outlined,
                                        color: Colors.white,
                                        size: 26,
                                      ),
                                    ),
                                    if (_totalItems > 0)
                                      Positioned(
                                        right: -4,
                                        top: -4,
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [Color(0xFFFF6B35), Color(0xFFF7931E)],
                                            ),
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0xFFFF6B35).withOpacity(0.5),
                                                blurRadius: 12,
                                                offset: Offset(0, 4),
                                              ),
                                            ],
                                          ),
                                          child: Text(
                                            '$_totalItems',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 180,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Sabor que',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 96,
                                  fontWeight: FontWeight.w700,
                                  height: 1.02,
                                  letterSpacing: -2.5,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                '🍕',
                                style: TextStyle(
                                  fontSize: 96,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Encanta',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFFFF6B35),
                              fontSize: 96,
                              fontWeight: FontWeight.w700,
                              height: 1.02,
                              letterSpacing: -2.5,
                            ),
                          ),
                          const SizedBox(height: 36),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.15),
                                width: 1.5,
                              ),
                            ),
                            child: Text(
                              'As melhores pizzas artesanais da cidade, feitas com amor e ingredientes selecionados.',
                              style: GoogleFonts.poppins(
                                color: Colors.white.withOpacity(0.95),
                                fontSize: 19,
                                height: 1.5,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                          const SizedBox(height: 52),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFFFF6B35), Color(0xFFF7931E)],
                                  ),
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFFF6B35).withOpacity(0.5),
                                      blurRadius: 28,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Role para ver o menu!'),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Color(0xFF1A1A2E),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 48,
                                      vertical: 20,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.menu_book, size: 20),
                                      const SizedBox(width: 12),
                                      Text(
                                        'Ver Cardápio',
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 24),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.12),
                                      borderRadius: BorderRadius.circular(24),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.35),
                                        width: 2,
                                      ),
                                    ),
                                    child: OutlinedButton(
                                      onPressed: _openWhatsApp,
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        side: BorderSide.none,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 48,
                                          vertical: 20,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(24),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.message, size: 20),
                                          const SizedBox(width: 12),
                                          Text(
                                            'Pedir Agora',
                                            style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 0.3,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 48, 40, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nossas Pizzas',
                    style: GoogleFonts.poppins(
                      fontSize: 42,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A1A2E),
                      letterSpacing: -1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Escolha sua favorita e peça agora!',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: const Color(0xFF636E72),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 48),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final pizza = _pizzas[index];
                  return PizzaCard(
                    pizza: pizza,
                    onAddToCart: () => _addToCart(pizza),
                  );
                },
                childCount: _pizzas.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 140),
          ),
        ],
      ),
      drawer: _buildCartDrawer(),
      floatingActionButton: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _pulseAnimation.value,
            child: Container(
              margin: const EdgeInsets.only(bottom: 32, right: 32),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF25D366), Color(0xFF128C7E)],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF25D366).withOpacity(0.5),
                    blurRadius: 32,
                    offset: const Offset(0, 12),
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: FloatingActionButton.extended(
                onPressed: _openWhatsApp,
                backgroundColor: Colors.transparent,
                elevation: 0,
                icon: const Icon(Icons.message, color: Colors.white, size: 22),
                label: Text(
                  'Pedir pelo WhatsApp',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _openCartDrawer() {
    Scaffold.of(context).openDrawer();
  }

  Widget _buildCartDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFFFAFAFA),
      width: 420,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(32, 70, 32, 40),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1A0A0A), Color(0xFF2D1010)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF6B35), Color(0xFFF7931E)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF6B35).withOpacity(0.3),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.shopping_bag,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Seu Carrinho',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '$_totalItems itens',
                          style: GoogleFonts.poppins(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: _cart.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 32,
                                offset: const Offset(0, 12),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            size: 64,
                            color: Colors.grey[300],
                          ),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          'Carrinho vazio',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF1A1A2E),
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Adicione pizzas deliciosas',
                          style: GoogleFonts.poppins(
                            color: Colors.grey[500],
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(32, 24, 32, 24),
                    itemCount: _cart.length,
                    itemBuilder: (context, index) {
                      final pizzaId = _cart.keys.elementAt(index);
                      final quantity = _cart[pizzaId]!;
                      final pizza = _pizzas.firstWhere((p) => p.id == pizzaId);
                      return CartItem(
                        pizza: pizza,
                        quantity: quantity,
                        onRemove: () => _removeFromCart(pizzaId),
                      );
                    },
                  ),
          ),
          if (_cart.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 32,
                    offset: const Offset(0, -12),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFFF6B35).withOpacity(0.12),
                          const Color(0xFFF7931E).withOpacity(0.06),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFFF6B35).withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total do Pedido',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF636E72),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'R\$ ${_totalPrice.toStringAsFixed(2)}',
                              style: GoogleFonts.poppins(
                                fontSize: 32,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFFFF6B35),
                                letterSpacing: -0.5,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFF6B35), Color(0xFFF7931E)],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFF6B35).withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.receipt_long,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 64,
                    child: ElevatedButton.icon(
                      onPressed: _openWhatsApp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF25D366),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shadowColor: const Color(0xFF25D366).withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      icon: const Icon(Icons.message, size: 24),
                      label: Text(
                        'Finalizar no WhatsApp',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class Pizza {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;

  Pizza({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
  });
}

class PizzaCard extends StatefulWidget {
  final Pizza pizza;
  final VoidCallback onAddToCart;

  const PizzaCard({
    super.key,
    required this.pizza,
    required this.onAddToCart,
  });

  @override
  State<PizzaCard> createState() => _PizzaCardState();
}

class _PizzaCardState extends State<PizzaCard> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
    if (isHovered) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: Colors.black.withOpacity(0.06),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? const Color(0xFFFF6B35).withOpacity(0.3)
                    : Colors.black.withOpacity(0.08),
                blurRadius: _isHovered ? 40 : 24,
                offset: Offset(0, _isHovered ? 16 : 8),
                spreadRadius: _isHovered ? -2 : 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: _isHovered
                          ? [
                              const Color(0xFFFF6B35).withOpacity(0.12),
                              const Color(0xFFF7931E).withOpacity(0.08),
                            ]
                          : [
                              const Color(0xFFFFF8F0),
                              const Color(0xFFFFF0E0),
                            ],
                    ),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(28),
                    ),
                  ),
                  child: Center(
                    child: AnimatedScale(
                      scale: _isHovered ? 1.12 : 1.0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutBack,
                      child: Text(
                        widget.pizza.imageUrl,
                        style: const TextStyle(fontSize: 80),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: _isHovered
                                ? [
                                    const Color(0xFFFF6B35),
                                    const Color(0xFFF7931E),
                                  ]
                                : [
                                    const Color(0xFFFF6B35).withOpacity(0.1),
                                    const Color(0xFFFF6B35).withOpacity(0.05),
                                  ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          widget.pizza.category,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: _isHovered ? Colors.white : const Color(0xFFFF6B35),
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        widget.pizza.name,
                        style: GoogleFonts.poppins(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1A1A2E),
                          letterSpacing: -0.3,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.pizza.description,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: const Color(0xFF95A5A6),
                          height: 1.4,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'R\$ ${widget.pizza.price.toStringAsFixed(2)}',
                            style: GoogleFonts.poppins(
                              fontSize: 21,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFFFF6B35),
                              letterSpacing: -0.5,
                            ),
                          ),
                          InkWell(
                            onTap: widget.onAddToCart,
                            borderRadius: BorderRadius.circular(16),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFFF6B35), Color(0xFFF7931E)],
                                ),
                                shape: BoxShape.circle,
                                boxShadow: _isHovered
                                    ? [
                                        BoxShadow(
                                          color: const Color(0xFFFF6B35).withOpacity(0.4),
                                          blurRadius: 16,
                                          offset: const Offset(0, 6),
                                        ),
                                      ]
                                    : [
                                        BoxShadow(
                                          color: const Color(0xFFFF6B35).withOpacity(0.2),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final Pizza pizza;
  final int quantity;
  final VoidCallback onRemove;

  const CartItem({
    super.key,
    required this.pizza,
    required this.quantity,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFFFFF8F0),
                  const Color(0xFFFFF0E0),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF6B35).withOpacity(0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                pizza.imageUrl,
                style: const TextStyle(fontSize: 42),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pizza.name,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                    color: const Color(0xFF1A1A2E),
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFFFF6B35).withOpacity(0.15),
                            const Color(0xFFFF6B35).withOpacity(0.08),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'x$quantity',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFFF6B35),
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'R\$ ${(pizza.price * quantity).toStringAsFixed(2)}',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF636E72),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onRemove,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFF6B35).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.remove_circle_outline,
                color: Color(0xFFFF6B35),
                size: 26,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
