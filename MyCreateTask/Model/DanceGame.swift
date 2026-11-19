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
