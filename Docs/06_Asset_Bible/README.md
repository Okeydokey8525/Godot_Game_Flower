# 🎨 Asset Bible (Tài nguyên đồ họa & âm thanh)

Thư mục này xác định quy chuẩn, danh sách yêu cầu và thông số kỹ thuật cho toàn bộ tài nguyên hình ảnh (Pixel Art, UI, VFX) và âm thanh (SFX, BGM) của dự án Plant Tales.

Quy chuẩn được sắp xếp theo đúng trình tự ưu tiên trong quy trình sản xuất thực tế (*Game Production Pipeline Priority*): từ nền tảng môi trường, kiến trúc đến cư dân sinh sống:

| Mã số | Tài liệu | Mô tả ngắn gọn | Trạng thái |
| --- | --- | --- | --- |
| **00** | **Asset Overview** | Hiến pháp quy chuẩn kỹ thuật, định hướng nghệ thuật (*Art Direction*) & cấu trúc thư mục. | [00_Asset_Overview.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/06_Asset_Bible/00_Asset_Overview.md) (`Approved`) |
| **01** | **Characters** | Quy chuẩn tài nguyên nhân vật (*Character Asset Standard*): Sprite sheet, Portrait, Expression. | [01_Characters.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/06_Asset_Bible/01_Characters.md) (`Approved`) |
| **02** | **Flowers** | Quy chuẩn tài nguyên & nhận diện hoa (*Flower Asset & Identity Standard*), bao gồm Bloom Plate. | [02_Flowers.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/06_Asset_Bible/02_Flowers.md) (`Approved`) |
| **03** | **Tilesets** | Nền tảng môi trường (*Tileset & Environmental Storytelling Standard*): Đất trồng, đường đi, bản đồ. | [03_Tilesets.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/06_Asset_Bible/03_Tilesets.md) (`Draft`) |
| **04** | **Buildings** | Kiến trúc thị trấn & ngoại thất: Nhà kính, cửa hàng hoa, thư viện, nhà trưởng làng. | [04_Buildings.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/06_Asset_Bible/04_Buildings.md) (`Draft`) |
| **05** | **NPC** | Cư dân thị trấn: Sprite sheet, chân dung thoại và biểu cảm NPC sau khi đã có thế giới sinh sống. | [05_NPC.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/06_Asset_Bible/05_NPC.md) (`Draft`) |
| **06** | **UI** | Khung giao diện, nút bấm, thanh trạng thái, icon hệ thống và bộ nguyên liệu sổ tay Bloom Journal. | [06_UI.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/06_Asset_Bible/06_UI.md) (`Draft`) |
| **07** | **Animation** | Thông số frame, tốc độ chuyển động (thu hoạch, tưới nước, gió thổi) và hiệu ứng VFX. | [07_Animation.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/06_Asset_Bible/07_Animation.md) (`Draft`) |
| **08** | **Audio** | Danh sách nhạc nền (BGM) theo mùa và hiệu ứng âm thanh (SFX) tương tác trồng trọt. | [08_Audio.md](file:///c:/LeDucLuong/Plant%20Tales/Docs/06_Asset_Bible/08_Audio.md) (`Draft`) |

---

## 📌 Nguyên Tắc Lộ Trình (Pipeline Roadmap Rule)
Toàn bộ Asset Bible được thiết kế để phục vụ tối đa cho **Codex / Engine Integration**. Việc định nghĩa `Tilesets` trước `Buildings` và `NPC` đảm bảo lập trình viên và nghệ sĩ luôn xây dựng thế giới từ nền đất phông nền lên đến kiến trúc bề mặt trước khi thả nhân vật vào sinh sống.
