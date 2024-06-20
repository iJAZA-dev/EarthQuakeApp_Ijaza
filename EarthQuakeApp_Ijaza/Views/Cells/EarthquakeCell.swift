//
//  EarthquakeTableViewCell.swift
//  EarthQuakeApp_Ijaza
//
//  Created by Martha on 18/06/2024.
//

import UIKit

class EarthquakeCell: UITableViewCell {

    static let reuseIdentifier = "EarthquakeCell"

    private let earthquakeInfoView = EarthquakeInfoView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCellView() {
        contentView.addSubview(earthquakeInfoView)
        earthquakeInfoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            earthquakeInfoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            earthquakeInfoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            earthquakeInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            earthquakeInfoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func configure(with earthquake: Earthquake) {
        earthquakeInfoView.configureCellDisplay(with: earthquake)
    }
}
