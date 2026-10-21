import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

class PlateCheckerScreen extends StatefulWidget {
  const PlateCheckerScreen({super.key});

  @override
  State<PlateCheckerScreen> createState() => _PlateCheckerScreenState();
}

class _PlateCheckerScreenState extends State<PlateCheckerScreen> {
  final _plateCtrl = TextEditingController();
  final _provCtrl = TextEditingController();
  Map<String, dynamic>? _result;
  String? _error;

  // ── Province list ───────────────────────────────────────────────────────
  static const _provinces = [
    'กรุงเทพมหานคร','กระบี่','กาญจนบุรี','กาฬสินธุ์','กำแพงเพชร',
    'ขอนแก่น','จันทบุรี','ฉะเชิงเทรา','ชลบุรี','ชัยนาท',
    'ชัยภูมิ','ชุมพร','เชียงราย','เชียงใหม่','ตรัง',
    'ตราด','ตาก','นครนายก','นครปฐม','นครพนม',
    'นครราชสีมา','นครศรีธรรมราช','นครสวรรค์','นนทบุรี','นราธิวาส',
    'น่าน','บึงกาฬ','บุรีรัมย์','ปทุมธานี','ประจวบคีรีขันธ์',
    'ปราจีนบุรี','ปัตตานี','พระนครศรีอยุธยา','พะเยา','พังงา',
    'พัทลุง','พิจิตร','พิษณุโลก','เพชรบุรี','เพชรบูรณ์',
    'แพร่','ภูเก็ต','มหาสารคาม','มุกดาหาร','แม่ฮ่องสอน',
    'ยโสธร','ยะลา','ร้อยเอ็ด','ระนอง','ระยอง',
    'ราชบุรี','ลพบุรี','ลำปาง','ลำพูน','เลย',
    'ศรีสะเกษ','สกลนคร','สงขลา','สตูล','สมุทรปราการ',
    'สมุทรสงคราม','สมุทรสาคร','สระแก้ว','สระบุรี','สิงห์บุรี',
    'สุโขทัย','สุพรรณบุรี','สุราษฎร์ธานี','สุรินทร์','หนองคาย',
    'หนองบัวลำภู','อ่างทอง','อำนาจเจริญ','อุดรธานี','อุตรดิตถ์',
    'อุทัยธานี','อุบลราชธานี',
  ];

  // ── Province region ──────────────────────────────────────────────────────
  static const _provinceRegion = {
    'กรุงเทพมหานคร': 'ภาคกลาง', 'นนทบุรี': 'ภาคกลาง', 'ปทุมธานี': 'ภาคกลาง',
    'สมุทรปราการ': 'ภาคกลาง', 'สมุทรสาคร': 'ภาคกลาง', 'สมุทรสงคราม': 'ภาคกลาง',
    'นครปฐม': 'ภาคกลาง', 'สุพรรณบุรี': 'ภาคกลาง', 'กาญจนบุรี': 'ภาคกลาง',
    'ราชบุรี': 'ภาคกลาง', 'เพชรบุรี': 'ภาคกลาง', 'ประจวบคีรีขันธ์': 'ภาคกลาง',
    'ชัยนาท': 'ภาคกลาง', 'สิงห์บุรี': 'ภาคกลาง', 'อ่างทอง': 'ภาคกลาง',
    'ลพบุรี': 'ภาคกลาง', 'สระบุรี': 'ภาคกลาง', 'นครนายก': 'ภาคกลาง',
    'ปราจีนบุรี': 'ภาคกลาง', 'สระแก้ว': 'ภาคกลาง', 'ฉะเชิงเทรา': 'ภาคกลาง',
    'พระนครศรีอยุธยา': 'ภาคกลาง', 'นครสวรรค์': 'ภาคกลาง', 'อุทัยธานี': 'ภาคกลาง',
    'กำแพงเพชร': 'ภาคเหนือ', 'ตาก': 'ภาคเหนือ', 'พิจิตร': 'ภาคเหนือ',
    'พิษณุโลก': 'ภาคเหนือ', 'เพชรบูรณ์': 'ภาคเหนือ', 'สุโขทัย': 'ภาคเหนือ',
    'อุตรดิตถ์': 'ภาคเหนือ', 'เชียงราย': 'ภาคเหนือ', 'เชียงใหม่': 'ภาคเหนือ',
    'น่าน': 'ภาคเหนือ', 'พะเยา': 'ภาคเหนือ', 'แพร่': 'ภาคเหนือ',
    'แม่ฮ่องสอน': 'ภาคเหนือ', 'ลำปาง': 'ภาคเหนือ', 'ลำพูน': 'ภาคเหนือ',
    'ขอนแก่น': 'ภาคตะวันออกเฉียงเหนือ', 'กาฬสินธุ์': 'ภาคตะวันออกเฉียงเหนือ',
    'มหาสารคาม': 'ภาคตะวันออกเฉียงเหนือ', 'ร้อยเอ็ด': 'ภาคตะวันออกเฉียงเหนือ',
    'ยโสธร': 'ภาคตะวันออกเฉียงเหนือ', 'อุบลราชธานี': 'ภาคตะวันออกเฉียงเหนือ',
    'ศรีสะเกษ': 'ภาคตะวันออกเฉียงเหนือ', 'สุรินทร์': 'ภาคตะวันออกเฉียงเหนือ',
    'บุรีรัมย์': 'ภาคตะวันออกเฉียงเหนือ', 'นครราชสีมา': 'ภาคตะวันออกเฉียงเหนือ',
    'ชัยภูมิ': 'ภาคตะวันออกเฉียงเหนือ', 'อุดรธานี': 'ภาคตะวันออกเฉียงเหนือ',
    'หนองคาย': 'ภาคตะวันออกเฉียงเหนือ', 'หนองบัวลำภู': 'ภาคตะวันออกเฉียงเหนือ',
    'เลย': 'ภาคตะวันออกเฉียงเหนือ', 'สกลนคร': 'ภาคตะวันออกเฉียงเหนือ',
    'นครพนม': 'ภาคตะวันออกเฉียงเหนือ', 'มุกดาหาร': 'ภาคตะวันออกเฉียงเหนือ',
    'อำนาจเจริญ': 'ภาคตะวันออกเฉียงเหนือ', 'บึงกาฬ': 'ภาคตะวันออกเฉียงเหนือ',
    'ชลบุรี': 'ภาคตะวันออก', 'ระยอง': 'ภาคตะวันออก', 'จันทบุรี': 'ภาคตะวันออก',
    'ตราด': 'ภาคตะวันออก',
    'ชุมพร': 'ภาคใต้', 'สุราษฎร์ธานี': 'ภาคใต้', 'นครศรีธรรมราช': 'ภาคใต้',
    'กระบี่': 'ภาคใต้', 'พังงา': 'ภาคใต้', 'ภูเก็ต': 'ภาคใต้',
    'ตรัง': 'ภาคใต้', 'พัทลุง': 'ภาคใต้', 'สงขลา': 'ภาคใต้',
    'สตูล': 'ภาคใต้', 'ปัตตานี': 'ภาคใต้', 'ยะลา': 'ภาคใต้',
    'นราธิวาส': 'ภาคใต้', 'ระนอง': 'ภาคใต้',
  };

  // ── Thai consonants order (for series decode) ────────────────────────────
  static const _thaiConsonants =
      'กขคงจฉชซญดตถทธนบปผฝพฟภมยรลวศษสหฬอฮ';
  // 44 consonants (ฆ ฌ ฎ ฏ ณ ฑ ฒ ศ ษ ฤ ฦ excluded from plate use)
  // Actual plate consonants (38 used):
  static const _plateConsonants = 'กขคงจฉชซญดตถทธนบปผฝพฟภมยรลวศษสหอฮ';

  void _check() {
    final plate = _plateCtrl.text.trim();
    final prov = _provCtrl.text.trim();

    if (plate.isEmpty) {
      setState(() { _error = 'กรอกเลขทะเบียนก่อน'; _result = null; });
      return;
    }

    final r = _decode(plate, prov);
    setState(() { _result = r; _error = null; });
  }

  Map<String, dynamic> _decode(String plate, String province) {
    // Normalize: remove spaces/dots for parsing, keep for display
    final cleaned = plate.replaceAll(RegExp(r'\s+'), ' ').trim();
    final parts = cleaned.split(' ');

    // Extract letter prefix and number
    final letterMatch = RegExp(r'^([ก-ฮบ\.]+)').firstMatch(plate.replaceAll(' ', ''));
    final numberMatch = RegExp(r'(\d{1,4})').firstMatch(plate);

    final letters = letterMatch?.group(1) ?? '';
    final number = numberMatch?.group(1) ?? '';

    // ── Vehicle type decode ──────────────────────────────────────────────
    String type = '';
    String typeDetail = '';
    String plateColor = '';
    String textColor = '';
    String plateEmoji = '';
    String category = '';

    final l = letters.replaceAll('.', '');

    if (letters.startsWith('บ.') || letters.startsWith('บ')) {
      // รถโดยสาร
      type = 'รถโดยสารสาธารณะ';
      typeDetail = 'รถประจำทาง/รถโดยสาร ใช้รับผู้โดยสารสาธารณะ';
      plateColor = 'เหลือง'; textColor = 'ดำ'; plateEmoji = '🟨';
      category = 'สาธารณะ';
    } else if (l.startsWith('ท') && l.length == 2) {
      // แท็กซี่
      type = 'รถแท็กซี่มิเตอร์';
      typeDetail = 'รถยนต์รับจ้างสาธารณะ (แท็กซี่) มีมิเตอร์ ป้ายสีเหลือง';
      plateColor = 'เหลือง'; textColor = 'ดำ'; plateEmoji = '🚕';
      category = 'รับจ้างสาธารณะ';
    } else if (l.startsWith('ว') && l.length == 2) {
      type = 'รถยนต์ให้เช่า';
      typeDetail = 'รถยนต์ให้เช่าโดยมีคนขับหรือไม่มีคนขับ ป้ายสีเขียว';
      plateColor = 'เขียว'; textColor = 'เหลือง'; plateEmoji = '🟩';
      category = 'ให้เช่า';
    } else if (l.length == 2 && _isThaiConsonant(l[0]) && _isThaiConsonant(l[1])) {
      // อักษร 2 ตัว → รถยนต์ส่วนบุคคล
      final firstLetter = l[0];
      final secondLetter = l[1];

      // Special series
      if (firstLetter == 'น' && secondLetter == 'ค') {
        type = 'รถยนต์ส่วนบุคคล (นครหลวง)';
        typeDetail = 'ซีรีส์เก่า กรุงเทพมหานคร ช่วงปี พ.ศ. 2493–2510';
        plateColor = 'ขาว'; textColor = 'ดำ'; plateEmoji = '🚗';
        category = 'ส่วนบุคคล';
      } else if (firstLetter == 'ข') {
        type = 'รถยนต์ส่วนบุคคล';
        typeDetail = 'อักษรนำ ข — รถยนต์นั่งส่วนบุคคล ไม่เกิน 7 ที่นั่ง';
        plateColor = 'ขาว'; textColor = 'ดำ'; plateEmoji = '🚗';
        category = 'ส่วนบุคคล';
      } else {
        type = 'รถยนต์นั่งส่วนบุคคล';
        typeDetail = 'รถยนต์นั่ง ไม่เกิน 7 ที่นั่ง น้ำหนักรวมไม่เกิน 2,200 กก.';
        plateColor = 'ขาว'; textColor = 'ดำ'; plateEmoji = '🚗';
        category = 'ส่วนบุคคล';
      }
    } else if (l.length == 1 && _isThaiConsonant(l[0])) {
      type = 'รถจักรยานยนต์';
      typeDetail = 'รถจักรยานยนต์ส่วนบุคคล ป้ายขนาดเล็ก';
      plateColor = 'ขาว'; textColor = 'ดำ'; plateEmoji = '🏍️';
      category = 'รถจักรยานยนต์';
    } else if (letters.contains('ทบ') || letters.contains('ทอ') || letters.contains('ทร')) {
      type = 'รถยนต์ทหาร';
      typeDetail = 'รถราชการสังกัดกองทัพ ป้ายน้ำเงินตัวขาว';
      plateColor = 'น้ำเงิน'; textColor = 'ขาว'; plateEmoji = '🚙';
      category = 'ราชการ';
    } else {
      type = 'ไม่สามารถระบุได้';
      typeDetail = 'รูปแบบป้ายทะเบียนไม่ตรงกับฐานข้อมูล';
      plateColor = '-'; textColor = '-'; plateEmoji = '❓';
      category = '-';
    }

    // ── Series / registration period estimate ───────────────────────────
    String series = '';
    String seriesNote = '';
    if (l.length == 2 && category == 'ส่วนบุคคล') {
      final idx1 = _plateConsonants.indexOf(l[0]);
      final idx2 = _plateConsonants.indexOf(l[1]);
      if (idx1 >= 0 && idx2 >= 0) {
        final totalSeries = idx1 * _plateConsonants.length + idx2;
        // กรุงเทพ: เริ่ม กก (0) ปี ~2516, แต่ละซีรีส์ ~3-5 ปี
        // ต่างจังหวัด: เริ่มช้ากว่าและวนช้ากว่า
        series = '${l[0]}${l[1]} — ซีรีส์ที่ ${totalSeries + 1} ของจังหวัด';
        if (province == 'กรุงเทพมหานคร' || province.isEmpty) {
          final estYear = 2516 + (totalSeries * 4);
          if (estYear <= 2570) {
            seriesNote = 'กรุงเทพฯ: จดทะเบียนช่วงประมาณ พ.ศ. $estYear–${estYear + 4}';
          }
        } else {
          seriesNote = 'ต่างจังหวัด: ช่วงเวลาจดทะเบียนขึ้นกับปริมาณรถในจังหวัดนั้น';
        }
      }
    }

    // ── Province info ────────────────────────────────────────────────────
    String provName = province;
    String region = '';
    if (province.isNotEmpty) {
      // fuzzy match
      for (final p in _provinces) {
        if (p.contains(province) || province.contains(p)) {
          provName = p;
          region = _provinceRegion[p] ?? '';
          break;
        }
      }
    }

    // ── Number info ──────────────────────────────────────────────────────
    String numNote = '';
    if (number.isNotEmpty) {
      final n = int.tryParse(number) ?? 0;
      if (n == 1) numNote = 'เลข 1 — ทะเบียนแรกของซีรีส์';
      else if (n <= 9) numNote = 'เลขหลักเดียว — ทะเบียนต้นซีรีส์ (หายาก)';
      else if (n == 9999) numNote = 'เลข 9999 — ทะเบียนสุดท้ายของซีรีส์';
    }

    return {
      'plate': cleaned.toUpperCase(),
      'letters': letters,
      'number': number,
      'province': provName,
      'region': region,
      'type': type,
      'typeDetail': typeDetail,
      'plateColor': plateColor,
      'textColor': textColor,
      'plateEmoji': plateEmoji,
      'category': category,
      'series': series,
      'seriesNote': seriesNote,
      'numNote': numNote,
    };
  }

  bool _isThaiConsonant(String c) {
    return _thaiConsonants.contains(c);
  }

  @override
  void dispose() {
    _plateCtrl.dispose();
    _provCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ตรวจสอบทะเบียนรถ')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Input card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.dividerColor),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _plateCtrl,
                    textCapitalization: TextCapitalization.characters,
                    decoration: const InputDecoration(
                      hintText: 'เลขทะเบียน เช่น กข 1234 หรือ ทก 5678',
                      prefixIcon: Icon(Icons.directions_car_outlined),
                      labelText: 'หมายเลขทะเบียน',
                    ),
                    onSubmitted: (_) => _check(),
                  ),
                  const SizedBox(height: 12),
                  Autocomplete<String>(
                    optionsBuilder: (v) {
                      if (v.text.isEmpty) return const [];
                      return _provinces.where((p) => p.contains(v.text));
                    },
                    onSelected: (v) => _provCtrl.text = v,
                    fieldViewBuilder: (ctx, ctrl, fn, onSubmit) {
                      _provCtrl.addListener(() {});
                      return TextField(
                        controller: ctrl,
                        focusNode: fn,
                        decoration: const InputDecoration(
                          hintText: 'จังหวัด (ไม่บังคับ)',
                          prefixIcon: Icon(Icons.location_on_outlined),
                          labelText: 'จังหวัด',
                        ),
                        onChanged: (v) => _provCtrl.text = v,
                        onSubmitted: (_) { onSubmit(); _check(); },
                      );
                    },
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.search),
                      label: const Text('ตรวจสอบ'),
                      onPressed: _check,
                    ),
                  ),
                ],
              ),
            ),

            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(_error!, style: const TextStyle(color: AppTheme.errorColor)),
            ],

            if (_result != null) ...[
              const SizedBox(height: 16),
              _buildResult(_result!),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildResult(Map<String, dynamic> r) {
    return Column(
      children: [
        // Plate visual
        _buildPlateVisual(r),
        const SizedBox(height: 14),
        // Info cards
        _infoCard('🚘 ประเภทรถ', [
          _row('ประเภท', r['type']),
          _row('หมวด', r['category']),
          _row('รายละเอียด', r['typeDetail']),
          _row('สีป้าย', '${r["plateEmoji"]} ป้ายสี${r["plateColor"]} ตัวอักษรสี${r["textColor"]}'),
        ]),
        const SizedBox(height: 10),
        if (r['province'].toString().isNotEmpty)
          _infoCard('📍 จังหวัด', [
            _row('จังหวัด', r['province']),
            if (r['region'].toString().isNotEmpty) _row('ภาค', r['region']),
          ]),
        if (r['province'].toString().isNotEmpty) const SizedBox(height: 10),
        if (r['series'].toString().isNotEmpty)
          _infoCard('📅 ข้อมูลซีรีส์', [
            _row('ซีรีส์', r['series']),
            if (r['seriesNote'].toString().isNotEmpty) _row('ช่วงเวลา', r['seriesNote']),
          ]),
        if (r['numNote'].toString().isNotEmpty) ...[
          const SizedBox(height: 10),
          _infoCard('🔢 เลขทะเบียน', [
            _row('หมายเหตุ', r['numNote']),
          ]),
        ],
        const SizedBox(height: 10),
        _buildDisclaimer(),
      ],
    );
  }

  Widget _buildPlateVisual(Map<String, dynamic> r) {
    Color bg; Color fg;
    switch (r['plateColor']) {
      case 'เหลือง': bg = const Color(0xFFFDD835); fg = Colors.black; break;
      case 'เขียว':  bg = const Color(0xFF2E7D32); fg = const Color(0xFFFDD835); break;
      case 'น้ำเงิน': bg = const Color(0xFF1565C0); fg = Colors.white; break;
      case 'ดำ':    bg = Colors.black; fg = const Color(0xFFFDD835); break;
      default:      bg = Colors.white; fg = Colors.black;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black26, width: 2),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 8, offset: const Offset(0,3))],
      ),
      child: Column(
        children: [
          if (r['province'].toString().isNotEmpty)
            Text(r['province'], style: TextStyle(fontSize: 11, color: fg.withOpacity(0.7), letterSpacing: 1)),
          const SizedBox(height: 4),
          Text(
            '${r["letters"]}  ${r["number"]}',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: fg,
              letterSpacing: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard(String title, List<Widget> rows) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppTheme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.06),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Text(title,
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w700,
                    color: AppTheme.primaryColor)),
          ),
          ...rows,
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    if (value.isEmpty || value == '-') return const SizedBox();
    return Column(
      children: [
        const Divider(height: 1, indent: 14),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 90,
                child: Text(label,
                    style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
              ),
              Expanded(
                child: Text(value,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDisclaimer() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.warningColor.withOpacity(0.07),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.warningColor.withOpacity(0.25)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: 16, color: AppTheme.warningColor),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'ข้อมูลวิเคราะห์จากรูปแบบป้ายทะเบียนเท่านั้น ไม่ได้เชื่อมต่อกับฐานข้อมูลกรมการขนส่งทางบก ข้อมูลจริง (สี รุ่น ปีผลิต) ต้องตรวจสอบกับ DLT',
              style: TextStyle(fontSize: 11, color: AppTheme.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}
