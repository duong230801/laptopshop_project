const dbConnect = require('./databaseConnect.js');

async function connect() {
    await dbConnect.connect((err) => {
        if(err) {
            console.log(err)
        } else {
            console.log('MySQL connect successfully!!!');
        }
    });
}

module.exports = { connect };