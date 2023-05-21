/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import POJO.DoanhThuTheoThang;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class DoanhThuTheoThangDAO {
    String SELECT_YEAR = "{CALL usp_SelectDoanhThuTheoNam ( ? ) }";
    String SELECT_ALL_SQL = "SELECT * FROM DoanhThuThang";
    public List<DoanhThuTheoThang> selectAll(){
        return this.selectBySql(SELECT_ALL_SQL);
    }
    public List<DoanhThuTheoThang> SelectYear(int Nam){
         List<DoanhThuTheoThang> list =  this.selectBySql(SELECT_YEAR, Nam);
        if (list.isEmpty()) {
            
            return null;
        }
        return list;
    }
    protected List<DoanhThuTheoThang> selectBySql(String sql, Object... args) {
        List<DoanhThuTheoThang> list = new ArrayList<DoanhThuTheoThang>();
        try {
            ResultSet rs = DataProvider.query(sql, args);
            while (rs.next()) {
                DoanhThuTheoThang enity = new DoanhThuTheoThang();              
                enity.setNam(rs.getInt("Nam"));
                enity.setThang(rs.getInt("Thang"));
                enity.setDoanhThu(rs.getFloat("DoanhThu"));
                list.add(enity);
            }
            rs.getStatement().getConnection().close();
            return list;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
