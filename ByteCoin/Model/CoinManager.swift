//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCoinData(_ coinManager: CoinManager, data: CoinData)
    func didFailWithError(_ coinManager: CoinManager, error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "37859933-B906-4E1B-8FF0-977EF4B42260"
    var delegate: CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String){
        let url = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        processUrl(urlString: url)
    }
    
    func processUrl(urlString: String)  {
        if let url = URL(string: urlString){
            
            let urlSession = URLSession(configuration: .default)
            let task = urlSession.dataTask(with: url) {
                (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(self, error: error!)
                    return
                }
                // update the delegate with actual data
                if let safeData = data {
                    if let coinModel = self.parseCoinBaseResult(data: safeData){
                        self.delegate?.didUpdateCoinData(self, data: coinModel)
                    }
                }
            }
            task.resume()
        }
    }
    
}

extension CoinManager {
    
    func parseCoinBaseResult(data: Data) -> CoinData? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            return decodedData
        } catch {
            self.delegate?.didFailWithError(self, error:error)
            return nil
        }
    }
    
}
