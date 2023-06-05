//
//  NetworkService.swift
//  MusicTextApp
//
//  Created by Даниил Циркунов on 02.06.2023.
//

import Foundation

class NetworkService
{
    //вынести
    let baseURL = "https://itunes.apple.com/search?entity=song&term="
    
    func request(trackName: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let escapedTrackName = trackName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "\(baseURL)\(escapedTrackName)") else {
            //вынести в конст
            let error = NSError(domain: "com.urlConvert.app", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error converting text to URL"])
            completion(nil, error)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    switch statusCode {
                    // вынести в кост
                    case 200:
                        completion(data, nil)
                    case 503:
                        //вынести в конст
                        let error = NSError(domain: "com.network.app", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "HTTP Error: \(statusCode)"])
                        print(error)
                        // запрос через алерт
                        let task = self.createDataTask(from: request, completion: completion)
                        task.resume()
                        //обработа остальные ошибки
                    default:
                        let error = NSError(domain: "com.network.app", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "HTTP Error: \(statusCode)"])
                        completion(nil, error)
                    }
                } else {
                    let error = NSError(domain: "com.network.app", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP Response"])
                    completion(nil, error)
                }
            }
        }
    }
}
