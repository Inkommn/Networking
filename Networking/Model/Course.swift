//
//  Course.swift
//  Networking
//
//  Created by Shamkhan Mutuskhanov on 11.07.2023.
//

struct Course: Decodable {
    let name: String?
    let imageUrl: String?
    let number_of_lessons: Int?
    let number_of_tests: Int?
}

struct SwiftbookInfo: Decodable {
    let courses: [Course]?
    let websiteDescription: String?
    let websiteName: String?
}
