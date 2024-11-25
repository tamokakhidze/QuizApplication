//
//  ConstantsExtension.swift
//  QuizApp
//
//  Created by Tamuna Kakhidze on 18.11.24.
//

import UIKit

extension QuizViewController {
    enum Constants {
        enum Sizing {
            static let tableViewRowHeight: CGFloat = 60
            static let heightForFooterInSection: CGFloat = 12
            static let tableViewTopAnchor: CGFloat = 190
            
            static let mainStackViewSpacing: CGFloat = 32
            static let mainStackViewTopAnchor: CGFloat = 8
            static let mainStackViewSidePadding: CGFloat = 16
            static let mainStackViewBottomAnchor: CGFloat = -115
                        
            static let nextButtonHeight: CGFloat = 60
            static let nextButtonRadius: CGFloat = 22
            static let numberOfRowsInSection = 1
            
            static let scoreSectionHeight: CGFloat = 103
            
            static let separatorBottomAnchor: CGFloat = -65
            static let separatorHeight: CGFloat = 1
            
            static let logoutButtonDimension: CGFloat = 42
            static let logoutButtonAnchor: CGFloat = -11
            
            static let currentPointsStackViewSpacing: CGFloat = 2
            static let progressIndicatorStackViewSpacing: CGFloat = 2
        }
        
        enum Texts {
            static let tableViewHeaderLabelText = "აირჩიე საგანი"
            static let nextButtonTitle = "შემდეგი"
            static let currentPointsLabelText = "მიმდინარე ქულა:"
            static let leaveQuizText = "ნამდვილად გსურს გასვლა?"
        }
        
        enum TableView {
            static let numberOfRowsInSection = 1
            static let numberOfSections = 4
        }
        
        enum Images {
            static let xMark = UIImage(systemName: "xmark")
        }
    }
}
