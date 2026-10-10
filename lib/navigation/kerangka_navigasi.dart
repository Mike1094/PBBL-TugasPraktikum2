import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_routes.dart';
import '../pages/beranda_page.dart';
import '../pages/layanan_page.dart';
import '../pages/warga_page.dart';
import '../models/pengajuan_model.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    BerandaPage(),
    LayananPage(),
    WargaPage(),
  ];

  void _onDestinationSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _bukaMenuPendukung(String route) {
    Navigator.pop(context);
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    // Hanya mendengarkan perubahan pada properti totalPengajuan
    int totalPengajuan = context.select<PengajuanModel, int>((model) => model.totalPengajuan);

    Widget buildWargaIcon(IconData iconData) {
      return totalPengajuan > 0
          ? Badge(label: Text('$totalPengajuan'), child: Icon(iconData))
          : Icon(iconData);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: _currentIndex,
                  onDestinationSelected: _onDestinationSelected,
                  labelType: NavigationRailLabelType.all,
                  destinations: [
                    const NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: Text('Beranda'),
                    ),
                    const NavigationRailDestination(
                      icon: Icon(Icons.list_alt_outlined),
                      selectedIcon: Icon(Icons.list_alt),
                      label: Text('Layanan'),
                    ),
                    NavigationRailDestination(
                      icon: buildWargaIcon(Icons.person_outline),
                      selectedIcon: buildWargaIcon(Icons.person),
                      label: const Text('Warga'),
                    ),
                  ],
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(child: _pages[_currentIndex]),
              ],
            ),
          );
        } else {
          return Scaffold(
            body: _pages[_currentIndex],
            bottomNavigationBar: NavigationBar(
              selectedIndex: _currentIndex,
              onDestinationSelected: _onDestinationSelected,
              destinations: [
                const NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Beranda',
                ),
                const NavigationDestination(
                  icon: Icon(Icons.list_alt_outlined),
                  selectedIcon: Icon(Icons.list_alt),
                  label: 'Layanan',
                ),
                NavigationDestination(
                  icon: buildWargaIcon(Icons.person_outline),
                  selectedIcon: buildWargaIcon(Icons.person),
                  label: 'Warga',
                ),
              ],
            ),
            drawer: NavigationDrawer(
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(color: Colors.teal),
                  child: Text('Menu Utama', style: TextStyle(color: Colors.white, fontSize: 24)),
                ),
                ListTile(leading: const Icon(Icons.settings), title: const Text('Pengaturan'), onTap: () => _bukaMenuPendukung(AppRoutes.pengaturan)),
                ListTile(leading: const Icon(Icons.info), title: const Text('Tentang'), onTap: () => _bukaMenuPendukung(AppRoutes.tentang)),
              ],
            ),
          );
        }
      },
    );
  }
}