

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/animations/shimmer_anim.dart';
import 'package:my_app/models/farm_details.dart';
import 'package:my_app/models/m_utils.dart';
import 'package:my_app/models/session.dart';
import 'package:my_app/pages/farmer_details_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  final SUPABASE_PROJECT_URL = dotenv.get("SUPABASE_PROJECT_URL");
  final SUPABASE_API_KEY = dotenv.get('SUPABASE_API_KEY');
  
  // Initialize supabase configuration
  await Supabase.initialize(
    url: SUPABASE_PROJECT_URL,
    publishableKey: SUPABASE_API_KEY,
  );

  return runApp(
    ProviderScope(
      child: MyApp(),
    )
  );
}

final supabase = Supabase.instance.client ;

final uuid = const Uuid();

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("MyAPP"),
        ),
        // body: FarmerDetailsPage(),
        body: FormsListPage(),
      ),
    );
  }
}


const _shimmerGradient = LinearGradient(
  colors: [Color(0xFFEBEBF4), Color(0xFFF4F4F4), Color(0xFFEBEBF4)],
  stops: [0.1, 0.3, 0.4],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);


void mockFormsListPageSetup(WidgetRef ref) {
  final myFormNotifier = ref.read(myFormListNotifierProvider.notifier);

  for (int i = 0; i < 4; i++){
    final myForm = i%2 == 0? MyForm(FormStatus.COMPLETED): MyForm(FormStatus.INCOMPLETE);

    myFormNotifier.addMyForm(myForm);
  }
}

class FormsListPage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // mockFormsListPageSetup(ref);

    final formListNotifier = ref.watch(myFormListNotifierProvider);
    final int count = formListNotifier.length ;

    return Scaffold(
      appBar: AppBar(
        title: Text("List of incomplete farmer details"),
        actions: [
          FloatingActionButton(
              onPressed: (){
                mockFormsListPageSetup(ref);
              },
              child: Icon(
                Icons.chat_rounded
              ),
            )
        ],
      ),
      body: Shimmer(
        linearGradient: _shimmerGradient,
        child: ListView.builder(
              itemCount: count,
              itemBuilder: (context, index) {
                // get the farmer name based on the form id
                final form = formListNotifier[index];
                // final farmer = form.farmerId !=null? ref.read(farmerProvider.notifier).getFarmerById(form.farmerId!): ;
                final farmerNotifier= ref.read(farmerProvider.notifier);
                late final Future<Farmer> farmer;
                if (form.farmerId != null){
                  farmer = farmerNotifier.getFarmerById(form.farmerId!);
                } else {
                  farmer = farmerNotifier.getNewFarmer();
                }

                return FutureBuilder<Farmer>(
                  future: farmer, 
                  builder: (context, snapshot){
                    if (snapshot.connectionState == ConnectionState.waiting){
                      return ShimmerLoading(
                        isLoading: true,
                        child: FarmerListItem(Farmer.initialize()),
                      );
                    } else if (snapshot.hasError){
                      return ShimmerLoading(
                        isLoading: false,
                        child: Text("Error: ${snapshot.error}"),
                      );
                    }

                    return ShimmerLoading(
                      isLoading: false, 
                      child: FarmerListItem(snapshot.data)
                    );
                  }
                );
              },
            ),
        )
      );
  }
}

class FarmerListItem extends StatelessWidget {

  FarmerListItem(this.farmer);

  Farmer? farmer ;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.black87,
        backgroundColor: Colors.grey[300],
        minimumSize: Size(88, 36),
        padding: EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2)),
        ),
      ),
      onPressed: () {
        // Route to the farmer form.
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) {
              return FarmerDetailsPage();
            },
          )
        );
      }, 
      child: farmer == null? Text("Unknown"): Text(farmer!.name)
    );
  }
}