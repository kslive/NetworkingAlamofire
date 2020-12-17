//
//  ImageViewController.swift
//  NetworkingAlamofire
//
//  Created by Eugene Kiselev on 08.10.2020.
//

import UIKit
import Alamofire

class ImageViewController: UIViewController {
    
    private let url = "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg"
    private let largeImage = "https://i.imgur.com/3416rvI.jpg"
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var completedLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        progressView.isHidden = true
        completedLabel.isHidden = true
    }
    
    func fetchImage() {
        NetworkManager.downloadImage(url: url) { (image) in
            self.activityIndicator.stopAnimating()
            self.imageView.image = image
        }
    }
    
    func fetchDataWithAlamofire() {
        AF.request(url).responseData { [weak self] responseData in
            guard let self = self else { return }
            switch responseData.result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                
                self.activityIndicator.stopAnimating()
                self.imageView.image = image
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func downloadImageWithProgress() {
        AlamofireNetworkRequest.onProgress = { [weak self] progress in
            guard let self = self else { return }
            self.progressView.isHidden = false
            self.progressView.progress = Float(progress)
        }
        AlamofireNetworkRequest.completes = { [weak self] completed in
            guard let self = self else { return }
            self.completedLabel.isHidden = false
            self.completedLabel.text = completed
        }
        AlamofireNetworkRequest.downloadImageWithProgress(url: largeImage) { [weak self] (image) in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            // скрываем прогрес и лейбл по завершению загрузки
            self.completedLabel.isHidden = true
            self.progressView.isHidden = true
            self.imageView.image = image
            
        }
    }
}
