

import Foundation
protocol CoinManagerDelegate {
    func didUpdatePrice(price : String,currency :String)
    func didFailWithError(error : Error)
}
struct CoinManager {
    
    var delegate : CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "A5684375-E074-41CB-987A-656F9A9C3CBE"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency :String){
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        DispatchQueue.main.async {
            LoadingView.instance.show()
        }
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, urlResponse, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    DispatchQueue.main.async {
                        LoadingView.instance.hide()
                    }
                    return
                }
                if let safeData = data{
                    
                    if let bitcoinPrice = self.parseJSON(data: safeData){
                    let priceString = String(format: "%.2f", bitcoinPrice)
                        DispatchQueue.main.async {
                            LoadingView.instance.hide()
                        }
                    
                    self.delegate?.didUpdatePrice(price: priceString, currency: currency)
                    }
                    
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(data : Data) -> Double? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let price = decodedData.rate
//            print(price)
            return price
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
            
        }
    }
}
