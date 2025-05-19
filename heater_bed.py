# Support for a heated bed
#
# Copyright (C) 2018-2019  Kevin O'Connor <kevin@koconnor.net>
#
# This file may be distributed under the terms of the GNU GPLv3 license.

class PrinterHeaterBed:
    def __init__(self, config):
        self.printer = config.get_printer()
        pheaters = self.printer.load_object(config, 'heaters')
        self.heater = pheaters.setup_heater(config, 'B')
        self.get_status = self.heater.get_status
        self.stats = self.heater.stats
        gcode = self.printer.lookup_object('gcode')
        gcode.register_command("M140", self.cmd_M140)
        gcode.register_command("M190", self.cmd_M190)

    def cmd_M140(self, gcmd, wait=False):
        pheaters = self.printer.lookup_object("heaters")
        try:
            temp = gcmd.get_float("S")
        except Exception:
            temp = self.heater.target_temp
        for name in ["heater_bed", "_Bed_2", "_Bed_3", "_Bed_4", "_Bed_5", "_Bed_6", "_Bed_7", "_Bed_8", "_Bed_9"]:
            try:
                h = pheaters.lookup_heater(name)
                h.set_temp(temp)
            except Exception:
                gcmd.respond_info(f"Warnung: {name} nicht gefunden.")

    def cmd_M190(self, gcmd):
        pheaters = self.printer.lookup_object("heaters")
        try:
            temp = gcmd.get_float("S")
        except Exception:
            temp = self.heater.target_temp
        for name in ["heater_bed", "_Bed_2", "_Bed_3", "_Bed_4", "_Bed_5", "_Bed_6", "_Bed_7", "_Bed_8", "_Bed_9"]:
            try:
                h = pheaters.lookup_heater(name)
                h.set_temp(temp)
            except Exception:
                gcmd.respond_info(f"Warnung: {name} nicht gefunden.")
        pheaters.set_temperature(self.heater, temp, wait=True)

def load_config(config):
    return PrinterHeaterBed(config)
