//
//  LoginViewModel.swift
//  QuizApp
//
//  Created by Tamuna Kakhidze on 27.11.24.
//

import Foundation

class LoginViewModel {
    
    // MARK: - Properties
    private let loginManager = LoginManager.shared
    
    private var _userExists: Bool = false
    
    var userExists: Bool {
        return _userExists
    }
    
    var userName: String?
    
    init() {
        userName = loginManager.currentUser?.value(forKey: "name") as? String
    }
    
    // MARK: - Creating User
    func authorizeUser(with name: String) {
        if checkUser(for: name) {
            _userExists = true
            userName = name
            print("User \(name) is authorized")
        } else {
            loginManager.createUser(name: name)
            _userExists = true
            userName = name
            print("User \(name) created and authorized")
        }
    }
    
    // MARK: - Check User
    func checkUser(for name: String) -> Bool {
        return loginManager.checkUser(for: name)
    }
    
    func logOutTapped() {
        _userExists = false
        userName = nil
        print(userName?.debugDescription)
    }
}
