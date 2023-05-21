/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package POJO;

/**
 *
 * @author Admin
 */
public class DoanhThuTheoThang {
    int Thang;
    int Nam;
    float DoanhThu;

    public int getThang() {
        return Thang;
    }

    public int getNam() {
        return Nam;
    }

    public float getDoanhThu() {
        return DoanhThu;
    }

    public void setThang(int Thang) {
        this.Thang = Thang;
    }

    public void setNam(int Nam) {
        this.Nam = Nam;
    }

    public void setDoanhThu(float DoanhThu) {
        this.DoanhThu = DoanhThu;
    }

    public DoanhThuTheoThang(int Thang, int Nam, float DoanhThu) {
        this.Thang = Thang;
        this.Nam = Nam;
        this.DoanhThu = DoanhThu;
    }
    public DoanhThuTheoThang(){
        
    }
}
