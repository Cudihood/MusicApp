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
    
    private let imageFilmView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let artistLable: UILabel = {
        let lable = UILabel()
        lable.textColor = Constans.dynamicTextColor
        lable.font = UIFont.preferredFont(forTextStyle: .title2)
        lable.textAlignment = .left
        return lable
    }()
    
    private let trackLable: UILabel = {
        let lable = UILabel()
        lable.textColor = Constans.dynamicTextColor
        lable.font = UIFont.preferredFont(forTextStyle: .title1)
        lable.textAlignment = .left
        return lable
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    func setCell(model: SearchMusicTableViewCellModel) {
        imageFilmView.image = model.image
        trackLable.text = model.track
        artistLable.text = model.artist
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SearchMusicTableViewCell
{
    func configure() {
        self.backgroundColor = .systemBackground
        buildUI()
    }
    
    func buildUI() {
        self.contentView.addSubview(imageFilmView)
        self.contentView.addSubview(trackLable)
        self.contentView.addSubview(artistLable)
        
        imageFilmView.snp.makeConstraints { make in
            make.top.bottom.left.equalToSuperview().inset(16)
            make.height.equalTo(70)
            make.width.equalTo(70)
        }
        
        trackLable.snp.makeConstraints { make in
            make.left.equalTo(imageFilmView.snp.right).offset(16)
            make.top.right.equalToSuperview().inset(16)
        }
        
        artistLable.snp.makeConstraints { make in
            make.left.equalTo(imageFilmView.snp.right).offset(16)
            make.top.equalTo(trackLable.snp.bottom).offset(6)
            make.right.equalToSuperview().inset(16)
        }
    }
}
