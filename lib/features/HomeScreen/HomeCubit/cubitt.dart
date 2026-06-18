
import 'package:flutter_bloc/flutter_bloc.dart';
import 'states.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());

  List<String> notes = [];

  void getNotes() {
    emit(NotesLoading());
    emit(NotesLoaded(List.from(notes)));
  }

  void addNote(String note) {
    notes.add(note);
    emit(NotesLoaded(List.from(notes)));
  }

  void deleteNote(int index) {
    notes.removeAt(index);
    emit(NotesLoaded(List.from(notes)));
  }

  void editNote(int index, String newNote) {
    notes[index] = newNote;
    emit(NotesLoaded(List.from(notes)));
  }
}
