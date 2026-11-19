import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/activity_viewmodel.dart';


class ActivityDetailView extends StatelessWidget {
  final String activityId;
  const ActivityDetailView({Key? key, required this.activityId}) : super(key: key);

  void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<bool?> _confirmAction(BuildContext context, String title, String content, VoidCallback onConfirm) async {
    return await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Batal')),
          TextButton(onPressed: () => Navigator.pop(c, true), child: const Text('OK')),
        ],
      ),
    ).then((value) {
      if (value == true) onConfirm();
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ActivityViewModel>();
    final activity = vm.getById(activityId);
    if (activity == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detail Aktivitas')),
        body: const Center(child: Text('Aktivitas tidak ditemukan')),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(activity.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Counter: ${activity.counter}', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    vm.incrementCounter(activity.id);
                    _showSnack(context, 'Counter meningkat');
                  },
                  child: const Text('+'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    vm.decrementCounter(activity.id);
                    _showSnack(context, 'Counter berkurang');
                  },
                  child: const Text('-'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            OutlinedButton(
              onPressed: () {
                _confirmAction(context, 'Reset Counter', 'Apakah Anda yakin ingin mereset counter?', () {
                  vm.resetCounter(activity.id);
                  _showSnack(context, 'Counter direset');
                });
              },
              child: const Text('Reset'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                _confirmAction(context, 'Delete Activity', 'Apakah Anda yakin ingin menghapus aktivitas ini?', () {
                  vm.deleteActivity(activity.id);
                  _showSnack(context, 'Aktivitas dihapus');
                  Navigator.of(context).pop();
                });
              },
              child: const Text('Hapus'),
            ),
          ],
        ),
      ),
    );
  }
}
