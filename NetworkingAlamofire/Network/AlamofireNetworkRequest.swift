//
//  AlamofireNetworkRequest.swift
//  NetworkingAlamofire
//
//  Created by Eugene Kiselev on 08.10.2020.
//

import Foundation
import Alamofire

class AlamofireNetworkRequest {
    
    static func sendRequest(url: String) {
        
        guard let url = URL(string: url) else { return }
        
        AF.request(url, method: .get).responseJSON { response in
            
            print(response)
        }
    }
}
