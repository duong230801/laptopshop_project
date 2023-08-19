const db = require('../../config/database/databaseConnect');
const {queryDatabase} = require('../../utils/queryDatabase');

const moment = require('moment');

const brandList = [
    {name: 'Acer'},
    {name: 'Asus'},
    {name: 'MSI'},
    {name: 'Dell'},
    {name: 'HP'},
    {name: 'Lenovo'},
]

class ClientController {
    //[GET] /client/
    showHomepage(req, res) {
        db.query('SELECT * FROM laptops', (err, results) => {
            if(err) throw err;
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

    //[POST] /client/add-to-cart/:product-id
    async onAddProductToCartHandler(req, res) {
        if (!req.session.isAuth) return res.redirect('/login');
        var {price, username, quantity, product_id } = req.body;
        price = parseInt(price);
        quantity = parseInt(quantity);
        let timeID = Date.now();

        const productInfo = await queryDatabase(db, 'SELECT * FROM laptops WHERE product_id = ?', [product_id], (results) => {
            return results[0];
        })

        db.query('SELECT * FROM carts WHERE username = ? AND product_id = ? AND status != ?', [username,product_id,'ordered'], (err, results) => {
            if (err) throw err;
            if(results.length > 0) {
                var existCart = results[0];
                const newQuantity = parseInt(existCart.quantity) + quantity;
                const newTotalAmount = newQuantity * price;
                db.query('UPDATE carts SET quantity = ?, total_amount = ? WHERE username = ? and product_id = ?', [newQuantity, newTotalAmount, username, product_id], (err, results) => {
                    if (err) throw err;
                })
            } else {
                db.query('INSERT INTO carts SET ?', {
                    cart_id: timeID.toString(),
                    username: username,
                    price: price,
                    quantity: quantity,
                    total_amount: price * quantity,
                    product_id: product_id,
                    product_image: productInfo.image,
                    product_name: productInfo.name,
                })
            }
        })

        db.query('SELECT * FROM laptops WHERE product_id = ?', [product_id], (err, results) => {
            if (err) throw err;
            const laptopInfo = results[0];
            return res.render('pages/infoDetailsPage', {
                laptopInfo: laptopInfo,
                isAuth: req.session.isAuth,
                user: {
                    name: req.session.name,
                    username: req.session.username,
                    role: req.session.role,
                },
                message: 'Thêm vào giỏ hàng thành công!',
            })
        })
    }

    //[GET] /client/cart
    onShowCartHandler(req, res) {
        const username = req.session.username;
        let cartIdList;
        db.query('SELECT cart_id FROM orders JOIN order_details ON orders.order_id = order_details.order_id WHERE order_details.username = ?', [username], (err, results) => {
            if (err) throw err;
            let idStringList = '';
            results.forEach((item, index) => {
                if(index !== (results.length - 1)) 
                {
                    idStringList = idStringList.concat(item['cart_id'].concat(','));
                } else {
                    idStringList = idStringList.concat(item['cart_id']);
                }
            })
            cartIdList = idStringList.split(',');
        })
        setTimeout(() => {
            db.query('SELECT * FROM carts JOIN laptops ON carts.product_id = laptops.product_id WHERE carts.username = ?', [username], (err, results) => {
                    if (err) throw err;
                    let cartList = results.filter(item => !cartIdList.includes(item.cart_id));
                    return res.render('client/cart', {
                        cartList: cartList,
                        isAuth: req.session.isAuth,
                        user: {
                            name: req.session.name,
                            username: req.session.username,
                            role: req.session.role,
                        },
                    })
    
            })
        },500)
    }

    //[DELETE] /client/cart/delete-item/:cart-id
    onDeleteCartItemHandler(req, res) {
        const username = req.session.username;
        const {cartID} = req.params;
        db.query('DELETE FROM carts WHERE cart_id = ? AND username = ?', [cartID, username], (err, results) => {
            if (err) throw err;
            return res.redirect('back');
        })
    }

    //[POST] /client/cart/edit-quantity/:cartID
    async onEditCartQuantityHandler(req, res) {
        const username = req.session.username;
        const {cartID} = req.params;
        const {quantity} = req.body;
        const existCart = await queryDatabase(db, 'SELECT * FROM carts WHERE cart_id = ?', [cartID], (results) => {
            return results[0];
        })
        const productPrice = parseInt(existCart['price']);
        const totalAmount = productPrice * quantity;
        db.query('UPDATE carts SET quantity = ?, total_amount = ? WHERE username = ? and cart_id = ?', [quantity, totalAmount, username, cartID], (err, results) => {
            if (err) throw err;
            res.redirect('/client/cart');
        })
    }

    //[POST] /client/create-order/
    async onCreateOrderHandler(req, res) {
        let cartID = req.body['cart-id'];
        let cartNote = req.body['note'];
        let orderID = Date.now();
        let orderDate = new Date ();
        orderDate = orderDate.toISOString();
        const isoDate = new Date(orderDate);
        const mySQLDateString = isoDate.toJSON().slice(0, 19).replace('T', ' ');

        let order = {
            order_id: orderID,
            order_date: mySQLDateString,
            note: req.body['note'] ? req.body['note'] : '',
            order_status: 'waiting',
            username: req.session.username,
        };

        order.price = await queryDatabase(db,'SELECT * FROM carts WHERE cart_id IN (?)',[cartID], (results) => {
            let cartList = results;
            let totalPrice = cartList.reduce((totalAmount, cartItem) => {
                return totalAmount = totalAmount + cartItem.total_amount;
            },0);
            return totalPrice;
        })
        
        db.query('INSERT INTO orders SET ?', {
            order_id: orderID,
            cart_id: cartID.toString(),
        })

        db.query('SELECT * FROM users WHERE username = ?', [req.session.username], (err, results) => {
            if (err) throw err;
            let user = results[0];
            order.name = user.name;
            order.phone = user.phone;
            order.address = user.address;
        })

        db.query('UPDATE carts SET status = ? WHERE username = ? and cart_id IN (?)', ['ordered', req.session.username, cartID], (err, results) => {
            if (err) throw err;
        })

        setTimeout(() => {
            db.query('INSERT INTO order_details SET ?', order);
            return res.redirect('back');
        }, 200)
    }

    //[GET] /client/my-order/:status
    async getClientOrder (req, res) {
        // const status = req.params['status'];
        //get user order
        let orderIDList = await queryDatabase(db, 'SELECT * FROM order_details WHERE username = ?', [req.session.username], (results) => {
            let output = [];
            results.forEach(item => {
                output.push(item.order_id)
            });
            return output;
        })

        if (orderIDList.length !== 0) {
            //create object order contain order_id, cart_id, cart_item
            let [orderObjectList, cartIDList] = await queryDatabase(db, 'SELECT * FROM orders JOIN order_details ON orders.order_id = order_details.order_id WHERE orders.order_id IN (?)',[orderIDList], (results) => {
                let orderObjectList = [];
                orderObjectList = results;
                orderObjectList = orderObjectList.map(item => ({
                    order_id: item.order_id,
                    order_status: item.order_status,
                    order_price: item.price,
                    cart_id: item.cart_id.split(','),
                    cart_items: [],
                }))
    
                let tempCartIDList = '';
                results.forEach((item, index) => {
                    if (index !== (results.length -1)) {
                        tempCartIDList = tempCartIDList.concat(item.cart_id, ',');
                    } else {
                        tempCartIDList = tempCartIDList.concat(item.cart_id);
                    }
                })
                let cartIDList = tempCartIDList.split(',');
                return [orderObjectList, cartIDList];
            })
            db.query('SELECT * FROM carts WHERE username = ?', [req.session.username], (err, results) => {
                if (err) throw err;
                results.forEach((item) => {
                    orderObjectList.forEach((order) => {
                        if (order.cart_id.includes(item.cart_id)) {
                            order['cart_items'].push(item);
                            order['numOfCart'] = order['cart_items'].length;
                        }
                    })
                })
                res.render('client/order', {
                    orderObjectList: orderObjectList,
                    isAuth: req.session.isAuth,
                    user: {
                        name: req.session.name,
                        username: req.session.username,
                        role: req.session.role,
                    },
                })
            })
        } else {
            res.render('client/emptyOrderList', {
                isAuth: req.session.isAuth,
                user: {
                    name: req.session.name,
                    username: req.session.username,
                    role: req.session.role,
                },
            });
        }

    }
}
module.exports = new ClientController();
