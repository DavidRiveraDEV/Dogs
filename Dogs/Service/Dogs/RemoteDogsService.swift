//
//  RemoteDogsService.swift
//  Dogs
//
//  Created by David Rivera on 16/11/21.
//

import Foundation

class RemoteDogsService {
    
    private var httpClient: HTTPClientProtocol
    
    init() {
        let logger = BasicLogger(String(describing: RemoteDogsService.self))
        let httpService = AlamofireHTTPService(with: logger)
        self.httpClient = HTTPClient(baseUrl: RemoteDataManagerSettings.baseUrl, httpService: httpService)
    }
    
    func getDogs(onSuccess: @escaping (_ dogs: [Dog]) -> Void, onFailed: @escaping (_ response: FailedResponse) -> Void) {
        self.httpClient.get(apiPath: RemoteDataManagerSettings.dogsPath, pathParams: nil, queryParams: nil, headers: nil, onSuccessful: onSuccess, onFailed: onFailed)
    }
}
