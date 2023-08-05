//
//  FirebaseDBTest.swift
//  iOS Coding Challenge Tests
//
//  Created by Nghia Dinh on 04/08/2023.
//

import XCTest
@testable import iOS_Coding_Challenge__Dev_
import FirebaseCore

final class FirebaseDBTest: XCTestCase {
    
    let accountTest1 = Account(userName: "nghia.dinh.test", userKey: "-Naz-4DfH4sh1CsUqGSL", noteIds: [])
    let accountTest2 = Account(userName: "nghia.dinh.2", userKey: "-Nb-H7er5Ph1xL7gg7HF", noteIds: [])
    let writeNoteAcc = Account(userName: "test.write.note", userKey: "-Nb2sM4uTlbQE2XWGCWV", noteIds: [])
    
    let noteRepository = NoteFirebaseReposiory()
    let authRepository = AuthFireBaseRepository()
    
    override class func setUp() {
        super.setUp()
        FirebaseApp.configure()
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testLoginSuccess() {
        let expectation = expectation(description: "testLoginSuccess")
        Task {
            do {
                let userName = "nghia.dinh.test"
                let account = try await authRepository.login(userName: userName)
                XCTAssertNotNil(account)
                XCTAssertEqual(account.userName, userName)
                XCTAssertEqual(account.userKey, "-Naz-4DfH4sh1CsUqGSL")
                expectation.fulfill()
            } catch {
                XCTFail("Unexpected result: \(error.localizedDescription)")
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 10.0)
    }
    
    
    func testLoginFailed() {
        let expectation = expectation(description: "testLoginFailed")
        Task {
            do {
                let _ = try await authRepository.login(userName: UUID().uuidString)
                XCTAssertThrowsError("testLoginFailed Eror")
                expectation.fulfill()
            } catch {
                XCTAssertNotNil(error)
                if case FirebaseError.userInvalid = error {
                    expectation.fulfill()
                } else {
                    XCTFail("Unexpected result: onError")
                    expectation.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 10.0)
    }
    
    func testRegister() {
        let expectation = expectation(description: "testRegister")
        Task {
            do {
                let userName = "unit.test\(UUID().uuidString)"
                let account = try await authRepository.signUp(userName: userName)
                XCTAssertNotNil(account)
                XCTAssertEqual(account.userName, userName)
                expectation.fulfill()
            } catch {
                XCTAssertThrowsError("Register account Failed")
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 10.0)
    }
    
    func testWriteNote() {
        let expectation = expectation(description: "testWriteNote")
        Task {
            do {
                let note = "Note \(Date().timeIntervalSince1970): Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"
                _ = try await noteRepository.createNote(from: writeNoteAcc, note: note)
                expectation.fulfill()
            } catch {
                XCTAssertThrowsError("Register account Failed")
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 10.0)
    }
    
    func testGetAllNotes() {
        let expectation = expectation(description: "testGetAllNotes")
        Task {
            do {
                let notes = try await noteRepository.fecthAllNotes(pageSize: 5)
                XCTAssertEqual(notes.count, 5)
                let timestamp = notes.last?.timestamp ?? 0
                let mores = try await noteRepository.loadmoreAllNotes(pageSize: 5, timestamp: -timestamp)
                XCTAssertEqual(mores.count, 5)
                XCTAssertTrue(notes[0].timestamp ?? 0 > mores[0].timestamp ?? 0)
                expectation.fulfill()
            } catch {
                XCTAssertThrowsError("testGetAllNotes Failed \(error.localizedDescription)")
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 10.0)
    }
    
    
    func testUpdateNote() {
        let expectation = expectation(description: "testUpdateNote")
        Task {
            do {
                let curNote = Note(id: "-Nb-HNj1pNNEPMDytBp2", content: "Note 5: Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum", createDate: Date.fromString("2023-08-04T18:23:12", format: "yyyy-MM-dd'T'HH:mm:ss"), createBy: "nghia.dinh.2", timestamp: 1691148192.678082, ownerId: "nghia.dinh.2")
                let newString = UUID().uuidString
                let notes = try await noteRepository.updateNote(currentNote: curNote, note: newString)
                XCTAssertEqual(notes.content ?? "", newString)
                expectation.fulfill()
            } catch {
                XCTAssertThrowsError("testGetAllNotes Failed \(error.localizedDescription)")
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 10.0)
    }
    
    
    func testGetMyNote() {
        let expectation = expectation(description: "testGetMyNote")
        Task {
            do {
                let notes = try await noteRepository.fetchMyNotes(account: accountTest2)
                XCTAssertEqual(notes.count, 6)
                expectation.fulfill()
            } catch {
                XCTAssertThrowsError("testGetAllNotes Failed \(error.localizedDescription)")
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 10.0)
    }
    

}
