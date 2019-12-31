extends Node


onready var _tello := $Tello as Tello


var _speed := 100
var _distance := 20
var _turn_angle := 1
var _rc_mode := false setget update_rc_mode
var _rc_mode_started := false


func _ready() -> void:
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    $Start.visible = true
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        $Start.visible = true')


func _process(_delta: float) -> void:
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    if !_rc_mode:
        NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '            if !_rc_mode:')
        return
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    if Input.is_action_just_pressed("emergency"):
        NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '            if Input.is_action_just_pressed("emergency"):')
        _tello.emergency()
        NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '                _tello.emergency()')
        _rc_mode = false
        NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '                _rc_mode = false')
        _rc_mode_started = false
        NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '                _rc_mode_started = false')
        $DebugStuff/Box/Box/RC.pressed = false
        NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '                $DebugStuff/Box/Box/RC.pressed = false')
        return
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    if Input.is_action_just_pressed("takeoff"):
        NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '            if Input.is_action_just_pressed("takeoff"):')
        _tello.takeoff()
        NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '                _tello.takeoff()')
        _rc_mode_started = true
        NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '                _rc_mode_started = true')
        return
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    if Input.is_action_just_pressed("land"):
        NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '            if Input.is_action_just_pressed("land"):')
        _tello.land()
        NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '                _tello.land()')
        _rc_mode = false
        NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '                _rc_mode = false')
        _rc_mode_started = false
        NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '                _rc_mode_started = false')
        $DebugStuff/Box/Box/RC.pressed = false
        NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '                $DebugStuff/Box/Box/RC.pressed = false')
        return
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    _handle_rc_control()
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        _handle_rc_control()')


func _handle_rc_control() -> void:
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    if !_rc_mode_started:
        NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '            if !_rc_mode_started:')
        return
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    var forward_backward := _input_forward_back()
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        var forward_backward := _input_forward_back()')
    var left_right := _input_left_right()
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        var left_right := _input_left_right()')
    var yaw := _input_turn_left_right()
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        var yaw := _input_turn_left_right()')
    var up_down := _input_up_down()
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        var up_down := _input_up_down()')
    _tello.rc(left_right * _speed, forward_backward * _speed, up_down * _speed, yaw * _speed)
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        _tello.rc(left_right * _speed, forward_backward * _speed, up_down * _speed, yaw * _speed)')


func _input_up_down() -> int:
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    var up_down := 0
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        var up_down := 0')
    if Input.is_action_pressed("up"):
        NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '            if Input.is_action_pressed("up"):')
        up_down += 1
        NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '                up_down += 1')
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    if Input.is_action_pressed("down"):
        NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '            if Input.is_action_pressed("down"):')
        up_down += -1
        NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '                up_down += -1')
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    return up_down


func _input_turn_left_right() -> int:
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    var yaw := 0
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        var yaw := 0')
    if Input.is_action_pressed("turn_left"):
        NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '            if Input.is_action_pressed("turn_left"):')
        yaw += -1
        NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '                yaw += -1')
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    if Input.is_action_pressed("turn_right"):
        NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '            if Input.is_action_pressed("turn_right"):')
        yaw += 1
        NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '                yaw += 1')
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    return yaw


func _input_left_right() -> int:
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    var left_right := 0
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        var left_right := 0')
    if Input.is_action_pressed("left"):
        NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '            if Input.is_action_pressed("left"):')
        left_right += -1
        NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '                left_right += -1')
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    if Input.is_action_pressed("right"):
        NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '            if Input.is_action_pressed("right"):')
        left_right += 1
        NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '                left_right += 1')
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    return left_right


func _input_forward_back() -> int:
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    var forward_backward := 0
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        var forward_backward := 0')
    if Input.is_action_pressed("forward"):
        NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '            if Input.is_action_pressed("forward"):')
        forward_backward += 1
        NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '                forward_backward += 1')
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    if Input.is_action_pressed("back"):
        NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '            if Input.is_action_pressed("back"):')
        forward_backward += -1
        NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '                forward_backward += -1')
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    return forward_backward


func update_rc_mode(val: bool) -> void:
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    _rc_mode = val
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        _rc_mode = val')


func _on_Send_pressed() -> void:
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    var cmd : String = ($DebugStuff/Box/Box/HBoxContainer/CmdTxt as LineEdit).text
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        var cmd : String = ($DebugStuff/Box/Box/HBoxContainer/CmdTxt as LineEdit).text')
    if cmd.length() == 0:
        NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '            if cmd.length() == 0:')
        return
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    _tello.send_cmd(cmd)
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        _tello.send_cmd(cmd)')


func _on_Tello_recived_control_code(val) -> void:
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    $Header.update_status(_tello.last_command + ": " + val)
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        $Header.update_status(_tello.last_command + ": " + val)')


func _on_Tello_command_send(cmd) -> void:
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    $Header.update_status(cmd + ": ?")
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        $Header.update_status(cmd + ": ?")')


func _on_CheckBox_toggled(button_pressed: bool) -> void:
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    if button_pressed:
        NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '            if button_pressed:')
        ($DebugStuff as MarginContainer).rect_position.x = 5
        NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '                ($DebugStuff as MarginContainer).rect_position.x = 5')
    else:
        NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '            else:')
        ($DebugStuff as MarginContainer).rect_position.x = -182
        NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '                ($DebugStuff as MarginContainer).rect_position.x = -182')
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')


func _on_ClickController_speed_changed(val) -> void:
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    _speed = val
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        _speed = val')
    _tello.speed(val)
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        _tello.speed(val)')


func _on_ClickController_distance_changed(val) -> void:
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    _distance = val
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        _distance = val')


func _on_ClickController_angle_changed(val) -> void:
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    _turn_angle = val
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        _turn_angle = val')


func _on_TurnLeft_pressed() -> void:
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    _tello.ccw(_turn_angle)
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        _tello.ccw(_turn_angle)')


func _on_TurnRight_pressed() -> void:
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    _tello.cw(_turn_angle)
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        _tello.cw(_turn_angle)')


func _on_Up_pressed() -> void:
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    _tello.up(_distance)
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        _tello.up(_distance)')


func _on_Forward_pressed() -> void:
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    _tello.forward(_distance)
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        _tello.forward(_distance)')


func _on_Left_pressed() -> void:
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    _tello.left(_distance)
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        _tello.left(_distance)')


func _on_Right_pressed() -> void:
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    _tello.right(_distance)
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        _tello.right(_distance)')


func _on_Backward_pressed() -> void:
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    _tello.back(_distance)
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        _tello.back(_distance)')


func _on_Liftoff_pressed() -> void:
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    _tello.takeoff()
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        _tello.takeoff()')
    _rc_mode_started = true
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        _rc_mode_started = true')


func _on_Land_pressed() -> void:
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    _tello.land()
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        _tello.land()')
    _rc_mode_started = false
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        _rc_mode_started = false')


func _on_Down_pressed() -> void:
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    _tello.down(_distance)
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        _tello.down(_distance)')


func _on_ForwardLeft_pressed() -> void:
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    _tello.go(_distance, _distance, 0, _speed)
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        _tello.go(_distance, _distance, 0, _speed)')


func _on_ForwardRight_pressed() -> void:
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    _tello.go(_distance, -_distance, 0, _speed)
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        _tello.go(_distance, -_distance, 0, _speed)')


func _on_BackwardLeft_pressed() -> void:
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    _tello.go(-_distance, _distance, 0, _speed)
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        _tello.go(-_distance, _distance, 0, _speed)')


func _on_BackwardRight_pressed() -> void:
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    _tello.go(-_distance, -_distance, 0, _speed)
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        _tello.go(-_distance, -_distance, 0, _speed)')


func _on_EmergencyOff_pressed() -> void:
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    _tello.emergency()
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        _tello.emergency()')
    _rc_mode_started = false
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        _rc_mode_started = false')


func _on_start_pressed() -> void:
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '')
    $Start/CenterContainer/Welcome.visible = false
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        $Start/CenterContainer/Welcome.visible = false')
    $Start/CenterContainer/WaitAnimation.visible = true
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        $Start/CenterContainer/WaitAnimation.visible = true')
    $Start/CenterContainer/WaitAnimation.play = true
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        $Start/CenterContainer/WaitAnimation.play = true')
    _tello.start()
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        _tello.start()')
    yield(_tello, "recived_control_code_ok")
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        yield(_tello, "recived_control_code_ok")')
    $Start/CenterContainer/WaitAnimation.play = false
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        $Start/CenterContainer/WaitAnimation.play = false')
    $Start.visible = false
    NaiveGBScriptProfiler.note('test/TelloDroneDemo_Main.test.gd', -1, OS.get_ticks_msec(), '        $Start.visible = false')
