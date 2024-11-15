//
//  ColorfulBackgroundView.swift
//  QuizApp
//
//  Created by Tamuna Kakhidze on 15.11.24.
//

import UIKit

// MARK: - ColorfulBackgroundView
class ColorfulBackgroundView: UIView {
    
    // MARK: - UI Components
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let gpaStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Constants.Sizing.gpaStackViewSpacing
        return stackView
    }()
    
    private let gpaLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Texts.gpaLabelText
        label.font = .systemFont(
            ofSize: FontSizes.med,
            weight: .thin
        )
        label.textColor = CustomColors.neutralWhite
        return label
    }()
    
    private let gpaScoreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(
            ofSize: FontSizes.med,
            weight: .bold
        )
        label.textColor = CustomColors.yellowPrimary
        return label
    }()
    
    private let gpaView: UIView = {
        let view = UIView()
        view.backgroundColor = CustomColors.blueSecondaryLighter
        view.layer.cornerRadius = Constants.Sizing.gpaViewCornerRadius
        return view
    }()
    
    private lazy var detailsButton: DetailsButton = {
        let button = DetailsButton()
        return button
    }()
    
    // MARK: - Properties
    var viewDetailsAction: (() -> Void)?
    
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
        addTargets()
    }
    
    private func setAppearance() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = CustomColors.blueSecondaryDefault
        self.layer.cornerRadius = Constants.Sizing.radius
        self.layer.cornerRadius = Constants.Sizing.radius
    }
    
    private func setupViewHierarchy() {
        addSubview(mainStackView)
        gpaView.addSubview(gpaStackView)
        gpaStackView.addArrangedSubviews(
            gpaLabel,
            gpaScoreLabel
        )
        mainStackView.addArrangedSubviews(
            gpaView,
            detailsButton
        )
    }
    
    private func setConstraints() {
        setMainStackViewConstraints()
        setGpaStackViewConstraints()
    }
    
    private func setViewConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: Constants.Sizing.height)
        ])
    }
    
    private func setMainStackViewConstraints() {
        NSLayoutConstraint.activate(
            [
                mainStackView.topAnchor.constraint(
                    equalTo: topAnchor,
                    constant: Constants.Sizing.mainStackViewVerticalPadding
                ),
                mainStackView.leadingAnchor.constraint(
                    equalTo: leadingAnchor,
                    constant: Constants.Sizing.mainStackViewVerticalPadding
                ),
                mainStackView.trailingAnchor.constraint(
                    equalTo: trailingAnchor,
                    constant: -Constants.Sizing.mainStackViewSidePadding
                ),
                mainStackView.bottomAnchor.constraint(
                    equalTo: bottomAnchor,
                    constant: -Constants.Sizing.mainStackViewVerticalPadding
                )
            ]
        )
    }
    
    private func setGpaStackViewConstraints() {
        NSLayoutConstraint.activate(
            [
                gpaStackView.topAnchor.constraint(
                    equalTo: gpaView.topAnchor,
                    constant: Constants.Sizing.gpaStackViewVerticalPadding
                ),
                gpaStackView.bottomAnchor.constraint(
                    equalTo: gpaView.bottomAnchor,
                    constant: -Constants.Sizing.gpaStackViewVerticalPadding
                ),
                gpaStackView.leadingAnchor.constraint(
                    equalTo: gpaView.leadingAnchor,
                    constant: Constants.Sizing.gpaStackViewSidePadding
                ),
                gpaStackView.trailingAnchor.constraint(
                    equalTo: gpaView.trailingAnchor,
                    constant: -Constants.Sizing.gpaStackViewSidePadding
                )
            ]
        )
    }
    
    // MARK: - Configure View
    func configure(gpa: String) {
        gpaScoreLabel.text = gpa
    }
    
    // MARK: - Add Targets
    private func addTargets() {
        detailsButton.addTarget(
            self,
            action: #selector(detailsButtonTapped),
            for: .touchUpInside
        )
    }
    
    // MARK: - Actions
    @objc private func detailsButtonTapped() {
        viewDetailsAction?()
    }
}

// MARK: - Constants Extension
extension ColorfulBackgroundView {
    enum Constants {
        enum Sizing {
            static let mainStackViewSidePadding: CGFloat = 20
            static let mainStackViewVerticalPadding: CGFloat = 18
            static let radius: CGFloat = 26
            static let height: CGFloat = 75
            
            static let gpaViewCornerRadius: CGFloat = 14
            static let gpaViewHeight: CGFloat = 35
            
            static let gpaStackViewVerticalPadding: CGFloat = 7
            static let gpaStackViewSidePadding: CGFloat = 10
            static let gpaStackViewSpacing: CGFloat = 4
        }
        
        enum Texts {
            static let detailsButtonTitle = "დეტალურად"
            static let gpaLabelText = "GPA -"
        }
    }
}
