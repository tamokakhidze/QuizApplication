//
//  QuizViewModel.swift
//  QuizApp
//
//  Created by Tamuna Kakhidze on 27.11.24.
//

import Foundation

final class QuizViewModel {
    
    // MARK: - Properties
    private var subject: Subject
    private var currentQuestionIndex = 0
    private var score = 0
    
    var quizTitle: String {
        return subject.subjectTitle
    }
    
    var currentQuestion: Question {
        if currentQuestionIndex < subject.questions.count {
            return subject.questions[currentQuestionIndex]
        } else {
            return Question(
                title: "Default question",
                options: [],
                questionIndex: 0
            )
        }
    }
    
    var totalQuestions: Int {
        return subject.quizQuestionCount
    }
    
    var quizScore: Int {
        return score
    }
    
    // MARK: - Init
    init(subject: Subject) {
        self.subject = subject
    }
    
    // MARK: - Methods for quiz logic
    func increaseScore() {
        score += 1
    }
    
    func updateIndex() {
        if hasNextQuestion() {
            currentQuestionIndex += 1
            print("Current index is: \(currentQuestionIndex)")
        } else {
            print("No more questions!")
        }
    }
    
    func hasNextQuestion() -> Bool {
        return currentQuestionIndex < totalQuestions
    }
    
    func isLastQuestion() -> Bool {
        return currentQuestionIndex == totalQuestions
    }
}
