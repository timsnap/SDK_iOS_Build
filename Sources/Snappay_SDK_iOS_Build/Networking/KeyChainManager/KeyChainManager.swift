//
//  KeyChainManager.swift
//
//  Created by Timothy Obeisun on 11/18/22.
//

import Foundation

class KeyChainManager {
    enum KeyChainError: Error {
        case duplicateEntry
        case unknown(OSStatus)
    }
    
    static func save(service: String,
                     account: String,
                     token: Data) throws {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecValueData as String: token as AnyObject
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status != errSecDuplicateItem else {
            throw KeyChainError.duplicateEntry
        }
        
        guard status == errSecSuccess else {
            throw KeyChainError.unknown(status)
        }
    }
    
    static func get(service: String,
                    account: String) -> Data? {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        _ = SecItemCopyMatching(query as CFDictionary,
                                &result)
        return result as? Data
    }
    
    static func removeFromKeyChain(
        service: String,
        account:String
    ) {
        // Instantiate a new default keychain query
        
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject
        ]
        
        // Delete any existing items
        let status = SecItemDelete(query as CFDictionary)
        if (status != errSecSuccess) {
            if #available(iOS 11.3, *) {
                if let err = SecCopyErrorMessageString(status, nil) {
                    print("Remove failed: \(err)")
                }
            } else {
                // Fallback on earlier versions
            }
        }
        
    }
}
