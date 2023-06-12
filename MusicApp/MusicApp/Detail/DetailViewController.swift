//
//  DetailViewController.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 01.06.2023.
//

import UIKit

final class DetailViewController: UIViewController
{
    private var customView: DetailView
    private var model: DetailViewModelProtocol
    
    private let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        return button
    }()
    
    init(model: DetailViewModel) {
        self.model = model
        self.customView = DetailView(model: model)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        super.loadView()
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension DetailViewController
{
    func configure() {
        self.view.backgroundColor = Constants.Color.systemBackground
        likeButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: likeButton)
        navigationItem.rightBarButtonItem = barButton
        bindViewModel()
    }
    
    func bindViewModel() {
        model.trackLikeUpdateHandler = { [weak self] isLiked in
            if isLiked {
                self?.likeButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                self?.likeButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
    }
    
    @objc func buttonTapped() {
//        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        model.likeButtonTapped()
    }
}
