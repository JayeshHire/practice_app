

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/models/farm_details.dart';
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
        body: FarmerDetailsPage(),
      ),
    );
  }
}

