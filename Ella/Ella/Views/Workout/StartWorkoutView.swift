import SwiftUI
import SwiftData

struct StartWorkoutView: View {
    @Environment(\.modelContext) private var context

    @Query(sort: \WorkoutTemplate.createdAt)
    private var templates: [WorkoutTemplate]

    @State private var activeSession: WorkoutSession?

    var body: some View {
        NavigationStack {
            List {
                if templates.isEmpty {
                    ContentUnavailableView(
                        "No Workouts Yet",
                        systemImage: "dumbbell",
                        description: Text("Create a workout program to get started.")
                    )
                }

                ForEach(templates) { template in
                    Button {
                        startWorkout(from: template)
                    } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(template.name)
                                .font(.headline)

                            Text("\(template.exercises.count) exercises")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Start Workout")
            .navigationDestination(item: $activeSession) { session in
                WorkoutPlayerView(session: session)
            }
        }
    }

    // MARK: - Start Workout

    private func startWorkout(from template: WorkoutTemplate) {
        let session = WorkoutSession(from: template)
        context.insert(session)
        activeSession = session
    }
}
