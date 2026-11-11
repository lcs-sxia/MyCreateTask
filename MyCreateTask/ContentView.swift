//
//  ContentView.swift
//  MyCreateTask
//
//  Created by Steven Xia on 2026-11-06.
//

import SwiftUI

struct ContentView: View {

    // MARK: - Stored properties

    @State private var hoveredCard: String?

    // MARK: - Computed properties

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    welcomeHeader

                    Text("Explore activities")
                        .font(.title2)
                        .bold()

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
                                subtitle: "Rocket Math & Study",
                                icon: "rocket.fill",
                                backgroundColor: Color.blue.opacity(0.16),
                                iconColor: .blue
                            )
                        }

                        NavigationLink {
                            RecessGameGuideView()
                        } label: {
                            dashboardCard(
                                title: "Recess Game Guide",
                                subtitle: "Playground Games & Rules",
                                icon: "figure.run",
                                backgroundColor: Color.pink.opacity(0.16),
                                iconColor: .pink
                            )
                        }

                        NavigationLink {
                            DailyChecklistView()
                        } label: {
                            dashboardCard(
                                title: "Daily Checklist",
                                subtitle: "Tasks & Reminders",
                                icon: "checkmark.square.fill",
                                backgroundColor: Color.teal.opacity(0.16),
                                iconColor: .teal
                            )
                        }

                        NavigationLink {
                            DanceGamesView()
                        } label: {
                            dashboardCard(
                                title: "Dance Games",
                                subtitle: "Movement & Fun",
                                icon: "figure.social.dance",
                                backgroundColor: Color.purple.opacity(0.16),
                                iconColor: .purple
                            )
                        }

                        NavigationLink {
                            ReadingHelperView()
                        } label: {
                            dashboardCard(
                                title: "Reading Helper",
                                subtitle: "Stories & Vocabulary",
                                icon: "book.fill",
                                backgroundColor: Color.orange.opacity(0.16),
                                iconColor: .orange
                            )
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("My Create Task")
        }
    }

    // MARK: - Functions

    private var welcomeHeader: some View {
        HStack(spacing: 16) {
            Image(systemName: "sparkles")
                .font(.system(size: 36, weight: .bold))
                .foregroundStyle(.white)
                .frame(width: 72, height: 72)
                .background(
                    LinearGradient(
                        colors: [.orange, .pink],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 18))

            VStack(alignment: .leading, spacing: 4) {
                Text("My Create Task")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.primary)

                Text("Choose an activity to explore")
                    .font(.title3)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding(24)
        .background(
            LinearGradient(
                colors: [
                    Color.orange.opacity(0.18),
                    Color.pink.opacity(0.14)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }

    private func dashboardCard(
        title: String,
        subtitle: String,
        icon: String,
        backgroundColor: Color,
        iconColor: Color
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: icon)
                .font(.title)
                .foregroundStyle(iconColor)
                .frame(width: 48, height: 48)
                .background(iconColor.opacity(0.14))
                .clipShape(Circle())

            Text(title)
                .font(.headline)
                .bold()
                .foregroundStyle(.primary)
                .multilineTextAlignment(.leading)

            Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity, minHeight: 150, alignment: .leading)
        .padding(20)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay {
            Image(systemName: icon)
                .font(.system(size: 112, weight: .bold))
                .foregroundStyle(iconColor.opacity(0.12))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                .padding(.trailing, 12)
                .clipped()

            RoundedRectangle(cornerRadius: 20)
                .stroke(.white.opacity(0.7), lineWidth: 1)
        }
        .contentShape(RoundedRectangle(cornerRadius: 20))
        .scaleEffect(hoveredCard == title ? 1.03 : 1.0)
        .shadow(
            color: .black.opacity(hoveredCard == title ? 0.14 : 0.06),
            radius: hoveredCard == title ? 10 : 4,
            y: 3
        )
        .onHover { isHovering in
            hoveredCard = isHovering ? title : nil
        }
        .animation(.easeInOut(duration: 0.15), value: hoveredCard)
    }
}

#Preview {
    ContentView()
}
