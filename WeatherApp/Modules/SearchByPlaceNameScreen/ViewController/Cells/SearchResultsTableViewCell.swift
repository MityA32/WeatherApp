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
        contentView.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(model.city), \(model.country)"
        label.textColor = .black
        label.textAlignment = .center
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
