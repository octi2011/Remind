//
//  ViewController.swift
//  Remind
//
//  Created by Duminica Octavian on 28/05/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        UNService.shared.authorize()
        CLService.shared.authorize()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didEnterRegion),
                                               name: NSNotification.Name("internalNotification.enteredRegion"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleAction(_:)),
                                               name: NSNotification.Name("internalNotification.handleAction"),
                                               object: nil)
    }
    
    func changeBackground() {
        view.backgroundColor = .red
    }
    
    @objc
    func handleAction(_ sender: Notification) {
        guard let action = sender.object as? NotificationActionID else { return }
        
        switch action {
        case .timer:
            print("timer logic ")
        case .date:
            print("date logic")
        case .location:
            changeBackground()
        }
    }
    
    @objc
    func didEnterRegion() {
        UNService.shared.locationRequest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTimerTapped() {
        print("timer")
        AlertService.actionSheet(in: self, title: "5 seconds") {
            UNService.shared.timerRequest(with: 5)
        }
    }
    
    @IBAction func onDateTapped() {
        print("date")
        
        AlertService.actionSheet(in: self, title: "Some future time") {
            
            var components = DateComponents()
            components.second = 0
            //components.weekday = 0 // takes the gregorian calendar, with sunday as first
            
            UNService.shared.dateRequest(with: components)
        }
        
       
    }
    
    @IBAction func onLocationTapped() {
        print("location")
        
        AlertService.actionSheet(in: self, title: "When I return") {
            CLService.shared.updateLocation()
        }
    }
}

