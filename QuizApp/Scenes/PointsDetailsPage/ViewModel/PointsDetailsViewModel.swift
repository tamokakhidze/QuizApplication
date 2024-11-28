//
//  PointsDetailsViewModel.swift
//  QuizApp
//
//  Created by Tamuna Kakhidze on 28.11.24.
//

import Foundation

class PointsDetailsViewModel {
    let subjectImages: [String] = ["geographyImage", "programmingImage", "historyImage", "atomImage" ]
    let points : [String : Int] = [
        "Geography" : 3,
        "History" : 5,
        "Programming": 5,
        "Math" : 3
    ]
    var isEmpty: Bool {
        return points.isEmpty
    }
}
