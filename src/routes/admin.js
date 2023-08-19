const express = require('express');
const router = express.Router();

const adminController = require('../app/controllers/AdminController');

router.put('/order-manager/details/edit-cart-quantity/:orderID/:cartID', adminController.editOrderQuantityHandler)

router.put('/order-manager/details/edit/:id', adminController.editOrderDetailHandler);

router.delete('/order-manager/delete-cart/:id', adminController.deleteCartFromOrderHandler)

router.get('/order-manager/details/:id', adminController.showOrderDetailPage)

router.put('/order-manager/edit-status/:id', adminController.onEditOrderStatusHandler)

router.delete('/order-manager/delete/:id', adminController.onDeleteOrderHandler);

router.get('/order-manager', adminController.showOrderManagerPage);

router.post('/product/add', adminController.onAddProductHandler);

router.get('/product/add', adminController.showAddProductPage);

router.put('/product/edit/:id', adminController.onEditProductHandler);

router.get('/product/edit/:id', adminController.showEditProductPage);

router.delete('/product/delete/:id', adminController.onDeleteProductHandler);

router.get('/product-manager', adminController.showProductManager);

router.get('/product-manager/brand/:brand', adminController.showProductManagerByBrand);

router.get('/add-new-product', adminController.showAddProductForm);

router.get('/', adminController.showHomepage);

module.exports = router;