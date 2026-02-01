import SwiftUI
import SwiftData

struct ProgramEditorView: View {
    @Bindable var template: WorkoutTemplate
    @State private var showExercisePicker = false
    @State private var showEditWorkout = false

    var body: some View {
        List {

            // MARK: - Exercises
            ForEach($template.exercises) { $templateExercise in
                Section(templateExercise.exercise.name) {

                    // MARK: - Sets
                    ForEach($templateExercise.sets) { $set in
                        HStack {
                            Stepper(
                                "Reps: \(set.reps)",
                                value: $set.reps,
                                in: 1...30
                            )

                            Spacer()

                            TextField(
                                "0",
                                value: $set.weight,
                                format: .number.precision(.fractionLength(1))
                            )
                            .frame(width: 70)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                        }
                    }
                    .onDelete { offsets in
                        templateExercise.sets.remove(atOffsets: offsets)
                    }

                    // MARK: - Add Set
                    Button {
                        templateExercise.sets.append(
                            TemplateSet(reps: 8, weight: 0)
                        )
                    } label: {
                        Label("Add Set", systemImage: "plus")
                    }
                }
            }

            // MARK: - Add Exercise
            Button {
                showExercisePicker = true
            } label: {
                Label("Add Exercise", systemImage: "plus")
            }
        }
        .navigationTitle(template.name)
        .sheet(isPresented: $showExercisePicker) {
            ExercisePicker { exercise in
                template.exercises.append(
                    TemplateExercise(exercise: exercise)
                )
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Edit") {
                    showExercisePicker = false
                    showEditWorkout = true
                }
            }
        }
        .sheet(isPresented: $showEditWorkout) {
            EditWorkoutView(template: template)
        }
    }
}
