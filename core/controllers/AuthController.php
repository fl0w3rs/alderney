<?php

namespace App\Controllers;

use App\Facades\Auth;

class AuthController extends BaseController {
    public function renderLogin() {
        return $this->render('login.twig');
    }

    public function apiLogin() {
        return responseJson(['access' => Auth::haveAccessToAlderney()]);
    }
}