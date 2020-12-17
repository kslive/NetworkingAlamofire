//
//  AlamofireNetworkRequest.swift
//  NetworkingAlamofire
//
//  Created by Eugene Kiselev on 08.10.2020.
//

import Foundation
import Alamofire

class AlamofireNetworkRequest {
    
    static var onProgress: ((Double) -> ())?
    static var completes: ((String) -> ())?
    
    static func sendRequest(url: String, completion: @escaping (_ courses: [Course]) -> ()) {
        
        guard let url = URL(string: url) else { return }
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                var courses = [Course]()
                
                courses = Course.getArray(from: value)!
                completion(courses)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func responseData(url: String) {
        AF.request(url).responseData { (responseData) in
            switch responseData.result {
            case .success(let data):
                guard let string = String(data: data, encoding: .utf8) else { return }
                print(string)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func responseString(url: String) {
        AF.request(url).responseString { (responseString) in
            switch responseString.result {
            case .success(let string):
                print(string)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func response(url: String) {
        AF.request(url).response { (response) in
            guard
                let data = response.data,
                  let string = String(data: data, encoding: .utf8)
            else { return }
            
            print(string)
        }
    }
    
    static func downloadImageWithProgress(url: String, completion: @escaping (_ image: UIImage) -> ()) {
        guard let url = URL(string: url) else { return }
        
        AF.request(url).validate().downloadProgress { (progress) in
            print("ttUcount: \(progress.totalUnitCount)")
            print("cmltUcount: \(progress.completedUnitCount)")
            print("frC: \(progress.fractionCompleted)")
            print("lcl: \(progress.localizedDescription)")
            print("______________________________________")
            
            self.onProgress?(progress.fractionCompleted)
            self.completes?(progress.localizedDescription)
        }.response { (response) in
            guard
                let data = response.data,
                let image = UIImage(data: data)
            else { return }
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}
