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
        label.text = "ჩემი პირველი ქვიზი"
        label.font = .systemFont(ofSize: FontSizes.xl, weight: .black)
        label.textColor = .white
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
        stackView.spacing = Sizing.stackViewSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    private let input: UITextField = {
        let input = UITextField()
        input.isUserInteractionEnabled = true
        input.textColor = .neutralGrey
        input.textAlignment = .center
        let placeholderText = "შეიყვანეთ სახელი"
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: FontSizes.xs)
        ]
        input.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        input.layer.borderWidth = Sizing.inputBorder
        input.layer.borderColor = Colors.border.cgColor
        input.layer.cornerRadius = Sizing.inputRadius
        return input
    }()
    
    private let startButton = YellowRoundedButton(
        title: "ქვიზის დაწყება",
        width: Sizing.startButtonWidth,
        height: Sizing.startButtonHeight,
        radius: Sizing.startButtoRadius,
        fontSize: FontSizes.xs
    )
    
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
        view.backgroundColor = .white
    }
    
    private func setupViewHierarchy() {
        loginStackView.addArrangedSubviews(input, startButton)
        view.addSubviews(blueBackground, titleLabel, illustration, loginStackView)
        view.bringSubviewToFront(titleLabel)
    }
    
    private func setConstraints() {
        blueBackgroundTopConstraint = blueBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: Sizing.blueBackgroundTopAnchor)
        
        NSLayoutConstraint.activate([
            blueBackgroundTopConstraint,
            blueBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Sizing.blueBackgroundLeadingAnchor),
            blueBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Sizing.blueBackgroundTrailingAnchor),
            blueBackground.heightAnchor.constraint(equalToConstant: Sizing.blueBackgroundHeight),
            
            titleLabel.topAnchor.constraint(equalTo: blueBackground.topAnchor, constant: Sizing.labelTopAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            illustration.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Sizing.illustrationTopAnchor),
            illustration.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginStackView.topAnchor.constraint(equalTo: blueBackground.bottomAnchor, constant: Sizing.stackViewTopAnchor),
            loginStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            input.widthAnchor.constraint(equalToConstant: Sizing.inputWidth),
            input.heightAnchor.constraint(equalToConstant: Sizing.inputHeight)
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
    
    // MARK: - Actions
    @objc private func keyboardWillShow() {
        blueBackgroundTopConstraint.constant = -150
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        blueBackgroundTopConstraint.constant = Sizing.stackViewTopAnchor
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
    
}

