import SwiftUI

// شاشة وحدة للحالتين: يومية جديدة (journal = nil) أو تعديل
struct JournalEditorView: View {
    let journal: Journal?
    let onSave: (String, String) -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var title: String
    @State private var text: String
    @State private var showDiscardDialog = false

    init(journal: Journal?, onSave: @escaping (String, String) -> Void) {
        self.journal = journal
        self.onSave = onSave
        _title = State(initialValue: journal?.title ?? "")
        _text = State(initialValue: journal?.text ?? "")
    }

    // هل المستخدم غيّر شي؟
    private var hasChanges: Bool {
        title != (journal?.title ?? "") || text != (journal?.text ?? "")
    }

    // ما نسمح بالحفظ بدون عنوان
    private var canSave: Bool {
        !title.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 8) {
                TextField("Title", text: $title)
                    .font(.system(size: 34, weight: .bold))
                    .foregroundStyle(.white)

                Text((journal?.date ?? Date()).formatted(date: .numeric, time: .omitted))
                    .font(.system(size: 14))
                    .foregroundStyle(Color.textSecondary)

                TextEditor(text: $text)
                    .scrollContentBackground(.hidden)
                    .foregroundStyle(.white)
                    .overlay(alignment: .topLeading) {
                        if text.isEmpty {
                            Text("Type your Journal...")
                                .foregroundStyle(Color.textSecondary)
                                .padding(.top, 8)
                                .padding(.leading, 5)
                                .allowsHitTesting(false)
                        }
                    }
            }
            .padding()
            .background(Color.cardSurface.ignoresSafeArea())
            .scrollDismissesKeyboard(.interactively)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        if hasChanges {
                            showDiscardDialog = true
                        } else {
                            dismiss()
                        }
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        onSave(title, text)
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                            .foregroundStyle(Color.accentPrimary)
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
    }
}

#Preview {
    JournalEditorView(journal: nil) { _, _ in }
        .preferredColorScheme(.dark)
}
