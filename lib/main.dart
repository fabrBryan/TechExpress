import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TechExpress',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => const LoginPage(),
        '/main': (BuildContext context) => const MainPage(),
      },
    );
  }
}

// 1. HALAMAN LOGIN
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  final String namaPengguna = 'Bryan';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login - $namaPengguna'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.flash_on, size: 80, color: Colors.blue),
            const SizedBox(height: 16),
            const Text(
              'Selamat Datang di\nTechExpress',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/main');
              },
              child: const Text('Masuk ke Aplikasi'),
            ),
          ],
        ),
      ),
    );
  }
}

// 2. MAIN PAGE (KATALOG & PROFIL)
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    KatalogTab(),
    ProfilTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Katalog',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

// TAB 1: KATALOG 
class KatalogTab extends StatelessWidget {
  const KatalogTab({super.key});

  final List<Map<String, dynamic>> listGadget = const [
    {
      'nama': 'Smartphone Bryan',
      'harga': '5.000.000',
      'icon': Icons.phone_android,
    },
    {
      'nama': 'Laptop Bryan',
      'harga': '12.500.000',
      'icon': Icons.laptop,
    },
    {
      'nama': 'Tablet Bryan',
      'harga': '7.000.000',
      'icon': Icons.tablet_android,
    },
    {
      'nama': 'Smartwatch Bryan',
      'harga': '2.500.000',
      'icon': Icons.watch,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TechExpress - Katalog'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: listGadget.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.85,
          ),
          itemBuilder: (context, index) {
            final gadget = listGadget[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                      namaGadget: gadget['nama'],
                      harga: gadget['harga'],
                      iconGadget: gadget['icon'],
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        gadget['icon'],
                        size: 50,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Gadget ${gadget['nama']}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Rp ${gadget['harga']}',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// TAB 2: PROFIL (USER)
class ProfilTab extends StatelessWidget {
  const ProfilTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TechExpress - Profil'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.account_circle, size: 90, color: Colors.grey),
              const SizedBox(height: 16),
              const Text(
                'kode member: MB-2026-001',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login',
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Text('Keluar/Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 3. HALAMAN DETAIL GADGET 
class DetailPage extends StatefulWidget {
  final String namaGadget;
  final String harga;
  final IconData iconGadget;

  const DetailPage({
    super.key,
    required this.namaGadget,
    required this.harga,
    required this.iconGadget,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  // BILA BELUM DIPILIH, DEFAULT BERISIKAN 'belum'
  String _voucherTerpilih = 'belum';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Gadget ${widget.namaGadget}'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(widget.iconGadget, size: 100, color: Colors.blue),
              const SizedBox(height: 20),
              Text(
                'Nama: Gadget ${widget.namaGadget}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Harga: Rp ${widget.harga}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

              // KOTAK / CARD KHUSUS TAMPILAN VOUCHER
              Container(
                width: 220,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent, width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue.shade50,
                ),
                child: Column(
                  children: [
                    const Text(
                      'Voucher terpilih:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _voucherTerpilih,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _voucherTerpilih == 'belum'
                            ? Colors.grey.shade700
                            : Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute<String>(
                      builder: (BuildContext context) => const VoucherPage(),
                    ),
                  );

                  if (result != null) {
                    setState(() {
                      _voucherTerpilih = result;
                    });
                  }
                },
                child: const Text('Klaim Voucher Diskon'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 4. HALAMAN PILIH VOUCHER
class VoucherPage extends StatelessWidget {
  const VoucherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Voucher'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Pilih diskon voucher Anda:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, '10%');
                },
                child: const Text('Diskon 10%'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, '20%');
                },
                child: const Text('Diskon 20%'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}