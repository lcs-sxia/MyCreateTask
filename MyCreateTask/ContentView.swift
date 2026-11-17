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
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    welcomeHeader

                    Text("Explore activities")
                        .font(.title2.weight(.bold))

                    LazyVGrid(
                        columns: Array(
                            repeating: GridItem(.flexible(), spacing: 16),
                            count: 3
                        ),
                        spacing: 16
                    ) {
                        NavigationLink {
                            LearningAssistantView()
                        } label: {
                            dashboardCard(
                                title: "Learning Assistant",
                                subtitle: "Blast off and learn!",
                                icon: "book.fill",
                                backgroundColor: Color(red: 0.82, green: 0.91, blue: 1.0),
                                iconColor: Color(red: 0.12, green: 0.33, blue: 0.62)
                            )
                        }
                        .buttonStyle(.plain)
                        .contentShape(Rectangle())

                        NavigationLink {
                            RecessGameGuideView()
                        } label: {
                            dashboardCard(
                                title: "Recess Game Guide",
                                subtitle: "Let’s get moving!",
                                icon: "figure.run",
                                backgroundColor: Color(red: 1.0, green: 0.87, blue: 0.92),
                                iconColor: Color(red: 0.72, green: 0.18, blue: 0.38)
                            )
                        }
                        .buttonStyle(.plain)
                        .contentShape(Rectangle())

                        NavigationLink {
                            DailyChecklistView()
                        } label: {
                            dashboardCard(
                                title: "Daily Checklist",
                                subtitle: "Power up your day!",
                                icon: "checkmark.square.fill",
                                backgroundColor: Color(red: 0.84, green: 0.95, blue: 0.88),
                                iconColor: Color(red: 0.12, green: 0.48, blue: 0.29)
                            )
                        }
                        .buttonStyle(.plain)
                        .contentShape(Rectangle())

                        NavigationLink {
                            DanceGamesView()
                        } label: {
                            dashboardCard(
                                title: "Dance Games",
                                subtitle: "Dance like a star!",
                                icon: "music.note",
                                backgroundColor: Color(red: 0.91, green: 0.86, blue: 1.0),
                                iconColor: Color(red: 0.40, green: 0.22, blue: 0.70)
                            )
                        }
                        .buttonStyle(.plain)
                        .contentShape(Rectangle())

                        NavigationLink {
                            ReadingHelperView()
                        } label: {
                            dashboardCard(
                                title: "Reading Helper",
                                subtitle: "Jump into a story!",
                                icon: "book.fill",
                                backgroundColor: Color(red: 1.0, green: 0.92, blue: 0.79),
                                iconColor: Color(red: 0.72, green: 0.34, blue: 0.08)
                            )
                        }
                        .buttonStyle(.plain)
                        .contentShape(Rectangle())
                    }
                }
                .padding()
            }
            .background(Color.white)
            .fontDesign(.rounded)
            .navigationTitle("My Create Task")
        }
    }

    // MARK: - Functions

    private var welcomeHeader: some View {
        HStack(spacing: 16) {
            Image(systemName: "sparkles")
                .font(.system(size: 40, weight: .bold))
                .foregroundStyle(Color(red: 0.20, green: 0.42, blue: 0.70))
                .frame(width: 82, height: 82)
                .background(Color(red: 0.85, green: 0.93, blue: 1.0))
                .clipShape(RoundedRectangle(cornerRadius: 24))

            VStack(alignment: .leading, spacing: 4) {
                Text("My Create Task")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundStyle(Color(red: 0.18, green: 0.30, blue: 0.52))

                Text("Pick a quest and have fun!")
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(Color(red: 0.35, green: 0.42, blue: 0.55))
            }

            Spacer()
        }
        .padding(24)
        .background(Color(red: 0.95, green: 0.97, blue: 1.0))
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .overlay {
            RoundedRectangle(cornerRadius: 28)
                .stroke(Color(red: 0.78, green: 0.87, blue: 0.98), lineWidth: 2)
        }
    }

    private func dashboardCard(
        title: String,
        subtitle: String,
        icon: String,
        backgroundColor: Color,
        iconColor: Color
    ) -> some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 64, weight: .bold))
                .foregroundStyle(iconColor)
                .frame(height: 76)

            Text(title)
                .font(.system(size: 17, weight: .bold, design: .rounded))
                .foregroundStyle(Color(red: 0.16, green: 0.20, blue: 0.28))
                .multilineTextAlignment(.center)

            Text(subtitle)
                .font(.system(size: 13, weight: .semibold, design: .rounded))
                .foregroundStyle(Color(red: 0.28, green: 0.32, blue: 0.40))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, minHeight: 220)
        .padding(.horizontal, 22)
        .padding(.vertical, 24)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .overlay {
            RoundedRectangle(cornerRadius: 24)
                .stroke(.white.opacity(0.9), lineWidth: 2)
        }
        .contentShape(RoundedRectangle(cornerRadius: 24))
        .shadow(
            color: .black.opacity(0.08),
            radius: 10,
            y: 6
        )
    }
}

#Preview {
    ContentView()
}
