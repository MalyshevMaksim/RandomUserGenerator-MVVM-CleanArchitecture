//
//  AlamofireNetworkService.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 12/1/20.
//

import Foundation
import Alamofire

class AlamofireNetworkService: NetworkServiceProtocol {
    
    var url: URL?
    
    init(url: URL?) {
        self.url = url
    }
    
    func execute<T: Decodable>(completion: @escaping (Result<T, NSError>) -> ()) {
        guard let url = url else {
            completion(.failure(NSError.makeError(withMessage: "Invalid URL")))
            return
        }
        AF.request(url) { $0.timeoutInterval = 5 }.validate().responseDecodable(of: T.self) { response in
            switch response.result {
                case .success(let users):
                    completion(.success(users))
                case .failure(let error):
                    completion(.failure(error as NSError))
            }
        }
    }
    
    func downloadPicture(url: URL, completion: @escaping (Result<Data, NSError>) -> ()) {
        AF.request(url).validate().response { response in
            switch response.result {
                case .success(let pictureData):
                    completion(.success(pictureData!))
                case .failure(let error):
                    completion(.failure(error as NSError))
            }
        }
    }
}
