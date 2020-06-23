//
//  HospitalViewController.swift
//  Project01
//
//  Created by KPUGAME on 5/13/20.
//  Copyright © 2020 KIMYOWNG WAN. All rights reserved.
//

import UIKit
import Speech

class HospitalViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

  
    @IBOutlet weak var secondname: UIPickerView!
    @IBOutlet weak var firstname: UIPickerView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBAction func doneToPickerViewController(segue:UIStoryboardSegue){
        
    }
    @IBOutlet weak var transcribeButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var myTextView: UITextView!
    
    @IBAction func startTranscribing(_ sender: Any) {
        transcribeButton.isEnabled = false
        stopButton.isEnabled = true
        try! startSession()
    }
    @IBAction func stopTranscribing(_ sender: Any) {
        if audioEngine.isRunning{
            audioEngine.stop()
            speechRecognitionRequest?.endAudio()
            transcribeButton.isEnabled = true
            stopButton.isEnabled = false
        }
        
        switch(self.myTextView.text){
        case "국민안심병원":
            self.pickerView.selectRow(1, inComponent: 0, animated: true)
        case "국민 안심 병원":
            self.pickerView.selectRow(1, inComponent: 0, animated: true)
        case "코로나검사 실시기관" :
            self.pickerView.selectRow(0, inComponent: 0, animated: true)
        case "코로나 검사 실시 기관" :
            self.pickerView.selectRow(0, inComponent: 0, animated: true)
        case "코로나 선별진료소 운영기관" :
            self.pickerView.selectRow(2, inComponent: 0, animated: true)
        case "코로나 선별 진료소 운영 기관" :
            self.pickerView.selectRow(2, inComponent: 0, animated: true)
      
        default: break
        }
    }
    
   
   var pickerDataSource = ["코로나검사 실시기관","국민안심병원" , "코로나 선별진료소 운영기관"]
    
    var pickerDataSource2 = ["서울특별시", "부산광역시","대구광역시","인천광역시", "광주광역시", "대전광역시", "울산광역시", "경기도", "강원도",
       "충청북도","충청남도","전라북도","전라남도","경상북도","경상남도","제주특별자치도"]
    var pickerDataSource3 = [
       "종로구", "중구", "용산구", "성동구", "광진구", "동대문구", "중랑구", "성북구", "강북구", "도봉구", "노원구", "은평구", "서대문구", "마포구", "양천구", "강서구", "구로구", "금천구", "영등포구", "동장구", "관악구", "서초구", "강남구", "송파구", "강동구"]
       
   var url : String = "http://apis.data.go.kr/B551182/pubReliefHospService/getpubReliefHospList?serviceKey=cCHEHEp%2BWRwV%2FfoF1u%2FVeQGoxigy9y%2FrGH8XHy3oN11YntHkyn3zf8fpQiLDIKWuVY6qT9MUkLU8yQ1naKv%2BFw%3D%3D&numOfRows=10&spclAdmTyCd="
    //A0: 국민안심병원/97: 코로나검사 실시기관/99: 코로나 선별진료소 운영기관
    var pclAdmTyCd : String = "97" // 디폴트 구분코드 = 국민안심병원
    
    
   
  let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))!
      
      var speechRecognitionRequest: SFSpeechAudioBufferRecognitionRequest?
      var speechRecognitionTask : SFSpeechRecognitionTask?
      
      let audioEngine = AVAudioEngine()
      
      func startSession() throws{
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
              result, error in
              
              var finished = false
              if let result = result{
                  self.myTextView.text = result.bestTranscription.formattedString
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
              (buffer: AVAudioPCMBuffer, when:AVAudioTime) in
              self.speechRecognitionRequest?.append(buffer)
          }
          audioEngine.prepare()
          try audioEngine.start()
      }
      
      func authorizeSR(){
          SFSpeechRecognizer.requestAuthorization { authStatus in
              OperationQueue.main.addOperation {
                  switch authStatus{
                  case.authorized:
                      self.transcribeButton.isEnabled = true
                  case .denied:
                      self.transcribeButton.isEnabled = false
                      self.transcribeButton.setTitle("Speech recognition access denied by user", for: .disabled)
                  case .restricted:
                      self.transcribeButton.isEnabled = false
                      self.transcribeButton.setTitle("Speech recognition access restricted by user", for: .disabled)
                  case .notDetermined:
                      self.transcribeButton.isEnabled = false
                      self.transcribeButton.setTitle("Speech recognition not authorized", for: .disabled)
                  @unknown default:
                      fatalError()
                  }
              }
              
          }
      }
      
      override func viewDidLoad() {
          super.viewDidLoad()
          self.pickerView.delegate = self
          self.pickerView.dataSource = self
          self.firstname.delegate = self;
          self.firstname.dataSource = self;
          self.secondname.delegate = self;
          self.secondname.dataSource = self;
          authorizeSR()
      }

   func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
   }
   
   func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int)-> Int{
       return pickerDataSource.count
   }
   
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)-> String?{
       return pickerDataSource[row]
   }
    
    
    
   
    
   
    
   
   func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
       if row == 0 {
           pclAdmTyCd = "97"
       }
       else if row == 1{
        pclAdmTyCd = "A0"
       }
       else if row == 2{
        pclAdmTyCd = "99"
       }
    }
   
   


   override func prepare(for segue: UIStoryboardSegue, sender: Any?){
       if segue.identifier == "segueToTableView"{
           if let navController = segue.destination as? UINavigationController{
               if let hospitalTableViewController = navController.topViewController as? HospitalTableViewController{
                   hospitalTableViewController.url = url + pclAdmTyCd
               }
           }
       }
   }

   

}
