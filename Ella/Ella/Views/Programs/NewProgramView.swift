import SwiftUI
import SwiftData

struct NewProgramView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("Program Name", text: $name)
            }
            .navigationTitle("New Program")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Create") {
                        let program = WorkoutTemplate(name: name)
                        context.insert(program)
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
}
