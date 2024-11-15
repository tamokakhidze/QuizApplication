//
//  HomeViewModel.swift
//  QuizApp
//
//  Created by Tamuna Kakhidze on 14.11.24.
//

import Foundation

class HomeViewModel {
    
    // MARK: - Properties
    let subjectImages: [String] = ["geographyImage", "programmingImage", "historyImage", "atomImage" ]
    private var gpaScore: Float = 3.45 //Will be calculated later
    
    var gpa: String {
        if gpaScore.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.1f", gpaScore)
        } else {
            return String(format: "%.2f", gpaScore)
        }
    }
    
}
