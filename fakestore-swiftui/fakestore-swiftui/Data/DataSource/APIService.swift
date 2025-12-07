//
//  APIError.swift
//  fakestore-swiftui
//
//  Created by Christian Alexandre on 07/12/25.
//


import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
}

class APIService {
    static let shared = APIService()
    private init() {}
    
    func fetchProducts(limit: Int, skip: Int) async throws -> (products: [ProductDTO], total: Int) {
        var components = URLComponents(string: "https://dummyjson.com/products")!
        components.queryItems = [
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "skip", value: "\(skip)")
        ]
        
        guard let url = components.url else { throw APIError.invalidURL }
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decodedResponse = try JSONDecoder().decode(ProductListResponseDTO.self, from: data)
        return (decodedResponse.products, decodedResponse.total)
    }
    
    func fetchProduct(id: Int) async throws -> ProductDTO {
        guard let url = URL(string: "https://dummyjson.com/products/\(id)") else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        return try JSONDecoder().decode(ProductDTO.self, from: data)
    }
}
