//
//  ViewController.swift
//  HospitalMap
//
//  Created by kpugame on 2020/05/17.
//  Copyright © 2020 kpugame. All rights reserved.
//

import UIKit
import Speech

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBAction func doneToPickerViewController(segue:UIStoryboardSegue){
        
    }
    
    
    @IBAction func startTranscribing(_ sender: Any) {
        startButton.isEnabled = false
        stopButton.isEnabled = true
        try! startSession()
    }
    @IBAction func stopTranscribing(_ sender: Any) {
        if audioEngine.isRunning{
            audioEngine.stop()
            speechRecognitionRequest?.endAudio()
            startButton.isEnabled = true
            stopButton.isEnabled = false
        }
        
        switch(self.voiceTextView.text){
        case "광진구":
            self.pickerView.selectRow(0, inComponent: 0, animated: true)
        case "구로구" :
            self.pickerView.selectRow(1, inComponent: 0, animated: true)
        case "동대문구" :
            self.pickerView.selectRow(2, inComponent: 0, animated: true)
        case "종로구" :
            self.pickerView.selectRow(3, inComponent: 0, animated: true)
        default: break
        }
    }
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var voiceTextView: UITextView!


    var pickerDataSource = [
    "서울특별시": ["종로구", "중구", "용산구", "성동구", "광진구", "동대문구", "중랑구", "성북구", "강북구", "도봉구", "노원구", "은평구", "서대문구", "마포구", "양천구", "강서구", "구로구", "금천구", "영등포구", "동장구", "관악구", "서초구", "강남구", "송파구", "강동구"],
    "부산광역시": ["중구", "서구", "동구", "영도구", "부산진구", "동래구", "남구", "북구", "해운대구", "사하구", "금정구", "강서구", "연제구", "수영구", "사상구", "기장군"],
    "대구광역시": ["중구", "동구", "서구", "남구", "북구", "수성구", "달서구", "달성군"],
    "인천광역시": ["중구", "동구", "남구", "연수구" , "남동구", "부평구", "계양구", "서구", "강화군", "옹진군"],
    "광주광역시": ["동구", "서구", "남구", "북구", "광산구"], "대전광역시": ["동구", "중구", "서구", "유성구", "대덕구"],
    "울산광역시": ["중구","남구", "동구", "북구", "울주군"],
    "경기도": ["수원시", "고양시","성남시", "용인시", "부천시", "안산시", "남양주시", "안양시", "화성시", "평택시", "의정부시", "시흥시", "파주시", "김포시", "광명시", "광주시", "군포시", "오산시", "이천시", "양주시", "안성시", "구리시", "포천시", "의왕시", "하남시", "여주시", "양평군", "동두천시", "과천시", "가평군", "연천군"],
    "강원도": ["춘천시", "원주시", "강릉시", "동해시", "태백시", "속초시", "삼척시", "홍천군", "횡성군", "영월군", "평창군", "정선군", "철원군", "화천군", "양구군", "인제군", "고성군", "양양군"],
    "충청북도": ["청주시", "충주시", "제천시", "보은군", "옥천군", "영동군", "증평군", "진천군", "괴산군", "음성군", "단양군"],
    "충청남도": ["천안시", "공주시", "보령시", "아산시", "서산시", "논산시", "계릉시", "당진시", "금산군", "부여군", "서천군", "청양군", "홍성군", "예산군", "태안군"],
    "전라북도": ["전주시", "군산시", "익산시", "정읍시", "남원시", "김제시", "완주군",  "진안군", "무주군", "장수군", "임실군", "순창군", "고창군", "부안군"],
    "전라남도": ["목포시", "여수시", "순천시", "나주시", "광양시", "담양군", "곡성군", "구례군", "고흥군", "보성군", "화순군", "장흥군", "강진군", "해남군", "영암군", "무안군", "함평군", "영광군", "장성군", "완도군", "진도군", "신안군"],
    "경상북도": ["포항시", "경주시", "김천시", "안동시", "구미시", "영주시", "영천시", "상주시", "문경시", "경산시", "군위군", "의성군", "청송군", "영양군", "영덕군", "청도군", "고령군", "성주군", "칠곡군", "예천군", "봉화군", "울진군", "울릉군"],
    "경상남도": ["창원시", "진주시", "통영시", "사천시", "김해시", "밀양시", "거제시", "양산시", "의령군", "함안군", "창녕군", "고성군", "남해군", "하동군", "산청군", "함양군", "거창군", "합천군"],
    "제주특별자치도": ["제주시", "서귀포시"]]
    var url : String = "http://apis.data.go.kr/B551182/hospInfoService/getHospBasisList?pageNo=1&numOfRows=10&serviceKey=sea100UMmw23Xycs33F1EQnumONR%2F9ElxBLzkilU9Yr1oT4TrCot8Y2p0jyuJP72x9rG9D8CN5yuEs6AS2sAiw%3D%3D&sidoCd=110000&sgguCd="
    
    var sgguCd : String = "110023" //디폴트 시구코드 = 광진구

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
                self.voiceTextView.text = result.bestTranscription.formattedString
                finished = result.isFinal
            }
            
            if error != nil || finished{
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.speechRecognitionRequest = nil
                self.speechRecognitionTask = nil
                
                self.startButton.isEnabled = true
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
                    self.startButton.isEnabled = true
                case .denied:
                    self.startButton.isEnabled = false
                    self.startButton.setTitle("Speech recognition access denied by user", for: .disabled)
                case .restricted:
                    self.startButton.isEnabled = false
                    self.startButton.setTitle("Speech recognition access restricted by user", for: .disabled)
                case .notDetermined:
                    self.startButton.isEnabled = false
                    self.startButton.setTitle("Speech recognition not authorized", for: .disabled)
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
        switch row {
        case 0:
            sgguCd = "110023"
        case 1:
            sgguCd = "110005"
        case 2:
            sgguCd = "110007"
        default:
            sgguCd = "110016"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "segueToTableView"{
            if let navController = segue.destination as? UINavigationController{
                if let hospitalTableViewController = navController.topViewController as? HospitalTableViewController{
                    hospitalTableViewController.url = url + sgguCd
                }
            }
        }
    }
    
}

