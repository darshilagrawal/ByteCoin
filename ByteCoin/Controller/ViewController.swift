

import UIKit
import Lottie

class ViewController: UIViewController {
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    @IBOutlet weak var animationView: AnimationView!
    
    var coinManager = CoinManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource=self
        currencyPicker.delegate=self
        coinManager.delegate=self
        animationView.isHidden = true
        animationView.backgroundColor = .black
    }
}

//MARK: - UIPickerViewDelegate
extension ViewController :UIPickerViewDelegate {
    
    //Function to return Text String as Title
    //    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    //        return coinManager.currencyArray[row]
    //    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency=coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    }
    
    //Function to return Attributed Text String as Title
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: coinManager.currencyArray[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
}

//MARK: - UIPickerViewDataSource
extension ViewController:UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}

//MARK: - CoinManagerDelegate

extension ViewController : CoinManagerDelegate {
    func didUpdatePrice(price: String, currency: String) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text=price
            self.currencyLabel.text=currency
        }
    }
    
    func didFailWithError(error: Error) {
        let alert = UIAlertController(title: "Please Try Again", message: "Connectivity Issues", preferredStyle: .alert)
        let action = UIAlertAction(title: "Try Again", style: .default, handler: nil)
        alert.addAction(action)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
