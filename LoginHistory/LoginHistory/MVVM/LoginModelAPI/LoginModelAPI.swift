//
//  LoginModelAPI.swift
//  LoginHistory
//
//  Created by Lyvennitha on 14/12/21.
//

import Foundation
class LoginModelAPI {
    
    class func getDetails(parameter: [String: Any]?, onResponse: @escaping (Result<LoginDataResponse, Error>)->()){
        NetworkLayer.shared.postDetails(parameters: parameter!, onResponse: onResponse)
    }
}

// MARK: - LoginHistoryResponse
class LoginDataResponse: Codable {
    var at, cul, culCon: String?
    var culConID, dID: Int?
    var dName: String?
    var eMS: [Em]?
    var em, lgt: String?
    var lID: Int?
    var os, pwd: String?
    var sID: Int?
    var sku: String?
    var uID: Int?
    var un: String?
    var cID: Int?
    var com, dn, dos: String?
    var ea, ec, emailAddress, fn: String?
    var gcmuqID: String?
    var isCon, isLT, isPU, isSuc: Bool?
    var isSync, isTri: Bool?
    var lld: String?
    var ln: String?
    var mod: String?
    var ndds, pip, pn, sd: String?
    var slt, sTs, uqID: String?
    var us: Int?
    var ver: String?

    enum CodingKeys: String, CodingKey {
        case at = "AT"
        case cul = "Cul"
        case culCon = "CulCon"
        case culConID = "CulConId"
        case dID = "DId"
        case dName = "DName"
        case eMS = "EMs"
        case em = "Em"
        case lgt = "LGT"
        case lID = "LId"
        case os = "OS"
        case pwd = "PWD"
        case sID = "SId"
        case sku = "Sku"
        case uID = "UId"
        case un = "UN"
        case cID = "CId"
        case com = "COM"
        case dn = "DN"
        case dos = "DOS"
        case ea = "EA"
        case ec = "EC"
        case emailAddress = "EmailAddress"
        case fn = "FN"
        case gcmuqID = "GCMUQId"
        case isCon = "IsCon"
        case isLT = "IsLT"
        case isPU = "IsPU"
        case isSuc = "IsSuc"
        case isSync = "IsSync"
        case isTri = "IsTri"
        case lld = "LLD"
        case ln = "LN"
        case mod = "MOD"
        case ndds = "NDDS"
        case pip = "PIP"
        case pn = "PN"
        case sd = "SD"
        case slt = "SLT"
        case sTs = "STs"
        case uqID = "UQId"
        case us = "US"
        case ver = "Ver"
    }

    init(at: String?, cul: String?, culCon: String?, culConID: Int?, dID: Int?, dName: String?, eMS: [Em]?, em: String?, lgt: String?, lID: Int?, os: String?, pwd: String?, sID: Int?, sku: String?, uID: Int?, un: String?, cID: Int?, com: String?, dn: String?, dos: String?, ea: String?, ec: String?, emailAddress: String?, fn: String?, gcmuqID: String?, isCon: Bool?, isLT: Bool?, isPU: Bool?, isSuc: Bool?, isSync: Bool?, isTri: Bool?, lld: String?, ln: String?, mod: String?, ndds: String?, pip: String?, pn: String?, sd: String?, slt: String?, sTs: String?, uqID: String?, us: Int?, ver: String?) {
        self.at = at
        self.cul = cul
        self.culCon = culCon
        self.culConID = culConID
        self.dID = dID
        self.dName = dName
        self.eMS = eMS
        self.em = em
        self.lgt = lgt
        self.lID = lID
        self.os = os
        self.pwd = pwd
        self.sID = sID
        self.sku = sku
        self.uID = uID
        self.un = un
        self.cID = cID
        self.com = com
        self.dn = dn
        self.dos = dos
        self.ea = ea
        self.ec = ec
        self.emailAddress = emailAddress
        self.fn = fn
        self.gcmuqID = gcmuqID
        self.isCon = isCon
        self.isLT = isLT
        self.isPU = isPU
        self.isSuc = isSuc
        self.isSync = isSync
        self.isTri = isTri
        self.lld = ""
        self.ln = ln
        self.mod = mod
        self.ndds = ndds
        self.pip = pip
        self.pn = pn
        self.sd = sd
        self.slt = slt
        self.sTs = sTs
        self.uqID = uqID
        self.us = us
        self.ver = ver
    }
}

// MARK: - Em
class Em: Codable {
    var ec, lm: String?
    var sCS: Int?
    var sm: String?

    enum CodingKeys: String, CodingKey {
        case ec = "EC"
        case lm = "LM"
        case sCS = "SCs"
        case sm = "SM"
    }

    init(ec: String?, lm: String?, sCS: Int?, sm: String?) {
        self.ec = ec
        self.lm = lm
        self.sCS = sCS
        self.sm = sm
    }
}
