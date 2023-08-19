const express = require('express');
const router = express.Router();

const clientController = require('../app/controllers/ClientController');

router.get('/my-order/:status', clientController.getClientOrder)

router.post('/create-order', clientController.onCreateOrderHandler);

router.post('/add-to-cart/:id', clientController.onAddProductToCartHandler);

router.post('/cart/edit-quantity/:cartID', clientController.onEditCartQuantityHandler);

router.delete('/cart/delete-item/:cartID', clientController.onDeleteCartItemHandler);

router.get('/cart',  clientController.onShowCartHandler);

router.get('/', clientController.showHomepage);

module.exports = router;