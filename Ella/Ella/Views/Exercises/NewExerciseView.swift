//
//  NewExerciseView.swift
//  Ella
//
//  Created by Jordan Silva on 1/22/26.
//


import SwiftUI
import SwiftData

struct NewExerciseView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var muscleGroup = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("Exercise Name", text: $name)

                TextField("Muscle Group (optional)", text: $muscleGroup)
            }
            .navigationTitle("New Exercise")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Create") {
                        let exercise = Exercise(
                            name: name,
                            muscleGroup: muscleGroup.isEmpty ? nil : muscleGroup
                        )
                        context.insert(exercise)
                        dismiss()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}
