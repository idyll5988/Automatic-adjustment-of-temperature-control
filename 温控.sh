#!/system/bin/sh
THERMAL_STATUS_NONE=0
THERMAL_STATUS_LIGHT=1
THERMAL_STATUS_MODERATE=2
set_cmd() {
    su -c "cmd device_config put $1 $2 $3" > /dev/null 2>&1
}
set_thermal_status() {
    su -c "cmd thermalservice override-status $1" > /dev/null 2>&1
}
get_battery_temperature() {
    local temperature
    temperature=$(su -c "dumpsys battery | grep 'temperature' | awk -F ': ' '{print \$2}'")
    if [ $? -eq 0 ]; then
        temperature=$(echo "scale=1; $temperature / 10" | bc)
        echo $temperature
        return 0
    else
        echo "0"
        return 1
    fi
}
while true; do
    screen_status=$(dumpsys window | grep "mScreenOn" | grep true)
    if [[ "${screen_status}" ]]; then
        echo "$(date "+%Y年%m月%d日%H时%M分%S秒") *📲- 亮屏运行*"
        temperature=$(get_battery_temperature)
        if [ $? -eq 0 ]; then
            echo "$(date "+%Y年%m月%d日%H时%M分%S秒") *😊- 设备支持温控管理*"
            echo "$(date "+%Y年%m月%d日%H时%M分%S秒") *🔋- 电池温度:$temperature°C*"
            temperature_int=${temperature%.*}
            case $temperature_int in
                [0-2][0-9]|30) 
                    set_thermal_status $THERMAL_STATUS_NONE
                    set_cmd power set-adaptive-power-saver-enabled false
                    set_cmd power set-fixed-performance-mode-enabled true
                    ;;
                31|32|33|34)
                    set_thermal_status $THERMAL_STATUS_NONE
                    set_cmd power set-adaptive-power-saver-enabled true
                    set_cmd power set-fixed-performance-mode-enabled true
                    ;;
                35|36)
                    set_thermal_status $THERMAL_STATUS_NONE
                    set_cmd power set-adaptive-power-saver-enabled true
                    set_cmd power set-fixed-performance-mode-enabled false
                    ;;
                37|38)
                    set_thermal_status $THERMAL_STATUS_LIGHT
                    set_cmd power set-adaptive-power-saver-enabled true
                    set_cmd power set-fixed-performance-mode-enabled false
                    ;;
                39|40)
                    set_thermal_status $THERMAL_STATUS_LIGHT
                    set_cmd power set-adaptive-power-saver-enabled true
                    set_cmd power set-fixed-performance-mode-enabled false
                    ;;
                41|42|43|44)
                    set_thermal_status $THERMAL_STATUS_MODERATE
                    set_cmd power set-adaptive-power-saver-enabled true
                    set_cmd power set-fixed-performance-mode-enabled false
                    ;;
                *)
                    set_cmd power set-adaptive-power-saver-enabled reset
                    set_cmd power set-fixed-performance-mode-enabled reset
                    set_thermal_status $THERMAL_STATUS_NONE
                    ;;
            esac
        else
            echo "$(date "+%Y年%m月%d日%H时%M分%S秒") *🔋- 未能获取电池温度信息*"
            exit 1
        fi
    else
        echo "$(date "+%Y年%m月%d日%H时%M分%S秒") *📵- 暗屏状态*"
        set_cmd power set-adaptive-power-saver-enabled true
        set_cmd power set-fixed-performance-mode-enabled false
        set_cmd power set-mode 1
    fi    
    sleep 5
done

