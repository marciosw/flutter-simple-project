import 'package:flutter/material.dart';
import 'package:healthcare/hcrequest/hcrequestdetail/register.page.dart';
import 'package:healthcare/hcrequest/models/HealthCareRequest.model.dart';
import 'package:healthcare/hcrequest/services/healthcarerequest.service.dart';
import 'package:healthcare/service_locator.dart';
import 'package:healthcare/shared/menu.dart';

class HealthCareRequestHomePage extends StatefulWidget {
  const HealthCareRequestHomePage({super.key});

  @override
  _HealthCareRequestHomePageState createState() =>
      _HealthCareRequestHomePageState();
}

class _HealthCareRequestHomePageState extends State<HealthCareRequestHomePage> {
  final healthCareRequestService =
      ServiceLocatorConfig.getIt<IHealthCareRequestService>();
  late Future<List<HealthCareRequestlModel>> getList;

  @override
  void initState() {
    super.initState();
    getList = healthCareRequestService.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: const Text('Requests'),
          actions: [
            IconButton(
                icon: const Icon(
                  Icons.add,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HCRequestRegister(),
                      ));
                }),
          ],
        ),
        body: buildBody(),
      ),
    );
  }

  Widget buildBody3() {
    return const Text('Está aqui');
  }

  Widget buildBody() {
    return FutureBuilder(
      future: getList,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Column(
            children: [
              SizedBox(
                height: 300,
              ),
              Center(
                child: CircularProgressIndicator(),
              )
            ],
          );
        }

        final data = snapshot.data as List<HealthCareRequestlModel>;
        return _listItems(context, data);
      },
    );
  }

  ListView _listItems(
      BuildContext context, List<HealthCareRequestlModel> list) {
    return ListView.builder(
      shrinkWrap: false,
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return _requestCard(context, list[index]);
      },
    );
  }

  Widget _requestCard(BuildContext context, HealthCareRequestlModel item) {
    double fontSize = 15.0;
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 300,
                      child: Text(
                        item.painList ?? "",
                        style: TextStyle(
                            fontSize: fontSize,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      item.date?.toIso8601String() ?? "",
                      style: TextStyle(fontSize: 18.0, color: Colors.grey[500]),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {},
    );
  }
}
