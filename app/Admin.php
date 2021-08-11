<?php

namespace App;

use Illuminate\Foundation\Auth\User as Authenticatable;

//Trait for sending notifications in laravel
use Illuminate\Notifications\Notifiable;

//Notification for Admin
use App\Notifications\AdminResetPasswordNotification;

class Admin extends Authenticatable
{

    // This trait has notify() method defined
    use Notifiable;

    //Mass assignable attributes
    protected $fillable = [
      'name', 'email', 'password',
    ];

    //hidden attributes
    protected $hidden = [
       'password', 'remember_token',
    ];

    //Send password reset notification
    public function sendPasswordResetNotification($token)
    {
      $this->notify(new AdminResetPasswordNotification($token));
    }

}

