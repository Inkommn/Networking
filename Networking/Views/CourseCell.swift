//
//  CourseCell.swift
//  Networking
//
//  Created by Alexey Efimov on 21/08/2019.
//  Copyright © 2019 Alexey Efimov. All rights reserved.
//

import UIKit

final class CourseCell: UITableViewCell {

    @IBOutlet var courseImage: UIImageView!
    @IBOutlet var courseNameLabel: UILabel!
    @IBOutlet var numberOfLessons: UILabel!
    @IBOutlet var numberOfTests: UILabel!
    
    private let networkManager = NetworkManager.shared
    
    func configure(with course: Course) {
        courseNameLabel.text = course.name
        numberOfLessons.text = "Number of lessons: \(course.numberOfLessons ?? 0)"
        numberOfTests.text = "Number of tests: \(course.numberOfTests ?? 0)"
        
        networkManager.fetchImage(from: course.imageUrl!) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.courseImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
