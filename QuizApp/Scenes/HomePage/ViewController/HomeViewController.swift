//
//  HomeViewController.swift
//  QuizApp
//
//  Created by Tamuna Kakhidze on 14.11.24.
//

import UIKit

// MARK: - HomeViewController
final class HomeViewController: UIViewController {
    
    // MARK: - UI Components
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Constants.Sizing.mainStackViewSpacing
        return stackView
    }()
    
    private lazy var greetingLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.userName
        label.textColor = CustomColors.yellowPrimary
        label.font = .systemFont(
            ofSize: FontSizes.med,
            weight: .bold
        )
        return label
    }()
    
    private lazy var scoreSection: ColorfulBackgroundView = {
        let scoreSection = ColorfulBackgroundView()
        scoreSection.viewDetailsAction = { [weak self] in
            self?.detailsTapped()
        }
        return scoreSection
    }()
    
    private let labelForTable: UILabel = {
        let label = UILabel()
        label.text = Constants.Texts.tableViewHeaderLabelText
        label.font = .systemFont(
            ofSize: FontSizes.med,
            weight: .medium
        )
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            SubjectCell.self,
            forCellReuseIdentifier: SubjectCell.identifier
        )
        tableView.separatorColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = CustomColors.neutralLighterGrey
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var logoutButton: SmallYellowButton = {
        let button = SmallYellowButton()
        button.addTarget(
            self,
            action: #selector(logOut),
            for: .touchUpInside
        )
        button.setImage(
            .logoutButton,
            for: .normal
        )
        return button
    }()
    
    // MARK: - Properties
    private var viewModel: HomeViewModel
    
    // MARK: - Lifecycle
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureGpa()
    }
    
    override func viewWillAppear(_ animated: Bool ) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        setupView()
        setupTableView()
        setupViewHierarchy()
        setConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = CustomColors.neutralWhite
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupTableView() {
        labelForTable.frame = CGRect(
            x: .zero,
            y: .zero,
            width: tableView.frame.width,
            height: Constants.Sizing.labelForTableHeight
        )
        tableView.tableHeaderView = labelForTable
    }
    
    private func setupViewHierarchy() {
        view.addSubviews(
            mainStackView,
            separatorView,
            logoutButton
        )
        mainStackView.addArrangedSubviews(
            greetingLabel,
            scoreSection,
            tableView
        )
    }
    
    // MARK: - Constraints
    private func setConstraints() {
        configureMainStackViewConstraints()
        configureSeparatorConstraints()
        configureLogoutButtonConstraints()
    }
    
    private func configureMainStackViewConstraints() {
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
    
    private func configureSeparatorConstraints() {
        NSLayoutConstraint.activate(
            [
                separatorView.heightAnchor.constraint(
                    equalToConstant: Constants.Sizing.separatorHeight
                ),
                separatorView.leadingAnchor.constraint(
                    equalTo: view.leadingAnchor
                ),
                separatorView.trailingAnchor.constraint(
                    equalTo: view.trailingAnchor
                ),
                separatorView.bottomAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                    constant: Constants.Sizing.separatorBottomAnchor
                )
            ]
        )
    }
    
    private func configureLogoutButtonConstraints() {
        NSLayoutConstraint.activate(
            [
                logoutButton.heightAnchor.constraint(
                    equalToConstant: Constants.Sizing.logoutButtonDimension
                ),
                logoutButton.widthAnchor.constraint(
                    equalToConstant: Constants.Sizing.logoutButtonDimension
                ),
                logoutButton.bottomAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                    constant: Constants.Sizing.logoutButtonAnchor
                ),
                logoutButton.trailingAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                    constant: Constants.Sizing.logoutButtonAnchor
                )
            ]
        )
    }
    // MARK: - Configurations
    private func configureGpa() {
        scoreSection.configure(gpa: viewModel.gpa)
    }
    
    // MARK: - Logout
    @objc private func logOut() {
        let vm = LoginViewModel()
        vm.logOutTapped()
        let vc = LoginViewController(viewModel: vm)
        navigationController?.pushViewController(vc, animated: false)
    }
    
    private func detailsTapped() {
        let vm = PointsDetailsViewModel()
        let vc = PointsDetailsViewController(viewModel: vm)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Constants.TableView.numberOfRowsInSection
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.mockSubjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SubjectCell.identifier
        ) as? SubjectCell else {
            return UITableViewCell()
        }
        let subject = viewModel.mockSubjects[indexPath.section]
        let image = subject.icon
        cell.configureCell(
            image: image,
            title: subject.subjectTitle,
            buttonImage: "nextButtonImage"
        )
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        Constants.Sizing.heightForFooterInSection
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subject = viewModel.mockSubjects[indexPath.section]
        let quizViewModel = QuizViewModel(subject: subject)
        let vc = QuizViewController(viewModel: quizViewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}
