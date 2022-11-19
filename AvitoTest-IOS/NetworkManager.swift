//
//  Cache.swift
//  AvitoTest-IOS
//
//  Created by Anna Shuryaeva on 16.11.2022.
//

import Foundation

protocol CacheRepositoryProtocol {
    //data from cache or not
    func getData(dataURL: URL)
    //if no cache, download from URL
    func downloadAndCacheData(dataURL: URL, completion: @escaping (Result<Data, Error>) -> Void)
    //if cache exists, load from cache
    func loadDataFromCache(dataURL: URL) -> Company?
//    func removeCache()
}

class NetworkManager: CacheRepositoryProtocol {

    let cache = URLCache.shared
    let timeInterval = 3600
    
    //получаем данные из кэша или из интернета, парсим, очищаем кэш
    
    func getData(dataURL: URL) {

        let request = URLRequest(url: dataURL)

        if self.cache.cachedResponse(for: request) != nil {
            loadDataFromCache(dataURL: dataURL)
        } else {
            downloadAndCacheData(dataURL: dataURL) { (result) in
               switch result {
               case .success(let data):
                   self.parse(jsonData: data)
               case .failure(let error):
                   print(error)
               }
            }
        }
    }
    
    func loadDataFromCache(dataURL: URL) ->  Company? {
        let request = URLRequest(url: dataURL)
        
        if let cacheResponse = URLCache.shared.cachedResponse(for: request) {
            if let parsingData = parse(jsonData: cacheResponse.data) {
                return parsingData
            }
        }
        return nil
    }

    
    func downloadAndCacheData(dataURL: URL, completion: @escaping (Result<Data, Error>) -> Void) {
         let request = URLRequest(url: dataURL)
                     
         DispatchQueue.global().async {
            let sessionDataTask = URLSession(configuration: .default).dataTask(with: dataURL)
            {
                (data, response,error) in
                if let data = data {
                     let cachedData = CachedURLResponse(response: response!, data: data)
                     self.cache.storeCachedResponse(cachedData, for: request)
                    completion(.success(data))
                }
                 if let error = error {
                     completion(.failure(error))
                 }
             }
             sessionDataTask.resume()
         }
    }
    
        func parse(jsonData: Data) -> Company? {
        let decoder = JSONDecoder()
        if let json = try? decoder.decode(Company.self, from: jsonData) {
            print(json)
            return json
//            employees = json.company.employees.sorted(by: { $0.name < $1.name })
        }
        return nil
    }
                       
//   func removeCache() {
//       guard let url = URL(string: Constants.urlString) else { return }
//       let request = URLRequest(url: url)
//
//       DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval) {
//           URLCache.shared.removeCachedResponse(for: request)
//       }
//   }
 
}
    
