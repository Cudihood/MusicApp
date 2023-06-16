//
//  DetailViewController.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 01.06.2023.
//

import UIKit

final class DetailViewController: UIViewController {
    var viewModel: DetailViewModelProtocol!
    
    private var artistNameLabel = UILabel()
    private var trackNameLabel = UILabel()
    private var artistViewLabel = UILabel()
    private var trackViewLabel = UILabel()
    private var previewLabel = UILabel()
    private var releaseDateLabel = UILabel()
    private var trackTimeLabel = UILabel()
    private var primaryGenreNameLabel = UILabel()
    
    private let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = Constants.Color.red
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        return button
    }()
    
    private let trackImageVeiw: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = CGFloat(Constants.Spacing.standart)
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.updateLikeStatus()
    }
}

extension DetailViewController {
    static func viewController(selectedTrack: Track) -> DetailViewController {
        let detailVC = DetailViewController()

        detailVC.viewModel = DetailViewModel(selectedTrack: selectedTrack)
        return detailVC
    }
}

private extension DetailViewController {
    func setupUI() {
        self.view.backgroundColor = Constants.Color.background
        likeButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: likeButton)
        navigationItem.rightBarButtonItem = barButton
        bindViewModel()
        configureLabels()
        setDataUI()
        buildUI()
    }
    
    func bindViewModel() {
        viewModel.trackLikeUpdateHandler = { [weak self] isLiked in
            if isLiked {
                self?.likeButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                self?.likeButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
    }
    
    func buildUI() {
        addElementsInStackView()
        view.addSubview(trackImageVeiw)
        view.addSubview(stackView)
        
        trackImageVeiw.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(Constants.Spacing.standart)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(Constants.Size.big)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(trackImageVeiw.snp.bottom).offset(Constants.Spacing.standart)
            make.horizontalEdges.equalToSuperview().inset(Constants.Spacing.standart)
        }
    }
    
    func setDataUI() {
        let track = viewModel.selectedTrack
        artistNameLabel.text? += "\(track.artistName ?? "-")"
        trackNameLabel.text? += "\(track.trackName ?? "-")"
        artistViewLabel.text? += "\(track.artistViewURL ?? "-")"
        trackViewLabel.text? += "\(track.trackViewURL ?? "-")"
        previewLabel.text? += "\(track.previewURL ?? "-")"
        releaseDateLabel.text? += "\(dateFormatter(releaseDate: track.releaseDate))"
        trackTimeLabel.text? += "\(transformInMinute(time: track.trackTimeMillis))"
        primaryGenreNameLabel.text? += "\(track.primaryGenreName ?? "-")"
        
        trackImageVeiw.addImageFrom(url: URL(string: track.artworkUrl100 ?? ""))
    }
    
    func makeSectionLabel(with name: String) -> UILabel {
        let label = UILabel()
        label.text = name
        label.font = Constants.Font.body
        label.textColor = Constants.dynamicTextColor
        label.numberOfLines = 2
        return label
    }
    
    func configureLabels() {
        artistNameLabel = makeSectionLabel(with: "Исполнитель: ")
        trackNameLabel = makeSectionLabel(with: "Песня: ")
        artistViewLabel = makeSectionLabel(with: "Ссылка для просмотра информации об артисте: ")
        trackViewLabel = makeSectionLabel(with: "Ссылка для просмотра информачии о песне: ")
        previewLabel = makeSectionLabel(with: "Ссылка для прослушывания превью трека: ")
        releaseDateLabel = makeSectionLabel(with: "Дата выпуска трека: ")
        trackTimeLabel = makeSectionLabel(with: "Продолжительность трека: ")
        primaryGenreNameLabel = makeSectionLabel(with: "Основной жанр трека: ")
    }
    
    func transformInMinute(time: Int?) -> String {
        guard let time = time else { return "-"}
        let seconds = (time / 1000) % 60
        let minutes = (time / 1000) / 60
        let timeString = String(format: "%02d:%02d", minutes, seconds)
        return timeString
    }
    
    func dateFormatter (releaseDate: String?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        guard let releaseDate = releaseDate, let date = dateFormatter.date(from: releaseDate) else { return "-" }
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd.MM.yyyy, HH:mm"
        let formattedDate = outputFormatter.string(from: date)
        return formattedDate
    }
    
    func addElementsInStackView() {
        stackView.addArrangedSubview(artistNameLabel)
        stackView.addArrangedSubview(trackNameLabel)
        stackView.addArrangedSubview(artistViewLabel)
        stackView.addArrangedSubview(trackViewLabel)
        stackView.addArrangedSubview(previewLabel)
        stackView.addArrangedSubview(releaseDateLabel)
        stackView.addArrangedSubview(trackTimeLabel)
        stackView.addArrangedSubview(primaryGenreNameLabel)
    }
    
    @objc func buttonTapped() {
        viewModel.likeButtonTapped()
    }
}
