# 🎮 CODE CRUSH

<div align="center">

![Code Crush Logo](/Users/cansagnak/.gemini/antigravity/brain/deaaf925-eeb8-426a-8bb2-14a3b1d661d9/codecrush_logo_1765795442432.png)

**Kod Dünyasında Eşleştirme Maceraları**

[![Swift](https://img.shields.io/badge/Swift-5.0+-orange.svg)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-13.0+-blue.svg)](https://www.apple.com/ios)
[![Platform](https://img.shields.io/badge/platform-iOS-lightgrey.svg)](https://www.apple.com)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

</div>

---

## 📋 İçindekiler

- [Genel Bakış](#-genel-bakış)
- [Özellikler](#-özellikler)
- [Ekran Görüntüleri](#-ekran-görüntüleri)
- [Mimari](#-mimari)
- [Teknolojiler](#-teknolojiler)
- [Kurulum](#-kurulum)
- [Oynanış](#-oynanış)
- [Proje Yapısı](#-proje-yapısı)
- [Geliştirme Detayları](#-geliştirme-detayları)
- [Katkıda Bulunma](#-katkıda-bulunma)
- [Lisans](#-lisans)

---

## 🎯 Genel Bakış

**Code Crush**, yazılım geliştiriciler için özel olarak tasarlanmış, eğlenceli ve bağımlılık yapan bir iOS match-3 oyunudur. Klasik Candy Crush mekaniğini yazılım terminolojisi ile birleştiren bu oyun, programlama dünyasından esinlenmiş benzersiz bir deneyim sunar.

Oyuncular API, JSON, GIT, SWIFT, BUG ve SQL gibi yazılım kavramlarını temsil eden renkli chip'leri eşleştirerek puan kazanır ve seviyeleri geçer. Tamamen programatik olarak geliştirilen arayüzü, akıcı animasyonları ve modern dark mode tasarımı ile profesyonel bir mobil oyun deneyimi yaşatır.

### 🎯 Hedef Kitle

- 👨‍💻 Yazılım geliştiriciler
- 🎮 Match-3 oyun severler
- 📱 iOS kullanıcıları
- 🌙 Dark mode hayranları

---

## ✨ Özellikler

### 🎮 Oyun Mekanikleri

- **Match-3 Sistemi**: 3 veya daha fazla aynı türdeki chip'i eşleştirerek puan kazanın
- **Zincirleme Reaksiyonlar**: Eşleşmeler sonrası yeni eşleşmeler otomatik olarak tespit edilir
- **Geçerlilik Kontrolü**: Sadece eşleşmeye yol açan hamleler kabul edilir
- **Yerçekimi Sistemi**: Eşleşen chip'ler yok olduktan sonra üsttekiler düşer, yeni chip'ler eklenir
- **Hamle Limiti**: Her seviye sınırlı sayıda hamle ile tamamlanmalıdır
- **Puan Hedefi**: Her seviyenin kendine özel puan hedefi vardır

### 🎨 Kullanıcı Arayüzü

- **%100 Programatik UI**: Storyboard veya XIB kullanılmadan, tamamen kod ile tasarlanmış arayüz
- **Dark Mode Teması**: Modern ve göz yormayan koyu renk paleti
- **Akıcı Animasyonlar**:
  - Chip eşleştirme animasyonları
  - Patlama efektleri
  - Düşme ve yerçekimi animasyonları
  - Geçersiz hamle geri dönüş animasyonu
  - Puan artışı animasyonu
- **Responsive Tasarım**: Farklı iPhone ekran boyutlarına uyumlu grid sistemi

### 🎯 Yazılım Öğeleri

Her chip farklı bir yazılım kavramını temsil eder:

| Chip | Açıklama |
|------|----------|
| 🔷 **API** | Application Programming Interface |
| 📦 **JSON** | JavaScript Object Notation |
| 🔀 **GIT** | Version Control System |
| 🦅 **SWIFT** | Apple'ın programlama dili |
| 🐛 **BUG** | Yazılım hatası |
| 🗄️ **SQL** | Structured Query Language |

### 💾 Veri Yönetimi

- **UserDefaults**: High score kayıt sistemi
- **Kalıcı Veri**: Oyun ilerlemesi ve en yüksek skorlar saklanır
- **Otomatik Kaydetme**: Her oyun bitiminde en yüksek skor güncellenir

---

## 📱 Ekran Görüntüleri

### Ana Ekran
![Ana Ekran](/Users/cansagnak/.gemini/antigravity/brain/deaaf925-eeb8-426a-8bb2-14a3b1d661d9/home_screen_1765795481791.png)

### Oyun Ekranı
![Oyun Ekranı](/Users/cansagnak/.gemini/antigravity/brain/deaaf925-eeb8-426a-8bb2-14a3b1d661d9/game_screenshot_1765795463987.png)

---

## 🏗️ Mimari

Code Crush, **MVVM (Model-View-ViewModel)** mimari desenini kullanır. Bu desen, kodun bakımını kolaylaştırır, test edilebilirliği artırır ve iş mantığını UI'dan ayırır.

![MVVM Architecture](/Users/cansagnak/.gemini/antigravity/brain/deaaf925-eeb8-426a-8bb2-14a3b1d661d9/architecture_diagram_1765795497528.png)

### Mimari Katmanlar

#### 📱 View (Görünüm Katmanı)

```
View/
├── Controllers/
│   ├── HomeViewController.swift        # Ana sayfa
│   ├── LevelSelectViewController.swift # Seviye seçimi
│   └── GameViewController.swift        # Oyun ekranı
└── Components/
    ├── GridView.swift                  # Oyun grid'i
    └── ItemView.swift                  # Chip görünümü
```

**Sorumluluklar:**
- Kullanıcı arayüzü render etme
- Kullanıcı etkileşimlerini yakalama
- Animasyonları yönetme
- ViewModel'den gelen güncellemeleri gösterme

#### 🧠 ViewModel (Sunum Katmanı)

```
ViewModel/
└── GameViewModel.swift                 # Oyun durumu yönetimi
```

**Sorumluluklar:**
- View ile Model arasında köprü görevi
- İş mantığını yönetme
- Kullanıcı girişlerini işleme
- View'a bildirim gönderme (Delegate pattern)
- Oyun durumunu takip etme

**Delegate Protokolü:**
```swift
protocol GameViewModelDelegate: AnyObject {
    func onGameStarted()
    func onGridUpdated(removed: Set<GameItem>, newItems: [[GameItem]], shifted: [[GameItem]])
    func onScoreUpdated(newScore: Int)
    func onMoveLimitUpdated(movesLeft: Int)
    func onGameOver(isWin: Bool)
    func onInvalidSwap(from: GameItem, to: GameItem)
}
```

#### 📦 Model (Veri Katmanı)

```
Model/
├── GameItem.swift                      # Oyun chip'i modeli
└── Level.swift                         # Seviye ve grid yönetimi
```

**Sorumluluklar:**
- Veri yapılarını tanımlama
- Grid veri yapısını yönetme (Array2D)
- Chip türlerini yönetme (ItemType enum)
- Temel veri operasyonları

#### ⚙️ Services (Servis Katmanı)

```
Services/
├── GameEngine.swift                    # Oyun mantığı motoru
└── StorageService.swift                # Veri saklama
```

**Sorumluluklar:**
- **GameEngine**: 
  - Match-3 algılama algoritması
  - Eşleşme doğrulama
  - Yerçekimi sistemi
  - Yeni chip oluşturma
- **StorageService**: 
  - UserDefaults ile veri saklama
  - High score yönetimi

---

## 🛠️ Teknolojiler

### Temel Teknolojiler

| Teknoloji | Versiyon | Kullanım Amacı |
|-----------|----------|----------------|
| **Swift** | 5.0+ | Ana programlama dili |
| **UIKit** | - | UI framework'ü |
| **Foundation** | - | Temel framework |
| **iOS** | 13.0+ | Minimum desteklenen versiyon |

### Teknik Özellikler

#### 🎨 UI/UX
- **100% Programatik UI**: Tüm arayüz Auto Layout ile kod içinde oluşturulmuştur
- **Custom Views**: GridView ve ItemView özel bileşenleri
- **UIViewPropertyAnimator**: Gelişmiş animasyon kontrolleri
- **Gesture Recognizers**: Tap ve swipe gesture'ları

#### 🧩 Veri Yapıları
- **Generic 2D Array**: Oyun grid'i için özel veri yapısı
  ```swift
  struct Array2D<T> {
      let columns: Int
      let rows: Int
      var array: [T?]
  }
  ```
- **Set**: Eşsiz chip koleksiyonları için
- **Enum**: Type-safe chip türleri

#### 🎯 Desenler
- **MVVM**: Ana mimari pattern
- **Delegate Pattern**: View-ViewModel iletişimi
- **Singleton**: StorageService için
- **Protocol-Oriented Programming**: Delegate protokolleri

#### 🎨 Tasarım Sistemi

**Renk Paleti:**
```swift
struct Colors {
    static let background = UIColor(hex: "#121212")      // Arka plan
    static let surface = UIColor(hex: "#1E1E1E")         // Yüzey
    static let surfaceHighlight = UIColor(hex: "#2C2C2C") // Vurgulu yüzey
    static let primaryText = UIColor(hex: "#FFFFFF")     // Ana metin
    static let secondaryText = UIColor(hex: "#AAAAAA")   // İkincil metin
    static let accent = UIColor(hex: "#BB86FC")          // Vurgu rengi (Mor)
    static let niceBlue = UIColor(hex: "#03DAC6")        // Teal
    static let error = UIColor(hex: "#CF6679")           // Hata
    static let success = UIColor(hex: "#03DAC6")         // Başarı
}
```

**Font Sistemi:**
```swift
struct Fonts {
    static func main(size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont
    static func codeDisplay(size: CGFloat) -> UIFont  // Menlo-Bold
}
```

---

## 📥 Kurulum

### Gereksinimler

- **macOS**: 11.0 veya üzeri
- **Xcode**: 12.0 veya üzeri
- **iOS**: 13.0 veya üzeri (Simülatör veya gerçek cihaz)
- **Swift**: 5.0 veya üzeri

### Kurulum Adımları

1. **Repository'yi klonlayın:**
   ```bash
   git clone https://github.com/yourusername/CodeCrush.git
   cd CodeCrush
   ```

2. **Xcode ile açın:**
   ```bash
   open CodeCrush.xcodeproj
   ```

3. **Simülatör veya cihaz seçin:**
   - Xcode üst barından hedef cihazı seçin (örn: iPhone 14 Pro)

4. **Projeyi çalıştırın:**
   - `Cmd + R` tuşlarına basın veya "Build & Run" butonuna tıklayın

### Asset'leri Ekleme

> **Önemli**: Oyunun çalışması için chip görselleri gereklidir.

Assets.xcassets klasörüne aşağıdaki sprite'ları ekleyin:
- `Chip_API`
- `Chip_JSON`
- `Chip_GIT`
- `Chip_SWIFT`
- `Chip_BUG`
- `Chip_SQL`

Her asset 1x, 2x ve 3x çözünürlüklerde eklenmelidir.

---

## 🎮 Oynanış

### Nasıl Oynanır?

1. **🏠 Ana Menü**: "BUILD & RUN" butonuna tıklayın
2. **📊 Seviye Seçimi**: Oynamak istediğiniz seviyeyi seçin
3. **🎯 Oyun Başlar**: 
   - Grid üzerindeki chip'lere tıklayarak seçin
   - İki komşu chip'i yer değiştirecek şekilde seçim yapın
   - Eşleşme oluşursa chip'ler patlar ve puan kazanırsınız
4. **🎊 Hedef**: Hamle limiti dolmadan hedef puanı kazanın!

### Oyun Kuralları

- ✅ **Geçerli Hamleler**: Sadece komşu chip'ler yer değiştirebilir (yatay veya dikey)
- 🎯 **Eşleşme**: 3 veya daha fazla aynı türden chip yan yana gelmelidir
- ⚡ **Zincirleme**: Bir eşleşme sonrası oluşan yeni eşleşmeler otomatik devam eder
- 🔄 **Geçersiz Hamle**: Eşleşme yaratmayan hamleler geri alınır (bounce animasyonu)
- 📉 **Hamle Limiti**: Her hamle sınırlı, dikkatli kullanın!

### Seviye Sistemi

| Seviye | Hedef Puan | Hamle Sayısı |
|--------|------------|--------------|
| **Level 1** | 1000 pts | 24 hamle |
| **Level 2** | 2000 pts | 23 hamle |
| **Level 3** | 3000 pts | 22 hamle |

*Formül: Hedef = Seviye × 1000, Hamle = 25 - Seviye*

### Puanlama Sistemi

- Her eşleşen chip: **10 puan**
- 3'lü eşleşme: **30 puan**
- 4'lü eşleşme: **40 puan**
- 5'li eşleşme: **50 puan**
- Zincirleme bonus: Otomatik eşleşmeler ek puan getirir

---

## 📂 Proje Yapısı

```
CodeCrush/
│
├── CodeCrush/
│   ├── App/                              # Uygulama yaşam döngüsü
│   │   ├── AppDelegate.swift             # Uygulama delegate
│   │   └── SceneDelegate.swift           # Scene delegate (iOS 13+)
│   │
│   ├── Core/                             # Temel yardımcı dosyalar
│   │   ├── AppConstants.swift            # Sabitler (Renkler, Fontlar, Oyun)
│   │   └── Extensions.swift              # UIColor, UIView extension'ları
│   │
│   ├── Model/                            # Veri modelleri
│   │   ├── GameItem.swift                # Chip modeli ve ItemType enum
│   │   └── Level.swift                   # Seviye modeli ve Array2D
│   │
│   ├── ViewModel/                        # Sunum mantığı
│   │   └── GameViewModel.swift           # Oyun durumu yönetimi
│   │
│   ├── View/                             # Görünüm katmanı
│   │   ├── Controllers/                  # View controller'lar
│   │   │   ├── HomeViewController.swift
│   │   │   ├── LevelSelectViewController.swift
│   │   │   └── GameViewController.swift
│   │   └── Components/                   # Özel UI bileşenleri
│   │       ├── GridView.swift            # Oyun grid view
│   │       └── ItemView.swift            # Chip view
│   │
│   ├── Services/                         # İş mantığı servisleri
│   │   ├── GameEngine.swift              # Match-3 algoritması
│   │   └── StorageService.swift          # Veri saklama
│   │
│   ├── Resources/                        # Kaynaklar
│   │   └── Assets.xcassets/              # Görseller ve asset'ler
│   │
│   └── Info.plist                        # Uygulama yapılandırması
│
├── CodeCrush.xcodeproj/                  # Xcode proje dosyası
└── README.md                             # Bu dosya
```

### Dosya Açıklamaları

#### 🎮 Core Files

**AppConstants.swift**
- Uygulama genelinde kullanılan sabitler
- Renk paleti tanımları
- Font sistemleri
- Oyun konfigürasyonu (grid boyutu, hamle limiti, animasyon süreleri)

**Extensions.swift**
- UIColor hex initializer
- UIView pin/center helper metodları
- Kod tekrarını azaltır

#### 📦 Model Layer

**GameItem.swift**
```swift
enum ItemType: Int, CaseIterable {
    case api, json, git, swift, bug, sql
}

struct GameItem: Hashable {
    var column: Int
    var row: Int
    let itemType: ItemType
}
```

**Level.swift**
- 2D grid yönetimi
- Array2D generic veri yapısı
- Chip yerleştirme ve swap operasyonları
- Başlangıçta match-3 olmayacak şekilde grid oluşturma

#### 🧠 ViewModel Layer

**GameViewModel.swift**
- Oyun durumu (skor, hamle sayısı)
- Kullanıcı input işleme
- GameEngine ile etkileşim
- View'a delegate ile bildirim
- Oyun döngüsü yönetimi

#### 👁️ View Layer

**HomeViewController**
- Ana menü ekranı
- "CODE CRUSH" başlığı
- "BUILD & RUN" butonu

**LevelSelectViewController**
- Seviye seçim ekranı
- Dinamik seviye butonları
- Hedef puan gösterimi

**GameViewController**
- Ana oyun ekranı
- GridView yönetimi
- Skor ve hamle gösterimi
- ViewModel delegate implementasyonu

**GridView**
- 2D grid layout
- Manuel frame hesaplama (optimizasyon için)
- Chip view'larını yönetme
- Tap gesture handling
- Swap ve patlama animasyonları

**ItemView**
- Tekil chip görünümü
- UIImageView tabanlı
- Highlight efektleri

#### ⚙️ Services Layer

**GameEngine**
- Match detection algoritması (yatay ve dikey)
- Yerçekimi sistemi
- Yeni chip oluşturma
- Swap validasyon

**StorageService**
- Singleton pattern
- UserDefaults wrapper
- High score kaydetme/okuma

---

## 🔧 Geliştirme Detayları

### Algoritma ve Performans

#### Match Detection Algoritması

**Yatay Eşleşme**:
```swift
// Her satır için tarama
for row in 0..<numRows {
    var column = 0
    while column < numColumns - 2 {
        // 3 ardışık chip kontrol et
        if currentType == nextType == nextNextType {
            // Eşleşme bulundu
            // 3'ten fazla kontrolü yap
            // Set'e ekle
        }
        column += 1
    }
}
```

**Dikey Eşleşme**: Aynı mantık, sütunlar için

**Zaman Karmaşıklığı**: O(rows × columns)

#### Yerçekimi Sistemi

1. Her sütun için ayrı ayrı işlem
2. Boş olan (nil) chip'leri filtrele
3. Kalan chip'leri en alta yerleştir
4. Üst kısma yeni chip'ler ekle

**Animasyon Sıralaması**:
1. Match animasyonu (0.2s) - Scale down + fade
2. Düşme animasyonu (0.6s delay)
3. Yeni eşleşme kontrolü (recursive)

### Optimizasyon Teknikleri

1. **Manuel Frame Hesaplama**: Auto Layout yerine manuel frame hesaplama (performans)
2. **Weak References**: Memory leak önleme (delegate'ler için)
3. **Lazy Loading**: Sadece gerektiğinde view oluşturma
4. **Set Kullanımı**: O(1) lookup için HashSet

### Test Senaryoları

#### Unit Test Önerileri
```swift
// GameEngine Tests
- testHorizontalMatchDetection()
- testVerticalMatchDetection()
- testGravitySystem()
- testInvalidSwapDetection()

// Level Tests
- testInitialBoardHasNoMatches()
- testSwapOperation()

// ViewModel Tests
- testScoreCalculation()
- testGameOverCondition()
```

### Bilinen Sınırlamalar

1. **Animasyon Detayı**: Düşme animasyonları basitleştirilmiş (MVP odaklı)
2. **Özel Power-up'lar**: Henüz implement edilmedi
3. **Ses Efektleri**: Ses sistemi eklenmedi
4. **Particle Effects**: Gelişmiş parçacık efektleri yok
5. **Online Leaderboard**: Sadece yerel high score

### Gelecek Geliştirmeler

- [ ] 🎵 Ses efektleri ve arka plan müziği
- [ ] 💥 Özel power-up'lar (bomba, rainbow chip)
- [ ] 🌐 Online leaderboard (Firebase)
- [ ] 📊 İstatistik ekranı
- [ ] 🎨 Tema seçenekleri
- [ ] 🏆 Achievement sistemi
- [ ] 📱 Haptic feedback
- [ ] 🎯 Daha karmaşık seviye tasarımları
- [ ] 🔄 iCloud sync
- [ ] 📹 Replay sistemi

---

## 🤝 Katkıda Bulunma

Projeye katkıda bulunmak isterseniz:

1. **Fork** edin
2. Feature branch oluşturun (`git checkout -b feature/AmazingFeature`)
3. Değişikliklerinizi commit edin (`git commit -m 'Add some AmazingFeature'`)
4. Branch'inizi push edin (`git push origin feature/AmazingFeature`)
5. **Pull Request** açın

### Katkı Kuralları

- ✅ Kod standartlarına uyun (Swift naming conventions)
- ✅ MVVM mimarisini koruyun
- ✅ Yorum satırları ekleyin (önemli logic için)
- ✅ Test case'ler ekleyin (mümkünse)
- ✅ README güncellemelerini dahil edin

---

## 📄 Lisans

Bu proje MIT Lisansı altında lisanslanmıştır. Detaylar için [LICENSE](LICENSE) dosyasına bakınız.

---

## 🙏 Teşekkürler

- Apple'a iOS ve Swift için
- Tüm açık kaynak topluluğuna
- Match-3 oyun geliştiricilerine ilham için

---

## 📞 İletişim

Sorularınız veya önerileriniz için:

- 📧 [email@example.com](mailto:cllcnsgnk0@gmail.com)

---

<div align="center">

**⭐ Projeyi beğendiyseniz yıldız vermeyi unutmayın! ⭐**

Made with Can Sağnak

[⬆ Başa Dön](#-code-crush)

</div>
