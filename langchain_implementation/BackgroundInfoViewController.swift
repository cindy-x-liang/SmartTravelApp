//
//  BackgroundInfoViewController.swift
//  langchain_implementation
//
//  Created by Helen Lei on 7/30/23.
//


import UIKit
import Foundation
import LangChain

class BackgroundInfoViewController: UIViewController, UITextFieldDelegate, finalIteneraryFromChat {
    
    
    var finalItemVC = UIViewController()
    let tempBot = chatBot()
    let response = UILabel()
    var models = [String]()
    
    weak var delegate: finalIteneraryFromBackground?
    
    init(delegateInfo: finalIteneraryFromBackground) {
        delegate = delegateInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    init(inputDelegate: ProvideInfoDelegate) {
//        delegate = inputDelegate
//        super.init(nibName: nil, bundle: nil)
//    }
    func addFinal(vc: UIViewController, name: String) {
        finalItemVC = vc
        delegate?.addFinal(vc: finalItemVC, place: name )
        
    }
    private let doneButton: UIButton = {
        let doneButton = UIButton()
        doneButton.setTitle("Done", for: .normal)
        doneButton.addTarget(self, action: #selector(goForward), for: .touchUpInside)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.backgroundColor = UIColor(red: 0.741, green: 0.804, blue: 0.839, alpha: 1)
        doneButton.layer.cornerRadius = 5
        return doneButton
    }()
    
    private let backButton: UIButton = {
        let backButton = UIButton()
        backButton.setTitle("Back", for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.backgroundColor = UIColor(red: 0.741, green: 0.804, blue: 0.839, alpha: 1)
        backButton.layer.cornerRadius = 5
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        return backButton
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.text = " Let's plan \n your travel"
        titleLabel.textColor = UIColor(red: 0.32, green: 0.32, blue: 0.32, alpha: 1)
        titleLabel.font = .systemFont(ofSize: 50, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private let instructionsLabel: UILabel = {
        let instructionsLabel = UILabel()
        instructionsLabel.numberOfLines = 0
        instructionsLabel.text = " Answer a few questions \n to get started"
        instructionsLabel.textColor = UIColor(red: 0.32, green: 0.32, blue: 0.32, alpha: 1)
        instructionsLabel.font = .systemFont(ofSize: 25)
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        return instructionsLabel
    }()
    
    private let whereLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = " Where are you headed?"
        label.textColor = UIColor(red: 0.32, green: 0.32, blue: 0.32, alpha: 1)
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let whatLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = " What is the purpose?"
        label.textColor = UIColor(red: 0.32, green: 0.32, blue: 0.32, alpha: 1)
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let whenLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = " When are you travelling?"
        label.textColor = UIColor(red: 0.32, green: 0.32, blue: 0.32, alpha: 1)
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let howLongLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = " How long are you travelling?"
        label.textColor = UIColor(red: 0.32, green: 0.32, blue: 0.32, alpha: 1)
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let chatButton: UIButton = {
        let chatButton = UIButton()
        let title = " Chat with our agent if you don't know where \n you're going"
        let titleAttributes: [NSAttributedString.Key : Any] = [
            .font : UIFont.systemFont(ofSize: 15),
            .foregroundColor : UIColor(red: 0.321, green: 0.321, blue: 0.321, alpha: 1),
            .underlineStyle : NSUnderlineStyle.single.rawValue
        ]
        let attributedTitle = NSAttributedString(string: title, attributes: titleAttributes)
        chatButton.setAttributedTitle(attributedTitle, for: .normal)
        chatButton.titleLabel?.lineBreakMode = .byWordWrapping
        chatButton.titleLabel?.numberOfLines = 0
        chatButton.translatesAutoresizingMaskIntoConstraints = false
        chatButton.backgroundColor = .white
        chatButton.layer.cornerRadius = 5
        chatButton.addTarget(self, action: #selector(locationHelp), for: .touchUpInside)
        return chatButton
    }()
    
    private let whereInput: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(red: 0.954, green: 0.954, blue: 0.954, alpha: 1)
        textField.returnKeyType = .done
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    private let whatInput: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(red: 0.954, green: 0.954, blue: 0.954, alpha: 1)
        textField.returnKeyType = .done
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    private let whenInput: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(red: 0.954, green: 0.954, blue: 0.954, alpha: 1)
        textField.returnKeyType = .done
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    private let howlongInput: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(red: 0.954, green: 0.954, blue: 0.954, alpha: 1)
        textField.returnKeyType = .done
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    private let alert: UIAlertController = {
        let alert = UIAlertController()
        alert.title = "Not all information entered"
        alert.message = "Please enter information in all fields. If you need help finding a location please chat with our agent."
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        return alert
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        view.addSubview(doneButton)
        view.addSubview(titleLabel)
        view.addSubview(instructionsLabel)
        view.addSubview(whereLabel)
        view.addSubview(chatButton)
        view.addSubview(whereInput)
        view.addSubview(whatLabel)
        view.addSubview(whatInput)
        view.addSubview(whenLabel)
        view.addSubview(whenInput)
        view.addSubview(howLongLabel)
        view.addSubview(howlongInput)
        view.addSubview(backButton)
        
        whereInput.delegate = self
        
        response.text = ""
        response.numberOfLines = 20
        response.font = .systemFont(ofSize: 12, weight: .regular)
        response.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(response)
    
        setupConstraints()
        
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            instructionsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            instructionsLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            whereLabel.topAnchor.constraint(equalTo: instructionsLabel.bottomAnchor, constant: 20),
            whereLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            chatButton.topAnchor.constraint(equalTo: whereLabel.bottomAnchor, constant: 3),
            chatButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            whereInput.heightAnchor.constraint (equalToConstant: 35),
            whereInput.leftAnchor.constraint (equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30),
            whereInput.rightAnchor.constraint (equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30),
            whereInput.topAnchor.constraint(equalTo: chatButton.bottomAnchor, constant: 3)
        ])
        
        NSLayoutConstraint.activate([
            whatLabel.topAnchor.constraint(equalTo: whereInput.bottomAnchor, constant: 20),
            whatLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            whatInput.heightAnchor.constraint (equalToConstant: 35),
            whatInput.leftAnchor.constraint (equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30),
            whatInput.rightAnchor.constraint (equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30),
            whatInput.topAnchor.constraint(equalTo: whatLabel.bottomAnchor, constant: 3)
        ])
        
        NSLayoutConstraint.activate([
            whenLabel.topAnchor.constraint(equalTo: whatInput.bottomAnchor, constant: 20),
            whenLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            whenInput.heightAnchor.constraint (equalToConstant: 35),
            whenInput.leftAnchor.constraint (equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30),
            whenInput.rightAnchor.constraint (equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30),
            whenInput.topAnchor.constraint(equalTo: whenLabel.bottomAnchor, constant: 3)
        ])
        
        NSLayoutConstraint.activate([
            howLongLabel.topAnchor.constraint(equalTo: whenInput.bottomAnchor, constant: 20),
            howLongLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            howlongInput.heightAnchor.constraint (equalToConstant: 35),
            howlongInput.leftAnchor.constraint (equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30),
            howlongInput.rightAnchor.constraint (equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30),
            howlongInput.topAnchor.constraint(equalTo: howLongLabel.bottomAnchor, constant: 3)
        ])
        
        NSLayoutConstraint.activate([
            doneButton.heightAnchor.constraint (equalToConstant: 50),
            doneButton.widthAnchor.constraint(equalToConstant: 150),
            doneButton.rightAnchor.constraint (equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30),
            doneButton.bottomAnchor.constraint (equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate([
            backButton.heightAnchor.constraint (equalToConstant: 50),
            backButton.widthAnchor.constraint(equalToConstant: 150),
            backButton.leftAnchor.constraint (equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30),
            backButton.bottomAnchor.constraint (equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
        
    }
    
    @objc func locationHelp() {
        present(DetermineLocationViewController(), animated: true, completion: nil)
    }
    
    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func goForward() {
        if (whereInput.text?.isEmpty ?? true || whatInput.text?.isEmpty ?? true || whenInput.text?.isEmpty ?? true) {
            self.present(alert, animated: true)
        }
        else {
            let secondVC = ChatModeViewController(delegateInfo: self)
            secondVC.location = whereInput.text ?? "Default Value"
            secondVC.purpose = whatInput.text ?? "Default Value"
            secondVC.date = whenInput.text ?? "Default Value"
            secondVC.length = howlongInput.text ?? "Default Value"
            self.navigationController?.pushViewController(secondVC, animated: true)
        }
    }
        
}

protocol finalIteneraryFromBackground: UIViewController {
    func addFinal(vc: UIViewController, place: String)
    
}
