import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_constants.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key, required this.children, this.padding = const EdgeInsets.fromLTRB(24, 48, 24, 120)});
  final List<Widget> children;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) => Scaffold(body: SafeArea(bottom: false, child: SingleChildScrollView(padding: padding, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children))));
}

class SoftCard extends StatelessWidget {
  const SoftCard({super.key, required this.child, this.color, this.borderColor, this.padding = const EdgeInsets.all(18), this.onTap});
  final Widget child; final Color? color; final Color? borderColor; final EdgeInsets padding; final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final c = color ?? Theme.of(context).cardTheme.color ?? Colors.white;
    final card = Container(
      padding: padding,
      decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(24), border: Border.all(color: borderColor ?? Theme.of(context).dividerColor.withOpacity(.13)), boxShadow: [BoxShadow(color: Colors.black.withOpacity(.035), blurRadius: 20, offset: const Offset(0, 10))]),
      child: child,
    );
    return onTap == null ? card : InkWell(borderRadius: BorderRadius.circular(24), onTap: onTap, child: card);
  }
}

class EmojiTile extends StatelessWidget {
  const EmojiTile({super.key, required this.emoji, required this.color, this.size = 64});
  final String emoji; final Color color; final double size;
  @override
  Widget build(BuildContext context) => Container(width: size, height: size, decoration: BoxDecoration(color: color.withOpacity(.13), borderRadius: BorderRadius.circular(16)), child: Center(child: Text(emoji, style: TextStyle(fontSize: size * .48))));
}

class SectionHeader extends StatelessWidget {
  const SectionHeader(this.title, {super.key, this.trailing});
  final String title; final Widget? trailing;
  @override
  Widget build(BuildContext context) => Row(children: [Expanded(child: Text(title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800))), if (trailing != null) trailing!]);
}

class Pill extends StatelessWidget {
  const Pill({super.key, required this.child, this.color = const Color(0xFFEAF7EE), this.padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 9)});
  final Widget child; final Color color; final EdgeInsets padding;
  @override
  Widget build(BuildContext context) => Container(padding: padding, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(18)), child: child);
}

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key, required this.currentIndex});
  final int currentIndex;
  static const routes = ['/home', '/calendar', '/add', '/progress', '/profile'];
  @override
  Widget build(BuildContext context) => BottomAppBar(
    height: 94,
    color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.96),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      _item(context, Icons.home_outlined, 'Home', 0), _item(context, Icons.calendar_today_outlined, 'Calendar', 1),
      InkWell(onTap: () => context.go('/add'), child: Container(width: 72, height: 72, decoration: BoxDecoration(color: AppColors.green, shape: BoxShape.circle, border: Border.all(color: AppColors.green.withOpacity(.16), width: 10), boxShadow: [BoxShadow(color: AppColors.green.withOpacity(.3), blurRadius: 18)]), child: const Icon(Icons.add, color: Colors.white, size: 38))),
      _item(context, Icons.bar_chart_rounded, 'Progress', 3), _item(context, Icons.person_outline, 'Profile', 4),
    ]));
  Widget _item(BuildContext context, IconData icon, String label, int index) {
    final active = currentIndex == index;
    return InkWell(onTap: () => context.go(routes[index]), child: SizedBox(width: 70, child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: active ? AppColors.green : AppColors.muted, size: 30), const SizedBox(height: 4), Text(label, style: TextStyle(color: active ? AppColors.green : AppColors.muted, fontWeight: active ? FontWeight.w800 : FontWeight.w600))])));
  }
}

class ShellScaffold extends StatelessWidget {
  const ShellScaffold({super.key, required this.child, required this.index});
  final Widget child; final int index;
  @override
  Widget build(BuildContext context) => Scaffold(body: child, bottomNavigationBar: AppBottomNav(currentIndex: index));
}

class SmallAvatar extends StatelessWidget {
  const SmallAvatar({super.key, this.size = 72}); final double size;
  @override
  Widget build(BuildContext context) => Container(width: size, height: size, decoration: const BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [Color(0xFFDCEFE2), Color(0xFFEAF3F5)])), child: Center(child: Text('👨🏽‍💻', style: TextStyle(fontSize: size * .5))));
}
