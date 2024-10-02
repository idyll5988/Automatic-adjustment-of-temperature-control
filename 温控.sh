#!/system/bin/sh
date=$(date +"%Y-%m-%d %H:%M:%S")
log_and_execute() {
    echo "$date *执行命令:$1*" 
    eval $1
    if [ $? -ne 0 ]; then
        echo "$date *命令执行失败:$1*" 
    fi
}

while true; do
screen_status=$(dumpsys window | grep "mScreenOn" | grep true)
if [[ "${screen_status}" ]]; then
echo "$date *📲- 亮屏运行*" 
    temperature=$(dumpsys battery | grep 'temperature' | awk -F ": " '{print $2}')
    if [ $? -eq 0 ]; then
	
        temperature=$(echo "scale=1; $temperature / 10" | bc)
        echo "$date *😊- 设备支持温控管理*"
        echo "$date *🔋- 电池温度:$temperature°C*"
    else
        echo "$date *🔋- 未能获取电池温度信息*"
        exit 1
    fi

    temperature_int=${temperature%.*}

    case $temperature_int in
        [0-2][0-9]) 
            log_and_execute "su -c cmd thermalservice override-status 0"
            log_and_execute "su -c cmd power set-adaptive-power-saver-enabled false"
            log_and_execute "su -c cmd power set-fixed-performance-mode-enabled true"
            ;;
        30)
            log_and_execute "su -c cmd thermalservice override-status 0"
            log_and_execute "su -c cmd power set-adaptive-power-saver-enabled false"
            log_and_execute "su -c cmd power set-fixed-performance-mode-enabled true"
            ;;
        31|32)
            log_and_execute "su -c cmd thermalservice override-status 0"
            log_and_execute "su -c cmd power set-adaptive-power-saver-enabled true"
            log_and_execute "su -c cmd power set-fixed-performance-mode-enabled true"
            ;;
        33|34)
            log_and_execute "su -c cmd thermalservice override-status 1"
            log_and_execute "su -c cmd power set-adaptive-power-saver-enabled true"
            log_and_execute "su -c cmd power set-fixed-performance-mode-enabled true"
            ;;
        35|36)
            log_and_execute "su -c cmd thermalservice override-status 2"
            log_and_execute "su -c cmd power set-adaptive-power-saver-enabled true"
            log_and_execute "su -c cmd power set-fixed-performance-mode-enabled false"
            ;;
        37|38)
            log_and_execute "su -c cmd thermalservice override-status 3"
            log_and_execute "su -c cmd power set-adaptive-power-saver-enabled true"
            log_and_execute "su -c cmd power set-fixed-performance-mode-enabled false"
            ;;
        *)
            log_and_execute "su -c cmd power set-adaptive-power-saver-enabled reset"
            log_and_execute "su -c cmd power set-fixed-performance-mode-enabled reset"
            log_and_execute "su -c cmd thermalservice reset"
            ;;
    esac
else
    echo "$date *📵- 暗屏状态，跳过优化*" 
fi	
    sleep 5
done
