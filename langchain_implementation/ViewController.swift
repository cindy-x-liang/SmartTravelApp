//
//  ViewController.swift
//  langchain_implementation
//
//  Created by Cindy Liang on 7/15/23.
//

import UIKit
import Foundation
import LangChain
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate{
    
    let tempBot = chatBot()
    let response = UILabel()
    var models = [String]()
    
    private let userInput: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter vacay deets"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .blue
        textField.returnKeyType = .done
        return textField
    }()
    
    private let table: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        view.addSubview(userInput)
        
        userInput.delegate = self
        table.delegate = self
        table.dataSource = self
        
        view.addSubview(table)
        
        
        response.text = ""
        response.numberOfLines = 20
        response.font = .systemFont(ofSize: 12, weight: .regular)
        response.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(response)
        
        
        setupConstraints()
        
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            userInput.heightAnchor.constraint (equalToConstant: 50),
            userInput.leftAnchor.constraint (equalTo: view.safeAreaLayoutGuide.leftAnchor,
            constant: 10),
            userInput.rightAnchor.constraint (equalTo: view.safeAreaLayoutGuide.rightAnchor,
            constant: -10),
            userInput.bottomAnchor.constraint (equalTo:
            view.keyboardLayoutGuide.topAnchor)
        ])
        
       
        NSLayoutConstraint.activate([
            table.leftAnchor.constraint (equalTo: view.safeAreaLayoutGuide.leftAnchor),
            table.rightAnchor.constraint (equalTo: view.safeAreaLayoutGuide.rightAnchor),
            table.topAnchor.constraint (equalTo: view.safeAreaLayoutGuide .topAnchor),
            table.bottomAnchor.constraint (equalTo: userInput.topAnchor)
        ])
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row]
        cell.textLabel?.numberOfLines = 20
        return cell
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, !text.isEmpty{
            var chatResponse = ""
            Task{
                chatResponse = await tempBot.run(userInput: text)
                self.models.append(chatResponse)
                DispatchQueue.main.async{
                    self.table.reloadData()
                }
            }
            
        }
        return true
    }
    

}

