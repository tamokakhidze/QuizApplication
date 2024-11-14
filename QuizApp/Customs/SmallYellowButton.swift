//
//  SmallYellowButton.swift
//  QuizApp
//
//  Created by Tamuna Kakhidze on 14.11.24.
//

import UIKit

class SmallYellowButton: UIButton {
    
//    let imageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.tintColor = CustomColors.neutralWhite
//        imageView.clipsToBounds = true
//        return imageView
//    }()
    
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
        setUp()
    }
    
    private func setUp() {
        setupView()
        setupHierarchy()
    }
    
    private func setupView() {
        self.backgroundColor = .yellowPrimary
        self.clipsToBounds = true
        self.contentHorizontalAlignment = .center
        self.contentVerticalAlignment = .center
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setImage(.nextButton, for: .normal)
    }
    
    func configure(
        image: UIImage
    ) {
        let imageToSet = image.withRenderingMode(.alwaysTemplate)
        self.setImage(imageToSet, for: .normal)
        //self.layer.cornerRadius = self.heightAnchor / 2 //whatever the height will be for different screens
        setConstraints()
    }
    
    private func setupHierarchy() {
        //self.addSubview(imageView)
    }
    
    private func setConstraints() {
//        NSLayoutConstraint.activate([
//            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
//        ])
    }
    
}
