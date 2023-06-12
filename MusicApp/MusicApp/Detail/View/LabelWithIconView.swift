//
//  LabelWithIconView.swift
//  MusicApp
//
//  Created by Даниил Циркунов on 09.06.2023.
//

import UIKit
import SnapKit

class LabelWithIconView: UIView {
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = Constants.dynamicTextColor
        label.numberOfLines = 2
        return label
    }()
    
    init(icon: UIImage?, text: String) {
        super.init(frame: .zero)
        iconImageView.image = icon
        textLabel.text = text
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(iconImageView)
        addSubview(textLabel)
        
        iconImageView.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }
        
        textLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func addTextLable(text: String) {
        textLabel.text? += text
    }
}
