import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:baitul_hikma/app/di.dart';
import 'package:baitul_hikma/data/models/hadith_model.dart';
import 'package:baitul_hikma/features/auth/bloc/auth_cubit.dart';
import 'package:baitul_hikma/features/home/widgets/daily_hadith_card.dart';
import 'package:baitul_hikma/features/home/widgets/home_drawer.dart';
import 'package:baitul_hikma/features/profile/view/profile_screen.dart';
import 'package:baitul_hikma/core/widgets/baitul_hikma_logo.dart';
import 'package:baitul_hikma/features/settings/bloc/settings_cubit.dart';
import 'package:baitul_hikma/features/settings/view/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await setupDi();
  });

  tearDown(() async {
    await di.reset();
  });

  testWidgets('DailyHadithCard triggers onTap callback when tapped', (tester) async {
    bool tapped = false;
    const testHadith = HadithModel(
      id: 'h1',
      collectionId: 'bukhari',
      number: 1,
      arabicText: 'إِنَّمَا الأَعْمَالُ بِالنِّيَّاتِ',
      englishText: 'Actions are judged by motives.',
      narrator: 'Umar ibn al-Khattab',
      grade: 'Sahih',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DailyHadithCard(
            hadith: testHadith,
            onTap: () => tapped = true,
          ),
        ),
      ),
    );

    expect(find.text('Narrated by Umar ibn al-Khattab'), findsOneWidget);
    await tester.tap(find.byType(DailyHadithCard));
    await tester.pump();

    expect(tapped, isTrue);
  });

  testWidgets('ProfileScreen does not contain Library Settings or SAVED COLLECTIONS', (tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider.value(value: di<SettingsCubit>()),
          BlocProvider.value(value: di<AuthCubit>()),
        ],
        child: const MaterialApp(
          home: ProfileScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Library Settings'), findsNothing);
    expect(find.text('SAVED COLLECTIONS'), findsNothing);
    expect(find.text('ACCOUNT CONTROLS'), findsOneWidget);
  });

  testWidgets('SettingsScreen does not contain ACCOUNT section but keeps app logo and subtitle', (tester) async {
    tester.view.physicalSize = const Size(1200, 3000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider.value(value: di<SettingsCubit>()),
          BlocProvider.value(value: di<AuthCubit>()),
        ],
        child: const MaterialApp(
          home: SettingsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('ACCOUNT'), findsNothing);
    await tester.drag(find.byType(ListView), const Offset(0, -1000));
    await tester.pumpAndSettle();
    expect(find.byType(BaitulHikmaLogo), findsOneWidget);
    expect(find.textContaining('Version'), findsOneWidget);
  });

  testWidgets('HomeDrawer has Collections before Profile and About in separate sections', (tester) async {
    tester.view.physicalSize = const Size(1200, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider.value(value: di<SettingsCubit>()),
          BlocProvider.value(value: di<AuthCubit>()),
        ],
        child: const MaterialApp(
          home: Scaffold(
            drawer: HomeDrawer(),
            body: SizedBox(),
          ),
        ),
      ),
    );

    // Open drawer
    tester.state<ScaffoldState>(find.byType(Scaffold)).openDrawer();
    await tester.pumpAndSettle();

    // Verify section headers exist
    expect(find.text('COLLECTIONS'), findsOneWidget);
    expect(find.text('PROFILE'), findsOneWidget);
    expect(find.text('ABOUT'), findsOneWidget);

    // Verify Collections appears before Profile, and Profile before About
    final collectionsY = tester.getTopLeft(find.text('COLLECTIONS')).dy;
    final profileY = tester.getTopLeft(find.text('PROFILE')).dy;
    final aboutY = tester.getTopLeft(find.text('ABOUT')).dy;

    expect(collectionsY < profileY, isTrue);
    expect(profileY < aboutY, isTrue);
  });
}
