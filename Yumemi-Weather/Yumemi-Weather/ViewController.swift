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
        // Do any additional setup after loading the view.
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
    
    @IBAction func tappedReloadButton(_ sender: Any) {
        
        struct Parameter: Codable {
            let area: String
            let date: String
        }

        let parameter = Parameter(area: "Tokyo", date: "2020-04-01T12:00:00+09:00")

        let encoder = JSONEncoder()
        guard let jsonValue = try? encoder.encode(parameter) else {
            assertionFailure("Failed to encode to JSON.")
            return
        }

        let jsonParameter = String(bytes: jsonValue, encoding: .utf8)!
        
        struct WeatherInfo: Codable {
            let maxTemp: Int
            let minTemp: Int
            let weather: String
            
            enum CodingKeys: String, CodingKey {
                case maxTemp = "max_temp"
                case minTemp = "min_temp"
                case weather
            }
        }
        
        let decoder: JSONDecoder = JSONDecoder()
        do {
            let jsonString = try YumemiWeather.fetchWeather(jsonParameter)
            let jsonData = jsonString.data(using: .utf8)!
            let weatherInfo = try decoder.decode(WeatherInfo.self, from: jsonData)
    
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
        } catch YumemiWeatherError.unknownError {
            showAlert(title: "Unknown error", message: "予期しないエラーが発生しました。")
        } catch YumemiWeatherError.invalidParameterError {
            showAlert(title: "Invalid parameter error", message: "パラメータが正しくありません。")
        } catch {
            showAlert(title: "Error", message: "エラーが発生しました。")
        }
    }
}

extension UIColor{
    static func sunny()->UIColor {
        return UIColor(red: 255/255, green: 153/255, blue: 0/255, alpha: 1.0)
    }

    static func cloudy()->UIColor{
        return UIColor.lightGray
    }

    static func rainy()->UIColor{
        return UIColor(red: 65/255, green: 105/255, blue: 225/255, alpha: 1.0)
    }
}
