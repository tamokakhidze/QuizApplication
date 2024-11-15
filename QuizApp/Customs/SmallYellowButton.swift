//
//  SmallYellowButton.swift
//  QuizApp
//
//  Created by Tamuna Kakhidze on 14.11.24.
//

import UIKit

class SmallYellowButton: UIButton {
    
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
        self.setImage(.nextButton.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    func configure(image: UIImage) {
        self.setImage(image, for: .normal)
    }
    
}
