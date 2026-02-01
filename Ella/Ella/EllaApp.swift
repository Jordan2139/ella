import SwiftUI
import SwiftData

@main
struct EllaApp: App {
    var body: some Scene {
        WindowGroup {
            RootTabView()
        }
        .modelContainer(for: [
            WorkoutTemplate.self,
            TemplateExercise.self,
            TemplateSet.self,
            WorkoutSession.self,
            WorkoutEntry.self,
            LiftSet.self,
            Exercise.self
        ])
    }
}
