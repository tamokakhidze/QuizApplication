//
//  PointsDetailsViewModel.swift
//  QuizApp
//
//  Created by Tamuna Kakhidze on 28.11.24.
//

import Foundation

class PointsDetailsViewModel {
    let subjectImages: [String] = ["geographyImage", "programmingImage", "historyImage", "atomImage" ]
    
    var isEmpty: Bool {
        return points?.isEmpty ?? true
    }

    
    let loginManager = LoginManager.shared
    
    var points: [String: Int]?
    
    var pointKeys: [String] {
        return points?.keys.map { $0 } ?? []
    }
    
    var pointValues: [Int] {
        return points?.values.map { $0 } ?? []
    }
    
    func viewDidLoad() {
        points = loginManager.getCurrentUserPoints()
    }
}
