//
//  SearchMusicTableViewCell.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 30.05.2023.
//

import UIKit
import SnapKit

final class SearchMusicTableViewCell: UITableViewCell {
    static let reuseIdentifier = "SearchCell"
    
    private let imageTrackView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Constants.Size.cornerRadius
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let artistLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.dynamicTextColor
        label.font = Constants.Font.title2
        label.textAlignment = .left
        return label
    }()
    
    private let trackLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.dynamicTextColor
        label.font = Constants.Font.title1
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackLabel.text = nil
        artistLabel.text = nil
        imageTrackView.image = nil
    }
    
    func setupViews() {
        self.backgroundColor = Constants.Color.background
        self.contentView.addSubview(imageTrackView)
        self.contentView.addSubview(trackLabel)
        self.contentView.addSubview(artistLabel)
        
        imageTrackView.snp.makeConstraints { make in
            make.top.bottom.left.equalToSuperview().inset(Constants.Spacing.standart)
            make.width.equalTo(Constants.Size.little)
        }
        
        trackLabel.snp.makeConstraints { make in
            make.left.equalTo(imageTrackView.snp.right).offset(Constants.Spacing.standart)
            make.top.right.equalToSuperview().inset(Constants.Spacing.standart)
        }
        
        artistLabel.snp.makeConstraints { make in
            make.left.equalTo(imageTrackView.snp.right).offset(Constants.Spacing.standart)
            make.top.equalTo(trackLabel.snp.bottom).offset(Constants.Spacing.little)
            make.right.equalToSuperview().inset(Constants.Spacing.standart)
            make.bottom.lessThanOrEqualToSuperview().inset(Constants.Spacing.standart)
        }
    }
    
    func configure(with model: SearchMusicTableViewCellModel) {
        trackLabel.text = model.trackTitle
        artistLabel.text = model.artistName
        imageTrackView.addImageFrom(url: model.artworkUrl60)
    }
}
