//
//  SearchResultsTableViewCell.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 09.09.2023.
//

import UIKit

class SearchResultsTableViewCell: UITableViewCell {

    static let id = "\(SearchResultsTableViewCell.self)"
    
    let label = UILabel()
    
    func config(from model: Place) {
        contentView.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        var labelText = model.city
        if !model.country.isEmpty {
            labelText.append(", \(model.country)")
        }
        label.text = labelText
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
