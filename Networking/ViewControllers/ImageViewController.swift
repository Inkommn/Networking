//
//  ImageViewController.swift
//  Networking
//
//  Created by Shamkhan Mutuskhanov on 11.07.2023.
//

import UIKit

final class ImageViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var imageView: UIImageView!
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchImage()
    }
    
    // MARK: - Private methods
    private func fetchImage() {
        NetworkManager.shared.fetchImage(from: Link.imageURL.rawValue) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.imageView.image = UIImage(data: imageData)
                self?.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
}
