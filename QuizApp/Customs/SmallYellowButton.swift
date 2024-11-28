//
//  SmallYellowButton.swift
//  QuizApp
//
//  Created by Tamuna Kakhidze on 14.11.24.
//

import UIKit

final class SmallYellowButton: UIButton {
    
    // MARK: - Lifecycle
    init() {
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height / 2
    }
    
    // MARK: - Configurations
    private func initialize() {
        setupView()
    }
    
    private func setupView() {
        self.backgroundColor = CustomColors.yellowPrimary
        self.clipsToBounds = true
        self.contentHorizontalAlignment = .center
        self.contentVerticalAlignment = .center
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure(image: UIImage? = nil, text: String? = nil) {
        if let image = image {
            self.setImage(image, for: .normal)
            self.setTitle(nil, for: .normal)
        } else {
            self.setImage(nil, for: .normal)
            self.setTitle(text, for: .normal)
        }
        
        if text != nil {
            self.setTitleColor(.white, for: .normal)
            self.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        } else {
            self.setTitleColor(.clear, for: .normal)
        }
    }
    
}
