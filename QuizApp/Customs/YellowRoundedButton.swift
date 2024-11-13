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
    init() {
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configurations
    private func initialize() {
        self.backgroundColor = .yellowPrimary
        self.clipsToBounds = true
        self.contentHorizontalAlignment = .center
        self.contentVerticalAlignment = .center
        self.setTitleColor(.white, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure(title: String, width: CGFloat, height: CGFloat, radius: CGFloat, fontSize: CGFloat) {
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: fontSize , weight: .bold)
        self.layer.cornerRadius = radius
        setConstraints(width: width, height: height)
    }
    
    private func setConstraints(width: CGFloat, height: CGFloat) {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: height),
            self.widthAnchor.constraint(equalToConstant: width)
        ])
    }
}
