import Foundation

struct RecessGame: Identifiable, Hashable {

    // MARK: - Stored properties

    let id: UUID
    let name: String
    let category: String
    let summary: String
    let minPlayers: Int
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
        self.playArea = playArea
        self.goal = goal
        self.rules = rules
        self.equipment = equipment
        self.safety = safety
    }

    // MARK: - Sample data

    static let sampleGames: [RecessGame] = [
        RecessGame(
            name: "Mr. Wolf",
            category: "Classic Tag Game",
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
            category: "Ball Skill Game",
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
            category: "Chasing Game",
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
            category: "Team Sport",
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
            category: "Coordination Game",
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
            category: "Team Strategy Game",
            summary: "A team game that combines running, strategy, and defending a team flag.",
            minPlayers: 6,
            playArea: "A large, clearly divided playground with one territory for each team.",
            goal: "Bring the other team's flag back to your own territory without being tagged.",
            rules: "Teams protect their own flag while trying to capture the other team's flag. A player who is tagged in the other team's territory follows the agreed-upon jail or restart rule.",
            equipment: "Two flags, cones, and open playground space",
            safety: "Set boundaries away from obstacles, tag gently, and use a no-contact rule near walls or equipment."
        )
    ]
}
