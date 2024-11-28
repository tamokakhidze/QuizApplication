//
//  PointsVCExtension.swift
//  QuizApp
//
//  Created by Tamuna Kakhidze on 28.11.24.
//

import UIKit
extension PointsDetailsViewController {
    enum Constants {
        enum Sizing {
            static let heightForFooterInSection: CGFloat = 20
            static let tableViewTopAnchor: CGFloat = 49
            static let tableViewSidePadding: CGFloat = 16
            static let tableViewBottomAnchor: CGFloat = 348
                        
            static let separatorBottomAnchor: CGFloat = -50
            static let separatorHeight: CGFloat = 1
            
            static let logoutButtonDimension: CGFloat = 42
            static let logoutButtonAnchor: CGFloat = -5
        }
        
        enum Texts {
            static let navigationLabelText = "დაგროვილი ქულები"
            static let noPointsLabelEmoji = "🧐"
            static let noPointsLabelText = "სამწუხაროდ,\nქულები ჯერ არ გაქვს\n დაგროვილი."
            static let emoji = "★"
        }
        
        enum TableView {
            static let numberOfRowsInSection = 1
            static let numberOfSections = 4
        }
        
        enum Images {
            static let leftArrowImage = UIImage(resource: .leftArrow)
        }
    }
}

