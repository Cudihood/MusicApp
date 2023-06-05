//
//  SearchMusicTableView.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 30.05.2023.
//

import UIKit
import SnapKit

final class SearchMusicTableView: UIView
{
    var tapItemHandler: (() -> Void)?
    
    private var model: SearchMusicTableViewModelProtocol?
    
//    private var model:
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchMusicTableViewCell.self, forCellReuseIdentifier: SearchMusicTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .systemRed
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    func setModel(model: SearchMusicTableViewModelProtocol?) {
        if let model = model {
            self.model = model
            activityIndicator.stopAnimating()
        } else {
            self.model = nil
            activityIndicator.startAnimating()
        }
//        tableView.reloadData()
    }
    
    func bindViewModel() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchMusicTableView: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tapItemHandler?()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SearchMusicTableView: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model?.tracks.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if model?.tracks.count > 0
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchMusicTableViewCell.reuseIdentifier) as? SearchMusicTableViewCell else { return UITableViewCell() }
        let model = SearchMusicTableViewCellModel(model: model?.tracks[indexPath.row])
        cell.setCell(model: model)
        return cell
    }
}

private extension SearchMusicTableView
{
    func configure() {
        buildUI()
//        bindViewModel()
    }
    
    func buildUI() {
        self.addSubview(self.tableView)
        self.addSubview(self.activityIndicator)
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.verticalEdges.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
//    func bindViewModel() {
//        model?.tracksUpdateHandler = {
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }
}
