//
//  ContentView.swift
//  MyCreateTask
//
//  Created by Steven Xia on 2026-11-06.
//

import SwiftUI
import AppKit

struct ContentView: View {

    // MARK: - Computed properties

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    welcomeHeader

                    LazyVGrid(
                        columns: Array(
                            repeating: GridItem(.flexible(), spacing: 12),
                            count: 3
                        ),
                        spacing: 12
                    ) {
                        NavigationLink {
                            LearningAssistantView()
                        } label: {
                            dashboardCard(
                                title: "Learning Assistant",
                                subtitle: "Math, science & social studies",
                                icon: "graduationcap.fill",
                                backgroundColor: adaptiveColor(
                                    light: NSColor(red: 0.82, green: 0.91, blue: 1.0, alpha: 1),
                                    dark: NSColor(red: 0.12, green: 0.18, blue: 0.29, alpha: 1)
                                ),
                                iconColor: adaptiveColor(
                                    light: NSColor(red: 0.12, green: 0.33, blue: 0.62, alpha: 1),
                                    dark: NSColor(red: 0.42, green: 0.72, blue: 1.0, alpha: 1)
                                )
                            )
                        }
                        .buttonStyle(.plain)
                        .contentShape(Rectangle())

                        NavigationLink {
                            RecessGameGuideView()
                        } label: {
                            dashboardCard(
                                title: "Recess Game Guide",
                                subtitle: "Playground games & rules",
                                icon: "figure.run",
                                backgroundColor: adaptiveColor(
                                    light: NSColor(red: 1.0, green: 0.87, blue: 0.92, alpha: 1),
                                    dark: NSColor(red: 0.28, green: 0.13, blue: 0.22, alpha: 1)
                                ),
                                iconColor: adaptiveColor(
                                    light: NSColor(red: 0.72, green: 0.18, blue: 0.38, alpha: 1),
                                    dark: NSColor(red: 1.0, green: 0.55, blue: 0.70, alpha: 1)
                                )
                            )
                        }
                        .buttonStyle(.plain)
                        .contentShape(Rectangle())

                        NavigationLink {
                            DailyChecklistView()
                        } label: {
                            dashboardCard(
                                title: "Daily Checklist",
                                subtitle: "Tasks & reminders",
                                icon: "checkmark.circle.fill",
                                backgroundColor: adaptiveColor(
                                    light: NSColor(red: 0.84, green: 0.95, blue: 0.88, alpha: 1),
                                    dark: NSColor(red: 0.10, green: 0.25, blue: 0.21, alpha: 1)
                                ),
                                iconColor: adaptiveColor(
                                    light: NSColor(red: 0.12, green: 0.48, blue: 0.29, alpha: 1),
                                    dark: NSColor(red: 0.45, green: 0.92, blue: 0.66, alpha: 1)
                                )
                            )
                        }
                        .buttonStyle(.plain)
                        .contentShape(Rectangle())

                        NavigationLink {
                            DanceGamesView()
                        } label: {
                            dashboardCard(
                                title: "Dance Games",
                                subtitle: "Movement & rhythm",
                                icon: "music.note",
                                backgroundColor: adaptiveColor(
                                    light: NSColor(red: 0.91, green: 0.86, blue: 1.0, alpha: 1),
                                    dark: NSColor(red: 0.23, green: 0.16, blue: 0.34, alpha: 1)
                                ),
                                iconColor: adaptiveColor(
                                    light: NSColor(red: 0.40, green: 0.22, blue: 0.70, alpha: 1),
                                    dark: NSColor(red: 0.76, green: 0.58, blue: 1.0, alpha: 1)
                                )
                            )
                        }
                        .buttonStyle(.plain)
                        .contentShape(Rectangle())

                        NavigationLink {
                            ReadingHelperView()
                        } label: {
                            dashboardCard(
                                title: "Reading Helper",
                                subtitle: "Vocabulary & passages",
                                icon: "book.pages.fill",
                                backgroundColor: adaptiveColor(
                                    light: NSColor(red: 1.0, green: 0.92, blue: 0.79, alpha: 1),
                                    dark: NSColor(red: 0.30, green: 0.23, blue: 0.12, alpha: 1)
                                ),
                                iconColor: adaptiveColor(
                                    light: NSColor(red: 0.72, green: 0.34, blue: 0.08, alpha: 1),
                                    dark: NSColor(red: 1.0, green: 0.76, blue: 0.38, alpha: 1)
                                )
                            )
                        }
                        .buttonStyle(.plain)
                        .contentShape(Rectangle())
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .padding(.bottom, 16)
            }
            .background(Color(nsColor: .windowBackgroundColor))
            .fontDesign(.rounded)
            .navigationTitle("My Create Task")
        }
    }

    // MARK: - Functions

    private var welcomeHeader: some View {
        HStack(spacing: 12) {
            Image(systemName: "sparkles")
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(.yellow)
                .frame(width: 58, height: 58)
                .background(Color(nsColor: .controlBackgroundColor))
                .clipShape(RoundedRectangle(cornerRadius: 18))

            VStack(alignment: .leading, spacing: 4) {
                Text("My Create Task")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.primary)

                Text("Pick a quest and have fun!")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding(16)
        .background(Color(nsColor: .controlBackgroundColor))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.secondary.opacity(0.18), lineWidth: 1)
        }
    }

    private func dashboardCard(
        title: String,
        subtitle: String,
        icon: String,
        backgroundColor: Color,
        iconColor: Color
    ) -> some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 38, weight: .bold))
                .foregroundStyle(iconColor)
                .frame(height: 48)

            Text(title)
                .font(.system(size: 17, weight: .bold, design: .rounded))
                .foregroundStyle(.primary)
                .multilineTextAlignment(.center)

            Text(subtitle)
                .font(.system(size: 13, weight: .semibold, design: .rounded))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, minHeight: 150)
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .overlay {
            RoundedRectangle(cornerRadius: 24)
                .stroke(.secondary.opacity(0.18), lineWidth: 1)
        }
        .contentShape(RoundedRectangle(cornerRadius: 24))
        .shadow(
            color: .black.opacity(0.08),
            radius: 10,
            y: 6
        )
    }

    private func adaptiveColor(light: NSColor, dark: NSColor) -> Color {
        let dynamicColor = NSColor(name: nil) { appearance in
            let matchedName = appearance.bestMatch(from: [.aqua, .darkAqua])
            return matchedName == .darkAqua ? dark : light
        }
        return Color(nsColor: dynamicColor)
    }
}

#Preview {
    ContentView()
}
