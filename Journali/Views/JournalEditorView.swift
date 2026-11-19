import SwiftUI

struct JournalEditorView: View {
    let journal: Journal?
    let onSave: (String, String) -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var text = ""
    @State private var showDiscardDialog = false

    private var hasChanges: Bool {
        title != (journal?.title ?? "") || text != (journal?.text ?? "")
    }

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
            title = journal?.title ?? ""
            text = journal?.text ?? ""
        }
    }
}

#Preview {
    JournalEditorView(journal: nil) { _, _ in }
        .preferredColorScheme(.dark)
}
