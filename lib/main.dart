import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MoodLedgerApp());

class SpendingEntry {
  const SpendingEntry({required this.date, required this.amount, required this.category, required this.motive, required this.impulsive});
  final DateTime date; final double amount; final String category; final String motive; final bool impulsive;
  Map<String, dynamic> toJson() => {'date': date.toIso8601String(), 'amount': amount, 'category': category, 'motive': motive, 'impulsive': impulsive};
  factory SpendingEntry.fromJson(Map<String, dynamic> j) => SpendingEntry(date: DateTime.parse(j['date'] as String), amount: (j['amount'] as num).toDouble(), category: j['category'] as String, motive: j['motive'] as String, impulsive: j['impulsive'] as bool);
}
class MoodEntry { const MoodEntry({required this.mood, required this.energy, required this.sleep}); final int mood, energy, sleep; Map<String, dynamic> toJson() => {'mood': mood, 'energy': energy, 'sleep': sleep}; }

class MoodLedgerApp extends StatelessWidget {
  const MoodLedgerApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(title: 'MoodLedger', theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo), useMaterial3: true), home: const DashboardPage());
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  @override State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final moods = <MoodEntry>[const MoodEntry(mood: 6, energy: 7, sleep: 7)];
  bool consentActive = true;
  final _stateReady = Completer<void>();
  @override void initState() { super.initState(); _loadState(); }
  Future<void> _loadState() async { try { if (kIsWeb) { _stateReady.complete(); return; } final prefs = await SharedPreferences.getInstance(); final raw = prefs.getStringList('spending_entries') ?? []; final loaded = <SpendingEntry>[]; for (final value in raw) { try { loaded.add(SpendingEntry.fromJson(jsonDecode(value) as Map<String, dynamic>)); } catch (_) {} } if (mounted) setState(() { consentActive = prefs.getBool('consent_active') ?? true; if (loaded.isNotEmpty) spending..clear()..addAll(loaded); }); } finally { if (!_stateReady.isCompleted) _stateReady.complete(); } }
  Future<void> _setConsent(bool value) async { final prefs = await SharedPreferences.getInstance(); await prefs.setBool('consent_active', value); if (mounted) setState(() => consentActive = value); }
  Future<bool> _saveSpending() async { if (kIsWeb) return false; final prefs = await SharedPreferences.getInstance(); return prefs.setStringList('spending_entries', spending.map((e) => jsonEncode(e.toJson())).toList()); }
  Future<void> _exportData() async { final payload = const JsonEncoder.withIndent('  ').convert({'schemaVersion': 1, 'exportedAt': DateTime.now().toIso8601String(), 'spending': spending.map((e) => e.toJson()).toList(), 'mood': moods.map((e) => e.toJson()).toList()}); await Clipboard.setData(ClipboardData(text: payload)); if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Dados copiados. Cole em um arquivo seguro.'))); }
  final spending = <SpendingEntry>[SpendingEntry(date: DateTime.now(), amount: 89.90, category: 'Alimentação', motive: 'Necessidade planejada', impulsive: false)];
  Future<void> addSpending() async { await _stateReady.future; final entry = await showDialog<SpendingEntry>(context: context, builder: (_) => const SpendingDialog()); if (entry != null) { setState(() => spending.insert(0, entry)); final saved = await _saveSpending(); if (!saved && mounted && !kIsWeb) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Não foi possível persistir o registro.'))); } }
  Future<void> addMood() async { final entry = await showDialog<MoodEntry>(context: context, builder: (_) => const MoodDialog()); if (entry != null) setState(() => moods.insert(0, entry)); }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('MoodLedger'), actions: [IconButton(onPressed: _exportData, tooltip: 'Exportar dados', icon: const Icon(Icons.download)), IconButton(onPressed: () {}, tooltip: 'Privacidade', icon: const Icon(Icons.lock_outline))]),
    floatingActionButton: Column(mainAxisSize: MainAxisSize.min, children: [FloatingActionButton.extended(onPressed: addMood, icon: const Icon(Icons.mood), label: const Text('Registrar humor')), const SizedBox(height: 12), FloatingActionButton.extended(onPressed: addSpending, icon: const Icon(Icons.add), label: const Text('Registrar compra'))]),
    body: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 1000), child: ListView(padding: const EdgeInsets.all(24), children: [
      Text('Seu acompanhamento', style: Theme.of(context).textTheme.headlineMedium),
      const Text('Registre o contexto. Os padrões são informativos e devem ser revisados com seu profissional.'),
      const SizedBox(height: 24),
      Wrap(spacing: 16, runSpacing: 16, children: [MetricCard(label: 'Humor recente', value: '${moods.first.mood}/10', icon: Icons.mood), MetricCard(label: 'Energia recente', value: '${moods.first.energy}/10', icon: Icons.bolt), MetricCard(label: 'Sono recente', value: '${moods.first.sleep}h', icon: Icons.bedtime), MetricCard(label: 'Gastos registrados', value: 'R\$ ${spending.fold<double>(0, (s, e) => s + e.amount).toStringAsFixed(2)}', icon: Icons.payments)]),
      const SizedBox(height: 20), Card(child: SwitchListTile(title: const Text('Compartilhamento consentido'), subtitle: Text(consentActive ? 'Ativo para revisão profissional' : 'Desativado'), value: consentActive, onChanged: _setConsent)),
      const SizedBox(height: 8), Text('Linha do tempo', style: Theme.of(context).textTheme.titleLarge),
      const Text('Eventos próximos no tempo não provam causalidade.'),
      Card(child: ListTile(leading: const CircleAvatar(child: Icon(Icons.mood)), title: Text('Humor ${moods.first.mood}/10 · energia ${moods.first.energy}/10'), subtitle: Text('Sono: ${moods.first.sleep}h · autorrelato'), trailing: const Text('hoje'))),
      ...spending.map((e) => Card(child: ListTile(leading: CircleAvatar(child: Icon(e.impulsive ? Icons.flash_on : Icons.receipt_long)), title: Text('${e.category} · R\$ ${e.amount.toStringAsFixed(2)}'), subtitle: Text('${e.motive}${e.impulsive ? ' · marcada como impulsiva' : ''}'), trailing: Text('${e.date.day}/${e.date.month}')))),
    ]))),
  );
}

class MetricCard extends StatelessWidget { const MetricCard({super.key, required this.label, required this.value, required this.icon}); final String label, value; final IconData icon; @override Widget build(BuildContext c) => SizedBox(width: 240, child: Card(child: Padding(padding: const EdgeInsets.all(16), child: Row(children: [Icon(icon), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, overflow: TextOverflow.ellipsis), Text(value, overflow: TextOverflow.ellipsis, style: Theme.of(c).textTheme.titleLarge)]))])))); }

class SpendingDialog extends StatefulWidget { const SpendingDialog({super.key}); @override State<SpendingDialog> createState() => _SpendingDialogState(); }
class _SpendingDialogState extends State<SpendingDialog> {
  final amount = TextEditingController(); final motive = TextEditingController(); String category = 'Alimentação'; bool impulsive = false;
  @override Widget build(BuildContext context) => AlertDialog(title: const Text('Registrar compra'), content: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [TextField(controller: amount, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Valor (R\$)')), DropdownButtonFormField<String>(initialValue: category, items: ['Alimentação', 'Lazer', 'Casa', 'Transporte', 'Outro'].map((x) => DropdownMenuItem(value: x, child: Text(x))).toList(), onChanged: (x) => setState(() => category = x!)), TextField(controller: motive, decoration: const InputDecoration(labelText: 'Motivo da compra')), SwitchListTile(title: const Text('Foi impulsiva?'), value: impulsive, onChanged: (x) => setState(() => impulsive = x))])), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')), FilledButton(onPressed: () { final v = double.tryParse(amount.text.replaceAll(',', '.')); if (v != null && v > 0 && motive.text.trim().isNotEmpty) Navigator.pop(context, SpendingEntry(date: DateTime.now(), amount: v, category: category, motive: motive.text.trim(), impulsive: impulsive)); }, child: const Text('Salvar'))]);
}
class MoodDialog extends StatefulWidget { const MoodDialog({super.key}); @override State<MoodDialog> createState() => _MoodDialogState(); }
class _MoodDialogState extends State<MoodDialog> { double mood = 5, energy = 5; final sleep = TextEditingController(text: '7'); @override Widget build(BuildContext c) => AlertDialog(title: const Text('Registrar estado mental'), content: Column(mainAxisSize: MainAxisSize.min, children: [Text('Humor: ${mood.round()}/10'), Slider(value: mood, min: 0, max: 10, divisions: 10, onChanged: (v) => setState(() => mood = v)), Text('Energia: ${energy.round()}/10'), Slider(value: energy, min: 0, max: 10, divisions: 10, onChanged: (v) => setState(() => energy = v)), TextField(controller: sleep, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Horas de sono'))]), actions: [TextButton(onPressed: () => Navigator.pop(c), child: const Text('Cancelar')), FilledButton(onPressed: () { final h = int.tryParse(sleep.text); if (h != null && h <= 24) Navigator.pop(c, MoodEntry(mood: mood.round(), energy: energy.round(), sleep: h)); }, child: const Text('Salvar'))]); }
