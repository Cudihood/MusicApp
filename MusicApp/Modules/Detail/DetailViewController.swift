//
//  DetailViewController.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 01.06.2023.
//

import UIKit

fileprivate enum DetailVCRows: Int, CaseIterable {
    case artistName
    case trackName
    case releaseDate
    case trackTimeMillis
    case primaryGenreName
    case artistViewURL
    case trackViewURL
    case previewURL
}

final class DetailViewController: UITableViewController {
    var viewModel: DetailViewModelProtocol!
    
    private let cellReuseIdentifier = "DetailCell"
    
    private let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = Constants.Color.red
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        return button
    }()
    
    private let trackImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.updateLikeStatus()
    }
}

extension DetailViewController {
    static func viewController(selectedTrack: Track) -> DetailViewController {
        let detailVC = DetailViewController(style: .grouped)
        detailVC.viewModel = DetailViewModel(selectedTrack: selectedTrack)
        return detailVC
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension DetailViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DetailVCRows.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.numberOfLines = 0
        switch DetailVCRows(rawValue: indexPath.row) {
        case .artistName:
            cell.imageView?.image = UIImage(systemName: "person.fill")
            cell.textLabel?.text = "Исполнитель: \(viewModel.selectedTrack.artistName ?? "-")"
        case .trackName:
            cell.imageView?.image = UIImage(systemName: "music.note")
            cell.textLabel?.text = "Песня: \(viewModel.selectedTrack.trackName ?? "-")"
        case .releaseDate:
            cell.imageView?.image = UIImage(systemName: "calendar")
            cell.textLabel?.text = "Дата выпуска трека: \(dateFormatter(releaseDate: viewModel.selectedTrack.releaseDate))"
        case .trackTimeMillis:
            cell.imageView?.image = UIImage(systemName: "timer")
            cell.textLabel?.text = "Продолжительность трека: \(transformInMinute(time: viewModel.selectedTrack.trackTimeMillis))"
        case .primaryGenreName:
            cell.imageView?.image = UIImage(systemName: "music.quarternote.3")
            cell.textLabel?.text = "Основной жанр трека: \(viewModel.selectedTrack.primaryGenreName ?? "-")"
        case .artistViewURL:
            cell.imageView?.image = UIImage(systemName: "globe")
            let linkText = "Ссылка для просмотра информации об артисте"
            let linkURL = viewModel.selectedTrack.artistViewURL ?? "-"
            let attributedText = createAttributedText(linkText: linkText, linkURL: linkURL)
            cell.textLabel?.attributedText = attributedText
        case .trackViewURL:
            cell.imageView?.image = UIImage(systemName: "globe")
            let linkText = "Ссылка для просмотра информачии о песне"
            let linkURL = viewModel.selectedTrack.trackViewURL ?? "-"
            let attributedText = createAttributedText(linkText: linkText, linkURL: linkURL)
            cell.textLabel?.attributedText = attributedText
        case .previewURL:
            cell.imageView?.image = UIImage(systemName: "globe")
            let linkText = "Ссылка для прослушывания превью трека"
            let linkURL = viewModel.selectedTrack.previewURL ?? "-"
            let attributedText = createAttributedText(linkText: linkText, linkURL: linkURL)
            cell.textLabel?.attributedText = attributedText
        default:
            break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch DetailVCRows(rawValue: indexPath.row) {
        case .artistViewURL:
            openURL(viewModel.selectedTrack.artistViewURL)
        case .trackViewURL:
            openURL(viewModel.selectedTrack.trackViewURL)
        case .previewURL:
            openURL(viewModel.selectedTrack.previewURL)
        default:
            break
        }
    }
}

// MARK: - Private extension

private extension DetailViewController {
    func configure() {
        setupTableView()
        bindViewModel()
        setupHeader()
        setupLikeButton()
    }
    
    func setupTableView() {
        tableView.backgroundColor = Constants.Color.background
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
    
    func setupHeader() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: Int(tableView.bounds.width), height: Constants.Size.big))
        headerView.addSubview(trackImageView)
        trackImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constants.Spacing.standart)
        }
        tableView.tableHeaderView = headerView
        trackImageView.addImageFrom(url: URL(string: viewModel.selectedTrack.artworkUrl100 ?? ""))
    }
    
    func setupLikeButton() {
        likeButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: likeButton)
        navigationItem.rightBarButtonItem = barButton
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
    
    func transformInMinute(time: Int?) -> String {
        guard let time = time else { return "-" }
        let seconds = (time / 1000) % 60
        let minutes = (time / 1000) / 60
        let timeString = String(format: "%02d:%02d", minutes, seconds)
        return timeString
    }
    
    func dateFormatter(releaseDate: String?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        guard let releaseDate = releaseDate, let date = dateFormatter.date(from: releaseDate) else { return "-" }
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd.MM.yyyy, HH:mm"
        let formattedDate = outputFormatter.string(from: date)
        return formattedDate
    }
    
    func openURL(_ urlString: String?) {
        if let url = URL(string: urlString ?? "") {
            UIApplication.shared.open(url)
        }
    }
    
    func createAttributedText(linkText: String, linkURL: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: linkText)
        let range = NSRange(location: 0, length: attributedString.length)
        attributedString.addAttribute(.link, value: linkURL, range: range)
        return attributedString
    }
    
    @objc func buttonTapped() {
        viewModel.likeButtonTapped()
    }
}
