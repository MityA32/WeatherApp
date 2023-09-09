//
//  SearchPlaceByTextNavigationBarView.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 08.09.2023.
//

import UIKit

class SearchPlaceByTextNavigationBarView: UIView {

    let backButtonImageView = UIImageView()
    let textField = UITextField()
    let searchImageView = UIImageView()
    weak var delegate: PopViewControllerDelegate?
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }
    
    func setupViews() {
        setupBackButton()
        setupTextField()
        setupSearchImageView()
        NSLayoutConstraint.activate([
            backButtonImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            backButtonImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            backButtonImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            backButtonImageView.widthAnchor.constraint(equalTo: backButtonImageView.heightAnchor),
            
            
            searchImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            searchImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchImageView.widthAnchor.constraint(equalTo: backButtonImageView.heightAnchor),
            
            textField.leadingAnchor.constraint(equalTo: backButtonImageView.trailingAnchor, constant: 10),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            textField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
            textField.trailingAnchor.constraint(equalTo: searchImageView.leadingAnchor, constant: -10)
            
        ])
    }
    
    func setupBackButton() {
        backButtonImageView.translatesAutoresizingMaskIntoConstraints = false
        backButtonImageView.image = AssetImage.back?.withTintColor(.white, renderingMode: .alwaysOriginal)
        backButtonImageView.contentMode = .scaleAspectFit
        addSubview(backButtonImageView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        backButtonImageView.isUserInteractionEnabled = true
        backButtonImageView.addGestureRecognizer(tapGesture)
    }
    
    func setupTextField() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);
        textField.textColor = .black
        addSubview(textField)
    }
    
    func setupSearchImageView() {
        searchImageView.translatesAutoresizingMaskIntoConstraints = false
        searchImageView.image = AssetImage.search
        searchImageView.contentMode = .scaleAspectFill
        addSubview(searchImageView)
    }
    
    @objc
    private func backButtonTapped() {
        delegate?.popViewController()
    }
}

