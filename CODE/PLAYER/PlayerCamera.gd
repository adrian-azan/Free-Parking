extends Camera2D


func _ready() -> void:
	$RemoteTransform2D.remote_path = LabelOverlay.get_path()
