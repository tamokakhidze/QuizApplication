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
        backgroundColor = Constants.Colors.backgroundColor
        clipsToBounds = true
        layer.cornerRadius = Constants.Sizing.radius
        titleLabel?.font = .systemFont(
            ofSize: Constants.Sizing.medFontSize ,
            weight: .bold
        )
        setTitleColor(
            Constants.Colors.neutralDarkGrey,
            for: .normal
        )
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure(title: String) {
        setTitle(title, for: .normal)
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
