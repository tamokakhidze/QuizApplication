//
//  PopupButton.swift
//  QuizApp
//
//  Created by Tamuna Kakhidze on 18.11.24.
//

import UIKit

final class PopupButton: UIButton {
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configurations
    private func initialize() {
        setAppearance()
        setConstraints()
    }
    
    private func setAppearance() {
        self.backgroundColor = Constants.Colors.backgroundColor
        self.clipsToBounds = true
        self.contentHorizontalAlignment = .center
        self.contentVerticalAlignment = .center
        self.layer.cornerRadius = Constants.Sizing.radius
        self.titleLabel?.font = .systemFont(
            ofSize: Constants.Sizing.medFontSize ,
            weight: .bold
        )
        self.setTitleColor(
            Constants.Colors.neutralDarkGrey,
            for: .normal
        )
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure(title: String) {
        self.setTitle(title, for: .normal)
    }
    
    // MARK: - Constraints
    private func setConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: Constants.Sizing.height),
        ])
    }
}

private extension PopupButton {
    enum Constants {
        enum Sizing {
            static let height: CGFloat = 34
            static let radius: CGFloat = height / 2
            static let medFontSize: CGFloat = 16
        }
        
        enum Colors {
            static let backgroundColor = UIColor.white.withAlphaComponent(0.6)
            static let neutralDarkGrey: UIColor = UIColor(hex: "#1D1D1D")
        }
    }
}
