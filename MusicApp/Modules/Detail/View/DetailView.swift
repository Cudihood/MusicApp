//
//  DetailView.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 01.06.2023.
//

import UIKit

final class DetailView: UIView {
    private var viewModel: DetailViewModelProtocol
    private var artistNameLabel = UILabel()
    private var trackNameLabel = UILabel()
    private var artistViewLabel = UILabel()
    private var trackViewLabel = UILabel()
    private var previewLabel = UILabel()
    private var releaseDateLabel = UILabel()
    private var trackTimeLabel = UILabel()
    private var primaryGenreNameLabel = UILabel()
    
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
    
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .systemBlue
        return view
    }()
    
    init(model: DetailViewModelProtocol) {
        self.viewModel = model
        super.init(frame: .zero)
        self.configure()
        self.setDataUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension DetailView {
    
    func configure() {
        self.backgroundColor = Constants.Color.background
        configureLabels()
        buildUI()
    }
    
    func buildUI() {
        self.addSubview(trackImageVeiw)
        self.addSubview(stackView)
        
        self.stackView.addArrangedSubview(artistNameLabel)
        self.stackView.addArrangedSubview(trackNameLabel)
        self.stackView.addArrangedSubview(artistViewLabel)
        self.stackView.addArrangedSubview(trackViewLabel)
        self.stackView.addArrangedSubview(previewLabel)
        self.stackView.addArrangedSubview(releaseDateLabel)
        self.stackView.addArrangedSubview(trackTimeLabel)
        self.stackView.addArrangedSubview(primaryGenreNameLabel)
        
        self.trackImageVeiw.addSubview(activityIndicator)
        
        trackImageVeiw.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).inset(Constants.Spacing.standart)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(Constants.Size.big)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(trackImageVeiw.snp.bottom).offset(Constants.Spacing.standart)
            make.horizontalEdges.equalToSuperview().inset(Constants.Spacing.standart)
        }
    }
    
    func setDataUI() {
        activityIndicator.startAnimating()
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
}
