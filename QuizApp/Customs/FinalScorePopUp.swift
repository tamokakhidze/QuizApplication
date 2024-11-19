//
//  FinalScorePopUp.swift
//  QuizApp
//
//  Created by Tamuna Kakhidze on 18.11.24.
//

import UIKit

// MARK: - FinalScorePopUp
class FinalScorePopUp: UIView {
    
    // MARK: - UI Components
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = Constants.Sizing.stackViewSpacing
        return stackView
    }()
    
    private let emojiText: UILabel = {
        let label = UILabel()
        label.text = Constants.Texts.emoji
        label.font = .systemFont(ofSize: Constants.FontSizes.xxl)
        return label
    }()
    
    private let congratsText: UILabel = {
        let label = UILabel()
        label.text = Constants.Texts.message
        label.font = .systemFont(
            ofSize: Constants.FontSizes.med,
            weight: .bold
        )
        label.textColor = Constants.Colors.neutralWhite
        return label
    }()
    
    private let pointsText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(
            ofSize: Constants.FontSizes.med14,
            weight: .bold
        )
        label.textColor = Constants.Colors.blueSecondaryDefault
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.neutralLighterGrey
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(
            Constants.Texts.closeButtonTitle,
            for: .normal
        )
        button.titleLabel?.textColor = Constants.Colors.neutralWhite
        button.addTarget(self, action: #selector(closeClicked), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Close Action
    var closeAction: (() -> Void)?
    
    // MARK: - Lifecycle
    init() {
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func initialize() {
        setAppearance()
        setupViewHierarchy()
        setConstraints()
        setCustomSpacings()
    }
    
    private func setAppearance() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = Constants.Colors.yellowPrimary
        self.layer.cornerRadius = Constants.Sizing.radius
        self.clipsToBounds = true
    }
    
    private func setupViewHierarchy() {
        addSubviews(mainStackView, closeButton)
        mainStackView.addArrangedSubviews(
            emojiText,
            congratsText,
            pointsText,
            separatorView
        )
    }
    
    // MARK: - Constraints
    private func setConstraints() {
        configureMainStackViewConstraints()
        configureSeparatorConstraints()
        configureCloseButtonConstraints()
    }
    
    private func configureMainStackViewConstraints() {
        NSLayoutConstraint.activate(
            [
                mainStackView.leadingAnchor.constraint(
                    equalTo: leadingAnchor
                ),
                mainStackView.trailingAnchor.constraint(
                    equalTo: trailingAnchor
                ),
                mainStackView.centerYAnchor.constraint(
                    equalTo: centerYAnchor
                ),
                mainStackView.centerXAnchor.constraint(
                    equalTo: centerXAnchor
                )
            ]
        )
    }
    
    private func configureSeparatorConstraints() {
        NSLayoutConstraint.activate(
            [
                separatorView.heightAnchor.constraint(
                    equalToConstant: Constants.Sizing.separatorHeight
                ),
                separatorView.leadingAnchor.constraint(
                    equalTo: leadingAnchor
                ),
                separatorView.trailingAnchor.constraint(
                    equalTo: trailingAnchor
                ),
                separatorView.bottomAnchor.constraint(
                    equalTo: bottomAnchor,
                    constant: Constants.Sizing.separatorBottomAnchor
                )
            ]
        )
    }
    
    private func configureCloseButtonConstraints() {
        NSLayoutConstraint.activate(
            [
                closeButton.leadingAnchor
                    .constraint(
                        equalTo: leadingAnchor
                    ),
                closeButton.trailingAnchor
                    .constraint(
                        equalTo: trailingAnchor
                    ),
                closeButton.topAnchor
                    .constraint(
                        equalTo: separatorView.bottomAnchor
                    ),
                closeButton.heightAnchor
                    .constraint(
                        equalToConstant: Constants.Sizing.closeButtonHeightAnchor
                    )
            ]
        )
    }
    
    private func setCustomSpacings() {
        mainStackView.setCustomSpacing(
            Constants.Sizing.customSpacingAfterEmoji,
            after: emojiText
        )
        mainStackView.setCustomSpacing(
            Constants.Sizing.customSpacingAfterPoints,
            after: pointsText
        )
    }
    
    // MARK: - Configure View
    func configure(points: Int) {
        pointsText.text = "შენ დააგროვე \(points) ქულა"
    }
    
    // MARK: - Actions
    @objc func closeClicked() {
        closeAction?()
    }
}

// MARK: - Constants Extension
extension FinalScorePopUp {
    enum Constants {
        enum Sizing {
            static let radius: CGFloat = 31
            static let sidePadding: CGFloat = 24
            static let stackViewSpacing: CGFloat = 4
            static let customSpacingAfterEmoji: CGFloat = 17
            static let customSpacingAfterPoints: CGFloat = 32
            static let separatorHeight: CGFloat = 1
            static let separatorBottomAnchor: CGFloat = -44.5
            static let closeButtonHeightAnchor: CGFloat = 44
        }
        
        enum Texts {
            static let message = "გილოცავ!"
            static let emoji = "🎉"
            static let closeButtonTitle = "დახურვა"
        }
        
        enum FontSizes {
            static let xl: CGFloat = 20
            static let xs: CGFloat = 12
            static let med: CGFloat = 16
            static let med14: CGFloat = 14
            static let xxl: CGFloat = 32
        }
        
        enum Colors {
            static let neutralDarkGrey = UIColor(hex: "1D1D1D")
            static let neutralGrey = UIColor(hex: "B3B3B3")
            static let neutralWhite: UIColor = .white
            static let neutralLighterGrey = UIColor(hex: "F6F6F6")
            static let yellowPrimary = UIColor(hex: "#FFC44A")
            static let blueSecondaryDefault = UIColor(hex: "#537FE7")
            static let blueSecondaryLighter = UIColor(hex: "#6B91EA")
            static let blueSecondaryLightest = UIColor(hex: "#C0D0F6")
        }
    }
}
