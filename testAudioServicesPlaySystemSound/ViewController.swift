//
//  ViewController.swift
//  testAudioServicesPlaySystemSound
//
//  Created by osu on 2018/05/18.
//  Copyright © 2018 osu. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    private let soundIds: ClosedRange<Int> = 1000...1351
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func tapButton(_ sender: Any) {
        let selected = pickerView.selectedRow(inComponent: 0)
        let soundId:SystemSoundID = SystemSoundID(soundIds.lowerBound + selected)
        AudioServicesPlaySystemSound(soundId)
    }

    @IBAction func tapButtonBundleSound(_ sender: Any) {
        guard let soundPath = Bundle.main.path(forResource: "sound2", ofType: "wav") else {
            return
        }

        guard let soundUrl = NSURL(string: soundPath) else {
            return
        }

        var soundId: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(soundUrl, &soundId)
//        AudioServicesPlaySystemSound(soundId)
//        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        AudioServicesPlayAlertSound(soundId)
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return soundIds.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(soundIds.lowerBound + row)"
    }

}
