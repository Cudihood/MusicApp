//
//  FavoriteMusicTableViewController.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 30.05.2023.
//

import UIKit

final class LikesCollectionViewController: UIViewController {
    private var viewModel: LikesCollectionViewModelProtocol!
    private var router: LikesCollectionRouterProtocol!
    
    private lazy var collectionView: UICollectionView = {
        let layout = CollectionLayout.portrait
        let collectionVeiw = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionVeiw.delegate = self
        collectionVeiw.dataSource = self
        collectionVeiw.register(LikesCollectionCell.self, forCellWithReuseIdentifier: LikesCollectionCell.reuseIdentifier)
        return collectionVeiw
    }()
    
    private lazy var emptyResultsTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = Constants.dynamicTextColor
        label.font = Constants.Font.title1
        label.text = "Нет результатов"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.emptyResultsTextLabel.isHidden = !self.viewModel.likesTrack.isEmpty
        self.collectionView.reloadData()
    }
    
    func setRouter(router: LikesCollectionRouterProtocol?) {
        self.router = router
    }
    
    func setViewModel(model: LikesCollectionViewModelProtocol?) {
        self.viewModel = model
    }
}

extension LikesCollectionViewController {
    static func viewController(trackRepository: TrackRepositoryProtocol) -> LikesCollectionViewController {
        let searchMusicVC = LikesCollectionViewController()

        searchMusicVC.router = LikesCollectionRouter(viewController: searchMusicVC)
        searchMusicVC.viewModel = LikesCollectionViewModel(trackRepository: trackRepository)
        return searchMusicVC
    }
}

extension LikesCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router.goToDetailsScreen(for: viewModel.likesTrack[indexPath.item])
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension LikesCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.likesTrack.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LikesCollectionCell.reuseIdentifier, for: indexPath) as? LikesCollectionCell else {
            return UICollectionViewCell()
        }
        let model = LikesCollectionCellModel(track: viewModel.likesTrack[indexPath.item])
        cell.configure(with: model)
        return cell
    }
}

private extension LikesCollectionViewController {
    func setupUI() {
        self.title = "Любимые"
        
        view.addSubview(collectionView)
        view.addSubview(self.emptyResultsTextLabel)
        
        self.collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.verticalEdges.equalToSuperview()
        }
        
        self.emptyResultsTextLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
