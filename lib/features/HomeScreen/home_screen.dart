
import 'package:dismissible_project/features/HomeScreen/HomeCubit/cubitt.dart';
import 'package:dismissible_project/features/HomeScreen/HomeCubit/states.dart';
import 'package:dismissible_project/features/AddNote/add_note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  final TextEditingController _addController = TextEditingController();

  @override
  void dispose() {
    _addController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotesCubit>().getNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: BlocBuilder<NotesCubit, NotesState>(
        builder: (context, state) {
          if (state is NotesLoading)
            return const Center(child: CircularProgressIndicator());

          if (state is NotesLoaded) {
            final notes = state.notes;

            return Column(
              children: [
                // قائمة المهام
                Expanded(
                  child: notes.isEmpty
                      ? const Center(child: Text("No added Tasks Yet 📝"))
                      : ListView.builder(
                          padding: EdgeInsets.all(width * 0.04),
                          itemCount: notes.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: UniqueKey(),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: width * 0.02,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.05,
                                ),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                              onDismissed: (_) =>
                                  context.read<NotesCubit>().deleteNote(index),
                            
                              child: InkWell(
                                onTap: () => _showEditDialog(
                                  context,
                                  index,
                                  notes[index],
                                ),
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: width * 0.015,
                                  ),
                                  padding: EdgeInsets.all(width * 0.04),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF5F5F5),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          notes[index],
                                          style: TextStyle(
                                            fontSize: width * 0.04,
                                          ),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.edit,
                                        size: 20,
                                        color: Colors.blue,
                                      ),
                                      const SizedBox(width: 10),
                                      const Icon(
                                        Icons.delete,
                                        size: 20,
                                        color: Colors.black54,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
            
                Padding(
                  padding: EdgeInsets.all(width * 0.04),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _addController,
                          decoration: const InputDecoration(
                            hintText: "Write a task...",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (_addController.text.isNotEmpty) {
                            context.read<NotesCubit>().addNote(
                              _addController.text,
                            );
                            _addController.clear();
                          }
                        },
                        child: const Text("Add"),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return const Center(child: Text("Something went wrong"));
        },
      ),
    );
  }

  void _showEditDialog(BuildContext context, int index, String currentText) {
    TextEditingController editController = TextEditingController(
      text: currentText,
    );
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Task"),
        content: TextField(controller: editController, autofocus: true),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<NotesCubit>().editNote(index, editController.text);
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
