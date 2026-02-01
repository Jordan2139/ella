//
//  EditWorkoutView.swift
//  Ella
//
//  Created by Jordan Silva on 1/22/26.
//


import SwiftUI
import SwiftData

struct EditWorkoutView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var template: WorkoutTemplate

    var body: some View {
        NavigationStack {
            Form {
                Section("Workout Info") {
                    TextField("Workout Name", text: $template.name)
                }
            }
            .navigationTitle("Edit Workout")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}
