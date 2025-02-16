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
    func fetchItems(completion: @escaping (Result<[Items.DataModel], Error>) -> Void) {
        let urlString = "https://api.escuelajs.co/api/v1/products"
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let items = try JSONDecoder().decode([Items.DataModel].self, from: data)
                completion(.success(items))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
