//
//  YellowRoundedButton.swift
//  QuizApp
//
//  Created by Tamuna Kakhidze on 12.11.24.
//

import UIKit

// MARK: - YellowRoundedButton
class YellowRoundedButton: UIButton {
    
    // MARK: - Init
    init(title: String, width: CGFloat, height: CGFloat, radius: CGFloat, fontSize: CGFloat) {
        super.init(frame: .zero)
        configureTitle(title, fontSize: fontSize)
        setConstraints(width: width, height: height)
        configureAppearance(radius: radius)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configurations
    private func configureTitle(_ title: String, fontSize: CGFloat) {
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: fontSize , weight: .bold)
        self.setTitleColor(.white, for: .normal)
    }
    
    private func configureAppearance(radius: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .yellowPrimary
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        self.contentHorizontalAlignment = .center
        self.contentVerticalAlignment = .center
    }
    
    private func setConstraints(width: CGFloat, height: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: height),
            self.widthAnchor.constraint(equalToConstant: width)
        ])
    }
}
