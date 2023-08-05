//
//  BaseObservableObject.swift
//  iOS Coding Challenge
//
//  Created by Nghia Dinh on 03/08/2023.
//

import Combine

class BaseObservableObject: ObservableObject {
    private var taskCancellables = Set<Task<Void, Never>>()

    deinit {
        cancelAllTasks()
    }

    func cancelAllTasks() {
        taskCancellables.removeAll()
    }

    func runTask(_ task: Task<Void, Never>) {
        taskCancellables.insert(task)
    }
}

