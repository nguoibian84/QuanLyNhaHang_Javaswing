CREATE DATABASE [QuanLyNhaHang]
GO


USE [QuanLyNhaHang]
GO


CREATE TABLE [dbo].[KhoHang](
	[MaHangHoa] [nvarchar](15) NOT NULL,
	[TenHangHoa] [nvarchar](50) NOT NULL,
	[NgayNhap] [date] NOT NULL,
	[DonVi] [nvarchar](50) NOT NULL,
	[SoLuong] [float] NOT NULL,
	[ChiPhi] [float] NOT NULL,
	[TongChiPhi] [float] NULL,
	PRIMARY KEY (MaHangHoa)
)
GO


CREATE TABLE [dbo].[NhanVien](
	[MaNV] [nvarchar](5) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[HoTen] [nvarchar](50) NOT NULL,
	[SoDT] [nvarchar](15) NOT NULL,
	[ChucVu] [nvarchar](50) NOT NULL,
	[GioiTinh] [bit] NULL,
	[Avatar] [nvarchar](50) NULL,
	PRIMARY KEY (MaNV)
)	
GO


ALTER TABLE NHANVIEN
ADD Active bit default 'false'


SELECT * FROM NHANVIEN
CREATE TABLE [dbo].[BanAn](
	[MaBan] [int] NOT NULL,
	[LoaiBan] [int] NOT NULL,
	[TrangThai] [nvarchar](50) NOT NULL,
	PRIMARY KEY (MaBan)
)
GO
select * from nhanvien


CREATE TABLE [dbo].[HoaDon](
	[MaHD] [int] IDENTITY(1,1) NOT NULL,
	[NgayTao] [datetime] NULL,
	[MaNV] [nvarchar](5) NOT NULL,
	[MaBan] [int] NOT NULL,
	[TongTien] [float] NOT NULL,
	[TrangThai] [nvarchar](20) NOT NULL,
	PRIMARY KEY (MaHD),
	CONSTRAINT FK_NhanVienHoaDon FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV),
	CONSTRAINT FK_BanAnHoaDon FOREIGN KEY (MaBan) REFERENCES BanAn(MaBan)
)
GO


CREATE TABLE LoaiThucDon
(
	MaLoaiTD int IDENTITY(1,1) NOT NULL,
	Ten [nvarchar](50) NOT NULL,
	PRIMARY KEY(MaLoaiTD)
)


CREATE TABLE [dbo].[ThucDon](
	[MaMon] [nvarchar](15) NOT NULL,
	[TenMon] [nvarchar](50) NOT NULL,
	[GiaTien] [float] NOT NULL,
	[HinhAnh] [nvarchar](50) NOT NULL,
	LoaiThucDon int NOT NULL FOREIGN KEY REFERENCES LoaiThucDon(MaLoaiTD),
	PRIMARY KEY (MaMon),
)
SELECT * FROM ThucDon
GO


create PROC SP_FindThucDon(@TenMon nvarchar(50))
AS
BEGIN
	SELECT * FROM ThucDon WHERE TenMon LIKE @TenMon
END
EXEC SP_FindThucDon @TenMon=N'%Salad%'


CREATE PROC SP_TongTienTheoNgay
@NgayBatDau DATETIME,
@NgayKetThuc DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    SELECT SUM(TongTien) AS TongTien
    FROM HoaDon
    WHERE NgayTao >= @NgayBatDau AND NgayTao < DATEADD(day, 1, @NgayKetThuc) 
END
EXEC SP_TongTienTheoNgay '2002-03-27', '2023-05-11'


CREATE PROCEDURE SP_XuatHoaDonTheoNgay
    @TuNgay datetime,
    @DenNgay datetime
AS
BEGIN
    SET NOCOUNT ON;
    SELECT * FROM HoaDon
    WHERE NgayTao BETWEEN @TuNgay AND @DenNgay
END
EXEC SP_XuatHoaDonTheoNgay '2002-03-27', '2023-05-11'


CREATE PROC SP_FindNhanVien(@HoTen nvarchar(50))
AS
BEGIN
	SELECT * FROM NhanVien WHERE HoTen LIKE @HoTen
END


CREATE TABLE [dbo].[ChiTietHoaDon](
	[MaHDCT] [int] IDENTITY(1,1) NOT NULL,
	[MaHD] [int] NOT NULL,
	[MaMon] [nvarchar](15) NOT NULL,
	[SoLuong] [int] Not Null,
	PRIMARY KEY (MaHDCT),
	CONSTRAINT FK_HoaDonHDCT FOREIGN KEY (MaHD) REFERENCES HoaDon(MaHD),
	CONSTRAINT FK_ThucDonHDCT FOREIGN KEY (MaMon) REFERENCES ThucDon(MaMon)
)
GO


CREATE TABLE [dbo].[DatBan](
	[MaDatBan] [nvarchar](15) NOT NULL,
	[TenKH] [nvarchar](50) NOT NULL,
	[SDTKH] [nvarchar](15) NOT NULL,
	[NgayDatBan] [date] NOT NULL,
	[GioDat] [nvarchar](10) NULL,
	[SoNguoi] [int] NOT NULL,
	[GhiChu] [nvarchar](50) NULL,
	[MaNV] [nvarchar](5),
	PRIMARY KEY (MaDatBan),
	CONSTRAINT FK_NhanVienDatBan FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV)
)
GO


insert into LoaiThucDon
values 
(N'Cua'),
(N'Món khác'),
(N'Món ăn'),
(N'Món uống'),
(N'Súp'),
(N'Khai vị'),
(N'Lẩu'),
(N'Sashimi')
SELECT * FROM LoaiThucDon WHERE MaLoaiTD=1


insert into ThucDon
values('TD01',N'Salad trái cây',150000,'saladtraicay.jpg',1),
	  ('TD02',N'Kim chi cải thảo',190000,'kimchi.jpg',1),
	  ('TD03',N'Cơm cuộn Kimbap',150000,'kimbap.jpg',1),
	  ('TD04',N'Bánh hải sản',190000,'banhhaisan.jpg',1),
	  ('TD05',N'Salad rong biển',190000,'saladrongbien.jpg',1),
	  ('TD07',N'Lươn biển nhật', 150000,'luonbien.png',2),
	  ('TD12',N'Trà đào', 119000,'tradao.jpg',3),
	  ('TD13',N'Strawberry tea', 150000,'strawberrytea.jpg',3),
	  ('TD14',N'Soju', 119000,'soju.jpg',3),
	  ('TD15',N'Rượu gạo', 150000,'ruougao.jpg',3),
	  ('TD17',N'Râu mục chiên giòn',119000,'raumucchien.png',1),
	  ('TD18',N'Mực vòng chiên giòn',150000,'mucvongchien.jpg',1),
	  ('TD20',N'Salad cá ngừ với trứng',150000,'saladcangu.jpg',1),
	  ('TD28',N'Coca light', 119000,'cocalight.jpg',3),
	  ('TD29',N'Sprite', 190000,'sprite.jpg',3),
	  ('TD30',N'Nước suối', 119000,'nuocsuoi.png',3),
	  ('TD31',N'Bạch tuộc sốt cay', 190000,'bachtuocsotcay.jpg',2),
	  ('TD32',N'Mực lá sốt cay', 150000,'mucsotcay.jpg',2),
	  ('TD33',N'Cá hồi nướng giấy bạc', 165000,'cahoi.png',2),
	  ('TD34',N'Tôm sốt Guang yang', 130000,'tomsot.jpg',2),
	  ('TD35',N'Tôm lột vỏ sốt tỏi', 165000,'tomsottoi.png',2),
	  ('TD36',N'Cơm trộn Hàn Quốc', 75000,'comtron.jpg',2),
	  ('TD37',N'Cơm trộn hải sản', 120000,'comtronhaisan.jpg',2),
	  ('TD38',N'Cơm trộng bạch tuộc', 99000,'comtronbachtuoc.jpg',2),
	  ('TD39',N'Miến lạnh trộn', 140000,'mienlanh.jpg',2),
	  ('TD40',N'Mì Udon xào hải sản', 165000,'miudon.jpg',2),
	  ('TD41',N'Miến xào hải sản', 165000,'mienxao.jpg',2),
	  ('TD42',N'Canh sườn bò Hàn Quốc', 189000,'canhsuonbo.jpg',2),
	  ('TD43',N'Canh rong biển', 119000,'canhrongbien.jpg',2),
	  ('TD44',N'Canh kim chi hải sản', 150000,'canhhaisan.jpg',2),
	  (N'TD46', N'Rau càng cua', 80000, N'raucangcua.jpg', 5),
      (N'TD47', N'Salad dầu dấm', 110000, N'saladdaudam.jpg', 5),
	  (N'TD48', N'Salad cá hồi', 100000, N'saladcahoi.jpg', 5),
	  (N'TD49', N'Nộm hải sản ', 99000, N'monhaisan.jpg', 5),
	  (N'TD50', N'Salad rong nha cá ngừ', 130000, N'saladrongnhacangu.jpg', 5),
	  (N'TD51', N'Sashimi Bào Ngư', 220000, N'sashimibaongu.jpg', 7),
	  (N'TD52', N'Sashimi Cá Cơm Hàn Quốc', 250000, N'sashimicacomhanquoc.jpg', 7),
	  (N'TD53', N'Sashimi Cá Hồi', 300000, N'sashimicahoi.jpg', 7),
	  (N'TD54', N'Sashimi Hàu Sữa ', 250000, N'sashimihausua.jpg', 7),
	  (N'TD55', N'Sashimi Tôm Hùm', 1000000, N'sashimitomhum.jpg', 7),
	  (N'TD56', N'Sashimi Tôm Sú', 180000, N'sashimitomsu.jpg', 7),
	  (N'TD57', N'Cua hoàng đế hấp ', 2500000, N'cuahoangdehap.jpg', 8),
	  (N'TD58', N'Cua rang me', 300000, N'cuarangme.jpg', 8),
	  (N'TD59', N'Cua sốt ớt Singapo', 350000, N'cuasototsing.jpg', 8),
	  (N'TD60', N'Cua sốt tiêu đen', 260000, N'cuasottieuden.jpg', 8),
	  (N'TD61', N'Ghẹ sốt me', 120000, N'ghesotme.jpg', 8),
	  (N'TD62', N'Lẩu hồng công', 250000, N'laucuahongcong.png', 6),
	  (N'TD63', N'Lẩu cua thái', 250000, N'laucuathai.jpg', 6),
	  (N'TD64', N'Suop Hải Sản', 25000, N'suphaisan.jpg', 4),
	  (N'TD65', N' Soup Tôm Bắp', 25000, N'suptombap.jpg', 4)


insert into NhanVien values
							('NV01', '1',N'Nguyễn Nhâm Ngọ','0348888888',N'Quản lý',1,null,1),
							('NV02', '1',N'Lưu Quang Khải', '055687954', N'Quản lý', 1,null,1),
							('NV03', '1',N'Bùi Đức Minh','0123456789', N'Quản lý', 1,null,1)
select * from NhanVien
--DELETE NhanVien


insert into BanAn values
						(1,4,N'Sẵn Sàng'),
						(2,4,N'Sẵn Sàng'),
						(3,4,N'Sẵn Sàng'),
						(4,4,N'Sẵn Sàng'),
						(5,4,N'Sẵn Sàng'),
						(6,8,N'Sẵn Sàng'),
						(7,8,N'Sẵn Sàng'),
						(8,8,N'Sẵn Sàng'),
						(9,8,N'Sẵn Sàng'),
						(10,8,N'Sẵn Sàng'),
						(11,10,N'Sẵn Sàng'),
						(12,10,N'Sẵn Sàng'),
						(13,10,N'Sẵn Sàng'),
						(14,10,N'Sẵn Sàng')
select * from BanAn


insert into KhoHang values 
							('CHEN01',N'Chén sứ minh long','20230803',N'Cái',100,10000,1000000),
							('DIA',N'Dĩa sứ minh long','20230803',N'Cái',100,10000,1000000),
							('DUA',N'Đũa nhựa cao cấp','20230803',N'Chiếc',200,10000,2000000),
							('NIA',N'Nĩa inox cao cấp','20230803',N'Chiếc',200,10000,2000000),
							('GIAY',N'Giấy ăn vuông','20230803',N'Gói',50,100000,5000000),
							('BIAHNK',N'Bia Heineken','20230803',N'Thùng',500,600000,300000000),
							('CUAHD',N'Cua Hoàng Đế','20230821',N'KG',50,2590000,129500000),
							('TOMHB',N'Tôm Hùm Bông','20230821',N'KG',50,2590000,129500000)


GO


CREATE PROCEDURE sp_NVSoBanbyHD (@TrangThai nvarchar(30),@MaBan nvarchar(15))
AS
select MaHD, hd.MaNV ,HoTen, NgayTao, TongTien, MaBan,TrangThai
from HoaDon HD inner join NHANVIEN NV on HD.MaNV = NV.MaNV
where TrangThai like @TrangThai and MaBan = @MaBan
go


create proc sp_SoSanhNgay(@ngayHT nvarchar(50))
as
select MaHD, hd.MaNV, HoTen, NgayTao, TongTien, MaBan,TrangThai
from HoaDon HD inner join NHANVIEN NV on HD.MaNV = NV.MaNV
where TrangThai = N'Đã Thanh Toán'
and NgayTao = @ngayHT
exec sp_SoSanhNgay '2021-08-04'
go


CREATE PROCEDURE sp_NVbyHD (@TrangThai nvarchar(30))
AS
select MaHD, hd.MaNV , HoTen, NgayTao, TongTien, MaBan,TrangThai
from HoaDon HD inner join NHANVIEN NV on HD.MaNV = NV.MaNV
where TrangThai like @TrangThai


select MaHD, hd.MaNV , HoTen, NgayTao, TongTien, MaBan,TrangThai
from HoaDon HD inner join NHANVIEN NV on HD.MaNV = NV.MaNV order by NgayTao desc
go


create PROC SP_Login(@MaNV nvarchar(5),@Password nvarchar(50))
AS
BEGIN
	SELECT * FROM NhanVien WHERE MaNV=@MaNV AND Password=@Password
END;
go


CREATE PROC SP_InsertOrUpdateThucDon(@MaMon nvarchar(15),@TenMon nvarchar(50),@GiaTien float,@HinhAnh nvarchar(50),@LoaiThucDon int)
AS
	BEGIN
		IF EXISTS(SELECT * FROM ThucDon WHERE MaMon=@MaMon)
			UPDATE ThucDon
			SET TenMon=@TenMon,GiaTien=@GiaTien,HinhAnh=@HinhAnh,LoaiThucDon=@LoaiThucDon
			WHERE MaMon=@MaMon
		ELSE
			INSERT INTO ThucDon
			VALUES(@MaMon,@TenMon,@GiaTien,@HinhAnh,@LoaiThucDon)
	END
	select * from ThucDon
go


Create PROC SP_InsertOrUpdateNhanVien(@MaNV nvarchar(5),@HoTen nvarchar(50),@SoDT nvarchar(15),@ChucVu nvarchar(50),@GioiTinh bit,@Avatar nvarchar(50),@Active bit)
AS
BEGIN
	IF EXISTS(SELECT * FROM NhanVien WHERE MaNV=@MaNV)
		UPDATE NhanVien
		SET HoTen=@HoTen,SoDT=@SoDT,ChucVu=@ChucVu,GioiTinh=@GioiTinh,Avatar=@Avatar,Active=@Active
		WHERE MaNV=@MaNV
	ELSE
		INSERT INTO NhanVien
		VALUES(@MaNV,CONVERT(nvarchar(50), HashBytes('MD5', '1'), 1),@HoTen,@SoDT,@ChucVu,@GioiTinh,@Avatar,@Active)
END


CREATE PROC TinhDoanhThuThang
    @Thang INT,
    @Nam INT
AS
BEGIN
    SELECT SUM(TongTien) AS DoanhThuThang
    FROM HoaDon
    WHERE MONTH(NgayTao) = @Thang
    AND YEAR(NgayTao) = @Nam
    AND TrangThai = N'Đã thanh toán'
END
EXEC TinhDoanhThuThang 5,2023


CREATE TABLE [dbo].[DoanhThuThang](
    [Nam] [int] NOT NULL,
    [Thang] [int] NOT NULL,
    [DoanhThu] [float] NOT NULL,
    PRIMARY KEY CLUSTERED 
    (
        [Nam] ASC,
        [Thang] ASC
    )
)


CREATE TRIGGER [dbo].[UpdateDoanhThuThang] 
ON [dbo].[HoaDon]
AFTER INSERT, UPDATE, DELETE
AS 
BEGIN
    SET NOCOUNT ON;
    DECLARE @Nam INT, @Thang INT, @DoanhThu FLOAT;
    SET @Nam = YEAR(GETDATE());

    -- Insert
    IF EXISTS(SELECT * FROM inserted) AND NOT EXISTS(SELECT * FROM deleted)
    BEGIN
        PRINT 'Insert trigger fired';
        IF OBJECT_ID('tempdb..#TempDoanhThu1') IS NOT NULL DROP TABLE #TempDoanhThu1;
        SELECT MONTH(NgayTao) AS Thang, SUM(TongTien) AS DoanhThu
        INTO #TempDoanhThu1
        FROM inserted
        WHERE YEAR(NgayTao) = @Nam
        GROUP BY MONTH(NgayTao);

        INSERT INTO DoanhThuThang (Nam, Thang, DoanhThu)
        SELECT @Nam, Thang, DoanhThu
        FROM #TempDoanhThu1
        WHERE NOT EXISTS(SELECT * FROM DoanhThuThang WHERE Nam = @Nam AND Thang = Thang);

        UPDATE DoanhThuThang
        SET DoanhThu = Temp.DoanhThu
        FROM DoanhThuThang DTT
        INNER JOIN #TempDoanhThu1 Temp ON DTT.Nam = @Nam AND DTT.Thang = Temp.Thang
        WHERE DTT.Nam = @Nam
        AND DTT.Thang = Temp.Thang;
    END

    -- Update
    IF EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted)
    BEGIN
        PRINT 'Update trigger fired';
        IF OBJECT_ID('tempdb..#TempDoanhThu2') IS NOT NULL DROP TABLE #TempDoanhThu2;
        SELECT @Thang = MONTH(NgayTao), @DoanhThu = SUM(TongTien)
        FROM inserted
        WHERE YEAR(NgayTao) = @Nam
        GROUP BY MONTH(NgayTao);

        UPDATE DoanhThuThang
        SET DoanhThu = @DoanhThu
        WHERE Nam = @Nam AND Thang = @Thang;
    END

    -- Delete
    IF NOT EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted)
    BEGIN
        PRINT 'Delete trigger fired';
        IF OBJECT_ID('tempdb..#TempDoanhThu3') IS NOT NULL DROP TABLE #TempDoanhThu3;
        SELECT MONTH(NgayTao) AS Thang, SUM(TongTien) AS DoanhThu
        INTO #TempDoanhThu3
        FROM deleted
        WHERE YEAR(NgayTao) = @Nam
        GROUP BY MONTH(NgayTao);

        UPDATE DoanhThuThang
        SET DoanhThu = Temp.DoanhThu
        FROM DoanhThuThang DTT
        INNER JOIN #TempDoanhThu3 Temp ON DTT.Nam = @Nam AND DTT.Thang = Temp.Thang
        WHERE DTT.Nam = @Nam AND DTT.Thang = Temp.Thang;
    END
END

GO


INSERT INTO HoaDon (NgayTao, MaNV, MaBan, TongTien, TrangThai)
VALUES ('2022-05-14', 'NV01', 1, 150000, N'Đã thanh toán'),
('2024-05-14', 'NV02', 1, 150000, N'Đã thanh toán'),
('2023-06-15', 'NV01', 2, 200000, N'Đã thanh toán'),
('2023-07-16', 'NV03', 3, 120000, N'Đã thanh toán'),
('2025-08-17', 'NV02', 4, 300000, N'Đã thanh toán'),
('2023-09-18', 'NV01', 5, 500000, N'Đã thanh toán'),
('2023-10-19', 'NV02', 6, 180000, N'Đã thanh toán'),
('2023-11-20', 'NV03', 7, 250000, N'Đã thanh toán'),
('2023-12-21', 'NV01', 8, 100000, N'Đã thanh toán'),
('2023-4-22', 'NV01', 9, 450000, N'Đã thanh toán'),
('2023-3-23', 'NV02', 10, 220000, N'Đã thanh toán'),
('2023-01-14', 'NV01', 1, 150000, N'Đã thanh toán')

CREATE PROCEDURE usp_SelectDoanhThuTheoNam
	@Nam int
AS
BEGIN
	SELECT *
	FROM DoanhThuThang
	WHERE Nam = @Nam
END
exec usp_SelectDoanhThuTheoNam 2023

