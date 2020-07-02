<?php if (!defined('BASEPATH')) exit('No direct script access allowed');
class Login extends CI_Controller
{
    function __construct()
    {
        parent::__construct();
        $this->load->model('M_api');
    }
    function index()
    {
        $this->load->view('Login');
    }
    function login_api()
    {
        $result['error'] = TRUE;
        $user = $this->M_api->cek_login($_POST['username'], md5($_POST['password']));
        if ($user != NULL) {
            $result = $user;
            $result['value'] = 1;
            $result['error'] = FALSE;
            $result['msg'] = 'Selamat Datang, ' . $user['username'];
        } else {
            $result['value'] = 0;
            $result['msg'] = 'Tidak ditemukan username';
        }
        echo json_encode($result);
        /* $usr = $_POST['username'];
        $psw = $_POST['password'];
        $queryresult = $this->db->query('SELECT * FROM users 
        WHERE username="' . $usr . '", and password="' . $psw . '"');
        $result = array();
        while ($fetchData = $queryresult->fetch_assoc()) {
            $result[] = $fetchData;
        }
        echo json_encode($result);*/
    }

    function register()
    {

        $cek1 = "SELECT * FROM users WHERE username = '$_POST[username]'";
        $cek2 = "SELECT * FROM users WHERE email = '$_POST[email]'";
        $db = mysqli_connect("localhost", "root", "", "db_penjualan");
        $result_username = mysqli_fetch_array(mysqli_query($db, $cek1));
        $result_email = mysqli_fetch_array(mysqli_query($db, $cek2));
        $response['error'] = TRUE;
        if (isset($result_username)) {
            $response['value'] = '0';
            $response['message'] = 'username sudah digunakan';
        } else if (isset($result_email)) {
            $response['value'] = '0';
            $response['message'] = 'email sudah digunakan';
        } else {
            $data = array(
                'email' => $_POST['email'],
                'username' => $_POST['username'],
                'password' => md5($_POST['password']),
                'level' => '2',
                'nama' => $_POST['nama'],
                'status' => '1',
                'createdDate' => date('Y-m-d h:m:s'),
                'photo' => 'swastini.jpg'
            );
            $this->db->insert('users', $data);
            $response['error'] = FALSE;
            $response['value'] = '1';
            $response['message'] = 'User Berhasil ditambahkan';
        }

        echo json_encode($response);
    }
}
