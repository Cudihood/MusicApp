//
//  SearchMusicTableViewCell.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 30.05.2023.
//

import UIKit
import SnapKit

final class SearchMusicTableViewCell: UITableViewCell
{
    static let reuseIdentifier = "SearchCell"
 
    private var model: SearchMusicTableViewCellModel? {
        didSet {
            setCell(model: model)
        }
    }
    
    private let imageTrackView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Constants.Size.cornerRadius
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let artistLable: UILabel = {
        let lable = UILabel()
        lable.textColor = Constants.dynamicTextColor
        lable.font = Constants.Font.title2
        lable.textAlignment = .left
        return lable
    }()
    
    private let trackLable: UILabel = {
        let lable = UILabel()
        lable.textColor = Constants.dynamicTextColor
        lable.font = Constants.Font.title1
        lable.textAlignment = .left
        return lable
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    func setModel(model: SearchMusicTableViewCellModel?) {
        self.model = model
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SearchMusicTableViewCell
{
    func configure() {
        self.backgroundColor = Constants.Color.background
        buildUI()
    }
    
    func buildUI() {
        self.contentView.addSubview(imageTrackView)
        self.contentView.addSubview(trackLable)
        self.contentView.addSubview(artistLable)
        
        imageTrackView.snp.makeConstraints { make in
            make.top.bottom.left.equalToSuperview().inset(Constants.Spacing.standart)
            make.width.equalTo(Constants.Size.little)
        }
        
        trackLable.snp.makeConstraints { make in
            make.left.equalTo(imageTrackView.snp.right).offset(Constants.Spacing.standart)
            make.top.right.equalToSuperview().inset(Constants.Spacing.standart)
        }
        
        artistLable.snp.makeConstraints { make in
            make.left.equalTo(imageTrackView.snp.right).offset(Constants.Spacing.standart)
            make.top.equalTo(trackLable.snp.bottom).offset(Constants.Spacing.little)
            make.right.equalToSuperview().inset(Constants.Spacing.standart)
            make.bottom.lessThanOrEqualToSuperview().inset(Constants.Spacing.standart)
        }
    }
    
    func setCell(model: SearchMusicTableViewCellModel?) {
        trackLable.text = model?.trackTitle
        artistLable.text = model?.artistName
        
        model?.fetchImageTrack { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.imageTrackView.image = image
            }
        }
    }
}
