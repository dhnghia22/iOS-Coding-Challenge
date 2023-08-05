//
//  FirebaseService.swift
//  iOS Coding Challenge
//
//  Created by Nghia Dinh on 03/08/2023.
//

import Foundation
import Firebase

class FirebaseNoteService {
    static func getAllNotes(limit: UInt) async throws -> [Note] {
        let noteRef = Database.database().reference().child(Constant.DatabasePath.notes)
        let query = noteRef.queryOrdered(byChild: Constant.DatabaseProps.negativeTimestamp).queryLimited(toFirst: limit)
        let value = try await FirebaseService.makeQueryMapToArray(from: query) as? [[String: Any]] ?? []
        return value.decodeArray(as: Note.self).sorted {$0.timestamp ?? 0 > $1.timestamp ?? 0}
    }
    
    
    static func loadMoreAllNote(limit: UInt, value: Double) async throws -> [Note] {
        let noteRef = Database.database().reference().child(Constant.DatabasePath.notes)
        let query = noteRef.queryOrdered(byChild: Constant.DatabaseProps.negativeTimestamp).queryStarting(afterValue: value).queryLimited(toFirst: limit)
        let value = try await FirebaseService.makeQueryMapToArray(from: query) as? [[String: Any]] ?? []
        return value.decodeArray(as: Note.self).sorted {$0.timestamp ?? 0 > $1.timestamp ?? 0}
    }
    
    static func getNoteFrom(account acc: Account) async throws -> [Note] {
        let noteRef = Database.database().reference().child(Constant.DatabasePath.notes)
        let query = noteRef.queryOrdered(byChild:  Constant.DatabaseProps.ownerId).queryEqual(toValue: acc.userKey)
        let value = try await FirebaseService.makeQueryMapToArray(from: query) as? [[String: Any]] ?? []
        return value.decodeArray(as: Note.self).sorted {$0.timestamp ?? 0 > $1.timestamp ?? 0}
    }
    
//    static func loadMoreNoteFrom(account acc: Account, limit: UInt, value: Double) async throws -> [Note] {
//        let noteRef = Database.database().reference().child("notes")
//        let query = noteRef.queryOrdered(byChild: "owner_id").queryEqual(toValue: acc.userKey).queryLimited(toLast: limit)
//        let value = try await FirebaseService.makeQueryMapToArray(from: query) as? [[String: Any]] ?? []
//        return value.decodeArray(as: Note.self).sorted {$0.timestamp ?? 0 > $1.timestamp ?? 0}
//    }
    
    static func write(from note: String, account: Account) async throws -> Note {
        let userRef = Database.database().reference().child(Constant.DatabasePath.user).child(account.userKey).child(Constant.DatabasePath.notes).childByAutoId()
        let date = Date()
        let noteContent = Note(id: userRef.key ?? "", content: note, createDate: Date(), createBy: account.userName, timestamp: date.timeIntervalSince1970, ownerId: account.userKey)
        let noteRef = Database.database().reference().child(Constant.DatabasePath.notes).childByAutoId()
        _ = try await FirebaseService.setValue(ref: noteRef, value: noteContent.toDictionary())
        if let key = noteRef.key {
            _ = try await FirebaseService.setValue(ref: userRef, value: key)
        }
        return noteContent
    }
    
    static func update(from note: Note, newNote: String) async throws -> Note {
        let newItem = Note(id: note.id, content: newNote, createDate: note.createDate, createBy: note.createBy, timestamp: note.timestamp, ownerId: note.ownerId)
        let noteRef = Database.database().reference().child(Constant.DatabasePath.notes).child(newItem.id ?? "")
        _ = try await FirebaseService.setValue(ref: noteRef, value: newItem.toDictionary())
        return newItem
    }
}


class FirebaseAuthService {
    static func signUp(with userName: String) async throws -> Account {
        let dbRef = Database.database().reference()
        let newUserRef = dbRef.child(Constant.DatabasePath.user).childByAutoId()
        let user = [
            Constant.DatabaseProps.userName: userName,
        ]
        let ref = try await FirebaseService.setValue(ref: newUserRef, value: user)
        return Account(userName: userName, userKey: ref.key ?? "", noteIds: [])
    }
    
    
    static func login(with userName: String) async throws -> Account {
        let user = Database.database().reference().child(Constant.DatabasePath.user)
        let query = user.queryOrdered(byChild: Constant.DatabaseProps.userName).queryEqual(toValue: userName)
        do {
            let res = try await FirebaseService.makeQuery(from: query)
            print(res)
            if let dic = res as? [String: Any] {
                return Account(from: dic)
            } else {
                throw FirebaseError.getValueFailed
            }
        } catch {
            throw FirebaseError.userInvalid
        }
    }
    
}

class FirebaseService {
    static func setValue(ref: DatabaseReference, value: Any) async throws -> DatabaseReference {
        OperationQueue.checkMainThread()
        return try await withCheckedThrowingContinuation({ r in
            ref.setValue(value) { error, value in
                if let error = error {
                    r.resume(throwing: error)
                } else {
                    r.resume(returning: value)
                }
            }
        })
    }
    

    
    static func makeQuery(from query: DatabaseQuery) async throws -> Any {
        OperationQueue.checkMainThread()
        return try await withCheckedThrowingContinuation({ r  in
            query.observeSingleEvent(of: .value, with: { snap in
                if let usersDict = snap.value as? [String: Any] {
                    query.removeAllObservers()
                    r.resume(returning: usersDict)
                    return
                }
                query.removeAllObservers()
                r.resume(returning: FirebaseError.getValueFailed)
            }) { err in
                query.removeAllObservers()
                r.resume(throwing: err)
            }
            
        })
    }
    
    
    static func makeQueryMapToArray(from query: DatabaseQuery) async throws -> Any {
        OperationQueue.checkMainThread()
        return try await withCheckedThrowingContinuation({ r  in
            query.observeSingleEvent(of: .value, with: { snap in
                if let usersDict = snap.value as? [String: Any] {
                    let items = usersDict.map { (key: String, value: Any) in
                        var dic = value as? [String: Any] ?? [:]
                        dic["key"] = key
                        return dic
                    }
                    query.removeAllObservers()
                    r.resume(returning: items)
                    return
                    
                }
                query.removeAllObservers()
                r.resume(returning: [])
            }) { err in
                query.removeAllObservers()
                r.resume(throwing: err)
            }
            
        })
    }
}

