//
//  LearningQuestion.swift
//  MyCreateTask
//
//  Created by Steven Xia on 2026-11-11.
//  This code was generated using GitHub Copilot.
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
