//
//  NetworkServiceProtocol.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 12/1/20.
//

import Foundation
import UIKit

protocol NetworkServiceProtocol {
    
    func execute<T: Decodable>(url: URL, completion: @escaping (T?, NSError?) -> ())
    func downloadPicture(url: URL, completion: @escaping (UIImage?, NSError?) -> ())
}
