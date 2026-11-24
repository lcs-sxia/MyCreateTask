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
                VStack(alignment: .leading, spacing: 16) {
                    welcomeHeader
                    dashboardCardsSection
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .padding(.bottom, 16)
            }
            .background(Color.white)
            .fontDesign(.rounded)
            .navigationTitle("My Create Task")
        }
        .preferredColorScheme(.light)
    }

    // MARK: - Functions

    // This section displays the welcome title and star decoration.
    private var dashboardCardsSection: some View {
        LazyVGrid(
            columns: Array(
                repeating: GridItem(.flexible(), spacing: 12),
                count: 3
            ),
            spacing: 12
        ) {
            dashboardLink(
                destination: LearningAssistantView(),
                title: "Learning Assistant",
                subtitle: "Math, science & social studies",
                icon: "graduationcap.fill",
                backgroundColor: .blue.opacity(0.15),
                iconColor: .blue,
                watermark: "🐼 🦆",
                backgroundGradient: LinearGradient(
                    colors: [Color.pink.opacity(0.15), Color.blue.opacity(0.15)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )

            dashboardLink(
                destination: RecessGameGuideView(),
                title: "Recess Game Guide",
                subtitle: "Playground games & rules",
                icon: "figure.run",
                backgroundColor: .purple.opacity(0.15),
                iconColor: .purple,
                watermark: "🎮 🐶"
            )

            dashboardLink(
                destination: DailyChecklistView(),
                title: "Daily Checklist",
                subtitle: "Tasks & reminders",
                icon: "checkmark.circle.fill",
                backgroundColor: .green.opacity(0.15),
                iconColor: .green,
                watermark: "⚽️ 🌟"
            )

            dashboardLink(
                destination: DanceGamesView(),
                title: "Dance Games",
                subtitle: "Movement & rhythm",
                icon: "music.note",
                backgroundColor: .yellow.opacity(0.20),
                iconColor: .orange,
                watermark: "🎵 🐄"
            )

            dashboardLink(
                destination: ReadingHelperView(),
                title: "Reading Helper",
                subtitle: "Vocabulary & passages",
                icon: "book.pages.fill",
                backgroundColor: .orange.opacity(0.15),
                iconColor: .orange,
                watermark: "🎨"
            )
        }
    }

    private func dashboardLink<Destination: View>(
        destination: Destination,
        title: String,
        subtitle: String,
        icon: String,
        backgroundColor: Color,
        iconColor: Color,
        watermark: String,
        backgroundGradient: LinearGradient? = nil
    ) -> some View {
        NavigationLink {
            destination
        } label: {
            dashboardCard(
                title: title,
                subtitle: subtitle,
                icon: icon,
                backgroundColor: backgroundColor,
                iconColor: iconColor,
                watermark: watermark,
                backgroundGradient: backgroundGradient
            )
        }
        .buttonStyle(.plain)
        .contentShape(Rectangle())
    }

    private var welcomeHeader: some View {
        HStack(alignment: .center, spacing: 8) {
            Text("Ready to Learn & Play?")
                .font(.largeTitle.weight(.bold))
                .foregroundStyle(.primary)

            Text("🌟")
                .font(.title2)
                .rotationEffect(.degrees(-8))
                .offset(y: -2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 4)
    }

    private func dashboardCard(
        title: String,
        subtitle: String,
        icon: String,
        backgroundColor: Color,
        iconColor: Color,
        watermark: String = "",
        backgroundGradient: LinearGradient? = nil
    ) -> some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 38, weight: .bold))
                    .foregroundStyle(iconColor)
                    .frame(height: 48)

                Text(title)
                    .font(.title3.weight(.bold))
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)

                Text(subtitle)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.primary.opacity(0.88))
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity, alignment: .center)

            if !watermark.isEmpty {
                Text(watermark)
                    .font(.system(size: 60))
                    .opacity(0.12)
                    .offset(x: 40, y: 30)
                    .allowsHitTesting(false)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 150)
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background {
            if let backgroundGradient {
                backgroundGradient
            } else {
                backgroundColor
            }
        }
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

}

#Preview {
    ContentView()
}
