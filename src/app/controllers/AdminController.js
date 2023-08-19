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

class AdminController {
    // [GET] /admin/
    showHomepage(req, res) {
        db.query('SELECT * FROM laptops', (err, results) => {
            if (err) throw err;
            let laptopList = results;
            res.render('pages/homepage', {
                isAuth: req.session.isAuth,
                brandList: brandList,
                laptopList: laptopList,
                user: {
                    name: req.session.name,
                    username: req.session.username,
                    role: req.session.role,
                },
            });
        });
    }

    // [GET] /admin/add-new-product
    showAddProductForm (req, res) {
        res.render('admin/addProductPage');
    }

    // [GET] /admin/product-manager
    showProductManager (req, res) {
        const editProductSuccess = req.query.success;
        db.query('SELECT * FROM laptops', (err, results) => {
            if (err) throw err;
            let laptopList = results;
            return res.render('admin/productManager', {
                isAuth: req.session.isAuth,
                brandList: brandList,
                laptopList: laptopList,
                editProductSuccess: editProductSuccess,
                user: {
                    name: req.session.name,
                    username: req.session.username,
                    role: req.session.role,
                },
            });
        });
    }
    //[GET] /admin/product-manager/brand/:brand

    showProductManagerByBrand(req, res) {

        const {brand} = req.params;

        db.query('SELECT * FROM laptops WHERE brand = ?', [brand], (err, results) => {

            if (err) throw err;

            let laptopListByInfo = results;

            return res.render('admin/productManager', {

                isAuth: req.session.isAuth,

                brandList: brandList,

                user: {

                    name: req.session.name,

                    username: req.session.username,

                    role: req.session.role,

                },

                laptopList: laptopListByInfo,

            });

        });

    }
    //[GET] /admin/product/edit:id
    showEditProductPage (req, res) {
        const productId = req.params['id'];

        db.query('SELECT * FROM laptops WHERE product_id = ?', [productId], (err, results) => {
            if (err) throw err;
            let product = results[0];
            return res.render('admin/editProductPage', {
                isAuth: req.session.isAuth,
                product: product,
                user: {
                    name: req.session.name,
                    username: req.session.username,
                    role: req.session.role,
                },
            });
        });
    }

    //[PUT] /admin/product/edit/:id
    onEditProductHandler (req, res) {
        const productId = req.params['id'];
        const productNewInfo = req.body;
        productNewInfo['product_id'] = productId;
        db.query('UPDATE laptops SET ? WHERE product_id = ?', [productNewInfo, productId], (err, results) => {
            if (err) {
                return res.redirect('/admin/product-manager?success=false');   
            };
            return res.redirect('/admin/product-manager?success=true');
        })
    }

    //[GET] /admin/product/add
    showAddProductPage (req, res) {
        const addProductSuccess = req.query.success;
        return res.render('admin/addProductPage', {
            addProductSuccess: addProductSuccess,
            isAuth: req.session.isAuth,
            user: {
                name: req.session.name,
                username: req.session.username,
                role: req.session.role,
            },
        })
    }

    //[POST] /admin/product/add
    onAddProductHandler (req, res) {
        const productInfo = req.body;
        db.query('INSERT INTO laptops SET ?', [productInfo], (err, results) => {
            if (err) {
                return res.redirect('/admin/product/add?success=false');   
            };
            return res.redirect('/admin/product/add?success=true');
        })
    }

    //[GET] /admin/order-manager
    async showOrderManagerPage (req, res) {
        const deleteOrderSuccess = req.query['deleteOrderSuccess'];
        const editOrderStatusSuccess = req.query['editOrderStatusSuccess'];
        const orderList = await queryDatabase(db, 'SELECT * FROM order_details', [], (results) => {
            return results;
        })
        return res.render('admin/orderManager',{
            isAuth: req.session.isAuth,
            user: {
                name: req.session.name,
                username: req.session.username,
                role: req.session.role,
            },
            orderList:orderList,
            deleteOrderSuccess: deleteOrderSuccess,
            editOrderStatusSuccess: editOrderStatusSuccess,
        })
    }

    //[DELETE] /admin/order-manager/delete/:id
    async onDeleteOrderHandler (req, res) {
        const orderID = req.params['id'];
        const cartList = await queryDatabase(db, 'SELECT * FROM orders WHERE order_id = ?', [orderID], (results) => {
            return results[0].cart_id.split(',');
        })

        const deleteOrder = await queryDatabase(db, 'DELETE FROM orders WHERE order_id = ?', [orderID], (results) => {
            return results;
        })

        const deleteOrderDetail = await queryDatabase(db, 'DELETE FROM order_details WHERE order_id = ?', [orderID], (results) => {
            return results;
        })

        const deleteCarts = await queryDatabase(db, 'DELETE FROM carts WHERE cart_id IN (?)', [cartList], (results) => {
            return results;
        })

        if (deleteOrder && deleteOrderDetail && deleteCarts) {
            return res.redirect('/admin/order-manager?deleteOrderSuccess=true');
        } else {
            return res.redirect('/admin/order-manager?deleteOrderSuccess=false');

        }
    }

    //[PUT] /admin/order-manager/edit-status/:id
    onEditOrderStatusHandler (req, res) {
        const orderID = req.params['id'];
        const newOrderStatus = req.body['order_status'];
        let orderDate = new Date ();
        orderDate = orderDate.toISOString();
        const isoDate = new Date(orderDate);
        const mySQLDateString = isoDate.toJSON().slice(0, 10).replace('T', ' ');
        let query = '';
        if (newOrderStatus === 'shipping') {
            query = ` ,delivery_date = '${mySQLDateString}'`;
        } else if (newOrderStatus === 'done') {
            query = ` ,receiving_date = '${mySQLDateString}'`;
        }
        db.query(`UPDATE order_details SET order_status = ? ${query} WHERE order_id = ?`, [newOrderStatus, orderID], (err, results) => {
            if (err) {
                console.log(err);
                return res.redirect('/admin/order-manager?editOrderStatusSuccess=false');
            };
            return res.redirect('/admin/order-manager?editOrderStatusSuccess=true');
        })
    }

    //[GET] /admin/order-manager/details/:id
    async showOrderDetailPage (req, res) {
        const orderID = req.params['id'];
        const editOrderSuccess = req.query['editOrderSuccess'];
        let cartIDList = await queryDatabase(db, 'SELECT * FROM orders WHERE order_id = ?', [orderID], (results) => {
            let tempCartList = results[0]['cart_id'].split(',');
            return tempCartList
        })
        
        let cartList = await queryDatabase(db, 'SELECT * FROM carts WHERE cart_id IN (?)', [cartIDList], (results) => {
            return results;
        })

        let orderDetails = await queryDatabase (db, 'SELECT * FROM order_details WHERE order_id = ?', [orderID], (results) => {
            return results[0];
        })

        // return res.json({cartIDList,cartList})
        res.render('admin/orderDetail', {
            isAuth: req.session.isAuth,
            user: {
                name: req.session.name,
                username: req.session.username,
                role: req.session.role,
            },
            orderDetails: orderDetails,
            editOrderSuccess:editOrderSuccess,
            cartList: cartList,
        });
    }

    //[DELETE] /admin/order-manager/delete-cart/:id
    async deleteCartFromOrderHandler (req, res) {
        const orderID = req.params['id'];
        const cartID = req.body['cartID'];
        const orderCartList = await queryDatabase(db, 'SELECT * FROM orders WHERE order_id = ?', [orderID], (results) => {
            return results[0]['cart_id'].split(',');
        })

        if (orderCartList.length === 1) {
            const deleteOrder = await queryDatabase(db, 'DELETE FROM orders WHERE order_id = ?', [orderID], (results) => {
                return results;
            })
            const deleteOrderDetail = await queryDatabase(db, 'DELETE FROM order_details WHERE order_id = ?', [orderID], (results) => {
                return results;
            })
            const deleteCart = await queryDatabase(db, 'DELETE FROM carts WHERE cart_id = ?', [cartID], (results) => {
                return results;
            })
            return res.redirect('/admin/order-manager');
        } else {
            const newOrderCartList = orderCartList.filter(item => item != cartID);
            const updateCartList = await queryDatabase(db, 'UPDATE orders SET cart_id = ? WHERE order_id = ?', [newOrderCartList.toString(), orderID], (results) => {
                return results;
            })
            const newOrderPrice = await queryDatabase(db, 'SELECT * FROM carts WHERE cart_id IN (?)', [newOrderCartList], (results) => {
                let cartList = results;
                let totalPrice = cartList.reduce((totalAmount, cartItem) => {
                    return totalAmount = totalAmount + cartItem.total_amount;
                },0);
                return totalPrice;
            })
            const updateOrderDetails = await queryDatabase(db, 'UPDATE order_details SET price = ? WHERE order_id = ?', [newOrderPrice, orderID], (results) => {
                return results;
            })

            const deleteCart = await queryDatabase(db, 'DELETE FROM carts WHERE cart_id = ?', [cartID], (results) => {
                return results;
            })
    
            return res.redirect('back');
        }
    }

    //[PUT] /admin/order-manager/details/edit/:id
    editOrderDetailHandler (req, res) {
        const orderID = req.params['id'];
        if (req.body['order_date']) {
            let {order_date, delivery_date, receiving_date, order_status, address, phone, note} = req.body;
            const newOrderStatus = req.body['order_status'];
            let orderDate = new Date ();
            orderDate = orderDate.toISOString();
            const isoDate = new Date(orderDate);
            const mySQLDateString = isoDate.toJSON().slice(0, 10).replace('T', ' ');

            if (newOrderStatus === 'shipping') {
                delivery_date = mySQLDateString;
            } else if (newOrderStatus === 'done') {
                receiving_date = mySQLDateString;
            }

            db.query('UPDATE order_details SET order_date = ?, delivery_date = ?, receiving_date = ?, order_status = ?, address = ?, phone = ?, note = ? WHERE order_id = ?', [order_date, delivery_date, receiving_date, order_status, address, phone, note, orderID], (err, results) => {
                if (err) throw err;
                return res.redirect(`/admin/order-manager/details/${orderID}?editOrderSuccess=true`);
            })
        } else {
            return res.redirect('back');
        }
    }

    //[DELETE] /admin/product/delete/:id
    onDeleteProductHandler (req, res) {
        db.query('DELETE FROM laptops WHERE product_id = ?', [req.params['id']], (err, results) => {
            if(err) throw err;
            if(results) return res.redirect('back');
        })
    }

    //[PUT] /admin/order-manager/edit-cart-quantity/:id
    async editOrderQuantityHandler (req, res) {
        const {orderID, cartID} = req.params;
        const {quantity} = req.body;
        const existCart = await queryDatabase(db, 'SELECT * FROM carts WHERE cart_id = ?', [cartID], (results) => {
            return results[0];
        });
        const productPrice = parseInt(existCart['price']);
        const totalAmount = productPrice * quantity;
        const editCart = await queryDatabase(db, 'UPDATE carts SET quantity = ?, total_amount = ? WHERE cart_id = ?', [quantity, totalAmount, cartID], (results) => {
            return results;
        })
        
        const cartList = await queryDatabase(db, 'SELECT * FROM orders WHERE order_id = ?', [orderID], (results) => {
            return results[0].cart_id.split(',');
        });

        const newOrderPrice = await queryDatabase(db, 'SELECT * FROM carts WHERE cart_id IN (?)', [cartList], (results) => {
            let price = results.reduce((price, item) => {
                return price = price + item['total_amount'];
            },0)
            return price;
        })

        const editOrder = await queryDatabase(db, 'UPDATE order_details SET price = ? WHERE order_id = ?', [newOrderPrice, orderID], (results) => {
            return results;
        })

        if (editOrder) {
            return res.redirect(`/admin/order-manager/details/${orderID}?editOrderSuccess=true`);
        } else {
            return res.redirect(`/admin/order-manager/details/${orderID}?editOrderSuccess=false`);
        }
    }
}

module.exports = new AdminController();
