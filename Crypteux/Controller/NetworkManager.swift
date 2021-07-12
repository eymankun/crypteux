//
//  NetworkManager.swift
//  Crypteux
//
//  Created by Aiman on 2021/07/11.
//

import Foundation

protocol NetworkManagerDelegate {
    func didUpdateCoin(networkManager: NetworkManager, coin: [CoinData])
}

struct NetworkManager {
    
    var delegate: NetworkManagerDelegate?
    
    func fetchData() {
        let coinURL = "\(K.coinURL)\(K.coinID)&apikey=\(API.Key)"
         
        if let url = URL(string: coinURL) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
//                if error != nil {
//                    print(error!)
//                    return
//                }
//                if let safeData = data {
//                    self.coinDataArray = parseJSON(safeData)!
//                }
                
                if error == nil {
                    if let safeData = data {
                        if let coinData = parseJSON(safeData) {
                            DispatchQueue.main.async {
                                self.delegate?.didUpdateCoin(networkManager: self, coin: coinData)
                            }
                        }
                    }
                } else {
                    print(error!)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> [CoinData]? {
        let decoder = JSONDecoder()
        do {
            let coinArray = try decoder.decode([CoinData].self, from: data)
            return coinArray
        } catch {
            print(error)
            return nil
        }
    }
    
    
}
