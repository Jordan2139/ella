//
//  ProgramListView.swift
//  Ella
//
//  Created by Jordan Silva on 1/20/26.
//


import SwiftUI
import SwiftData

struct ProgramListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \WorkoutTemplate.createdAt) private var templates: [WorkoutTemplate]

    @State private var showNewTemplate = false

    var body: some View {
        NavigationStack {
            List {
                if templates.isEmpty {
                    ContentUnavailableView(
                        "No Programs",
                        systemImage: "calendar",
                        description: Text("Create a workout program to get started.")
                    )
                }

                ForEach(templates) { template in
                    NavigationLink {
                        ProgramEditorView(template: template)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(template.name)
                                .font(.headline)

                            Text("\(template.exercises.count) exercises")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .onDelete { offsets in
                    offsets.map { templates[$0] }.forEach(context.delete)
                }
            }
            .navigationTitle("Programs")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showNewTemplate = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showNewTemplate) {
                NewProgramView()
            }
        }
    }
}
