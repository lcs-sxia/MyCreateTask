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

}

extension RecessGame {

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
            playArea: "A flat, open field divided into two team territories with a center line.",
            goal: "Bring the center object back to your team's side without being tagged.",
            rules: "Divide players into two teams and give each player a number. Place an object in the center. The caller announces a number, and the matching players race to the object. A player scores by carrying it home safely, or the other player scores by tagging the carrier before they cross the line.",
            equipment: "One soft object such as a beanbag and boundary cones",
            safety: "Use a soft center object, tag gently below the shoulders, keep the center area clear, and stop if players collide."
        )
    ]
}
