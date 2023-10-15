from launch import LaunchDescription
from launch.actions import ExecuteProcess
from launch_ros.actions import Node

def generate_launch_description():
    foxglove_studio = ExecuteProcess(cmd=["foxglove-studio"])

    node_foxglove_bridge = Node(
        package="foxglove_bridge",
        executable="foxglove_bridge",
        output="screen",
    )
    
    return LaunchDescription([
        foxglove_studio,
        node_foxglove_bridge,
    ])