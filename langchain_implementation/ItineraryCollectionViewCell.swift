//
//  itineraryCollectionViewCell.swift
//  langchain_implementation
//
//  Created by Ashley Liu on 2023-07-26.
//

import UIKit

class ItineraryCollectionViewCell: UICollectionViewCell {
    var destinationName = UILabel()
    var finalItenerary = UIViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = UIColor(red: 0.58, green: 0.75, blue: 0.81, alpha: 1)
        contentView.layer.cornerRadius = 5
        
        destinationName.textColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        destinationName.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(destinationName)
        
        setupConstraints()
        
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            destinationName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            destinationName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    func configure(location: String, vc: UIViewController ) {
        destinationName.text = location
        finalItenerary = vc
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
