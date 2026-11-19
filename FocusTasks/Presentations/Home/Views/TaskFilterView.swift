//
//  TaskFilterView.swift
//  FocusTasks
//
//  Created by Esraa Abuseada on 18/11/2026.
//

import SwiftUI

struct TaskFilterView: View {
    @Binding var selection: TaskFilter

    var body: some View {
        Picker("Filter", selection: $selection) {
            ForEach(TaskFilter.allCases) { filter in
                Text(filter.title).tag(filter)
            }
        }
        .pickerStyle(.segmented)
    }
}
