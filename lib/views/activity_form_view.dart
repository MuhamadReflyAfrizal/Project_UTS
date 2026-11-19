import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/activity_viewmodel.dart';

class ActivityFormView extends StatefulWidget {
  final String? activityId;
  const ActivityFormView({Key? key, this.activityId}) : super(key: key);

  @override
  State<ActivityFormView> createState() => _ActivityFormViewState();
}

class _ActivityFormViewState extends State<ActivityFormView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.activityId != null) {
      final vm = context.read<ActivityViewModel>();
      final activity = vm.getById(widget.activityId!);
      if (activity != null) {
        _nameController.text = activity.name;
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState?.validate() ?? false) {
      final name = _nameController.text.trim();
      final vm = context.read<ActivityViewModel>();
      if (widget.activityId == null) {
        vm.addActivity(name);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Aktivitas berhasil ditambahkan')),
        );
      } else {
        vm.updateName(widget.activityId!, name);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Aktivitas berhasil diperbarui')),
        );
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.activityId != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Aktivitas' : 'Tambah Aktivitas')),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Aktivitas',
                  prefixIcon: Icon(Icons.edit),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _save,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
