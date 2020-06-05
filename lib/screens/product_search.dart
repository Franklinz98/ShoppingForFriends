import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shopping_for_friends/backend/frutiland_api.dart';
import 'package:shopping_for_friends/constants/colors.dart';
import 'package:shopping_for_friends/constants/formatter.dart';
import 'package:shopping_for_friends/models/product.dart';
import 'package:shopping_for_friends/other/s_f_f_line_awesome_icons.dart';
import 'package:shopping_for_friends/widgets/components/filter_chip.dart';
import 'package:shopping_for_friends/widgets/components/input.dart';
import 'package:shopping_for_friends/widgets/components/search_item.dart';

class SearchScreen extends StatefulWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future<List<Product>> _futureList;
  List<String> _categories;
  TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _futureList = fetchProducts();
    _searchController = TextEditingController();
    _searchController.addListener(_searchQuery);
    _categories = [];
    _categories.add("CARNE");
    _categories.add("DESPENSA");
    _categories.add("FRUTA");
    _categories.add("LACTEO");
    _categories.add("LIMPIEZA");
    _categories.add("SALUD");
    _categories.add("VERDURA");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget._scaffoldKey,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: AppColors.cornflower_blue,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    "Añadir Producto",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Input(
                validator: (value) {},
                controller: _searchController,
                hintText: "Nombre del producto",
                icon: Icon(
                  SFFLineAwesome.search_solid,
                  color: AppColors.cornflower_blue,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "Filtrar",
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Wrap(
                spacing: 5.0,
                children: <Widget>[
                  FilterChipWidget(
                    text: "Carnes",
                    onTap: (isSelected) {
                      _filterSearch(isSelected, "CARNE");
                    },
                  ),
                  FilterChipWidget(
                    text: "Despensa",
                    onTap: (isSelected) {
                      _filterSearch(isSelected, "DESPENSA");
                    },
                  ),
                  FilterChipWidget(
                    text: "Frutas",
                    onTap: (isSelected) {
                      _filterSearch(isSelected, "FRUTA");
                    },
                  ),
                  FilterChipWidget(
                    text: "Lacteos",
                    onTap: (isSelected) {
                      _filterSearch(isSelected, "LACTEO");
                    },
                  ),
                  FilterChipWidget(
                    text: "Limpieza",
                    onTap: (isSelected) {
                      _filterSearch(isSelected, "LIMPIEZA");
                    },
                  ),
                  FilterChipWidget(
                    text: "Salud",
                    onTap: (isSelected) {
                      _filterSearch(isSelected, "SALUD");
                    },
                  ),
                  FilterChipWidget(
                    text: "Verduras",
                    onTap: (isSelected) {
                      _filterSearch(isSelected, "VERDURA");
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Product>>(
                future: _futureList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 8.0),
                        itemBuilder: (_, index) {
                          Product product = snapshot.data[index];
                          return SearchTile(
                            product: product,
                            formatter: Formatter.currency,
                            onTap: () {
                              Navigator.pop(context, product);
                            },
                          );
                        },
                        itemCount: snapshot.data.length,
                      );
                    } else {
                      return Center(
                        child: Text("Error"),
                      );
                    }
                  }
                  // By default, show a loading spinner.
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.cornflower_blue),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  _filterSearch(bool isSelected, String category) {
    if (isSelected) {
      _categories.add(category);
    } else {
      _categories.remove(category);
    }
    print(_categories.asMap());
  }

  _searchQuery() {
    String query = _searchController.text;
    if (query.isNotEmpty) {
      setState(() {
        _futureList = fetchProducts(query: query);
      });
    } else {
      setState(() {
        _futureList = fetchProducts();
      });
    }
  }
}
