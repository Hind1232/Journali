import SwiftUI

// One screen for both: a new journal (journal is nil) or editing one
struct JournalEditorView: View {
    let journal: Journal?
    let onSave: (String, String) -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var text = ""
    @State private var showDiscardDialog = false

    // Did the user change anything?
    private var hasChanges: Bool {
        title != (journal?.title ?? "") || text != (journal?.text ?? "")
    }

    // Saving needs a title
    private var canSave: Bool {
        !title.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    TextField("Title", text: $title)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text((journal?.date ?? Date()).formatted(date: .numeric, time: .omitted))
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    TextField("Type your Journal...", text: $text, axis: .vertical)
                        .font(.body)
                }
                .padding()
            }
            .scrollDismissesKeyboard(.interactively)
            .toolbar {
                // Close button
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        if hasChanges {
                            showDiscardDialog = true
                        } else {
                            dismiss()
                        }
                    } label: {
                        Label("Close", systemImage: "xmark")
                    }
                }

                // Save button
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        onSave(title, text)
                        dismiss()
                    } label: {
                        Label("Save", systemImage: "checkmark")
                    }
                    .disabled(!canSave)
                }
            }
            .confirmationDialog(
                "Are you sure you want to discard changes on this journal?",
                isPresented: $showDiscardDialog,
                titleVisibility: .visible
            ) {
                Button("Discard Changes", role: .destructive) { dismiss() }
                Button("Keep Editing", role: .cancel) { }
            }
        }
        .interactiveDismissDisabled(hasChanges)
        .onAppear {
            // Fill the fields when editing an existing journal
            title = journal?.title ?? ""
            text = journal?.text ?? ""
        }
    }
}

#Preview("Dark") {
    JournalEditorView(journal: nil) { _, _ in }
        .preferredColorScheme(.dark)
}

#Preview("Light") {
    JournalEditorView(journal: nil) { _, _ in }
        .preferredColorScheme(.light)
}
