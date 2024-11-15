//
//  HomeVCExtension.swift
//  QuizApp
//
//  Created by Tamuna Kakhidze on 15.11.24.
//

import Foundation

extension HomeViewController {
    enum Constants {
        enum Sizing {
            static let tableViewRowHeight: CGFloat = 108
            static let heightForFooterInSection: CGFloat = 20
            static let tableViewTopAnchor: CGFloat = 190
            
            static let mainStackViewSpacing: CGFloat = 20
            static let mainStackViewTopAnchor: CGFloat = 8
            static let mainStackViewSidePadding: CGFloat = 16
            static let mainStackViewBottomAnchor: CGFloat = -81
            
            static let labelForTableHeight: CGFloat = 60
            
            static let numberOfRowsInSection = 1
            
            static let scoreSectionHeight: CGFloat = 75
            
            static let separatorBottomAnchor: CGFloat = -65
            static let separatorHeight: CGFloat = 1
            
            static let logoutButtonDimension: CGFloat = 42
            static let logoutButtonAnchor: CGFloat = -11
        }
        
        enum Texts {
            static let tableViewHeaderLabelText = "აირჩიე საგანი"
            static let greeting = "გამარჯობა, ირაკლი"
        }
        
        enum TableView {
            static let numberOfRowsInSection = 1
            static let numberOfSections = 4
        }
    }
}
