import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {

            StartWorkoutView()
                .tabItem {
                    Label("Workout", systemImage: "play.circle")
                }

            ProgramListView()
                .tabItem {
                    Label("Programs", systemImage: "list.bullet.rectangle")
                }

            Text("History coming soon")
                .tabItem {
                    Label("History", systemImage: "clock.arrow.circlepath")
                }

            Text("Body metrics coming soon")
                .tabItem {
                    Label("Body", systemImage: "figure")
                }
        }
    }
}
