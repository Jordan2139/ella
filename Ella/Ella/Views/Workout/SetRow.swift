import SwiftUI

struct SetRow: View {
    @Binding var set: LiftSet

    @State private var weightText = ""
    @State private var repsText = ""

    var body: some View {
        HStack(spacing: 14) {
            Button {
                set.isCompleted.toggle()
            } label: {
                Image(systemName: set.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(set.isCompleted ? .green : .secondary)
            }

            Spacer()

            numberControl(
                value: $set.weight,
                step: 2.5,
                text: $weightText,
                formatter: { String(format: "%.1f", $0) },
                unit: "lb"
            )

            intControl(
                value: $set.reps,
                step: 1,
                text: $repsText,
                unit: "reps"
            )
        }
        .padding(.vertical, 6)
        .onAppear(perform: syncText)
        .onChange(of: set.weight) { syncText() }
        .onChange(of: set.reps) { syncText() }
    }

    // MARK: - Weight

    private func numberControl(
        value: Binding<Double>,
        step: Double,
        text: Binding<String>,
        formatter: @escaping (Double) -> String,
        unit: String
    ) -> some View {
        HStack(spacing: 6) {
            Button {
                value.wrappedValue = max(0, value.wrappedValue - step)
                text.wrappedValue = formatter(value.wrappedValue)
            } label: {
                Image(systemName: "minus.circle")
            }
            .buttonStyle(.borderless)

            TextField("", text: text)
                .keyboardType(.decimalPad)
                .frame(width: 52)
                .multilineTextAlignment(.trailing)
                .onSubmit {
                    value.wrappedValue = Double(text.wrappedValue) ?? value.wrappedValue
                    text.wrappedValue = formatter(value.wrappedValue)
                }

            Button {
                value.wrappedValue += step
                text.wrappedValue = formatter(value.wrappedValue)
            } label: {
                Image(systemName: "plus.circle")
            }
            .buttonStyle(.borderless)

            Text(unit)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    // MARK: - Reps

    private func intControl(
        value: Binding<Int>,
        step: Int,
        text: Binding<String>,
        unit: String
    ) -> some View {
        HStack(spacing: 6) {
            Button {
                value.wrappedValue = max(0, value.wrappedValue - step)
                text.wrappedValue = "\(value.wrappedValue)"
            } label: {
                Image(systemName: "minus.circle")
            }
            .buttonStyle(.borderless)

            TextField("", text: text)
                .keyboardType(.numberPad)
                .frame(width: 40)
                .multilineTextAlignment(.trailing)
                .onSubmit {
                    value.wrappedValue = Int(text.wrappedValue) ?? value.wrappedValue
                    text.wrappedValue = "\(value.wrappedValue)"
                }

            Button {
                value.wrappedValue += step        // ✅ reps increment by 1
                text.wrappedValue = "\(value.wrappedValue)"
            } label: {
                Image(systemName: "plus.circle")
            }
            .buttonStyle(.borderless)

            Text(unit)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    private func syncText() {
        weightText = String(format: "%.1f", set.weight)
        repsText = "\(set.reps)"
    }
}
