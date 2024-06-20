//
//  EarthquakeInfoView.swift
//  EarthQuakeApp_Ijaza
//
//  Created by Martha on 19/06/2024.
//

import UIKit

class EarthquakeInfoView: UIView {
    
    private let magnitudeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()

    private let placeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        return label
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .systemGray
        return label
    }()

    private let depthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    private let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.backgroundColor = .systemBlue
        label.textColor = .white
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        return view
    }()

    // Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupEarthquakeInfoDisplay()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupEarthquakeInfoDisplay() {
        addSubview(magnitudeLabel)
        addSubview(placeLabel)
        addSubview(depthLabel)
        addSubview(separatorView)
        addSubview(timeLabel)
        addSubview(numberLabel)
        
        
        NSLayoutConstraint.activate([
            // Separator View
            separatorView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 240),
            separatorView.widthAnchor.constraint(equalToConstant: 5),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            // Time Label
            timeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 36),
            timeLabel.leadingAnchor.constraint(equalTo: separatorView.trailingAnchor, constant: 16),
            timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            // Number Label
            numberLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 8),
            numberLabel.leadingAnchor.constraint(equalTo: separatorView.trailingAnchor, constant: 12),
            numberLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            numberLabel.widthAnchor.constraint(equalToConstant: 50),
            numberLabel.heightAnchor.constraint(equalToConstant: 30),
            
            // Magnitude Label
            magnitudeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            magnitudeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            magnitudeLabel.trailingAnchor.constraint(equalTo: separatorView.leadingAnchor, constant: -16),
            
            // Place Label
            placeLabel.topAnchor.constraint(equalTo: magnitudeLabel.bottomAnchor, constant: 4),
            placeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            placeLabel.trailingAnchor.constraint(equalTo: separatorView.leadingAnchor, constant: -16),
            
            // Depth Label
            depthLabel.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: 4),
            depthLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            depthLabel.trailingAnchor.constraint(equalTo: separatorView.leadingAnchor, constant: -16),
            depthLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }

    func configureCellDisplay(with earthquake: Earthquake) {
        magnitudeLabel.text = "Magnitude: \(earthquake.magnitude)"
        placeLabel.text = earthquake.place
        depthLabel.text = "Depth: \(earthquake.depth) km"
        numberLabel.text = "No.\(earthquake.number)"
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        timeLabel.text = formatter.string(from: earthquake.time)
    }
}
