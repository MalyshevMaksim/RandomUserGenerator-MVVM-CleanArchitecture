//
//  NetworkServiceProtocol.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 12/1/20.
//

import Foundation
import UIKit

protocol NetworkServiceProtocol {
    
    var url: URL? { get set }
    
    func execute<T: Decodable>(completion: @escaping (Result<T, NSError>) -> ())
    func downloadPicture(url: URL, completion: @escaping (Result<Data, NSError>) -> ())
}
