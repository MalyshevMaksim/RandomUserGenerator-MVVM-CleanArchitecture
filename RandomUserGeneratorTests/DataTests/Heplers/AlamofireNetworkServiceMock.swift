//
//  AlamofireNetworkServiceMock.swift
//  RandomUserGeneratorTests
//
//  Created by Малышев Максим Алексеевич on 12/2/20.
//

@testable import RandomUserGenerator
import Foundation

class AlamofireNetworkServiceMock: NetworkServiceProtocol {
    
    func execute<T>(url: URL, completion: @escaping (Result<T, NSError>) -> ()) where T : Decodable {
        
    }
    
    func downloadPicture(url: URL, completion: @escaping (Result<Data, NSError>) -> ()) {
        
    }
}
