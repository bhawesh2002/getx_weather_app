import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/controllers/weater_controller.dart';
import 'package:getx_weather_app/routes/app_routes.dart';
import 'package:getx_weather_app/utils/enums/temperature_units.dart';
import 'package:getx_weather_app/widgets/loaction_name.dart';
import 'package:getx_weather_app/widgets/temperature_widget.dart';
import 'package:getx_weather_app/widgets/weather_status_widget.dart';
import 'package:getx_weather_app/widgets/weather_status_widgets_collection.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  // final LocationController _locationController = Get.put(LocationController());
  final WeatherController _weatherController = Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: Get.height * 0.02,
            horizontal: Get.width * 0.04,
          ),
          child: Stack(
            children: [
              //Base widget.
              SizedBox(
                width: Get.width,
                height: Get.height,
              ),
              //Display name of the location
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Obx(
                      () => LocationName(name: _weatherController.name.value)),
                ),
              ),
              //Settings Icon
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.settings);
                    },
                    child: Icon(
                      Icons.settings,
                      size: Get.width * 0.06,
                    ),
                  ),
                ),
              ),
              //Display the Temperature value
              Positioned.fill(
                bottom: Get.height * 0.3,
                child: Align(
                  alignment: Alignment.center,
                  child: Obx(
                    () => TemperatureWidget(
                      temperature: _weatherController.mainTemp.value,
                      tempUnit: TemperatureUnit.celsius,
                    ),
                  ),
                ),
              ),
              //Display weatherMain
              Positioned.fill(
                bottom: Get.height * 0.15,
                child: Align(
                  alignment: Alignment.center,
                  child: Obx(
                    () => weatherMain(
                      weatherMain:
                          _weatherController.weatherMain.value.toString(),
                    ),
                  ),
                ),
              ),
              //Display weather status widget
              Positioned.fill(
                bottom: Get.height * -0.1,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                      width: Get.width * 0.85,
                      height: Get.height * 0.15,
                      decoration: BoxDecoration(
                        color: Colors.amber.shade100,
                        borderRadius: BorderRadius.circular(Get.width),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: Get.height * 0.01,
                          horizontal: Get.width * 0.15),
                      child: const WeatherStatus()),
                ),
              ),
              Positioned.fill(
                bottom: Get.height * 0.15,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "More Info",
                      style: GoogleFonts.montserrat(
                        fontSize: Get.width * 0.05,
                        color: Colors.black.withOpacity(0.6),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Get.snackbar(
            'Weather status',
            'Fetching weather data',
            snackPosition: SnackPosition.TOP,
          );
          await _weatherController.getweatherFromCoordinates();
        },
        child: const Icon(
          Icons.gps_fixed_rounded,
        ),
      ),
    );
  }
}
