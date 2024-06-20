//
//  EarthQuakeInfoVC.swift
//  EarthQuakeApp_Ijaza
//
//  Created by Martha on 18/06/2024.
//

import UIKit
import RxSwift
import RxCocoa

class EarthQuakeInfoVC: UIViewController {

    private let tableView = UITableView()
    private let earthquakeViewModel = EarthquakeViewModel()
    private let disposeBag = DisposeBag()
    private var earthquakes: [Earthquake] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        setupTableView()
        bindViewModel()
    }

    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Earthquake Info"
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(EarthquakeCell.self, forCellReuseIdentifier: EarthquakeCell.reuseIdentifier)
        tableView.delegate = self

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func bindViewModel() {
        earthquakeViewModel.getEarthquakeInfo()
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: EarthquakeCell.reuseIdentifier, cellType: EarthquakeCell.self)) { index, earthquake, cell in
                cell.configure(with: earthquake)

                // Configure cell appearance
                if index % 2 == 0 {
                    cell.contentView.backgroundColor = .systemGray6 // Light color
                    cell.contentView.layer.shadowColor = UIColor.black.cgColor
                    cell.contentView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
                    cell.contentView.layer.shadowOpacity = 0.4
                    cell.contentView.layer.shadowRadius = 5.0
                    cell.contentView.layer.masksToBounds = false
                    cell.contentView.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
                } else {
                    cell.contentView.backgroundColor = .white // Darker color or default
                }
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Earthquake.self)
            .subscribe(onNext: { [weak self] earthquake in
                if let url = URL(string: earthquake.url) {
                    UIApplication.shared.open(url)
                }
            })
            .disposed(by: disposeBag)
    }
}

extension EarthQuakeInfoVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // Adjust as needed
    }
}


