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
