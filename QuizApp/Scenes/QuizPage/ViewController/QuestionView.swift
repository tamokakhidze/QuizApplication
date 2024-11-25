//
//  QuestionView.swift
//  QuizApp
//
//  Created by Tamuna Kakhidze on 15.11.24.
//

import UIKit

// MARK: - ColorfulBackgroundView
final class QuestionView: UIView {
    
    // MARK: - UI Components
    private let questionView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(
            ofSize: FontSizes.med14,
            weight: .medium
        )
        textView.textColor = CustomColors.neutralDarkGrey
        textView.textAlignment = .center
        textView.isEditable = false
        textView.textContainerInset = .zero
        textView.backgroundColor = .clear
        return textView
    }()
    
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
        backgroundColor = CustomColors.blueSecondaryLightest
        layer.cornerRadius = Constants.Sizing.radius
    }
    
    private func setupViewHierarchy() {
        addSubview(questionView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate(
            [
                self.heightAnchor.constraint(
                    equalToConstant: Constants.Sizing.height
                ),
                questionView.centerYAnchor.constraint(
                    equalTo: centerYAnchor
                ),
                questionView.leadingAnchor.constraint(
                    equalTo: leadingAnchor,
                    constant: Constants.Sizing.sidePadding
                ),
                questionView.trailingAnchor.constraint(
                    equalTo: trailingAnchor,
                    constant: -Constants.Sizing.sidePadding
                ),
                questionView.heightAnchor.constraint(
                    equalToConstant: 35
                )
            ]
        )
    }
    
    // MARK: - Configure View
    func configure(question: String) {
        questionView.text = question
    }
}

// MARK: - Constants Extension
extension QuestionView {
    enum Constants {
        enum Sizing {
            static let radius: CGFloat = 26
            static let height: CGFloat = 103
            static let sidePadding: CGFloat = 56
            static let numberOfLines: Int = 0
        }
    }
}
