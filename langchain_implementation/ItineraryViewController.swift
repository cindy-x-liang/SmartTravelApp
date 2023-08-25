//
//  ItineraryViewController.swift
//  langchain_implementation
//
//  Created by Helen Lei on 8/10/23.
//

import UIKit
import Foundation
import LangChain

class ItineraryViewController: UIViewController, UITextFieldDelegate {
    
    let tempBot = chatBot()
    let response = UILabel()
    var models = [String]()
    var itineraryDisplay = UIButton()
    var itineraryText = ""
    var itineraryDestination = ""
    var itineraryDate = ""
    var itineraryPurpose = ""
    var displayConfig = UIButton.Configuration.plain()
    var textLabel = UILabel()
    //var scrollview = UIScrollView()
    //var itineraryObj = Itinerary()
    

//    private let doneButton: UIButton = {
//        let doneButton = UIButton()
//        doneButton.setTitle("Done", for: .normal)
//        doneButton.addTarget(self, action: #selector(goForward), for: .touchUpInside)
//        doneButton.translatesAutoresizingMaskIntoConstraints = false
//        doneButton.backgroundColor = UIColor(red: 0.741, green: 0.804, blue: 0.839, alpha: 1)
//        doneButton.layer.cornerRadius = 5
//        return doneButton
//    }()
    
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
        titleLabel.text = " Here's your \n itinerary"
        titleLabel.textColor = UIColor(red: 0.32, green: 0.32, blue: 0.32, alpha: 1)
        titleLabel.font = .systemFont(ofSize: 50, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
//    private let itinerary: UITextField = {
//        let itinerary = UITextField()
//        itinerary.text = " Here's your \n itinerary"
//        itinerary.textColor = UIColor(red: 0.32, green: 0.32, blue: 0.32, alpha: 1)
//        itinerary.font = .systemFont(ofSize: 50, weight: .bold)
//        itinerary.translatesAutoresizingMaskIntoConstraints = false
//        return itinerary
//    }()

    lazy var contentViewSize = CGSize(width: self.view.frame.width , height: self.view.frame.height) //Step One

    lazy var scrollView : UIScrollView = {
        let view = UIScrollView(frame : .zero)
        view.frame = self.view.bounds
        view.contentInsetAdjustmentBehavior = .never
        view.contentSize = contentViewSize
        view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var secondscrollView : UIScrollView = {
        let view = UIScrollView(frame : .zero)
        view.frame = self.view.bounds
        view.contentInsetAdjustmentBehavior = .never
        view.contentSize = contentViewSize
        view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var containerView : UIView = {
        let view = UIView()
        view.frame.size = contentViewSize
        view.backgroundColor = .lightGray
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.navigationItem.setHidesBackButton(true, animated: true)
        
//
//        displayConfig.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10)
//        textLabel.configuration = displayConfig
//        textLabel.setTitle("Flight and Hotel", for: .normal)
//        textLabel.titleLabel?.numberOfLines = 5
//        textLabel.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
//        textLabel.isUserInteractionEnabled = false
//        textLabel.setTitleColor(.black, for: .normal)
//        textLabel.layer.cornerRadius = 10
//        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        textLabel.text = "Flight and Hotel: "
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.numberOfLines = 20
        NSLayoutConstraint.activate([
            textLabel.widthAnchor.constraint(equalToConstant: 350)
        ])
        //view.addSubview(textLabel)
//       x
        view.addSubview(titleLabel)
        view.addSubview(backButton)
        view.addSubview(itineraryDisplay)
        
//        response.text = ""
//        response.numberOfLines = 20
//        response.font = .systemFont(ofSize: 12, weight: .regular)
//        response.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(response)
        
        displayConfig.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10)
        itineraryDisplay.configuration = displayConfig
        itineraryDisplay.setTitle(itineraryText, for: .normal)
        itineraryDisplay.titleLabel?.numberOfLines = 5
        itineraryDisplay.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        itineraryDisplay.isUserInteractionEnabled = false
        itineraryDisplay.setTitleColor(.black, for: .normal)
        itineraryDisplay.layer.cornerRadius = 10
        itineraryDisplay.translatesAutoresizingMaskIntoConstraints = false
        //view.addSubview(itineraryDisplay)
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(itineraryDisplay)
        
        self.view.addSubview(secondscrollView)
        self.secondscrollView.addSubview(textLabel)
        
        
        //scrollview.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        //view.addSubview(scrollview)
        //scrollview.addSubview(itineraryDisplay)
        
        
        postRequest()
    
        setupConstraints()
        
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30)
        ])
        
//        NSLayoutConstraint.activate([
//            doneButton.heightAnchor.constraint (equalToConstant: 50),
//            doneButton.widthAnchor.constraint(equalToConstant: 150),
//            doneButton.rightAnchor.constraint (equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30),
//            doneButton.bottomAnchor.constraint (equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
//        ])
        
        NSLayoutConstraint.activate([
            backButton.heightAnchor.constraint (equalToConstant: 50),
            backButton.widthAnchor.constraint(equalToConstant: 150),
            backButton.leftAnchor.constraint (equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30),
            backButton.bottomAnchor.constraint (equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
        NSLayoutConstraint.activate([
            secondscrollView.topAnchor.constraint(equalTo:  backButton.topAnchor, constant: -80),
            secondscrollView.leftAnchor.constraint (equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30),
            secondscrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30),
            secondscrollView.bottomAnchor.constraint (equalTo: backButton.topAnchor, constant: -20)
        ])
        
//        NSLayoutConstraint.activate([
//            itineraryDisplay.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
//            itineraryDisplay.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
//            itineraryDisplay.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30),
//            //itineraryDisplay.bottomAnchor.constraint(equalTo: doneButton.topAnchor, constant: 5)
//        ])
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            scrollView.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30),
            scrollView.bottomAnchor.constraint(equalTo: secondscrollView.topAnchor, constant: -20)
            //itineraryDisplay.bottomAnchor.constraint(equalTo: doneButton.topAnchor, constant: 5)
        ])
    }
    
    @objc func locationHelp() {
        present(DetermineLocationViewController(), animated: true, completion: nil)
    }
    
    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func goForward() {
//        NetworkManager.createItinerary(destination: itineraryDestination, date: itineraryDate, purpose: itineraryPurpose, chats: itineraryText) { itinerary in
//            self.itineraryObj = itinerary
//        }

        self.navigationController?.pushViewController(ViewController(), animated: true)
    }
        
    @objc func postRequest() {
      var ret = ""
      // declare the parameter as a dictionary that contains string as key and value combination. considering inputs are valid
      
        let parameters: [String: Any] = ["userInput": "plan trip to \(self.itineraryDestination) on \(self.itineraryDate)"]
      
      // create the url with URL
      let url = URL(string: "http://34.16.184.184:8000/api/calls/")! // change server url accordingly
      
      // create the session object
      let session = URLSession.shared
      
      // now create the URLRequest object using the url object
      var request = URLRequest(url: url)
      request.httpMethod = "POST" //set http method as POST
      
      // add headers for the request
      request.addValue("application/json", forHTTPHeaderField: "Content-Type") // change as per server requirements
      request.addValue("application/json", forHTTPHeaderField: "Accept")
      
      do {
        // convert parameters to Data and assign dictionary to httpBody of request
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
      } catch let error {
        print(error.localizedDescription)
        return
      }
      
      // create dataTask using the session object to send data to the server
      let task = session.dataTask(with: request) { data, response, error in
        
        if let error = error {
          print("Post Request Error: \(error.localizedDescription)")
          return
        }
        
        // ensure there is valid response code returned from this HTTP response
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode)
        else {
          print("Invalid Response received from the server")
          return
        }
        
        // ensure there is data returned
        guard let responseData = data else {
          print("nil Data received from the server")
          return
        }
          var result: Response?
        do {
            
            result = try JSONDecoder().decode(Response.self, from: responseData)
          // create json object from data or use JSONDecoder to convert to Model stuct
//          if let jsonResponse = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any] {
//              var result: Response?
//              //result = try JSONDecoder().decode(Response.self, from: jsonResponse)
//              print(jsonResponse)
            // handle json response
//          } else {
//            print("data maybe corrupted or in wrong format")
//            throw URLError(.badServerResponse)
//          }
        } catch let error {
          print(error.localizedDescription)
        }
          
          
          guard let json = result else {
              print("ruh roh ")
              return
          }

          
          print(json.response)
          //self.textLabel.text = json.response
          ret = json.response
          self.updateFlightHotelText(text:json.response)
      }
      // perform the task
      task.resume()
    }
    
    
    
    struct Response: Codable{
        let response: String
        
    }
    
    @objc func updateFlightHotelText(text:String) {
        DispatchQueue.main.async {
            self.textLabel.text = "Flight and Hotel: \(text)"
            //self.textLabel.setTitle("Flight and Hotel : \(text)", for: .normal)
//            self.textLabel.numberOfLines = 10
//            self.textLabel.translatesAutoresizingMaskIntoConstraints = false
            self.secondscrollView.addSubview(self.textLabel)
        
        }
    }
}


