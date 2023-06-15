//
//  SearchMusicViewController.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 30.05.2023.
//

import UIKit

final class SearchMusicTableViewController: UIViewController {
    var router: SearchMusicTableRouterProtocol!
    var viewModel: SearchMusicTableViewModelProtocol!
    
    private var isLoading = false {
        didSet {
            isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
            emptyResultsTextLabel.isHidden = isLoading
        }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchMusicTableViewCell.self, forCellReuseIdentifier: SearchMusicTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = Constants.Color.blue
        return view
    }()
    
    private lazy var emptyResultsTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = Constants.dynamicTextColor
        label.font = Constants.Font.title1
        label.text = "Нет результатов"
        return label
    }()
    
    private let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupUI()
    }
}

extension SearchMusicTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router.goToDetailsScreen(for: viewModel.tracks[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SearchMusicTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchMusicTableViewCell.reuseIdentifier) as? SearchMusicTableViewCell else{
            return UITableViewCell()
        }
        let model = SearchMusicTableViewCellModel(track: viewModel.tracks[indexPath.row])
        cell.configure(with: model)
        return cell
    }
}

extension SearchMusicTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //Если ввесли S то будет ошибка 404 и будет отображен активити индикатор и лейбл
        guard let text = searchBar.text else { return }
        isLoading = true
        viewModel.fetchTrack(trackName: text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.resetSearch()
    }
}

extension SearchMusicTableViewController {
    static func viewController(trackRepository: TrackRepositoryProtocol) -> SearchMusicTableViewController {
        let searchMusicVC = SearchMusicTableViewController()

        searchMusicVC.router = SearchMusicTableRouter(viewController: searchMusicVC)
        searchMusicVC.viewModel = SearchMusicTableViewModel(trackRepository: trackRepository)
        return searchMusicVC
    }
}

private extension SearchMusicTableViewController {
    func bindViewModel() {
        viewModel.tracksUpdateHandler = { [weak self] in
            guard let self else { return }
            self.isLoading = false
            self.emptyResultsTextLabel.isHidden = !self.viewModel.tracks.isEmpty
            self.tableView.reloadData()
        }
        
        viewModel.showAlert = { [weak self] message in
            self?.present(AlertFactory.createAlert(title: "Произошла ошибка", message: message), animated: true)
        }
    }
    
    func setupUI() {
        title = "Поиск"
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Введите название трека"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        
        view.addSubview(self.tableView)
        view.addSubview(self.activityIndicator)
        view.addSubview(self.emptyResultsTextLabel)
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.verticalEdges.equalToSuperview()
        }
        
        emptyResultsTextLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
