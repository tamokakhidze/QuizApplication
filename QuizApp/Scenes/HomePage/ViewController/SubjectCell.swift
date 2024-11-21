//
//  SubjectCell.swift
//  QuizApp
//
//  Created by Tamuna Kakhidze on 14.11.24.
//

import UIKit

// MARK: - SubjectCell
final class SubjectCell: UITableViewCell {
    
    //MARK: - Properties
    private let subjectImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = CustomColors.neutralDarkGrey
        label.font = .systemFont(
            ofSize: FontSizes.med,
            weight: .bold
        )
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Texts.descriptionLabelText
        label.textColor = CustomColors.neutralGrey
        label.font = .systemFont(
            ofSize: FontSizes.xs,
            weight: .bold
        )
        return label
    }()
    
    private let nextButton: SmallYellowButton = {
        let button = SmallYellowButton()
        button.configure(image: .nextButton)
        return button
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Constants.Sizing.mainStackViewSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    private let textsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Constants.Sizing.textsStackViewSpacing
        stackView.alignment = .leading
        return stackView
    }()
    
    static let identifier = Constants.Texts.subjectCellIdentifier
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Methods
    private func initialize() {
        setAppearance()
        setupHierarchy()
        setConstraints()
        setCustomSpacing()
    }
    
    private func setAppearance() {
        contentView.layer.cornerRadius = Constants.Sizing.cornerRadius
        contentView.backgroundColor = CustomColors.neutralLighterGrey
        contentView.clipsToBounds = true
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    private func setupHierarchy() {
        sendSubviewToBack(contentView)
        addSubviews(mainStackView)
        textsStackView.addArrangedSubviews(
            titleLabel,
            descriptionLabel
        )
        mainStackView.addArrangedSubviews(
            subjectImage,
            textsStackView,
            nextButton
        )
    }
    
    private func setCustomSpacing() {
        mainStackView.setCustomSpacing(
            Constants.Sizing.customSpacingAfterTexts,
            after: textsStackView
        )
    }
    
    // MARK: - Constraints
    private func setConstraints() {
        NSLayoutConstraint.activate(
            [
                mainStackView.topAnchor.constraint(
                    equalTo: topAnchor,
                    constant: Constants.Sizing.mainStackViewVerticalPadding
                ),
                mainStackView.leadingAnchor.constraint(
                    equalTo: leadingAnchor,
                    constant: Constants.Sizing.mainStackViewSidePadding
                ),
                mainStackView.bottomAnchor.constraint(
                    equalTo: bottomAnchor,
                    constant: -Constants.Sizing.mainStackViewVerticalPadding
                ),
                mainStackView.trailingAnchor.constraint(
                    equalTo: trailingAnchor,
                    constant: -Constants.Sizing.mainStackViewSidePadding
                ),
                
                textsStackView.leadingAnchor.constraint(
                    equalTo: subjectImage.trailingAnchor,
                    constant: Constants.Sizing.textsStackViewLeadingAnchor
                ),
                textsStackView.trailingAnchor.constraint(
                    equalTo: mainStackView.trailingAnchor,
                    constant: Constants.Sizing.textsStackViewTrailingAnchor
                ),
                
                nextButton.topAnchor.constraint(
                    equalTo: mainStackView.topAnchor,
                    constant: Constants.Sizing.nextButtonPadding
                ),
                nextButton.bottomAnchor.constraint(
                    equalTo: mainStackView.bottomAnchor,
                    constant: -Constants.Sizing.nextButtonPadding
                )
            ]
        )
    }
    
    //MARK: - Cell Configuration
    func configureCell(image: UIImage, title: String) {
        subjectImage.image = image
        titleLabel.text = title
    }
}

// MARK: - Constants Extension
extension SubjectCell {
    enum Constants {
        enum Texts {
            static let descriptionLabelText = "აღწერა"
            static let subjectCellIdentifier = "SubjectCell"
        }
        
        enum Sizing {
            static let cornerRadius: CGFloat = 26
            
            static let mainStackViewSpacing: CGFloat = 18
            static let customSpacingAfterTexts: CGFloat = 27
            static let textsStackViewSpacing: CGFloat = 0
            
            static let mainStackViewSidePadding: CGFloat = 29.5
            static let mainStackViewVerticalPadding: CGFloat = 22
            
            static let textsStackViewVerticalPadding: CGFloat = 8
            static let textsStackViewLeadingAnchor: CGFloat = 18
            static let textsStackViewTrailingAnchor: CGFloat = -71
            
            static let nextButtonPadding: CGFloat = 10
        }
    }
}

