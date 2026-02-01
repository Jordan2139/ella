//
//  WorkoutTemplate.swift
//  Ella
//
//  Created by Jordan Silva on 1/20/26.
//


import SwiftData
import Foundation
import SwiftData

@Model
final class WorkoutTemplate {
    var name: String
    var createdAt: Date

    @Relationship(deleteRule: .cascade)
    var exercises: [TemplateExercise] = []

    init(name: String) {
        self.name = name
        self.createdAt = .now
    }
}

@Model
final class TemplateExercise {
    var exercise: Exercise

    @Relationship(deleteRule: .cascade)
    var sets: [TemplateSet] = []

    init(exercise: Exercise) {
        self.exercise = exercise
    }
}

@Model
final class TemplateSet {
    var reps: Int
    var weight: Double?

    init(reps: Int, weight: Double? = nil) {
        self.reps = reps
        self.weight = weight
    }
}
