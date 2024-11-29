//
//  CustomPopUp.swift
//  QuizApp
//
//  Created by Tamuna Kakhidze on 18.11.24.
//

import UIKit

// MARK: - CustomPopUp
final class CustomPopUp: UIView {
    
    // MARK: - UI Components
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = Constants.Sizing.mainStackViewSpacing
        return stackView
    }()
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = Constants.Sizing.buttonsSpacing
        return stackView
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(
            ofSize: Constants.FontSize.med,
            weight: .bold
        )
        label.textColor = Constants.Colors.neutralWhite
        label.textAlignment = .center
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var rejectButton: PopupButton = {
        let button = PopupButton()
        button.configure(title: Constants.Texts.rejectButtonTitle)
        button.addTarget(
            self,
            action: #selector(handleNoButtonTap),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var acceptButton: PopupButton = {
        let button = PopupButton()
        button.configure(title: Constants.Texts.acceptButtonTitle)
        button.addTarget(
            self,
            action: #selector(handleYesButtonTap),
            for: .touchUpInside
        )
        return button
    }()
    
    // MARK: - Actions
    var onAcceptAction: (() -> Void)?
    var onRejectAction: (() -> Void)?
    
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
    }
    
    private func setAppearance() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Constants.Colors.yellowPrimary
        layer.cornerRadius = Constants.Sizing.radius
        clipsToBounds = true
    }
    
    private func setupViewHierarchy() {
        addSubviews(mainStackView)
        buttonsStackView.addArrangedSubviews(
            rejectButton,
            acceptButton
        )
        mainStackView.addArrangedSubviews(
            questionLabel,
            buttonsStackView
        )
    }
    
    // MARK: - Constraints
    private func setConstraints() {
        configureMainStackViewConstraints()
    }
    
    private func configureMainStackViewConstraints() {
        NSLayoutConstraint.activate(
            [
                mainStackView.leadingAnchor.constraint(
                    equalTo: leadingAnchor,
                    constant: Constants.Sizing.sidePadding
                ),
                mainStackView.trailingAnchor.constraint(
                    equalTo: trailingAnchor,
                    constant: -Constants.Sizing.sidePadding
                ),
                mainStackView.topAnchor.constraint(
                    equalTo: topAnchor,
                    constant: Constants.Sizing.verticalPadding
                ),
                mainStackView.bottomAnchor.constraint(
                    equalTo: bottomAnchor,
                    constant: -Constants.Sizing.verticalPadding
                )
            ]
        )
    }
    
    // MARK: - Configure View
    func configure(question: String) {
        questionLabel.text = question
    }
    
    // MARK: - Actions
    @objc func handleYesButtonTap() {
        onAcceptAction?()
    }
    
    @objc func handleNoButtonTap() {
        onRejectAction?()
    }
}

// MARK: - Constants Extension
private extension CustomPopUp {
    enum Constants {
        enum Sizing {
            static let radius: CGFloat = 31
            static let sidePadding: CGFloat = 24
            static let verticalPadding: CGFloat = 39
            static let mainStackViewSpacing: CGFloat = 42
            static let buttonsSpacing: CGFloat = 10
        }
        
        enum Texts {
            static let rejectButtonTitle = "არა"
            static let acceptButtonTitle = "კი"
            
        }
        
        enum FontSize {
            static let med: CGFloat = 16
        }
        
        enum Colors {
            static let neutralWhite: UIColor = .white
            static let yellowPrimary: UIColor = UIColor(hex: "#FFC44A")
        }
    }
}

