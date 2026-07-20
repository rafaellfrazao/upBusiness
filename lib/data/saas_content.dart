class SaasPlan {
  final String name;
  final String price;
  final String period;
  final List<String> features;
  final bool highlighted;

  const SaasPlan({
    required this.name,
    required this.price,
    required this.period,
    required this.features,
    this.highlighted = false,
  });
}

class SaasFeature {
  final String icon;
  final String title;
  final String description;

  const SaasFeature({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class SaasSegment {
  final String emoji;
  final String title;
  final String description;

  const SaasSegment({
    required this.emoji,
    required this.title,
    required this.description,
  });
}

const appName = 'UB upBusiness';

const heroTitle = 'Focada em Resultados e Evolução';
const heroSubtitle =
    'Cardápio holográfico, pedidos inteligentes e gestão em tempo real. '
    'Tecnologia de ponta para seu negócio decolar.';

const features = [
  SaasFeature(icon: '🛸', title: 'Cardápio 3D', description: 'Sabores em destaque com visual imersivo que aumenta conversão.'),
  SaasFeature(icon: '⚡', title: 'Pedido instantâneo', description: 'Cliente monta a pizza e dispara pro WhatsApp em 1 toque.'),
  SaasFeature(icon: '🤖', title: 'IA de sugestões', description: 'Recomenda combos e bordas com base no histórico de pedidos.'),
  SaasFeature(icon: '📡', title: 'Painel em tempo real', description: 'Preços, promoções e estoque atualizados ao vivo.'),
  SaasFeature(icon: '📋', title: 'Catálogo Inteligente', description: 'Permita que seu cliente personalize o pedido ou escolha serviços adicionais de forma simples.'),
  SaasFeature(icon: '🔐', title: 'Infra segura', description: 'Cloud com backups automáticos e 99.9% de uptime.'),
];

const segments = [
  SaasSegment(emoji: '🛍️', title: 'Vitrine Digital', description: 'Exposição moderna e premium de produtos e serviços para qualquer tipo de comércio local.'),
  SaasSegment(emoji: '🚀', title: 'Delivery turbo', description: 'Fluxo otimizado pra volume alto e entrega rápida.'),
  SaasSegment(emoji: '✨', title: 'Gourmet lab', description: 'Sabores especiais, harmonização e experiência exclusiva.'),
];

const plans = [
  SaasPlan(
    name: 'Slice',
    price: 'R\$ 49',
    period: '/mês',
    features: ['1 unidade', '50 sabores', 'Cardápio web', 'WhatsApp', 'Suporte e-mail'],
  ),
  SaasPlan(
    name: 'Orbit',
    price: 'R\$ 99',
    period: '/mês',
    highlighted: true,
    features: ['3 unidades', 'Sabores ∞', 'Domínio próprio', 'Analytics', 'Suporte VIP'],
  ),
  SaasPlan(
    name: 'Galaxy',
    price: 'Consulte',
    period: '',
    features: ['Rede completa', 'API aberta', 'Gerente dedicado', 'SLA premium', 'Onboarding'],
  ),
];
