//
//
//
// Created by: Patrik Drab on 12/02/2025
// Copyright (c) 2025 UIKitPro 
//
//         

import Foundation

public struct JSONManager {
    
    public static func decodeJSON<T: Decodable>(from fileName: String, type: T.Type) -> T? {
        guard let loadedData = FileManager.loadFile(fileName: fileName),
              let result = try? JSONDecoder().decode(T.self, from: loadedData) else {
            return nil
        }
        return result
    }
}
