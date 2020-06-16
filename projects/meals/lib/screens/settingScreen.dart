import 'package:flutter/material.dart';
import 'package:meals/components/mainDrawer.dart';
import 'package:meals/models/setting.dart';

class SettingScreen extends StatefulWidget {
  final Setting setting;
  final Function(Setting) onSettingsChanged;

  const SettingScreen(this.setting, this.onSettingsChanged);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Setting setting;

  @override
  void initState() {
    super.initState();
    this.setting = widget.setting;
  }

  Widget _createSwitch(
    String title,
    String subTitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile.adaptive(
      title: Text(title),
      subtitle: Text(subTitle),
      value: value,
      onChanged: (value) {
        onChanged(value);
        widget.onSettingsChanged(setting);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Configurações'),
        ),
        drawer: MainDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Configurações',
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _createSwitch(
                    'Sem Glúten',
                    'Só exibe refeições sem glúten!',
                    setting.isGlutenFree,
                    (value) => setState(() => setting.isGlutenFree = value),
                  ),
                  _createSwitch(
                    'Sem Lactose',
                    'Só exibe refeições sem lactose!',
                    setting.isLactoseFree,
                    (value) => setState(() => setting.isLactoseFree = value),
                  ),
                  _createSwitch(
                    ' Vegano',
                    'Só exibe refeições veganas!',
                    setting.isVegan,
                    (value) => setState(() => setting.isVegan = value),
                  ),
                  _createSwitch(
                    'Vegetariano',
                    'Só exibe refeições vegetarinas!',
                    setting.isVegetarian,
                    (value) => setState(() => setting.isVegetarian = value),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
