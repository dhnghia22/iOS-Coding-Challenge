//
//  AuthStoreTest.swift
//  iOS Coding Challenge Tests
//
//  Created by Nghia Dinh on 05/08/2023.
//

import XCTest
@testable import iOS_Coding_Challenge__Dev_

class AuthMockSuccessRepository: AuthRepositoryProtocol {
    func login(userName: String) async throws -> iOS_Coding_Challenge__Dev_.Account {
        return Account(userName: userName, userKey: "1", noteIds: [])
    }
    
    func signUp(userName: String) async throws -> iOS_Coding_Challenge__Dev_.Account {
        return Account(userName: userName, userKey: "1", noteIds: [])
    }
}

class AuthMockLoginFailRepository: AuthRepositoryProtocol {
    func login(userName: String) async throws -> iOS_Coding_Challenge__Dev_.Account {
        throw FirebaseError.userInvalid
    }
    
    func signUp(userName: String) async throws -> iOS_Coding_Challenge__Dev_.Account {
        return Account(userName: "signUp", userKey: "1", noteIds: [])
    }
}

class AuthMockErorRepository: AuthRepositoryProtocol {
    func login(userName: String) async throws -> iOS_Coding_Challenge__Dev_.Account {
        throw FirebaseError.getValueFailed
    }
    
    func signUp(userName: String) async throws -> iOS_Coding_Challenge__Dev_.Account {
        throw FirebaseError.getValueFailed
    }
}


final class AuthStoreTest: XCTestCase {
    
    var successStore: AuthStore!
    var failStore: AuthStore!
    var errStore: AuthStore!
    
    override func setUp() {
        super.setUp()
        successStore = AuthStore(repository:  AuthMockSuccessRepository())
        failStore = AuthStore(repository: AuthMockLoginFailRepository())
        errStore = AuthStore(repository: AuthMockErorRepository())
    }
    
    override func tearDown() {
        super.tearDown()
        successStore = nil
        failStore = nil
        errStore = nil
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor func testLoginSuccess() throws {
        do {
            let name = "abc"
            successStore.login(with: name)
            let publisher = successStore.$account.collect(2).first()
            let items = try awaitPublisher(publisher)
            XCTAssertEqual(items.count, 2)
            XCTAssertEqual(items[1]?.userName, name)
        } catch {
            XCTAssertThrowsError("testCreateNoteSuccess failed")
        }

    }
    
    @MainActor func testLoginFailAndRegisterSuccess() throws {
        do {
            let name = "abc"
            failStore.login(with: name)
            let publisher = failStore.$account.collect(2).first()
            let items = try awaitPublisher(publisher)
            XCTAssertEqual(items.count, 2)
            XCTAssertEqual(items[1]?.userName, "signUp")
        } catch {
            XCTAssertThrowsError("testCreateNoteSuccess failed")
        }
    }
    
    
    @MainActor func testAllError() throws {
        do {
            let name = "abc"
            errStore.login(with: name)
            let publisher = errStore.$errorString.collect(2).first()
            let items = try awaitPublisher(publisher)
            XCTAssertEqual(items.count, 2)
            XCTAssertEqual(items[1], "The operation couldn’t be completed. (iOS_Coding_Challenge__Dev_.FirebaseError error 1.)")
            
            errStore.register(with: name)
            let publisher2 = errStore.$errorString.collect(2).first()
            let items2 = try awaitPublisher(publisher2)
            XCTAssertEqual(items2.count, 2)
            XCTAssertEqual(items2[1], "The operation couldn’t be completed. (iOS_Coding_Challenge__Dev_.FirebaseError error 1.)")
            
        } catch {
            XCTAssertThrowsError("testCreateNoteSuccess failed")
        }
    }

}
