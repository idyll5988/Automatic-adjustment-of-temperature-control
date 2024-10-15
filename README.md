# Automatic-adjustment-of-temperature-control

循环检测电池温度并根据电池温度值自动调整设置 关屏不执行

Cyclically detects the battery temperature and automatically adjusts the settings according to the battery temperature value Screen off is not executed

1. **检查屏幕状态**：使用`dumpsys window`命令检查设备是否亮屏。
2. **获取电池温度**：调用`get_battery_temperature`函数获取当前的电池温度。
3. **根据温度调整热状态和电源管理参数**：
   - 如果电池温度较低（0-29°C或30°C），则将热状态设置为`THERMAL_STATUS_NONE`（无限制），并启用固定性能模式，禁用自适应省电模式。
   - 如果电池温度在31-34°C之间，热状态保持为`THERMAL_STATUS_NONE`，启用自适应省电模式和固定性能模式。
   - 如果电池温度在35-38°C之间，热状态保持为`THERMAL_STATUS_NONE`，自适应省电模式和固定性能模式根据温度进一步调整。
   - 如果电池温度更高，逐步提高热状态级别，并相应地调整电源管理参数。
4. **暗屏状态**：如果设备处于暗屏状态，脚本将启用自适应省电模式，禁用固定性能模式，并设置电源模式为1。

1. **Check screen status**: Use the `dumpsys window` command to check if the device is lit.
2. **Get battery temperature**: Call the `get_battery_temperature` function to get the current battery temperature.
3. **Adjust thermal state and power management parameters based on temperature**:
   - If the battery temperature is low (0-29°C or 30°C), set the thermal state to `THERMAL_STATUS_NONE` (unlimited) and enable fixed performance mode and disable adaptive power saving mode.
   - If the battery temperature is between 31-34°C, keep the thermal state to `THERMAL_STATUS_NONE` and enable Adaptive Power Save Mode and Fixed Performance Mode.
   - If the battery temperature is between 35-38°C, the thermal state remains as `THERMAL_STATUS_NONE` and the adaptive power saving mode and fixed performance mode are further adjusted according to the temperature.
   - If the battery temperature is higher, gradually increase the thermal state level and adjust the power management parameters accordingly.
4. **DARK SCREEN STATUS**: If the device is in a dark screen state, the script will enable Adaptive Power Save Mode, disable Fixed Performance Mode, and set Power Mode to 1.
