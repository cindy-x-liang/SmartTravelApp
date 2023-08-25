//
//  ChatTableViewCell.swift
//  langchain_implementation
//
//  Created by Ashley Liu on 2023-08-03.
//

import UIKit
import SwiftUI

class ChatTableViewCell: UITableViewCell {

    var chat = UIButton()
    var cellConfiguration = UIButton.Configuration.plain()

     
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        
        cellConfiguration.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10)
        chat.configuration = cellConfiguration
        //chat.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        chat.isUserInteractionEnabled = false
        chat.setTitleColor(.black, for: .normal)
        chat.layer.cornerRadius = 10
        chat.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(chat)
        
        
        
        //setupConstraints()
    }
    
    func configure1(chatInput: String, index: Int) {
        if (index % 2 == 0) {
            chat.setTitle(chatInput, for: .normal)
            chat.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            //chat.numberOfLines = 0
        }
        else {
            chat.setTitle(chatInput, for: .normal)
            chat.backgroundColor = UIColor(red: 0.58, green: 0.75, blue: 0.81, alpha: 1)
            //chat.setTitleColor(.white, for: .normal)

            //chat.numberOfLines = 0
        }
        NSLayoutConstraint.activate([
            chat.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            chat.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            chat.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            chat.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    func configure2(chatInput: String, index: Int) {
        if (index % 2 == 0) {
            chat.setTitle(chatInput, for: .normal)
            chat.backgroundColor = UIColor(red: 0.58, green: 0.75, blue: 0.81, alpha: 1)
            //chat.numberOfLines = 0
        }
        else {
            chat.setTitle(chatInput, for: .normal)
            chat.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            //chat.setTitleColor(.white, for: .normal)

            //chat.numberOfLines = 0
        }
        NSLayoutConstraint.activate([
            chat.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            chat.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            chat.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            chat.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
//    func configure2(chatInput: String) {
//        chat.setTitle(chatInput, for: .normal)
//        chat.backgroundColor = UIColor(red: 0.58, green: 0.75, blue: 0.81, alpha: 1)
//        chat.setTitleColor(.white, for: .normal)
//
//        //chat.numberOfLines = 0
//        NSLayoutConstraint.activate([
//            chat.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
//            chat.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
//            chat.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
//            chat.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
//        ])
//    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
