//
//  MaskViewController.swift
//  Project01
//
//  Created by KPUGAME on 5/13/20.
//  Copyright © 2020 KIMYOWNG WAN. All rights reserved.
//

import UIKit
import Speech

class MaskViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var transcribeButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var TextView: UITextView!
    var firstId : String = "서울특별시"
    
    
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))!
    
    private var speechRecognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var speechRecognitionTask: SFSpeechRecognitionTask?
    
    private let audioEngine = AVAudioEngine()
    
    @IBAction func startTranscribing(_ sender: Any)
    {
        transcribeButton.isEnabled = false
        stopButton.isEnabled = true
        try! startSession()
    }
    @IBAction func stopTrancribing(_ sender: Any)
    {
        audioEngine.stop()
        speechRecognitionRequest?.endAudio()
        transcribeButton.isEnabled = true
        stopButton.isEnabled = false
        
        var idx : Int = 0
        for key in pickerDataSource
        {
            if TextView.text == key{
                self.pickerView.selectRow(idx, inComponent: 0, animated: true)
                firstId = key
            break
            }
            
            idx += 1
        }

    }
    func startSession() throws {
        if let recognitionTask = speechRecognitionTask{
            recognitionTask.cancel()
            self.speechRecognitionTask = nil
        }
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(AVAudioSession.Category.record)
        
        speechRecognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let recognitionRequest = speechRecognitionRequest else{
            fatalError("SFSpeechAudioBufferRecognitionRequest object creation failed")
        }
        let inputNode = audioEngine.inputNode
        
        recognitionRequest.shouldReportPartialResults = true
        
        speechRecognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest){
            result,error in var finished = false
            
            if let result = result{
                self.TextView.text = result.bestTranscription.formattedString
                finished = result.isFinal
            }
            if error != nil || finished{
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.speechRecognitionRequest = nil
                self.speechRecognitionTask = nil
                
                self.transcribeButton.isEnabled = true
            }
        }
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat){
            (buffer: AVAudioPCMBuffer, when: AVAudioTime) in self.speechRecognitionRequest?.append(buffer)
        }
        audioEngine.prepare()
        try audioEngine.start()
    }
    
    @IBAction func doneToPickerViewController(segue: UIStoryboardSegue){
    
    }
    override func prepare(for segue: UIStoryboardSegue,sender: Any?){
          if segue.identifier == "segueToMask2View"{
              if let navController = segue.destination as? UINavigationController{
                  if let Mask2ViewController = navController.topViewController as? Mask2ViewController{
                      Mask2ViewController.firstId = firstId//url + sgguCd
                  }
              }
          }
      }
    
    @IBOutlet weak var firstName: UIPickerView!
    
    var pickerDataSource = ["서울특별시", "부산광역시","대구광역시","인천광역시", "광주광역시", "울산광역시", "경기도", "강원도",
    "충청북도","충청남도","전라북도","전라남도","경상북도","경상남도","제주특별자치도"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstName.delegate = self;
        self.firstName.dataSource = self;
        // Do any additional setup after loading the view.
    }
    

    
     func numberOfComponents(in pickerView: UIPickerView) -> Int{
           return 1
       }
    // pickerView의 각 컴포넌트에 대한 row의 개수 = pickerDataSource 배열 원소 개수
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return pickerDataSource.count
       }
       //pickerView의 주어진 컴포넌트 /row에 대한 데이터 = pickerDataSource 배열의 원소
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
           return pickerDataSource[row]
       }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       firstId = pickerDataSource[row]
        let explore1 = ExplodeView(frame: CGRect(x: 30, y: 300, width: 10, height: 10))
        pickerView.superview?.addSubview(explore1)
        pickerView.superview?.sendSubviewToBack(_: explore1)
        
        let explore2 = ExplodeView(frame: CGRect(x: 350, y: 300, width: 10, height: 10))
        pickerView.superview?.addSubview(explore2)
        pickerView.superview?.sendSubviewToBack(_: explore2)
        //audioController.playerEffect(name: SoundDing)
    }
    
    func authorizeSR()
    {
        SFSpeechRecognizer.requestAuthorization{
            authStatus in OperationQueue.main.addOperation {
                switch authStatus{
                case .authorized:
                    self.transcribeButton.isEnabled = true
                    
                case .denied:
                    self.transcribeButton.isEnabled = false
                    self.transcribeButton.setTitle("Speech recognition access denied by user", for: .disabled)
                case .restricted:
                    self.transcribeButton.isEnabled = false
                    self.transcribeButton.setTitle("Speech recognition restricted on device", for: .disabled)
                case .notDetermined:
                    self.transcribeButton.isEnabled = false
                    self.transcribeButton.setTitle("Speech recognition not authorized", for: .disabled)
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
