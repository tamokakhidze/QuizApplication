//
//  LoginVCExtension.swift
//  QuizApp
//
//  Created by Tamuna Kakhidze on 12.11.24.
//

import UIKit

// MARK: - LoginViewController constants extension
extension LoginViewController {
    enum Constants {
        enum Sizing {
            static let blueBackgroundTopAnchor: CGFloat = 0
            static let blueBackgroundHeightMultiplier: CGFloat = 0.5
            static let keyboardAdjustmentOffset: CGFloat = -150
            
            static let labelTopAnchor: CGFloat = 121
            
            static let illustrationTopAnchor: CGFloat = 34
            
            static let startButtonHeight: CGFloat = 44
            static let startButtoRadius: CGFloat = 12
            static let startButtonSidePadding: CGFloat = 117
            static let stackViewTopAnchor: CGFloat = 92
            static let stackViewSpacing: CGFloat = 20
            
            static let inputRadius: CGFloat = 12
            static let inputBorder: CGFloat = 1
            static let inputSidePadding: CGFloat = 54
            static let inputHeight: CGFloat = 44
        }
        
        enum Colors {
            static let buttonColor = UIColor(hex: "#FFC44A")
            static let borderColor = UIColor(hex: "#FFC44A")
            static let neutralWhite: UIColor = .white
            static let neutralGrey = UIColor(hex: "#B3B3B3")
        }
        
        enum Texts {
            static let title = "ჩემი პირველი ქვიზი"
            static let placeholderText = "შეიყვანეთ სახელი"
            static let startButtonTitle = "ქვიზის დაწყება"
        }
    }
}
