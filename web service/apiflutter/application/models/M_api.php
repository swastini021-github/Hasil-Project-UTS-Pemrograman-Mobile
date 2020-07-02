<?php if (!defined('BASEPATH')) exit('No direct script access allowed');
class M_api extends CI_Model
{
    function get_tb_user()
    {
        $data = $this->db->get('users')->result_array();
        return $data;
    }

    function get_tb_penjualan()
    {
        $data = $this->db->get('penjualan')->result_array();
        return $data;
    }

    function cek_login($usr, $psw)
    {

        $this->db->where('username', $usr)->where('password', $psw);
        return $this->db->get('users')->row_array();
    }

    function get_penjualanId($id)
    {

        $this->db->where('idUsers', $id);
        return $this->db->get('penjualan')->row_array();
    }
}
