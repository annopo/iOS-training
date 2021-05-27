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
        let weather = YumemiWeather.fetchWeather()
        
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
    }
}

extension UIColor{
    class func sunny()->UIColor {
        return UIColor(red: 255/255, green: 153/255, blue: 0/255, alpha: 1.0)
    }

    class func cloudy()->UIColor{
        return UIColor.lightGray
    }

    class func rainy()->UIColor{
        return UIColor(red: 51/255, green: 204/255, blue: 255/255, alpha: 1.0)
    }
}
