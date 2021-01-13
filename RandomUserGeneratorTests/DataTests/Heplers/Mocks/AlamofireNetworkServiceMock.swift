//
//  AlamofireNetworkServiceMock.swift
//  RandomUserGeneratorTests
//
//  Created by Малышев Максим Алексеевич on 12/2/20.
//

@testable import RandomUserGenerator
import Foundation

class AlamofireNetworkServiceMock: NetworkServiceProtocol {
    
    var url: URL?
    var data: Data?
    
    init(data: Data? = nil) {
        self.data = data
    }
    
    func execute<T: Decodable>(completion: @escaping (Result<T, NSError>) -> ()) {
        guard self.url != nil else {
            completion(.failure(NSError.makeError(withMessage: "Foo")))
            return
        }
        guard let data = data else {
            completion(.failure(NSError.makeError(withMessage: "Bar")))
            return
        }
        let result = try! JSONDecoder().decode(T.self, from: data)
        completion(.success(result))
    }
    
    func downloadPicture(url: URL, completion: @escaping (Result<Data, NSError>) -> ()) {
        
    }
}
