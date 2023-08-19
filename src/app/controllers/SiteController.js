const db = require('../../config/database/databaseConnect');
const {queryDatabase} = require('../../utils/queryDatabase');


const brandList = [
    {name: 'Acer'},
    {name: 'Asus'},
    {name: 'MSI'},
    {name: 'Dell'},
    {name: 'HP'},
    {name: 'Lenovo'},
]

class SiteController {
    //[GET] /
    showHomepage(req, res) {
        db.query('SELECT * FROM laptops', (err, results) => {
            if(err) {
                console.log(err);
            } else {
                let laptopList = results;
                if (req.session.isAuth !== undefined) {
                    if (req.session.role === 'admin') {
                        res.redirect('/admin');
                    } else {
                        res.redirect('/client');
                    }
                } else {
                    res.render('pages/homepage', {
                        isAuth: req.session.isAuth,
                        brandList: brandList,
                        laptopList: laptopList,
                    });
                }
            }
        })
        
    }

    //[GET] /login
    showLoginForm(req, res) {
        res.render('accounts/login', {
            isAuth: req.session.isAuth,
        })
    }

    //[POST] /login
    onLoginHandler(req, res) {
        const {username, password} = req.body;
        db.query('SELECT * FROM users WHERE username = ? and password = ?', [username, password], (err, results) => {
            if (results.length > 0) {
                const user = results[0];
                req.session.isAuth = true;
                req.session.name = user.name;
                req.session.username = user.username;
                req.session._id = user.id;
                req.session.email = user.email;
                if (user.role === 'admin') {
                    req.session.role = 'admin';
                    res.redirect('/');
                } else {
                    req.session.role = 'client';
                    res.redirect('/client');
                }
            } else {
                res.render('accounts/login', {
                    message: 'Tên đăng nhập hoặc mật khẩu không đúng. Xin vui lòng thử lại!',
                });
            }
        })
    }

    //[GET] /logout
    onLogoutHandler(req, res) {
        req.session.destroy(function () {
            res.cookie('connect.sid', '', { maxAge: 1 });
            res.redirect('/');
        });
    }

    //[GET] /register
    showRegisterForm(req, res) {
        res.render('accounts/register', {
            isAuth: req.session.isAuth,
        })
    }

    //[POST] /register
    onRegisterHandler(req, res) {
        const {name, gender, doB, address, email, phone, username, password, confirmPassword} = req.body;
        db.query('SELECT * FROM users WHERE email = ? or username = ?', [email, username], (err, results) => {
            if(err) {
                console.log(err);
            }
            if (results.length > 0) {
                const existUser = results[0];
                let message = '';
                if (email === existUser['email']) {
                    message = 'This email is already in use';
                }
                if (username === existUser['username']) {
                    message = 'This username is already in use';
                }
                if (username === existUser['username'] && email === existUser['email']) {
                    message = 'Username and email are already in use';
                }
                return res.render('accounts/register', {
                    message: message,
                })
            }
            db.query('INSERT INTO users SET ?', {
                name: name,
                gender: gender,
                username: username,
                password: password,
                email: email,
                phone: phone,
                role: 'client',
                address: address,
                doB: doB,
                avatar: 'default.png',
            }, (err, results) => {
                if (err) {
                    console.log(err);
                } else {
                    return res.render('accounts/register', {
                        message: 'Đăng ký thành công!',
                        type: 'successful',
                    })
                }
            })
        });
    }

    //[GET] /reset-password
    showResetPasswordForm(req, res) {
        res.render('accounts/editPassword', {
            isAuth: req.session.isAuth,
            user: {
                name: req.session.name,
                username: req.session.username,
                role: req.session.role,
            },
        })
    }

    //[PUT] /reset-password
    onResetPasswordHandler(req, res) {
        const {password, newPassword} = req.body;
        const username = req.session.username;
        db.query('SELECT * FROM users WHERE username= ? and password= ?', [username, password], (err, results) => {
            if(err) throw err;
                 
            if(results.length > 0) {
                db.query('UPDATE users SET password= ? WHERE username= ?', [newPassword, username], (err, results) => {
                    if(err) throw err;
                    return res.render('accounts/editPassword', {
                        isAuth: req.session.isAuth,
                        user: {
                            name: req.session.name,
                            username: req.session.username,
                            role: req.session.role,
                        },
                        message: 'Đổi mật khẩu thành công!',
                        type: 'successful',
                    })
                })
            } else {
                return res.render('accounts/editPassword', {
                    isAuth: req.session.isAuth,
                    user: {
                        name: req.session.name,
                        username: req.session.username,
                        role: req.session.role,
                    },
                    message: 'Mật khẩu hiện tại không đúng. Xin vui lòng thử lại!',
                })
            }
        })
    }

    //[GET] /user/profile
    async onShowUserProfile (req, res) {
        const editInfoSuccess = req.query['editInfoSuccess'];
        const editInfoMessage = req.query['message'];
        const username = req.session.username;
        const user = await queryDatabase(db, 'SELECT * FROM users WHERE username = ?', [username], (results) => {
            return results[0];
        })
        return res.render('accounts/profile', {
            isAuth: req.session.isAuth,
            user: {
                name: req.session.name,
                username: req.session.username,
                role: req.session.role,
            },
            userInfo: user,
            editInfoSuccess: editInfoSuccess,
            editInfoMessage: editInfoMessage,
        });
    }

    //[PUT] /user/infor/:username
    async onEditUserInfoHandler (req, res) {
        const currentUsername = req.session.username;
        const currentEmail = req.session.email;
        const {name, gender, doB, address, email, phone, username} = req.body;
        let isNewEmailExisted;
        let isNewUsernameExisted;

        if (currentEmail !== email) {
            isNewEmailExisted = await queryDatabase(db, 'SELECT * FROM users WHERE email = ?', [email], (results) => {
                if (results.length > 0) {
                    return true;
                } else {
                    return false;
                }
            })
        }

        if (currentUsername !== username) {
            isNewUsernameExisted = await queryDatabase(db, 'SELECT * FROM users WHERE username = ?', [username], (results) => {
                if (results.length > 0) {
                    return true
                } else {
                    return false
                }
            })
        }

        if (isNewEmailExisted) {
            return res.redirect('/user/profile?editInfoSuccess=false&message=existedEmail');
        } else if (isNewUsernameExisted) {
            return res.redirect('/user/profile?editInfoSuccess=false&message=existedUsername');
        } else {
            db.query('UPDATE users SET name = ?, gender = ?, doB = ?, address = ?, email = ?, phone = ?, username = ? WHERE username = ?', [name, gender, doB, address, email, phone, username, currentUsername], (err, results) => {
                if (err) {
                    console.log(err)
                    return res.redirect('/user/profile?editInfoSuccess=false');
                };
                if (results){
                    req.session.username = username;
                    req.session.email = email;
                    return res.redirect('/user/profile?editInfoSuccess=true')
                };
            })
        }

    }

    //[PUT] /user/change-avatar
    onEditUserAvatarHandler (req, res) {
        let avatarFile;
        let uploadPath;

        if (!req.files || Object.keys(req.files).length === 0) {
            return res.status(400).send('No files were uploaded.');
        }

        // name of the input is avatarFile
        avatarFile = req.files.avatarFile;
        let tempPath = __dirname.toString();
        let srcIndex = tempPath.indexOf('src');
        uploadPath = tempPath.slice(0,srcIndex + 3) + "/public/upload/" + avatarFile.name;
        uploadPath = uploadPath.replace('\\','/');
        // Use mv() to place file on the server
        avatarFile.mv(uploadPath, function (err) {
            if (err) return res.status(500).send(err);
            db.query('UPDATE users SET avatar = ? WHERE username = ?', [avatarFile.name, req.session.username], (err, rows) => {
                if (!err) {
                    res.redirect('/user/profile?editInfoSuccess=true&message=changeAvatarSuccess');
                } else {
                    res.redirect('/user/profile?editInfoSuccess=false&message=changeAvatarFail');
                }
            });
        });
    }
}

module.exports = new SiteController();
