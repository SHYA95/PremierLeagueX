//
//  FavouriteViewController.swift
//  PremierLeagueX
//
//  Created by Shrouk Yasser on 18/04/2024.
//
import UIKit
import RxSwift
import RxCocoa

class FavouriteViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var favTableView: UITableView!
    
    // MARK: Properties
    private let viewModel: HomeViewModel
    private var disposeBag = DisposeBag()
    private var favMatches: [MatchModel] = []
    
    // MARK: Init
    init(viewModel: HomeViewModel) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        viewModelInputs()
        viewModelOutputs()
        subscribeToMatches()
        viewModel.fetchMatchesFromCoreData()
    }
    
    // MARK: Configure table view
    
    private func configureTableView() {
        favTableView.registerNib(cell: MatchTableViewCell.self)
        favTableView.separatorStyle = .none
        favTableView.delegate = self
        favTableView.dataSource = self
    }
    
    // MARK: ViewModel Inputs
    
    private func viewModelInputs() {
        viewModel.fetchMatchesFromCoreData()
    }
    
    // MARK: ViewModel Outputs
    
    private func viewModelOutputs() {
        subscribeToReloadTableView()
        subscribeToErrorMessage()
    }
    
    // MARK: Subscribe to Reload TableView
    
    private func subscribeToErrorMessage() {
        viewModel.errorMessageObservable.subscribe { [weak self] (errorMessage: AppErrorType) in
            guard let self = self else { return }
            // Handle error message if needed
        }.disposed(by: disposeBag)
    }
    
    private func subscribeToReloadTableView() {
        viewModel.reloadTableViewObservable.subscribe { [weak self] in
            guard let self = self else { return }
            self.reloadTableView()
        }.disposed(by: disposeBag)
    }
    
    private func subscribeToMatches() {
        viewModel.matches.subscribe { [weak self] matches in
            guard let self = self else { return }
            self.favMatches = matches
            self.reloadTableView()
        }.disposed(by: disposeBag)
    }



    
    // MARK: Reload TableView
    
    private func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.favTableView.reloadData()
        }
    }
}

// MARK: - TableView DataSource and Delegate

extension FavouriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favMatches.count
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
