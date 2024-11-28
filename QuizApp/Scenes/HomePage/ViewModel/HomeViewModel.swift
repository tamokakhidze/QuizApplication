//
//  HomeViewModel.swift
//  QuizApp
//
//  Created by Tamuna Kakhidze on 14.11.24.
//

import Foundation

final class HomeViewModel {
    
    // MARK: - Properties
    private var gpaScore: Float = 3.45 //Will be calculated later
    
    var gpa: String {
        if gpaScore.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.1f", gpaScore)
        } else {
            return String(format: "%.2f", gpaScore)
        }
    }
    
    let mockSubjects: [Subject] = [
        Subject(
            icon: "geographyImage",
            subjectTitle: "გეოგრაფია",
            quizDescription: "აღწერა",
            quizQuestionCount: 5,
            questions: [
                Question(
                    title: "რომელია მსოფლიოს ყველაზე დიდი კონტინენტი?",
                    options: [
                        Option(title: "აფრიკა", isCorrect: false),
                        Option(title: "აზია", isCorrect: true),
                        Option(title: "სამხრეთ ამერიკა", isCorrect: false),
                        Option(title: "ავსტრალია", isCorrect: false)
                    ],
                    questionIndex: 0
                ),
                Question(
                    title: "რომელია ყველაზე გრძელი მდინარე მსოფლიოში?",
                    options: [
                        Option(title: "ამაზონი", isCorrect: false),
                        Option(title: "ნილოსი", isCorrect: true),
                        Option(title: "მეკონგი", isCorrect: false),
                        Option(title: "დანუბი", isCorrect: false)
                    ],
                    questionIndex: 1
                ),
                Question(
                    title: "რომელია ყველაზე მაღალი მთა მსოფლიოში?",
                    options: [
                        Option(title: "ევერესტი", isCorrect: true),
                        Option(title: "მაკინლი", isCorrect: false),
                        Option(title: "კილიმანჯარო", isCorrect: false),
                        Option(title: "ელბრუსი", isCorrect: false)
                    ],
                    questionIndex: 2
                ),
                Question(
                    title: "რომელ ოკეანეში მდებარეობს ბერმუდის სამკუთხედი?",
                    options: [
                        Option(title: "ატლანტის", isCorrect: true),
                        Option(title: "წყნარი", isCorrect: false),
                        Option(title: "ინდოეთის", isCorrect: false),
                        Option(title: "ჩრდილოეთის", isCorrect: false)
                    ],
                    questionIndex: 3
                ),
                Question(
                    title: "რომელია ყველაზე პატარა ქვეყანა მსოფლიოში?",
                    options: [
                        Option(title: "ვატიკანი", isCorrect: true),
                        Option(title: "მონაკო", isCorrect: false),
                        Option(title: "მალტა", isCorrect: false),
                        Option(title: "ანდორა", isCorrect: false)
                    ],
                    questionIndex: 4
                )
            ]
        ),
        Subject(
            icon: "historyImage",
            subjectTitle: "ისტორია",
            quizDescription: "აღწერა",
            quizQuestionCount: 5,
            questions: [
                Question(
                    title: "რომელ წელს გამოცხადდა საქართველოს დამოუკიდებლობა?",
                    options: [
                        Option(title: "1918", isCorrect: true),
                        Option(title: "1921", isCorrect: false),
                        Option(title: "1991", isCorrect: false),
                        Option(title: "2003", isCorrect: false)
                    ],
                    questionIndex: 0
                ),
                Question(
                    title: "რომელია ძველი ეგვიპტის ყველაზე ცნობილი ფარაონი?",
                    options: [
                        Option(title: "ტუტანჰამონი", isCorrect: true),
                        Option(title: "რამსესი II", isCorrect: false),
                        Option(title: "ქლეოპატრა", isCorrect: false),
                        Option(title: "ხეფრენი", isCorrect: false)
                    ],
                    questionIndex: 1
                ),
                Question(
                    title: "რომელ წელს დაიწყო პირველი მსოფლიო ომი?",
                    options: [
                        Option(title: "1914", isCorrect: true),
                        Option(title: "1918", isCorrect: false),
                        Option(title: "1939", isCorrect: false),
                        Option(title: "1945", isCorrect: false)
                    ],
                    questionIndex: 2
                ),
                Question(
                    title: "რომელი ქალაქი იყო რომის იმპერიის ცენტრი?",
                    options: [
                        Option(title: "რომი", isCorrect: true),
                        Option(title: "კონსტანტინოპოლი", isCorrect: false),
                        Option(title: "პომპეი", isCorrect: false),
                        Option(title: "ალექსანდრია", isCorrect: false)
                    ],
                    questionIndex: 3
                ),
                Question(
                    title: "რომელ წელს აღმოაჩინა ამერიკა ქრისტეფორე კოლუმბმა?",
                    options: [
                        Option(title: "1492", isCorrect: true),
                        Option(title: "1500", isCorrect: false),
                        Option(title: "1485", isCorrect: false),
                        Option(title: "1512", isCorrect: false)
                    ],
                    questionIndex: 4
                )
            ]
        ),
        Subject(
            icon: "atomImage",
            subjectTitle: "ფიზიკა",
            quizDescription: "აღწერა",
            quizQuestionCount: 5,
            questions: [
                Question(
                    title: "რა არის სინათლის სიჩქარე ვაკუუმში?",
                    options: [
                        Option(title: "299,792 კმ/წმ", isCorrect: true),
                        Option(title: "150,000 კმ/წმ", isCorrect: false),
                        Option(title: "100,000 კმ/წმ", isCorrect: false),
                        Option(title: "1,080 კმ/სთ", isCorrect: false)
                    ],
                    questionIndex: 0
                ),
                Question(
                    title: "ვინ შეიმუშავა გრავიტაციის კანონი?",
                    options: [
                        Option(title: "ნიუტონი", isCorrect: true),
                        Option(title: "აინშტაინი", isCorrect: false),
                        Option(title: "გალილეო", isCorrect: false),
                        Option(title: "ფარადეი", isCorrect: false)
                    ],
                    questionIndex: 1
                ),
                Question(
                    title: "რომელია სამყაროს ყველაზე პატარა ნაწილაკი?",
                    options: [
                        Option(title: "ელექტრონი", isCorrect: true),
                        Option(title: "ნეიტრონი", isCorrect: false),
                        Option(title: "ატომი", isCorrect: false),
                        Option(title: "მოლეკულა", isCorrect: false)
                    ],
                    questionIndex: 2
                ),
                Question(
                    title: "რა არის ნიუტონის პირველი კანონი?",
                    options: [
                        Option(title: "ინერციის კანონი", isCorrect: true),
                        Option(title: "ძალის კანონი", isCorrect: false),
                        Option(title: "გრავიტაციის კანონი", isCorrect: false),
                        Option(title: "წინააღმდეგობის კანონი", isCorrect: false)
                    ],
                    questionIndex: 3
                ),
                Question(
                    title: "რომელი გაზი ქმნის მზის ენერგიის წყაროს?",
                    options: [
                        Option(title: "ჰიდროგენი", isCorrect: true),
                        Option(title: "ჟანგბადი", isCorrect: false),
                        Option(title: "ჰელიუმი", isCorrect: false),
                        Option(title: "აზოტი", isCorrect: false)
                    ],
                    questionIndex: 4
                )
            ]
        )
    ]
    
}
