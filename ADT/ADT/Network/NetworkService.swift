//
//  NetworkService.swift
//  ADT
//
//  Created by Xavier De Leon on 7/28/21.
//

import Foundation

let endPointURLString = "https://rickandmortyapi.com/api/episode"

final class NetworkService {
    static let shared = NetworkService()
    private init() {}
    
//    func fetchShows(completion: @escaping ([Welcome], Error?) -> ()) {
    func fetchShows(completion: @escaping (Welcome?, Error?) -> ()) {
        guard let url = URL(string: endPointURLString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, error) in
            if let error = error {
                completion(nil, error)
                print("Error fetching shows:", error)
                return
            }
            
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let shows = try decoder.decode(Welcome.self, from: data)
                DispatchQueue.main.async {
                    completion(shows, nil)
                }
            } catch let jsonErr {
                print("Error decoding shows:", jsonErr)
            }
        }.resume()
    }
}
