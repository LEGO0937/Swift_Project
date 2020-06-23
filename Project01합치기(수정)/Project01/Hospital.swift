//
//  Hospital.swift
//  Project01
//
//  Created by KPUGAME on 6/24/20.
//  Copyright © 2020 KIMYOWNG WAN. All rights reserved.
//

import Foundation


class Hospital: NSObject{

    var yadmNm = String()
      var telno = String()
    var sidoNm = String()
    var sgguNm = String()
    var spclAdmTyCd = String()
    
 
    init(yadmNm: String, telno: String, sidoNm: String,
         sgguNm: String,spclAdmTyCd: String){
        self.yadmNm = yadmNm
        self.telno = telno
        self.sidoNm = sidoNm
        self.sgguNm = sgguNm
        self.spclAdmTyCd = spclAdmTyCd
        super.init()
    }
}
