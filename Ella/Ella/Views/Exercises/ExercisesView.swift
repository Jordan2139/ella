//
//  ExercisesView.swift
//  Ella
//
//  Created by Jordan Silva on 1/20/26.
//

import SwiftUI
import SwiftData

struct ExercisesView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Exercise.createdAt, order: .reverse) private var exercises: [Exercise]

    @State private var newExerciseName = ""
    @State private var newMuscleGroup = ""

    var body: some View {
        NavigationStack {
            List {
                Section("Add Exercise") {
                    TextField("Exercise name", text: $newExerciseName)
                    TextField("Muscle group (optional)", text: $newMuscleGroup)

                    Button("Add Exercise") {
                        addExercise()
                    }
                    .disabled(newExerciseName.trimmingCharacters(in: .whitespaces).isEmpty)
                }

                Section("Your Exercises") {
                    if exercises.isEmpty {
                        Text("No exercises yet")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(exercises) { exercise in
                            VStack(alignment: .leading) {
                                Text(exercise.name)
                                    .font(.headline)

                                if let group = exercise.muscleGroup {
                                    Text(group)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                        .onDelete(perform: deleteExercise)
                    }
                }
            }
            .navigationTitle("Exercises")
        }
    }

    private func addExercise() {
        let exercise = Exercise(
            name: newExerciseName.trimmingCharacters(in: .whitespaces),
            muscleGroup: newMuscleGroup.isEmpty ? nil : newMuscleGroup
        )

        context.insert(exercise)
        newExerciseName = ""
        newMuscleGroup = ""
    }

    private func deleteExercise(at offsets: IndexSet) {
        for index in offsets {
            context.delete(exercises[index])
        }
    }
}
