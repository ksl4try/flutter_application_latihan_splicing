import 'package:flutter/material.dart';

// Menjalankan aplikasi Flutter, root-nya adalah MyApp
void main() => runApp(const MyApp());

// Widget root aplikasi (stateless = tidak punya state internal)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp: pengaturan global (tema, routing, home)
    return MaterialApp(
      // Sembunyikan banner merah "DEBUG"
      debugShowCheckedModeBanner: false,
      // ThemeData: tema global aplikasi
      theme: ThemeData(
        // Aktifkan Material 3 (komponen & warna gaya terbaru)
        useMaterial3: true,
        // colorSchemeSeed: satu warna dasar untuk generate palet
        colorSchemeSeed: Colors.indigo,
      ),
      // Halaman pertama yang ditampilkan
      home: const SlicePage(),
    );
  }
}

// Halaman latihan (stateless page)
class SlicePage extends StatelessWidget {
  // Named parameter {super.key} sesuai best practice lint
  const SlicePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold: rangka halaman (app bar, body, fab, dll.)
    return Scaffold(
      // Body dipusatkan biar konten "rasa HP" di layar lebar
      body: Center(
        // ConstrainedBox: batasi lebar maksimum konten
        child: ConstrainedBox(
          // Lebar maksimal 420 agar nyaman dibaca
          constraints: const BoxConstraints(maxWidth: 420),
          // Konten utama halaman
          child: const _SliceBody(),
        ),
      ),
    );
  }
}

// ───────────────── SECTION CONTAINER ─────────────────
// ───────────────── B: LAYOUT / SLICING (DASAR) ─────────────────
class _SliceBody extends StatelessWidget {
  const _SliceBody();

  @override
  Widget build(BuildContext context) {
    // Gunakan tema aktif untuk konsistensi warna/typography
    final theme = Theme.of(context);

    // Scroll agar aman di semua ukuran layar
    return SingleChildScrollView(
      // Padding tepi konten
      padding: const EdgeInsets.all(16),
      // Susun vertikal
      child: Column(
        // Rata kiri
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── HERO / HEADER (judul + subjudul) ─────────────────────
          // Judul halaman
          Text('Dashboard', style: theme.textTheme.headlineSmall),
          // Spasi kecil
          const SizedBox(height: 6),
          // Subjudul ringkas
          Text(
            'Kerangka dasar untuk tugas slicing.',
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
          ),

          // Spasi seksi
          const SizedBox(height: 16),

          // ── QUICK ACTIONS (3 tombol horisontal) ─────────────────
          // Baris aksi cepat
          Row(
            // Sebar rata
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              // Aksi: Scan
              _ActionButton(icon: Icons.qr_code_scanner, label: 'Scan'),
              // Aksi: Add
              _ActionButton(icon: Icons.add, label: 'Add'),
              // Aksi: Export
              _ActionButton(icon: Icons.ios_share, label: 'Export'),
            ],
          ),

          // Spasi seksi
          const SizedBox(height: 16),

          // ── STATS (grid 2 kolom, placeholder) ───────────────────
          // Bagian judul seksi
          const _SectionHeader('sembarang'),
          // Spasi kecil
          const SizedBox(height: 8),
          // Wrap untuk 2 kolom responsif
          Wrap(
            // Jarak antar kolom
            spacing: 12,
            // Jarak antar baris
            runSpacing: 12,
            children: const [
              // Kartu stat 1
              _CardBox(title: 'Revenue', value: '—', icon: Icons.payments),
              // Kartu stat 2
              _CardBox(title: 'Orders', value: '—', icon: Icons.receipt_long),
              // Kartu stat 3
              _CardBox(
                title: 'Users',
                value: '—',
                icon: Icons.people_alt_outlined,
              ),
              // Kartu stat 4
              _CardBox(title: 'Visits', value: '—', icon: Icons.show_chart),
            ],
          ),

          // Spasi seksi
          const SizedBox(height: 16),

          // ── LIST (daftar item sederhana) ────────────────────────
          // Judul seksi list
          const _SectionHeader('Recent Items'),
          // Spasi kecil
          const SizedBox(height: 8),
          // Kolom list (placeholder 5 item)
          Column(
            children: List.generate(5, (i) {
              // Kartu item list
              return Card(
                // Radius lembut
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                // ListTile pola umum (ikon-kiri, judul, subjudul, panah-kanan)
                child: ListTile(
                  // Ikon dokumen
                  leading: const Icon(Icons.description_outlined),
                  // Judul item
                  title: Text('Item ${i + 1}'),
                  // Subjudul deskripsi
                  subtitle: const Text('Deskripsi singkat'),
                  // Ikon panah kanan
                  trailing: const Icon(Icons.chevron_right),
                  // Aksi ketuk (belum ada navigasi, nanti di tahap C)
                  onTap: () {},
                ),
              );
            }),
          ),

          // Spasi seksi
          const SizedBox(height: 16),

          // ── CTA (tombol aksi panjang) ───────────────────────────
          // Tombol utama lebar penuh
          SizedBox(
            // Lebar penuh kontainer
            width: double.infinity,
            // ElevatedButton gaya default Material 3
            child: ElevatedButton.icon(
              // Aksi klik (placeholder)
              onPressed: () {},
              // Ikon tambah
              icon: const Icon(Icons.add_circle_outline),
              // Teks tombol
              label: const Text('Buat Baru'),
            ),
          ),

          // Spasi akhir
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ───────────────── WIDGET KECIL PENDUKUNG ─────────────────

// Judul seksi kecil
class _SectionHeader extends StatelessWidget {
  final String text;
  const _SectionHeader(this.text);

  @override
  Widget build(BuildContext context) {
    // Teks judul seksi menggunakan style titleMedium
    return Text(text, style: Theme.of(context).textTheme.titleMedium);
  }
}

// Tombol aksi cepat (ikon + label)
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  const _ActionButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    // Tema warna saat ini
    final cs = Theme.of(context).colorScheme;

    // Kontainer tombol kecil
    return Expanded(
      // Card tipis agar terangkat sedikit
      child: Card(
        // Bentuk persegi membulat
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        // Konten tombol
        child: InkWell(
          // Efek ripple
          borderRadius: BorderRadius.circular(12),
          // Aksi sentuh (kosong dulu)
          onTap: () {},
          // Padding dalam tombol
          child: Padding(
            // Ruang dalam
            padding: const EdgeInsets.symmetric(vertical: 12),
            // Susun vertikal ikon + teks di tengah
            child: Column(
              // Pusatkan
              mainAxisSize: MainAxisSize.min,
              children: [
                // Ikon
                Icon(icon, color: cs.primary),
                // Spasi kecil
                const SizedBox(height: 6),
                // Label
                Text(label, style: Theme.of(context).textTheme.labelMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Kartu statistik (dipakai di Wrap → 2 kolom)
class _CardBox extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _CardBox({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // Warna & teks dari tema
    final theme = Theme.of(context);

    // LayoutBuilder untuk hitung lebar slot dari Wrap
    return LayoutBuilder(
      builder: (context, constraints) {
        // Lebar kolom 2-grid sederhana
        final double colWidth = (constraints.maxWidth - 12) / 2;
        // Tentukan lebar final (∞ artinya anak Wrap)
        final double width = constraints.maxWidth == double.infinity
            ? colWidth
            : constraints.maxWidth;

        // Bungkus isi kartu dengan lebar yang ditentukan
        return SizedBox(
          // Tetapkan lebar
          width: width,
          // Kartu stat
          child: Card(
            // Radius lembut
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            // Padding isi
            child: Padding(
              // Ruang dalam
              padding: const EdgeInsets.all(14),
              // Susun horizontal ikon + kolom teks
              child: Row(
                children: [
                  // Ikon stat
                  Icon(icon),
                  // Spasi kecil
                  const SizedBox(width: 12),
                  // Kolom teks fleksibel
                  Expanded(
                    // Susun vertikal judul + nilai
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Judul kecil
                        Text(title, style: theme.textTheme.labelMedium),
                        // Spasi kecil
                        const SizedBox(height: 2),
                        // Nilai besar (placeholder "—")
                        Text(value, style: theme.textTheme.titleLarge),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
