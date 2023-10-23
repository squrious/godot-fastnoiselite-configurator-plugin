# FastNoiseLite Configurator

A simple Godot plugin to configure a FastNoiseLite with a live preview. 

## Why?

When I came to procedural level generation, I used the FastNoiseLite feature to randomly draw my TileMap. But calibrating the parameters was painful, as I had to dive into a hell cycle of _change something, relaunch, not good enough, do it again..._. So I made a simple plugin to ease this step.

## Overview

### Main configuration panel

Here you can play with the main parameters of the FastNoiseLite object. The viewport shows a live preview of the configured size.

![Configuration panel](/assets/configuration_panel.png)


### Tool panel

Here you can reset the settings to default values, and get the code snippet for current parameters.

![Tool panel](/assets/tool_panel.png)


## Install

### Install from the AssetLib

Coming soon!

### Manual installation

Get the sources from this repository, either by cloning it or downloading a ZIP archive. Then add the content of `addons/` to the `res://addons` directory of your project, and enable the plugin in Godot (`Project > Project Settings > Plugins`).


## References

- [FastNoiseLite documentation](https://docs.godotengine.org/en/stable/classes/class_fastnoiselite.html#)
