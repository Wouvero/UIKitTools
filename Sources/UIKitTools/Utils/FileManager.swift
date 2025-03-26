//
//
//
// Created by: Patrik Drab on 12/02/2025
// Copyright (c) 2025 UIKitPro 
//
//         

import Foundation

public struct FileManager {
    /// fileName/filePath
    public static func loadFile(fileName: String) -> Data? {
        do {
            guard let filePath = Bundle.main.path(forResource: fileName, ofType: nil) else {
                debugPrint("\(APIClient.identifier) loadLocalResource \(DebuggingIdentifiers.actionOrEventFailed) Could not find filepath.")
                return nil
            }
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath), options: .mappedIfSafe)
            debugPrint("\(APIClient.identifier) loadLocalResource \(DebuggingIdentifiers.actionOrEventSucceded) Gathered Data for resource \(fileName).")
            return data
            
        } catch {
            return nil
        }
    }
}

