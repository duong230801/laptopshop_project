const mysql = require('mysql');

const dbConnect = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'laptop_shop',
})

module.exports = dbConnect;