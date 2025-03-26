//
//
//
// Created by: Patrik Drab on 12/02/2025
// Copyright (c) 2025 UIKitPro 
//
//         

import Foundation

public struct APIConfigurator {
    var urlSession: URLSession = .shared
    var apiKey: APIRequestHeader?
    var url: URL?
}
