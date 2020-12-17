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
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataWithAlamofire()
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
    }
    
    func fetchImage() {
        NetworkManager.downloadImage(url: url) { (image) in
            self.activityIndicator.stopAnimating()
            self.imageView.image = image
        }
    }
    
    func fetchDataWithAlamofire() {
        // создаем запрос к серверу
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
}
