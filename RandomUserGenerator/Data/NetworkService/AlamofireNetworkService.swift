//
//  AlamofireNetworkService.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 12/1/20.
//

import Foundation
import Alamofire

class AlamofireNetworkService: NetworkServiceProtocol {
    
    func execute<T: Decodable>(url: URL, completion: @escaping (T?, NSError?) -> ()) {
        AF.request(url) { $0.timeoutInterval = 5 }.validate().responseDecodable(of: T.self) { response in
            switch response.result {
                case .success(let users):
                    completion(users, nil)
                case .failure(let error):
                    completion(nil, error as NSError)
            }
        }
    }
    
    func downloadPicture(url: URL, completion: @escaping (UIImage?, NSError?) -> ()) {
        AF.request(url).validate().response { response in
            switch response.result {
                case .success(let pictureData):
                    let image = UIImage(data: pictureData!)
                    completion(image, nil)
                case .failure(let error):
                    completion(nil, error as NSError)
            }
        }
    }
}
