//
//  ViewController.swift
//  Networking
//
//  Created by Shamkhan Mutuskhanov on 11.07.2023.
//

import UIKit

enum UserAction: String, CaseIterable {
    case showImage = "Show Image"
    case fetchCourse = "Fetch Course"
    case fetchCourses = "Fetch Courses"
    case aboutSwiftBook = "About SwiftBook"
    case aboutSwiftBook2 = "About SwiftBook 2"
    case showCourses = "Show Courses"
    case postRequestWithDict = "POST RQST with Dict"
    case postRequestWithModel = "POST RQST with Model"
}

enum Alert {
    case success
    case failed
    
    var title: String {
        switch self {
        case .success:
            return "Success"
        case .failed:
            return "Failed"
        }
    }
    
    var message: String {
        switch self {
        case .success:
            return "You can see the results in the Debug area"
        case .failed:
            return "You can see error in the Debug area"
        }
    }
}

final class MainViewController: UICollectionViewController {
    
    private let userActions = UserAction.allCases

    // MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userAction", for: indexPath)
        guard let cell = cell as? UserActionCell else { return UICollectionViewCell() }
        cell.userActionLabel.text = userActions[indexPath.item].rawValue
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item]
        
        switch userAction {
        case .showImage: performSegue(withIdentifier: "showImage", sender: nil)
        case .fetchCourse: fetchCourse()
        case .fetchCourses: fetchCourses()
        case .aboutSwiftBook: fetchInfoAboutUs()
        case .aboutSwiftBook2: fetchInfoAboutUsWithEmptyFields()
        case .showCourses: performSegue(withIdentifier: "showCourses", sender: nil)
        case .postRequestWithDict: postRequestWithDict()
        case .postRequestWithModel: postRequestWithModel()
            
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCourses" {
            guard let coursesVC = segue.destination as? CoursesViewController else { return }
            coursesVC.fetchCourses()
        }
    }
    
    // MARK: - Private methods
    private func showAlert(with status: Alert) {
        let alert = UIAlertController(title: status.title, message: status.message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        DispatchQueue.main.async { [unowned self] in
            present(alert, animated: true)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
}

// MARK: - Networking
extension MainViewController {
    private func fetchCourse() {
        NetworkManager.shared.fetch(Course.self, from: Link.courseURL.rawValue) { [weak self] result in
            switch result {
            case .success(let course):
                print(course)
                self?.showAlert(with: .success)
            case .failure(let error):
                print(error.localizedDescription)
                self?.showAlert(with: .failed)
            }
        }
    }
    
    private func fetchCourses() {
        NetworkManager.shared.fetch([Course].self, from: Link.coursesURL.rawValue) { [weak self] result in
            switch result {
            case .success(let courses):
                print(courses)
                self?.showAlert(with: .success)
            case .failure(let error):
                print(error.localizedDescription)
                self?.showAlert(with: .failed)
            }
        }
    }
    
    private func fetchInfoAboutUs() {
        NetworkManager.shared.fetch(SwiftbookInfo.self, from: Link.aboutUsURL.rawValue) { [weak self] result in
            switch result {
            case .success(let info):
                print(info)
                self?.showAlert(with: .success)
            case .failure(let error):
                print(error.localizedDescription)
                self?.showAlert(with: .failed)
            }
        }
    }
    
    private func fetchInfoAboutUsWithEmptyFields() {
        NetworkManager.shared.fetch(SwiftbookInfo.self, from: Link.aboutUsURL2.rawValue) { [weak self] result in
            switch result {
            case .success(let info):
                print(info)
                self?.showAlert(with: .success)
            case .failure(let error):
                print(error.localizedDescription)
                self?.showAlert(with: .failed)
            }
        }
    }
    
    private func postRequestWithDict() {
        let course = [
            "name" : "Network",
            "imageURL" : "image url",
            "numberOfLesson" : "10",
            "numberOfTests" : "8"
        ]
        
        NetworkManager.shared.postRequest(with: course, to: Link.postRequest.rawValue) { [weak self] result in
            switch result {
            case .success(let json):
                print(json)
                self?.showAlert(with: .success)
            case .failure(let error):
                print(error.localizedDescription)
                self?.showAlert(with: .failed)
            }
        }
    }
    
    private func postRequestWithModel() {
        let course = Course(
            name: "Networking",
            imageUrl: Link.courseImageURL.rawValue,
            numberOfLessons: 10,
            numberOfTests: 5
        )
        
        NetworkManager.shared.postRequest(with: course, to: Link.postRequest.rawValue) { [weak self] result in
            switch result {
            case .success(let course):
                print(course)
                self?.showAlert(with: .success)
            case .failure(let error):
                print(error.localizedDescription)
                self?.showAlert(with: .failed)
            }
        }
    }
}

