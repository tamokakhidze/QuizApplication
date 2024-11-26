//
//  QuizViewController.swift
//  QuizApp
//
//  Created by Tamuna Kakhidze on 18.11.24.
//

import UIKit

struct Question {
    var title: String
    var options: [String]
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
            question: question?.title ?? "Which programming language is used in iOS?"
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
    
    private let questionNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "1/10" //Will change
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
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private let currentPointsLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Texts.currentPointsLabelText
        label.textColor = CustomColors.yellowPrimary
        label.font = .systemFont(
            ofSize: FontSizes.xs,
            weight: .light
        )
        return label
    }()
    
    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .star.withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let progressBar = ProgressView()
    
    // MARK: - Properties
    private var viewModel: HomeViewModel
    private var question: Question?
    private var subject: Subject
    
    // MARK: - Lifecycle
    init(viewModel: HomeViewModel, subject: Subject) {
        self.viewModel = viewModel
        self.subject = subject
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
        progressBar.configure(progress: 3, quizQuestionCount: subject.quizQuestionCount)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        setupNavigationBar()
        setupView()
        setupViewHierarchy()
        setConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = CustomColors.neutralWhite
        navigationController?.isNavigationBarHidden = false
    }
    
    private func setupNavigationBar() {
        title = subject.subjectTitle
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
            currentPointsLabel,
            starImageView
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
    
    // MARK: - Actions
    @objc private func didTapCloseButton() {
        let vc = HomeViewController(viewModel: viewModel)
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc private func nextButtonTapped() {
        let vc = QuizViewController(viewModel: viewModel, subject: subject)
        navigationController?.pushViewController(vc, animated: true)
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
        let options = [
            Option(title: "Python", isCorrect: false),
            Option(title: "C++", isCorrect: false),
            Option(title: "Ruby", isCorrect: false),
            Option(title: "Swift", isCorrect: true)
        ] //Wont be here in the future
        cell?.option = options[indexPath.section]
        cell?.configure(text: options[indexPath.section].title)
        cell?.showCorrectAnswer = { [weak self] in
            self?.highlightCorrectAnswer()
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
}
