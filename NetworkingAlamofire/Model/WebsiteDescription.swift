//
//  WebsiteDescription.swift
//  Networking
//
//  Created by Eugene Kiselev on 08.10.2020.
//

import Foundation

struct WebsiteDescription: Decodable {
    
    let websiteDescription: String?
    let websiteName: String?
    let courses: [Course]
}
