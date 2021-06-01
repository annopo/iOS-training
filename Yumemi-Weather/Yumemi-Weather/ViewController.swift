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
    
    @IBAction func tappedReloadButton(_ sender: Any) {
        do {
            let weather = try YumemiWeather.fetchWeather(at: "Tokyo")
            switch weather {
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
        return UIColor(red: 51/255, green: 204/255, blue: 255/255, alpha: 1.0)
    }
}
