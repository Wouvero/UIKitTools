//
//
//
// Created by: Patrik Drab on 12/02/2025
// Copyright (c) 2025 UIKitPro 
//
//         

import Foundation

public enum NetworkError: Error {
    case noConnection
    case notAuthorized
    case serverOffline
    
    case otherServerError
    
    case invalidURL
    case invalidData
    case invalidResponseCode(statusCode: Int)
    
    case failedToDecode(error: Error)
    case custom(error: Error)
}

