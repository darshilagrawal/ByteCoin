

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource=self
        currencyPicker.delegate=self
        coinManager.delegate=self
        // Do any additional setup after loading the view.
    }
}
//MARK: - UIPickerViewDelegate
    extension ViewController :UIPickerViewDelegate{
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return coinManager.currencyArray[row]
//    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency=coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    }
//       Function to set the Text Color of PickerView to White
        
        func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
            return NSAttributedString(string: coinManager.currencyArray[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }

}
//MARK: - UIPickerViewDataSource
extension ViewController:UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}

//MARK: - CoinManagerDelegate

extension ViewController : CoinManagerDelegate{
    func didUpdatePrice(price: String, currency: String) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text=price
            self.currencyLabel.text=currency
            
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
