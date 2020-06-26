//
//  CoinModel.swift
//  ByteCoin
//
//  Created by everest on 26/06/2020.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData : Codable{
    
    let time: String
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
    
    var rateString: String {
        return  String(format: "%.2f", self.rate)
    }
}
