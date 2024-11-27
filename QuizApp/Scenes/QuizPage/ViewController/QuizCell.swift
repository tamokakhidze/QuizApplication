//
//  QuizCell.swift
//  QuizApp
//
//  Created by Tamuna Kakhidze on 18.11.24.
//

struct Option {
    var title: String
    var isCorrect: Bool
} //will be moved to according file later

import UIKit

final class QuizCell: UITableViewCell {
    
    // MARK: - Properties
    var option: Option?
    var showCorrectAnswer: (() -> Void)?
    
    static let identifier = Constants.Texts.identifier
    
    // MARK: - UI Components
    var optionTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = CustomColors.neutralDarkGrey
        label.font = .systemFont(
            ofSize: FontSizes.med14,
            weight: .bold
        )
        return label
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    var rightStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Constants.Sizing.rightStackViewSpacing
        stackView.isHidden = true
        return stackView
    }()
    
    private let plusOneLabel: UILabel = {
        let label = UILabel()
        label.textColor = CustomColors.neutralWhite
        label.text = Constants.Texts.plusOneLabelText
        label.font = .systemFont(
            ofSize: FontSizes.med14,
            weight: .bold
        )
        return label
    }()
    
    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .cellStar.withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell Reuse Preparation
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundColor = CustomColors.neutralLighterGrey
        rightStackView.isHidden = true
    }
    
    // MARK: - Selection Handling
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        guard let option = option else { return }
        
        if selected {
            if option.isCorrect {
                backgroundColor = CustomColors.successColor
                rightStackView.isHidden = false
                optionTextLabel.textColor = CustomColors.neutralWhite
            } else {
                backgroundColor = CustomColors.wrongColor
                rightStackView.isHidden = true
                optionTextLabel.textColor = CustomColors.neutralWhite
                showCorrectAnswer?()
            }
        }
    }
    
    // MARK: - UI Setup
    private func initialize() {
        setAppearance()
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        addSubview(stackView)
        rightStackView.addArrangedSubviews(
            plusOneLabel,
            starImageView
        )
        stackView.addArrangedSubviews(
            optionTextLabel,
            rightStackView
        )
    }
    
    private func setAppearance() {
        backgroundColor = CustomColors.neutralLighterGrey
        clipsToBounds = true
        layer.cornerRadius = Constants.Sizing.cornerRadius
        selectionStyle = .none
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate(
            [
                stackView.leadingAnchor
                    .constraint(
                        equalTo: leadingAnchor,
                        constant: Constants.Sizing.stackViewSidePadding
                    ),
                stackView.trailingAnchor
                    .constraint(
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
    
    // MARK: - Configuration
    func configure(text: String) {
        optionTextLabel.text = text
    }
}

// MARK: - Constants Extension
extension QuizCell {
    enum Constants {
        enum Sizing {
            static let cornerRadius: CGFloat = 22
            static let stackViewSidePadding: CGFloat = 30
            static let stackViewVerticalPadding: CGFloat = 22
            static let rightStackViewSpacing: CGFloat = 4
        }
        
        enum Texts {
            static let identifier = "QuizCell"
            static let plusOneLabelText = "+1"
        }
    }
}
