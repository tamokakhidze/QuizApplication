//
//  DetailsButton.swift
//  QuizApp
//
//  Created by Tamuna Kakhidze on 15.11.24.
//

import UIKit

// MARK: - DetailsButton
final class DetailsButton: UIButton {
    
    // MARK: - UI Components
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = Constants.Sizing.stackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = Constants.Texts.title
        label.font = .systemFont(ofSize: FontSizes.xs)
        label.textColor = CustomColors.neutralWhite
        return label
    }()
    
    private let chevron: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .detailsChevron
            .withRenderingMode(.alwaysOriginal)
        return imageView
    }()
    
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
        setupViewHierarchy()
        setConstraints()
    }
    
    private func setupViewHierarchy() {
        stackView.addArrangedSubviews(
            label,
            chevron
        )
        addSubview(stackView)
    }
    
    private func setAppearance() {
        clipsToBounds = true
        contentHorizontalAlignment = .center
        contentVerticalAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Constraints
    private func setConstraints() {
        NSLayoutConstraint.activate(
            [
                self.widthAnchor.constraint(equalToConstant: Constants.Sizing.width),
                
                stackView.leadingAnchor.constraint(
                    equalTo: leadingAnchor,
                    constant: Constants.Sizing.stackViewSidePadding
                ),
                stackView.trailingAnchor.constraint(
                    equalTo: trailingAnchor,
                    constant: -Constants.Sizing.stackViewSidePadding
                ),
                stackView.topAnchor.constraint(
                    equalTo: topAnchor,
                    constant: Constants.Sizing.stackViewVerticalPadding
                ),
                stackView.bottomAnchor.constraint(
                    equalTo: bottomAnchor,
                    constant: -Constants.Sizing.stackViewVerticalPadding
                )
            ]
        )
    }
}

// MARK: - Constants Extension
extension DetailsButton {
    enum Constants {
        
        enum Texts {
            static let title = "დეტალურად"
        }
        
        enum Sizing {
            static let width: CGFloat = 107
            static let stackViewSpacing: CGFloat = 4
            static let stackViewVerticalPadding: CGFloat = 7
            static let stackViewSidePadding: CGFloat = 10
        }
    }
}
