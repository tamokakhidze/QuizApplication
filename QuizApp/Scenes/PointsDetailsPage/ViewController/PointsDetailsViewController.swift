//
//  PointsDetailsViewController.swift
//  QuizApp
//
//  Created by Tamuna Kakhidze on 28.11.24.
//

import UIKit

// MARK: - PointsDetailsViewController
final class PointsDetailsViewController: UIViewController {
    
    // MARK: - UI Components
    private let navigationLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Texts.navigationLabelText
        label.textColor = CustomColors.neutralDarkGrey
        label.font = .systemFont(
            ofSize: FontSizes.med,
            weight: .bold
        )
        return label
    }()
    
    private lazy var noPointsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = setupNoPointsLabelText()
        label.textAlignment = .center
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
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
        button.setImage(
            .logoutButton,
            for: .normal
        )
        button.addTarget(
            self,
            action: #selector(logOutButtonTapped),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var logOutPopUp: CustomPopUp = {
        let popup = CustomPopUp()
        popup.configure(question: Constants.Texts.logOutPopUpText)
        popup.onAcceptAction = { [weak self] in
            popup.removeFromSuperview()
            self?.navigationController?.popToRootViewController(animated: false)
        }
        
        popup.onRejectAction = {
            popup.removeFromSuperview()
        }
        return popup
    }()
    
    // MARK: - Properties
    private var viewModel: PointsDetailsViewModel
    private var isPointsEmpty: Bool = true
    
    // MARK: - Lifecycle
    init(viewModel: PointsDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        setupUI()
        updatePointsUI()
    }
    
    private func updatePointsUI() {
        isPointsEmpty = viewModel.isEmpty
        noPointsLabel.isHidden = !isPointsEmpty
        tableView.isHidden = isPointsEmpty
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        setupView()
        setupViewHierarchy()
        setupNavigationBar()
        setConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = CustomColors.neutralWhite
        navigationController?.isNavigationBarHidden = false
    }
    
    private func setupViewHierarchy() {
        view.addSubviews(
            tableView,
            noPointsLabel,
            separatorView,
            logoutButton
        )
    }
    
    private func setupNavigationTitle() -> NSAttributedString {
        let emojiAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: FontSizes.med),
            .foregroundColor: CustomColors.yellowPrimary
        ]
        
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: FontSizes.med, weight: .bold),
            .foregroundColor: CustomColors.neutralDarkGrey
        ]
        
        let emojiAttributedString = NSAttributedString(string: Constants.Texts.emoji, attributes: emojiAttributes)
        let titleAttributedString = NSAttributedString(string: Constants.Texts.navigationLabelText, attributes: titleAttributes)
        let spaceAttributedString = NSAttributedString(string: " ")
        
        let combinedAttributedString = NSMutableAttributedString()
        combinedAttributedString.append(titleAttributedString)
        combinedAttributedString.append(spaceAttributedString)
        combinedAttributedString.append(emojiAttributedString)
        return combinedAttributedString
    }
    
    private func setupNoPointsLabelText() -> NSAttributedString {
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: FontSizes.med18),
            .foregroundColor: CustomColors.neutralDarkGrey
        ]
        
        let emojiAttributedString = NSAttributedString(string: Constants.Texts.noPointsLabelEmoji)
        let spaceAttributedString = NSAttributedString(string: "\n")
        let titleAttributedString = NSAttributedString(string: Constants.Texts.noPointsLabelText, attributes: titleAttributes)
        
        let combinedAttributedString = NSMutableAttributedString()
        combinedAttributedString.append(emojiAttributedString)
        combinedAttributedString.append(spaceAttributedString)
        combinedAttributedString.append(titleAttributedString)
        return combinedAttributedString
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.attributedText = setupNavigationTitle()
        titleLabel.textAlignment = .center
        
        navigationItem.titleView = titleLabel
        
        let closeButton = UIBarButtonItem(
            image: Constants.Images.leftArrowImage,
            style: .plain,
            target: self,
            action: #selector(didTapLeftArrow)
        )
        closeButton.tintColor = CustomColors.neutralDarkGrey
        navigationItem.leftBarButtonItem = closeButton
    }
    
    // MARK: - Constraints
    private func setConstraints() {
        configureTableViewConstraints()
        configureNoPointsLabelConstraints()
        configureSeparatorConstraints()
        configureLogoutButtonConstraints()
    }
    
    private func configureTableViewConstraints() {
        NSLayoutConstraint.activate(
            [
                tableView.topAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.topAnchor,
                    constant: Constants.Sizing.tableViewTopAnchor
                ),
                tableView.leadingAnchor.constraint(
                    equalTo: view.leadingAnchor,
                    constant: Constants.Sizing.tableViewSidePadding
                ),
                tableView.trailingAnchor.constraint(
                    equalTo: view.trailingAnchor,
                    constant: -Constants.Sizing.tableViewSidePadding
                ),
                tableView.bottomAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                    constant: Constants.Sizing.tableViewBottomAnchor
                )
            ]
        )
    }
    
    private func configureNoPointsLabelConstraints() {
        NSLayoutConstraint.activate(
            [
                noPointsLabel.leadingAnchor.constraint(
                    equalTo: view.leadingAnchor,
                    constant: Constants.Sizing.noPointsLabelSidePadding
                ),
                noPointsLabel.trailingAnchor.constraint(
                    equalTo: view.trailingAnchor,
                    constant: -Constants.Sizing.noPointsLabelSidePadding
                ),
                noPointsLabel.centerYAnchor.constraint(
                    equalTo: view.centerYAnchor
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
    
    private func configurePopUpConstraints() {
        NSLayoutConstraint.activate(
            [
                logOutPopUp.leadingAnchor.constraint(
                    equalTo: view.leadingAnchor,
                    constant: Constants.Sizing.popupSidePadding
                ),
                logOutPopUp.trailingAnchor.constraint(
                    equalTo: view.trailingAnchor,
                    constant: -Constants.Sizing.popupSidePadding
                ),
                logOutPopUp.topAnchor.constraint(
                    equalTo: view.topAnchor,
                    constant: Constants.Sizing.popupVerticalPadding
                ),
                logOutPopUp.bottomAnchor.constraint(
                    equalTo: view.bottomAnchor,
                    constant: -Constants.Sizing.popupVerticalPadding
                )
            ]
        )
    }
    
    private func showLogOutPopUp() {
        view.addSubview(logOutPopUp)
        configurePopUpConstraints()
    }
    
    // MARK: - Actions
    @objc private func didTapLeftArrow() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func logOutButtonTapped() {
        showLogOutPopUp()
    }
    
}

// MARK: - UITableViewDataSource
extension PointsDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Constants.TableView.numberOfRowsInSection
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.points?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SubjectCell.identifier
        ) as? SubjectCell else {
            return UITableViewCell()
        }
        let image = viewModel.subjectImages[indexPath.section]
        let point = viewModel.pointValues[indexPath.section]
        cell.configureCell(image: image, title: viewModel.pointKeys[indexPath.section], buttonText: point)
        
        return cell
        
    }
    
}

// MARK: - UITableViewDelegate
extension PointsDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        Constants.Sizing.heightForFooterInSection
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
    
}
