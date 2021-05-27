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
                weatherImageView.tintColor = UIColor(red: 255/255, green: 153/255, blue: 0/255, alpha: 1.0)

            case "cloudy":
                weatherImageView.image = UIImage(named: "cloudy")?.withRenderingMode(.alwaysTemplate)
                weatherImageView.tintColor = .lightGray
            case "rainy":
                weatherImageView.image = UIImage(named: "rainy")?.withRenderingMode(.alwaysTemplate)
                weatherImageView.tintColor = UIColor(red: 51/255, green: 204/255, blue: 255/255, alpha: 1.0)

            default:
                print("error")
        }
    }
}

