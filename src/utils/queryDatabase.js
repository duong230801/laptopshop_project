module.exports = {
    queryDatabase : async function (db, query, conditionArray, callback) {
        return new Promise((resolve, reject) => {
            db.query(query, conditionArray, async (err, results) => {
                if (err) reject (err);
                let finalResult = await callback(results);
                resolve(finalResult);
            });
        })       
    }
}