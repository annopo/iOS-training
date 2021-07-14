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
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
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
    
    private func returnWeatherTuple(weather: String) -> (weatherImage: UIImage?, weatherColor: UIColor?) {

        switch weather {
        case "sunny":
            return (weatherImage: UIImage(named: weather)?.withRenderingMode(.alwaysTemplate), weatherColor: UIColor.sunny())
        case "cloudy":
            return (weatherImage: UIImage(named: weather)?.withRenderingMode(.alwaysTemplate), weatherColor: UIColor.cloudy())
        case "rainy":
            return (weatherImage: UIImage(named: weather)?.withRenderingMode(.alwaysTemplate), weatherColor: UIColor.rainy())
        default:
            return (nil, nil)
        }
    }
    
    private func changeImageView(weather: String?) {
        guard let weather = weather else {
            print("nil")
            return
        }
        let weatherView = returnWeatherTuple(weather: weather)
        weatherImageView.image = weatherView.weatherImage
        weatherImageView.tintColor = weatherView.weatherColor
    }
    
    private func handleWeather(result: Result<WeatherInfo, Error>) {
        switch result {
        case .success(let weatherInfo):
            self.changeLabelText(max: weatherInfo.maxTemp, min: weatherInfo.minTemp)
            self.changeImageView(weather: weatherInfo.weather)
        case .failure(let error):
            switch error {
            case YumemiWeatherError.unknownError:
                self.showAlert(title: "Unknown error", message: "予期しないエラーが発生しました。")
            case YumemiWeatherError.invalidParameterError:
                self.showAlert(title: "Invalid parameter error", message: "パラメータが正しくありません。")
            default:
                self.showAlert(title: "Unknown error", message: "予期しないエラーが発生しました。")
            }
        }
    }
    
    func reloadWeather() {
        let request = Request(area: "Tokyo", date: "2020-04-01T12:00:00+09:00")
        self.activityIndicatorView.startAnimating()
        weatherModelImpl?.getWeather(request: request) { result in
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                self.activityIndicatorView.hidesWhenStopped = true
                self.handleWeather(result: result)
            }
        }
    }
    
    @IBAction func tappedReloadButton(_ sender: Any) {
      reloadWeather()
    }
    
    @IBAction func tappedCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
