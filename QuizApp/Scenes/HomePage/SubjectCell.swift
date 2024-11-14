//
//  SubjectCell.swift
//  QuizApp
//
//  Created by Tamuna Kakhidze on 14.11.24.
//

import UIKit

final class SubjectCell: UITableViewCell {
    
    //MARK: - Properties
    private let subjectImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = CustomColors.neutralDarkGrey
        label.font = .systemFont(ofSize: FontSizes.med, weight: .bold)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.Texts.descriptionLabelText
        label.textColor = CustomColors.neutralGrey
        label.font = .systemFont(ofSize: FontSizes.xs, weight: .bold)
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
        stackView.axis = .horizontal
        stackView.spacing = Constants.Sizing.mainStackViewSpacing
        return stackView
    }()
    
    private let leftStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Constants.Sizing.leftStackViewSpacing
        stackView.backgroundColor = .blue
        return stackView
    }()
    
    private let textsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Constants.Sizing.textsStackView
        stackView.alignment = .leading
        return stackView
    }()
    
    static let identifier = "SubjectCell"
    
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
    }
    
    private func setAppearance() {
        contentView.layer.cornerRadius = Constants.Sizing.cornerRadius
        contentView.backgroundColor = CustomColors.neutralLighterGrey
        contentView.clipsToBounds = true
    }
    
    private func setupHierarchy() {
        sendSubviewToBack(contentView)
        addSubviews(mainStackView)
        textsStackView.addArrangedSubviews(titleLabel, descriptionLabel)
        leftStackView.addArrangedSubviews(subjectImage, textsStackView)
        mainStackView.addArrangedSubviews(leftStackView, nextButton)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.Sizing.mainStackViewVerticalPadding),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Sizing.mainStackViewSidePadding),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.Sizing.mainStackViewVerticalPadding),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.Sizing.mainStackViewSidePadding),
            
            leftStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            
            textsStackView.topAnchor.constraint(equalTo: leftStackView.topAnchor, constant: Constants.Sizing.textsStackViewVerticalPadding),
            textsStackView.bottomAnchor.constraint(equalTo: leftStackView.bottomAnchor, constant: -Constants.Sizing.textsStackViewVerticalPadding),
            textsStackView.leadingAnchor.constraint(equalTo: subjectImage.trailingAnchor, constant: Constants.Sizing.textsStackViewLeadingAnchor),
            textsStackView.trailingAnchor.constraint(equalTo: leftStackView.trailingAnchor),
            
            nextButton.topAnchor.constraint(equalTo: mainStackView.topAnchor, constant: 10),
            nextButton.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: -10)
        ])
    }
    
    //MARK: - Cell Configuration
    func configureCell(image: UIImage, title: String) {
        subjectImage.image = image
        titleLabel.text = title
    }
}

extension SubjectCell {
    enum Constants {
        enum Texts {
            static let descriptionLabelText = "აღწერა"
        }
        
        enum Sizing {
            static let cornerRadius: CGFloat = 26

            static let mainStackViewSpacing: CGFloat = 27
            static let leftStackViewSpacing: CGFloat = 18
            static let textsStackView: CGFloat = 0
            
            static let mainStackViewSidePadding: CGFloat = 29.5
            static let mainStackViewVerticalPadding: CGFloat = 22
            
            static let textsStackViewVerticalPadding: CGFloat = 8
            static let textsStackViewLeadingAnchor: CGFloat = 18
            
        }
    }
}

