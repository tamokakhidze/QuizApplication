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
        var message = ""
        if viewModel.isLastQuestion() {
            message = "მიმდინარე ქულა:\(viewModel.quizScore+1)"
        } else {
            message = "მიმდინარე ქულა:\(viewModel.quizScore)"
        }
        
        let messageAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(
                ofSize: FontSizes.med14,
                weight: .light
            ),
            .foregroundColor: CustomColors.yellowPrimary
        ]
        let emojiAttributedString = NSAttributedString(
            string: Constants.Texts.emoji,
            attributes: messageAttributes
        )
        let messageAttributedString = NSAttributedString(
            string: message,
            attributes: messageAttributes
        )
        
        let combinedAttributedString = NSMutableAttributedString()
        combinedAttributedString.append(messageAttributedString)
        combinedAttributedString.append(emojiAttributedString)
        label.attributedText = combinedAttributedString
        
        if viewModel.isLastQuestion() {
            message = "მიმდინარე ქულა:\(viewModel.quizScore+1)"
        }
        return label
    }()
    
    private lazy var scorePopUp: FinalScorePopUp = {
        let popup = FinalScorePopUp()
        popup.configure(points: viewModel.quizScore)
        popup.translatesAutoresizingMaskIntoConstraints = false
        popup.closeAction = { [weak self] in
            popup.removeFromSuperview()
            self?.backgroundBlur.removeFromSuperview()
        }
        return popup
    }()
    
    private lazy var closeQuizPopUp: CustomPopUp = {
        let popup = CustomPopUp()
        popup.configure(question: Constants.Texts.leaveQuizText)
        popup.onAcceptAction = { [weak self] in
            popup.removeFromSuperview()
            let homeViewModel = HomeViewModel()
            let vc = HomeViewController(viewModel: homeViewModel)
            self?.navigationController?.pushViewController(
                vc,
                animated: false
            )
        }
        
        popup.onRejectAction = {
            popup.removeFromSuperview()
        }
        return popup
    }()
    
    private lazy var backgroundBlur: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.7)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        setupView()
        setupViewHierarchy()
        setMainstackViewConstraints()
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
    private func setMainstackViewConstraints() {
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
    
    private func setScorePopUpConstraints() {
        NSLayoutConstraint.activate(
            [
                scorePopUp.leadingAnchor.constraint(
                    equalTo: view.leadingAnchor,
                    constant: Constants.Sizing.popupSidePadding
                ),
                scorePopUp.trailingAnchor.constraint(
                    equalTo: view.trailingAnchor,
                    constant: -Constants.Sizing.popupSidePadding
                ),
                scorePopUp.centerYAnchor.constraint(
                    equalTo: view.centerYAnchor
                )
            ]
        )
    }
    
    private func setCloseQuizPopUpConstraints() {
        NSLayoutConstraint.activate(
            [
                closeQuizPopUp.leadingAnchor.constraint(
                    equalTo: view.leadingAnchor,
                    constant: Constants.Sizing.popupSidePadding
                ),
                closeQuizPopUp.trailingAnchor.constraint(
                    equalTo: view.trailingAnchor,
                    constant: -Constants.Sizing.popupSidePadding
                ),
                closeQuizPopUp.centerYAnchor.constraint(
                    equalTo: view.centerYAnchor
                )
            ]
        )
    }
    
    private func setBlurViewConstraints() {
        NSLayoutConstraint.activate([
            backgroundBlur.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            backgroundBlur.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            backgroundBlur.topAnchor.constraint(
                equalTo: view.topAnchor
            ),
            backgroundBlur.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            )
        ])
    }
    
    // MARK: - Show PopUps
    private func showScorePopup() {
        showBlurView()
        view.addSubview(scorePopUp)
        setScorePopUpConstraints()
    }
    
    private func showBlurView() {
        view.addSubview(backgroundBlur)
        setBlurViewConstraints()
    }
    
    private func showClosePopup() {
        view.addSubview(closeQuizPopUp)
        setCloseQuizPopUpConstraints()
    }
    
    private func updateNextButtonTitle() {
        let buttonTitle = viewModel.isLastQuestion() ? "დასრულება" : Constants.Texts.nextButtonTitle
        nextButton.setTitle(buttonTitle, for: .normal)
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
            updateNextButtonTitle()
            showScorePopup()
            viewModel.finishQuiz()
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
