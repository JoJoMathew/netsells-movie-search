//
//  NetworkManager.swift
//  SearchMov
//
//  Created by Mathew Thomas on 25/10/2020.
//

import Foundation

class NetworkManager {
    
    // Base URL & API key
    fileprivate let baseURL: String = "https://www.omdbapi.com/?apikey=bb3eecae&"
    
    // MARK: - Search Movies By Name
    public func searchMovieByName(name: String) -> [SearchElement]? {
        
        var result: Search? = nil
        let semaphore = DispatchSemaphore (value: 0)
        var request = URLRequest(url: URL(string:baseURL + "s=" + name.replacingOccurrences(of: " ", with: "%20") + "&type=movie")!,timeoutInterval: 15)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            
            guard let data = data else {
                print(String(describing: error))
                return
            }
            
            result = try? JSONDecoder().decode(Search.self, from: data)
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
        return (result?.Search)
    }
    
    // MARK: - Get Movie BY ID
    public func getMovieDetailsByID(id: String) -> Movie? {
        
        var result: Movie? = nil
        let semaphore = DispatchSemaphore (value: 0)
        var request = URLRequest(url: URL(string:baseURL + "i=" + id)!,timeoutInterval: 15)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            
            guard let data = data else {
                print(String(describing: error))
                return
            }
            
            result = try? JSONDecoder().decode(Movie.self, from: data)
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
        return result
    }
    
    //TODO: Error Handling
    enum NetworkError: Error {
        case dataEmpty
        case dataInvalid
        case responseInvalid
        case statusCode(Int)
    }
}
