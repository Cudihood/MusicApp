//
//  SearchMusicViewController.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 30.05.2023.
//

import UIKit

final class SearchMusicTableViewController: UIViewController
{
    var router: SearchMusicTableRouterProtocol?
    var viewModel: SearchMusicTableViewModelProtocol?
    
    private let searchController = UISearchController()
    private let customView = SearchMusicTableView()
    
    override func loadView() {
        super.loadView()
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

extension SearchMusicTableViewController: UISearchResultsUpdating, UISearchBarDelegate
{
    func updateSearchResults(for searchController: UISearchController) {
//        viewModel?.fetchTrack(trackName: searchController.searchBar.text ?? "")
//        customView.setModel(model: viewModel)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.fetchTrack(trackName: searchBar.text ?? "")
        customView.setModel(model: viewModel)
    }
}

private extension SearchMusicTableViewController
{
    func configure() {
        self.title = "Поиск"
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.placeholder = "Введите название трека"
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
        setupTapItemHandlers()
        customView.setModel(model: viewModel)
        setupTrackUpdateHandler()
    }
    
    func setupTapItemHandlers() {
        customView.tapItemHandler = { [weak self] in
            guard let self = self else { return }
            self.router?.goToDetailsScreen()
        }
    }
    
    func setupTrackUpdateHandler() {
        viewModel?.tracksUpdateHandler = {
            self.customView.bindViewModel()
        }
    }
}
