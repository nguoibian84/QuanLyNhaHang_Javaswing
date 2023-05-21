/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;
import POJO.HoaDon;
import java.util.Date;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author Admin
 */
public class HoaDonDAO {
    String FIND_BY_SQL = "{CALL SP_XuatHoaDonTheoNgay (? , ?) }";
    String SELECT_ALL_SQL = "SELECT * FROM HoaDon";
    public List<HoaDon> FIND_TongTien(Date TuNgay,Date DenNgay){
         List<HoaDon> list =  this.selectBySql(FIND_BY_SQL, TuNgay, DenNgay);
        if (list.isEmpty()) {
            
            return null;
        }
        return list;
    }
    public List<HoaDon> selectAll(){
        return this.selectBySql(SELECT_ALL_SQL);
    }
    protected List<HoaDon> selectBySql(String sql, Object... args) {
        List<HoaDon> list = new ArrayList<HoaDon>();
        try {
            ResultSet rs = DataProvider.query(sql, args);
            while (rs.next()) {
                HoaDon enity = new HoaDon();
                enity.setMaHD(rs.getInt("MaHD"));
                enity.setNgayTao(rs.getDate("NgayTao"));
                enity.setMaNV(rs.getString("MaNV"));
                enity.setMaBan(rs.getInt("MaBan"));
                enity.setTongTien(rs.getDouble("TongTien"));
                enity.setTrangThai(rs.getString("TrangThai"));
                list.add(enity);
            }
            rs.getStatement().getConnection().close();
            return list;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
