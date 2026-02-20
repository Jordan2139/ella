import SwiftUI
import SwiftData

struct ProgramEditorView: View {
    @Bindable var template: WorkoutTemplate
    @State private var showExercisePicker = false
    @State private var showEditWorkout = false
    @State private var exerciseBeingEdited: Exercise?

    var body: some View {
        List {
            // Render each exercise as its own row so it can be moved
            ForEach(template.exercises.indices, id: \.self) { exerciseIndex in
                let templateExercise = template.exercises[exerciseIndex]

                VStack(alignment: .leading, spacing: 8) {
                    // Header with exercise name and pencil icon to edit the exercise
                    HStack {
                        Text(templateExercise.exercise.name)
                            .font(.headline)
                        Spacer()
                        Button {
                            exerciseBeingEdited = templateExercise.exercise
                        } label: {
                            Image(systemName: "pencil")
                                .foregroundStyle(.secondary)
                        }
                    }

                    // Sets editing rows
                    ForEach(templateExercise.sets.indices, id: \.self) { setIndex in
                        let set = templateExercise.sets[setIndex]
                        HStack {
                            Stepper(
                                "Reps: \(set.reps)",
                                value: Binding(
                                    get: { template.exercises[exerciseIndex].sets[setIndex].reps },
                                    set: { template.exercises[exerciseIndex].sets[setIndex].reps = $0 }
                                ),
                                in: 1...30
                            )
                            Spacer()
                            TextField(
                                "0",
                                value: Binding(
                                    get: { template.exercises[exerciseIndex].sets[setIndex].weight ?? 0 },
                                    set: { template.exercises[exerciseIndex].sets[setIndex].weight = $0 }
                                ),
                                format: .number.precision(.fractionLength(1))
                            )
                            .frame(width: 70)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                        }
                    }
                    .onDelete { offsets in
                        template.exercises[exerciseIndex].sets.remove(atOffsets: offsets)
                    }

                    // Button to add a new set for this exercise
                    Button {
                        template.exercises[exerciseIndex].sets.append(
                            TemplateSet(reps: 8, weight: 0)
                        )
                    } label: {
                        Label("Add Set", systemImage: "plus")
                    }
                    .moveDisabled(true)  // prevent dragging this button
                    .deleteDisabled(true)
                }
                .padding(.vertical, 4)
            }
            // Enable reordering of exercises
            .onMove { indices, newOffset in
                template.exercises.move(fromOffsets: indices, toOffset: newOffset)
            }
            .onDelete { offsets in
                template.exercises.remove(atOffsets: offsets)
            }

            // Button to add a new exercise to the program
            Button {
                showExercisePicker = true
            } label: {
                Label("Add Exercise", systemImage: "plus")
            }
        }
        .navigationTitle(template.name)
        // Toolbar with edit mode toggle and rename button
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                EditButton() // toggles reordering
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Rename") {
                    showEditWorkout = true
                }
            }
        }
        // Sheets for adding new exercise, renaming workout, and editing exercise details
        .sheet(isPresented: $showExercisePicker) {
            ExercisePicker { exercise in
                template.exercises.append(TemplateExercise(exercise: exercise))
            }
        }
        .sheet(isPresented: $showEditWorkout) {
            EditWorkoutView(template: template)
        }
        .sheet(item: $exerciseBeingEdited) { exercise in
            EditExerciseView(exercise: exercise)
        }
    }
}
