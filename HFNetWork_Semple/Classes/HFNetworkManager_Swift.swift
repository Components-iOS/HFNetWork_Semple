//
//  HFNetworkManager_Swift.swift
//  HFNetWork_Semple
//
//  Created by bizconf on 2025/2/21.
//

import Foundation
import Alamofire

@objc public class HFNetworkManager_Swift: NSObject {
    
    @objc public static let sharedInstance = HFNetworkManager_Swift()

    // MARK: - Properties
    @objc public var globalDict: [String: Any] = [:]
    @objc public var userDict: [String: Any] = [:]
    @objc public var statusCode: String = ""
    @objc public var isCanLog: Bool = false

    private var sessionManager: Session

    // MARK: - Initialization
    private override init() {
        sessionManager = Session()
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        sessionManager = Session(configuration: configuration, rootQueue: .main, serverTrustManager: nil)
    }

    // MARK: - Methods

    /// Set base URL
    @objc public func setBaseURL(baseURL: String) {
        HFURLMacros.sharedInstance().baseURL = baseURL
    }

    /// Get current HTTPSessionManager
    func getSessionManager() -> Session {
        return sessionManager
    }

    /// Send a GET request
    @objc public func GETRequest(
        URLString: String,
        parameters: [String: Any]?,
        completion: @escaping (Any?, Error?) -> Void
    ) -> Void {
        var parametersM = parameters ?? [:]
        parametersM.merge(globalParms(needUserInfo: true)) { (current, _) in current }
        
        print(HFURLMacros.sharedInstance().baseURL + URLString)
        print(sessionManager)

        sessionManager.request(HFURLMacros.sharedInstance().baseURL + URLString, method: .get, parameters: parametersM, encoding: URLEncoding.default)
            .validate()
            .responseData { response in 
                switch response.result {
                case .success(let data):
                    if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
                        if self.isCanLog {
                            self.showLog(task: response.request!, parameters: parametersM)
                        }
                        completion(json, nil)
                    } else {
                        completion(nil, NSError(domain: "HFNetworkManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to parse JSON"]))
                    }
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }

    /// Send a POST request
    @objc public func POSTRequest(
        URLString: String,
        parameters: [String: Any]?,
        completion: @escaping (Any?, Error?) -> Void
    ) -> Void {
        var parametersM = parameters ?? [:]
        parametersM.merge(globalParms(needUserInfo: true)) { (current, _) in current }
        
        sessionManager.request(HFURLMacros.sharedInstance().baseURL + URLString, method: .post, parameters: parametersM, encoding: JSONEncoding.default)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
                        if self.isCanLog {
                            self.showLog(task: response.request!, parameters: parametersM)
                        }
                        completion(json, nil)
                    } else {
                        completion(nil, NSError(domain: "HFNetworkManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to parse JSON"]))
                    }
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }
    
    /// Send a Upload request
    @objc public func uploadFile (
        URLString: String,
        parameters: [String: Any]?,
        fileURL: URL,
        fileKey: String,
        completion: @escaping (Any?, Error?) -> Void
    ) -> Void {
        var parametersM = parameters ?? [:]
        parametersM.merge(globalParms(needUserInfo: true)) { (current, _) in current }

        // Prepare the multipart form data
        sessionManager.upload(multipartFormData: { multipartFormData in
            // Add file to multipart data
            multipartFormData.append(fileURL, withName: fileKey, fileName: fileURL.lastPathComponent, mimeType: "application/octet-stream")
            
            // Add other parameters to multipart data
            for (key, value) in parametersM {
                if let value = value as? String {
                    multipartFormData.append(Data(value.utf8), withName: key)
                } else if let value = value as? Data {
                    multipartFormData.append(value, withName: key)
                }
            }
        }, to: URLString)
        .validate()
        .responseData { response in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
                    if self.isCanLog {
                        self.showLog(task: response.request!, parameters: parametersM)
                    }
                    completion(json, nil)
                } else {
                    completion(nil, NSError(domain: "HFNetworkManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to parse JSON"]))
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }

    /// Global parameters
    private func globalParms(needUserInfo: Bool) -> [String: Any] {
        var parameters: [String: Any] = [:]

        parameters.merge(self.globalDict) { (current, _) in current }
        parameters.merge(self.userDict) { (current, _) in current }

        return parameters
    }

    /// Logging method
    private func showLog(task: URLRequest, parameters: [String: Any]) {
        print("===== URL = \(task.url?.absoluteString ?? "")")
        print("----- HTTPMethod = \(task.httpMethod ?? "")")
        print("----- HTTPBody = \(parameters)")
        print("----- allHTTPHeaderFields = \(task.allHTTPHeaderFields ?? [:])")
    }
}
