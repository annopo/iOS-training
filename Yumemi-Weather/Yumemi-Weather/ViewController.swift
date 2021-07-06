//
//  ViewController.swift
//  Yumemi-Weather
//
//  Created by anna.ishizaki on 2021/05/25.
//

import UIKit
import YumemiWeather

class ViewController: UIViewController {
    
    var weatherModelImpl: WeatherModel?
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadWeather()
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
            return
        }
        maxTempLabel.text = String(maxTemp)
        
        guard let minTemp = min else {
            return
        }
        minTempLabel.text = String(minTemp)
    }
    
    private func changeImageView(weather: String?) {
        guard let weatherView = weather else {
            return
        }
        
        weatherImageView.image = UIImage(named: weatherView)?.withRenderingMode(.alwaysTemplate)
        
        switch weatherView {
        case "sunny":
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
    }
    
    func reloadWeather() {
        let request = Request(area: "Tokyo", date: "2020-04-01T12:00:00+09:00")
        do {
            let weatherInfo = try weatherModelImpl?.getWeather(request: request)

            changeLabelText(max: weatherInfo?.maxTemp, min: weatherInfo?.minTemp)
            changeImageView(weather: weatherInfo?.weather)
            
        } catch YumemiWeatherError.unknownError {
            showAlert(title: "Unknown error", message: "予期しないエラーが発生しました。")
        } catch YumemiWeatherError.invalidParameterError {
            showAlert(title: "Invalid parameter error", message: "パラメータが正しくありません。")
        } catch {
            showAlert(title: "Unknown error", message: "予期しないエラーが発生しました。")
        }
    }
    
    @IBAction func tappedReloadButton(_ sender: Any) {
        reloadWeather()
    }
    
    @IBAction func tappedCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
