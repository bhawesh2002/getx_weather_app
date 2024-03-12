import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/controllers/search_controller.dart';
import 'package:getx_weather_app/controllers/weater_controller.dart';
import 'package:getx_weather_app/routes/app_routes.dart';
import 'package:getx_weather_app/widgets/city_list_tile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  final SearchPageController _searchController =
      Get.put(SearchPageController());
  final WeatherController _weatherController = Get.find<WeatherController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              _searchController.search(query: "");
              Get.back();
            },
            icon: Icon(
              Symbols.arrow_back,
              size: Get.width * 0.06,
              weight: 1000,
            )),
        title: Text(
          "City Search",
          style: GoogleFonts.montserrat(
            fontSize: Get.width * 0.05,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Get.height * 0.01,
                    horizontal: Get.width * 0.05,
                  ),
                  child: TextField(
                    onChanged: (input) =>
                        _searchController.search(query: input),
                    style: GoogleFonts.montserrat(
                      fontSize: Get.width * 0.04,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: "Search for a City",
                      hintStyle: GoogleFonts.montserrat(),
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              top: Get.height * 0.1,
              child: Align(
                alignment: Alignment.topCenter,
                child: _searchController.isLoading.value == false
                    ? _searchController.searching.value == false
                        ? Center(
                            child: Text(
                              "No Saved Cities",
                              style: GoogleFonts.montserrat(
                                  fontSize: Get.width * 0.05),
                            ),
                          )
                        : Container(
                            constraints: BoxConstraints(
                              maxHeight: Get.height * 0.4,
                            ),
                            width: Get.width * 0.9,
                            child: Material(
                              elevation: 10,
                              borderRadius:
                                  BorderRadius.circular(Get.width * 0.05),
                              color: Colors.white,
                              child: _searchController.filterCities.isEmpty
                                  ? SizedBox(
                                      height: Get.height * 0.08,
                                      child: Center(
                                        child: Text(
                                          "No cities Found",
                                          style: GoogleFonts.montserrat(
                                            fontSize: Get.width * 0.04,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          _searchController.filterCities.length,
                                      itemBuilder: (context, index) {
                                        return CityListTile(
                                          onTap: () {
                                            _weatherController
                                                .getWeatherFromCity(
                                                    cityName: _searchController
                                                        .filterCities[index]
                                                        .cityName);
                                            _searchController.search(query: "");
                                            Get.toNamed(AppRoutes.home);
                                          },
                                          cityName: _searchController
                                              .filterCities[index].cityName,
                                          moreDetails:
                                              "${_searchController.filterCities[index].district}, ${_searchController.filterCities[index].state}",
                                          countryShort: _searchController
                                              .filterCities[index].countryShort,
                                        );
                                      },
                                    ),
                            ),
                          )
                    : Center(
                        child: CircularProgressIndicator(
                          color: Get.theme.primaryColor,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
