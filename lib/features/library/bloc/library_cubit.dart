import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/bookmark_model.dart';
import '../../../data/services/local_storage_service.dart';

part 'library_state.dart';

class LibraryCubit extends Cubit<LibraryState> {
  final LocalStorageService storage;

  LibraryCubit({required this.storage}) : super(const LibraryState());

  void load() {
    final bookmarks = storage.bookmarks;
    final history = storage.readingHistory;
    emit(state.copyWith(bookmarks: bookmarks, readingHistory: history));
  }

  Future<void> addBookmark(BookmarkModel bookmark) async {
    await storage.addBookmark(bookmark);
    load();
  }

  Future<void> removeBookmark(String contentId) async {
    await storage.removeBookmark(contentId);
    load();
  }

  bool isBookmarked(String contentId) => storage.isBookmarked(contentId);

  void setTab(LibraryTab tab) => emit(state.copyWith(currentTab: tab));
}

enum LibraryTab { bookmarks, history }
