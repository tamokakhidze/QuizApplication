//
//  ProgressView.swift
//  QuizApp
//
//  Created by Tamuna Kakhidze on 18.11.24.
//

import UIKit

// MARK: - ProgressView
final class ProgressView: UIView {
    
    // MARK: - UI Components and Properties
    private let blueProgressView: UIView = {
        let progressView = UIView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.backgroundColor = CustomColors.blueSecondaryDefault
        progressView.layer.cornerRadius = Constants.Sizing.radius
        return progressView
    }()
    
    private var progressWidthConstraint: NSLayoutConstraint?
    var quizQuestionCount: Int?
    
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
        backgroundColor = CustomColors.neutralLighterGrey
        layer.cornerRadius = Constants.Sizing.radius
    }
    
    private func setupViewHierarchy() {
        addSubview(blueProgressView)
    }
    
    private func setConstraints() {
        progressWidthConstraint = blueProgressView.widthAnchor.constraint(
            equalToConstant: .zero
        )
        
        NSLayoutConstraint.activate(
            [
                self.heightAnchor.constraint(
                    equalToConstant: Constants.Sizing.height
                ),
                blueProgressView.leadingAnchor.constraint(
                    equalTo: leadingAnchor,
                    constant: Constants.Sizing.leftPadding
                ),
                blueProgressView.heightAnchor.constraint(
                    equalToConstant: Constants.Sizing.height
                ),
                progressWidthConstraint!
            ]
        )
    }
    
    // MARK: - Configure View
    func configure(progress: Int, quizQuestionCount: Int) {
        let progressValue = max(0, min(progress, quizQuestionCount))
        let newWidth = (self.frame.width * CGFloat(progressValue)) / CGFloat(quizQuestionCount)
        progressWidthConstraint?.constant = newWidth
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}

// MARK: - Constants Extension
extension ProgressView {
    enum Constants {
        enum Sizing {
            static let height: CGFloat = 9
            static let radius: CGFloat = height / 2
            static let leftPadding: CGFloat = 0
        }
    }
}

