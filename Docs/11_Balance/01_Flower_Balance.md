# Chapter 01: Flower & Seed Numerical Balance (`Botanical Tuning Sheet v1.0`)

**Bảng chỉ số cân bằng chi tiết dành cho hạt giống, thời gian sinh trưởng, giá bán và độ hiếm thực vật Plant Tales.**

---

## 1. Bảng Chỉ Số Tiêu Chuẩn (`Master Flower Balance Sheet`)

Tất cả các thông số dưới đây được ánh xạ 1:1 với tệp cấu trúc cơ sở dữ liệu tĩnh `Source/Data/Static/flower_catalog.json`:

| Flower ID (`Mã Loài Hoa`) | Tên Hiển Thị (`Display Name`) | Độ Hiếm (`Rarity`) | Giá Mua Hạt Giống (`Seed Cost`) | Giá Bán Thu Hoạch (`Yield Sell Price`) | Tổng Thời Gian Lớn (`Base Growth Mins`) | Phân Bổ Thời Gian Từng Stage (`Seed : Sprout : Bud : Bloom`) | Lợi Nhuận Gộp (`Net Profit`) | Ghi Chú Đặc Biệt (`Special Trait`) |
| --- | --- | :---: | :---: | :---: | :---: | :---: | :---: | --- |
| `flower_white_lily` | Lily Trắng (`White Lily`) | ⭐ (`Common`) | `20 Gold` | `50 Gold` | `120 mins` (`2 giờ game`) | `24m : 42m : 54m : 120m` | `+30 Gold` | Hoa khởi đầu cho người chơi mới. Dễ mọc, chịu hạn tốt. |
| `flower_red_rose` | Hồng Đỏ (`Red Rose`) | ⭐⭐ (`Uncommon`)| `80 Gold` | `220 Gold` | `1,080 mins` (`18 giờ game`) | `216m : 378m : 486m : 1,080m`| `+140 Gold` | Yêu cầu tưới đều đặn. Là hoa yêu thích của NPC Thomas. |
| `flower_blue_lavender`| Oải Hương Xanh (`Blue Lavender`)| ⭐⭐ (`Uncommon`)| `60 Gold` | `180 Gold` | `720 mins` (`12 giờ game`) | `144m : 252m : 324m : 720m` | `+120 Gold` | Hoa thơm giúp tăng tỷ lệ xuất hiện bướm (`Butterfly VFX`). |
| `flower_golden_sunflower`| Hướng Dương Vàng | ⭐⭐⭐ (`Rare`)| `150 Gold`| `450 Gold` | `1,440 mins` (`24 giờ game`)| `288m : 504m : 648m : 1,440m`| `+300 Gold` | Sinh trưởng nhanh gấp đôi trong những ngày trời nắng (`weather_sunny`). |
| `flower_moonlight_orchid`| Phong Lan Ánh Trăng | ⭐⭐⭐⭐ (`Legendary`)| `500 Gold`| `1,800 Gold`| `4,320 mins` (`3 ngày game`)| `864m : 1,512m : 1,944m : 4,320m`|`+1,300 Gold`| Cây lâu năm (`perennial`). Sau khi thu hoạch lùi về `Stage 2 (Bud)`. |

---

## 2. Công Thức Cân Bằng Kinh Tế Thực Vật (`Botanical Economic ROI Formula`)

Để đảm bảo người chơi có tiến trình tích cực (`Rule 003 Positive Progression`) nhưng không bị lạm phát tiền tệ quá nhanh (`No Inflation Law`), lợi tức đầu tư (`Return on Investment - ROI`) cho mỗi cây hoa được chuẩn hóa theo độ hiếm:

$$\text{ROI (\%)} = \left( \frac{\text{Yield Sell Price} - \text{Seed Cost}}{\text{Seed Cost}} \right) \times 100\%$$

- ⭐ **Common (`White Lily`):** $\text{ROI} = \frac{50 - 20}{20} = 150\%$ *(Vốn ít, hoàn vốn nhanh trong 2 giờ)*
- ⭐⭐ **Uncommon (`Red Rose`):** $\text{ROI} = \frac{220 - 80}{80} = 175\%$ *(Vốn vừa, thời gian 18 giờ)*
- ⭐⭐⭐ **Rare (`Sunflower`):** $\text{ROI} = \frac{450 - 150}{150} = 200\%$ *(Vốn cao, thời gian 1 ngày)*
- ⭐⭐⭐⭐ **Legendary (`Orchid`):** $\text{ROI} = \frac{1800 - 500}{500} = 260\%$ *(Vốn rất cao, thời gian 3 ngày, thu hoạch nhiều vụ)*

---

## 3. Bản Đồ Trọng Số Lai Tạo Di Truyền (`Hybrid Matrix Numerical Balance`)

| Cặp Hoa Bố Mẹ (`Parent Pair`) | Hạt Giống Lai Tạo (`Hybrid Output`) | Tỷ Lệ Lai Tạo Cơ Bản (`Base Chance`) | Thưởng Độ Ẩm (`Moisture Bonus`) | Thưởng NPC Thomas Heart (`Heart Level Bonus`) | Tỷ Lệ Tối Đa (`Max Cap`) |
| --- | --- | :---: | :---: | :---: | :---: |
| Lily Trắng + Hồng Đỏ | `item_seed_pink_blossom` | `15%` | `+5%` (khi `moisture == 100`) | `+1% / 10 Heart Points` | `30% / ngày` |
| Oải Hương Xanh + Lily Trắng| `item_seed_silver_bell` | `10%` | `+5%` | `+1% / 10 Heart Points` | `25% / ngày` |
| Hồng Đỏ + Hướng Dương Vàng| `item_seed_sunset_dahlia`| `5%`  | `+5%` | `+1% / 10 Heart Points` | `20% / ngày` |
