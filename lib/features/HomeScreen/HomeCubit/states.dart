
abstract class NotesState {}

class NotesInitial extends NotesState {}

class NotesLoading extends NotesState {}

class NotesLoaded extends NotesState {
  final List<String> notes;

  NotesLoaded(this.notes);
}

class NotesError extends NotesState {
  final String error;

  NotesError(this.error);
}
