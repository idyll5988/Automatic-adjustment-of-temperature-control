# Automatic-adjustment-of-temperature-control

循环检测电池温度并根据电池温度值自动调整设置 关屏不执行

Cyclically detects the battery temperature and automatically adjusts the settings according to the battery temperature value Screen off is not executed

当电池温度低于30°C时，关闭自适应省电模式，开启固定性能模式.

当电池温度在30°C到31°C之间时，同样关闭自适应省电模式，开启固定性能模式.

当电池温度在32°C到33°C之间时，开启自适应省电模式，同时开启固定性能模式.

当电池温度在34°C到35°C之间时，开启自适应省电模式，但固定性能模式保持开启.

当电池温度在36°C到37°C之间时，自适应省电模式保持开启，但关闭固定性能模式.

当电池温度在38°C到39°C之间时，自适应省电模式保持开启，固定性能模式关闭.

当电池温度高于或等于40°C时，重置所有电源管理设置.

When the battery temperature is below 30°C, the adaptive power saving mode is turned off and the fixed performance mode is turned on.

When the battery temperature is between 30°C and 31°C, also turn off the adaptive power saving mode and turn on the fixed performance mode.

When the battery temperature is between 32°C and 33°C, the adaptive power saving mode is turned on and the fixed performance mode is turned on.

When the battery temperature is between 34°C and 35°C, adaptive power saving mode is turned on, but fixed performance mode remains on.

When the battery temperature is between 36°C and 37°C, the Adaptive Power Save Mode stays on but the Fixed Performance Mode is turned off.

When the battery temperature is between 38°C and 39°C, the Adaptive Power Saving Mode remains on and the Fixed Performance Mode is turned off.

Resets all power management settings when the battery temperature is above or equal to 40°C.
