//
//  AddEditTaskView.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import SwiftUI

struct AddEditTaskView: View {
    @StateObject private var viewModel: AddEditTaskViewModel
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isTitleFocused: Bool

    init(viewModel: @autoclosure @escaping () -> AddEditTaskViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel())
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Title") {
                    TextField("What needs to be done?", text: $viewModel.title)
                        .focused($isTitleFocused)
                }

                Section("Notes") {
                    TextField("Optional notes", text: $viewModel.notes, axis: .vertical)
                        .lineLimit(3...6)
                }

                Section("Priority") {
                    Picker("Priority", selection: $viewModel.priority) {
                        ForEach(TaskPriority.allCases) { priority in
                            Text(priority.title).tag(priority)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section("Due date") {
                    Toggle("Set due date", isOn: $viewModel.hasDueDate.animation())
                    if viewModel.hasDueDate {
                        DatePicker("Date", selection: $viewModel.dueDate, displayedComponents: .date)
                    }
                }
            }
            .navigationTitle(viewModel.screenTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if viewModel.save() { dismiss() }
                    }
                    .disabled(!viewModel.isValid)
                }
            }
            .errorAlert(message: $viewModel.errorMessage)
            .onAppear { isTitleFocused = true }
        }
    }
}
