import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:baitul_hikma/app/di.dart';
import 'package:baitul_hikma/data/models/hadith_model.dart';
import 'package:baitul_hikma/features/auth/bloc/auth_cubit.dart';
import 'package:baitul_hikma/features/home/widgets/daily_hadith_card.dart';
import 'package:baitul_hikma/features/profile/view/profile_screen.dart';
import 'package:baitul_hikma/features/settings/bloc/settings_cubit.dart';
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

  testWidgets('ProfileScreen does not contain Library Settings', (tester) async {
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
    expect(find.text('ACCOUNT CONTROLS'), findsOneWidget);
  });
}
