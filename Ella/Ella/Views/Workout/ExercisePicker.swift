import SwiftUI
import SwiftData

struct ExercisePicker: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    @Query(sort: \Exercise.name)
    private var exercises: [Exercise]

    @State private var showNewExercise = false

    let onSelect: (Exercise) -> Void

    var body: some View {
        NavigationStack {
            List {
                // Existing exercises
                ForEach(exercises) { exercise in
                    Button {
                        onSelect(exercise)
                        dismiss()
                    } label: {
                        Text(exercise.name)
                    }
                }

                // Create new exercise
                Button {
                    showNewExercise = true
                } label: {
                    Label("Create New Exercise", systemImage: "plus")
                        .foregroundStyle(.blue)
                }
            }
            .navigationTitle("Add Exercise")
            .sheet(isPresented: $showNewExercise) {
                NewExerciseView()
                    .modelContext(context) // 🔑 critical
            }
        }
    }
}
