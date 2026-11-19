import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/activity_viewmodel.dart';
import 'activity_form_view.dart';
import 'activity_detail_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Counter'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(Icons.insights),
          ),
        ],
      ),
      body: Consumer<ActivityViewModel>(
        builder: (context, vm, child) {
          final activities = vm.activities;
          final totalJenis = activities.length;
          final totalCounter = activities.fold<int>(0, (sum, a) => sum + a.counter);
          return ListView(
            padding: const EdgeInsets.all(12.0),
            children: [
              // Summary Header Card
              Card(
                margin: const EdgeInsets.only(bottom: 16.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total Aktivitas: $totalJenis', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Text('Total Counter: $totalCounter', style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ),
              ),
              // Daftar aktivitas
              if (activities.isEmpty)
                const Center(child: Text('Belum ada aktivitas.'))
              else
                ...activities.map((activity) => Card(
                      margin: const EdgeInsets.symmetric(vertical: 6.0),
                      child: ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.indigo.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.check_circle_outline, color: Colors.indigo),
                        ),
                        title: Text(activity.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('Counter saat ini: ${activity.counter}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.indigo.shade200,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text('${activity.counter}', style: const TextStyle(color: Colors.white)),
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit_rounded),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => ActivityFormView(activityId: activity.id)),
                                );
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => ActivityDetailView(activityId: activity.id)),
                          );
                        },
                      ),
                    ))
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Tambah Aktivitas'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ActivityFormView()),
          );
        },
      ),
    );
  }
}
