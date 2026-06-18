-- =====================================================
-- NHIỆM VỤ 1: PHÂN TÍCH CẤU TRÚC VÀ RÀNG BUỘC CSDL
-- =====================================================

USE DB03;

-- =====================================================
-- 1. LIỆT KÊ KHÓA CỦA CÁC BẢNG
-- =====================================================

-- Bảng Category
-- PRIMARY KEY : CategoryID
-- (không có FOREIGN KEY)

-- Bảng Product
-- PRIMARY KEY  : ProductID
-- FOREIGN KEY  : CategoryID → Category(CategoryID)

-- Bảng Warehouse
-- PRIMARY KEY  : WarehouseID
-- FOREIGN KEY  : CategoryID → Category(CategoryID)

-- Bảng Instock
-- PRIMARY KEY  : (WarehouseID, ProductID)  -- composite key
-- FOREIGN KEY  : WarehouseID → Warehouse(WarehouseID)
-- FOREIGN KEY  : ProductID   → Product(ProductID)

-- Kiểm tra lại cấu trúc từng bảng
DESCRIBE Category;
DESCRIBE Product;
DESCRIBE Warehouse;
DESCRIBE Instock;

-- Xem toàn bộ khóa / index của từng bảng
SHOW KEYS FROM Category;
SHOW KEYS FROM Product;
SHOW KEYS FROM Warehouse;
SHOW KEYS FROM Instock;

-- =====================================================
-- 2. SƠ ĐỒ ERD (mô tả quan hệ dạng text)
-- =====================================================

-- Category (1) ──< (N) Product
--   Category.CategoryID = Product.CategoryID

-- Category (1) ──< (N) Warehouse
--   Category.CategoryID = Warehouse.CategoryID

-- Product   (1) ──< (N) Instock
--   Product.ProductID = Instock.ProductID

-- Warehouse (1) ──< (N) Instock
--   Warehouse.WarehouseID = Instock.WarehouseID

-- =====================================================
-- 3. TỔNG HỢP INTEGRITY CONSTRAINTS
-- =====================================================

-- ── 3.1 ENTITY INTEGRITY ────────────────────────────
-- Mỗi bảng có PRIMARY KEY, không NULL, duy nhất.
-- Kiểm tra: không có hàng nào trùng PK
SELECT 'Category'  AS Bang, COUNT(*) AS TongSoDong, COUNT(DISTINCT CategoryID)  AS SoKhoaChinh FROM Category;
SELECT 'Product'   AS Bang, COUNT(*) AS TongSoDong, COUNT(DISTINCT ProductID)   AS SoKhoaChinh FROM Product;
SELECT 'Warehouse' AS Bang, COUNT(*) AS TongSoDong, COUNT(DISTINCT WarehouseID) AS SoKhoaChinh FROM Warehouse;
SELECT 'Instock'   AS Bang, COUNT(*) AS TongSoDong,
       COUNT(DISTINCT CONCAT(WarehouseID, '-', ProductID)) AS SoKhoaChinh
FROM Instock;

-- ── 3.2 REFERENTIAL INTEGRITY ───────────────────────
-- FK phải trỏ đến giá trị tồn tại trong bảng cha.

-- Product.CategoryID không được trỏ đến CategoryID không tồn tại
SELECT p.ProductID, p.CategoryID
FROM Product p
LEFT JOIN Category c ON p.CategoryID = c.CategoryID
WHERE c.CategoryID IS NULL;
-- Kết quả rỗng = tất cả FK hợp lệ

-- Warehouse.CategoryID không được trỏ đến CategoryID không tồn tại
SELECT w.WarehouseID, w.CategoryID
FROM Warehouse w
LEFT JOIN Category c ON w.CategoryID = c.CategoryID
WHERE c.CategoryID IS NULL;

-- Instock.WarehouseID hợp lệ
SELECT i.WarehouseID, i.ProductID
FROM Instock i
LEFT JOIN Warehouse w ON i.WarehouseID = w.WarehouseID
WHERE w.WarehouseID IS NULL;

-- Instock.ProductID hợp lệ
SELECT i.WarehouseID, i.ProductID
FROM Instock i
LEFT JOIN Product p ON i.ProductID = p.ProductID
WHERE p.ProductID IS NULL;

-- ── 3.3 DOMAIN INTEGRITY ────────────────────────────
-- Kiểm tra UnitPrice > 0
SELECT ProductID, ProductName, UnitPrice
FROM Product
WHERE UnitPrice <= 0;
-- Kết quả rỗng = tất cả giá hợp lệ

-- Kiểm tra Quantity >= 0
SELECT WarehouseID, ProductID, Quantity
FROM Instock
WHERE Quantity < 0;
-- Kết quả rỗng = tất cả số lượng hợp lệ

-- ── 3.4 BUSINESS INTEGRITY ──────────────────────────
-- Kho chỉ chứa sản phẩm cùng danh mục (bảo vệ bởi trigger)
-- Kiểm tra thủ công: Instock không có dòng nào vi phạm
SELECT i.WarehouseID, i.ProductID,
       w.CategoryID AS WarehouseCategory,
       p.CategoryID AS ProductCategory
FROM Instock i
JOIN Warehouse w ON i.WarehouseID = w.WarehouseID
JOIN Product   p ON i.ProductID   = p.ProductID
WHERE w.CategoryID <> p.CategoryID;
-- Kết quả rỗng = không có vi phạm

-- Kiểm tra trigger đang tồn tại
SHOW TRIGGERS LIKE 'Instock';

-- =====================================================
-- 4. MÔ TẢ DATABASE SCHEMA
-- =====================================================

-- ── 4.1 Thông tin tổng quan các bảng ────────────────
SELECT
    TABLE_NAME       AS BangDuLieu,
    TABLE_ROWS       AS UocTinhSoHang,
    CREATE_TIME      AS ThoiGianTao
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'DB03'
ORDER BY TABLE_NAME;

-- ── 4.2 Toàn bộ cột + kiểu dữ liệu + ràng buộc ─────
SELECT
    TABLE_NAME       AS Bang,
    COLUMN_NAME      AS TenCot,
    DATA_TYPE        AS KieuDuLieu,
    CHARACTER_MAXIMUM_LENGTH AS DoDai,
    IS_NULLABLE      AS ChoPhepNull,
    COLUMN_KEY       AS LoaiKhoa,
    COLUMN_DEFAULT   AS GiaTriMacDinh,
    EXTRA            AS GhiChu
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = 'DB03'
ORDER BY TABLE_NAME, ORDINAL_POSITION;

-- ── 4.3 Toàn bộ FOREIGN KEY và quan hệ ─────────────
SELECT
    kcu.TABLE_NAME        AS BangCon,
    kcu.COLUMN_NAME       AS CotForeignKey,
    kcu.REFERENCED_TABLE_NAME  AS BangCha,
    kcu.REFERENCED_COLUMN_NAME AS CotThamChieu,
    rc.UPDATE_RULE        AS KhiCapNhat,
    rc.DELETE_RULE        AS KhiXoa
FROM information_schema.KEY_COLUMN_USAGE kcu
JOIN information_schema.REFERENTIAL_CONSTRAINTS rc
  ON kcu.CONSTRAINT_NAME = rc.CONSTRAINT_NAME
 AND kcu.TABLE_SCHEMA    = rc.CONSTRAINT_SCHEMA
WHERE kcu.TABLE_SCHEMA = 'DB03'
  AND kcu.REFERENCED_TABLE_NAME IS NOT NULL
ORDER BY kcu.TABLE_NAME;

-- ── 4.4 Thống kê tóm tắt dữ liệu ───────────────────

-- Số sản phẩm theo danh mục
SELECT c.CategoryName AS DanhMuc,
       COUNT(p.ProductID) AS SoSanPham,
       MIN(p.UnitPrice)   AS GiaThapNhat,
       MAX(p.UnitPrice)   AS GiaCaoNhat,
       AVG(p.UnitPrice)   AS GiaTrungBinh
FROM Category c
LEFT JOIN Product p ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryID, c.CategoryName;

-- Số kho và tổng tồn kho theo danh mục
SELECT c.CategoryName AS DanhMuc,
       COUNT(DISTINCT w.WarehouseID) AS SoKho,
       SUM(i.Quantity)               AS TongTonKho
FROM Category c
LEFT JOIN Warehouse w ON c.CategoryID = w.CategoryID
LEFT JOIN Instock   i ON w.WarehouseID = i.WarehouseID
GROUP BY c.CategoryID, c.CategoryName;

-- Tồn kho chi tiết: kho – sản phẩm – số lượng
SELECT
    w.WarehouseID,
    w.WarehouseAddress AS DiaChi,
    c.CategoryName     AS DanhMuc,
    p.ProductName      AS TenSanPham,
    i.Quantity         AS SoLuongTon
FROM Instock   i
JOIN Warehouse w ON i.WarehouseID = w.WarehouseID
JOIN Product   p ON i.ProductID   = p.ProductID
JOIN Category  c ON w.CategoryID  = c.CategoryID
ORDER BY w.WarehouseID, p.ProductID;
