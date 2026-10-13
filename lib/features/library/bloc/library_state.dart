part of 'library_cubit.dart';

class LibraryState extends Equatable {
  final List<BookmarkModel> bookmarks;
  final List<Map<String, String>> readingHistory;
  final LibraryTab currentTab;

  const LibraryState({
    this.bookmarks = const [],
    this.readingHistory = const [],
    this.currentTab = LibraryTab.bookmarks,
  });

  LibraryState copyWith({
    List<BookmarkModel>? bookmarks,
    List<Map<String, String>>? readingHistory,
    LibraryTab? currentTab,
  }) => LibraryState(
    bookmarks: bookmarks ?? this.bookmarks,
    readingHistory: readingHistory ?? this.readingHistory,
    currentTab: currentTab ?? this.currentTab,
  );

  @override
  List<Object?> get props => [bookmarks, readingHistory, currentTab];
}
