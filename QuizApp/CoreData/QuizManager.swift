//
//  QuizManager.swift
//  QuizApp
//
//  Created by Tamuna Kakhidze on 29.11.24.
//

import CoreData
import UIKit

final class QuizManager {
    
    // MARK: - Properties
    let loginManager = LoginManager.shared
    public static let shared = QuizManager()
    private init() {}
    
    lazy var userName = loginManager.currentUser?.value(
        forKey: "name"
    ) as? String
    
    // MARK: - Save points forKey userName
    func saveQuizPoints(for subject: Subject, points: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        guard let currentUser = loginManager.currentUser else {
            print("No current user found")
            return
        }
        
        var pointsDict = currentUser.value(forKey: "points") as? [String: Int] ?? [:]
        let maxPointForCurrentSubject = pointsDict[subject.subjectTitle] ?? 0
        
        if points > maxPointForCurrentSubject {
            pointsDict[subject.subjectTitle] = points
            
            currentUser.setValue(pointsDict, forKey: "points")
            
            do {
                try managedContext.save()
                print("Points for \(subject.subjectTitle) saved: \(points)")
            } catch let error as NSError {
                print("Could not save points. Error: \(error), \(error.userInfo)")
            }
            
        } else {
            print("Your previous point was higher so current point will not be saved")
        }
    }

}
