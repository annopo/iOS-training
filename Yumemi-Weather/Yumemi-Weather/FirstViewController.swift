//
//  FirstViewController.swift
//  Yumemi-Weather
//
//  Created by anna.ishizaki on 2021/06/03.
//

import UIKit

class FirstViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "main") as? ViewController else {
            return
        }
        viewController.modalPresentationStyle = .fullScreen
        viewController.weatherModelImpl = WeatherModelImpl()
        self.present(viewController, animated: true, completion: nil)
    }
}
