//
//  APIClient.swift
//  PremierLeagueX
//
//  Created by Shrouk Yasser on 18/04/2024.
//

import Foundation
import Alamofire

class APIClient<T: TargetType> {
    
    /// Properties.
    ///
    private var loadingCheck: Bool = true
    
}

/// Generic function to handle requests with request model.
///
extension APIClient {
    /// A generic method to perform requests with requestModels.
    /// - Parameters:
    ///   - target: It carries the data of the request you are performing.
    ///   - param: It is the parameters to be sent with the request.
    ///   - completion: That carries a success or failure response.
    ///
    func performRequest<M: Decodable, P: Encodable>(target: T, param: P?, completion: @escaping (Result<M, AppErrorType>) -> Void)  {
        InternetReachability.shared.InternetConnectivity { [weak self] in
            guard let self = self else { return }

            /// Start loading.
            if self.loadingCheck { LoadingManager.shared.showLoading() }

            /// Create request properties.
            let url = target.baseURL + target.path
            let method = HTTPMethod(rawValue: target.method.rawValue)
            let headers: HTTPHeaders = [
                Constants.API_AUTH_KEY: Constants.API_AUTH_VALUE]
            let paramters = [Constants.DATE_FROM: Utilities.getcurrentDate(), Constants.DATE_TO: Utilities.getNextYearDate()]

            /// Create AF request.
            AF.request(url, method: method, parameters: paramters, encoder: URLEncodedFormParameterEncoder.default, headers: headers).responseDecodable(of: M.self) { response in
                if self.loadingCheck { LoadingManager.shared.hideLoading() }

                debugPrint(response)

                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(_):
                    if let statusCode = response.response?.statusCode {
                        switch statusCode {
                        case 500...599:
                            completion(.failure(.serverError))
                        default:
                            completion(.failure(.genericError))
                        }
                    } else {
                        completion(.failure(.genericError))
                    }
                }
            }
        } failCompletion: { [weak self] in
            guard let self = self else { return }

            if self.loadingCheck { LoadingManager.shared.hideLoading() }

            completion(.failure(.internetConnectionError))
        }
    }
}
