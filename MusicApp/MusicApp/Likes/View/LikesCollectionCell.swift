//
//  FavoriteMusicCollectionCell.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 30.05.2023.
//

import UIKit
import SnapKit

final class LikesCollectionCell: UICollectionViewCell
{
    static let reuseIdentifier = "Cell"
    
    private var model: LikesCollectionCellModel? {
        didSet {
            setCell(model: model)
        }
    }
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Constants.Size.cornerRadius
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let trackNameLabel: UILabel = {
        let lable = UILabel()
        lable.textColor = .black
        lable.font = Constants.Font.title2
        lable.textAlignment = .left
//        lable.numberOfLines = 0
        return lable
    }()
    
    private let artistNameLabel: UILabel = {
        let lable = UILabel()
        lable.textColor = .black
        lable.font = Constants.Font.title3
        lable.textAlignment = .left
//        lable.numberOfLines = 0
        return lable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(model: LikesCollectionCellModel?) {
        self.model = model
    }
}

private extension LikesCollectionCell
{
    func setCell(model: LikesCollectionCellModel?) {
        self.imageView.image = model?.imageTrack
        self.artistNameLabel.text = model?.artistName
        self.trackNameLabel.text = model?.trackName
    }
    
    func configure() {
        self.backgroundColor = Constants.Color.background
        buildUI()
    }
    
    func buildUI() {
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(trackNameLabel)
        self.contentView.addSubview(artistNameLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.trailing.leading.equalToSuperview().inset(Constants.Spacing.standart)
        }
        
        trackNameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.Spacing.little)
            make.top.equalTo(imageView.snp.bottom).offset(Constants.Spacing.little)
        }
        
        artistNameLabel.snp.makeConstraints { make in
            make.top.equalTo(trackNameLabel.snp.bottom).offset(Constants.Spacing.little)
            make.leading.trailing.equalToSuperview().inset(Constants.Spacing.little)
        }
    }
}
