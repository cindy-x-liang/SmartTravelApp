//
//  Itinerary.swift
//  langchain_implementation
//
//  Created by Ashley Liu on 2023-07-25.
//

import Foundation

//class Itinerary {
//    var destination: String
//
//    init(destination: String) {
//        self.destination = destination
//    }
//}


struct Itinerary: Codable {
    var id: Int
    var destination: String
    var date: String
    var purpose: String
    var chats: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case destination
        case date
        case purpose
        case chats
    }
}
struct ItineraryResponse: Codable {
    var itineraries: [Itinerary]
}
