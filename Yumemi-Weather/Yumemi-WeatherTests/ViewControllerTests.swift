//
//  ViewControllerTests.swift
//  Yumemi-WeatherTests
//
//  Created by anna.ishizaki on 2021/06/29.
//

import XCTest
@testable import Yumemi_Weather

class ViewControllerTests: XCTestCase {
    
    var mainViewController: ViewController?
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let testViewController = storyboard.instantiateViewController(withIdentifier: "main") as? ViewController else {
            return
        }
        mainViewController = testViewController
        
        print("set rootViewController")
        UIApplication.shared.windows.first { $0.isKeyWindow }!.rootViewController = testViewController
        
        let exp = self.expectation(description: "test sunny")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            exp.fulfill()
        })

        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testSunny() {
        
        mainViewController?.weatherModelImpl = SunnyModelImplMock()
        mainViewController?.loadViewIfNeeded()

        let sunnyWeatherInfo = SunnyModelImplMock().getWeather(request: Request(area: "Tokyo", date: "2020-04-01T12:00:00+09:00"))
        mainViewController?.reloadWeather()
        
        XCTAssertTrue(sunnyWeatherInfo?.maxTemp == Int((mainViewController?.maxTempLabel.text)!))
        XCTAssertTrue(sunnyWeatherInfo?.minTemp == Int((mainViewController?.minTempLabel.text)!))
        XCTAssertTrue(UIImage(named: sunnyWeatherInfo!.weather)?.pngData() == mainViewController?.weatherImageView.image?.pngData())
    }
    
    func testCloudy() {
        
        mainViewController?.weatherModelImpl = CloudyModelImplMock()
        mainViewController?.loadViewIfNeeded()

        let cloudyWeatherInfo = CloudyModelImplMock().getWeather(request: Request(area: "Tokyo", date: "2020-04-01T12:00:00+09:00"))
        mainViewController?.reloadWeather()
        
        XCTAssertTrue(cloudyWeatherInfo?.maxTemp == Int((mainViewController?.maxTempLabel.text)!))
        XCTAssertTrue(cloudyWeatherInfo?.minTemp == Int((mainViewController?.minTempLabel.text)!))
        XCTAssertTrue(UIImage(named: cloudyWeatherInfo!.weather)?.pngData() == mainViewController?.weatherImageView.image?.pngData())
    }
    
    func testRainy() {
        
        mainViewController?.weatherModelImpl = RainyModelImplMock()
        mainViewController?.loadViewIfNeeded()

        let rainyWeatherInfo = RainyModelImplMock().getWeather(request: Request(area: "Tokyo", date: "2020-04-01T12:00:00+09:00"))
        mainViewController?.reloadWeather()
        
        XCTAssertTrue(rainyWeatherInfo?.maxTemp == Int((mainViewController?.maxTempLabel.text)!))
        XCTAssertTrue(rainyWeatherInfo?.minTemp == Int((mainViewController?.minTempLabel.text)!))
        XCTAssertTrue(UIImage(named: rainyWeatherInfo!.weather)?.pngData() == mainViewController?.weatherImageView.image?.pngData())
    }
    
}
