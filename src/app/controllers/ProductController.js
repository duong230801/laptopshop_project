const db = require('../../config/database/databaseConnect.js');
const brandList = [
    {name: 'Acer'},
    {name: 'Asus'},
    {name: 'MSI'},
    {name: 'Dell'},
    {name: 'HP'},
    {name: 'Lenovo'},
]

const renderHomepageWithLaptopList = (req, res, results,) => {
    let laptopListByInfo = results;
    return res.render('pages/homepage', {
        isAuth: req.session.isAuth,
        user: {
            name: req.session.name,
            username: req.session.username,
            role: req.session.role,
        },
        laptopList: laptopListByInfo,
        brandList: brandList,
    });
}

class ProductController {

    //[GET] /product/:id
    showDetailPage(req, res) {
        const { id } = req.params;
        db.query('SELECT * FROM laptops WHERE product_id = ?', [id], (err, results) => {
            if (err) {
                console.log(err);
            } else {
                const laptopInfo = results[0];
                return res.render('pages/infoDetailsPage', {
                    laptopInfo: laptopInfo,
                    isAuth: req.session.isAuth,
                    user: {
                        name: req.session.name,
                        username: req.session.username,
                        role: req.session.role,
                    },
                    message: '',
                })
            }
        })
    }

    //[GET] /product/brand/:manufacturer
    showLaptopByBrandPage(req, res) {
        const {brand} = req.params;
        db.query('SELECT * FROM laptops WHERE brand = ?', [brand], (err, results) => {
            if (err) throw err;
            renderHomepageWithLaptopList(req, res, results);
        });
    }

    //[GET] /product/search/:info
    seachInfo(req, res) {
        const searchInfo = '%'.concat(req.params['info'].concat('%'));
        db.query('SELECT * FROM laptops WHERE name LIKE ?', [searchInfo], (err, results) => {
            if (err) throw err;
            renderHomepageWithLaptopList(req, res, results);
        } )
    }

    //[GET] /product/sort-by-price/:sortType
    sortProduct(req, res) {
        const sortType = req.params['sortType'];
        if (sortType === 'asc') {
            db.query('SELECT * FROM laptops ORDER BY price', (err, results) => {
                if (err) throw err;
                renderHomepageWithLaptopList(req, res, results);
            } )
        } else if (sortType === 'desc') {
            db.query('SELECT * FROM laptops ORDER BY price DESC', (err, results) => {
                if (err) throw err;
                renderHomepageWithLaptopList(req, res, results);
            });
        }
    }

    // [GET] /product/category/:type
    refineProduct(req, res) {
        const filterType = '%'.concat(req.params['type'].concat('%'));
        db.query('SELECT * FROM laptops WHERE status LIKE ?', [filterType], (err, results) => {
            if (err) throw err;
            renderHomepageWithLaptopList(req, res, results);
        } )
  
    }
}

module.exports = new ProductController();