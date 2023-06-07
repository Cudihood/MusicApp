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
    
    private let textLable: UILabel = {
        let lable = UILabel()
        lable.textAlignment = .center
        lable.textColor = Constants.dynamicTextColor
        lable.font = UIFont.preferredFont(forTextStyle: .title1)
        lable.isHidden = true
        lable.text = "Нет результатов"
        return lable
    }()
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    func setModel(model: SearchMusicTableViewModelProtocol?) {
//        if let model = model {
            self.model = model
//        } else {
//            activityIndicator.stopAnimating()
//        }
    }
    
    func showActivityIndicator(swow: Bool) {
        if swow {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
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
        guard let count = model?.tracks.count else { return 0 }
        if count > 0 || activityIndicator.isAnimating {
            textLable.isHidden = true
        } else {
            textLable.isHidden = false
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    }
    
    func buildUI() {
        self.addSubview(self.tableView)
        self.addSubview(self.activityIndicator)
        self.addSubview(self.textLable)
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.verticalEdges.equalToSuperview()
        }
        
        textLable.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
