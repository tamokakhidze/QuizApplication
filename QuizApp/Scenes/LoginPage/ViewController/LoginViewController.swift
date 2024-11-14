//
//  ViewController.swift
//  QuizApp
//
//  Created by Tamuna Kakhidze on 12.11.24.
//

import UIKit

// MARK: - LoginViewController
class LoginViewController: UIViewController {
    
    // MARK: - UI Components
    private let blueBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .blueBackground
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.Texts.title
        label.font = .systemFont(ofSize: FontSizes.xl, weight: .black)
        label.textColor = Constants.Colors.neutralWhite
        return label
    }()
    
    private let illustration: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .loginPageIllustration
        return imageView
    }()
    
    private let loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Constants.Sizing.stackViewSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    private let input: UITextField = {
        let input = UITextField()
        input.textColor = Constants.Colors.neutralGrey
        input.textAlignment = .center
        let placeholderText = Constants.Texts.placeholderText
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: FontSizes.xs)
        ]
        input.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        input.layer.borderWidth = Constants.Sizing.inputBorder
        input.layer.borderColor = Constants.Colors.buttonColor.cgColor
        input.layer.cornerRadius = Constants.Sizing.inputRadius
        return input
    }()
    
    private let startButton: YellowRoundedButton = {
        let button = YellowRoundedButton()
        button.configure(
            title: Constants.Texts.startButtonTitle,
            height: Constants.Sizing.startButtonHeight,
            radius: Constants.Sizing.startButtoRadius,
            fontSize: FontSizes.xs
        )
        return button
    }()
    
    // MARK: - Constraints
    private var blueBackgroundTopConstraint: NSLayoutConstraint!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardObservers()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        setupView()
        setupViewHierarchy()
        setConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = Constants.Colors.neutralWhite
        addTapGestureToDismissKeyboard()
    }
    
    private func setupViewHierarchy() {
        loginStackView.addArrangedSubviews(
            input,
            startButton
        )
        view.addSubviews(
            blueBackground,
            titleLabel,
            illustration,
            loginStackView
        )
        view.bringSubviewToFront(titleLabel)
    }
    
    // MARK: - UI Constraints
    private func setConstraints() {
        setupBackgroundConstraints()
        setupTitleConstraints()
        setupIllustrationConstraints()
        setupStackViewConstraints()
        setupInputConstraints()
        setupStartButtonConstraints()
    }
    
    private func setupBackgroundConstraints() {
        blueBackgroundTopConstraint = blueBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.Sizing.blueBackgroundTopAnchor)
        
        NSLayoutConstraint.activate([
            blueBackgroundTopConstraint,
            blueBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blueBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blueBackground.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Constants.Sizing.blueBackgroundHeightMultiplier)
        ])
    }
    
    private func setupTitleConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: blueBackground.topAnchor, constant: Constants.Sizing.labelTopAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupIllustrationConstraints() {
        NSLayoutConstraint.activate([
            illustration.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.Sizing.illustrationTopAnchor),
            illustration.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupStackViewConstraints() {
        NSLayoutConstraint.activate([
            loginStackView.topAnchor.constraint(equalTo: blueBackground.bottomAnchor, constant: Constants.Sizing.stackViewTopAnchor)
        ])
    }
    
    private func setupInputConstraints() {
        NSLayoutConstraint.activate([
            input.heightAnchor.constraint(equalToConstant: Constants.Sizing.inputHeight),
            input.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Sizing.inputSidePadding),
            input.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Sizing.inputSidePadding)
        ])
    }
    
    private func setupStartButtonConstraints() {
        NSLayoutConstraint.activate([
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Sizing.startButtonSidePadding),
            startButton.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -Constants.Sizing.startButtonSidePadding),
        ])
    }
    
    // MARK: - Keyboard Handling
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Add Tap Gesture
    private func addTapGestureToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Actions
    @objc private func keyboardWillShow() {
        blueBackgroundTopConstraint.constant = Constants.Sizing.keyboardAdjustmentOffset
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        blueBackgroundTopConstraint.constant = Constants.Sizing.blueBackgroundTopAnchor
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

