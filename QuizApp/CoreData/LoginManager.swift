//
//  LoginManager.swift
//  QuizApp
//
//  Created by Tamuna Kakhidze on 27.11.24.
//

import CoreData
import UIKit

class LoginManager {
    
    // MARK: - Properties
    public static let shared = LoginManager()
    private init() {}
    var currentUser: NSManagedObject?
    
    // MARK: - Methods
    func createUser(name: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let usersEntity = NSEntityDescription.entity(forEntityName: "Users", in: managedContext)!
        
        let user = NSManagedObject(entity: usersEntity, insertInto: managedContext)
        user.setValue(name, forKey: "name")
        user.setValue(["quiz1": 0], forKey: "points")
        
        do {
            try managedContext.save()
            currentUser = user
            print("User \(name) created and set as current user")
        } catch let error as NSError {
            print("Could not save users name. error: \(error), \(error.userInfo)")
        }
    }
    
    func checkUser(for name: String) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Users")
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            if let user = result.first {
                currentUser = user
                print("User \(name) found and set as current user")
                return true
            }
        } catch {
            print("Failed to fetch user with name \(name)")
        }
        
        return false
    }
    
    // MARK: - Get Current User's Data
    func getCurrentUserName() -> String? {
        return currentUser?.value(forKey: "name") as? String
    }
    
    func getCurrentUserPoints() -> [String: Int]? {
        return currentUser?.value(forKey: "points") as? [String: Int]
    }

    
}
