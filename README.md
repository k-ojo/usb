# USB 1.1 Physical Layer (PHY) Implementation

A complete Verilog implementation of the USB 1.1 Physical Layer, providing standards-compliant signaling and data transmission capabilities for USB device controllers.

## Overview

This project implements the physical layer (PHY) of the USB 1.1 specification in Verilog HDL. The PHY handles low-level signaling protocols, differential data encoding/decoding, and physical interface management, enabling reliable communication between USB devices and hosts at speeds up to 12 Mbps (Full Speed).

## Features

### Core PHY Functionality
- **Differential Signaling**: Implementation of USB's differential pair signaling (D+ and D-)
- **NRZI Encoding/Decoding**: Non-Return-to-Zero Inverted encoding for data transmission
- **Bit Stuffing**: Automatic insertion and removal of stuff bits for clock recovery
- **Speed Detection**: Support for Low Speed (1.5 Mbps) and Full Speed (12 Mbps) operation
- **Line State Management**: Detection and generation of USB line states (J, K, SE0, SE1)

### Signal Processing
- **Clock Recovery**: Robust clock extraction from incoming data streams
- **Edge Detection**: Precise timing for data sampling and transmission
- **Synchronization**: SOP (Start of Packet) and EOP (End of Packet) detection/generation
- **Jitter Tolerance**: Compliant with USB 1.1 timing specifications

### Interface Compatibility
- **UTMI-like Interface**: Clean separation between PHY and upper protocol layers
- **Configurable Parameters**: Adjustable timing and operational parameters
- **Reset Handling**: Proper initialization and reset sequence management

## Architecture

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   USB Device    │◄──►│   Higher Layer   │◄──►│   Host/Hub      │
│   Controller    │    │   (MAC/SIE)      │    │                 │
└─────────────────┘    └──────────────────┘    └─────────────────┘
                                │
                                ▼
┌─────────────────────────────────────────────────────────────────┐
│                        USB 1.1 PHY                             │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────────┐ │
│  │   NRZI      │  │    Bit      │  │    Differential         │ │
│  │ Encoder/    │  │  Stuffing   │  │     Signaling           │ │
│  │  Decoder    │  │             │  │                         │ │
│  └─────────────┘  └─────────────┘  └─────────────────────────┘ │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────────┐ │
│  │   Clock     │  │    Line     │  │      SOP/EOP            │ │
│  │  Recovery   │  │    State    │  │     Detection           │ │
│  │             │  │  Detection  │  │                         │ │
│  └─────────────┘  └─────────────┘  └─────────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
                                │
                                ▼
                    ┌───────────────────────┐
                    │    USB Connector      │
                    │    (D+, D-, VCC, GND) │
                    └───────────────────────┘
```
### Timing Specifications

| Parameter | Low Speed | Full Speed | Unit |
|-----------|-----------|------------|------|
| Data Rate | 1.5 | 12 | Mbps |
| Clock Tolerance | ±1.5% | ±0.25% | % |
| Rise/Fall Time | 75-300 | 4-20 | ns |
| Crossover Voltage | 1.3-2.0 | 1.3-2.0 | V |

## Getting Started

### Prerequisites

- **Verilog Simulator**: ModelSim, VCS, or Icarus Verilog
- **FPGA Tools** (optional): Vivado, Quartus Prime for hardware implementation
- **USB Analyzer** (recommended): For hardware validation

### Quick Start

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/usb11-phy.git
   cd usb11-phy
   ```

2. **Run basic simulation**:
   ```bash
   # Using ModelSim
   vlog src/*.v tb/*.v
   vsim tb_usb_phy
   run -all
   
   # Using Icarus Verilog
   iverilog -o sim src/*.v tb/tb_usb_phy.v
   ./sim
   ```

3. **View waveforms**:
   ```bash
   gtkwave tb_usb_phy.vcd
   ```

### Testing

The project includes comprehensive test suites:

- **Unit Tests**: Individual module verification
- **Integration Tests**: Full PHY datapath testing
- **Compliance Tests**: USB 1.1 specification compliance verification
- **Stress Tests**: Jitter tolerance and edge case handling

Run all tests:
```bash
make test
```

## Known Limitations

- **Single Port**: Currently supports single USB port (no hub functionality)
- **Device Only**: Optimized for USB device implementation (not host)
- **No Power Management**: USB suspend/resume states not implemented
- **Fixed Timing**: Requires external 48 MHz clock (no internal PLL)

## Future Enhancements

- [ ] USB 2.0 High Speed support (480 Mbps)
- [ ] Integrated USB host capability
- [ ] Power management and suspend/resume
- [ ] Built-in PLL for clock generation
- [ ] Multi-port hub support

## Documentation

- **[Design Specification](docs/design_spec.md)**: Detailed design documentation
- **[User Guide](docs/user_guide.md)**: Integration and usage instructions  
- **[Test Plan](docs/test_plan.md)**: Verification methodology and results
- **[Timing Analysis](docs/timing_analysis.md)**: Clock domain and timing constraints

## Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## References

- [USB 1.1 Specification](https://www.usb.org/document-library/usb-11-specification)
- [USB Physical Layer Guidelines](https://www.usb.org/document-library/usb-physical-layer-guidelines)
- [UTMI Specification](https://www.usb.org/document-library/usb-20-transceiver-macrocell-interface-utmi-specification)

## Contact

**Project Maintainer**: Your Name  
**Email**: your.email@university.edu  
**LinkedIn**: [yourprofile](https://linkedin.com/in/yourprofile)

---

*This project was developed as part of advanced digital design coursework, focusing on USB protocol implementation and FPGA-based system design.*

