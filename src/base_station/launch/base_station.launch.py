from launch import LaunchDescription
from launch_ros.actions import Node
from launch.actions import IncludeLaunchDescription
from launch.launch_description_sources import AnyLaunchDescriptionSource
from launch.substitutions import PathJoinSubstitution
from launch_ros.substitutions import FindPackageShare
from launch.actions import ExecuteProcess


def generate_launch_description():
    # include launch file in video_feed/launch/video_feed.launch.py

    # Start foxglove_bridge node
    node_foxglove_bridge = Node(
        name="foxglove_bridge",
        package="foxglove_bridge",
        executable="foxglove_bridge",
    )

    # Start foxglove studio
    exec_foxglove_studio = ExecuteProcess(cmd=["foxglove-studio"])

    node_joy = Node(
        name="joy_node",
        package="joy",
        executable="joy_node",
        output="screen",
    )
    return LaunchDescription(
        [
            node_foxglove_bridge,
            exec_foxglove_studio,
            node_joy
        ]
    )
