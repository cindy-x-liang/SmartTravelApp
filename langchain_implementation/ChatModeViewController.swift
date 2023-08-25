//
//  ChatModeViewController.swift
//  langchain_implementation
//
//  Created by Helen Lei on 7/22/23.
//

import UIKit
import Foundation
import LangChain

class ChatModeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    
    let tempBot = chatBot()
    let response = UILabel()
    var models = [String]()
    
    var finalItinerary = String()
    var counter = 0
    
    var finalChat = String()
    
    var location = String()
    var date = String()
    var purpose = String()
    var length = String()
    
    weak var delegate: finalIteneraryFromChat?
    
    init(delegateInfo: finalIteneraryFromChat) {
        delegate = delegateInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //dummy data
//    var location = "Dallas, Texas"
//    var date = "july 4"
//    var purpose = "celebrating the fourth of july"
    
    
    private let userInput: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Enter vacay deets"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(red: 0.954, green: 0.954, blue: 0.954, alpha: 1)
        textField.returnKeyType = .done
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    private let doneButton: UIButton = {
        let doneButton = UIButton()
        doneButton.setTitle("Done", for: .normal)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.backgroundColor = UIColor(red: 0.741, green: 0.804, blue: 0.839, alpha: 1)
        doneButton.addTarget(self, action: #selector(goForward), for: .touchUpInside)
        doneButton.layer.cornerRadius = 5
        return doneButton
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.text = " AI Travel \n Agent"
        titleLabel.textColor = .black
        titleLabel.textColor = UIColor(red: 0.32, green: 0.32, blue: 0.32, alpha: 1)
        titleLabel.font = .systemFont(ofSize: 50, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private let table: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ChatTableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(doneButton)
        view.addSubview(userInput)
        view.addSubview(titleLabel)
        
        userInput.delegate = self
        table.delegate = self
        table.dataSource = self
        
        view.addSubview(table)
        
        
        response.text = ""
        response.numberOfLines = 20
        response.font = .systemFont(ofSize: 12, weight: .regular)
        response.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(response)
        
        initialPrompt()
        
        setupConstraints()
        
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            userInput.heightAnchor.constraint (equalToConstant: 50),
            userInput.leftAnchor.constraint (equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30),
            userInput.bottomAnchor.constraint (equalTo:
            view.keyboardLayoutGuide.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            doneButton.heightAnchor.constraint (equalToConstant: 50),
            doneButton.rightAnchor.constraint (equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30),
            doneButton.bottomAnchor.constraint (equalTo:
            view.keyboardLayoutGuide.topAnchor)
        ])
       
        NSLayoutConstraint.activate([
            table.leftAnchor.constraint (equalTo: view.safeAreaLayoutGuide.leftAnchor),
            table.rightAnchor.constraint (equalTo: view.safeAreaLayoutGuide.rightAnchor),
            table.topAnchor.constraint (equalTo: titleLabel.bottomAnchor, constant: 10),
            table.bottomAnchor.constraint (equalTo: userInput.topAnchor)
        ])
        
    }
    @objc func initialPrompt() {
        var initialInput = "I want to go to " + location + " on " + date + " for the purpose of " + purpose + " for " + length + " days."
        self.models.append(initialInput)
        var chatResponse = ""
        Task{
            chatResponse = await tempBot.run(userInput: "output itenerary for user's indicated length and destination of travel \(initialInput)")
            self.models.append(chatResponse)
            finalChat = chatResponse
            DispatchQueue.main.async{
                self.table.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = models[indexPath.row]
//        cell.textLabel?.numberOfLines = 20
//        return cell
        
        
        if let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ChatTableViewCell {
            cell.configure1(chatInput: models[indexPath.row], index: indexPath.row)

            //cell.textLabel?.numberOfLines = 20
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, !text.isEmpty{
            self.models.append(text)
            self.table.reloadData()
            var chatResponse = ""
            Task{
                chatResponse = await tempBot.run(userInput: text)
                self.models.append(chatResponse)
                finalChat = chatResponse
                DispatchQueue.main.async{
                    self.table.reloadData()
                }
            }
            textField.text = ""
        }
        return true
    }
    
    @objc func goForward() {
        let secondVC = ItineraryViewController()
        secondVC.itineraryText = finalChat
        secondVC.itineraryDestination = location
        secondVC.itineraryDate = date
        secondVC.itineraryPurpose = purpose
        self.navigationController?.pushViewController(secondVC, animated: true)
        delegate?.addFinal(vc: secondVC, name: location)
        //self.navigationController?.pushViewController(secondVC, animated: true)
    }
    

}
protocol finalIteneraryFromChat: UIViewController {
    func addFinal(vc: UIViewController, name: String)
    
}
