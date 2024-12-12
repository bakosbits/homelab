# My Home Assistant

This repository holds the configuration for my [Home Assistant](https://home-assistant.io)

It consists of ~80 devices, including the following integrations:

- Z-wave (lights, switches and motion via z-wave.js)
- Zigbee (lights and motion via zigbee2mqtt)
- Wiz (lights)
- Matter (lights)
- Google cast (8 total)
- Android TV (2 total)
- Amcrest cameras
- Sony Bravia
- Denon AVR
- Universal media player
- Rachio 3
- Bond fan bridge
- Presence detetion (via ping)

I do have a dashboard setup for control but most of the time I leveage Google Assistant to carry out actions. I have crafted ~30 automations to control the state of the house as the sun rises and sets, or I come and go. 

I use the Home-Assistant docker image deployed on [my Nomad cluster](https://github.com/RichBakos/homelab)
