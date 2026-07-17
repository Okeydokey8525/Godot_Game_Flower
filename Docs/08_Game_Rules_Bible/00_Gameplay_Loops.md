# Chapter 00B: Gameplay Loop Bible (`Core, Secondary & Meta Loops Architecture`)

**Hiến pháp vòng lặp trải nghiệm (`Gameplay Loop Bible`) định hướng nhịp độ chơi từ 5 phút đầu tiên đến hành trình hàng nghìn giờ của Plant Tales.**

---

## 1. Mục Tiêu & Trách Nhiệm Của Gameplay Loop Bible

Để đảm bảo Game Designer, Kỹ sư lập trình và các AI Agent luôn giữ đúng tiêu điểm trải nghiệm (`Player Experience Focus`), tài liệu này xác lập rõ ràng 3 tầng vòng lặp cốt lõi. Mọi tính năng hay hệ thống mới được viết code sau này đều phải phục vụ việc khép kín một hoặc nhiều vòng lặp dưới đây.

---

## 2. Vòng Lặp Cốt Lõi (`Core Loop — Tần Suất: Mỗi 3–5 Phút`)

**Core Loop** là trái tim của trò chơi, diễn ra liên tục mỗi ngày trong game và ngay bên trong khu nhà kính ấm cúng. Đây chính là mục tiêu tối thượng của **Milestone M3 (`Playable Vertical Slice`)**:

```text
┌────────────────────────────────────────────────────────────────────────┐
│                        CORE GAMEPLAY LOOP (3-5 MINS)                   │
├────────────────────────────────────────────────────────────────────────┤
│                                                                        │
│   [ 1. PLANT SEEDS ] ──► Gieo hạt xuống ô đất trống (Greenhouse Grid)   │
│          ▲                                                       │     │
│          │                                                       ▼     │
│   [ 6. BUY SEEDS ]                                     [ 2. WATERING ] │
│   Dùng tiền mua mầm non                                Tưới đủ ẩm 100% │
│          ▲                                                       │     │
│          │                                                       ▼     │
│   [ 5. SELL YIELD ]                                    [ 3. GROW TIME ]│
│   Bán hoa cho cửa hàng                                 Chờ nhịp đồng hồ│
│          ▲                                                       │     │
│          │                                                       ▼     │
│   [ 4. HARVEST ] ◄── Thu hoạch bông hoa nở rực rỡ (Stage 3 Bloom)      │
│                                                                        │
└────────────────────────────────────────────────────────────────────────┘
```

---

## 3. Vòng Lặp Thứ Cấp (`Secondary Loop — Tần Suất: 1–3 Ngày Game / 15 Phút`)

**Secondary Loop** mở rộng tương tác từ Nhà Kính (`GreenhouseScene`) ra Quảng Trường Làng (`VillageScene`), tạo dựng kết nối cảm xúc với cư dân và chiều sâu sưu tầm:

```text
┌────────────────────────────────────────────────────────────────────────┐
│                     SECONDARY GAMEPLAY LOOP (15 MINS)                  │
├────────────────────────────────────────────────────────────────────────┤
│                                                                        │
│   [ 1. INTERACT WITH NPC ] ──► Trò chuyện & Tặng hoa yêu thích cho NPC │
│          ▲                                                       │     │
│          │                                                       ▼     │
│   [ 4. UNLOCK HYBRIDS ]                                [ 2. FRIENDSHIP ]│
│   Lai tạo ra giống hoa hiếm                            Tăng Heart Level│
│          ▲                                                       │     │
│          │                                                       ▼     │
│   [ 3. COMPLETE QUESTS ] ◄── Nhận nhiệm vụ botanist & ghi Journal      │
│                                                                        │
└────────────────────────────────────────────────────────────────────────┘
```

---

## 4. Vòng Lặp Siêu Cấp (`Meta Loop — Tần Suất: Theo Mùa / Hàng Tuần Đời Thực`)

**Meta Loop** là mục tiêu dài hạn giữ chân người chơi hàng tháng trời, khám phá bí mật gia tộc và mở rộng toàn bộ quy mô khu vườn:

```text
┌────────────────────────────────────────────────────────────────────────┐
│                       META GAMEPLAY LOOP (LONG-TERM)                   │
├────────────────────────────────────────────────────────────────────────┤
│                                                                        │
│   [ 1. SEASON ADVANCE ] ──► Trải qua 28 ngày của một mùa (Spring/Summer)
│          ▲                                                       │     │
│          │                                                       ▼     │
│   [ 5. CREDITS & LORE ]                                [ 2. FESTIVALS ]│
│   Hoàn thành tâm nguyện ông                            Tham gia lễ hội │
│          ▲                                                       │     │
│          │                                                       ▼     │
│   [ 4. STORY UNLOCK ] ◄── [ 3. EXPAND GREENHOUSE ]                     │
│   Mở ký ức Pressed Memory Cải tạo & mở khóa khu đất mới                │
│                                                                        │
└────────────────────────────────────────────────────────────────────────┘
```

---

## 5. Tiêu Chuẩn Nghiệm Thu Playable Loop cho Milestone M3 (`Vertical Slice DoD`)
Một Vertical Slice chỉ được coi là hoàn thành (`Done`) khi người chơi có thể điều khiển nhân vật trải nghiệm trọn vẹn **Core Loop** và kết nối sang bước đầu tiên của **Secondary Loop** (gặp NPC Thomas, nhận nhiệm vụ, trồng hoa, thu hoạch và trả nhiệm vụ nhận thưởng) trong một phiên chơi mượt mà từ 5–10 phút mà không gặp lỗi nghẽn dòng chảy (`Flow Bottlenecks`).
