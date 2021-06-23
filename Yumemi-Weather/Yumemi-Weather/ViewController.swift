//
//  ViewController.swift
//  Yumemi-Weather
//
//  Created by anna.ishizaki on 2021/05/25.
//

import UIKit
import YumemiWeather

class ViewController: UIViewController {
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.viewWillEnterForeground(_:)), name:UIApplication.willEnterForegroundNotification, object: nil)
    }

    private func showAlert(title: String, message: String) {
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:  {
                (action: UIAlertAction!) -> Void in
                print(title)
        })
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func changeLabelText(max: Int?, min: Int?) {
        guard let maxTemp = max else {
            print("nil")
            return
        }
        maxTempLabel.text = String(maxTemp)
        
        guard let minTemp = min else {
            print("nil")
            return
        }
        minTempLabel.text = String(minTemp)
    }
    
    private func reloadWeather() {
        
        let weatherModelImpl = WeatherModelImpl()
        let request = Request(area: "Tokyo", date: "2020-04-01T12:00:00+09:00")
        let result = weatherModelImpl.getWeather(request: request)
        switch result {
        case .success(let weatherInfo):
            changeLabelText(max: weatherInfo.maxTemp, min: weatherInfo.minTemp)
            
            switch weatherInfo.weather {
                case "sunny":
                    weatherImageView.image = UIImage(named: "sunny")?.withRenderingMode(.alwaysTemplate)
                    weatherImageView.tintColor = UIColor.sunny()
                case "cloudy":
                    weatherImageView.image = UIImage(named: "cloudy")?.withRenderingMode(.alwaysTemplate)
                    weatherImageView.tintColor = UIColor.cloudy()
                case "rainy":
                    weatherImageView.image = UIImage(named: "rainy")?.withRenderingMode(.alwaysTemplate)
                    weatherImageView.tintColor = UIColor.rainy()
                default:
                    print("error")
            }
            
        case .failure(let error):
            if let yumemiWeatherError = error as? YumemiWeatherError {
                switch yumemiWeatherError {
                case YumemiWeatherError.unknownError:
                    showAlert(title: "Unknown error", message: "予期しないエラーが発生しました。")
                case YumemiWeatherError.invalidParameterError:
                    showAlert(title: "Invalid parameter error", message: "パラメータが正しくありません。")
                }
            } else {
                showAlert(title: "Unknown error", message: "予期しないエラーが発生しました。")
            }
        }
    }
    
    @IBAction func tappedReloadButton(_ sender: Any) {
        reloadWeather()
    }
    
    @IBAction func tappedCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func viewWillEnterForeground(_ notification: Notification?) {
        print("foreground")
        reloadWeather()
    }
}
