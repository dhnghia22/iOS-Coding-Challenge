//
//  NoteStoreTest.swift
//  iOS Coding Challenge Tests
//
//  Created by Nghia Dinh on 06/08/2023.
//

import XCTest
@testable import iOS_Coding_Challenge__Dev_

final class NoteStoreTest: XCTestCase {
    
    var noteStore: NoteStore!
    
    override func setUp() {
        super.setUp()
        noteStore = NoteStore(repository: MockNoteStoreRepository())
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    @MainActor func testFetchAllNote() throws {
        do {
            noteStore.fetchAllNotes()
            let publisher = noteStore.$allNoteState.collect(2).first()
            let items = try awaitPublisher(publisher)
            XCTAssertEqual(items.count, 2)
            if case DataState.success(let data) = items[1] {
                XCTAssertEqual(data.count, 20)
            } else {
                XCTAssertThrowsError("testFetchAllNote failed")
            }
        } catch {
            XCTAssertThrowsError("testCreateNoteSuccess failed")
        }
    }
    
    
    @MainActor func testLoadMore() throws {
        do {
            let publisher = noteStore.$allNoteState.collect(3).first()
            noteStore.fetchAllNotes()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
                self.noteStore.loadMoreNotes()
            }
            let items = try awaitPublisher(publisher)
            XCTAssertEqual(items.count, 3)
            if case DataState.success(let data) = items[2] {
                XCTAssertEqual(data.count, 21)
            } else {
                XCTAssertThrowsError("testLoadMore failed")
            }
        } catch {
            XCTAssertThrowsError("testLoadMore failed")
        }
    }
    
    @MainActor func testFetchMyNotes() throws {
        do {
            noteStore.fetchAllMyNote(from: Account(userName: "", userKey: "", noteIds: []))
            let publisher = noteStore.$myNoteState.collect(2).first()
            let items = try awaitPublisher(publisher)
            XCTAssertEqual(items.count, 2)
            if case DataState.success(let data) = items[1] {
                XCTAssertEqual(data.count, 1)
            } else {
                XCTAssertThrowsError("testFetchMyNotes failed")
            }
        } catch {
            XCTAssertThrowsError("testFetchMyNotes failed")
        }

    }

}

class MockNoteStoreRepository: NotesRepositoryProtocol {
    func fecthAllNotes(pageSize: UInt) async throws -> [iOS_Coding_Challenge__Dev_.Note] {
        var items: [Note] = []
        for i in 1...20 {
            items.append(Note(id: "\(i)", content: "\(i)", createDate: nil, createBy: nil, timestamp: 123456, ownerId: nil))
        }
        return items
    }
    
    func loadmoreAllNotes(pageSize: UInt, timestamp: Double) async throws -> [iOS_Coding_Challenge__Dev_.Note] {
        return [
            Note(id: "1", content: "1", createDate: nil, createBy: nil, timestamp: 123456, ownerId: nil)
        ]
    }
    
    func fetchMyNotes(account: iOS_Coding_Challenge__Dev_.Account) async throws -> [iOS_Coding_Challenge__Dev_.Note] {
        return [
            Note(id: "1", content: "1", createDate: nil, createBy: nil, timestamp: 123456, ownerId: nil)
        ]
    }
    
    func createNote(from account: Account, note: String) async throws -> Note {
        let newNote = Note(id: "", content: note, createDate: nil, createBy: nil, timestamp: nil, ownerId: nil)
        return newNote
    }
    
    func updateNote(currentNote: Note, note: String) async throws -> Note {
        return Note(id: currentNote.id, content: note, createDate: currentNote.createDate, createBy: currentNote.createBy, timestamp: nil, ownerId: currentNote.ownerId)
    }
}
