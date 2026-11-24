// ============================================================
// File: MyCreateTask/ContentView.swift
// ============================================================
//
//  ContentView.swift
//  MyCreateTask
//
//  Created on 2026-11-06.
//  AI Acknowledgment: GitHub Copilot was used to assist with SwiftUI implementation, refactoring, and debugging. All code behavior and outputs were reviewed and verified by the student.
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

// ============================================================
// File: MyCreateTask/MyCreateTaskApp.swift
// ============================================================
//
//  MyCreateTaskApp.swift
//  MyCreateTask
//
//  Created on 2026-11-06.
//  AI Acknowledgment: GitHub Copilot was used to assist with SwiftUI implementation, refactoring, and debugging. All code behavior and outputs were reviewed and verified by the student.
//

import SwiftUI

@main
struct MyCreateTaskApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.dynamicTypeSize, .xLarge)
        }
    }
}

// ============================================================
// File: MyCreateTask/Model/DailyTask.swift
// ============================================================
//
//  DailyTask.swift
//  MyCreateTask
//
//  Created on 2026-11-11.
//  AI Acknowledgment: GitHub Copilot was used to assist with SwiftUI implementation, refactoring, and debugging. All code behavior and outputs were reviewed and verified by the student.
//

import Foundation

struct DailyTask: Identifiable, Hashable {

    // MARK: - Stored properties

    let id: UUID
    let title: String
    var isCompleted: Bool

    // MARK: - Initializer

    init(id: UUID = UUID(), title: String, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
}

extension DailyTask {

    // MARK: - Sample data

    static let sampleTasks: [DailyTask] = [
        DailyTask(title: "Complete Math Worksheet"),
        DailyTask(title: "Read for 20 Minutes"),
        DailyTask(title: "Organize Study Desk"),
        DailyTask(title: "Pack Tomorrow's Backpack")
    ]
}

// ============================================================
// File: MyCreateTask/Model/DanceGame.swift
// ============================================================
//
//  DanceGame.swift
//  MyCreateTask
//
//  Created on 2026-11-11.
//  AI Acknowledgment: GitHub Copilot was used to assist with SwiftUI implementation, refactoring, and debugging. All code behavior and outputs were reviewed and verified by the student.
//

import Foundation

enum DanceGameCategory: String, CaseIterable, Identifiable {
    case rhythm = "Rhythm"
    case freeze = "Freeze"
    case mirror = "Mirror"

    var id: String {
        rawValue
    }
}

enum DanceGameEnergy: String, CaseIterable, Identifiable {
    case low = "Low Energy"
    case medium = "Medium Energy"
    case high = "High Energy"

    var id: String {
        rawValue
    }
}

struct DanceGame: Identifiable, Hashable {

    // MARK: - Stored properties

    let id: UUID
    let name: String
    let description: String
    let duration: Int
    let groupSize: String
    let category: DanceGameCategory
    let energy: DanceGameEnergy
    let steps: [String]
    let classroomTip: String

    // MARK: - Initializer

    init(
        id: UUID = UUID(),
        name: String,
        description: String,
        duration: Int,
        groupSize: String,
        category: DanceGameCategory,
        energy: DanceGameEnergy,
        steps: [String],
        classroomTip: String
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.duration = duration
        self.groupSize = groupSize
        self.category = category
        self.energy = energy
        self.steps = steps
        self.classroomTip = classroomTip
    }
}

extension DanceGame {

    // MARK: - Sample data

    static let sampleGames: [DanceGame] = [
        DanceGame(
            name: "Freeze Dance",
            description: "Freeze Dance combines energetic whole-body movement with careful listening and quick reactions. Players dance freely through the open space, then freeze in place whenever the music stops.",
            duration: 60,
            groupSize: "2 or more players",
            category: .freeze,
            energy: .high,
            steps: [
                "Clear a safe open area and have everyone stand at least one arm's length from the people nearest them.",
                "Choose a DJ to play upbeat music and explain that dancers may move in personal space until the music stops.",
                "Start the round with medium tempo music, encouraging arms, legs, turns, and low or high movement levels.",
                "Pause the music for surprise freezes; anyone who moves can complete three jumping jacks or make a silly pose, then rejoin immediately.",
                "Change the tempo or ask for animal poses on the next round, then switch to a new DJ or student leader."
            ],
            classroomTip: "Start at a moderate tempo and increase it only after students demonstrate safe spacing. If someone misses a freeze, use a quick silly pose re-entry so the whole group stays engaged."
        ),
        DanceGame(
            name: "Rhythm Echo",
            description: "Rhythm Echo lets students turn claps and stomps into a shared musical pattern. Each player listens closely, copies the leader, and contributes a creative beat for the group.",
            duration: 90,
            groupSize: "2 or more players",
            category: .rhythm,
            energy: .medium,
            steps: [
                "Stand or sit in a circle with enough space to clap and step safely without touching a neighbor.",
                "Choose a rhythm leader who creates a short pattern using claps, pats, or quiet stomps.",
                "Repeat the pattern together three times, listening for accuracy while keeping a steady tempo.",
                "Add a new sound or level for the next turn; a student who misses the beat can tap three times or strike a silly pose before echoing again.",
                "Rotate the leader each round so every player gets a chance to invent and lead a rhythm."
            ],
            classroomTip: "Model the rhythm slowly before adding speed, and keep sounds quiet enough for every echo to be heard. Praise careful listening and offer a clapping-only option for anyone who prefers lower movement."
        ),
        DanceGame(
            name: "Mirror Movement",
            description: "Mirror Movement builds balance and teamwork through slow, controlled partner movement. One student leads while the other watches carefully and copies the motion from the opposite side.",
            duration: 120,
            groupSize: "2 players",
            category: .mirror,
            energy: .low,
            steps: [
                "Stand facing a partner with at least arm's-length space and choose one safe personal-movement zone.",
                "Decide who is the leader and begin with slow movements for the head, shoulders, arms, or feet.",
                "The partner mirrors each action as a reflection, matching direction and motion without rushing or touching.",
                "Change direction or level every 20 seconds; if a partner loses sync, they can make one silly mirror pose and rejoin the pattern.",
                "Pause the round, trade leader and follower roles, and repeat with the new leader."
            ],
            classroomTip: "Encourage smooth, small movements that fit the available personal space. Remind partners that accuracy matters more than speed and that role changes are essential for fair participation."
        ),
        DanceGame(
            name: "Pass the Beat",
            description: "Pass the Beat is a cooperative rhythm game that moves a beat around the whole group. Players listen for their turn, copy the pattern, and gradually create a shared musical chain.",
            duration: 90,
            groupSize: "4 or more players",
            category: .rhythm,
            energy: .medium,
            steps: [
                "Arrange players in a circle with an arm's length of space and agree on two quiet signals, such as left and right.",
                "Start a short four-beat pattern and have everyone practice it once together.",
                "Pass the pattern one player at a time around the circle, changing direction when the leader gives the signal.",
                "Add a new sound or tempo variation at each full pass; a player who misses it can make three tap beats or a silly rhythm pose before entering again.",
                "Choose a new first player and leader so everyone gets an opportunity to begin and vary the beat."
            ],
            classroomTip: "Keep the first pattern simple and pass it slowly before introducing changes. Use hands or seated tapping as an alternative if standing and stomping would make the activity unsafe."
        ),
        DanceGame(
            name: "Musical Statues",
            description: "Musical Statues blends energetic movement with quick thinking and creative posing. Students travel safely through the open space, then become balanced statues when the music stops.",
            duration: 60,
            groupSize: "6 or more players",
            category: .freeze,
            energy: .high,
            steps: [
                "Create a clear open area and place players with at least arm's-length space around every statue zone.",
                "Choose a DJ, start the music, and invite students to move with safe walking, sliding, or light dance steps.",
                "When the music stops, everyone holds a strong, balanced pose while staying on the spot.",
                "Restart with a new challenge such as a low animal pose or a high victory pose; anyone who cannot hold still can do three jumping jacks or a silly pose and rejoin.",
                "Increase or reduce the tempo for the final round, then let a new student become DJ."
            ],
            classroomTip: "Keep the music brief and watch the room before starting each round. Offer low, seated, or arm-only poses so every student can participate without needing to jump or travel."
        ),
        DanceGame(
            name: "Shadow Follower",
            description: "Shadow Follower develops coordination and careful observation through gentle partner movement. Each student follows a leader's actions while staying close enough to notice small changes in direction and level.",
            duration: 120,
            groupSize: "2 players",
            category: .mirror,
            energy: .low,
            steps: [
                "Clear a partner area and stand at least arm's length apart with room to move safely in every direction.",
                "Choose the first leader and begin with slow steps, stretches, turns, or changes in arm height.",
                "The follower stays one or two steps behind, matching each movement while keeping personal and partner space.",
                "Vary speed and movement level from low to high; if the follower loses the lead, they can choose a silly shadow pose before reconnecting.",
                "Switch leader roles halfway through and finish by repeating one movement sequence together."
            ],
            classroomTip: "Model a few safe low-speed movements and remind partners to keep a clear shadow gap. Allow walking, seated movement, or seated arm patterns for an inclusive classroom pace."
        ),
        DanceGame(
            name: "Body Percussion Chain",
            description: "Body Percussion Chain builds a growing rhythm by linking claps, stomps, and snaps around a circle. Each player listens carefully, adds one new sound, and helps the whole group remember the pattern.",
            duration: 90,
            groupSize: "3 or more players",
            category: .rhythm,
            energy: .medium,
            steps: [
                "Clear a circle with at least arm's-length spacing and choose whether players will stand or sit.",
                "Start a one-beat clap pattern and let the first student repeat it before adding a second sound.",
                "Pass around the circle, with each student adding a clap, stomp, snap, or pat to the cumulative chain.",
                "Reverse direction or change tempo for a variation; a player who forgets the pattern can do three quiet taps or make a silly rhythm pose before rejoining.",
                "Choose a new starting student and alternate the chain direction for the next round."
            ],
            classroomTip: "Keep the first round short enough for everyone to remember the growing pattern. Let students use seated pats or claps if standing or stomping is uncomfortable."
        ),
        DanceGame(
            name: "Tempo Shifter",
            description: "Tempo Shifter challenges students to match footwork and arm grooves to changing music speeds. The leader guides the group through slow, medium, and double-time movement while everyone stays in personal space.",
            duration: 90,
            groupSize: "2 or more players",
            category: .rhythm,
            energy: .high,
            steps: [
                "Create a clear open area and have every student stand at least one arm's length from nearby dancers.",
                "Choose a leader and begin with a simple four-count groove using feet and relaxed arm movements.",
                "Repeat the groove at slow, medium, and double-time tempos while keeping shoulders and movements controlled.",
                "Let the DJ call a movement variation, such as level changes or backward steps; anyone who loses the beat can complete three taps or a silly groove pose before rejoining.",
                "Change leaders and select a new groove sequence for the next round."
            ],
            classroomTip: "Demonstrate each tempo clearly before the beat changes and leave time for recovery between rounds. Offer arm-only or seated stepping as a safe, energetic alternative."
        ),
        DanceGame(
            name: "Emotion Freeze",
            description: "Emotion Freeze combines expressive slow-motion movement with clear emotion poses. Students move through an open space and freeze into a recognizable feeling whenever the leader gives the signal.",
            duration: 60,
            groupSize: "2 or more players",
            category: .freeze,
            energy: .low,
            steps: [
                "Choose a calm open area and mark enough personal space for everyone to stand or sit arm's length apart.",
                "Display or call a feeling, such confidence, surprise, calm, or excitement, and explain that it will guide the movement.",
                "Move slowly through the space, changing facial expression and upper-body position to communicate the emotion.",
                "Freeze in a clear, balanced emotion pose when the leader stops the music; if someone does not freeze, they can make a silly face or strike a three-second pose before rejoining.",
                "Select a new emotion and leader for the next round, encouraging respectful and positive choices."
            ],
            classroomTip: "Use neutral and positive emotions and remind students that every expression should feel comfortable. Keep cues predictable while allowing seated or facial-expression-only participation."
        ),
        DanceGame(
            name: "Spotlight Pose",
            description: "Spotlight Pose invites dancers to move freely, then hold a balanced solo or team sculpture at the freeze cue. The activity celebrates creative shapes while reinforcing listening and stillness.",
            duration: 90,
            groupSize: "3 or more players",
            category: .freeze,
            energy: .medium,
            steps: [
                "Arrange the group in a safe open space with at least one arm's length around each dancer or sculpture group.",
                "Choose a DJ or leader, start the music, and encourage free movement using safe walking and low-impact steps.",
                "When the DJ calls the cue, hold a balanced solo pose or join nearby partners for a five-second team sculpture.",
                "Change themes for the next round, such as animals or buildings; anyone moving early can hold a silly pose for three seconds and rejoin immediately.",
                "Invite a new DJ and rotate who leads the pose theme and freeze count."
            ],
            classroomTip: "Demonstrate a stable five-second pose before beginning and count slowly for a calm finish. Encourage partners to avoid climbing or lifting and offer a seated sculpture option."
        ),
        DanceGame(
            name: "Copycat Groove",
            description: "Copycat Groove gives partners a fast, energetic way to echo four-count dance moves in real time. A caller introduces simple steps and the follower mirrors every action while maintaining safe spacing.",
            duration: 90,
            groupSize: "2 or more players",
            category: .mirror,
            energy: .high,
            steps: [
                "Pair students and mark open space so partners stand at least arm's length apart in a safe mirror line.",
                "Choose a groove leader who calls a move and demonstrates it on counts four of one sequence.",
                "Partners mirror the moves immediately, matching direction and level while keeping their feet in the safe zone.",
                "Add jumps, turns, or arm variations one at a time; if a partner misses the groove, they can make a three-second silly move and rejoin.",
                "Rotate the caller and switch the leader and follower roles after every four-count sequence."
            ],
            classroomTip: "Use low-impact steps at first and model safe turn direction before adding speed. Provide a seated or upper-body groove so every partner can mirror at an appropriate pace."
        ),
        DanceGame(
            name: "Slow-Motion Reflection",
            description: "Slow-Motion Reflection uses ultra-controlled partner movement to build concentration and balance. One student leads long, smooth actions while the partner mirrors them in a peaceful, deliberate rhythm.",
            duration: 120,
            groupSize: "2 players",
            category: .mirror,
            energy: .low,
            steps: [
                "Stand facing a partner in an open area with at least an arm's length of space and choose a low, medium, or high movement level.",
                "The leader moves one body part at a time, stretching counts from one to four before changing direction.",
                "The partner follows in slow motion, matching speed and shape without rushing or making contact.",
                "Introduce one balance or turning variation each round; anyone who loses balance can hold a stable silly reflection pose and rejoin.",
                "Switch roles halfway through and finish with a matching slow-motion movement performed together."
            ],
            classroomTip: "Keep the environment quiet and remind students that control is more important than depth or flexibility. Provide seated stretches or arm-only reflections for anyone needing extra support."
        )
    ]
}

// ============================================================
// File: MyCreateTask/Model/LearningQuestion.swift
// ============================================================
//
//  LearningQuestion.swift
//  MyCreateTask
//
//  Created on 2026-11-11.
//  AI Acknowledgment: GitHub Copilot was used to assist with SwiftUI implementation, refactoring, and debugging. All code behavior and outputs were reviewed and verified by the student.
//

import Foundation

enum LearningSubject: String, CaseIterable, Identifiable {
    case math = "Math"
    case science = "Science"
    case socialStudies = "Social Studies"
    case english = "English (Grammar)"
    case geography = "Geography"

    var id: String {
        rawValue
    }

    var icon: String {
        switch self {
        case .math:
            "function"
        case .science:
            "atom"
        case .socialStudies:
            "building.columns"
        case .english:
            "pencil.and.outline"
        case .geography:
            "map"
        }
    }
}

struct StudyConcept: Identifiable, Hashable {

    // MARK: - Stored properties

    let id: UUID
    let subject: LearningSubject
    let title: String
    let summary: String

    // MARK: - Initializer

    init(
        id: UUID = UUID(),
        subject: LearningSubject,
        title: String,
        summary: String
    ) {
        self.id = id
        self.subject = subject
        self.title = title
        self.summary = summary
    }
}

extension StudyConcept {

    // MARK: - Sample data

    static let sampleConcepts: [StudyConcept] = [
        StudyConcept(
            subject: .math,
            title: "Area & Perimeter",
            summary: "Area measures space inside a shape; perimeter measures the distance around it."
        ),
        StudyConcept(
            subject: .math,
            title: "Equivalent Fractions",
            summary: "Equivalent fractions name the same amount, even when their numbers look different."
        ),
        StudyConcept(
            subject: .math,
            title: "Multi-Step Word Problems",
            summary: "Read carefully, choose the needed operations, and check each step."
        ),
        StudyConcept(
            subject: .math,
            title: "Decimals & Place Value",
            summary: "Place value helps you compare, read, and calculate with decimals."
        ),
        StudyConcept(
            subject: .math,
            title: "Multiplication & Division Strategies",
            summary: "Use arrays, partial products, friendly numbers, and estimation to solve."
        ),
        StudyConcept(
            subject: .math,
            title: "Data & Bar Graphs",
            summary: "Bar graphs organize data so you can compare amounts and find patterns."
        ),
        StudyConcept(
            subject: .science,
            title: "The Water Cycle",
            summary: "Water moves through evaporation, condensation, precipitation, and collection."
        ),
        StudyConcept(
            subject: .science,
            title: "Forms of Energy",
            summary: "Energy can appear as light, sound, heat, electrical energy, or motion."
        ),
        StudyConcept(
            subject: .science,
            title: "Rocks & Minerals",
            summary: "Rocks are made of minerals, and their properties help us identify them."
        ),
        StudyConcept(
            subject: .science,
            title: "Human Organ Systems",
            summary: "Organ systems work together to help the human body move, grow, and stay healthy."
        ),
        StudyConcept(
            subject: .science,
            title: "Habitats & Food Chains",
            summary: "Habitats provide what organisms need, and food chains show how energy moves."
        ),
        StudyConcept(
            subject: .science,
            title: "Pulleys & Gears",
            summary: "Simple machines can change the direction or amount of force needed for a task."
        ),
        StudyConcept(
            subject: .socialStudies,
            title: "Three Levels of Government in Canada",
            summary: "Federal government works in Ottawa, provincial government works at Queen's Park in Toronto, and municipalities serve local communities."
        ),
        StudyConcept(
            subject: .socialStudies,
            title: "Canada's Physical Regions",
            summary: "Canada includes the Canadian Shield, Great Lakes–St. Lawrence Lowlands, Interior Plains, and other physical regions."
        ),
        StudyConcept(
            subject: .socialStudies,
            title: "Early Societies & First Nations",
            summary: "First Nations, Inuit, and Métis communities have rich systems of governance, trade, and environmental stewardship."
        ),
        StudyConcept(
            subject: .socialStudies,
            title: "Ontario's Capital & Parliament",
            summary: "Toronto is Ontario's capital, and Queen's Park is where the provincial legislature meets."
        ),
        StudyConcept(
            subject: .socialStudies,
            title: "Rights & Responsibilities of Citizenship",
            summary: "Citizens have rights and responsibilities that help communities remain fair and respectful."
        ),
        StudyConcept(
            subject: .socialStudies,
            title: "Fur Trade & Early Canadian History",
            summary: "The fur trade connected Indigenous communities, European newcomers, and growing Canadian settlements."
        ),
        StudyConcept(
            subject: .english,
            title: "Parts of Speech",
            summary: "Nouns name people, places, or things; verbs show action or being; adjectives describe nouns."
        ),
        StudyConcept(
            subject: .english,
            title: "Sentence Types",
            summary: "Declarative sentences make statements, and interrogative sentences ask questions."
        ),
        StudyConcept(
            subject: .english,
            title: "Prefixes & Suffixes",
            summary: "Word parts can change a base word's meaning or grammatical form."
        ),
        StudyConcept(
            subject: .english,
            title: "Subject–Verb Agreement",
            summary: "The verb in a sentence should match whether its subject is singular or plural."
        ),
        StudyConcept(
            subject: .geography,
            title: "Map Features",
            summary: "Maps use symbols, a legend, a scale, and directions to communicate places accurately."
        ),
        StudyConcept(
            subject: .geography,
            title: "Natural Resources",
            summary: "Renewable and non-renewable resources support people and industries in different ways."
        ),
        StudyConcept(
            subject: .geography,
            title: "Human & Natural Systems",
            summary: "Human activities and natural systems interact and can change communities and environments."
        ),
        StudyConcept(
            subject: .geography,
            title: "Canada's Regions",
            summary: "Ontario includes varied natural and human features shaped by land, water, climate, and settlement."
        )
    ]
}

struct LearningQuestion: Identifiable, Hashable {

    // MARK: - Stored properties

    let id: UUID
    let subject: LearningSubject
    let questionText: String
    let options: [String]
    let correctAnswer: String
    let hint: String

    // MARK: - Initializer

    init(
        id: UUID = UUID(),
        subject: LearningSubject,
        questionText: String,
        options: [String],
        correctAnswer: String,
        hint: String
    ) {
        self.id = id
        self.subject = subject
        self.questionText = questionText
        self.options = options
        self.correctAnswer = correctAnswer
        self.hint = hint
    }
}

extension LearningQuestion {

    // MARK: - Sample data

    static let sampleQuestions: [LearningQuestion] = [
        LearningQuestion(
            subject: .math,
            questionText: "A rectangular garden is 12 meters long and 8 meters wide. What is its total perimeter?",
            options: ["20 meters", "32 meters", "40 meters", "96 meters"],
            correctAnswer: "40 meters",
            hint: "Add all four sides, or use 2 × (length + width)."
        ),
        LearningQuestion(
            subject: .math,
            questionText: "A pizza has 8 equal slices. If Mia eats 3 slices, what fraction of the pizza is left?",
            options: ["3/8", "5/8", "1/2", "7/8"],
            correctAnswer: "5/8",
            hint: "Subtract the slices eaten from the total number of slices."
        ),
        LearningQuestion(
            subject: .math,
            questionText: "Sam has $30. He buys a notebook for $12 and markers for $8. How much money is left?",
            options: ["$8", "$10", "$12", "$20"],
            correctAnswer: "$10",
            hint: "Add the two costs first, then subtract that total from $30."
        ),
        LearningQuestion(
            subject: .math,
            questionText: "A recipe needs 3/4 cup of oats. Which fraction is equivalent to 3/4?",
            options: ["2/3", "6/8", "4/6", "3/8"],
            correctAnswer: "6/8",
            hint: "Multiply both the numerator and denominator by the same number."
        ),
        LearningQuestion(
            subject: .math,
            questionText: "A rectangular playground is 9 m long and 5 m wide. What is its area?",
            options: ["14 m²", "28 m²", "45 m²", "90 m²"],
            correctAnswer: "45 m²",
            hint: "Multiply the length by the width to find the area of a rectangle."
        ),
        LearningQuestion(
            subject: .math,
            questionText: "Which decimal is greatest?",
            options: ["0.45", "0.5", "0.405", "0.054"],
            correctAnswer: "0.5",
            hint: "Compare the tenths place first, then look at smaller place values if needed."
        ),
        LearningQuestion(
            subject: .math,
            questionText: "A class collects 128 cans on Monday and 176 cans on Tuesday. They donate 95 cans. How many cans remain?",
            options: ["209", "213", "304", "399"],
            correctAnswer: "209",
            hint: "Add the two collection totals, then subtract the donated cans."
        ),
        LearningQuestion(
            subject: .science,
            questionText: "What process changes liquid water into water vapor?",
            options: ["Evaporation", "Condensation", "Precipitation", "Collection"],
            correctAnswer: "Evaporation",
            hint: "This happens when the Sun warms water on Earth’s surface."
        ),
        LearningQuestion(
            subject: .science,
            questionText: "Which form of energy helps a lamp produce light?",
            options: ["Electrical energy", "Sound energy", "Chemical energy", "Motion energy"],
            correctAnswer: "Electrical energy",
            hint: "Think about the type of energy carried through the lamp’s cord."
        ),
        LearningQuestion(
            subject: .science,
            questionText: "What happens during condensation?",
            options: ["Gas changes to liquid", "Liquid changes to gas", "Water freezes", "Rain collects"],
            correctAnswer: "Gas changes to liquid",
            hint: "Water droplets form when water vapor cools."
        ),
        LearningQuestion(
            subject: .science,
            questionText: "Which action helps conserve energy at home?",
            options: [
                "Leaving lights on",
                "Opening the fridge often",
                "Turning off unused devices",
                "Running water all day"
            ],
            correctAnswer: "Turning off unused devices",
            hint: "Conserving energy means avoiding energy use when it is not needed."
        ),
        LearningQuestion(
            subject: .science,
            questionText: "Which organ system carries oxygen and nutrients around the body?",
            options: [
                "Digestive system",
                "Circulatory system",
                "Skeletal system",
                "Nervous system"
            ],
            correctAnswer: "Circulatory system",
            hint: "The heart and blood vessels are part of this system."
        ),
        LearningQuestion(
            subject: .science,
            questionText: "Which property can help identify a mineral?",
            options: ["Colour only", "Hardness", "Its habitat", "Its life cycle"],
            correctAnswer: "Hardness",
            hint: "Minerals can be compared by how easily they are scratched."
        ),
        LearningQuestion(
            subject: .science,
            questionText: "What is a habitat?",
            options: [
                "A tool for measuring weather",
                "A place where an organism lives",
                "A type of rock",
                "A change from liquid to gas"
            ],
            correctAnswer: "A place where an organism lives",
            hint: "A habitat provides an organism with food, water, shelter, and space."
        ),
        LearningQuestion(
            subject: .science,
            questionText: "Which change is a reversible change?",
            options: [
                "Burning paper",
                "Cooking an egg",
                "Melting ice",
                "Rusting iron"
            ],
            correctAnswer: "Melting ice",
            hint: "A reversible change can be changed back to its original form."
        ),
        LearningQuestion(
            subject: .socialStudies,
            questionText: "Where does Canada's federal government meet?",
            options: ["Ottawa", "Toronto", "Vancouver", "Winnipeg"],
            correctAnswer: "Ottawa",
            hint: "Ottawa is Canada's national capital."
        ),
        LearningQuestion(
            subject: .socialStudies,
            questionText: "Where does Ontario's provincial government meet?",
            options: ["Queen's Park in Toronto", "Parliament Hill in Ottawa", "City Hall in London", "Rideau Hall in Kingston"],
            correctAnswer: "Queen's Park in Toronto",
            hint: "Ontario's legislature meets at a well-known place in the provincial capital."
        ),
        LearningQuestion(
            subject: .socialStudies,
            questionText: "Which level of government is responsible for local services such as parks and garbage collection?",
            options: ["Federal", "Provincial", "Municipal", "International"],
            correctAnswer: "Municipal",
            hint: "Municipal governments serve cities, towns, and other local communities."
        ),
        LearningQuestion(
            subject: .socialStudies,
            questionText: "Which region contains much of Ontario and is known for exposed rock and many lakes?",
            options: ["Canadian Shield", "Interior Plains", "Arctic Lowlands", "Atlantic Region"],
            correctAnswer: "Canadian Shield",
            hint: "This large rocky region wraps around Hudson Bay."
        ),
        LearningQuestion(
            subject: .socialStudies,
            questionText: "Which group is one of the three recognized Indigenous peoples of Canada?",
            options: ["Métis", "Vikings", "Romans", "Aztecs"],
            correctAnswer: "Métis",
            hint: "Canada recognizes First Nations, Inuit, and Métis peoples."
        ),
        LearningQuestion(
            subject: .socialStudies,
            questionText: "What is one way many First Nations, Inuit, and Métis communities show environmental stewardship?",
            options: [
                "Using resources carefully",
                "Wasting clean water",
                "Ignoring seasonal changes",
                "Removing all wildlife"
            ],
            correctAnswer: "Using resources carefully",
            hint: "Stewardship means caring for land, water, animals, and resources."
        ),
        LearningQuestion(
            subject: .socialStudies,
            questionText: "Which action is a civic responsibility in a community?",
            options: [
                "Littering in a park",
                "Respecting shared spaces",
                "Ignoring community rules",
                "Damaging public property"
            ],
            correctAnswer: "Respecting shared spaces",
            hint: "Civic responsibilities help communities stay safe, fair, and welcoming."
        ),
        LearningQuestion(
            subject: .english,
            questionText: "Which word is an adjective in: “The curious students read an informative article”?",
            options: ["students", "read", "curious", "article"],
            correctAnswer: "curious",
            hint: "An adjective describes or adds detail to a noun."
        ),
        LearningQuestion(
            subject: .english,
            questionText: "Which sentence uses the correct subject–verb agreement?",
            options: ["The students is ready.", "The class are ready.", "The students are ready.", "The student are ready."],
            correctAnswer: "The students are ready.",
            hint: "A plural subject needs a plural verb."
        ),
        LearningQuestion(
            subject: .english,
            questionText: "Which punctuation mark ends an interrogative sentence?",
            options: ["A period", "A comma", "A question mark", "An exclamation mark"],
            correctAnswer: "A question mark",
            hint: "Interrogative sentences ask questions."
        ),
        LearningQuestion(
            subject: .english,
            questionText: "What does the prefix “un-” usually mean in “uncertain”?",
            options: ["Before", "Not or opposite", "Again", "Very large"],
            correctAnswer: "Not or opposite",
            hint: "Look for how the prefix changes the meaning of “certain.”"
        ),
        LearningQuestion(
            subject: .geography,
            questionText: "Which map feature explains the meaning of symbols on a map?",
            options: ["The title", "The legend", "The scale", "The border"],
            correctAnswer: "The legend",
            hint: "A legend connects map symbols to real features."
        ),
        LearningQuestion(
            subject: .geography,
            questionText: "Which is a renewable natural resource?",
            options: ["Coal", "Oil", "Solar energy", "Natural gas"],
            correctAnswer: "Solar energy",
            hint: "Renewable resources can be replenished naturally in a short time."
        ),
        LearningQuestion(
            subject: .geography,
            questionText: "What does a map scale help readers determine?",
            options: ["Real distance", "Population age", "Weather temperature", "Plant names"],
            correctAnswer: "Real distance",
            hint: "Scale compares distance on the map with distance on the ground."
        ),
        LearningQuestion(
            subject: .geography,
            questionText: "Which example shows interaction between human and natural systems?",
            options: ["A rock sitting in a field", "A dam changing river flow", "A cloud passing overhead", "A star in the night sky"],
            correctAnswer: "A dam changing river flow",
            hint: "Look for a human-built feature that changes a natural system."
        ),
    ]
}

// ============================================================
// File: MyCreateTask/Model/ReadingItem.swift
// ============================================================
//
//  ReadingItem.swift
//  MyCreateTask
//
//  Created on 2026-11-11.
//  AI Acknowledgment: GitHub Copilot was used to assist with SwiftUI implementation, refactoring, and debugging. All code behavior and outputs were reviewed and verified by the student.
//

import Foundation

enum ReadingItemType: String, CaseIterable, Identifiable {
    case vocabulary = "Vocabulary"
    case passage = "Reading Passages"

    var id: String {
        rawValue
    }
}

enum ReadingPartOfSpeech: String, CaseIterable, Identifiable {
    case adjective = "Adjective"
    case verb = "Verb"
    case noun = "Noun"

    var id: String {
        rawValue
    }
}

struct ReadingKeyTerm: Identifiable, Hashable {
    let id: UUID
    let term: String
    let meaning: String

    init(id: UUID = UUID(), term: String, meaning: String) {
        self.id = id
        self.term = term
        self.meaning = meaning
    }
}

struct ReadingQuestion: Identifiable, Hashable {
    let id: UUID
    let prompt: String
    let options: [String]
    let correctOptionIndex: Int
    let explanation: String

    init(
        id: UUID = UUID(),
        prompt: String,
        options: [String],
        correctOptionIndex: Int,
        explanation: String
    ) {
        self.id = id
        self.prompt = prompt
        self.options = options
        self.correctOptionIndex = correctOptionIndex
        self.explanation = explanation
    }
}

struct ReadingItem: Identifiable, Hashable {
    let id: UUID
    let type: ReadingItemType
    let title: String
    let partOfSpeech: ReadingPartOfSpeech?
    let definition: String?
    let exampleSentence: String?
    let synonym: String?
    let category: String?
    let summary: String?
    let readingTime: Int?
    let readingLevel: Int?
    let wordCount: Int?
    let passageParagraphs: [String]
    let keyVocabulary: [ReadingKeyTerm]
    let questions: [ReadingQuestion]

    init(
        id: UUID = UUID(),
        type: ReadingItemType,
        title: String,
        partOfSpeech: ReadingPartOfSpeech? = nil,
        definition: String? = nil,
        exampleSentence: String? = nil,
        synonym: String? = nil,
        category: String? = nil,
        summary: String? = nil,
        readingTime: Int? = nil,
        readingLevel: Int? = nil,
        wordCount: Int? = nil,
        passageParagraphs: [String] = [],
        keyVocabulary: [ReadingKeyTerm] = [],
        questions: [ReadingQuestion] = []
    ) {
        self.id = id
        self.type = type
        self.title = title
        self.partOfSpeech = partOfSpeech
        self.definition = definition
        self.exampleSentence = exampleSentence
        self.synonym = synonym
        self.category = category
        self.summary = summary
        self.readingTime = readingTime
        self.readingLevel = readingLevel
        self.wordCount = wordCount
        self.passageParagraphs = passageParagraphs
        self.keyVocabulary = keyVocabulary
        self.questions = questions
    }
}

extension ReadingItem {
    static let sampleItems: [ReadingItem] = [
        ReadingItem(type: .vocabulary, title: "Curious", partOfSpeech: .adjective, definition: "Eager to learn, understand, or investigate something.", exampleSentence: "The curious students questioned how a seed can grow in a container with limited sunlight.", synonym: "Inquisitive"),
        ReadingItem(type: .vocabulary, title: "Observe", partOfSpeech: .verb, definition: "To watch carefully and notice details, patterns, or changes.", exampleSentence: "Ecologists observe wetland birds across several seasons to identify changes in migration.", synonym: "Monitor"),
        ReadingItem(type: .vocabulary, title: "Resourceful", partOfSpeech: .adjective, definition: "Able to find effective solutions using available skills and materials.", exampleSentence: "The resourceful team repaired their prototype with recycled materials after a design failed.", synonym: "Inventive"),
        ReadingItem(type: .vocabulary, title: "Biodiversity", partOfSpeech: .noun, definition: "The variety of living organisms within an ecosystem or region.", exampleSentence: "Protecting nearby wetlands can increase biodiversity by providing food and shelter for many species.", synonym: "Variety"),
        ReadingItem(type: .vocabulary, title: "Analyze", partOfSpeech: .verb, definition: "To examine information closely and decide how its parts are connected.", exampleSentence: "Students analyze population graphs to determine whether water quality is improving.", synonym: "Examine"),
        ReadingItem(type: .vocabulary, title: "Resilient", partOfSpeech: .adjective, definition: "Able to recover, adapt, or remain strong after difficulty or change.", exampleSentence: "A resilient shoreline community developed new plans after repeated flooding.", synonym: "Adaptable"),
        ReadingItem(type: .vocabulary, title: "Hypothesis", partOfSpeech: .noun, definition: "A testable prediction based on evidence or prior knowledge.", exampleSentence: "The team formed a hypothesis that darker soil would absorb more heat than lighter soil.", synonym: "Prediction"),
        ReadingItem(type: .vocabulary, title: "Sustainable", partOfSpeech: .adjective, definition: "Able to continue over time without harming resources or future needs.", exampleSentence: "A sustainable school garden uses rainwater and compost to support its plants.", synonym: "Renewable"),
        ReadingItem(type: .vocabulary, title: "Interpret", partOfSpeech: .verb, definition: "To explain the meaning of information, evidence, or a situation.", exampleSentence: "Readers interpret the author's examples to understand why the habitat is important.", synonym: "Explain"),
        ReadingItem(type: .vocabulary, title: "Collaborate", partOfSpeech: .verb, definition: "To work with others by sharing ideas and responsibilities.", exampleSentence: "The classes collaborate to design a community campaign about reducing plastic waste.", synonym: "Cooperate"),
        ReadingItem(type: .vocabulary, title: "Perspective", partOfSpeech: .noun, definition: "A particular viewpoint or way of considering an issue.", exampleSentence: "Listening to a scientist and an Indigenous Knowledge Keeper added perspective to the conservation discussion.", synonym: "Viewpoint"),
        ReadingItem(type: .vocabulary, title: "Adapt", partOfSpeech: .noun, definition: "A change in behavior or design made in response to changing conditions.", exampleSentence: "The species' adapt allowed it to survive through increasingly warm seasons.", synonym: "Adjustment"),
        ReadingItem(type: .vocabulary, title: "Innovative", partOfSpeech: .adjective, definition: "Introducing new, creative, or original ideas or methods.", exampleSentence: "The students proposed an innovative rain-collection system for the rooftop garden.", synonym: "Creative"),
        ReadingItem(type: .vocabulary, title: "Meticulous", partOfSpeech: .adjective, definition: "Very careful and precise about small details.", exampleSentence: "Mina kept meticulous weather records so she could compare temperatures accurately.", synonym: "Precise"),
        ReadingItem(type: .vocabulary, title: "Abundant", partOfSpeech: .adjective, definition: "Existing in large amounts or present in great supply.", exampleSentence: "Spring rains made wildflowers abundant across the restored prairie.", synonym: "Plentiful"),
        ReadingItem(type: .vocabulary, title: "Crucial", partOfSpeech: .adjective, definition: "Extremely important because it strongly affects a result.", exampleSentence: "Accurate measurements are crucial when researchers test a water-quality hypothesis.", synonym: "Essential"),
        ReadingItem(type: .vocabulary, title: "Evaluate", partOfSpeech: .verb, definition: "To examine information carefully and make a reasoned judgment.", exampleSentence: "Readers evaluate each source before deciding whether it supports the claim.", synonym: "Assess"),
        ReadingItem(type: .vocabulary, title: "Synthesize", partOfSpeech: .verb, definition: "To combine ideas or evidence into a clear, unified understanding.", exampleSentence: "The research team will synthesize survey results and scientific observations in its report.", synonym: "Combine"),
        ReadingItem(type: .vocabulary, title: "Advocate", partOfSpeech: .verb, definition: "To publicly support or recommend a cause, person, or action.", exampleSentence: "Student council members advocate for reusable water bottles at school events.", synonym: "Support"),
        ReadingItem(type: .vocabulary, title: "Illustrate", partOfSpeech: .verb, definition: "To explain or make a point clear with an example or visual.", exampleSentence: "The diagram illustrates how water moves through the Great Lakes watershed.", synonym: "Demonstrate"),
        ReadingItem(type: .vocabulary, title: "Stewardship", partOfSpeech: .noun, definition: "The responsible care and protection of people, land, or resources.", exampleSentence: "Community stewardship helped restore native plants along the riverbank.", synonym: "Care"),
        ReadingItem(type: .vocabulary, title: "Phenomenon", partOfSpeech: .noun, definition: "An observable event or fact that can be studied or explained.", exampleSentence: "The northern lights are a natural phenomenon that appears in many northern skies.", synonym: "Event"),
        ReadingItem(type: .vocabulary, title: "Consensus", partOfSpeech: .noun, definition: "A general agreement reached after people consider different ideas.", exampleSentence: "The committee reached a consensus on the safest route for the school hike.", synonym: "Agreement"),
        ReadingItem(type: .vocabulary, title: "Infrastructure", partOfSpeech: .noun, definition: "The basic systems and facilities that a community needs to function.", exampleSentence: "Reliable roads, water systems, and internet infrastructure support daily life.", synonym: "Framework"),

        ReadingItem(
            type: .passage,
            title: "Life in the Boreal Forest",
            category: "Canadian Nature",
            summary: "Explore how boreal species depend on relationships, seasonal change, and responsible conservation. The passage connects an ecosystem's biodiversity to human stewardship.",
            readingTime: 4,
            readingLevel: 2,
            wordCount: 310,
            passageParagraphs: [
                "Across much of northern Ontario, the boreal forest stretches between the Great Lakes and the Arctic. This vast ecosystem contains spruce and pine trees, wetlands, rivers, and rocky ridges. It may look quiet, yet the forest is filled with interactions. Moose browse on young shoots, beavers shape streams, and fungi recycle nutrients from fallen trees.",
                "Many species must adapt as temperatures and daylight change. Snowshoe hares grow thicker coats in winter, while birds such as chickadees gather seeds and insect prey. Forest fires, though frightening, can also create habitats and help certain pine cones open. Scientists do not view every disturbance as harmful, but they analyze the timing, extent, and effects of change.",
                "The forest is also home to Indigenous Peoples whose histories and Knowledge Keepers continue to guide stewardship. Indigenous communities may combine seasonal observations with scientific research to monitor caribou, water quality, and forest health. These partnerships offer more than one perspective on how ecosystems should be protected.",
                "People in nearby communities rely on boreal resources, so conservation requires careful choices. Sustainable forestry, protected areas, and responsible tourism can reduce harm while supporting livelihoods. The challenge is to balance present needs with the long-term health of soil, wildlife, and water."
            ],
            keyVocabulary: [
                ReadingKeyTerm(term: "biodiversity", meaning: "The variety of living organisms in an ecosystem."),
                ReadingKeyTerm(term: "stewardship", meaning: "Responsibly caring for land, resources, and communities."),
                ReadingKeyTerm(term: "disturbance", meaning: "A temporary event that changes an ecosystem."),
                ReadingKeyTerm(term: "sustainable", meaning: "Able to continue without damaging future resources.")
            ],
            questions: [
                ReadingQuestion(prompt: "What is the main idea of the passage?", options: ["Boreal forests are important ecosystems that require balanced stewardship.", "Every forest fire should be prevented immediately.", "Moose are the only important animals in northern Ontario.", "Only scientists can protect the boreal forest."], correctOptionIndex: 0, explanation: "The passage explains interconnected species, seasonal change, Indigenous stewardship, and sustainable resource choices."),
                ReadingQuestion(prompt: "Why might scientists view a boreal forest fire as potentially useful?", options: ["It removes all living organisms permanently.", "It guarantees that all trees grow faster.", "It can create habitat and help certain pine cones open.", "It makes human resource use unnecessary."], correctOptionIndex: 2, explanation: "The passage states that fires can create habitats and allow certain pine cones to open."),
                ReadingQuestion(prompt: "What does “sustainable” suggest about a conservation plan?", options: ["It must benefit current people without destroying future resources.", "It must avoid involving local communities.", "It must produce immediate profit only.", "It must keep every ecosystem unchanged."], correctOptionIndex: 0, explanation: "The context describes sustainable practices that balance present needs with long-term ecological health.")
            ]
        ),
        ReadingItem(
            type: .passage,
            title: "Protecting the Great Lakes",
            category: "Canadian Nature",
            summary: "Discover how communities investigate pollution and protect freshwater across the Great Lakes. The passage emphasizes evidence, cooperation, and practical action.",
            readingTime: 4,
            readingLevel: 2,
            wordCount: 298,
            passageParagraphs: [
                "The Great Lakes contain nearly one-fifth of Earth's surface freshwater, and they support wildlife, transportation, industry, and communities across Ontario. Because water moves between shorelines and rivers, pollution in one area can affect a much larger region. A dropped piece of plastic may travel from a street drain to a lake and eventually enter the food chain.",
                "Young researchers in a lakeside town investigate this problem through a “watershed walk.” They observe storm drains, test small water samples, and record litter near the shore. The students form a hypothesis before collecting evidence: they predict that locations near storm drains will contain more microplastics than beaches farther away.",
                "Their results show that the pattern is not completely consistent. Wind, recent storms, and park cleaning also influence what they find. Instead of dismissing the data, the class analyzes the variables and proposes a larger study. This careful approach prevents a single observation from becoming an unsupported conclusion.",
                "Local scientists, Indigenous communities, schools, and municipal teams then collaborate on the next steps. They organize shoreline cleanups, improve storm-drain filters, and reduce unnecessary packaging. No single group solves the issue alone, but a combination of science, public policy, and informed choices can make the lakes more resilient."
            ],
            keyVocabulary: [
                ReadingKeyTerm(term: "watershed", meaning: "An area where water drains toward a common river or lake."),
                ReadingKeyTerm(term: "microplastic", meaning: "A very small fragment of plastic."),
                ReadingKeyTerm(term: "variable", meaning: "A factor that can change or influence an outcome."),
                ReadingKeyTerm(term: "resilient", meaning: "Able to recover or adapt after stress.")
            ],
            questions: [
                ReadingQuestion(prompt: "What is the central concern of the passage?", options: ["Protecting Great Lakes water through evidence and cooperation.", "Building more boats for lake transportation.", "Measuring only plastic from beaches.", "Keeping students away from waterways."], correctOptionIndex: 0, explanation: "The passage focuses on investigating pollution and combining community, scientific, and policy action."),
                ReadingQuestion(prompt: "Why do the students need a larger study?", options: ["Their first data showed that wind and storms may affect results.", "They already proved every conclusion.", "The lakes contain no freshwater.", "They do not need to collaborate."], correctOptionIndex: 0, explanation: "The text says variables such as wind and storms may explain patterns, so the students need more evidence."),
                ReadingQuestion(prompt: "In this passage, “resilient” most likely means what?", options: ["Able to remain unchanged forever.", "Able to recover and adapt to pressure.", "Unable to handle pollution.", "Designed for one short event."], correctOptionIndex: 1, explanation: "The passage connects resilience with recovering and cooperating despite environmental stress.")
            ]
        ),
        ReadingItem(
            type: .passage,
            title: "Renewable Energy Across Ontario",
            category: "Science & Inquiry",
            summary: "Compare hydroelectric, wind, and solar options in Ontario's varied landscapes. The article explains trade-offs through inquiry rather than presenting one answer.",
            readingTime: 4,
            readingLevel: 2,
            wordCount: 320,
            passageParagraphs: [
                "Ontario generates electricity through several renewable sources, including water, wind, and sunlight. Hydroelectric stations use moving water to turn turbines, wind farms use rotating blades, and solar panels convert light into electrical energy. Each system depends on natural conditions, existing infrastructure, and careful planning.",
                "In a small town beside Lake Erie, a science class compares possible energy plans. They interpret maps showing wind patterns, river systems, and nearby homes. One plan uses existing hydroelectric capacity, while another requires many acres for solar panels. Students calculate advantages and disadvantages before reaching a conclusion.",
                "Wind and solar farms produce relatively low greenhouse gas emissions when operating, but their output can change with weather. Hydroelectric projects may disrupt fish habitat and river flow. These comparisons show why sustainable decisions involve more than cost. Communities must consider biodiversity, public opinion, land use, and reliability.",
                "The students therefore propose a mixed approach. They support improved building efficiency and a combination of local renewable sources. Their plan includes monitoring wildlife, consulting Indigenous and community partners, and sharing results with the town council. A strong plan remains adaptable because evidence and technology continue to change."
            ],
            keyVocabulary: [
                ReadingKeyTerm(term: "infrastructure", meaning: "Systems such " + "roads, pipelines, grids, and buildings needed for society."),
                ReadingKeyTerm(term: "turbine", meaning: "A machine whose blades turn when moved by water or air."),
                ReadingKeyTerm(term: "greenhouse gas", meaning: "A gas that traps heat in Earth's atmosphere."),
                ReadingKeyTerm(term: "reliability", meaning: "How consistently a system produces the needed result.")
            ],
            questions: [
                ReadingQuestion(prompt: "What main idea unites the passage?", options: ["Ontario must consider benefits and trade-offs when choosing renewable energy.", "Solar panels are useless in every season.", "Hydroelectric power has no environmental effects.", "Students should make engineering decisions alone."], correctOptionIndex: 0, explanation: "The passage compares several renewable options and emphasizes evidence, trade-offs, and consultation."),
                ReadingQuestion(prompt: "Which detail supports the need for an adaptable plan?", options: ["Evidence and technology continue to change.", "The town has one possible energy source.", "Solar panels create no construction needs.", "Communities never share opinions."], correctOptionIndex: 0, explanation: "The ending says the plan should adapt because evidence and technology continue to change."),
                ReadingQuestion(prompt: "What does “infrastructure” mean in this context?", options: ["Natural wind patterns.", "Physical systems that support electricity and society.", "A list of student opinions.", "The number of turbines in a lab."], correctOptionIndex: 1, explanation: "The passage uses infrastructure for existing systems that support energy generation and distribution.")
            ]
        ),
        ReadingItem(
            type: .passage,
            title: "Treaties, Stewardship, and Shared Responsibility",
            category: "Community & History",
            summary: "Learn how treaties and Indigenous stewardship have shaped relationships with land in Ontario. The passage encourages critical reading about historical perspective and responsibility.",
            readingTime: 5,
            readingLevel: 3,
            wordCount: 340,
            passageParagraphs: [
                "Treaties are agreements that have shaped relationships among Indigenous Nations, the Crown, newcomers, and the land. In what is now Ontario, treaties reflect different understandings of sharing, jurisdiction, and long-term responsibility. Because historical records used European legal language, later readers must interpret documents carefully and consider Indigenous perspectives.",
                "Many treaty relationships existed before written documents arrived in North America. Oral traditions preserved promises and understandings across generations. For example, a treaty may have been understood as a continuing relationship of mutual respect rather than a one-time sale of land. This does not mean every treaty used the same language or produced the same outcome.",
                "Today, Indigenous communities across Ontario practice stewardship through cultural tradition, scientific monitoring, and protection of sacred places. A community may monitor fish, restore wetlands, or negotiate land-use agreements. These actions demonstrate that treaties remain living relationships rather than distant artifacts.",
                "Students can investigate these topics through primary sources, community speakers, and reliable Indigenous voices. They should question whose perspective is included and whose is missing. A resourceful citizen also recognizes that learning about treaty responsibilities is one step toward respectful partnerships and informed civic action."
            ],
            keyVocabulary: [
                ReadingKeyTerm(term: "jurisdiction", meaning: "The authority to make and apply decisions over a place or issue."),
                ReadingKeyTerm(term: "oral tradition", meaning: "Knowledge passed through spoken stories and teachings."),
                ReadingKeyTerm(term: "stewardship", meaning: "Responsible care for land and resources."),
                ReadingKeyTerm(term: "civic action", meaning: "A responsible step taken to participate in community life.")
            ],
            questions: [
                ReadingQuestion(prompt: "What is the main idea of the passage?", options: ["Treaties and Indigenous stewardship remain important relationships that require informed respect.", "All treaties had identical terms.", "Stewardship ended when written treaties appeared.", "Only colonial governments kept treaty records."], correctOptionIndex: 0, explanation: "The passage explains treaty diversity, Indigenous perspectives, continuing stewardship, and responsible civic learning."),
                ReadingQuestion(prompt: "Why should readers interpret treaty documents with multiple perspectives?", options: ["They were all written in simple modern language.", "European records may not fully reflect Indigenous understandings.", "Oral tradition has no historical value.", "Every community shared exactly the same view."], correctOptionIndex: 1, explanation: "The passage explains that different cultural understandings and Indigenous oral traditions add meaning and context."),
                ReadingQuestion(prompt: "What can be inferred about “living relationships” in the final section?", options: ["Treaties continue to influence present responsibilities.", "Treaties no longer have legal or cultural meaning.", "Only historic facts matter.", "Students should avoid community partnerships."], correctOptionIndex: 0, explanation: "The discussion of present monitoring, agreements, and stewardship shows treaties remain active relationships.")
            ]
        ),
        ReadingItem(
            type: .passage,
            title: "Robotics Beyond Earth's Atmosphere",
            category: "Science & Inquiry",
            summary: "Follow the Canadarm legacy from a Canadian engineering challenge to a global space program. The passage examines problem-solving, teamwork, and future exploration.",
            readingTime: 5,
            readingLevel: 3,
            wordCount: 332,
            passageParagraphs: [
                "The Canadarm began as an engineering challenge: how could astronauts move large objects outside a spacecraft safely? A Canadian team answered with a remote-controlled robotic arm that could extend, grip, and release equipment in weightlessness. The first Canadarm helped launch satellites and inspect the outside of a Space Shuttle.",
                "Later generations became larger and more specialized. Canadarm2 is based on the International Space Station and can move along its exterior like a mechanical traveler. Astronauts remotely operate the arm to capture spacecraft, move supplies, and support repairs. Engineers must interpret signals, calculate force, and communicate with extreme precision.",
                "A robotic mission does not depend on one brilliant inventor. Teams of programmers, mechanics, biologists, and astronauts analyze risks and test designs. They also adapt to conditions that cannot be reproduced perfectly on Earth. For example, a small delay in communication makes every remote movement require planning.",
                "Canada's space robotics program has inspired future systems for the Moon and Mars. Engineers are designing robots that can work with or without direct human control. These systems may assemble habitats, collect samples, or perform hazardous inspections. Their success will depend on resilient hardware and collaborative teams able to respond to uncertainty."
            ],
            keyVocabulary: [
                ReadingKeyTerm(term: "weightlessness", meaning: "A condition with almost no apparent gravitational force."),
                ReadingKeyTerm(term: "remote-controlled", meaning: "Operated from a distance."),
                ReadingKeyTerm(term: "precision", meaning: "A high level of exactness."),
                ReadingKeyTerm(term: "uncertainty", meaning: "Not knowing what may happen with complete confidence.")
            ],
            questions: [
                ReadingQuestion(prompt: "What problem did the original Canadarm solve?", options: ["It transported astronauts underground.", "It moved objects outside spacecraft safely.", "It replaced every computer on Earth.", "It produced oxygen for future missions."], correctOptionIndex: 1, explanation: "The passage says Canadarm was designed to extend, grip, and release equipment outside a spacecraft."),
                ReadingQuestion(prompt: "Why must engineers plan remote movements carefully?", options: ["Communication delays can create uncertainty.", "The arm can only turn in a straight line.", "No one can interpret its signals.", "Weightlessness gives every object unlimited speed."], correctOptionIndex: 0, explanation: "The passage states that communication delays require precise planning for remote movements."),
                ReadingQuestion(prompt: "What does the passage imply about future space robotics?", options: ["Future systems will require teamwork and adaptable technology.", "Robots will work only without human knowledge.", "Canada will stop designing robotic systems.", "Every mission will use identical hardware."], correctOptionIndex: 0, explanation: "The conclusion describes uncertain conditions, resilient hardware, and collaborative teams.")
            ]
        ),
        ReadingItem(
            type: .passage,
            title: "Small Actions, Strong Communities",
            category: "Community & History",
            summary: "Examine how young citizens identify needs and turn ideas into responsible civic action. The passage shows that participation can begin with research, listening, and measurable goals.",
            readingTime: 4,
            readingLevel: 2,
            wordCount: 300,
            passageParagraphs: [
                "Civic responsibility means participating in decisions that affect a community. It can include voting when eligible, attending public meetings, obeying fair rules, and volunteering. For young people, civic action often begins with noticing an issue and asking who is affected.",
                "A class near Toronto discovers that the walking route to a community center crosses a busy driveway. Rather than assume a solution, students observe traffic at different times, survey users, and analyze the results. They include perspectives from students, caregivers, bus drivers, and accessibility advocates.",
                "The class prepares a clear proposal for the local council. Their ideas include brighter signs, a shorter crossing route, and a temporary volunteer monitor. They also explain that the proposal should be tested and adjusted if it creates another problem. A resourceful team recognizes that a strong plan uses evidence and welcomes criticism.",
                "The council approves a pilot project for six months. If collisions or near misses decrease, the community may continue or improve the design. If not, leaders will adapt the plan. This process shows that responsible participation is sustained: citizens listen, act, measure, and learn."
            ],
            keyVocabulary: [
                ReadingKeyTerm(term: "civic responsibility", meaning: "A citizen's role in contributing to community well-being."),
                ReadingKeyTerm(term: "stakeholder", meaning: "A person or group affected by a decision."),
                ReadingKeyTerm(term: "pilot project", meaning: "A small trial of an idea before a larger commitment."),
                ReadingKeyTerm(term: "advocate", meaning: "A person who publicly supports a need or viewpoint.")
            ],
            questions: [
                ReadingQuestion(prompt: "What is the main idea of the passage?", options: ["Civic participation should use listening, evidence, action, and reflection.", "Students should make changes without adults.", "Only traffic problems count as civic issues.", "A pilot project never needs to be evaluated."], correctOptionIndex: 0, explanation: "The passage demonstrates the complete cycle of identifying an issue, gathering evidence, proposing action, and evaluating results."),
                ReadingQuestion(prompt: "Why did the class include several perspectives?", options: ["To understand how the crossing affected different community members.", "To choose one correct route without evidence.", "To replace the council's responsibilities.", "To avoid testing the project."], correctOptionIndex: 0, explanation: "The students interviewed and surveyed people who experienced or managed the crossing."),
                ReadingQuestion(prompt: "What does “adapt” mean at the end of the passage?", options: ["Ignore the pilot project's results.", "Change the plan in response to evidence.", "Return to the first assumption.", "End participation in the community."], correctOptionIndex: 1, explanation: "The council and students would adjust the plan based on whether the trial improved safety.")
            ]
        ),
        ReadingItem(
            type: .passage,
            title: "A Walk in the Wetland",
            category: "Canadian Nature",
            summary: "See how a wetland gives frogs, birds, and plants a place to live.",
            readingTime: 2,
            readingLevel: 1,
            wordCount: 180,
            passageParagraphs: [
                "A wetland is a wet area covered by shallow water or very damp soil. Many wetlands in Ontario have cattails, reeds, frogs, ducks, and insects. These plants and animals depend on one another.",
                "Cattails provide shelter for birds. Ducks find food among the plants. Frogs eat insects and become food for larger animals. This chain of life is called a food web.",
                "Wetlands also hold extra rainwater. They help slow floods and keep nearby water clean. When people protect wetlands, they help many living things and keep communities safer.",
                "Always explore a wetland with an adult. Stay on the path and watch wildlife from far away. You can help by not littering and reporting damaged areas."
            ],
            keyVocabulary: [
                ReadingKeyTerm(term: "wetland", meaning: "An area with shallow water or very damp soil."),
                ReadingKeyTerm(term: "food web", meaning: "Connected paths showing how living things get food."),
                ReadingKeyTerm(term: "habitat", meaning: "A place where a living thing finds what it needs.")
            ],
            questions: [
                ReadingQuestion(prompt: "What is the main purpose of a wetland?", options: ["It provides habitat and helps control water.", "It replaces every forest.", "It only grows flowers.", "It has no connection to animals."], correctOptionIndex: 0, explanation: "The passage says wetlands provide homes and help hold extra rainwater."),
                ReadingQuestion(prompt: "What is a food web?", options: ["A net used in science", "Connected paths showing how living things get food", "A map of a wetland", "A kind of water plant"], correctOptionIndex: 1, explanation: "The passage explains that a food web shows connected feeding relationships."),
                ReadingQuestion(prompt: "How can students help wetlands?", options: ["Litter near the path", "Stay on the path and do not litter", "Disturb nesting birds", "Remove the cattails"], correctOptionIndex: 1, explanation: "The final paragraph suggests staying on paths and avoiding litter.")
            ]
        ),
        ReadingItem(
            type: .passage,
            title: "Light and Shadows",
            category: "Science & Inquiry",
            summary: "Discover how a light source and an object work together to make a shadow.",
            readingTime: 3,
            readingLevel: 1,
            wordCount: 195,
            passageParagraphs: [
                "A shadow forms when an object blocks light. The object may be a tree, a pencil, or your own body. If light can pass around the edges, the shadow will show a simple shape.",
                "Light travels in straight lines. When you move an object closer to a lamp, its shadow can look larger. When you move the object farther away, the shadow may become smaller.",
                "The Sun also makes shadows. At noon, the Sun is high in the sky, so shadows are short. In the morning or afternoon, shadows grow longer because sunlight reaches us at a lower angle.",
                "Try this with a flashlight and a small toy. Change the distance and notice how the shadow changes. Make one careful prediction before each test."
            ],
            keyVocabulary: [
                ReadingKeyTerm(term: "shadow", meaning: "A dark shape made when an object blocks light."),
                ReadingKeyTerm(term: "light source", meaning: "Something that gives off light."),
                ReadingKeyTerm(term: "angle", meaning: "The direction or slant of a line or ray.")
            ],
            questions: [
                ReadingQuestion(prompt: "What makes a shadow?", options: ["A loud sound", "An object blocking light", "A warm temperature", "A coloured marker"], correctOptionIndex: 1, explanation: "The passage says shadows form when an object blocks light."),
                ReadingQuestion(prompt: "When are shadows usually shortest?", options: ["At noon", "At midnight", "After dark", "During rain"], correctOptionIndex: 0, explanation: "The passage says shadows are short when the Sun is high at noon."),
                ReadingQuestion(prompt: "What should students do before each flashlight test?", options: ["Predict what will happen", "Turn off the flashlight", "Leave the room", "Use no toy"], correctOptionIndex: 0, explanation: "The final paragraph asks students to make a prediction.")
            ]
        ),
        ReadingItem(
            type: .passage,
            title: "The School Recycling Team",
            category: "Community & History",
            summary: "Learn how a small student team uses sorting, planning, and teamwork to reduce waste.",
            readingTime: 3,
            readingLevel: 1,
            wordCount: 205,
            passageParagraphs: [
                "A recycling team at Westview School noticed too much paper in the garbage. The students wanted to solve the problem. First, they asked every class how much paper and plastic they threw away.",
                "The team drew a chart. It showed which rooms produced the most recyclable material. They also checked the labels on bins. Some bins needed clearer signs.",
                "Next, the students made bright signs with pictures. They showed which items belong in paper, plastic, and garbage bins. Teachers helped place the signs near every bin.",
                "After one month, the school found less recyclable material in the garbage. The team checked the chart again and celebrated progress. They learned that teamwork and clear directions can improve a routine."
            ],
            keyVocabulary: [
                ReadingKeyTerm(term: "recyclable", meaning: "Able to be collected and made into new items."),
                ReadingKeyTerm(term: "data", meaning: "Facts or information used to answer a question."),
                ReadingKeyTerm(term: "teamwork", meaning: "Working together to reach a shared goal.")
            ],
            questions: [
                ReadingQuestion(prompt: "What problem did the recycling team notice?", options: ["Too much paper in the garbage", "Too few desks", "Long lineups for lunch", "Broken playground slides"], correctOptionIndex: 0, explanation: "The passage begins by describing too much paper in garbage."),
                ReadingQuestion(prompt: "How did the team show their findings?", options: ["With a chart", "With a song", "With a science kit", "With a treasure map"], correctOptionIndex: 0, explanation: "The team drew a chart to compare recyclable material."),
                ReadingQuestion(prompt: "What helped the team improve recycling?", options: ["Clear signs and teamwork", "More garbage bins", "Less classroom work", "Removing all bins"], correctOptionIndex: 0, explanation: "Clear signs and the team's shared work improved the routine.")
            ]
        )
    ]
}

// ============================================================
// File: MyCreateTask/Model/RecessGame.swift
// ============================================================
//
//  RecessGame.swift
//  MyCreateTask
//
//  Created on 2026-11-10.
//  AI Acknowledgment: GitHub Copilot was used to assist with SwiftUI implementation, refactoring, and debugging. All code behavior and outputs were reviewed and verified by the student.
//

import Foundation

struct RecessGame: Identifiable, Hashable {

    // MARK: - Stored properties

    let id: UUID
    let name: String
    let category: String
    let summary: String
    let minPlayers: Int
    let maxPlayers: Int
    let estimatedDuration: Int
    let playArea: String
    let goal: String
    let rules: String
    let equipment: String
    let safety: String

    // MARK: - Initializer

    init(
        id: UUID = UUID(),
        name: String,
        category: String,
        summary: String,
        minPlayers: Int,
        maxPlayers: Int = 12,
        estimatedDuration: Int = 15,
        playArea: String,
        goal: String,
        rules: String,
        equipment: String,
        safety: String
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.summary = summary
        self.minPlayers = minPlayers
        self.maxPlayers = maxPlayers
        self.estimatedDuration = estimatedDuration
        self.playArea = playArea
        self.goal = goal
        self.rules = rules
        self.equipment = equipment
        self.safety = safety
    }

}

extension RecessGame {

    // MARK: - Kid-friendly instructions

    var ruleSteps: [String] {
        switch name {
        case "Four Square":
            return [
                "Stand inside your square and wait for a turn.",
                "Bounce the ball once before hitting it to another square.",
                "Hit the ball with one controlled hand.",
                "Keep the ball inside the lines and avoid double hits.",
                "Leave the court after an out and let the next player enter."
            ]
        case "Capture the Flag":
            return [
                "Divide into two teams and choose a safe playing field.",
                "Place each team's flag inside its own territory.",
                "Cross into the other territory to look for the flag.",
                "Tag opponents gently and follow the agreed jail or restart rule.",
                "Carry the flag back across your line to score."
            ]
        case "Wall Ball":
            return [
                "Stand behind the throwing line and face the wall.",
                "Throw or bounce the soft ball toward the wall.",
                "Let the ball bounce once, then return it to the wall.",
                "Keep the ball moving until someone misses or lets it bounce twice.",
                "Step away after an out so the next player can play."
            ]
        case "Gaga Ball":
            return [
                "Stand inside the gaga ball pit.",
                "Roll or gently tap the ball instead of throwing it.",
                "Keep the ball below the waist when you hit it.",
                "Duck, jump, or move aside when the ball comes toward you.",
                "Leave the pit after being hit and cheer for the remaining players."
            ]
        case "Octopus Tag":
            return [
                "Choose one safe starting area for the octopus.",
                "Stand behind the starting line and listen for the go signal.",
                "Run across the play area without getting tagged.",
                "Join the octopus and stay in the middle area after being tagged.",
                "Keep moving safely and follow the teacher's stopping signal."
            ]
        case "Crab Soccer":
            return [
                "Place two goals on opposite sides of a clear field.",
                "Move in the crab position with hands and feet near the ground.",
                "Kick the soft ball toward the goal using your feet.",
                "Keep the ball in bounds and take turns changing sides.",
                "Stop immediately when a player becomes tired or unsafe."
            ]
        case "Ultimate Frisbee":
            return [
                "Divide into two teams and place end zones on both sides.",
                "Pass the frisbee to a teammate with one controlled throw.",
                "Do not run while holding the frisbee.",
                "Score by catching the frisbee inside the other team's end zone.",
                "Turn the frisbee over to the other team after a drop or out."
            ]
        case "Sharks and Minnows":
            return [
                "Choose one area for the sharks and one safe line for the minnows.",
                "Start all minnows on the same side of the play area.",
                "Move across the area when the leader calls go.",
                "Avoid the sharks and stay inside the marked boundaries.",
                "Join the sharks after being tagged and restart the next round."
            ]
        case "Mr. Wolf":
            return [
                "Stand together behind the starting line.",
                "Ask, “What time is it, Mr. Wolf?”",
                "Take the number of steps Mr. Wolf says.",
                "Run back when Mr. Wolf calls, “Dinner time!”",
                "Tag gently and return to the line for the next round."
            ]
        case "Tag":
            return [
                "Choose one player to be the tagger.",
                "Stay inside the marked playground boundaries.",
                "Run gently and look for open space.",
                "Tag a player lightly below the shoulders.",
                "Let the tagged player become the new tagger."
            ]
        case "Soccer":
            return [
                "Divide into two teams and choose goals.",
                "Pass or dribble the ball with your feet.",
                "Keep the ball inside the playing area.",
                "Use no hands unless you are the assigned goalkeeper.",
                "Kick the whole ball across the goal line to score."
            ]
        case "Jump Rope Challenge":
            return [
                "Choose a safe, clear place to jump.",
                "Hold the rope so it fits comfortably.",
                "Swing the rope over your head.",
                "Jump over the rope as it reaches your feet.",
                "Count successful jumps or try a new jumping pattern."
            ]
        case "Freeze Tag":
            return [
                "Choose one or two players to be the taggers.",
                "Stay inside the marked play area.",
                "Freeze in place after a gentle tag.",
                "Unfreeze a teammate with a gentle high five.",
                "Stop the round when time ends or everyone is frozen."
            ]
        case "Red Light, Green Light":
            return [
                "Choose a caller and face the caller away from the group.",
                "Stand behind the starting line.",
                "Move forward only when the caller says green light.",
                "Stop completely when the caller says red light.",
                "Return to the line if you move on red light."
            ]
        case "Hopscotch":
            return [
                "Draw a clear numbered hopscotch grid.",
                "Toss a small marker into the first square.",
                "Hop around the marker through the grid.",
                "Pick up the marker on the way back.",
                "Continue with the next number after a successful turn."
            ]
        case "Kickball":
            return [
                "Place the bases and divide into two teams.",
                "Roll the ball toward the kicker.",
                "Kick the ball into the field and run to a base.",
                "Stop at a base or keep running if the path is safe.",
                "Score a run or get three outs to change turns."
            ]
        case "Steal the Bacon":
            return [
                "Divide into two teams and give every player a number.",
                "Place a soft object in the centre of the field.",
                "Listen for the caller to announce a number.",
                "Race out together and carry the object to your side.",
                "Score only if you return without being tagged."
            ]
        default:
            return [
                "Gather in a safe, clearly marked play area.",
                "Choose teams or roles before starting.",
                "Follow the game goal and take turns fairly.",
                "Use the equipment gently and stay inside the boundaries.",
                "Stop, reset, and begin a new round when the leader calls."
            ]
        }
    }

    // MARK: - Sample data

    static let sampleGames: [RecessGame] = [
        RecessGame(
            name: "Mr. Wolf",
            category: "Tag & Chasing",
            summary: "A listening and movement game where players try to reach Mr. Wolf safely.",
            minPlayers: 4,
            playArea: "A flat, open playground area with a clear starting line.",
            goal: "Be the first player to reach the finish line without being tagged.",
            rules: "Players ask, “What time is it, Mr. Wolf?” Mr. Wolf answers with a number. Players take that many steps forward. When Mr. Wolf says, “Dinner time!”, players run back to the starting line while Mr. Wolf tries to tag someone.",
            equipment: "Open playground space",
            safety: "Use a clear running area, look where you are going, and avoid pushing or cutting across other players."
        ),
        RecessGame(
            name: "Four Square",
            category: "Ball & Target",
            summary: "A court game that combines bouncing, catching, and quick reactions.",
            minPlayers: 4,
            playArea: "A marked four-square court on a flat surface.",
            goal: "Keep the ball in play and move toward the highest square.",
            rules: "Bounce the ball into another player's square. The receiving player lets it bounce once, then hits it into another square. A player leaves the court after hitting out or missing a legal return.",
            equipment: "Four-square court and playground ball",
            safety: "Keep hands away from other players and wait behind the court until it is your turn."
        ),
        RecessGame(
            name: "Tag",
            category: "Tag & Chasing",
            summary: "A simple running game where one player tries to tag the others.",
            minPlayers: 2,
            playArea: "An open, bounded playground area.",
            goal: "Avoid being tagged or become the next tagger.",
            rules: "One player is the tagger. The tagger chases the other players and gently tags one player, who then becomes the new tagger.",
            equipment: "Open playground space",
            safety: "Set boundaries before starting, keep both hands gentle, and do not tag near playground equipment."
        ),
        RecessGame(
            name: "Soccer",
            category: "Team Strategy",
            summary: "A cooperative kicking game focused on passing and scoring goals.",
            minPlayers: 4,
            playArea: "A flat field with two goals and marked boundaries.",
            goal: "Score more goals than the other team.",
            rules: "Teams pass and dribble the ball using their feet. A goal is scored when the whole ball crosses the goal line. Players may not use their hands except for a goalkeeper if one is assigned.",
            equipment: "Soccer ball and two goals",
            safety: "Use a soft ball when possible, keep cleats or shoes tied, and avoid slide tackles."
        ),
        RecessGame(
            name: "Jump Rope Challenge",
            category: "Coordination",
            summary: "A rhythm and coordination activity that can be played alone or with a partner.",
            minPlayers: 1,
            playArea: "A clear, level area with enough room to swing the rope.",
            goal: "Complete as many controlled jumps as possible.",
            rules: "Swing the rope over your head and under your feet while jumping. Players can count consecutive jumps or try a challenge such as alternating feet.",
            equipment: "Jump rope",
            safety: "Leave space between players, use a rope that fits, and stop if the ground becomes slippery."
        ),
        RecessGame(
            name: "Capture the Flag",
            category: "Team Strategy",
            summary: "A team game that combines running, strategy, and defending a team flag.",
            minPlayers: 6,
            playArea: "A large, clearly divided playground with one territory for each team.",
            goal: "Bring the other team's flag back to your own territory without being tagged.",
            rules: "Teams protect their own flag while trying to capture the other team's flag. A player who is tagged in the other team's territory follows the agreed-upon jail or restart rule.",
            equipment: "Two flags, cones, and open playground space",
            safety: "Set boundaries away from obstacles, tag gently, and use a no-contact rule near walls or equipment."
        ),
        RecessGame(
            name: "Freeze Tag",
            category: "Tag & Chasing",
            summary: "A cooperative tag game where frozen players need teammates to set them free.",
            minPlayers: 4,
            playArea: "An open, bounded playground area with clear running space.",
            goal: "Avoid being tagged or unfreeze teammates while staying inside the boundaries.",
            rules: "Choose one or two taggers. When a player is tagged, they freeze in place with their feet still. A teammate unfreezes them with a gentle high five. The round ends when everyone is frozen or time runs out.",
            equipment: "Open playground space",
            safety: "Tag gently below the shoulders, keep boundaries away from obstacles, and walk carefully when unfreezing a teammate."
        ),
        RecessGame(
            name: "Red Light, Green Light",
            category: "Coordination",
            summary: "Players listen carefully and move toward the leader only when it is safe to go.",
            minPlayers: 3,
            playArea: "A flat, open area with a starting line and finish line.",
            goal: "Be the first player to reach the finish line while following the signals.",
            rules: "One player is the caller and faces away from the group. When the caller says, “Green Light,” players move forward. When the caller says, “Red Light,” players freeze completely. Anyone who moves on Red Light returns to the starting line.",
            equipment: "Open playground space",
            safety: "Use walking or gentle jogging speed, leave space between players, and choose a flat area without obstacles."
        ),
        RecessGame(
            name: "Wall Ball",
            category: "Ball & Target",
            summary: "Players take turns bouncing a playground ball against a wall and making a controlled return.",
            minPlayers: 2,
            playArea: "A flat wall with a clear space in front of it.",
            goal: "Keep the rally going by returning the ball after one bounce.",
            rules: "The first player throws or rolls the ball toward the wall. The ball may bounce once before the next player returns it. A player earns a point when another player misses, lets the ball bounce twice, or sends it out of bounds.",
            equipment: "Soft rubber playground ball and a clear wall",
            safety: "Use a soft ball, stand behind the throwing line, check that nobody is nearby, and never throw toward faces."
        ),
        RecessGame(
            name: "Hopscotch",
            category: "Coordination",
            summary: "Players toss a marker and hop through a numbered pattern using one or two feet.",
            minPlayers: 1,
            playArea: "A flat surface with a clearly drawn hopscotch grid.",
            goal: "Complete the grid while keeping balance and following the foot pattern.",
            rules: "Toss a marker onto the first square without touching a line. Hop over that square through the grid, using one foot in single squares and two feet in side-by-side squares. Pick up the marker on the way back, then continue with the next number.",
            equipment: "Chalk and a small flat marker",
            safety: "Draw the grid on a dry, level surface, take turns, and leave space around the player who is hopping."
        ),
        RecessGame(
            name: "Kickball",
            category: "Ball & Target",
            summary: "A baseball-style team game played by kicking a rolled playground ball and running bases.",
            minPlayers: 6,
            playArea: "A flat field marked with home plate and three bases.",
            goal: "Score runs by kicking the ball and reaching home plate before the other team gets three outs.",
            rules: "One team kicks while the other team fields. The pitcher rolls the ball toward the kicker, who kicks it into the field and runs the bases. Fielders can catch the kick, tag a runner, or send the ball to a base before the runner arrives.",
            equipment: "Soft playground ball, four bases, and cones",
            safety: "Roll the ball instead of throwing it at runners, keep kickers behind the line, and wait until the field is clear."
        ),
        RecessGame(
            name: "Steal the Bacon",
            category: "Team Strategy",
            summary: "Two numbered teams race to grab a center object and return it safely to their side.",
            minPlayers: 6,
            maxPlayers: 12,
            estimatedDuration: 15,
            playArea: "A flat, open field divided into two team territories with a center line.",
            goal: "Bring the center object back to your team's side without being tagged.",
            rules: "Divide players into two teams and give each player a number. Place an object in the center. The caller announces a number, and the matching players race to the object. A player scores by carrying it home safely, or the other player scores by tagging the carrier before they cross the line.",
            equipment: "One soft object such as a beanbag and boundary cones",
            safety: "Use a soft center object, tag gently below the shoulders, keep the center area clear, and stop if players collide."
        ),
        RecessGame(
            name: "Gaga Ball",
            category: "Coordination",
            summary: "A fast, low-contact ball game played inside an octagonal pit.",
            minPlayers: 3,
            maxPlayers: 10,
            estimatedDuration: 15,
            playArea: "A flat, enclosed gaga ball pit.",
            goal: "Stay inside the pit while avoiding a ball below the waist.",
            rules: "Players stand inside the pit. A player rolls or taps the ball into the game. Players use hands to send the ball below waist height. A hit below the waist means a player leaves. The last player inside wins.",
            equipment: "Gaga ball, pit walls, and soft indoor or outdoor surface",
            safety: "Keep hands open, stay on your feet, and avoid pushing or trapping players against the walls."
        ),
        RecessGame(
            name: "Octopus Tag",
            category: "Tag & Chasing",
            summary: "A large-group tag game where tagged players join the octopus in the middle.",
            minPlayers: 6,
            maxPlayers: 24,
            estimatedDuration: 12,
            playArea: "A marked open area with a safe starting line.",
            goal: "Cross the play area without being tagged.",
            rules: "The octopus starts in the middle. Players cross from one line to the other. Tagged players join the octopus and may also tag. Safe crossing earns a point for the next round.",
            equipment: "Cones and open playground space",
            safety: "Use a walking pace near walls, tag gently, and stop the game in crowded areas."
        ),
        RecessGame(
            name: "Crab Soccer",
            category: "Team Strategy",
            summary: "A silly team game played while moving in the crab position.",
            minPlayers: 6,
            maxPlayers: 16,
            estimatedDuration: 15,
            playArea: "A flat field with two goals.",
            goal: "Kick the ball into the other team's goal while moving like a crab.",
            rules: "Players sit or support themselves on hands and feet. Teams move sideways to pass and defend. Only feet move the ball toward a goal. The team with more goals wins.",
            equipment: "Soft foam ball and two goals",
            safety: "Use a soft ball, keep crab movements away from obstacles, and stop if wrists become sore."
        ),
        RecessGame(
            name: "Ultimate Frisbee",
            category: "Team Strategy",
            summary: "A passing and movement game played with a frisbee and two end zones.",
            minPlayers: 6,
            maxPlayers: 16,
            estimatedDuration: 20,
            playArea: "A wide open field with two marked end zones.",
            goal: "Complete passes and catch the frisbee in the opposite end zone.",
            rules: "Teams pass the frisbee to advance. A player cannot run while holding it. A catch in the end zone scores a point. Drops or out-of-bounds throws switch possession.",
            equipment: "Lightweight frisbee and field cones",
            safety: "Leave space for throws, call for the frisbee, and never reach into another player's space."
        ),
        RecessGame(
            name: "Sharks and Minnows",
            category: "Tag & Chasing",
            summary: "Minnows cross a field while sharks try to tag them.",
            minPlayers: 6,
            maxPlayers: 24,
            estimatedDuration: 12,
            playArea: "A large open field with one shark zone and two safe lines.",
            goal: "Cross to the opposite line and avoid becoming a shark.",
            rules: "Minnows start behind one line. Sharks stand in the middle. The leader calls start and minnows cross the field. Tagged minnows become sharks. The last safe minnow begins the next round.",
            equipment: "Cones and open playground space",
            safety: "Use gentle tags, keep both hands low, and pause if the field becomes crowded."
        )
    ]
}

// ============================================================
// File: MyCreateTask/ViewModels/DailyChecklistViewModel.swift
// ============================================================
//
//  DailyChecklistViewModel.swift
//  MyCreateTask
//
//  Created on 2026-11-11.
//  AI Acknowledgment: GitHub Copilot was used to assist with SwiftUI implementation, refactoring, and debugging. All code behavior and outputs were reviewed and verified by the student.
//

import Foundation
import Observation

@Observable
final class DailyChecklistViewModel {

    // MARK: - Stored properties

    private(set) var tasks: [DailyTask] = DailyTask.sampleTasks

    // MARK: - Computed properties

    var completedTaskCount: Int {
        countCompletedTasks(tasks: tasks)
    }

    var completionProgress: Double {
        guard !tasks.isEmpty else {
            return 0
        }

        return Double(completedTaskCount) / Double(tasks.count)
    }

    // MARK: - Functions

    func countCompletedTasks(tasks: [DailyTask]) -> Int {
        var count: Int = 0

        // Add one for each task that is marked complete.
        for task in tasks {
            if task.isCompleted {
                count += 1
            }
        }

        return count
    }

    func toggleTask(_ task: DailyTask) {
        var taskIndex: Int?

        for index in tasks.indices {
            if tasks[index].id == task.id {
                taskIndex = index
                break
            }
        }

        guard let taskIndex else {
            return
        }

        tasks[taskIndex].isCompleted.toggle()
    }

    func addTask(title: String) {
        let trimmedTitle: String = title.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedTitle.isEmpty else {
            return
        }

        tasks.append(DailyTask(title: trimmedTitle))
    }

    func deleteTasks(at offsets: IndexSet) {
        var offsetArray: [Int] = []

        // Copy the requested positions, then sort them by hand from highest to lowest.
        for offset in offsets {
            offsetArray.append(offset)
        }
        offsetArray.sort()

        if !offsetArray.isEmpty {
            for index in stride(from: offsetArray.count - 1, through: 0, by: -1) {
                let offset: Int = offsetArray[index]
                if tasks.indices.contains(offset) {
                    tasks.remove(at: offset)
                }
            }
        }
    }

    func delete(_ task: DailyTask) {
        var remainingTasks: [DailyTask] = []

        // Keep every task except the task with the matching ID.
        for currentTask in tasks {
            if currentTask.id != task.id {
                remainingTasks.append(currentTask)
            }
        }

        tasks = remainingTasks
    }

    func clearCompletedTasks() {
        var remainingTasks: [DailyTask] = []

        // Keep only tasks that are not completed.
        for task in tasks {
            if !task.isCompleted {
                remainingTasks.append(task)
            }
        }

        tasks = remainingTasks
    }

    func resetDefaults() {
        tasks = DailyTask.sampleTasks
    }
}

// ============================================================
// File: MyCreateTask/ViewModels/DanceGamesViewModel.swift
// ============================================================
//
//  DanceGamesViewModel.swift
//  MyCreateTask
//
//  Created on 2026-11-11.
//  AI Acknowledgment: GitHub Copilot was used to assist with SwiftUI implementation, refactoring, and debugging. All code behavior and outputs were reviewed and verified by the student.
//

import Foundation
import Observation

@Observable
final class DanceGamesViewModel {

    // MARK: - Stored properties

    let games: [DanceGame] = DanceGame.sampleGames
    var selectedCategory: DanceGameCategory?
    var selectedEnergy: DanceGameEnergy?
    private(set) var secondsRemaining: Int = 0
    private(set) var isTimerRunning: Bool = false
    private(set) var selectedGameID: UUID?
    private(set) var remainingSecondsByGame: [UUID: Int] = [:]
    private(set) var runningGameIDs: Set<UUID> = []
    private(set) var completedGameIDs: Set<UUID> = []

    // MARK: - Initializer

    init() {
        for game in games {
            remainingSecondsByGame[game.id] = game.duration
        }
    }

    // MARK: - Computed properties

    var filteredGames: [DanceGame] {
        filterDanceGames(
            games: games,
            category: selectedCategory,
            energy: selectedEnergy
        )
    }

    var timerText: String {
        let minutes: Int = secondsRemaining / 60
        let seconds: Int = secondsRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    // MARK: - Functions

    func remainingSeconds(for game: DanceGame) -> Int {
        remainingSecondsByGame[game.id] ?? game.duration
    }

    func timerText(for game: DanceGame) -> String {
        let secondsRemaining = remainingSeconds(for: game)
        let minutes: Int = secondsRemaining / 60
        let seconds: Int = secondsRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    func isRunning(_ game: DanceGame) -> Bool {
        runningGameIDs.contains(game.id)
    }

    func isComplete(_ game: DanceGame) -> Bool {
        completedGameIDs.contains(game.id)
    }

    func startTimer(for game: DanceGame) {
        if isComplete(game) {
            remainingSecondsByGame[game.id] = game.duration
            completedGameIDs.remove(game.id)
        }

        if remainingSecondsByGame[game.id] == nil {
            remainingSecondsByGame[game.id] = game.duration
        }

        guard remainingSeconds(for: game) > 0 else {
            return
        }

        runningGameIDs.insert(game.id)
    }

    func pauseTimer(for game: DanceGame) {
        runningGameIDs.remove(game.id)
    }

    func resetTimer(for game: DanceGame) {
        remainingSecondsByGame[game.id] = game.duration
        runningGameIDs.remove(game.id)
        completedGameIDs.remove(game.id)
    }

    func selectGame(_ game: DanceGame) {
        selectedGameID = game.id
        secondsRemaining = game.duration
        isTimerRunning = false
    }

    func startTimer() {
        guard secondsRemaining > 0 else {
            return
        }

        isTimerRunning = true
    }

    func pauseTimer() {
        isTimerRunning = false
    }

    func resetTimer() {
        guard let selectedGameID,
              let selectedGame = game(withID: selectedGameID) else {
            secondsRemaining = 0
            isTimerRunning = false
            return
        }

        secondsRemaining = selectedGame.duration
        isTimerRunning = false
    }

    func tickTimer() {
        for game in games {
            guard runningGameIDs.contains(game.id) else {
                continue
            }

            let remainingSeconds = remainingSeconds(for: game)
            if remainingSeconds > 0 {
                remainingSecondsByGame[game.id] = remainingSeconds - 1
            }

            if remainingSeconds <= 1 {
                runningGameIDs.remove(game.id)
                completedGameIDs.insert(game.id)
            }
        }

        if isTimerRunning {
            if secondsRemaining > 0 {
                secondsRemaining -= 1
            }
            if secondsRemaining == 0 {
                isTimerRunning = false
            }
        }
    }

    func filterDanceGames(
        games: [DanceGame],
        category: DanceGameCategory?,
        energy: DanceGameEnergy?
    ) -> [DanceGame] {
        var matchingGames: [DanceGame] = []

        // Check each activity against both of the saved filters.
        for game in games {
            var matchesCategory: Bool = false
            if category == nil {
                matchesCategory = true
            } else if game.category == category {
                matchesCategory = true
            }

            var matchesEnergy: Bool = false
            if energy == nil {
                matchesEnergy = true
            } else if game.energy == energy {
                matchesEnergy = true
            }

            if matchesCategory && matchesEnergy {
                matchingGames.append(game)
            }
        }

        return matchingGames
    }

    private func game(withID id: UUID) -> DanceGame? {
        for game in games {
            if game.id == id {
                return game
            }
        }

        return nil
    }
}

// ============================================================
// File: MyCreateTask/ViewModels/LearningAssistantViewModel.swift
// ============================================================
//
//  LearningAssistantViewModel.swift
//  MyCreateTask
//
//  Created on 2026-11-11.
//  AI Acknowledgment: GitHub Copilot was used to assist with SwiftUI implementation, refactoring, and debugging. All code behavior and outputs were reviewed and verified by the student.
//

import Foundation
import Observation

@Observable
final class LearningAssistantViewModel {

    // MARK: - Stored properties

    // These lists hold every question and study concept for the app.
    let allQuestions: [LearningQuestion] = LearningQuestion.sampleQuestions
    let allStudyConcepts: [StudyConcept] = StudyConcept.sampleConcepts

    private(set) var score: Int = 0
    private(set) var currentQuestionIndices: [LearningSubject: Int] = [:]
    private(set) var hasFailedCurrentQuestion: Bool = false
    private(set) var showHint: Bool = false
    private(set) var wrongSelectedOptions: Set<String> = []

    private var completedQuestionIDs: Set<UUID> = []
    private var attemptedIncorrectQuestionIDs: Set<UUID> = []
    private var selectedAnswers: [UUID: String] = [:]

    // MARK: - Initializer

    init() {
        for subject in LearningSubject.allCases {
            currentQuestionIndices[subject] = 0
        }
    }

    // MARK: - Functions

    func questions(for subject: LearningSubject) -> [LearningQuestion] {
        var matchingQuestions: [LearningQuestion] = []

        for question in allQuestions {
            if question.subject == subject {
                matchingQuestions.append(question)
            }
        }

        return matchingQuestions
    }

    func studyConcepts(for subject: LearningSubject) -> [StudyConcept] {
        var matchingConcepts: [StudyConcept] = []

        for concept in allStudyConcepts {
            if concept.subject == subject {
                matchingConcepts.append(concept)
            }
        }

        return matchingConcepts
    }

    func currentQuestion(for subject: LearningSubject) -> LearningQuestion? {
        let subjectQuestions: [LearningQuestion] = questions(for: subject)
        let currentIndex: Int = currentQuestionIndices[subject, default: 0]

        guard subjectQuestions.indices.contains(currentIndex) else {
            return nil
        }

        return subjectQuestions[currentIndex]
    }

    func nextQuestion(for subject: LearningSubject) {
        let subjectQuestions: [LearningQuestion] = questions(for: subject)

        guard !subjectQuestions.isEmpty else {
            return
        }

        let currentIndex: Int = currentQuestionIndices[subject, default: 0]
        let nextIndex: Int = (currentIndex + 1) % subjectQuestions.count
        currentQuestionIndices[subject] = nextIndex
        hasFailedCurrentQuestion = false
        showHint = false
        wrongSelectedOptions = []
        selectedAnswers.removeValue(forKey: subjectQuestions[currentIndex].id)

        let nextQuestionID: UUID = subjectQuestions[nextIndex].id
        selectedAnswers.removeValue(forKey: nextQuestionID)
    }

    func resetForSubjectChange() {
        hasFailedCurrentQuestion = false
        showHint = false
        wrongSelectedOptions = []
    }

    func tryAgain(for question: LearningQuestion) {
        selectedAnswers.removeValue(forKey: question.id)
        wrongSelectedOptions = []
        hasFailedCurrentQuestion = false
        showHint = false
    }

    func selectedAnswer(for question: LearningQuestion) -> String? {
        selectedAnswers[question.id]
    }

    @discardableResult
    func submit(answer: String, for question: LearningQuestion) -> Bool {
        selectedAnswers[question.id] = answer

        let normalizedAnswer: String = normalize(answer)
        let normalizedCorrectAnswer: String = normalize(question.correctAnswer)
        let isCorrect: Bool = checkQuizAnswer(
            selectedOption: normalizedAnswer,
            correctOption: normalizedCorrectAnswer
        )

        if !isCorrect {
            hasFailedCurrentQuestion = true
            wrongSelectedOptions.insert(answer)
            attemptedIncorrectQuestionIDs.insert(question.id)
        }

        if isCorrect && !completedQuestionIDs.contains(question.id) {
            completedQuestionIDs.insert(question.id)
            let wasAttemptedIncorrectly: Bool =
                attemptedIncorrectQuestionIDs.contains(question.id)
            score += calculateQuizPoints(wasAttemptedIncorrectly: wasAttemptedIncorrectly)
            hasFailedCurrentQuestion = false
            wrongSelectedOptions = []
        }

        return isCorrect
    }

    func isCorrect(answer: String?, for question: LearningQuestion) -> Bool {
        guard let answer else {
            return false
        }

        return normalize(answer) == normalize(question.correctAnswer)
    }

    func toggleHint() {
        showHint.toggle()
    }

    // MARK: - Helper functions

    func checkQuizAnswer(selectedOption: String, correctOption: String) -> Bool {
        // Normalize both answers before comparing them.
        let selectedAnswer: String = normalize(selectedOption)
        let correctAnswer: String = normalize(correctOption)

        if selectedAnswer == correctAnswer {
            return true
        } else {
            return false
        }
    }

    private func calculateQuizPoints(wasAttemptedIncorrectly: Bool) -> Int {
        // First-try answers earn ten points; later answers earn five points.
        if wasAttemptedIncorrectly {
            return 5
        } else {
            return 10
        }
    }

    private func normalize(_ answer: String) -> String {
        answer.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

// ============================================================
// File: MyCreateTask/ViewModels/ReadingHelperViewModel.swift
// ============================================================
//
//  ReadingHelperViewModel.swift
//  MyCreateTask
//
//  Created on 2026-11-11.
//  AI Acknowledgment: GitHub Copilot was used to assist with SwiftUI implementation, refactoring, and debugging. All code behavior and outputs were reviewed and verified by the student.
//

import Foundation
import Observation

enum ReadingLevelFilter: String, CaseIterable, Identifiable {
    case all = "All Levels"
    case level1 = "Level 1"
    case level2 = "Level 2"
    case level3 = "Level 3"

    var id: String {
        rawValue
    }

    var level: Int? {
        switch self {
        case .all:
            return nil
        case .level1:
            return 1
        case .level2:
            return 2
        case .level3:
            return 3
        }
    }
}
 
enum ReadingTimeFilter: String, CaseIterable, Identifiable {
    case all = "All Times"
    case short = "2–3 min"
    case medium = "4–5 min"

    var id: String {
        rawValue
    }

    func matches(_ readingTime: Int) -> Bool {
        switch self {
        case .all:
            return true
        case .short:
            return readingTime >= 2 && readingTime <= 3
        case .medium:
            return readingTime >= 4 && readingTime <= 5
        }
    }
}

@Observable
final class ReadingHelperViewModel {

    // MARK: - Stored properties

    // This list is the source of truth for all vocabulary words and passages.
    private let readingItems: [ReadingItem] = ReadingItem.sampleItems
    var selectedType: ReadingItemType = .vocabulary
    var selectedPartOfSpeech: ReadingPartOfSpeech?
    var selectedPassageCategory: String?
    var selectedPassageLevel: ReadingLevelFilter = .all
    var selectedPassageTime: ReadingTimeFilter = .all
    // These sets remember which cards have been revealed or mastered.
    private(set) var revealedVocabularyIDs: Set<UUID> = []
    private(set) var masteredVocabularyIDs: Set<UUID> = []

    // MARK: - Computed properties

    var vocabularyItems: [ReadingItem] {
        // Send the saved filters to the clear loop-based filtering function.
        filterVocabulary(
            readingItems: readingItems,
            selectedPartOfSpeech: selectedPartOfSpeech
        )
    }

    var passageItems: [ReadingItem] {
        // Send the saved category, level, and time choices to the passage filter.
        filterPassages(
            readingItems: readingItems,
            category: selectedPassageCategory,
            level: selectedPassageLevel.level,
            timeRange: selectedPassageTime
        )
    }

    var masteredVocabularyCount: Int {
        countMasteredVocabulary(
            readingItems: readingItems,
            masteredVocabularyIDs: masteredVocabularyIDs
        )
    }

    var totalVocabularyCount: Int {
        countVocabularyItems(readingItems: readingItems)
    }

    // MARK: - Functions

    func toggleVocabularyReveal(_ item: ReadingItem) {
        if revealedVocabularyIDs.contains(item.id) {
            revealedVocabularyIDs.remove(item.id)
        } else {
            revealedVocabularyIDs.insert(item.id)
        }
    }

    func isVocabularyRevealed(_ item: ReadingItem) -> Bool {
        revealedVocabularyIDs.contains(item.id)
    }

    func revealVocabulary(_ item: ReadingItem) {
        revealedVocabularyIDs.insert(item.id)
    }

    func toggleVocabularyMastered(_ item: ReadingItem) {
        if masteredVocabularyIDs.contains(item.id) {
            masteredVocabularyIDs.remove(item.id)
        } else {
            masteredVocabularyIDs.insert(item.id)
        }
    }

    func isVocabularyMastered(_ item: ReadingItem) -> Bool {
        masteredVocabularyIDs.contains(item.id)
    }

    // MARK: - Helper functions

    private func filterVocabulary(
        readingItems: [ReadingItem],
        selectedPartOfSpeech: ReadingPartOfSpeech?
    ) -> [ReadingItem] {
        var matchingItems: [ReadingItem] = []

        // Check each reading item one at a time.
        for item in readingItems {
            if item.type != .vocabulary {
                continue
            }

            // A nil part of speech means that All is selected.
            if selectedPartOfSpeech == nil {
                matchingItems.append(item)
            } else if item.partOfSpeech == selectedPartOfSpeech {
                matchingItems.append(item)
            }
        }

        return matchingItems
    }

    func filterPassages(
        readingItems: [ReadingItem],
        category: String?,
        level: Int?,
        timeRange: ReadingTimeFilter
    ) -> [ReadingItem] {
        var matchingItems: [ReadingItem] = []

        // Check every reading item against the three saved passage filters.
        for item in readingItems {
            if item.type != .passage {
                continue
            }

            if category != nil {
                if item.category != category {
                    continue
                }
            }

            if level != nil {
                if item.readingLevel != level {
                    continue
                }
            }

            let readingTime: Int = item.readingTime ?? 0
            if timeRange.matches(readingTime) {
                matchingItems.append(item)
            }
        }

        return matchingItems
    }

    private func countVocabularyItems(readingItems: [ReadingItem]) -> Int {
        var count: Int = 0

        // Count vocabulary items only, so the interface has an accurate total.
        for item in readingItems {
            if item.type == .vocabulary {
                count += 1
            }
        }

        return count
    }

    private func countMasteredVocabulary(
        readingItems: [ReadingItem],
        masteredVocabularyIDs: Set<UUID>
    ) -> Int {
        var count: Int = 0

        // Count only vocabulary cards that the student marked mastered.
        for item in readingItems {
            if item.type == .vocabulary {
                if masteredVocabularyIDs.contains(item.id) {
                    count += 1
                }
            }
        }

        return count
    }
}

// ============================================================
// File: MyCreateTask/ViewModels/RecessGameViewModel.swift
// ============================================================
//
//  RecessGameViewModel.swift
//  MyCreateTask
//
//  Created on 2026-11-10.
//  AI Acknowledgment: GitHub Copilot was used to assist with SwiftUI implementation, refactoring, and debugging. All code behavior and outputs were reviewed and verified by the student.
//

import Foundation
import Observation

enum RecessPlayerFilter: String, CaseIterable, Identifiable {
    case any = "Any"
    case small = "2–4 Players"
    case medium = "5–8 Players"
    case large = "8+ Players"

    var id: String {
        rawValue
    }
}

@Observable
final class RecessGameViewModel {

    // MARK: - Stored properties

    let allRecessGames: [RecessGame] = RecessGame.sampleGames
    var selectedPlayerFilter: RecessPlayerFilter = .any
    var searchText: String = ""
    private(set) var selectedCategory: String?

    // MARK: - Computed properties

    var categories: [String] {
        var gameCategories: [String] = ["All"]

        for game in allRecessGames {
            if !gameCategories.contains(game.category) {
                gameCategories.append(game.category)
            }
        }

        return gameCategories
    }

    var filteredGames: [RecessGame] {
        filterRecessGames(
            games: allRecessGames,
            playerFilter: selectedPlayerFilter,
            category: selectedCategory,
            searchText: searchText
        )
    }

    // MARK: - Functions

    func selectCategory(_ category: String) {
        if category == "All" {
            selectedCategory = nil
        } else {
            selectedCategory = category
        }
    }

    func filterRecessGames(
        games: [RecessGame],
        playerFilter: RecessPlayerFilter,
        category: String?,
        searchText: String
    ) -> [RecessGame] {
        var matchingGames: [RecessGame] = []
        let searchTerm: String = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        for game in games {
            let matchesPlayers: Bool = recessGameMatches(
                game: game,
                playerFilter: playerFilter
            )

            var matchesCategory: Bool = false
            if category == nil {
                matchesCategory = true
            } else if game.category == category {
                matchesCategory = true
            }

            var matchesSearchText: Bool = false
            if searchTerm.isEmpty {
                matchesSearchText = true
            } else if game.name.localizedCaseInsensitiveContains(searchTerm)
                || game.summary.localizedCaseInsensitiveContains(searchTerm) {
                matchesSearchText = true
            } else {
                matchesSearchText = false
            }

            if matchesPlayers && matchesCategory && matchesSearchText {
                matchingGames.append(game)
            }
        }

        return matchingGames
    }

    private func recessGameMatches(
        game: RecessGame,
        playerFilter: RecessPlayerFilter
    ) -> Bool {
        switch playerFilter {
        case .any:
            return true
        case .small:
            if game.minPlayers <= 4 && game.maxPlayers >= 2 {
                return true
            } else {
                return false
            }
        case .medium:
            if game.minPlayers <= 8 && game.maxPlayers >= 5 {
                return true
            } else {
                return false
            }
        case .large:
            if game.maxPlayers >= 8 {
                return true
            } else {
                return false
            }
        }
    }
}

// ============================================================
// File: MyCreateTask/Views/DailyChecklistView.swift
// ============================================================
//
//  DailyChecklistView.swift
//  MyCreateTask
//
//  Created on 2026-11-10.
//  AI Acknowledgment: GitHub Copilot was used to assist with SwiftUI implementation, refactoring, and debugging. All code behavior and outputs were reviewed and verified by the student.
//

import SwiftUI

struct DailyChecklistView: View {

    // MARK: - Stored properties

    @State private var viewModel = DailyChecklistViewModel()
    @State private var newTaskTitle: String = ""

    // MARK: - Computed properties

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                dailyChecklistHeader
                customTaskInput
                progressSummaryCard
                taskContentSection
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 28)
            .padding(.top, 16)
            .padding(.bottom, 16)
            .fontDesign(.rounded)
        }
        .navigationTitle("Daily Checklist")
    }

    // MARK: - Views

    // This header explains the purpose of the checklist.
    private var dailyChecklistHeader: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Daily Checklist")
                .font(.largeTitle.weight(.bold))

            Text("Plan today's tasks and celebrate completed work.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    // This section chooses between the empty state and the task cards.
    @ViewBuilder
    private var taskContentSection: some View {
        if viewModel.tasks.isEmpty {
            emptyState
        } else {
            taskGrid
        }
    }

    private var progressSummaryCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(viewModel.completedTaskCount) of \(viewModel.tasks.count) Completed")
                        .font(.title2.weight(.bold))

                    Text(progressSubtitle)
                        .font(.subheadline)
                        .foregroundStyle(.primary.opacity(0.88))
                }

                Spacer()

                Text("\(completionPercentage)%")
                    .font(.headline.weight(.bold))
                    .foregroundStyle(.green)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(.green.opacity(0.14), in: Capsule())
            }

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(.green.opacity(0.14))

                    Capsule()
                        .fill(.green)
                        .frame(
                            width: geometry.size.width * viewModel.completionProgress
                        )
                }
            }
            .frame(height: 14)
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Completion progress")
            .accessibilityValue("\(completionPercentage) percent")

            HStack(spacing: 10) {
                Button("Clear Completed", systemImage: "checkmark.circle") {
                    viewModel.clearCompletedTasks()
                }
                .buttonStyle(.bordered)
                .disabled(viewModel.completedTaskCount == 0)

                Button("Load Daily Tasks", systemImage: "arrow.clockwise") {
                    viewModel.resetDefaults()
                }
                .buttonStyle(.bordered)
            }
        }
        .padding(18)
        .background(.green.opacity(0.08), in: RoundedRectangle(cornerRadius: 18))
        .overlay {
            RoundedRectangle(cornerRadius: 18)
                .stroke(.green.opacity(0.2), lineWidth: 1)
        }
    }

    private var customTaskInput: some View {
        HStack(spacing: 10) {
            TextField("Type a new task...", text: $newTaskTitle)
                .textFieldStyle(.plain)
                .onSubmit {
                    addCustomTask(title: newTaskTitle)
                }

            Button("Add Task") {
                addCustomTask(title: newTaskTitle)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
        }
        .padding(12)
        .background(
            Color.primary.opacity(0.04),
            in: RoundedRectangle(cornerRadius: 16)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(.secondary.opacity(0.12), lineWidth: 1)
        }
    }

    private var taskGrid: some View {
        LazyVGrid(
            columns: [
                GridItem(.flexible(), spacing: 14),
                GridItem(.flexible(), spacing: 14)
            ],
            spacing: 14
        ) {
            ForEach(viewModel.tasks) { task in
                taskCard(for: task)
            }
        }
    }

    private func taskCard(for task: DailyTask) -> some View {
        HStack(spacing: 10) {
            Button {
                viewModel.toggleTask(task)
            } label: {
                HStack(spacing: 10) {
                    Image(
                        systemName: task.isCompleted
                            ? "checkmark.circle.fill"
                            : "circle"
                    )
                    .font(.title3)
                    .foregroundStyle(task.isCompleted ? .green : .secondary)

                    Text(task.title)
                        .font(.body.weight(.medium))
                        .foregroundStyle(
                            task.isCompleted ? .secondary : .primary
                        )
                        .strikethrough(task.isCompleted)
                        .multilineTextAlignment(.leading)

                    Spacer(minLength: 0)
                }
                .frame(maxWidth: .infinity, minHeight: 52, alignment: .leading)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

            Button("Delete", systemImage: "trash") {
                viewModel.delete(task)
            }
            .labelStyle(.iconOnly)
            .foregroundStyle(.red)
            .help("Delete \(task.title)")
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(
            task.isCompleted
                ? Color.green.opacity(0.1)
                : Color.blue.opacity(0.08),
            in: RoundedRectangle(cornerRadius: 16)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    task.isCompleted
                        ? Color.green.opacity(0.22)
                        : Color.blue.opacity(0.14),
                    lineWidth: 1
                )
        }
    }

    private var emptyState: some View {
        VStack(spacing: 10) {
            Image(systemName: "checkmark.seal")
                .font(.system(size: 38))
                .foregroundStyle(.green)

            Text("All clear!")
                .font(.title2.weight(.bold))

            Text("Add a new task or load today's daily tasks to keep your day on track.")
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            Button("Load Daily Tasks", systemImage: "checklist") {
                viewModel.resetDefaults()
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity)
        .padding(32)
        .background(.green.opacity(0.08), in: RoundedRectangle(cornerRadius: 18))
    }

    // MARK: - Functions

    private var completionPercentage: Int {
        Int((viewModel.completionProgress * 100).rounded())
    }

    private var progressSubtitle: String {
        let totalTasks: Int = viewModel.tasks.count
        let completedTasks: Int = viewModel.completedTaskCount

        if totalTasks > 0 && completedTasks == totalTasks {
            return "All tasks complete! Great job!"
        }

        if totalTasks == 0 {
            return "Add a task to get started."
        }

        return "Keep going—you are building great habits!"
    }

    private func addCustomTask(title: String) {
        let trimmedTitle: String = title.trimmingCharacters(in: .whitespacesAndNewlines)

        if !trimmedTitle.isEmpty {
            viewModel.addTask(title: trimmedTitle)
            newTaskTitle = ""
        } else {
            newTaskTitle = ""
        }
    }
}

#Preview {
    NavigationStack {
        DailyChecklistView()
    }
}

// ============================================================
// File: MyCreateTask/Views/DanceGamesView.swift
// ============================================================
//
//  DanceGamesView.swift
//  MyCreateTask
//
//  Created on 2026-11-10.
//  AI Acknowledgment: GitHub Copilot was used to assist with SwiftUI implementation, refactoring, and debugging. All code behavior and outputs were reviewed and verified by the student.
//

import SwiftUI
import Combine

struct DanceGamesView: View {

    // MARK: - Stored properties

    @State private var viewModel = DanceGamesViewModel()
    // This optional value holds the activity chosen by the random button.
    @State private var randomlySelectedGame: DanceGame?

    // MARK: - Computed properties

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                danceGamesHeader
                controlBar
                danceActivitiesSection
            }
            .padding(.horizontal, 28)
            .padding(.top, 16)
            .padding(.bottom, 16)
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .fontDesign(.rounded)
        .navigationTitle("Dance Games")
        .navigationDestination(item: $randomlySelectedGame) { game in
            DanceGameDetailView(game: game, viewModel: viewModel)
        }
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
            viewModel.tickTimer()
        }
    }

    // MARK: - Views

    // This header introduces the Dance Games screen.
    private var danceGamesHeader: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Dance Games")
                .font(.largeTitle.weight(.bold))

            Text("Choose a movement game for a group.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    // This section shows an empty state or the filtered activity cards.
    @ViewBuilder
    private var danceActivitiesSection: some View {
        if viewModel.filteredGames.isEmpty {
            VStack(spacing: 8) {
                Image(systemName: "music.note")
                    .font(.title)
                    .foregroundStyle(.secondary)

                Text("No activities match the selected category and energy level.")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, minHeight: 180)
        } else {
            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: 12),
                    GridItem(.flexible(), spacing: 12)
                ],
                spacing: 12
            ) {
                ForEach(viewModel.filteredGames) { game in
                    NavigationLink {
                        DanceGameDetailView(game: game, viewModel: viewModel)
                    } label: {
                        danceCard(game)
                    }
                    .buttonStyle(.plain)
                    .contentShape(Rectangle())
                }
            }
        }
    }

    private var controlBar: some View {
        HStack(alignment: .bottom, spacing: 16) {
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 8) {
                    Text("Category:")
                        .font(.subheadline.weight(.bold))
                        .foregroundStyle(.secondary)

                    categoryPill(title: "All", category: nil)
                    ForEach(DanceGameCategory.allCases) { category in
                        categoryPill(title: category.rawValue, category: category)
                    }
                }

                HStack(spacing: 8) {
                    Text("Energy:")
                        .font(.subheadline.weight(.bold))
                        .foregroundStyle(.secondary)

                    energyPill(title: "All", energy: nil)
                    energyPill(title: "Low", energy: .low)
                    energyPill(title: "Medium", energy: .medium)
                    energyPill(title: "High", energy: .high)
                }
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 8) {
                Text("\(viewModel.filteredGames.count) Activities")
                    .font(.caption.weight(.bold))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 7)
                    .background(.blue.opacity(0.12))
                    .foregroundStyle(.blue)
                    .clipShape(Capsule())

                Button("Random Activity", systemImage: "shuffle") {
                    randomlySelectedGame = viewModel.filteredGames.randomElement()
                }
                .buttonStyle(.bordered)
                .controlSize(.small)
                .disabled(viewModel.filteredGames.isEmpty)
                .opacity(viewModel.filteredGames.isEmpty ? 0.5 : 1.0)
            }
        }
    }

    private func categoryPill(title: String, category: DanceGameCategory?) -> some View {
        let isSelected = viewModel.selectedCategory == category

        return Button {
            viewModel.selectedCategory = category
        } label: {
            Text(title)
                .font(.subheadline.weight(.bold))
                .foregroundStyle(isSelected ? .white : .primary)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .frame(minHeight: 34)
                .background(isSelected ? .blue : Color.primary.opacity(0.06), in: Capsule())
        }
        .buttonStyle(.plain)
        .clipShape(Capsule())
    }

    private func energyPill(title: String, energy: DanceGameEnergy?) -> some View {
        let isSelected = viewModel.selectedEnergy == energy

        return Button {
            viewModel.selectedEnergy = energy
        } label: {
            Text(title)
                .font(.subheadline.weight(.bold))
                .foregroundStyle(isSelected ? .white : .primary)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .frame(minHeight: 34)
                .background(isSelected ? .orange : Color.primary.opacity(0.06), in: Capsule())
        }
        .buttonStyle(.plain)
        .clipShape(Capsule())
    }

    private func danceCard(_ game: DanceGame) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top, spacing: 8) {
                Text(game.name)
                    .font(.headline)
                    .fixedSize(horizontal: false, vertical: true)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.secondary)
            }

            HStack(spacing: 6) {
                Text(game.category.rawValue)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.cyan)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .background(.blue.opacity(0.28), in: Capsule())

                Text(shortEnergyName(game.energy))
                    .font(.caption2.weight(.bold))
                    .foregroundStyle(.orange)
                    .padding(.horizontal, 7)
                    .padding(.vertical, 5)
                    .background(.orange.opacity(0.15), in: Capsule())
            }

            Text(game.description)
                .font(.subheadline)
                .foregroundStyle(.primary.opacity(0.88))
                .fixedSize(horizontal: false, vertical: true)

            HStack(spacing: 8) {
                Label("\(game.duration) sec", systemImage: "clock.fill")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.blue)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .background(.blue.opacity(0.13), in: Capsule())

                Label(game.groupSize, systemImage: "person.2")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 128, alignment: .topLeading)
        .padding(12)
        .background(.quaternary.opacity(0.7), in: RoundedRectangle(cornerRadius: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(.secondary.opacity(0.12), lineWidth: 1)
        }
    }

    private func shortEnergyName(_ energy: DanceGameEnergy) -> String {
        switch energy {
        case .low:
            return "Low"
        case .medium:
            return "Medium"
        case .high:
            return "High"
        }
    }

    struct DanceGameDetailView: View {

        // MARK: - Stored properties

        let game: DanceGame
        let viewModel: DanceGamesViewModel

        // MARK: - Computed properties

        var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(game.name)
                        .font(.largeTitle.weight(.bold))

                    HStack(spacing: 6) {
                        badge(game.category.rawValue, tint: .blue)
                        badge(shortEnergyName(game.energy), tint: .orange)
                    }

                    Text(game.description)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }

                HStack(spacing: 12) {
                    statCard(title: "Duration", value: "\(game.duration) sec", icon: "clock")
                    statCard(title: "Players", value: game.groupSize, icon: "person.2")
                    statCard(title: "Energy Level", value: shortEnergyName(game.energy), icon: "bolt")
                }
                .frame(height: 78)

                HStack(alignment: .top, spacing: 20) {
                    howToPlayCard
                        .frame(maxWidth: .infinity, alignment: .topLeading)

                    VStack(alignment: .leading, spacing: 12) {
                        roundTimerCard
                            .frame(maxWidth: .infinity, alignment: .topLeading)

                        classroomTipCard
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.horizontal, 28)
            .padding(.top, 16)
            .padding(.bottom, 16)
            .fontDesign(.rounded)
            .navigationTitle(game.name)
            .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
                viewModel.tickTimer()
            }
        }

        // MARK: - Views

        private func statCard(title: String, value: String, icon: String) -> some View {
            VStack(alignment: .leading, spacing: 6) {
                Label(title, systemImage: icon)
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.secondary)

                Text(value)
                    .font(.title3.bold())
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(12)
            .background(.quaternary.opacity(0.7), in: RoundedRectangle(cornerRadius: 12))
        }

        private var howToPlayCard: some View {
            VStack(alignment: .leading, spacing: 16) {
                Label("How to Play", systemImage: "list.number")
                    .font(.headline)
                    .foregroundStyle(.tint)

                ForEach(Array(game.steps.enumerated()), id: \.offset) { step in
                    HStack(alignment: .top, spacing: 12) {
                        Text("\(step.offset + 1)")
                            .font(.caption.weight(.bold))
                            .foregroundStyle(.primary)
                            .frame(width: 24, height: 24)
                            .background(.tint, in: Circle())

                        Text(step.element)
                            .font(.body)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .padding(20)
            .background(.tint.opacity(0.07), in: RoundedRectangle(cornerRadius: 14))
        }

        private var roundTimerCard: some View {
            VStack(spacing: 10) {
                Label("Round Timer", systemImage: "timer")
                    .font(.headline)

                Text(viewModel.timerText(for: game))
                    .font(.system(size: 56, weight: .bold, design: .rounded))
                    .monospacedDigit()

                if viewModel.isComplete(game) {
                    Text("Time is up!")
                        .font(.subheadline.weight(.bold))
                        .foregroundStyle(.green)
                }

                HStack(spacing: 8) {
                    Button(viewModel.isRunning(game) ? "Pause" : "Start", systemImage: viewModel.isRunning(game) ? "pause.fill" : "play.fill") {
                        if viewModel.isRunning(game) {
                            viewModel.pauseTimer(for: game)
                        } else {
                            viewModel.startTimer(for: game)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.small)

                    Button("Reset", systemImage: "arrow.counterclockwise") {
                        viewModel.resetTimer(for: game)
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.small)
                }
            }
            .frame(maxWidth: .infinity, alignment: .top)
            .padding(16)
            .background(.blue.opacity(0.08), in: RoundedRectangle(cornerRadius: 14))
        }

        private var classroomTipCard: some View {
            HStack(alignment: .top, spacing: 8) {
                Image(systemName: "lightbulb")
                    .foregroundStyle(.orange)

                VStack(alignment: .leading, spacing: 3) {
                    Text("Classroom Tip")
                        .font(.subheadline.weight(.bold))
                    Text(game.classroomTip)
                        .font(.subheadline)
                        .foregroundStyle(.primary.opacity(0.88))
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            .padding(10)
            .background(.orange.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
        }

        private func badge(_ title: String, tint: Color) -> some View {
            Text(title)
                .font(.caption.weight(.semibold))
                .foregroundStyle(tint)
                .padding(.horizontal, 8)
                .padding(.vertical, 5)
                .background(tint.opacity(0.12), in: Capsule())
        }

        private func shortEnergyName(_ energy: DanceGameEnergy) -> String {
            switch energy {
            case .low:
                return "Low"
            case .medium:
                return "Medium"
            case .high:
                return "High"
            }
        }
    }
}

// ============================================================
// File: MyCreateTask/Views/LearningAssistantView.swift
// ============================================================
//
//  LearningAssistantView.swift
//  MyCreateTask
//
//  Created on 2026-11-10.
//  AI Acknowledgment: GitHub Copilot was used to assist with SwiftUI implementation, refactoring, and debugging. All code behavior and outputs were reviewed and verified by the student.
//

import SwiftUI

private enum DraftTool: String, CaseIterable, Identifiable {
    case pen = "Pen"
    case eraser = "Eraser"

    var id: String {
        rawValue
    }
}

private struct DraftStroke: Identifiable {
    let id = UUID()
    var points: [CGPoint]
    let color: Color
    let lineWidth: CGFloat
}

struct LearningAssistantView: View {

    // MARK: - Stored properties

    @State private var viewModel = LearningAssistantViewModel()
    // This value remembers which subject is currently open.
    @State private var selectedSubject: LearningSubject = .math
    @State private var expandedQuestionID: UUID?
    @State private var showingPointsPopover: Bool = false
    @State private var showingDraftSheet: Bool = false
    // The draft arrays store drawn stroke colors and positions.
    @State private var draftStrokes: [DraftStroke] = []
    @State private var draftPenColor: Color = .black
    @State private var draftTool: DraftTool = .pen
    @State private var draftActiveStrokeID: UUID?

    // MARK: - Computed properties

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            learningAssistantHeader
            topBar
            selectedSubjectSection
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.horizontal, 28)
        .padding(.top, 16)
        .padding(.bottom, 16)
        .navigationTitle("Learning Assistant")
        .onChange(of: selectedSubject) {
            viewModel.resetForSubjectChange()
        }
    }

    // This header introduces the Learning Assistant screen.
    private var learningAssistantHeader: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Learning Assistant")
                .font(.largeTitle.bold())

            Text("Practice, explain, and strengthen your understanding.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    // This section selects the header and data for the active subject.
    @ViewBuilder
    private var selectedSubjectSection: some View {
        switch selectedSubject {
        case .math:
            subjectSection(
                title: "Math Workshop",
                subtitle: "Solve math problems and explain your thinking.",
                subject: .math
            )
        case .science:
            subjectSection(
                title: "Science Lab",
                subtitle: "Explore science concepts and test your knowledge.",
                subject: .science
            )
        case .socialStudies:
            subjectSection(
                title: "Social Studies Hub",
                subtitle: "Explore government and geography concepts",
                subject: .socialStudies
            )
        case .english:
            subjectSection(
                title: "English (Grammar)",
                subtitle: "Practice sentence structure, word choice, and grammar.",
                subject: .english
            )
        case .geography:
            subjectSection(
                title: "Geography",
                subtitle: "Explore maps, regions, resources, and human–natural systems.",
                subject: .geography
            )
        }
    }

    private var topBar: some View {
        HStack(spacing: 16) {
            subjectPicker
            Spacer()

            Button {
                showingDraftSheet = true
            } label: {
                Label("Draft", systemImage: "pencil.and.outline")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.primary)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 6)
                    .background(Color.primary.opacity(0.06), in: Capsule())
            }
            .buttonStyle(.plain)
            .sheet(isPresented: $showingDraftSheet) {
                draftSheet
            }

            Button {
                showingPointsPopover = true
            } label: {
                Label("\(viewModel.score) Points", systemImage: "star.fill")
                    .font(.headline)
                    .foregroundStyle(.orange)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 7)
                    .background(.orange.opacity(0.14), in: Capsule())
            }
            .buttonStyle(.plain)
            .popover(isPresented: $showingPointsPopover) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("How Points Work")
                        .font(.headline)

                    Text("You earn +10 points for every question you answer correctly on your first try, and +5 points on a second try!")
                        .font(.body)
                        .foregroundStyle(.primary)
                        .frame(width: 260, alignment: .leading)
                }
                .padding(16)
            }
        }
    }

    private var draftSheet: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Rough Work & Draft Notes")
                        .font(.title2.weight(.bold))

                    Text("Draw calculations, shapes, and ideas.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Button("Done") {
                    showingDraftSheet = false
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }

            if let activeQuestion = viewModel.currentQuestion(for: selectedSubject) {
                HStack(alignment: .top, spacing: 8) {
                    Image(systemName: "questionmark.circle.fill")
                        .foregroundStyle(subjectThemeColor(for: selectedSubject))

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Active Question")
                            .font(.caption.weight(.bold))
                            .foregroundStyle(subjectThemeColor(for: selectedSubject))

                        Text(activeQuestion.questionText)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.primary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(12)
                .background(subjectThemeColor(for: selectedSubject).opacity(0.10), in: RoundedRectangle(cornerRadius: 12))
            }

            HStack(spacing: 8) {
                penColorPill(title: "Black", color: .black)
                penColorPill(title: "Blue", color: .blue)
                penColorPill(title: "Red", color: .red)

                Divider()
                    .frame(height: 28)

                Button {
                    draftTool = .eraser
                } label: {
                    Label("Eraser", systemImage: "eraser")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(draftTool == .eraser ? .white : .primary)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 6)
                        .background(
                            draftTool == .eraser ? Color.orange : Color.primary.opacity(0.06),
                            in: Capsule()
                        )
                }
                .buttonStyle(.plain)

                Spacer()

                Button("Undo", systemImage: "arrow.uturn.backward") {
                    if !draftStrokes.isEmpty {
                        draftStrokes.removeLast()
                    }
                }
                .buttonStyle(.bordered)
                .disabled(draftStrokes.isEmpty)

                Button("Clear", systemImage: "trash") {
                    draftStrokes = []
                    draftActiveStrokeID = nil
                }
                .buttonStyle(.bordered)
                .disabled(draftStrokes.isEmpty)
            }

            Canvas { context, _ in
                for stroke in draftStrokes {
                    guard stroke.points.count > 1 else {
                        continue
                    }

                    var path = Path()
                    path.move(to: stroke.points[0])
                    for point in stroke.points.dropFirst() {
                        path.addLine(to: point)
                    }

                    context.stroke(
                        path,
                        with: .color(stroke.color),
                        style: StrokeStyle(
                            lineWidth: stroke.lineWidth,
                            lineCap: .round,
                            lineJoin: .round
                        )
                    )
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white, in: RoundedRectangle(cornerRadius: 14))
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.secondary.opacity(0.18), lineWidth: 1)
            )
            .contentShape(RoundedRectangle(cornerRadius: 14))
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        if draftTool == .eraser {
                            eraseDraftStroke(at: value.location)
                        } else {
                            if let activeID = draftActiveStrokeID,
                               let strokeIndex = draftStrokes.firstIndex(where: { $0.id == activeID }) {
                                draftStrokes[strokeIndex].points.append(value.location)
                            } else {
                                let stroke = DraftStroke(
                                    points: [value.location],
                                    color: draftPenColor,
                                    lineWidth: 4
                                )
                                draftStrokes.append(stroke)
                                draftActiveStrokeID = stroke.id
                            }
                        }
                    }
                    .onEnded { _ in
                        draftActiveStrokeID = nil
                    }
            )
        }
        .padding(20)
        .frame(minWidth: 650, minHeight: 480)
    }

    private func penColorPill(title: String, color: Color) -> some View {
        let isSelected = draftPenColor == color && draftTool == .pen

        return Button {
            draftPenColor = color
            draftTool = .pen
        } label: {
            Text(title)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(isSelected ? .white : .primary)
                .padding(.horizontal, 14)
                .padding(.vertical, 6)
                .background(isSelected ? color : Color.primary.opacity(0.06), in: Capsule())
        }
        .buttonStyle(.plain)
    }

    private func eraseDraftStroke(at location: CGPoint) {
        var remainingStrokes: [DraftStroke] = []

        // Check each stroke and keep only strokes that the eraser did not touch.
        for stroke in draftStrokes {
            var strokeWasErased: Bool = false

            for point in stroke.points {
                let horizontalDistance = point.x - location.x
                let verticalDistance = point.y - location.y
                let distance = sqrt(
                    (horizontalDistance * horizontalDistance) +
                    (verticalDistance * verticalDistance)
                )
                if distance <= 16 {
                    strokeWasErased = true
                    break
                }
            }

            if !strokeWasErased {
                remainingStrokes.append(stroke)
            }
        }

        draftStrokes = remainingStrokes
    }

    private var subjectPicker: some View {
        HStack(spacing: 6) {
            ForEach(LearningSubject.allCases) { subject in
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selectedSubject = subject
                    }
                } label: {
                    Label {
                        Text(subject.rawValue)
                    } icon: {
                        Image(systemName: subjectTabIcon(for: subject))
                    }
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(
                        selectedSubject == subject
                            ? .white
                            : .primary
                    )
                    .padding(.horizontal, 14)
                    .padding(.vertical, 6)
                    .background {
                        if selectedSubject == subject {
                            Capsule()
                                .fill(subjectThemeColor(for: subject))
                        } else {
                            Capsule()
                                .fill(Color.primary.opacity(0.06))
                        }
                    }
                    .contentShape(Capsule())
                }
                .buttonStyle(.plain)
            }
        }
    }

    private func subjectThemeColor(for subject: LearningSubject) -> Color {
        switch subject {
        case .math:
            return .blue
        case .science:
            return .green
        case .socialStudies:
            return .purple
        case .english:
            return .pink
        case .geography:
            return .orange
        }
    }

    private func subjectTabIcon(for subject: LearningSubject) -> String {
        switch subject {
        case .math:
            "function"
        case .science:
            "atom"
        case .socialStudies:
            "globe.americas.fill"
        case .english:
            "pencil.and.outline"
        case .geography:
            "map"
        }
    }

    private func subjectSection(
        title: String,
        subtitle: String,
        subject: LearningSubject
    ) -> some View {
        let currentQuestion: LearningQuestion? = viewModel.currentQuestion(for: subject)
        let studyConcepts: [StudyConcept] = viewModel.studyConcepts(for: subject)

        return VStack(alignment: .leading, spacing: 20) {
            sectionHeader(title: title, subtitle: subtitle)
            conceptCards(studyConcepts)

            if let quizQuestion = currentQuestion {
                quizCard(for: quizQuestion)
            }
        }
    }

    private func conceptCards(_ concepts: [StudyConcept]) -> some View {
        LazyVGrid(
            columns: Array(
                repeating: GridItem(.flexible(), spacing: 12),
                count: 3
            ),
            spacing: 12
        ) {
            ForEach(concepts) { concept in
                Button {
                    if expandedQuestionID == concept.id {
                        expandedQuestionID = nil
                    } else {
                        expandedQuestionID = concept.id
                    }
                } label: {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(alignment: .top, spacing: 8) {
                            Label {
                                Text(concept.title)
                                    .font(.subheadline.weight(.bold))
                                    .multilineTextAlignment(.leading)
                            } icon: {
                                Image(systemName: concept.subject.icon)
                                    .foregroundStyle(.blue)
                            }

                            Spacer(minLength: 4)

                            Image(
                                systemName: expandedQuestionID == concept.id
                                    ? "chevron.up"
                                    : "chevron.down"
                            )
                            .foregroundStyle(.secondary)
                        }

                        if expandedQuestionID == concept.id {
                            Text(concept.summary)
                                .font(.subheadline)
                                .foregroundStyle(.primary.opacity(0.88))
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
                .buttonStyle(.plain)
                .padding(12)
                .frame(maxWidth: .infinity, minHeight: 82, alignment: .topLeading)
                .background(.blue.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .contentShape(Rectangle())
            }
        }
    }

    private func quizCard(for question: LearningQuestion) -> some View {
        let selectedAnswer: String? = viewModel.selectedAnswer(for: question)

        return VStack(alignment: .leading, spacing: 16) {
            Text("Quick Quiz")
                .font(.title2)
                .bold()

            gardenPerimeterDiagram(for: question)

            Text(question.questionText)
                .font(.title3)
                .foregroundStyle(.primary)

            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: 12),
                    GridItem(.flexible(), spacing: 12)
                ],
                spacing: 12
            ) {
                ForEach(question.options, id: \.self) { option in
                    let isWrongOption: Bool = viewModel.wrongSelectedOptions.contains(option)
                    let isSelectedOption: Bool = selectedAnswer == option

                    Button {
                        viewModel.submit(answer: option, for: question)
                    } label: {
                        HStack {
                            Text(option)
                                .font(.body)
                                .foregroundStyle(.primary)
                                .multilineTextAlignment(.leading)
                            Spacer(minLength: 4)

                            if isWrongOption {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.red)
                            } else if isSelectedOption {
                                Image(
                                    systemName: viewModel.isCorrect(
                                        answer: option,
                                        for: question
                                    )
                                    ? "checkmark.circle.fill"
                                    : "xmark.circle.fill"
                                )
                                .foregroundStyle(
                                    viewModel.isCorrect(
                                        answer: option,
                                        for: question
                                    )
                                    ? .green
                                    : .red
                                )
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 44, alignment: .leading)
                    }
                    .buttonStyle(.bordered)
                    .tint(isWrongOption ? .red : .accentColor)
                    .background(
                        isWrongOption
                            ? Color.red.opacity(0.08)
                            : Color.clear
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .disabled(isWrongOption)
                }
            }

            if let selectedAnswer {
                let isAnswerCorrect: Bool = viewModel.isCorrect(
                    answer: selectedAnswer,
                    for: question
                )

                if isAnswerCorrect {
                    Text("Correct! Nice work.")
                        .font(.body.weight(.semibold))
                        .foregroundStyle(.green)
                    nextQuestionButton(for: question.subject)
                } else if viewModel.hasFailedCurrentQuestion {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Not quite! Give it another try.")
                            .font(.body.weight(.semibold))
                            .foregroundStyle(.orange)

                        HStack(spacing: 8) {
                            Button("Try Again") {
                                viewModel.tryAgain(for: question)
                            }
                            .buttonStyle(.borderedProminent)
                            .controlSize(.large)

                            Button("Need a Hint?") {
                                viewModel.toggleHint()
                            }
                            .buttonStyle(.bordered)
                        }

                        if viewModel.showHint {
                            Text("Hint: \(question.hint)")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.purple.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    @ViewBuilder
    private func gardenPerimeterDiagram(for question: LearningQuestion) -> some View {
        if question.subject == .math &&
            question.questionText ==
            "A rectangular garden is 12 meters long and 8 meters wide. What is its total perimeter?" {
            VStack(spacing: 4) {
                Text("12 m")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.blue)
                    .padding(.horizontal, 8)
                    .background(.white, in: Capsule())

                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(.blue, lineWidth: 2)
                        .frame(width: 180, height: 112)

                    HStack {
                        Spacer()
                        Text("8 m")
                            .font(.caption.weight(.bold))
                            .foregroundStyle(.blue)
                            .padding(.horizontal, 6)
                            .background(.white, in: Capsule())
                            .padding(.trailing, -34)
                    }
                    .frame(width: 180, height: 112)
                }
            }
            .padding(12)
            .frame(maxWidth: .infinity)
            .background(.blue.opacity(0.05), in: RoundedRectangle(cornerRadius: 12))
        }
    }

    private func sectionHeader(title: String, subtitle: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.largeTitle)
                .bold()

            Text(subtitle)
                .font(.title3)
                .foregroundStyle(.secondary)
        }
    }

    private func advanceToNextQuestion(for subject: LearningSubject) {
        viewModel.nextQuestion(for: subject)
        expandedQuestionID = nil
    }

    private func nextQuestionButton(for subject: LearningSubject) -> some View {
        Button("Next Question", systemImage: "arrow.right") {
            advanceToNextQuestion(for: subject)
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    NavigationStack {
        LearningAssistantView()
    }
}

// ============================================================
// File: MyCreateTask/Views/ReadingHelperView.swift
// ============================================================
//
//  ReadingHelperView.swift
//  MyCreateTask
//
//  Created on 2026-11-10.
//  AI Acknowledgment: GitHub Copilot was used to assist with SwiftUI implementation, refactoring, and debugging. All code behavior and outputs were reviewed and verified by the student.
//

import SwiftUI
import Combine

struct ReadingHelperView: View {

    // MARK: - Stored properties

    @State private var viewModel = ReadingHelperViewModel()

    // MARK: - Computed properties

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                readingHelperHeader
                readingTypeSelector
                selectedReadingSection
            }
            .padding(.horizontal, 28)
            .padding(.top, 16)
            .padding(.bottom, 16)
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .fontDesign(.rounded)
        .navigationTitle("Reading Helper")
    }

    // MARK: - Views

    // This header identifies the Reading Helper screen.
    private var readingHelperHeader: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Reading Helper")
                .font(.largeTitle.weight(.bold))

            Text("Vocabulary and reading comprehension")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    // These pills switch between vocabulary cards and reading passages.
    private var readingTypeSelector: some View {
        HStack(spacing: 8) {
            readingTypePill(title: "Vocabulary", type: .vocabulary)
            readingTypePill(title: "Reading Passages", type: .passage)
        }
    }

    // This section displays the selected reading mode.
    @ViewBuilder
    private var selectedReadingSection: some View {
        if viewModel.selectedType == .vocabulary {
            vocabularySection
        } else {
            passageSection
        }
    }

    private var vocabularySection: some View {
        return VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Text("Part of Speech:")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.secondary)

                partOfSpeechPill(title: "All", partOfSpeech: nil)
                ForEach(ReadingPartOfSpeech.allCases) { partOfSpeech in
                    partOfSpeechPill(
                        title: partOfSpeech.rawValue,
                        partOfSpeech: partOfSpeech
                    )
                }

                Spacer()

                Text("\(viewModel.masteredVocabularyCount) of \(viewModel.totalVocabularyCount) Mastered")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.blue)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 7)
                    .background(.blue.opacity(0.12), in: Capsule())

                Button("Random Word", systemImage: "shuffle") {
                    if let randomWord = viewModel.vocabularyItems.randomElement() {
                        viewModel.revealVocabulary(randomWord)
                    }
                }
                .buttonStyle(.bordered)
                .controlSize(.small)
                .disabled(viewModel.vocabularyItems.isEmpty)
            }

            if viewModel.vocabularyItems.isEmpty {
                VStack(spacing: 8) {
                    Image(systemName: "text.book.closed")
                        .font(.title)
                        .foregroundStyle(.secondary)
                    Text("No vocabulary words match this filter.")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, minHeight: 180)
            } else {
                LazyVGrid(
                    columns: [
                        GridItem(.flexible(), spacing: 12),
                        GridItem(.flexible(), spacing: 12),
                        GridItem(.flexible(), spacing: 12)
                    ],
                    spacing: 12
                ) {
                    ForEach(viewModel.vocabularyItems) { item in
                        vocabularyCard(item)
                    }
                }
            }
        }
    }

    private func partOfSpeechPill(
        title: String,
        partOfSpeech: ReadingPartOfSpeech?
    ) -> some View {
        let isSelected = viewModel.selectedPartOfSpeech == partOfSpeech

        return capsuleButton(
            title: title,
            isSelected: isSelected,
            selectedColor: .blue
        ) {
            if viewModel.selectedPartOfSpeech != partOfSpeech {
                viewModel.selectedPartOfSpeech = partOfSpeech
            }
        }
    }

    private func readingTypePill(title: String, type: ReadingItemType) -> some View {
        capsuleButton(
            title: title,
            isSelected: viewModel.selectedType == type,
            selectedColor: .blue
        ) {
            if viewModel.selectedType != type {
                viewModel.selectedType = type
            }
        }
    }

    private func capsuleButton(
        title: String,
        isSelected: Bool,
        selectedColor: Color,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(isSelected ? .white : .primary)
                .padding(.horizontal, 14)
                .padding(.vertical, 6)
                .background(
                    isSelected ? selectedColor : Color.primary.opacity(0.06),
                    in: Capsule()
                )
        }
        .buttonStyle(.plain)
        .clipShape(Capsule())
    }

    private func vocabularyCard(_ item: ReadingItem) -> some View {
        let isRevealed = viewModel.isVocabularyRevealed(item)
        let isMastered = viewModel.isVocabularyMastered(item)
        let definition = item.definition ?? ""
        let exampleSentence = item.exampleSentence ?? ""
        let synonym = item.synonym ?? ""

        return ZStack {
            ZStack(alignment: .topLeading) {
                HStack {
                    Spacer()

                    Button {
                        viewModel.toggleVocabularyMastered(item)
                    } label: {
                        Image(systemName: isMastered ? "checkmark.circle.fill" : "circle")
                            .font(.title3)
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(isMastered ? .green : .secondary)
                    .help(isMastered ? "Mark not mastered" : "Mark mastered")
                }
                .frame(maxWidth: .infinity)

                VStack(alignment: .center, spacing: 8) {
                    Text(item.title)
                        .font(.title2.weight(.bold))
                        .foregroundStyle(.primary)
                        .multilineTextAlignment(.center)

                    vocabularyPartOfSpeechPill(item.partOfSpeech)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                VStack {
                    Spacer()
                    Text("Tap to reveal meaning")
                        .font(.caption2.weight(.semibold))
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(14)
            .background(.quaternary.opacity(0.7), in: RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        isMastered
                            ? Color.green.opacity(0.5)
                            : Color.secondary.opacity(0.12),
                        lineWidth: isMastered ? 1.5 : 1
                    )
            )
            .rotation3DEffect(
                .degrees(isRevealed ? 180 : 0),
                axis: (x: 0, y: 1, z: 0)
            )
            .opacity(isRevealed ? 0 : 1)

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(item.title)
                        .font(.headline.weight(.bold))
                        .foregroundStyle(.primary)

                    Spacer()

                    Button {
                        viewModel.toggleVocabularyMastered(item)
                    } label: {
                        Image(systemName: isMastered ? "checkmark.circle.fill" : "circle")
                            .font(.title3)
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(isMastered ? .green : .secondary)
                    .help(isMastered ? "Mark not mastered" : "Mark mastered")
                }

                Text(definition)
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.primary)
                    .fixedSize(horizontal: false, vertical: true)

                Text("Example:")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.secondary)

                Text(exampleSentence)
                    .font(.caption)
                    .foregroundStyle(.primary)
                    .fixedSize(horizontal: false, vertical: true)

                Text("Synonym: \(synonym)")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.blue)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .background(.blue.opacity(0.14), in: Capsule())

                Spacer()

                Text("Tap to flip back")
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(14)
            .background(.blue.opacity(0.10), in: RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.blue.opacity(0.25), lineWidth: 1)
            )
            .rotation3DEffect(
                .degrees(isRevealed ? 0 : -180),
                axis: (x: 0, y: 1, z: 0)
            )
            .opacity(isRevealed ? 1 : 0)
        }
        .frame(height: 210)
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.35)) {
                viewModel.toggleVocabularyReveal(item)
            }
        }
    }

    private func vocabularyPartOfSpeechPill(_ partOfSpeech: ReadingPartOfSpeech?) -> some View {
        let title = partOfSpeech?.rawValue ?? ""
        let tint: Color

        switch partOfSpeech {
        case .adjective:
            tint = .blue
        case .verb:
            tint = .orange
        case .noun:
            tint = .purple
        case nil:
            tint = .secondary
        }

        return Text(title)
            .font(.caption2.weight(.bold))
            .foregroundStyle(tint)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(tint.opacity(0.14), in: Capsule())
    }

    private func vocabularyDetails(
        definition: String,
        exampleSentence: String,
        synonym: String
    ) -> some View {
        VStack(alignment: .leading, spacing: 7) {
            Text(definition)
                .font(.subheadline)

            Text(exampleSentence)
                .font(.caption)
                .foregroundStyle(.secondary)

            Text("Synonym: \(synonym)")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.blue)
        }
    }

    private func vocabularyMasteryButton(
        item: ReadingItem,
        isMastered: Bool
    ) -> some View {
        if isMastered {
            return AnyView(
                Button("Mastered", systemImage: "checkmark.circle.fill") {
                    viewModel.toggleVocabularyMastered(item)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.small)
            )
        } else {
            return AnyView(
                Button("Mark Mastered", systemImage: "circle") {
                    viewModel.toggleVocabularyMastered(item)
                }
                .buttonStyle(.bordered)
                .controlSize(.small)
            )
        }
    }

    private var passageSection: some View {
        return VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    Text("Category:")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(.secondary)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 6) {
                            passageCategoryPill(title: "All", category: nil)
                            passageCategoryPill(title: "Canadian Nature", category: "Canadian Nature")
                            passageCategoryPill(title: "Science & Inquiry", category: "Science & Inquiry")
                            passageCategoryPill(title: "Community & History", category: "Community & History")
                        }
                    }

                    Spacer()

                    Text("\(viewModel.passageItems.count) Passages")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(.blue)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 7)
                        .background(.blue.opacity(0.12), in: Capsule())
                }

                HStack(spacing: 8) {
                    Text("Level:")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(.secondary)

                    ForEach(ReadingLevelFilter.allCases) { level in
                        passageLevelPill(level)
                    }
                }

                HStack(spacing: 8) {
                    Text("Time:")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(.secondary)

                    ForEach(ReadingTimeFilter.allCases) { time in
                        passageTimePill(time)
                    }
                }
            }

            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: 14),
                    GridItem(.flexible(), spacing: 14)
                ],
                spacing: 14
            ) {
                ForEach(viewModel.passageItems) { passage in
                    NavigationLink {
                        ReadingPassageDetailView(passage: passage)
                    } label: {
                        passageCard(passage)
                    }
                    .buttonStyle(.plain)
                    .contentShape(Rectangle())
                }
            }
        }
    }

    private func passageCategoryPill(
        title: String,
        category: String?
    ) -> some View {
        let isSelected = viewModel.selectedPassageCategory == category

        return capsuleButton(
            title: title,
            isSelected: isSelected,
            selectedColor: .orange
        ) {
            if viewModel.selectedPassageCategory != category {
                viewModel.selectedPassageCategory = category
            }
        }
    }

    private func passageLevelPill(_ level: ReadingLevelFilter) -> some View {
        let isSelected = viewModel.selectedPassageLevel == level

        return capsuleButton(
            title: level.rawValue,
            isSelected: isSelected,
            selectedColor: .purple
        ) {
            viewModel.selectedPassageLevel = level
        }
    }

    private func passageTimePill(_ time: ReadingTimeFilter) -> some View {
        let isSelected = viewModel.selectedPassageTime == time

        return capsuleButton(
            title: time.rawValue,
            isSelected: isSelected,
            selectedColor: .orange
        ) {
            viewModel.selectedPassageTime = time
        }
    }

    private func readingLevelLabel(for passage: ReadingItem) -> String {
        switch passage.readingLevel {
        case 1:
            return "Level 1 • Easy"
        case 2:
            return "Level 2 • Medium"
        case 3:
            return "Level 3 • Advanced"
        default:
            return "Level 1 • Easy"
        }
    }

    private func passageCard(_ passage: ReadingItem) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top, spacing: 8) {
                Text(passage.title)
                    .font(.headline.weight(.bold))

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.secondary)
            }

            HStack(spacing: 6) {
                Text(passage.category ?? "")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.blue)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .background(.blue.opacity(0.14), in: Capsule())

                Text(readingLevelLabel(for: passage))
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.purple)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .background(.purple.opacity(0.14), in: Capsule())
            }

            Text(passage.summary ?? "")
                .font(.subheadline)
                .foregroundStyle(.primary.opacity(0.85))
                .fixedSize(horizontal: false, vertical: true)

            HStack(spacing: 10) {
                Label("\(passage.readingTime ?? 0) min read", systemImage: "clock.fill")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.orange)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .background(.orange.opacity(0.14), in: Capsule())

                Label("\(passage.wordCount ?? 0) words", systemImage: "text.alignleft")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 128, alignment: .topLeading)
        .padding(12)
        .background(.orange.opacity(0.10), in: RoundedRectangle(cornerRadius: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(.secondary.opacity(0.12), lineWidth: 1)
        }
    }
}

struct ReadingPassageDetailView: View {

    // MARK: - Stored properties

    let passage: ReadingItem
    @State private var secondsRemaining: Int
    @State private var isTimerRunning: Bool = false
    @State private var selectedAnswers: [UUID: Int] = [:]

    // MARK: - Initializer

    init(passage: ReadingItem) {
        self.passage = passage
        _secondsRemaining = State(initialValue: (passage.readingTime ?? 4) * 60)
    }

    // MARK: - Computed properties

    var timerText: String {
        let minutes = secondsRemaining / 60
        let seconds = secondsRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    private func readingLevelLabel(for passage: ReadingItem) -> String {
        switch passage.readingLevel {
        case 1:
            return "Level 1 • Easy"
        case 2:
            return "Level 2 • Medium"
        case 3:
            return "Level 3 • Advanced"
        default:
            return "Level 1 • Easy"
        }
    }

    // MARK: - Computed properties

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(passage.title)
                        .font(.largeTitle.weight(.bold))

                    Text(passage.category ?? "")
                        .font(.headline)
                        .foregroundStyle(.blue)

                    HStack(spacing: 6) {
                        Text(readingLevelLabel(for: passage))
                            .font(.caption.weight(.bold))
                            .foregroundStyle(.purple)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 5)
                            .background(.purple.opacity(0.14), in: Capsule())

                        Label("\(passage.readingTime ?? 0) min read", systemImage: "clock.fill")
                            .font(.caption.weight(.bold))
                            .foregroundStyle(.orange)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 5)
                            .background(.orange.opacity(0.14), in: Capsule())
                    }

                    Text(passage.summary ?? "")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }

                HStack(alignment: .top, spacing: 16) {
                    passageColumn
                        .frame(maxWidth: .infinity, alignment: .topLeading)

                    VStack(alignment: .leading, spacing: 12) {
                        readingCheck
                            .frame(maxWidth: .infinity, alignment: .topLeading)

                        timerCard
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                }
            }
            .padding(.horizontal, 28)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .fontDesign(.rounded)
        .navigationTitle(passage.title)
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
            if isTimerRunning && secondsRemaining > 0 {
                secondsRemaining -= 1
            } else if secondsRemaining == 0 {
                isTimerRunning = false
            }
        }
    }

    // MARK: - Views

    private var passageColumn: some View {
        VStack(alignment: .leading, spacing: 14) {
            ForEach(Array(passage.passageParagraphs.enumerated()), id: \.offset) { paragraph in
                Text(paragraph.element)
                    .font(.body)
                    .lineSpacing(6)
                    .foregroundStyle(.primary)
            }

            VStack(alignment: .leading, spacing: 8) {
                Label("Key Vocabulary", systemImage: "text.book.closed")
                    .font(.headline)
                    .foregroundStyle(.blue)

                ForEach(passage.keyVocabulary) { term in
                    VStack(alignment: .leading, spacing: 2) {
                        Text(term.term)
                            .font(.subheadline.weight(.bold))
                        Text(term.meaning)
                            .font(.subheadline)
                            .foregroundStyle(.primary.opacity(0.88))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .padding(14)
            .background(.blue.opacity(0.08), in: RoundedRectangle(cornerRadius: 14))
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding(18)
        .background(.quaternary.opacity(0.55), in: RoundedRectangle(cornerRadius: 16))
    }

    private var readingCheck: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Reading Check", systemImage: "checklist")
                .font(.headline)
                .foregroundStyle(.blue)

            ForEach(passage.questions) { question in
                VStack(alignment: .leading, spacing: 7) {
                    Text(question.prompt)
                        .font(.body.weight(.bold))
                        .foregroundStyle(.primary)
                        .fixedSize(horizontal: false, vertical: true)

                    ForEach(Array(question.options.enumerated()), id: \.offset) { option in
                        Button {
                            selectedAnswers[question.id] = option.offset
                        } label: {
                            HStack {
                                Text(option.element)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            .font(.subheadline)
                            .frame(maxWidth: .infinity)
                            .fixedSize(horizontal: false, vertical: true)
                        }
                        .buttonStyle(.bordered)
                        .controlSize(.small)
                        .tint(optionTint(question: question, optionIndex: option.offset))
                    }

                    if let selectedIndex = selectedAnswers[question.id] {
                        HStack(alignment: .top, spacing: 6) {
                            Image(systemName: selectedIndex == question.correctOptionIndex ? "checkmark.circle.fill" : "exclamationmark.circle.fill")
                                .foregroundStyle(selectedIndex == question.correctOptionIndex ? .green : .orange)
                            Text(question.explanation)
                                .font(.subheadline)
                                .foregroundStyle(.primary.opacity(0.88))
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(.top, 2)
                    }
                }
                .padding(.bottom, 4)
            }
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding(14)
        .background(.green.opacity(0.07), in: RoundedRectangle(cornerRadius: 14))
    }

    private var timerCard: some View {
        VStack(spacing: 8) {
            Label("Reading Timer", systemImage: "timer")
                .font(.headline)

            Text(timerText)
                .font(.system(size: 48, weight: .bold, design: .rounded))
                .monospacedDigit()

            if secondsRemaining == 0 {
                Text("Reading time complete!")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.green)
            }

            HStack(spacing: 8) {
                Button(isTimerRunning ? "Pause" : "Start", systemImage: isTimerRunning ? "pause.fill" : "play.fill") {
                    if secondsRemaining > 0 {
                        isTimerRunning.toggle()
                    }
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.small)

                Button("Reset", systemImage: "arrow.counterclockwise") {
                    secondsRemaining = (passage.readingTime ?? 4) * 60
                    isTimerRunning = false
                }
                .buttonStyle(.bordered)
                .controlSize(.small)
            }
        }
        .frame(maxWidth: .infinity, alignment: .top)
        .padding(14)
        .background(.orange.opacity(0.08), in: RoundedRectangle(cornerRadius: 14))
    }

    private func optionTint(question: ReadingQuestion, optionIndex: Int) -> Color? {
        guard let selectedIndex = selectedAnswers[question.id] else {
            return nil
        }

        if optionIndex == question.correctOptionIndex {
            return .green
        }

        if optionIndex == selectedIndex {
            return .orange
        }

        return nil
    }
}

// ============================================================
// File: MyCreateTask/Views/RecessGameGuideView.swift
// ============================================================
//
//  RecessGameGuideView.swift
//  MyCreateTask
//
//  Created on 2026-11-10.
//  AI Acknowledgment: GitHub Copilot was used to assist with SwiftUI implementation, refactoring, and debugging. All code behavior and outputs were reviewed and verified by the student.
//

import SwiftUI

struct RecessGameGuideView: View {

    // MARK: - Stored properties

    @State private var viewModel = RecessGameViewModel()
    // This optional value stores the game selected by the random button.
    @State private var randomlySelectedGame: RecessGame?

    // MARK: - Computed properties

    var body: some View {
        @Bindable var viewModel = viewModel

        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: 16) {
                header
                searchBar
                controlBar
                gamesGridSection
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .padding(.horizontal, 28)
            .padding(.top, 20)
            .padding(.bottom, 28)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .fontDesign(.rounded)
        .navigationTitle("Recess Game Guide")
        .navigationDestination(item: $randomlySelectedGame) { game in
            RecessGameDetailView(game: game)
        }
    }

    // MARK: - Views

    // This section shows either an empty state or the matching game cards.
    @ViewBuilder
    private var gamesGridSection: some View {
        if viewModel.filteredGames.isEmpty {
            VStack(spacing: 8) {
                Image(systemName: "figure.run")
                    .font(.title)
                    .foregroundStyle(.secondary)

                if viewModel.searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    Text("No games match the selected player count and category.")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                } else {
                    Text("No games match your search")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
            }
            .frame(maxWidth: .infinity, minHeight: 180)
        } else {
            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: 14),
                    GridItem(.flexible(), spacing: 14)
                ],
                spacing: 14
            ) {
                ForEach(viewModel.filteredGames) { game in
                    NavigationLink {
                        RecessGameDetailView(game: game)
                    } label: {
                        gameCard(game)
                    }
                    .buttonStyle(.plain)
                    .contentShape(Rectangle())
                }
            }
            .fixedSize(horizontal: false, vertical: true)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Recess Game Guide")
                .font(.largeTitle.weight(.bold))

            Text("Filter playground games by player count and activity type.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    private var searchBar: some View {
        @Bindable var viewModel = viewModel

        return HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)

            TextField("Search games by keyword...", text: $viewModel.searchText)
                .textFieldStyle(.plain)
                .accessibilityLabel("Search games by keyword")

            if !viewModel.searchText.isEmpty {
                Button("Clear search", systemImage: "xmark.circle.fill") {
                    viewModel.searchText = ""
                }
                .labelStyle(.iconOnly)
                .buttonStyle(.plain)
                .foregroundStyle(.secondary)
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 11)
        .background(.quaternary.opacity(0.7), in: Capsule())
        .overlay {
            Capsule()
                .stroke(.secondary.opacity(0.12), lineWidth: 1)
        }
    }

    private var controlBar: some View {
        @Bindable var viewModel = viewModel

        return HStack(alignment: .bottom, spacing: 12) {
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 8) {
                    Text("Category:")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(.secondary)

                    ForEach(viewModel.categories, id: \.self) { category in
                        categoryPill(
                            title: category,
                            isSelected: isCategorySelected(category)
                        ) {
                            viewModel.selectCategory(category)
                        }
                    }
                }

                HStack(spacing: 8) {
                    Text("Players:")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(.secondary)

                    ForEach(RecessPlayerFilter.allCases) { filter in
                        playerPill(filter)
                    }
                }
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 8) {
                Text("\(viewModel.filteredGames.count) Games")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.blue)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 7)
                    .background(.blue.opacity(0.12), in: Capsule())

                Button("Random Game", systemImage: "shuffle") {
                    randomlySelectedGame = viewModel.filteredGames.randomElement()
                }
                .buttonStyle(.bordered)
                .controlSize(.small)
                .disabled(viewModel.filteredGames.isEmpty)
                .opacity(viewModel.filteredGames.isEmpty ? 0.5 : 1.0)
            }
        }
    }

    private func categoryPill(
        title: String,
        isSelected: Bool,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(isSelected ? .white : .primary)
                .padding(.horizontal, 14)
                .padding(.vertical, 6)
                .background(isSelected ? .purple : Color.primary.opacity(0.06), in: Capsule())
        }
        .buttonStyle(.plain)
        .contentShape(Capsule())
    }

    private func playerPill(_ filter: RecessPlayerFilter) -> some View {
        let isSelected = viewModel.selectedPlayerFilter == filter

        return Button {
            viewModel.selectedPlayerFilter = filter
        } label: {
            Text(filter.rawValue)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(isSelected ? .white : .primary)
                .padding(.horizontal, 14)
                .padding(.vertical, 6)
                .background(isSelected ? .purple : Color.primary.opacity(0.06), in: Capsule())
        }
        .buttonStyle(.plain)
        .clipShape(Capsule())
    }

    private func isCategorySelected(_ category: String) -> Bool {
        if category == "All" {
            return viewModel.selectedCategory == nil
        }

        return viewModel.selectedCategory == category
    }

    private func minimumPlayersText(for game: RecessGame) -> String {
        let playerWord: String = game.minPlayers == 1 ? "player" : "players"
        return "Minimum \(game.minPlayers) \(playerWord)"
    }

    private func gameCard(_ game: RecessGame) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top, spacing: 8) {
                Text(game.name)
                    .font(.headline.weight(.bold))
                    .multilineTextAlignment(.leading)

                Spacer(minLength: 4)

                Image(systemName: "chevron.right")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.secondary)
            }

            Text(game.category)
                .font(.caption.weight(.semibold))
                .foregroundStyle(.tint)
                .padding(.horizontal, 8)
                .padding(.vertical, 5)
                .background(.tint.opacity(0.12), in: Capsule())

            Text(game.summary)
                .font(.subheadline)
                .foregroundStyle(.primary.opacity(0.88))
                .fixedSize(horizontal: false, vertical: true)

            Label(
                minimumPlayersText(for: game),
                systemImage: "person.2"
            )
            .font(.caption.weight(.semibold))
            .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, minHeight: 128, alignment: .topLeading)
        .padding(12)
        .background(.quaternary.opacity(0.7), in: RoundedRectangle(cornerRadius: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(.secondary.opacity(0.12), lineWidth: 1)
        }
    }
}

struct RecessGameDetailView: View {

    // MARK: - Stored properties

    let game: RecessGame

    // MARK: - Computed properties

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 6) {
                Text(game.name)
                    .font(.largeTitle.weight(.bold))

                Text(game.category)
                    .font(.headline)
                    .foregroundStyle(.tint)

                Text(game.summary)
                    .font(.title3)
                    .foregroundStyle(.secondary)
            }

            HStack(spacing: 12) {
                statBadge(title: "Play Area", text: game.playArea, icon: "map")
                statBadge(title: "Goal", text: game.goal, icon: "target")
                statBadge(
                    title: "Minimum Players",
                    text: "\(game.minPlayers)",
                    icon: "person.2"
                )
                statBadge(
                    title: "Duration",
                    text: "\(game.estimatedDuration) min",
                    icon: "clock"
                )
            }
            .frame(height: 112)

            HStack(alignment: .top, spacing: 16) {
                detailSection(title: "Rules", icon: "list.bullet") {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(Array(game.ruleSteps.enumerated()), id: \.offset) { step in
                            HStack(alignment: .top, spacing: 10) {
                                Text("\(step.offset + 1).")
                                    .font(.body.weight(.bold))
                                    .foregroundStyle(.primary)
                                    .frame(width: 24, alignment: .leading)

                                Text(step.element)
                                    .font(.body)
                                    .foregroundStyle(.primary)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)

                VStack(alignment: .leading, spacing: 16) {
                    detailSection(title: "Equipment", icon: "shippingbox") {
                        Text(game.equipment)
                            .font(.body.weight(.semibold))
                            .foregroundStyle(.primary)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 7)
                            .background(.purple.opacity(0.12), in: Capsule())
                    }

                    detailSection(
                        title: "Safety",
                        icon: "checkmark.shield",
                        tint: .orange
                    ) {
                        Text(game.safety)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.horizontal, 28)
        .padding(.top, 16)
        .padding(.bottom, 16)
        .fontDesign(.rounded)
        .navigationTitle(game.name)
    }

    // MARK: - Views

    private func statBadge(title: String, text: String, icon: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Label(title, systemImage: icon)
                .font(.caption.weight(.bold))
                .foregroundStyle(.secondary)

            Text(text)
                .font(.subheadline)
                .foregroundStyle(.primary.opacity(0.88))
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .padding(12)
        .background(.quaternary.opacity(0.7), in: RoundedRectangle(cornerRadius: 12))
    }

    private func detailSection<Content: View>(
        title: String,
        icon: String,
        tint: Color = .accentColor,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Label(title, systemImage: icon)
                .font(.headline)
                .foregroundStyle(tint)

            content()
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(
            tint.opacity(tint == .orange ? 0.12 : 0.07),
            in: RoundedRectangle(cornerRadius: 14)
        )
    }
}

#Preview {
    NavigationStack {
        RecessGameGuideView()
    }
}
