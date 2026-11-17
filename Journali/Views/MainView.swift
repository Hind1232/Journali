import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = JournalViewModel()

    @State private var showNewJournal = false
    @State private var journalToEdit: Journal?
    @State private var journalToDelete: Journal?
    @State private var showDeleteAlert = false

    var body: some View {
        NavigationStack {
            Group {
                // No journals: empty state. Otherwise: the list.
                if viewModel.journals.isEmpty {
                    EmptyStateView()
                } else {
                    journalList
                }
            }
            .navigationTitle("Journal")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    // Sort menu
                    Menu {
                        Button("Sort by Bookmark") { viewModel.sortByBookmark = true }
                        Button("Sort by Entry Date") { viewModel.sortByBookmark = false }
                    } label: {
                        Label("Sort", systemImage: "line.3.horizontal.decrease")
                    }

                    // Add button
                    Button {
                        showNewJournal = true
                    } label: {
                        Label("Add", systemImage: "plus")
                    }
                }
            }
            .searchable(text: $viewModel.searchText)
            // New journal screen
            .sheet(isPresented: $showNewJournal) {
                JournalEditorView(journal: nil) { title, text in
                    viewModel.add(title: title, text: text)
                }
            }
            // Edit journal screen
            .sheet(item: $journalToEdit) { journal in
                JournalEditorView(journal: journal) { title, text in
                    viewModel.update(journal, title: title, text: text)
                }
            }
            // Delete confirmation
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

    // The list of cards
    private var journalList: some View {
        List {
            ForEach(viewModel.displayedJournals) { journal in
                Section {
                    JournalCard(journal: journal) {
                        viewModel.toggleBookmark(journal)
                    }
                    .contentShape(Rectangle())            // the whole card is tappable
                    .onTapGesture { journalToEdit = journal }
                    .swipeActions(edge: .leading) {       // swipe right to delete
                        Button(role: .destructive) {
                            journalToDelete = journal
                            showDeleteAlert = true
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                    }
                }
            }
        }
    }
}

#Preview("Dark") {
    MainView().preferredColorScheme(.dark)
}

#Preview("Light") {
    MainView().preferredColorScheme(.light)
}
