import SwiftUI
import SwiftData

struct WorkoutPlayerView: View {
    @Environment(\.modelContext) private var context

    @State private var session: WorkoutSession

    init(session: WorkoutSession) {
        _session = State(initialValue: session)
    }
    @State private var showExercisePicker = false

    var body: some View {
        NavigationStack {
            List {
                if session.entries.isEmpty {
                    Text("No exercises yet")
                        .foregroundStyle(.secondary)
                }

                // MARK: - Exercises (NOW draggable)
                ForEach(session.entries) { entry in
                    exerciseBlock(for: entry)
                }
                .onMove { indices, newOffset in
                    session.entries.move(fromOffsets: indices, toOffset: newOffset)
                }
                .onDelete { offsets in
                    session.entries.remove(atOffsets: offsets)
                }
            }
            .navigationTitle("Workout")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Add Exercise") {
                        showExercisePicker = true
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Finish") {
                        finishWorkout()
                    }
                    .disabled(session.entries.isEmpty)
                }
            }
            .sheet(isPresented: $showExercisePicker) {
                ExercisePicker { exercise in
                    addExercise(exercise)
                }
            }
        }
    }

    // MARK: - Exercise Block (custom section)

    private func exerciseBlock(for entry: WorkoutEntry) -> some View {
        VStack(alignment: .leading, spacing: 8) {

            // HEADER
            HStack {
                Text(entry.exercise.name)
                    .font(.headline)

                if entry.sets.contains(where: { $0.isCompleted }) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                        .font(.caption)
                }

                Spacer()

                Image(systemName: "line.3.horizontal")
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, 4)

            // SETS
            ForEach(entry.sets) { set in
                if let setBinding = binding(for: set, in: entry) {
                    SetRow(set: setBinding)
                }
            }
            .onMove { indices, newOffset in
                entry.sets.move(fromOffsets: indices, toOffset: newOffset)
            }
            .onDelete { offsets in
                entry.sets.remove(atOffsets: offsets)
            }

            // ADD SET (protected)
            Button("Add Set") {
                entry.sets.append(LiftSet(weight: 0, reps: 5))
            }
            .buttonStyle(.borderless)
            .moveDisabled(true)
            .deleteDisabled(true)
        }
        .padding(.vertical, 8)
    }

    // MARK: - SwiftData Binding Helper

    private func binding(
        for set: LiftSet,
        in entry: WorkoutEntry
    ) -> Binding<LiftSet>? {
        guard let index = entry.sets.firstIndex(where: { $0.id == set.id }) else {
            return nil
        }

        return Binding(
            get: { entry.sets[index] },
            set: { entry.sets[index] = $0 }
        )
    }

    // MARK: - Actions

    private func addExercise(_ exercise: Exercise) {
        let entry = WorkoutEntry(exercise: exercise)
        entry.sets.append(LiftSet(weight: 0, reps: 5))
        session.entries.append(entry)
    }

    private func finishWorkout() {
        context.insert(session)
    }
}
