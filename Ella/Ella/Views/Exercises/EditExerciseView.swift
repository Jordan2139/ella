import SwiftUI
import SwiftData

struct EditExerciseView: View {
    @Environment(\.dismiss) private var dismiss

    // Pass the exercise in as a variable; we'll edit its properties explicitly
    var exercise: Exercise

    @State private var name: String
    @State private var muscleGroup: String

    init(exercise: Exercise) {
        self.exercise = exercise
        _name = State(initialValue: exercise.name)
        _muscleGroup = State(initialValue: exercise.muscleGroup ?? "")
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Exercise Info") {
                    TextField("Exercise Name", text: $name)
                    TextField("Muscle Group", text: $muscleGroup)
                }
            }
            .navigationTitle("Edit Exercise")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Done") {
                        // Update the exercise when done
                        exercise.name = name.trimmingCharacters(in: .whitespaces)
                        exercise.muscleGroup = muscleGroup.trimmingCharacters(in: .whitespaces).isEmpty
                            ? nil
                            : muscleGroup
                        dismiss()
                    }
                }
            }
        }
    }
}
