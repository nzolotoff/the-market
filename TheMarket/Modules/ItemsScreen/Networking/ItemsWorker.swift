//
//  ItemsWorker.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 15.02.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class ItemsWorker: ItemsWorkingLogic {
    // MARK: - Fields
    private let baseURL = "https://api.escuelajs.co/api/v1/products"
    
    // MARK: - Methods
    func fetchItems(completion: @escaping (Result<[Items.DataModel], Error>) -> Void) {
        performRequest(urlString: baseURL, completion: completion)
    }
    
    func searchItems(by title: String, completion: @escaping (Result<[Items.DataModel], Error>) -> Void) {
        let encodedTitle = title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "\(baseURL)?title=\(encodedTitle)"
        performRequest(urlString: urlString, completion: completion)
    }
    
    // MARK: - Private methods
    private func performRequest<T: Decodable>(
        urlString: String,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                completion(.failure(NetworkError.invalidURL))
            }
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.noData))
                }
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.decodingError))
                }
            }
        }.resume()
    }
}
