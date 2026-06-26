alsa_monitor.rules = alsa_monitor.rules or {}

table.insert(alsa_monitor.rules, {
  matches = {
    {
      { "node.name", "equals", "alsa_output.pci-0000_03_00.1.hdmi-stereo-extra2" },
    },
  },
  apply_properties = {
    ["audio.format"] = "S16LE",
    ["audio.rate"] = 48000,
  },
})
