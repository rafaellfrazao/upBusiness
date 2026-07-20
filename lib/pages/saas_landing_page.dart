import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/saas_content.dart';
import '../theme/app_theme.dart';

class SaasLandingPage extends StatefulWidget {
  const SaasLandingPage({super.key});

  @override
  State<SaasLandingPage> createState() => _SaasLandingPageState();
}

class _SaasLandingPageState extends State<SaasLandingPage> {
  final _scrollController = ScrollController();
  final _featuresKey = GlobalKey();
  final _segmentsKey = GlobalKey();
  final _plansKey = GlobalKey();
  final _contactKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            _Hero(
              onFeatures: () => _scrollTo(_featuresKey),
              onPlans: () => _scrollTo(_plansKey),
              onContact: () => _scrollTo(_contactKey),
              onDemo: () => Navigator.pushNamed(context, '/demo'),
            ),
            KeyedSubtree(key: _featuresKey, child: const _FeaturesSection()),
            KeyedSubtree(key: _segmentsKey, child: const _SegmentsSection()),
            KeyedSubtree(key: _plansKey, child: const _PlansSection()),
            KeyedSubtree(key: _contactKey, child: const _ContactSection()),
            const _Footer(),
          ],
        ),
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  final VoidCallback onFeatures;
  final VoidCallback onPlans;
  final VoidCallback onContact;
  final VoidCallback onDemo;

  const _Hero({
    required this.onFeatures,
    required this.onPlans,
    required this.onContact,
    required this.onDemo,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 900;

    return Container(
      decoration: const BoxDecoration(color: AppTheme.bg),
      child: Stack(
        children: [
          Positioned(top: -80, right: -60, child: _Glow(180, AppTheme.neonRed.withValues(alpha: 0.25))),
          Positioned(bottom: 40, left: -40, child: _Glow(140, AppTheme.neonOrange.withValues(alpha: 0.2))),
          Positioned(top: 200, left: 200, child: _Glow(80, AppTheme.neonGold.withValues(alpha: 0.1))),
          SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(isWide ? 80 : 24, 16, isWide ? 80 : 24, isWide ? 80 : 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Navbar(
                onFeatures: onFeatures,
                onPlans: onPlans,
                onContact: onContact,
                onDemo: onDemo,
              ),
              SizedBox(height: isWide ? 64 : 40),
              if (isWide)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: _HeroText(isWide: true, onPlans: onPlans, onContact: onContact)),
                    const SizedBox(width: 48),
                    Expanded(child: _HeroMockup(isWide: true)),
                  ],
                )
              else ...[
                _HeroText(isWide: false, onPlans: onPlans, onContact: onContact),
                const SizedBox(height: 32),
                _HeroMockup(isWide: false),
              ],
            ],
          ),
        ),
          ),
        ],
      ),
    );
  }
}

class _Glow extends StatelessWidget {
  final double size;
  final Color color;
  const _Glow(this.size, this.color);

  @override
  Widget build(BuildContext context) => Container(
        width: size, height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [BoxShadow(color: color, blurRadius: 80, spreadRadius: 30)]),
      );
}

class _Navbar extends StatelessWidget {
  final VoidCallback onFeatures;
  final VoidCallback onPlans;
  final VoidCallback onContact;
  final VoidCallback onDemo;

  const _Navbar({
    required this.onFeatures,
    required this.onPlans,
    required this.onContact,
    required this.onDemo,
  });

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 960;

    return Row(
      children: [
        Flexible(
          child: Text(
            appName,
            overflow: TextOverflow.ellipsis,
          style: AppTheme.display(22),
          ),
        ),
        const Spacer(),
        if (isWide) ...[
          _NavLink(label: 'Recursos', onTap: onFeatures),
          _NavLink(label: 'Planos', onTap: onPlans),
          _NavLink(label: 'Contato', onTap: onContact),
          //_NavLink(label: 'Demonstração', onTap: onDemo),
          const SizedBox(width: 16),
        ],
        ElevatedButton(
          onPressed: onPlans,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.neonRed,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: const Text('Começar grátis'),
        ),
      ],
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _NavLink({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 15)),
    );
  }
}

class _HeroText extends StatelessWidget {
  final bool isWide;
  final VoidCallback onPlans;
  final VoidCallback onContact;

  const _HeroText({
    required this.isWide,
    required this.onPlans,
    required this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white24),
          ),
          child: Text(
            '🚀 Impulsione suas vendas e gestão',
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 13),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          heroTitle,
          style: AppTheme.display(isWide ? 48 : 34),
        ),
        const SizedBox(height: 16),
        Text(
          heroSubtitle,
          style: GoogleFonts.poppins(
            fontSize: isWide ? 18 : 16,
            color: Colors.white.withValues(alpha: 0.9),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ElevatedButton(
              onPressed: onPlans,
              child: const Text('Ver planos'),
            ),
            OutlinedButton(
              onPressed: onContact,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white, width: 2),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text('Falar com vendas'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            _StatChip(value: '500+', label: 'Lojas ativas'),
            const SizedBox(width: 24),
            _StatChip(value: '4.9★', label: 'Avaliação'),
          ],
        ),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  final String value;
  final String label;

  const _StatChip({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
        Text(label, style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70)),
      ],
    );
  }
}

class _HeroMockup extends StatelessWidget {
  final bool isWide;

  const _HeroMockup({required this.isWide});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.glass(r: 20, glow: AppTheme.neonOrange),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: AppTheme.primaryRed, borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.restaurant, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('UB', style: GoogleFonts.orbitron(fontWeight: FontWeight.w600, color: AppTheme.textPrimary)),
                      const SizedBox(width: 4),
                      Text('up business', style: GoogleFonts.rajdhani(fontSize: 12, color: AppTheme.neonOrange)),
                    ],
                  ),
                  Text('Cardápio digital', style: GoogleFonts.rajdhani(fontSize: 12, color: AppTheme.textMuted)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          _MockItem(name: 'Pizza Margherita G', price: 'R\$ 49,90'),
          _MockItem(name: 'Pizza Calabresa M', price: 'R\$ 39,90'),
          _MockItem(name: 'Refrigerante 2L', price: 'R\$ 12,00'),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFF25D366),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.chat, color: Colors.white, size: 18),
                const SizedBox(width: 8),
                Text('Pedir pelo WhatsApp', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MockItem extends StatelessWidget {
  final String name;
  final String price;

  const _MockItem({required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Text(name, style: GoogleFonts.rajdhani(fontSize: 14, color: AppTheme.textPrimary))),
          Text(price, style: GoogleFonts.orbitron(fontWeight: FontWeight.w600, color: AppTheme.neonRed, fontSize: 13)),
        ],
      ),
    );
  }
}

class _FeaturesSection extends StatelessWidget {
  const _FeaturesSection();

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;
    final padding = EdgeInsets.symmetric(horizontal: isWide ? 80 : 24, vertical: 64);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        border: Border(top: BorderSide(color: AppTheme.neonRed.withValues(alpha: 0.15))),
      ),
      padding: padding,
      child: Column(
        children: [
          _SectionTitle(
            badge: 'Recursos',
            title: 'Tudo que seu negócio precisa',
            subtitle: 'Ferramentas pensadas para quem vive a correria da cozinha.',
          ),
          const SizedBox(height: 48),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: features.map((f) => SizedBox(
              width: isWide ? 340 : double.infinity,
              child: _FeatureCard(feature: f),
            )).toList(),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final SaasFeature feature;

  const _FeatureCard({required this.feature});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: AppTheme.glass(glow: AppTheme.neonRed),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(feature.icon, style: const TextStyle(fontSize: 32)),
          const SizedBox(height: 12),
          Text(feature.title, style: GoogleFonts.orbitron(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textPrimary)),
          const SizedBox(height: 8),
          Text(feature.description, style: GoogleFonts.rajdhani(color: AppTheme.textMuted, height: 1.5, fontSize: 15)),
        ],
      ),
    );
  }
}

class _SegmentsSection extends StatelessWidget {
  const _SegmentsSection();

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.card,
        border: Border(top: BorderSide(color: AppTheme.neonOrange.withValues(alpha: 0.12)),
            bottom: BorderSide(color: AppTheme.neonOrange.withValues(alpha: 0.12))),
      ),
      padding: EdgeInsets.symmetric(horizontal: isWide ? 80 : 24, vertical: 64),
      child: Column(
        children: [
          _SectionTitle(
            badge: 'Para quem é',
            title: 'Feito para o seu segmento',
            subtitle: 'Templates e fluxos prontos para cada tipo de estabelecimento.',
          ),
          const SizedBox(height: 48),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: segments.map((s) => SizedBox(
              width: isWide ? 300 : double.infinity,
              child: _SegmentCard(segment: s),
            )).toList(),
          ),
        ],
      ),
    );
  }
}

class _SegmentCard extends StatelessWidget {
  final SaasSegment segment;

  const _SegmentCard({required this.segment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: AppTheme.glass(glow: AppTheme.neonGold),
      child: Column(
        children: [
          Text(segment.emoji, style: const TextStyle(fontSize: 48)),
          const SizedBox(height: 16),
          Text(segment.title, style: GoogleFonts.orbitron(fontSize: 16, fontWeight: FontWeight.w600, color: AppTheme.textPrimary)),
          const SizedBox(height: 8),
          Text(segment.description, textAlign: TextAlign.center, style: GoogleFonts.rajdhani(color: AppTheme.textMuted)),
        ],
      ),
    );
  }
}

class _PlansSection extends StatelessWidget {
  const _PlansSection();

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        border: Border(top: BorderSide(color: AppTheme.neonRed.withValues(alpha: 0.15))),
      ),
      padding: EdgeInsets.symmetric(horizontal: isWide ? 80 : 24, vertical: 64),
      child: Column(
        children: [
          _SectionTitle(
            badge: 'Planos',
            title: 'Preços simples, sem surpresa',
            subtitle: '14 dias grátis em qualquer plano. Cancele quando quiser.',
          ),
          const SizedBox(height: 48),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: plans.map((p) => SizedBox(
              width: isWide ? 300 : double.infinity,
              child: _PlanCard(plan: p),
            )).toList(),
          ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final SaasPlan plan;

  const _PlanCard({required this.plan});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: plan.highlighted ? null : AppTheme.card,
        gradient: plan.highlighted
            ? LinearGradient(colors: [AppTheme.neonRed.withValues(alpha: 0.25), AppTheme.neonOrange.withValues(alpha: 0.15)])
            : null,
        border: Border.all(color: plan.highlighted ? AppTheme.neonRed : AppTheme.neonRed.withValues(alpha: 0.25), width: plan.highlighted ? 2 : 1),
        boxShadow: [BoxShadow(color: AppTheme.neonRed.withValues(alpha: plan.highlighted ? 0.25 : 0.08), blurRadius: 20)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (plan.highlighted)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(color: AppTheme.warmOrange, borderRadius: BorderRadius.circular(8)),
              child: Text('Mais popular', style: GoogleFonts.poppins(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w600)),
            ),
          Text(
            plan.name,
            style: GoogleFonts.orbitron(fontSize: 18, fontWeight: FontWeight.w600, color: AppTheme.textPrimary),
          ),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  plan.price,
                  style: GoogleFonts.orbitron(fontSize: 32, fontWeight: FontWeight.bold, color: plan.highlighted ? AppTheme.neonGold : AppTheme.neonRed),
                ),
                if (plan.period.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(plan.period, style: GoogleFonts.poppins(color: plan.highlighted ? Colors.white70 : Colors.grey)),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ...plan.features.map((f) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Icon(Icons.check_circle, size: 18, color: plan.highlighted ? Colors.white : AppTheme.warmOrange),
                const SizedBox(width: 8),
                Expanded(child: Text(f, style: GoogleFonts.rajdhani(color: AppTheme.textMuted, fontSize: 14))),
              ],
            ),
          )),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: plan.highlighted ? Colors.white : AppTheme.primaryRed,
                foregroundColor: plan.highlighted ? AppTheme.primaryRed : Colors.white,
              ),
              child: Text(plan.name == 'Galaxy' ? 'Falar com vendas' : 'Começar grátis'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactSection extends StatefulWidget {
  const _ContactSection();

  @override
  State<_ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<_ContactSection> {
  final _formKey = GlobalKey<FormState>();
  bool _sent = false;

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        border: Border(top: BorderSide(color: AppTheme.neonRed.withValues(alpha: 0.2))),
      ),
      padding: EdgeInsets.symmetric(horizontal: isWide ? 80 : 24, vertical: 64),
      child: isWide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _ContactInfo()),
                const SizedBox(width: 48),
                Expanded(child: _sent ? _SuccessMessage() : _ContactForm(formKey: _formKey, onSubmit: _submit)),
              ],
            )
          : Column(
              children: [
                _ContactInfo(),
                const SizedBox(height: 32),
                _sent ? _SuccessMessage() : _ContactForm(formKey: _formKey, onSubmit: _submit),
              ],
            ),
    );
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _sent = true);
    }
  }
}

class _ContactInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Contato', style: GoogleFonts.poppins(color: AppTheme.warmOrange, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        Text(
          'Pronto para digitalizar\nseu negócio?',
          style: GoogleFonts.playfairDisplay(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white, height: 1.2),
        ),
        const SizedBox(height: 16),
        Text(
          'Preencha o formulário e nossa equipe entra em contato em até 24h.',
          style: GoogleFonts.poppins(color: Colors.white70, height: 1.6),
        ),
        const SizedBox(height: 24),
        _ContactRow(icon: Icons.email_outlined, text: 'contato@pedidofacil.com.br'),
        _ContactRow(icon: Icons.phone_outlined, text: '(11) 99999-0000'),
      ],
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ContactRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.warmOrange, size: 20),
          const SizedBox(width: 12),
          Text(text, style: GoogleFonts.poppins(color: Colors.white)),
        ],
      ),
    );
  }
}

class _ContactForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final VoidCallback onSubmit;

  const _ContactForm({required this.formKey, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: AppTheme.glass(r: 16),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Nome'),
              validator: (v) => v == null || v.isEmpty ? 'Informe seu nome' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'E-mail'),
              validator: (v) => v == null || !v.contains('@') ? 'E-mail inválido' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Tipo de negócio'),
              validator: (v) => v == null || v.isEmpty ? 'Informe o tipo' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Mensagem'),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: onSubmit, child: const Text('Enviar mensagem')),
            ),
          ],
        ),
      ),
    );
  }
}

class _SuccessMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: AppTheme.glass(r: 16),
      child: Column(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 64),
          const SizedBox(height: 16),
          Text('Mensagem enviada!', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text('Entraremos em contato em breve.', style: GoogleFonts.poppins(color: Colors.grey)),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1A0F0A),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        children: [
          Text(appName, style: AppTheme.display(20)),
          const SizedBox(height: 8),
          Text('© 2026 $appName. Todos os direitos reservados.', style: GoogleFonts.poppins(color: Colors.white54, fontSize: 13)),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String badge;
  final String title;
  final String subtitle;

  const _SectionTitle({required this.badge, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(badge, style: GoogleFonts.orbitron(color: AppTheme.neonOrange, fontWeight: FontWeight.w600, fontSize: 12)),
        const SizedBox(height: 8),
        Text(title, textAlign: TextAlign.center, style: AppTheme.display(28)),
        const SizedBox(height: 12),
        Text(subtitle, textAlign: TextAlign.center, style: GoogleFonts.rajdhani(color: AppTheme.textMuted, fontSize: 16)),
      ],
    );
  }
}
