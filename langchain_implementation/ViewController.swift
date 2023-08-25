//
//  ViewController.swift
//  langchain_implementation
//
//  Created by Cindy Liang on 7/15/23.
//

import UIKit

class ViewController: UIViewController,finalIteneraryFromBackground {
    
    

    var welcomeLabel = UILabel()
    var speakButton = UIButton()
    var viewHistoryButton = UIButton()
    var finalIteneraryList:[UIViewController] = []
    var finalItenerayNames:[String] = []
    var histViewController:HistoryViewController? = nil
    
    func addFinal(vc: UIViewController, place: String) {
        finalIteneraryList.append(vc)
        finalItenerayNames.append(place)
    }
    override func viewDidLoad() {

        super.viewDidLoad()
        view.backgroundColor = .white

        // Do any additional setup after loading the view.

        welcomeLabel.numberOfLines = 0
        welcomeLabel.text = " Hello! \n Welcome to \n our AI Travel \n Agent App!"
        welcomeLabel.textColor = UIColor(red: 0.32, green: 0.32, blue: 0.32, alpha: 1)
        welcomeLabel.font = .systemFont(ofSize: 50, weight: .bold)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(welcomeLabel)



        speakButton.setTitle("Speak to our AI travel agent", for: .normal)
        speakButton.setTitleColor(.white, for: .normal)
        speakButton.layer.borderWidth = 1
        speakButton.layer.borderColor = UIColor(red: 0.576, green: 0.749, blue: 0.812, alpha: 1).cgColor
        speakButton.backgroundColor = UIColor(red: 0.576, green: 0.749, blue: 0.812, alpha: 1)
        speakButton.layer.cornerRadius = 5
        speakButton.translatesAutoresizingMaskIntoConstraints = false

        speakButton.addTarget(self, action: #selector(selectSpeak), for: .touchUpInside)

        view.addSubview(speakButton)
        

        viewHistoryButton.setTitle("View Itinerary History", for: .normal)
        viewHistoryButton.setTitleColor(.white, for: .normal)
        viewHistoryButton.layer.borderWidth = 1
        viewHistoryButton.layer.borderColor = UIColor(red: 0.576, green: 0.749, blue: 0.812, alpha: 1).cgColor
        viewHistoryButton.backgroundColor = UIColor(red: 0.576, green: 0.749, blue: 0.812, alpha: 1)
        viewHistoryButton.layer.cornerRadius = 5
        viewHistoryButton.translatesAutoresizingMaskIntoConstraints = false

        viewHistoryButton.addTarget(self, action: #selector(selectViewHistory), for: .touchUpInside)
        view.addSubview(viewHistoryButton)


        NSLayoutConstraint.activate([

            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            welcomeLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30)

        ])

        NSLayoutConstraint.activate([

            speakButton.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 30),
            speakButton.heightAnchor.constraint(equalToConstant: 50),
            speakButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            speakButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30)

        ])

        NSLayoutConstraint.activate([

            viewHistoryButton.topAnchor.constraint(equalTo: speakButton.bottomAnchor, constant: 15),

            viewHistoryButton.heightAnchor.constraint(equalToConstant: 50),

            viewHistoryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            viewHistoryButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30)

        ])

    }
    @objc
    func selectSpeak(){
        navigationController?.pushViewController(BackgroundInfoViewController(delegateInfo: self), animated: true)

    }
    @objc
    func selectViewHistory(){
        
        if (histViewController == nil){
            histViewController = HistoryViewController()
            histViewController?.iteneraryVCList = self.finalIteneraryList
            histViewController?.iteneraryNamesList = self.finalItenerayNames
            navigationController?.pushViewController(histViewController!, animated: true)
            
        }else{
            histViewController?.iteneraryVCList = self.finalIteneraryList
            histViewController?.iteneraryNamesList = self.finalItenerayNames
            histViewController?.itineraryList.reloadData()
            navigationController?.pushViewController(histViewController!, animated: true)
        }
        
       
    }
}
