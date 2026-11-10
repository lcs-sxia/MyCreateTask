//
//  ContentView.swift
//  MyCreateTask
//
//  Created by Steven Xia on 2026-11-06.
//

import SwiftUI

struct ContentView: View {

    // MARK: - Computed properties

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("My Create Task")
                    .font(.largeTitle)
                    .bold()

                Text("Choose a section to explore.")
                    .font(.title3)
                    .foregroundStyle(.secondary)

                VStack(spacing: 12) {
                    NavigationLink("Learning Assistant") {
                        LearningAssistantView()
                    }

                    NavigationLink("Recess Game Guide") {
                        RecessGameGuideView()
                    }

                    NavigationLink("Daily Checklist") {
                        DailyChecklistView()
                    }

                    NavigationLink("Dance Games") {
                        DanceGamesView()
                    }

                    NavigationLink("Reading Helper") {
                        ReadingHelperView()
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(40)
        }
    }
}

#Preview {
    ContentView()
}
