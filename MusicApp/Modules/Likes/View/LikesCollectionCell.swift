//
//  FavoriteMusicCollectionCell.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 30.05.2023.
//

import UIKit
import SnapKit

final class LikesCollectionCell: UICollectionViewCell {
    static let reuseIdentifier = "Cell"
    
    private var imageTrackView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Constants.Size.cornerRadius
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let trackLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = Constants.Font.title2
        label.textAlignment = .left
        return label
    }()
    
    private let artistLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = Constants.Font.title3
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
      
    override func prepareForReuse() {
        super.prepareForReuse()
        imageTrackView.image = nil
        trackLabel.text = nil
        artistLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: LikesCollectionCellModel) {
        trackLabel.text = model.trackTitle
        artistLabel.text = model.artistName
        imageTrackView.addImageFrom(url: model.artworkUrl100)
    }
}

// MARK: - Private extension

private extension LikesCollectionCell {
    func setupViews() {
        self.backgroundColor = Constants.Color.background
        self.contentView.addSubview(imageTrackView)
        self.contentView.addSubview(trackLabel)
        self.contentView.addSubview(artistLabel)
        
        imageTrackView.snp.makeConstraints { make in
            make.top.trailing.leading.equalToSuperview().inset(Constants.Spacing.standart)
        }
        
        trackLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.Spacing.little)
            make.top.equalTo(imageTrackView.snp.bottom).offset(Constants.Spacing.little)
        }
        
        artistLabel.snp.makeConstraints { make in
            make.top.equalTo(trackLabel.snp.bottom).offset(Constants.Spacing.little)
            make.leading.trailing.equalToSuperview().inset(Constants.Spacing.little)
        }
    }
}
