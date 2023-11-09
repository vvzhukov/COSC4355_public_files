//
//  SyncService.swift
//  exc_week12
//
//  Created by Vitalii Zhukov on 11/9/23.
//

import Foundation
import WatchConnectivity

class SyncService : NSObject, WCSessionDelegate {
    private var session: WCSession = .default
    var dataReceived: ((String, Any) -> Void)?
    
    init(session: WCSession = .default) {
        self.session = session

        super.init()

        self.session.delegate = self
        self.connect()
    }
    
    func connect(){
        guard WCSession.isSupported() else {
            print("WCSession is not supported")
            return
        }
        
        session.activate()
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) { }

    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) { }

    func sessionDidDeactivate(_ session: WCSession) { }
    #endif

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        guard dataReceived != nil else {
            print("Received data, but 'dataReceived' handler is not provided")
            return
        }
        
        DispatchQueue.main.async {
            if let dataReceived = self.dataReceived {
                for pair in message {
                    dataReceived(pair.key, pair.value)
                }
            }
        }
    }

    func sendMessage(_ key: String, _ message: String, _ errorHandler: ((Error) -> Void)?) {
        if session.isReachable {
            session.sendMessage([key : message], replyHandler: nil) { (error) in
                print(error.localizedDescription)
                if let errorHandler = errorHandler {
                    errorHandler(error)
                }
            }
        }
    }
}
