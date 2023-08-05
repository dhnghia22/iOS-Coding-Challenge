//
//  CreateNoteStoreTest.swift
//  iOS Coding Challenge Tests
//
//  Created by Nghia Dinh on 05/08/2023.
//

import XCTest
import Combine
@testable import iOS_Coding_Challenge__Dev_


class MockNotesRepository: NotesRepositoryProtocol {
    func fecthAllNotes(pageSize: UInt) async throws -> [iOS_Coding_Challenge__Dev_.Note] {
        return []
    }
    
    func loadmoreAllNotes(pageSize: UInt, timestamp: Double) async throws -> [iOS_Coding_Challenge__Dev_.Note] {
        return []
    }
    
    func fetchMyNotes(account: iOS_Coding_Challenge__Dev_.Account) async throws -> [iOS_Coding_Challenge__Dev_.Note] {
        return []
    }
    
    var notes: [Note] = []
    
    func createNote(from account: Account, note: String) async throws -> Note {
        let newNote = Note(id: "", content: note, createDate: nil, createBy: nil, timestamp: nil, ownerId: nil)
        notes.append(newNote)
        return newNote
    }
    
    func updateNote(currentNote: Note, note: String) async throws -> Note {
        return Note(id: currentNote.id, content: note, createDate: currentNote.createDate, createBy: currentNote.createBy, timestamp: nil, ownerId: currentNote.ownerId)
    }
}


final class CreateNoteStoreTest: XCTestCase {
    var store: CreateNoteStore!
    var account: Account!
    override func setUp() {
        super.setUp()
        let mockRepository = MockNotesRepository()
        store = CreateNoteStore(repository: mockRepository)
        account = Account(userName: "nghia.dinh.test", userKey: "-Naz-4DfH4sh1CsUqGSL", noteIds: [])
    }
    
    override func tearDown() {
        super.tearDown()
        store = nil
        account = nil
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    @MainActor func testCreateNoteSuccess() throws {
        do {
            let noteContent = "This is a new note"
            
            store.createNote(from: account, note: noteContent)
            
            let publisher = store.$updateNoteState.collect(2).first()
            let items = try awaitPublisher(publisher)
            
            XCTAssertEqual(items.count, 2)
            if case DataState.success(let data) = items[1] {
                XCTAssertEqual(data.content, noteContent)
            } else {
                XCTAssertThrowsError("testCreateNoteSuccess failed")
            }
        } catch {
            XCTAssertThrowsError("testCreateNoteSuccess failed")
        }
    }
    
    @MainActor func testCreateNoteFailure() {
        do {
            let noteContent = ""
            store.createNote(from: account, note: noteContent)
            let publisher = store.$updateNoteState.collect(2).first()
            let items = try awaitPublisher(publisher)
            
            XCTAssertEqual(items.count, 2)
            if case DataState.failed(let err) = items[1] {
                XCTAssertEqual(err, "Please input note")
            } else {
                XCTAssertThrowsError("testCreateNoteFailure failed")
            }
        } catch {
            XCTAssertThrowsError("testCreateNoteFailure failed")
        }
    }
    //
    @MainActor func testUpdateNoteSuccess() {
        do {
            let curNote = Note(id: "-Nb-HNj1pNNEPMDytBp2", content: "Note 5: Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum", createDate: Date.fromString("2023-08-04T18:23:12", format: "yyyy-MM-dd'T'HH:mm:ss"), createBy: "nghia.dinh.2", timestamp: 1691148192.678082, ownerId: "nghia.dinh.2")
            let newNote = "Updated note content"
            
            store.updateNote(curentNote: curNote, newNoteString: newNote)
            
            let publisher = store.$updateNoteState.collect(2).first()
            let items = try awaitPublisher(publisher)
            
            XCTAssertEqual(items.count, 2)
            if case DataState.success(let data) = items[1] {
                XCTAssertEqual(data.content, newNote)
            } else {
                XCTAssertThrowsError("testUpdateNoteSuccess failed")
            }
        } catch {
            XCTAssertThrowsError("testUpdateNoteSuccess failed")
        }
    }
    
    @MainActor func testUpdateNoteFailure() {
        do {
            let curNote = Note(id: "-Nb-HNj1pNNEPMDytBp2", content: "Note 5: Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum", createDate: Date.fromString("2023-08-04T18:23:12", format: "yyyy-MM-dd'T'HH:mm:ss"), createBy: "nghia.dinh.2", timestamp: 1691148192.678082, ownerId: "nghia.dinh.2")
            let newNote = ""
            
            store.updateNote(curentNote: curNote, newNoteString: newNote)
            
            let publisher = store.$updateNoteState.collect(2).first()
            let items = try awaitPublisher(publisher)
            
            XCTAssertEqual(items.count, 2)
            if case DataState.failed(let err) = items[1] {
                XCTAssertEqual(err, "Please input note")
            } else {
                XCTAssertThrowsError("testCreateNoteFailure failed")
            }
        } catch {
            XCTAssertThrowsError("testUpdateNoteSuccess failed")
        }
    }
}


