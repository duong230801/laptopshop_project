const express = require('express');
const router = express.Router();

const siteController = require('../app/controllers/SiteController');

router.put('/user/change-avatar', siteController.onEditUserAvatarHandler)

router.put('/user/infor/:username', siteController.onEditUserInfoHandler);

router.get('/user/profile', siteController.onShowUserProfile);

router.put('/reset-password', siteController.onResetPasswordHandler);

router.get('/reset-password', siteController.showResetPasswordForm);

router.post('/register', siteController.onRegisterHandler);

router.get('/register', siteController.showRegisterForm);

router.get('/logout', siteController.onLogoutHandler);

router.post('/login', siteController.onLoginHandler);

router.get('/login', siteController.showLoginForm);

router.get('/', siteController.showHomepage);

module.exports = router;
