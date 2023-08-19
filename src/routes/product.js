const express = require('express');
const router = express.Router();

const productController = require('../app/controllers/ProductController');

router.get('/category/:type', productController.refineProduct)

router.get('/sort-by-price/:sortType', productController.sortProduct)

router.get('/search/:info', productController.seachInfo)

router.get('/brand/:brand', productController.showLaptopByBrandPage)

router.get('/:id', productController.showDetailPage)

module.exports = router;