//
//  Cache.swift
//  AvitoTest-IOS
//
//  Created by Anna Shuryaeva on 16.11.2022.
//

import Foundation

protocol CacheRepositoryProtocol {
    // data from cache or not
    func getData(dataURL: URL, completion: @escaping (Result<Company, Error>) -> Void)
    // if no cache, download from URL
    func downloadAndCacheData(dataURL: URL, completion: @escaping (Result<Data, NetworkErrors>) -> Void)
    // if cache exists, load from cache
    func loadDataFromCache(dataURL: URL) -> Company?
//    func removeCache()
}

class NetworkManager: CacheRepositoryProtocol {

    let cache: URLCache
    init(memoryCapacity: Int, diskCapacity: Int, diskPath: String) {
        cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: diskPath)
    }
    let timeInterval = 3600
    
    //получаем данные из кэша или из интернета, парсим, очищаем кэш
    
    func getData(dataURL: URL, completion: @escaping (Result<Company, Error>) -> Void) {

        let request = URLRequest(url: dataURL)

        if self.cache.cachedResponse(for: request) != nil {
            if let company = loadDataFromCache(dataURL: dataURL) {
                completion(.success(company))
            } else {
                // error
            }
        } else {
            downloadAndCacheData(dataURL: dataURL) { (result) in
               switch result {
               case .success(let data):
                   if let company = self.parse(jsonData: data) {
                       completion(.success(company))
                   } else {
                       // error
                   }
               case .failure(let error):
                   completion(.failure(error))
               }
            }
        }
    }
    
    func loadDataFromCache(dataURL: URL) -> Company? {
        let request = URLRequest(url: dataURL)

        if let cacheResponse = URLCache.shared.cachedResponse(for: request) {
            if let parsingData = parse(jsonData: cacheResponse.data) {
                return parsingData
            }
        }
        return nil
    }

    func downloadAndCacheData(dataURL: URL, completion: @escaping (Result<Data, NetworkErrors>) -> Void) {
         let request = URLRequest(url: dataURL)

         DispatchQueue.global().async {
            let sessionDataTask = URLSession(configuration: .default).dataTask(with: dataURL) {
                (data, response, error) in
                if let data = data {
                     let cachedData = CachedURLResponse(response: response!, data: data)
                     self.cache.storeCachedResponse(cachedData, for: request)
                    completion(.success(data))
                }
                 if let error = error {
                     completion(.failure(.invalidData))
                 }
             }
             sessionDataTask.resume()
         }
    }

    func parse(jsonData: Data) -> Company? {
        let decoder = JSONDecoder()
        if let response = try? decoder.decode(Response.self, from: jsonData) {
            return response.company
//            employees = json.company.employees.sorted(by: { $0.name < $1.name })
        }
        return nil
    }
                       
   func removeCache() {
       guard let url = URL(string: Constants.urlString) else { return }
       let request = URLRequest(url: url)

       DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
           URLCache.shared.removeCachedResponse(for: request)
       }
   }
 
}
