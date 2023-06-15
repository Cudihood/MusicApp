//
//  CollectionFlowLayout.swift
//  MusicApp
//
//  Created by Даниил Циркунов on 10.06.2023.
//

import UIKit

final class CollectionFlowLayout: UICollectionViewFlowLayout {
    
    private let countCellsRow: Int
    
    init(countCellsRow: Int, minimumInteritemSpacing: CGFloat = 0, minimumLineSpacing: CGFloat = 0, sectionInset: UIEdgeInsets = .zero) {
        self.countCellsRow = countCellsRow
        super.init()
        self.minimumLineSpacing = minimumLineSpacing
        self.minimumInteritemSpacing = minimumInteritemSpacing
        self.sectionInset = sectionInset
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        scrollDirection = .vertical
        let width = (collectionView.safeAreaLayoutGuide.layoutFrame.width - sectionInset.left - sectionInset.right - minimumInteritemSpacing * CGFloat(countCellsRow - 1)) / CGFloat(countCellsRow)
        itemSize = CGSize(width: width, height: width * 1.5)
    }
}

enum CollectionLayout {
    
    static let portrait = CollectionFlowLayout (
        countCellsRow: 3,
        minimumInteritemSpacing: 10,
        minimumLineSpacing: 10
    )
}
