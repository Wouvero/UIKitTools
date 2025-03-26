//
//
//
// Created by: Patrik Drab on 12/02/2025
// Copyright (c) 2025 UIKitPro 
//
//         


import Foundation

public struct APIClient {
    public static let identifier: String = "[APIClient]"
    let configuration: APIConfigurator
    let timeout: TimeInterval = 60.0
    
    init(configuration: APIConfigurator) {
        self.configuration = configuration
    }
    
    
    public func get<Response: Decodable>(
        _: Response.Type,
        path: String,
        parameters: [URLQueryItem],
        requestHeaders: [APIRequestHeader]
    ) async throws -> Response {
        debugPrint("\(APIClient.identifier) \(DebuggingIdentifiers.actionOrEventInProgress) get \(DebuggingIdentifiers.actionOrEventInProgress)")
        
        //Check that the URL exists and that it's not a local file.
        if configuration.url == nil || configuration.url?.isFileURL ?? true {
            debugPrint("\(APIClient.identifier) get \(DebuggingIdentifiers.actionOrEventFailed)  is local.")
            return try await loadLocal(resource: path)
        }
        
        // Check the base URL exists.
        guard let baseURL = configuration.url else {
            debugPrint("\(APIClient.identifier) get \(DebuggingIdentifiers.actionOrEventFailed) This resource does not have a url.")
            throw NetworkError.invalidURL
        }
        
        // Create the URL by adding the path to the base URL.
        let url = baseURL.appendingPathComponent(path)
        // Create a url that allows for parameters
        guard var urlWithComponents: URLComponents = URLComponents(string: url.absoluteString) else {
            debugPrint("\(APIClient.identifier) get \(DebuggingIdentifiers.actionOrEventFailed) This resource could not produce a URL with components.")
            throw NetworkError.invalidURL
        }
        
        // Set the parameters
        urlWithComponents.queryItems = parameters
        // Safely create a URL with parameters
        guard let urlWithParameters = urlWithComponents.url else {
            debugPrint("\(APIClient.identifier) get \(DebuggingIdentifiers.actionOrEventFailed) This resource could not produce a URL with parameters.")
            throw NetworkError.invalidURL
        }
        
        // Create your request
        var request = URLRequest(url: urlWithParameters, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: timeout)
        
        // Add the headers
        for header in requestHeaders {
            request.addValue(header.value, forHTTPHeaderField: header.httpHeaderField)
        }
        // Implement api key in headers if exist
        if let apiKey = configuration.apiKey {
            request.addValue(apiKey.value, forHTTPHeaderField: apiKey.httpHeaderField)
        }
        
        // Get the session
        let session = configuration.urlSession
        
        
        debugPrint("\(APIClient.identifier) \(DebuggingIdentifiers.actionOrEventInProgress) get \(DebuggingIdentifiers.actionOrEventInProgress) Entering Resquest with URL \(urlWithParameters)")
        
        
        let (data, response) = try await session.data(for: request)
        print(data, response)
        // Check the request response
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            debugPrint("\(APIClient.identifier) get \(DebuggingIdentifiers.actionOrEventFailed) Failed Request with URL \(url) with bad response.")
            throw NetworkError.invalidResponseCode(statusCode: (response as? HTTPURLResponse)?.statusCode ?? -1)
        }
        
        // Attempt to decode the response.
        do {
            let decoded = try JSONDecoder().decode(Response.self, from: data)
            debugPrint("\(APIClient.identifier) get \(DebuggingIdentifiers.actionOrEventSucceded) Completed Resquest with URL \(urlWithParameters)")
            return decoded
        } catch {
            debugPrint("\(APIClient.identifier) get \(DebuggingIdentifiers.actionOrEventFailed) Failed Request with URL \(url) with error : \(error).")
            throw NetworkError.failedToDecode(error: error)
        }
    }
    
    
    public func makeAPICall<Body:Encodable, Response: Decodable>(
        method: HTTPMethod,
        item: Body,
        path: String,
        parameters: [URLQueryItem],
        requestHeaders: [APIRequestHeader],
        resultType: Response.Type
    ) async throws -> Response {
        debugPrint("\(APIClient.identifier) \(DebuggingIdentifiers.actionOrEventInProgress) makeAPICall \(DebuggingIdentifiers.actionOrEventInProgress)")
        
        // Check the base URL exists.
        guard let baseURL = configuration.url else {
            debugPrint("\(APIClient.identifier) get \(DebuggingIdentifiers.actionOrEventFailed) This resource does not have a url.")
            throw NetworkError.invalidURL
        }
        
        // Encode the body.
        guard let body = try? JSONEncoder().encode(item) else {
            debugPrint("\(APIClient.identifier) makeAPICall \(DebuggingIdentifiers.actionOrEventFailed) Could not encode the body.")
            throw NetworkError.invalidData
        }
        
        // Create the URL by adding the path to the base URL.
        let url = baseURL.appendingPathComponent(path)
        // Create a url that allows for parameters
        guard var urlWithComponents: URLComponents = URLComponents(string: url.absoluteString) else {
            debugPrint("\(APIClient.identifier) makeAPICall \(DebuggingIdentifiers.actionOrEventFailed) This resource could not produce a URL with components.")
            throw NetworkError.invalidURL
        }
        
        // Set the parameters
        urlWithComponents.queryItems = parameters
        // Safely create a URL with parameters
        guard let urlWithParameters = urlWithComponents.url else {
            debugPrint("\(APIClient.identifier) get \(DebuggingIdentifiers.actionOrEventFailed) This resource could not produce a URL with parameters.")
            throw NetworkError.invalidURL
        }
        
        // Create your request
        var request = URLRequest(url: urlWithParameters, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: timeout)
        // Add the HTTP Method.
        request.httpMethod = method.rawValue
        
        // Add the headers
        for header in requestHeaders {
            request.addValue(header.value, forHTTPHeaderField: header.httpHeaderField)
        }
        // Implement api key in headers if exists
        if let apiKey = configuration.apiKey {
            request.addValue(apiKey.value, forHTTPHeaderField: apiKey.httpHeaderField)
        }
        
        // Set the body
        request.httpBody = body
        
        // Get the session
        let session = configuration.urlSession
        
        
        let (data, response) = try await session.data(for: request)
        
        // Check the request response
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            debugPrint("\(APIClient.identifier) get \(DebuggingIdentifiers.actionOrEventFailed) Failed Request with URL \(url) with bad response.")
            throw NetworkError.invalidResponseCode(statusCode: (response as? HTTPURLResponse)?.statusCode ?? -1)
        }
        
        // Attempt to decode the response.
        do {
            let decoded = try JSONDecoder().decode(Response.self, from: data)
            debugPrint("\(APIClient.identifier) get \(DebuggingIdentifiers.actionOrEventSucceded) Completed Resquest with URL \(urlWithParameters)")
            return decoded
        } catch {
            debugPrint("\(APIClient.identifier) get \(DebuggingIdentifiers.actionOrEventFailed) Failed Request with URL \(url) with error : \(error).")
            throw NetworkError.failedToDecode(error: error)
        }
    }
    
    
    public func loadLocal<T: Decodable>(resource: String) async throws -> T {
        do {
            if let loadedData = loadLocalResource(name: resource) {
                let data = try JSONDecoder().decode(T.self, from: loadedData)
                debugPrint("\(APIClient.identifier) loadLocal \(DebuggingIdentifiers.actionOrEventSucceded) Successfully loaded resource \(data).")
                return data
            } else {
                debugPrint("\(APIClient.identifier) loadLocal \(DebuggingIdentifiers.actionOrEventFailed) Failed with error: Other Server Error.")
                throw NetworkError.otherServerError
            }
        } catch {
            debugPrint("\(APIClient.identifier) loadLocal \(DebuggingIdentifiers.actionOrEventFailed) Failed with error: \(error).")
            throw NetworkError.custom(error: error)
        }
    }
    
    
    private func loadLocalResource(name: String) -> Data? {
        do {
            guard let filePath = Bundle.main.path(forResource: name, ofType: nil) else {
                debugPrint("\(APIClient.identifier) loadLocalResource \(DebuggingIdentifiers.actionOrEventFailed) Could not find filepath.")
                return nil
            }
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath), options: .mappedIfSafe)
            debugPrint("\(APIClient.identifier) loadLocalResource \(DebuggingIdentifiers.actionOrEventSucceded) Gathered Data for resource \(name).")
            return data
            
        } catch {
            return nil
        }
    }
    
}


public struct DebuggingIdentifiers {
    static let actionOrEventSucceded: String = "✅"
    static let actionOrEventInProgress: String = "💪"
    static let actionOrEventFailed: String = "❌"
    static let notificationSent: String = "📤"
    static let notificationRecieved: String = "📥"
}
