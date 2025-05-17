import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://xscfxyblbcpxpdnlfusm.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhzY2Z4eWJsYmNweHBkbmxmdXNtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc0NjE1MzgsImV4cCI6MjA2MzAzNzUzOH0.C3qJLzrd8bTl3A7amDCStJhOqSloGQCli4--GbqKkXU",
  );

  final initialRoute = await AppPages.getInitialRoute();
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: initialRoute,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
