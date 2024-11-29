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
        layer.cornerRadius = bounds.height / 2
    }
    
    // MARK: - Configurations
    private func initialize() {
        setupView()
    }
    
    private func setupView() {
        backgroundColor = CustomColors.yellowPrimary
        clipsToBounds = true
        contentHorizontalAlignment = .center
        contentVerticalAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure(image: UIImage? = nil, text: String? = nil) {
        if let image = image {
            setImage(image, for: .normal)
            setTitle(nil, for: .normal)
        } else {
            setImage(nil, for: .normal)
            setTitle(text, for: .normal)
        }
        
        if text != nil {
            setTitleColor(.white, for: .normal)
            titleLabel?.font = .systemFont(
                ofSize: FontSizes.med14,
                weight: .bold
            )
        } else {
           setTitleColor(.clear, for: .normal)
        }
    }
    
}
