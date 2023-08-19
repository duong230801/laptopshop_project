const path = require('path');
const moment = require('moment');
const express = require('express');
const fileUpload = require('express-fileupload');
const handlebars = require('express-handlebars');
const methodOverride = require('method-override');
const route = require('./routes');
const database = require('./config/database');
const session = require('express-session');
const databaseConnect = require('./config/database/databaseConnect');
const MySQLStore = require('express-mysql-session')(session);

//Connect to Database
database.connect();

const sessionStore = new MySQLStore({}, databaseConnect);


const app = express();
const port = 3000;

app.use(fileUpload());
// app.use(express.static(path.join(__dirname, 'upload')));
app.use(express.static(path.join(__dirname, 'public')));
app.use(methodOverride('_method'));
app.use(express.json({ limit: '50mb' }));
app.use(express.urlencoded({ limit: '50mb' }));
app.use(express.json());
app.use(
    session({
        secret: 'cookie_secret',
        resave: false,
        saveUninitialized: false,
        store: sessionStore,
    })
);

app.engine(
    'hbs', 
    handlebars({
        extname: '.hbs',
        helpers: {
            sum: (a, b) => {
                return parseInt(a) + parseInt(b);
            },
            formatTime: function (date, format) {
                var mmnt = moment(date);
                return mmnt.format(format);
            },
            ifCond: (a) => {
                if (a == 'true') {
                    return true;
                }
                return false;
            },
            ifConds: (v1, operator, v2, options) => {
                switch (operator) {
                    case '==':
                        return v1 == v2
                            ? options.fn(this)
                            : options.inverse(this);
                    case '===':
                        return v1 === v2
                            ? options.fn(this)
                            : options.inverse(this);
                    case '!=':
                        return v1 != v2
                            ? options.fn(this)
                            : options.inverse(this);
                    case '!==':
                        return v1 !== v2
                            ? options.fn(this)
                            : options.inverse(this);
                    case '<':
                        return v1 < v2
                            ? options.fn(this)
                            : options.inverse(this);
                    case '<=':
                        console.log(v1, v2);
                        return v1 <= v2
                            ? options.fn(this)
                            : options.inverse(this);
                    case '>':
                        return v1 > v2
                            ? options.fn(this)
                            : options.inverse(this);
                    case '>=':
                        return v1 >= v2
                            ? options.fn(this)
                            : options.inverse(this);
                    case '&&':
                        return v1 && v2
                            ? options.fn(this)
                            : options.inverse(this);
                    case '||':
                        return v1 || v2
                            ? options.fn(this)
                            : options.inverse(this);
                    default:
                        return options.inverse(this);
                }
            },
        },
    })
);

//route init
route(app);

app.set('view engine', 'hbs');
app.set('views', path.join(__dirname, 'resources', 'views'));

const server = require('http').Server(app);

server.listen(port, () =>
    console.log(`App listening at http://localhost:${port}`),
);