//
//  HomeViewController.swift
//  PremierLeagueX
//
//  Created by Shrouk Yasser on 18/04/2024.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var matchesTableView: UITableView!
    
    // MARK: Properties
    private let viewModel: HomeViewModelType
    private var disposeBag = DisposeBag()
    
    // MARK: init
    
    init(viewModel: HomeViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelOutputs()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModelInputs()
    }
    
    // MARK: Configure table view
    
    private func configureTableView() {
        matchesTableView.registerNib(cell: MatchTableViewCell.self)
        matchesTableView.separatorStyle = .none
        matchesTableView.delegate = self
        matchesTableView.dataSource = self
    }
    
    /// To hidden keyboard when scrolling.
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    private func toggleFavoriteValue(with match: MatchModel, at indexPath: IndexPath) {
        if !match.isFav {
            viewModel.addMatchToFavorites(match: match)
        } else {
            viewModel.removeFavMatches(with: Int32(match.id!))
        }
    }

    private func animateButton(_ button: UIButton) {
      UIView.animate(withDuration: 0.3, animations: {
        button.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)

        button.setImage(UIImage(systemName: Constants.HEART_FILLED_ICON)?.withTintColor(.red, renderingMode: .alwaysOriginal), for: .normal)
        button.tintColor = .red
      }) { _ in
        UIView.animate(withDuration: 0.3) {
          button.transform = .identity
        }
      }
    }
}

// MARK: - TableView DataSource and Delegate

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: TableView Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMatches(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionTitle(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchTableViewCell", for: indexPath) as! MatchTableViewCell
        viewModel.matches.map { $0[indexPath.row] }
            .subscribe(onNext: { match in
                cell.update(match: match)
            })
            .disposed(by: disposeBag)
        
        cell.favButtonTapped = { match in
            if !match.isFav {
                self.viewModel.addMatchToFavorites(match: match)
                self.animateButton(cell.favButton)
            } else {
                self.displayRemoveFromFavoritesAlert(match: match, cell: cell)
            }
        }
        
        return cell
    }

    private func displayRemoveFromFavoritesAlert(match: MatchModel, cell: MatchTableViewCell) {
        Utilities.displayDestructiveAlert(self, title: Constants.REMOVE, text: Constants.REMOVE_FROM_FAV) {
            self.viewModel.removeFavMatches(with: Int32(match.id ?? 0))
            cell.favButton.setImage(UIImage(systemName: Constants.HEART_ICON)?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        }
    } }

// MARK: - ViewModel Handlers

extension HomeViewController {
    
    private func viewModelInputs() {
        viewModel.fetchMatches()
    }
    
    private func viewModelOutputs() {
        subscribeToReloadTableView()
        subscribeToErrorMessage()
    }
    
    private func subscribeToReloadTableView() {
        viewModel.reloadTableViewObservable.subscribe { [weak self] _ in
            guard let self = self else { return }
            self.reloadTableView()
        }.disposed(by: disposeBag)
    }
    
    private func subscribeToErrorMessage() {
        viewModel.errorMessageObservable.subscribe { [weak self] errorMessage in
            guard let self = self else { return }

            // self.coordinator?.presentErrorAlert(errorType: errorMessage)
        }.disposed(by: disposeBag)
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.matchesTableView.reloadData()
        }
    }
}
