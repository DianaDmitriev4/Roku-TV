//
//  SelectDeviceViewModel.swift
//  Roku TV
//
//  Created by User on 24.03.2024.
//

import Foundation

protocol SelectDeviceViewModelProtocol {
    var devices: [SelectDeviceModel] { get set }
    var selectCell: IndexPath? { get set }
}

final class SelectDeviceViewModel: SelectDeviceViewModelProtocol {
    var devices: [SelectDeviceModel] = []
    var selectCell: IndexPath?
    
    init() {
        fillDevicesArray()
    }
    
    private func fillDevicesArray() {
        devices = [SelectDeviceModel(deviceName: "SONY KD"),
                   SelectDeviceModel(deviceName: "SONY KD"),
                   SelectDeviceModel(deviceName: "SONY KD")]
    }
}
