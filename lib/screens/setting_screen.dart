import 'package:animeworld/common/styles/padding.dart';
import 'package:animeworld/cubits/anime_title_language_cubit.dart';
import 'package:animeworld/cubits/theme_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: const Padding(
        padding: Paddings.defaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ThemeSwitchWidget(),
             
            SizedBox(height: 20),

            AnimeTitleLanguageSwitch()
          ],
        ),
      ),
    );
  }
}

class ThemeSwitchWidget extends StatefulWidget {
  const ThemeSwitchWidget({super.key});

  @override
  State<ThemeSwitchWidget> createState() => _ThemeSwitchWidgetState();
}

class _ThemeSwitchWidgetState extends State<ThemeSwitchWidget> {
  bool isDarkMode = false;

  Future<void> toggleDarkMode(value) async {
    setState(() {
      isDarkMode = !isDarkMode;
      context.read<ThemeCubit>().changeTheme(isDarkMode: isDarkMode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Dark Mode'),
        BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, state) {
            isDarkMode = state == ThemeMode.dark;
            return CupertinoSwitch(
              value: isDarkMode, 
              onChanged: toggleDarkMode,
            );
          },
        )
      ],
    );
  }
}

class AnimeTitleLanguageSwitch extends StatefulWidget {
  const AnimeTitleLanguageSwitch({super.key});

  @override
  State<AnimeTitleLanguageSwitch> createState() => _AnimeTitleLanguageSwitchState();
}

class _AnimeTitleLanguageSwitchState extends State<AnimeTitleLanguageSwitch> {

  bool isEnglish = false;

  Future toggleAnimeTitleLanguage(bool value) async {
    setState(() => isEnglish = value);
    await context.read<AnimeTitleLanguageCubit>()
    .changeAnimeTitleLanguage(isEnglish: isEnglish);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('English'),
        BlocBuilder<AnimeTitleLanguageCubit, bool>(
          builder: (context, state) {
            isEnglish = state;
            return CupertinoSwitch(
              value: isEnglish, 
              onChanged: toggleAnimeTitleLanguage,
            );
          },
        )
      ],
    );
  }
}