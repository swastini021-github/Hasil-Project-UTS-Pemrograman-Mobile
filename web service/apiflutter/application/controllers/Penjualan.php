<?php if (!defined('BASEPATH')) exit('No direct script access allowed');
class Penjualan extends CI_Controller
{
    function __construct()
    {
        parent::__construct();
        $this->load->model('M_api');
    }
    //untuk get data

    function index()
    {
        $result = $this->db->get('penjualan')->result();
        echo json_encode($result);
    }

    //untuk save data
    function save()
    {
        $data = array(
            'nama' => $_POST['nama'],
            'keterangan' => $_POST['keterangan'],
            // 'idUsers' => $_POST['idUsers'],
            'jumlah' => $_POST['jumlah'],
            'tanggal' => $_POST['tanggal']
        );
        $this->db->insert('penjualan', $data);
    }
    //untuk update data
    function save_update()
    {
        $data = array(
            'nama' => $_POST['nama'],
            'keterangan' => $_POST['keterangan'],
            'jumlah' => $_POST['jumlah'],
            // 'idUsers' => $_POST['idUsers'],
            'tanggal' => $_POST['tanggal']
        );
        $this->db->where('id', $_POST['id'])->update('penjualan', $data);
        $result['message'] = "Pesanan Telah Terkirim";
        echo json_encode($result);
    }
    //untuk delete data
    function delete($id)
    {
        $this->db->where('id', $id)->delete('penjualan');
    }

    function get_produk()
    {
        $result = $this->db->get('produk')->result();
        echo json_encode($result);
    }
}
