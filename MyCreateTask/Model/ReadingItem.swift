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
