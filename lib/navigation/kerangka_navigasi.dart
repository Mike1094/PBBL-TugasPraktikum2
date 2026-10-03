import 'package:flutter/material.dart';
import 'app_routes.dart';
import '../pages/beranda_page.dart';
import '../pages/layanan_page.dart';
import '../pages/warga_page.dart';

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
    Navigator.pop(context); // Tutup drawer terlebih dahulu
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          // Tampilan Layar Lebar menggunakan NavigationRail
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: _currentIndex,
                  onDestinationSelected: _onDestinationSelected,
                  labelType: NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: Text('Beranda'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.list_alt_outlined),
                      selectedIcon: Icon(Icons.list_alt),
                      label: Text('Layanan'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person_outline),
                      selectedIcon: Icon(Icons.person),
                      label: Text('Warga'),
                    ),
                  ],
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(child: _pages[_currentIndex]),
              ],
            ),
          );
        } else {
          // Tampilan Layar Sempit menggunakan NavigationBar dan Drawer
          return Scaffold(
            body: _pages[_currentIndex],
            bottomNavigationBar: NavigationBar(
              selectedIndex: _currentIndex,
              onDestinationSelected: _onDestinationSelected,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Beranda',
                ),
                NavigationDestination(
                  icon: Icon(Icons.list_alt_outlined),
                  selectedIcon: Icon(Icons.list_alt),
                  label: 'Layanan',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person),
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
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Pengaturan Kota'),
                  onTap: () => _bukaMenuPendukung(AppRoutes.pengaturan),
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('Tentang Aplikasi'),
                  onTap: () => _bukaMenuPendukung(AppRoutes.tentang),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Keluar'),
                  onTap: () => Navigator.pop(context),
                ),
                // Tombol khusus untuk menguji onUnknownRoute
                ListTile(
                  leading: const Icon(Icons.error, color: Colors.red),
                  title: const Text('Uji Rute Salah'),
                  onTap: () => _bukaMenuPendukung(AppRoutes.testRouteSalah),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}