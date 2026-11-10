import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = JournalViewModel()

    @State private var showNewJournal = false
    @State private var journalToEdit: Journal?
    @State private var journalToDelete: Journal?
    @State private var showDeleteAlert = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                if viewModel.journals.isEmpty {
                    EmptyStateView()
                } else {
                    journalList
                }
            }
            .navigationTitle("Journal")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    // قائمة الترتيب
                    Menu {
                        Button("Sort by Bookmark") { viewModel.sortByBookmark = true }
                        Button("Sort by Entry Date") { viewModel.sortByBookmark = false }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                    }

                    // زر الإضافة
                    Button {
                        showNewJournal = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .searchable(text: $viewModel.searchText)
            // شاشة يومية جديدة
            .sheet(isPresented: $showNewJournal) {
                JournalEditorView(journal: nil) { title, text in
                    viewModel.add(title: title, text: text)
                }
            }
            // شاشة تعديل يومية
            .sheet(item: $journalToEdit) { journal in
                JournalEditorView(journal: journal) { title, text in
                    viewModel.update(journal, title: title, text: text)
                }
            }
            // تنبيه الحذف
            .alert("Delete Journal?", isPresented: $showDeleteAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Delete", role: .destructive) {
                    if let journal = journalToDelete {
                        withAnimation { viewModel.delete(journal) }
                    }
                }
            } message: {
                Text("Are you sure you want to delete this journal?")
            }
        }
    }

    private var journalList: some View {
        List {
            ForEach(viewModel.displayedJournals) { journal in
                JournalCard(journal: journal) {
                    viewModel.toggleBookmark(journal)
                }
                .onTapGesture { journalToEdit = journal }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                // السحب لليمين للحذف
                .swipeActions(edge: .leading, allowsFullSwipe: false) {
                    Button {
                        journalToDelete = journal
                        showDeleteAlert = true
                    } label: {
                        Image(systemName: "trash.fill")
                    }
                    .tint(Color.destructive)
                }
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    MainView()
        .preferredColorScheme(.dark)
}
