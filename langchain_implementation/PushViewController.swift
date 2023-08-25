//
//  PushViewController.swift
//  langchain_implementation
//
//  Created by Cindy Liang on 7/30/23.
//

import Foundation
import UIKit


class PushViewController: UIViewController {
    let goButton = UIButton()
    var textLabel = UILabel()
    weak var delegate: saveInfoDelegate?
    
    init(inputDelegate: saveInfoDelegate) {
        delegate = inputDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        goButton.addTarget(self, action: #selector(postRequest), for: .touchUpInside)
        goButton.translatesAutoresizingMaskIntoConstraints = false
        goButton.setTitleColor(.black, for: .normal)
        goButton.setTitle("Go", for: .normal)
        view.addSubview(goButton)
        
        
        textLabel.text = ""
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.numberOfLines = 10
        view.addSubview(textLabel)
        
        
        setupConstraints()
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            goButton.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor)
        ])
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo:goButton.bottomAnchor),
            textLabel.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor)
        ])
       
    }
    
    @objc func postRequest() {
      var ret = ""
      // declare the parameter as a dictionary that contains string as key and value combination. considering inputs are valid
      
      let parameters: [String: Any] = ["userInput": "plan trip to dallas texas on 7/30"]
      
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
            self.textLabel.text = text
            self.textLabel.numberOfLines = 10
            self.textLabel.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(self.textLabel)
        
        }
    }
    
    
}

protocol saveInfoDelegate: UIViewController {
}
