import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'design_system.dart';

void main() => runApp(const MoodLedgerApp());

class SpendingEntry {
  const SpendingEntry({
    required this.date,
    required this.amount,
    required this.category,
    required this.motive,
    required this.impulsive,
  });
  final DateTime date;
  final double amount;
  final String category;
  final String motive;
  final bool impulsive;
  Map<String, dynamic> toJson() => {
    'date': date.toIso8601String(),
    'amount': amount,
    'category': category,
    'motive': motive,
    'impulsive': impulsive,
  };
  factory SpendingEntry.fromJson(Map<String, dynamic> j) => SpendingEntry(
    date: DateTime.parse(j['date'] as String),
    amount: (j['amount'] as num).toDouble(),
    category: j['category'] as String,
    motive: j['motive'] as String,
    impulsive: j['impulsive'] as bool,
  );
}

class MoodEntry {
  const MoodEntry({
    required this.mood,
    required this.energy,
    required this.sleep,
    this.irritability = 0,
    this.impulsivity = 0,
    this.medicationTaken = false,
    this.missingReason,
    this.date,
  });
  final int mood, energy, sleep, irritability, impulsivity;
  final bool medicationTaken;
  final String? missingReason;
  final DateTime? date;
  Map<String, dynamic> toJson() => {
    'mood': mood,
    'energy': energy,
    'sleep': sleep,
    'irritability': irritability,
    'impulsivity': impulsivity,
    'medicationTaken': medicationTaken,
    if (missingReason != null) 'missingReason': missingReason,
    if (date != null) 'date': date!.toIso8601String(),
  };
  factory MoodEntry.fromJson(Map<String, dynamic> json) => MoodEntry(
    mood: (json['mood'] as num).toInt(),
    energy: (json['energy'] as num).toInt(),
    sleep: (json['sleep'] as num).toInt(),
    irritability: (json['irritability'] as num?)?.toInt() ?? 0,
    impulsivity: (json['impulsivity'] as num?)?.toInt() ?? 0,
    medicationTaken: json['medicationTaken'] as bool? ?? false,
    missingReason: json['missingReason'] as String?,
    date: json['date'] == null
        ? null
        : DateTime.tryParse(json['date'] as String),
  );
}

class AuditEvent {
  const AuditEvent({required this.operation, required this.at});
  final String operation;
  final DateTime at;
  Map<String, dynamic> toJson() => {
    'operation': operation,
    'at': at.toIso8601String(),
  };
}

class ProfessionalLink {
  const ProfessionalLink({required this.code, required this.active});
  final String code;
  final bool active;
}

class MoodLedgerApp extends StatelessWidget {
  const MoodLedgerApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'MoodLedger',
    theme: MoodLedgerTheme.data(),
    darkTheme: MoodLedgerTheme.dark(),
    themeMode: ThemeMode.system,
    builder: (context, child) {
      final media = MediaQuery.of(context);
      if (!media.highContrast) return child!;
      final dark = media.platformBrightness == Brightness.dark;
      return Theme(
        data: dark
            ? MoodLedgerTheme.dark(highContrast: true)
            : MoodLedgerTheme.data(highContrast: true),
        child: child!,
      );
    },
    home: const DashboardPage(),
  );
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final moods = <MoodEntry>[const MoodEntry(mood: 6, energy: 7, sleep: 7)];
  final consent = <String, bool>{
    'mood': true,
    'spending': true,
    'link': false,
    'export': false,
  };
  ProfessionalLink? professionalLink;
  final audit = <AuditEvent>[];
  bool reduceMotion = false;
  bool reviewSignalEnabled = false;
  String timelinePeriod = 'Tudo';
  String timelineCategory = 'Todas';
  String timelineType = 'Todos';
  final _stateReady = Completer<void>();
  MoodEntry? get latestMood => moods.isEmpty ? null : moods.first;
  @override
  void initState() {
    super.initState();
    _loadState();
  }

  Future<void> _loadState() async {
    try {
      if (kIsWeb) {
        _stateReady.complete();
        return;
      }
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getStringList('spending_entries') ?? [];
      final loaded = <SpendingEntry>[];
      for (final value in raw) {
        try {
          loaded.add(
            SpendingEntry.fromJson(jsonDecode(value) as Map<String, dynamic>),
          );
        } catch (_) {}
      }
      if (mounted) {
        setState(() {
          for (final key in consent.keys) {
            consent[key] = prefs.getBool('consent_$key') ?? consent[key]!;
          }
          if (loaded.isNotEmpty) {
            spending
              ..clear()
              ..addAll(loaded);
          }
          final moodRaw = prefs.getStringList('mood_entries') ?? [];
          final loadedMoods = moodRaw
              .map((value) {
                try {
                  return MoodEntry.fromJson(
                    jsonDecode(value) as Map<String, dynamic>,
                  );
                } catch (_) {
                  return null;
                }
              })
              .whereType<MoodEntry>()
              .toList();
          if (loadedMoods.isNotEmpty) {
            moods
              ..clear()
              ..addAll(loadedMoods);
          }
          final auditRaw = prefs.getStringList('audit_events') ?? [];
          audit
            ..clear()
            ..addAll(
              auditRaw.map((value) {
                try {
                  final json = jsonDecode(value) as Map<String, dynamic>;
                  return AuditEvent(
                    operation: json['operation'] as String,
                    at: DateTime.parse(json['at'] as String),
                  );
                } catch (_) {
                  return null;
                }
              }).whereType<AuditEvent>(),
            );
        });
      }
    } finally {
      if (!_stateReady.isCompleted) _stateReady.complete();
    }
  }

  Future<void> _setConsent(String key, bool value) async {
    if (kIsWeb) {
      setState(() => consent[key] = value);
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('consent_$key', value);
    if (mounted) setState(() => consent[key] = value);
  }

  Future<bool> _saveSpending() async {
    if (kIsWeb) return false;
    final prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(
      'spending_entries',
      spending.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }

  Future<bool> _saveMoods() async {
    if (kIsWeb) return false;
    final prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(
      'mood_entries',
      moods.map((entry) => jsonEncode(entry.toJson())).toList(),
    );
  }

  Future<void> _saveAudit() async {
    if (kIsWeb) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'audit_events',
      audit.map((event) => jsonEncode(event.toJson())).toList(),
    );
  }

  List<String> get _reviewSignals => reviewSignalEnabled && latestMood != null
      ? [
          if (latestMood!.irritability >= 7)
            'Irritabilidade autorrelatada elevada para revisão',
          if (latestMood!.impulsivity >= 7)
            'Impulsividade autorrelatada elevada para revisão',
          if (latestMood!.sleep <= 4)
            'Sono autorrelatado reduzido para revisão',
        ]
      : const [];

  List<SpendingEntry> get _filteredSpending {
    final cutoff = timelinePeriod == '30 dias'
        ? DateTime.now().subtract(const Duration(days: 30))
        : timelinePeriod == '7 dias'
        ? DateTime.now().subtract(const Duration(days: 7))
        : null;
    return spending.where((entry) {
      final matchesPeriod = cutoff == null || !entry.date.isBefore(cutoff);
      final matchesCategory =
          timelineCategory == 'Todas' || entry.category == timelineCategory;
      final matchesType =
          timelineType == 'Todos' ||
          (timelineType == 'Impulsiva' && entry.impulsive) ||
          (timelineType == 'Planejada' && !entry.impulsive);
      return matchesPeriod && matchesCategory && matchesType;
    }).toList();
  }

  Future<void> _exportData() async {
    if (!consent['export']!) {
      _notice('Ative o consentimento de exportação antes de continuar.');
      return;
    }
    final payload = const JsonEncoder.withIndent('  ').convert({
      'schemaVersion': 2,
      'exportedAt': DateTime.now().toIso8601String(),
      'spending': spending.map((e) => e.toJson()).toList(),
      'mood': moods.map((e) => e.toJson()).toList(),
      'audit': audit.map((e) => e.toJson()).toList(),
      'reviewSignals': _reviewSignals,
    });
    try {
      await Clipboard.setData(ClipboardData(text: payload));
    } catch (_) {
      if (mounted) _notice('Não foi possível copiar os dados.');
      return;
    }
    if (mounted) {
      _recordAudit('export');
      _notice('Dados copiados. Cole em um arquivo seguro.');
    }
  }

  void _recordAudit(String operation) {
    setState(
      () => audit.add(AuditEvent(operation: operation, at: DateTime.now())),
    );
    _saveAudit();
  }

  void _notice(String text) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  Future<void> _eraseLocalData() async {
    final confirmed =
        await showDialog<bool>(
          context: context,
          builder: (c) => AlertDialog(
            title: const Text('Excluir dados locais?'),
            content: const Text(
              'Esta ação remove gastos, autorrelatos, consentimentos e vínculo deste dispositivo.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(c, false),
                child: const Text('Cancelar'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(c, true),
                child: const Text('Excluir'),
              ),
            ],
          ),
        ) ??
        false;
    if (!confirmed) return;
    if (!kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('spending_entries');
      await prefs.remove('mood_entries');
      await prefs.remove('audit_events');
      for (final key in consent.keys) {
        await prefs.remove('consent_$key');
      }
    }
    if (!mounted) return;
    _recordAudit('erase_local_data');
    setState(() {
      spending.clear();
      moods.clear();
      professionalLink = null;
      for (final key in consent.keys) {
        consent[key] = false;
      }
    });
    _notice('Dados locais excluídos.');
  }

  Future<void> _linkProfessional() async {
    if (!consent['link']!) {
      _notice('Ative o consentimento de vínculo antes de continuar.');
      return;
    }
    final code = await showDialog<String>(
      context: context,
      builder: (_) => const LinkDialog(),
    );
    if (code != null && mounted) {
      setState(
        () => professionalLink = ProfessionalLink(code: code, active: true),
      );
      _recordAudit('professional_link_created');
    }
  }

  final spending = <SpendingEntry>[
    SpendingEntry(
      date: DateTime.now(),
      amount: 89.90,
      category: 'Alimentação',
      motive: 'Necessidade planejada',
      impulsive: false,
    ),
  ];
  Future<void> addSpending() async {
    await _stateReady.future;
    if (!mounted || !consent['spending']!) {
      _notice('Ative o consentimento de gastos antes de registrar.');
      return;
    }
    final entry = await showDialog<SpendingEntry>(
      context: context,
      builder: (_) => const SpendingDialog(),
    );
    if (entry != null) {
      setState(() => spending.insert(0, entry));
      final saved = await _saveSpending();
      if (!mounted) return;
      if (!saved && !kIsWeb) _notice('Não foi possível persistir o registro.');
    }
  }

  Future<void> addMood() async {
    if (!consent['mood']!) {
      _notice('Ative o consentimento de autorrelato antes de registrar.');
      return;
    }
    final entry = await showDialog<MoodEntry>(
      context: context,
      builder: (_) => const MoodDialog(),
    );
    if (entry != null) {
      setState(() => moods.insert(0, entry));
      _recordAudit('mood_entry_created');
      final saved = await _saveMoods();
      if (!saved && !kIsWeb && mounted) {
        _notice('Não foi possível persistir o autorrelato.');
      }
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('MoodLedger'),
      actions: [
        IconButton(
          onPressed: _linkProfessional,
          tooltip: 'Vincular profissional',
          icon: const Icon(Icons.people_outline),
        ),
        IconButton(
          onPressed: _exportData,
          tooltip: 'Exportar dados',
          icon: const Icon(Icons.download),
        ),
        IconButton(
          onPressed: _eraseLocalData,
          tooltip: 'Excluir dados locais',
          icon: const Icon(Icons.delete_outline),
        ),
      ],
    ),
    floatingActionButton: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton.extended(
          onPressed: addMood,
          icon: const Icon(Icons.mood),
          label: const Text('Registrar humor'),
        ),
        const SizedBox(height: 12),
        FloatingActionButton.extended(
          onPressed: addSpending,
          icon: const Icon(Icons.add),
          label: const Text('Registrar compra'),
        ),
      ],
    ),
    body: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(
              'Seu acompanhamento',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Text(
              'Registre o contexto. Os padrões são informativos e devem ser revisados com seu profissional.',
            ),
            const ListTile(
              leading: Icon(Icons.cloud_off),
              title: Text('Armazenamento local'),
              subtitle: Text(
                'Os registros permanecem neste dispositivo até existir sincronização autorizada.',
              ),
            ),
            const SizedBox(height: 24),
            if (latestMood != null)
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  MetricCard(
                    label: 'Humor recente',
                    value: '${moods.first.mood}/10',
                    icon: Icons.mood,
                  ),
                  MetricCard(
                    label: 'Energia recente',
                    value: '${moods.first.energy}/10',
                    icon: Icons.bolt,
                  ),
                  MetricCard(
                    label: 'Sono recente',
                    value: '${moods.first.sleep}h',
                    icon: Icons.bedtime,
                  ),
                  MetricCard(
                    label: 'Gastos registrados',
                    value:
                        'R\$ ${spending.fold<double>(0, (s, e) => s + e.amount).toStringAsFixed(2)}',
                    icon: Icons.payments,
                  ),
                ],
              ),
            if (latestMood == null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Ainda não há autorrelatos ou gastos.'),
                      const SizedBox(height: 8),
                      const Text(
                        'Seus registros aparecerão aqui e permanecerão neste dispositivo.',
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        children: [
                          FilledButton.icon(
                            onPressed: addMood,
                            icon: const Icon(Icons.mood),
                            label: const Text('Registrar humor'),
                          ),
                          OutlinedButton.icon(
                            onPressed: addSpending,
                            icon: const Icon(Icons.add),
                            label: const Text('Registrar compra'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 20),
            Card(
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('Reduzir animações'),
                    subtitle: const Text(
                      'Mantém informação e remove movimento decorativo',
                    ),
                    value: reduceMotion,
                    onChanged: (v) => setState(() => reduceMotion = v),
                  ),
                  SwitchListTile(
                    title: const Text('Sinal para revisão'),
                    subtitle: const Text(
                      'Apenas organiza dados para revisão profissional; não é diagnóstico.',
                    ),
                    value: reviewSignalEnabled,
                    onChanged: (v) => setState(() => reviewSignalEnabled = v),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Resumo visual',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (latestMood != null)
              TrendBar(
                label: 'Humor autorrelatado',
                value: latestMood!.mood / 10,
                color: Colors.indigo,
                animate: !reduceMotion,
              ),
            if (latestMood != null)
              TrendBar(
                label: 'Energia autorrelatada',
                value: latestMood!.energy / 10,
                color: Colors.deepOrange.shade700,
                animate: !reduceMotion,
              ),
            if (_reviewSignals.isNotEmpty)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.flag_outlined),
                  title: const Text('Pontos para revisão'),
                  subtitle: Text(_reviewSignals.join(' · ')),
                ),
              ),
            const SizedBox(height: 20),
            if (latestMood != null)
              Card(
                child: Column(
                  children: [
                    const ListTile(
                      title: Text('Consentimentos'),
                      subtitle: Text(
                        'Cada finalidade pode ser revogada separadamente.',
                      ),
                    ),
                    ...{
                      'mood': 'Autorrelatos',
                      'spending': 'Gastos',
                      'link': 'Vínculo profissional',
                      'export': 'Exportação JSON',
                    }.entries.map(
                      (e) => SwitchListTile(
                        title: Text(e.value),
                        value: consent[e.key]!,
                        onChanged: (v) => _setConsent(e.key, v),
                      ),
                    ),
                  ],
                ),
              ),
            if (professionalLink != null)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.verified_user),
                  title: const Text('Profissional vinculado'),
                  subtitle: Text(
                    'Código ${professionalLink!.code} · acesso autorizado',
                  ),
                  trailing: TextButton(
                    onPressed: () => setState(() => professionalLink = null),
                    child: const Text('Revogar'),
                  ),
                ),
              ),
            const SizedBox(height: 8),
            Text(
              'Linha do tempo',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Text('Eventos próximos no tempo não provam causalidade.'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                DropdownButton<String>(
                  value: timelinePeriod,
                  items: ['Tudo', '7 dias', '30 dias']
                      .map(
                        (v) => DropdownMenuItem(
                          value: v,
                          child: Text('Período: $v'),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => timelinePeriod = v!),
                ),
                DropdownButton<String>(
                  value: timelineCategory,
                  items: ['Todas', ...spending.map((e) => e.category).toSet()]
                      .map(
                        (v) => DropdownMenuItem(
                          value: v,
                          child: Text('Categoria: $v'),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => timelineCategory = v!),
                ),
                DropdownButton<String>(
                  value: timelineType,
                  items: ['Todos', 'Planejada', 'Impulsiva']
                      .map(
                        (v) =>
                            DropdownMenuItem(value: v, child: Text('Tipo: $v')),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => timelineType = v!),
                ),
              ],
            ),
            if (latestMood != null)
              Card(
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.mood)),
                  title: Text(
                    'Humor ${latestMood!.mood}/10 · energia ${latestMood!.energy}/10',
                  ),
                  subtitle: Text(
                    'Sono: ${latestMood!.sleep}h · irritabilidade ${latestMood!.irritability}/10 · impulsividade ${latestMood!.impulsivity}/10 · autorrelato',
                  ),
                  trailing: const Text('hoje'),
                ),
              ),
            if (_filteredSpending.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text('Nenhuma compra registrada.'),
              ),
            ..._filteredSpending.map(
              (e) => Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(
                      e.impulsive ? Icons.flash_on : Icons.receipt_long,
                    ),
                  ),
                  title: Text(
                    '${e.category} · R\$ ${e.amount.toStringAsFixed(2)}',
                  ),
                  subtitle: Text(
                    '${e.motive}${e.impulsive ? ' · marcada como impulsiva' : ''}',
                  ),
                  trailing: Text('${e.date.day}/${e.date.month}'),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class MetricCard extends StatelessWidget {
  const MetricCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });
  final String label, value;
  final IconData icon;
  @override
  Widget build(BuildContext c) => SizedBox(
    width: 240,
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, overflow: TextOverflow.ellipsis),
                  Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(c).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class SpendingDialog extends StatefulWidget {
  const SpendingDialog({super.key});
  @override
  State<SpendingDialog> createState() => _SpendingDialogState();
}

class _SpendingDialogState extends State<SpendingDialog> {
  final amount = TextEditingController();
  final motive = TextEditingController();
  String category = 'Alimentação';
  bool impulsive = false;
  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('Registrar compra'),
    content: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: amount,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Valor (R\$)'),
          ),
          DropdownButtonFormField<String>(
            initialValue: category,
            items: [
              'Alimentação',
              'Lazer',
              'Casa',
              'Transporte',
              'Outro',
            ].map((x) => DropdownMenuItem(value: x, child: Text(x))).toList(),
            onChanged: (x) => setState(() => category = x!),
          ),
          TextField(
            controller: motive,
            decoration: const InputDecoration(labelText: 'Motivo da compra'),
          ),
          SwitchListTile(
            title: const Text('Foi impulsiva?'),
            value: impulsive,
            onChanged: (x) => setState(() => impulsive = x),
          ),
        ],
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancelar'),
      ),
      FilledButton(
        onPressed: () {
          final v = double.tryParse(amount.text.replaceAll(',', '.'));
          if (v != null && v > 0 && motive.text.trim().isNotEmpty) {
            Navigator.pop(
              context,
              SpendingEntry(
                date: DateTime.now(),
                amount: v,
                category: category,
                motive: motive.text.trim(),
                impulsive: impulsive,
              ),
            );
          }
        },
        child: const Text('Salvar'),
      ),
    ],
  );
}

class MoodDialog extends StatefulWidget {
  const MoodDialog({super.key});
  @override
  State<MoodDialog> createState() => _MoodDialogState();
}

class _MoodDialogState extends State<MoodDialog> {
  double mood = 5, energy = 5, irritability = 0, impulsivity = 0;
  bool medicationTaken = false;
  final sleep = TextEditingController(text: '7');
  @override
  Widget build(BuildContext c) => AlertDialog(
    title: const Text('Registrar estado mental'),
    content: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MoodScaleTile(
            label: 'Humor',
            value: mood,
            onChanged: (v) => setState(() => mood = v),
          ),
          const SizedBox(height: 8),
          MoodScaleTile(
            label: 'Energia',
            value: energy,
            onChanged: (v) => setState(() => energy = v),
          ),
          MoodScaleTile(
            label: 'Irritabilidade',
            value: irritability,
            onChanged: (v) => setState(() => irritability = v),
          ),
          MoodScaleTile(
            label: 'Impulsividade',
            value: impulsivity,
            onChanged: (v) => setState(() => impulsivity = v),
          ),
          TextField(
            controller: sleep,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Horas de sono (0 = não informado)',
            ),
          ),
          CheckboxListTile(
            value: medicationTaken,
            onChanged: (v) => setState(() => medicationTaken = v ?? false),
            title: const Text('Medicação autorrelatada conforme rotina'),
          ),
        ],
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(c),
        child: const Text('Cancelar'),
      ),
      FilledButton(
        onPressed: () {
          final h = int.tryParse(sleep.text);
          if (h != null && h >= 0 && h <= 24) {
            Navigator.pop(
              c,
              MoodEntry(
                mood: mood.round(),
                energy: energy.round(),
                sleep: h,
                irritability: irritability.round(),
                impulsivity: impulsivity.round(),
                medicationTaken: medicationTaken,
                missingReason: h == 0 ? 'Não informado' : null,
              ),
            );
          }
        },
        child: const Text('Salvar'),
      ),
    ],
  );
}

class LinkDialog extends StatefulWidget {
  const LinkDialog({super.key});
  @override
  State<LinkDialog> createState() => _LinkDialogState();
}

class _LinkDialogState extends State<LinkDialog> {
  final code = TextEditingController();
  bool accepted = false;
  @override
  Widget build(BuildContext c) => AlertDialog(
    title: const Text('Vincular profissional'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: code,
          decoration: const InputDecoration(labelText: 'Código do convite'),
        ),
        CheckboxListTile(
          value: accepted,
          onChanged: (v) => setState(() => accepted = v ?? false),
          title: const Text('Aceito compartilhar meus registros'),
        ),
      ],
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(c),
        child: const Text('Cancelar'),
      ),
      FilledButton(
        onPressed: accepted && code.text.trim().isNotEmpty
            ? () => Navigator.pop(c, code.text.trim())
            : null,
        child: const Text('Vincular'),
      ),
    ],
  );
}

class TrendBar extends StatelessWidget {
  const TrendBar({
    super.key,
    required this.label,
    required this.value,
    required this.color,
    required this.animate,
  });
  final String label;
  final double value;
  final Color color;
  final bool animate;
  @override
  Widget build(BuildContext c) => Semantics(
    label: '$label: ${(value * 10).round()} de 10',
    value: '${(value * 10).round()} de 10',
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: animate
                ? TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: value),
                    duration: const Duration(milliseconds: 250),
                    builder: (context, v, child) => LinearProgressIndicator(
                      value: v,
                      minHeight: 14,
                      color: color,
                    ),
                  )
                : LinearProgressIndicator(
                    value: value,
                    minHeight: 14,
                    color: color,
                  ),
          ),
        ],
      ),
    ),
  );
}
