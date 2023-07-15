//
//  Course.swift
//  Networking
//
//  Created by Shamkhan Mutuskhanov on 11.07.2023.
//

struct Course: Codable {
    let name: String?
    let imageUrl: String?
    let numberOfLessons: Int?
    let numberOfTests: Int?
}

struct SwiftbookInfo: Decodable {
    let courses: [Course]?
    let websiteDescription: String?
    let websiteName: String?
}
