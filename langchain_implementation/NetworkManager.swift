//
//  NetworkManager.swift
//  langchain_implementation
//
//  Created by Ashley Liu on 2023-08-01.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let host = "http://127.0.0.1:8000/api/"
    
    static func getAllItineraries(completion: @escaping (ItineraryResponse) -> Void) {
        let endpoint = "\(host)/itineraries/"
        AF.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.dateDecodingStrategy = .iso8601
                if let newItineraries = try? jsonDecoder.decode(ItineraryResponse.self, from: data) {
                    completion(newItineraries)
                } else {
                    print("Failed to decode getAllItineraries")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    static func createItinerary(destination: String, date: String, purpose: String, chats: String, completion: @escaping (Itinerary) -> Void) {
        let endpoint = "\(host)/itineraries/"
        let param: Parameters = [
            "destination": destination,
            "date": date,
            "purpose": purpose,
            "chats": chats
        ]
        AF.request(endpoint, method: .post, parameters: param, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(Itinerary.self, from: data) {
                    completion(userResponse)
                } else {
                    print("failed to decode createItinerary")
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func updateItinerary(id: Int, destination: String, date: String, purpose: String, chats: String, completion: @escaping (Itinerary) -> Void) {
        let endpoint = "\(host)/itineraries/\(id)/"
        
        let params: Parameters = [
            "destination": destination,
            "date": date,
            "purpose": purpose,
            "chats": chats
        ]
        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(Itinerary.self, from: data) {
                    completion(userResponse)
                } else {
                    print("failed to decode updateItinerary")
                }
            
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    static func deleteItinerary(id: Int, completion: @escaping (Itinerary) -> Void) {
        let endpoint = "\(host)/itineraries/\(id)/"
        let params: Parameters = [
            "id": id
        ]
        AF.request(endpoint, method: .delete, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(Itinerary.self, from: data) {
                    completion(userResponse)
                } else {
                    print("failed to decode deleteItinerary")
                }
            
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
