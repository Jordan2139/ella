//
//  Models.swift
//  Ella
//
//  Created by Jordan Silva on 1/20/26.
//

import Foundation
import SwiftData

@Model
final class Exercise {
    var name: String
    var muscleGroup: String?
    var createdAt: Date

    init(name: String, muscleGroup: String? = nil) {
        self.name = name
        self.muscleGroup = muscleGroup
        self.createdAt = .now
    }
}

@Model
final class WorkoutSession {
    var date: Date
    var postWorkoutReflection: String?

    @Relationship(deleteRule: .cascade)
    var entries: [WorkoutEntry] = []

    init(date: Date = .now) {
        self.date = date
    }
    init(from template: WorkoutTemplate) {
        self.date = .now
        self.postWorkoutReflection = nil

        self.entries = template.exercises.map { templateExercise in
            let entry = WorkoutEntry(
                exercise: templateExercise.exercise
            )

            entry.sets = templateExercise.sets.map {
                LiftSet(
                    weight: $0.weight ?? 0,
                    reps: $0.reps ?? 0
                )
            }
            return entry
        }
    }
}

@Model
final class WorkoutEntry {
    var exercise: Exercise
    var wasModified: Bool
    var modificationReason: String?

    @Relationship(deleteRule: .cascade)
    var sets: [LiftSet] = []

    init(
        exercise: Exercise,
        wasModified: Bool = false,
        modificationReason: String? = nil
    ) {
        self.exercise = exercise
        self.wasModified = wasModified
        self.modificationReason = modificationReason
    }
}

@Model
final class LiftSet {
    var weight: Double
    var reps: Int
    var isWarmup: Bool
    var isCompleted: Bool
    var note: String?
    var createdAt: Date

    init(weight: Double, reps: Int) {
        self.weight = weight
        self.reps = reps
        self.isWarmup = false
        self.isCompleted = false
        self.createdAt = .now
    }
}
