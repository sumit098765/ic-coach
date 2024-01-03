import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instacoach/domain/repositories/api_repositories.dart';
import 'package:instacoach/logic/blocs/authentication_bloc/LoginUserBloc/login_user_bloc.dart';
import 'package:instacoach/logic/cubits/google_login_cubit/google_login_cubit.dart';
import 'package:instacoach/presentation/views/authentication/Login.dart';

void main() {
  testWidgets('Email TextFormField Validation Test',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ScreenUtilInit(
          minTextAdapt: true,
          child: MultiBlocProvider(providers: [
            BlocProvider(
              create: (context) => LoginBloc(ApiServices()),
            ),
            BlocProvider(
              create: (context) => GoogleLoginCubit(ApiServices()),
            )
          ], child: const MaterialApp(home: LoginScreen()))),
    );

    await tester.pumpAndSettle();
    // Enter invalid email
    await tester.enterText(find.byType(TextFormField).at(0), 'invalid@gmail');
    await tester.pump();

    // Check if the TextFormField shows error text for invalid email
    expect(find.text('Please enter a valid email address'), findsOneWidget);

    // Enter valid email
    await tester.enterText(find.byType(TextFormField).at(0), 'valid@email.com');
    await tester.pump();

    // Check if the TextFormField no longer shows error text for valid email
    expect(find.text('Please enter a valid email address'), findsNothing);
  });

  testWidgets('Password TextFormField Validation Test',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ScreenUtilInit(
        minTextAdapt: true,
        child: MultiBlocProvider(providers: [
          BlocProvider(
            create: (context) => LoginBloc(ApiServices()),
          ),
          BlocProvider(
            create: (context) => GoogleLoginCubit(ApiServices()),
          )
        ], child: const MaterialApp(home: LoginScreen())),
      ),
    );

    // Ensure the widget tree is fully built.
    await tester.pumpAndSettle();

    // Find the TextFormField for the password field.
    final passwordField = find.byKey(const Key("passwordTextField"));

    // Ensure the TextFormField is visible.
    await tester.ensureVisible(passwordField);

    // Enter invalid password.
    await tester.enterText(passwordField, '123');
    await tester.pumpAndSettle();

    // Check if the TextFormField shows error text for invalid password.
    expect(find.text('Password must be at least 8 characters long'),
        findsOneWidget);

    // Enter valid password.
    await tester.enterText(passwordField, 'password123');
    await tester.pumpAndSettle();

    // Check if the TextFormField no longer shows error text for valid password.
    expect(
        find.text('Password must be at least 8 characters long'), findsNothing);
  });

  testWidgets('Login Button Press Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        minTextAdapt: true,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => LoginBloc(ApiServices()),
            ),
            BlocProvider(
              create: (context) => GoogleLoginCubit(ApiServices()),
            )
          ],
          child: const MaterialApp(home: LoginScreen()),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.runAsync(() async {
      final gradientButton = find.text("Login");

      if (gradientButton.evaluate().isNotEmpty) {
        await tester.tap(gradientButton.first);
        await tester.pump();
        await tester.pump(Duration.zero);
        // print(tester.getSemantics(find.byType(CircularProgressIndicator)));
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        
      } else {
        fail('GradientButton1 not found');
      }
    });
  });
}
