<?php if (!defined('BASEPATH')) exit('No direct script access allowed');
class Admin extends CI_Controller
{
    function __construct()
    {
        parent::__construct();
        $this->load->model('M_api');
    }

    function index()
    {
        $result = $this->db->get('users')->result();
        echo json_encode($result);
    }



    function save_users()
    {
        $data = array(
            'email' => $_POST['email'],
            'username' => $_POST['username'],
            'password' => md5($_POST['password']),
            'level' => '1',
            'nama' => $_POST['nama'],
            'status' => '1',
            'createdDate' => date('Y-m-d h:m:s'),
            'photo' => $_POST['photo']
        );
        $this->db->insert('users', $data);
    }
    //untuk update data
    function save_update_users()
    {
        $data = array(
            'email' => $_POST['email'],
            'username' => $_POST['username'],
            'password' => md5($_POST['password']),
            'nama' => $_POST['nama'],
            //'status' => '1',
            'photo' => $_POST['photo']
        );
        $this->db->where('id', $_POST['id'])->update('users', $data);
        $result['message'] = "Pesanan Telah Terkirim";
        echo json_encode($result);
    }

    function save_produk()
    {

        $data = array(
            'nama_produk' => $_POST['nama_produk'],
            'quantity' => $_POST['quantity'],
            'deskripsi' => $_POST['deskripsi'],
            'harga' => $_POST['harga'],
            'createdDate' => date('Y-m-d h:m:s'),
            'image' => $_POST['photo']
        );
        $this->db->insert('produk', $data);
    }

    function save_update_produk()
    {
        $data = array(
            'nama_produk' => $_POST['nama_produk'],
            'quantity' => $_POST['quantity'],
            'deskripsi' => $_POST['deskripsi'],
            'harga' => $_POST['harga'],
            'createdDate' => date('Y-m-d h:m:s'),
            'image' => $_POST['photo']
        );
        $this->db->where('id_produk', $_POST['id_produk'])->update('produk', $data);
        $result['message'] = "Pesanan Telah Terkirim";
        echo json_encode($result);
    }

    function delete_produk($id)
    {
        $this->db->where('id_produk', $id)->delete('produk');
    }

    function delete_users($id)
    {
        $this->db->where('id', $id)->delete('users');
    }
}
