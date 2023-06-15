//
//  FavoriteMusicTableView.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 30.05.2023.
//

import UIKit
import SnapKit

final class LikesCollectionView: UIView {
    
    var tapItemHandlet: ((Track?) -> Void)?
    
    private var model: LikesCollectionViewModelProtocol?
    
    private lazy var collectionView: UICollectionView = {
        let layout = CollectionLayout.portrait
        let collectionVeiw = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionVeiw.delegate = self
        collectionVeiw.dataSource = self
        collectionVeiw.register(LikesCollectionCell.self, forCellWithReuseIdentifier: LikesCollectionCell.reuseIdentifier)
        return collectionVeiw
    }()
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(model: LikesCollectionViewModelProtocol?) {
        self.model = model
    }
    
    func reload() {
        self.collectionView.reloadData()
    }
}

extension LikesCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let track = model?.likesTrack[indexPath.item]
        tapItemHandlet?(track)
    }
}

extension LikesCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model?.likesTrack.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LikesCollectionCell.reuseIdentifier, for: indexPath) as? LikesCollectionCell else {
            return UICollectionViewCell()
        }
        let track = LikesCollectionCellModel(track: model?.likesTrack[indexPath.item])
        cell.setModel(model: track)
        return cell
    }
}

private extension LikesCollectionView {
    
    func configure() {
        self.backgroundColor = Constants.Color.background
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.verticalEdges.equalToSuperview()
        }
    }
}
