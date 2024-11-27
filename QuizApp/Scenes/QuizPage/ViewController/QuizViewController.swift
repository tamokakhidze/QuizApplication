//
//  QuizViewController.swift
//  QuizApp
//
//  Created by Tamuna Kakhidze on 18.11.24.
//

import UIKit

struct Question {
    var title: String
    var options: [Option]
    var questionIndex: Int
} //Will have model separately later

struct Subject {
    var icon: String
    var subjectTitle: String
    var quizDescription: String
    var quizQuestionCount: Int
    var questions: [Question]
}

final class QuizViewController: UIViewController {
    
    // MARK: - UI Components
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Constants.Sizing.mainStackViewSpacing
        return stackView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(
            QuizCell.self,
            forCellReuseIdentifier: QuizCell.identifier
        )
        tableView.separatorColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var nextButton: YellowRoundedButton = {
        let button = YellowRoundedButton()
        button.configure(
            title: Constants.Texts.nextButtonTitle,
            height: Constants.Sizing.nextButtonHeight,
            radius: Constants.Sizing.nextButtonRadius,
            fontSize: FontSizes.med
        )
        button.addTarget(
            self,
            action: #selector(nextButtonTapped),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var questionView: QuestionView = {
        let view = QuestionView()
        view.configure(
            question: viewModel.currentQuestion.title
        )
        return view
    }()
    
    private let progressIndicatorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.Sizing.currentPointsStackViewSpacing
        return stackView
    }()
    
    private let progressPointsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var questionNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "\(viewModel.currentQuestion.questionIndex+1)/\(viewModel.totalQuestions)"
        label.textColor = CustomColors.neutralDarkGrey
        label.font = .systemFont(
            ofSize: FontSizes.med14,
            weight: .bold
        )
        return label
    }()
    
    private let currentPointsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = Constants.Sizing.currentPointsStackViewSpacing
        return stackView
    }()
    
    private lazy var currentPointsLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Texts.currentPointsLabelText + "\(viewModel.quizScore)"
        label.textColor = CustomColors.yellowPrimary
        label.font = .systemFont(
            ofSize: FontSizes.xs,
            weight: .light
        )
        return label
    }()
    
    private let progressBar = ProgressView()
    
    // MARK: - Properties
    private var viewModel: QuizViewModel
    
    // MARK: - Lifecycle
    init(viewModel: QuizViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        progressBar.configure(
            progress: viewModel.currentQuestion.questionIndex+1,
            quizQuestionCount: viewModel.totalQuestions
        )
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        setupNavigationBar()
        setCurrentScoreTitle()
        setupView()
        setupViewHierarchy()
        setConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = CustomColors.neutralWhite
        navigationController?.isNavigationBarHidden = false
    }
    
    private func setupNavigationBar() {
        title = viewModel.quizTitle
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: FontSizes.med, weight: .bold),
            .foregroundColor: CustomColors.neutralDarkGrey
        ]
        
        let closeButton = UIBarButtonItem(
            image: Constants.Images.xMark,
            style: .plain,
            target: self,
            action: #selector(didTapCloseButton)
        )
        closeButton.tintColor = CustomColors.neutralDarkGrey
        navigationItem.rightBarButtonItem = closeButton
        navigationItem.hidesBackButton = true
    }
    
    private func setCurrentScoreTitle() {
        let emoji = Constants.Texts.emoji
        let currentPoints = 3
        let message = "მიმდინარე ქულა: \(currentPoints)"
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 5
        
        let emojiAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: FontSizes.med14)
        ]
        
        let messageAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: FontSizes.med14, weight: .light),
            .paragraphStyle: paragraphStyle
        ]
        
        let emojiAttributedString = NSAttributedString(string: emoji, attributes: emojiAttributes)
        let messageAttributedString = NSAttributedString(string: message, attributes: messageAttributes)
        
        let combinedAttributedString = NSMutableAttributedString()
        combinedAttributedString.append(messageAttributedString)
        combinedAttributedString.append(emojiAttributedString)
        
        currentPointsLabel.attributedText = combinedAttributedString
    }
    
    
    private func setupViewHierarchy() {
        view.addSubviews(
            mainStackView
        )
        currentPointsStackView.addArrangedSubviews(
            currentPointsLabel
        )
        progressPointsStackView.addArrangedSubviews(
            questionNumberLabel,
            currentPointsStackView
        )
        progressIndicatorStackView.addArrangedSubviews(
            progressPointsStackView,
            progressBar
        )
        mainStackView.addArrangedSubviews(
            progressIndicatorStackView,
            questionView,
            tableView,
            nextButton
        )
    }
    
    // MARK: - Constraints
    private func setConstraints() {
        NSLayoutConstraint.activate(
            [
                mainStackView.topAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.topAnchor,
                    constant: Constants.Sizing.mainStackViewTopAnchor
                ),
                mainStackView.leadingAnchor.constraint(
                    equalTo: view.leadingAnchor,
                    constant: Constants.Sizing.mainStackViewSidePadding
                ),
                mainStackView.trailingAnchor.constraint(
                    equalTo: view.trailingAnchor,
                    constant: -Constants.Sizing.mainStackViewSidePadding
                ),
                mainStackView.bottomAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                    constant: Constants.Sizing.mainStackViewBottomAnchor
                )
            ]
        )
    }
    
    // MARK: - Show PopUps
    private func showScorePopup() {
        let popup = FinalScorePopUp()
        popup.configure(points: viewModel.quizScore)
        
        popup.closeAction = {
            popup.removeFromSuperview()
        }
        
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            popup.frame = window.bounds
            window.addSubview(popup)
            
            popup.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate(
                [
                    popup.leadingAnchor.constraint(
                        equalTo: window.leadingAnchor,
                        constant: Constants.Sizing.popupSidePadding
                    ),
                    popup.trailingAnchor.constraint(
                        equalTo: window.trailingAnchor,
                        constant: -Constants.Sizing.popupSidePadding
                    ),
                    popup.topAnchor.constraint(
                        equalTo: window.topAnchor,
                        constant: Constants.Sizing.popupVerticalPadding
                    ),
                    popup.bottomAnchor.constraint(
                        equalTo: window.bottomAnchor,
                        constant: -Constants.Sizing.popupVerticalPadding
                    )
                ]
            )
        }
    }
    
    private func showClosePopup() {
        let popup = CustomPopUp()
        popup.configure(question: Constants.Texts.leaveQuizText)
        
        popup.onAcceptAction = { [weak self] in
            popup.removeFromSuperview()
            let homeViewModel = HomeViewModel()
            let vc = HomeViewController(viewModel: homeViewModel)
            self?.navigationController?.pushViewController(vc, animated: false)
        }
        
        popup.onRejectAction = {
            popup.removeFromSuperview()
        }
        
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            popup.frame = window.bounds
            window.addSubview(popup)
            
            popup.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate(
                [
                    popup.leadingAnchor.constraint(
                        equalTo: window.leadingAnchor,
                        constant: Constants.Sizing.popupSidePadding
                    ),
                    popup.trailingAnchor.constraint(
                        equalTo: window.trailingAnchor,
                        constant: -Constants.Sizing.popupSidePadding
                    ),
                    popup.topAnchor.constraint(
                        equalTo: window.topAnchor,
                        constant: Constants.Sizing.popupVerticalPadding
                    ),
                    popup.bottomAnchor.constraint(
                        equalTo: window.bottomAnchor,
                        constant: -Constants.Sizing.popupVerticalPadding
                    )
                ]
            )
        }
    }
    
    // MARK: - Actions
    @objc private func didTapCloseButton() {
        showClosePopup()
    }
    
    @objc private func nextButtonTapped() {
        let vc = QuizViewController(viewModel: viewModel)
        if viewModel.hasNextQuestion() {
            navigationController?.pushViewController(vc, animated: true)
        } else if viewModel.isLastQuestion() {
            showScorePopup()
        }
    }
}

// MARK: - UITableViewDataSource
extension QuizViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Constants.TableView.numberOfRowsInSection
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        Constants.TableView.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuizCell.identifier) as? QuizCell
        
        cell?.option = viewModel.currentQuestion.options[indexPath.section]
        cell?.configure(text: viewModel.currentQuestion.options[indexPath.section].title)
        cell?.showCorrectAnswer = { [weak self] in
            self?.highlightCorrectAnswer()
        }
        cell?.handleScore = { [weak self] in
            self?.viewModel.increaseScore()
        }
        return cell!
    }
    
    func highlightCorrectAnswer() {
        for cell in tableView.visibleCells {
            if let quizCell = cell as? QuizCell, let option = quizCell.option {
                if option.isCorrect {
                    quizCell.backgroundColor = CustomColors.successColor
                    quizCell.rightStackView.isHidden = true
                    quizCell.optionTextLabel.textColor = CustomColors.neutralWhite
                }
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension QuizViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        Constants.Sizing.heightForFooterInSection
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.updateIndex()
        tableView.isUserInteractionEnabled = false
    }
}
