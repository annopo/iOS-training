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
            let alert: UIAlertController = UIAlertController(title: "Unknown error", message: "予期しないエラーが発生しました", preferredStyle: UIAlertController.Style.alert)

            let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:  {
                    (action: UIAlertAction!) -> Void in
                    print("unknown error")
            })
                
            alert.addAction(cancelAction)
                
            present(alert, animated: true, completion: nil)
        } catch YumemiWeatherError.invalidParameterError {
            let alert: UIAlertController = UIAlertController(title: "Invalid parameter error", message: "パラメータが正しくありません", preferredStyle: UIAlertController.Style.alert)

            let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:  {
                (action: UIAlertAction!) -> Void in
                print("invalid parameter error")
            })
            
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
        } catch {
            print("error")
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
