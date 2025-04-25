function add_to_cart(pid, pname, price, pquantity) {
    let cart = localStorage.getItem("cart");
    if (cart == null) {

        //no  cart yet
        let products = [];
        let product = {
            productId: pid,
            productName: pname,
            productQuantity: 1,
            productPrice: price,
            totalQuantity: pquantity
        }
        products.push(product);
        localStorage.setItem("cart", JSON.stringify(products));
        console.log("Product is added for the first time")
    } else {
        //cart is already present
        let pcart = JSON.parse(cart);


        let oldProduct = pcart.find((item) => item.productId == pid)
        console.log(oldProduct)
        if (oldProduct) {
            //we have to increase the quuantity
            oldProduct.productQuantity = oldProduct.productQuantity + 1
            //checking if quantity is more than available quantity
            if (oldProduct.productQuantity > pquantity) {
                alert("Product quantity is more than available quantity")
                oldProduct.productQuantity = oldProduct.productQuantity - 1
            } else {
                pcart.map((item) => {
                    if (item.productId == oldProduct.productId) {
                        item.productQuantity = oldProduct.productQuantity;
                    }
                })
                localStorage.setItem("cart", JSON.stringify(pcart));
            }
        } else {
            //we have add product
            let product = {productId: pid, productName: pname, productQuantity: 1, productPrice: price}
            pcart.push(product)
            localStorage.setItem("cart", JSON.stringify(pcart));
            console.log("Product id added")
        }
    }
    updateCart();
}


//update cart
function updateCart() {
    let cartString = localStorage.getItem("cart");
    let cart = JSON.parse(cartString);

    if (cart == null || cart.length == 0) {
        console.log("Cart is empty");
        $(".cart-items").html("( 0 )");
        $(".cart-body").html("<h3>Cart does not have any items </h3>");
        $(".checkout-btn").attr('disabled', true);
    } else {
        // Có sản phẩm trong giỏ hàng
        console.log(cart);
        $(".cart-items").html(`( ${cart.length} )`);

        let table = `
        <table class='table'>
        <thead class='thead-light'>
        <tr>
            <th>Item Name</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Total Price</th>
            <th>Action</th>
        </tr>
        </thead>`;

        let totalPrice = 0;

        cart.map((item) => {
            let formattedPrice = parseFloat(item.productPrice).toLocaleString('vi-VN', {
                style: 'currency',
                currency: 'VND'
            });
            let formattedTotalPrice = (item.productQuantity * item.productPrice).toLocaleString('vi-VN', {
                style: 'currency',
                currency: 'VND'
            });

            table += `
            <tr>
                <td>${item.productName}</td>
                <td>${formattedPrice}</td>
                <td>
                    ${item.productQuantity}
                    <input type='hidden' name='productId[]' value='${item.productId}'/>
                    <input type='hidden' name='productQuantity[]' value='${item.productQuantity}'/>
                </td>
                <td>${formattedTotalPrice}</td>
                <td>
                    <button onclick="deleteItemFromCart(${item.productId})" class="btn btn-danger btn-sm">Remove</button>
                </td>
            </tr>`;

            totalPrice += item.productPrice * item.productQuantity;
        });

        // Định dạng tổng tiền
        let formattedTotalPrice = totalPrice.toLocaleString('vi-VN', {style: 'currency', currency: 'VND'});

        table += `<tr><td colspan='5' class='text-right font-weight-bold m-5'> Total Price: ${formattedTotalPrice}</td></tr>
        </table>`;

        $(".cart-body").html(table);
        $(".checkout-btn").attr('disabled', false);
    }
}


function deleteItemFromCart(pid) {
    let cart = JSON.parse(localStorage.getItem('cart'));
    let newcart = cart.filter((item) => item.productId != pid);

    localStorage.setItem('cart', JSON.stringify(newcart))
    updateCart();

}

$(document).ready(function () {
    updateCart();
})


function gotoCheckout() {
    window.location = "checkout.jsp"
}










