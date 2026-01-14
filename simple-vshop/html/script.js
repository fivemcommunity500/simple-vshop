let selectedVeh = null;
let selectedPrice = 0;

window.addEventListener('message', function(event) {
    let data = event.data;

    if (data.action === "open") {
        $("#app").fadeIn();
        renderStore(data.vehicles, data.categories);
    } else if (data.action === "close") {
        $("#app").fadeOut();
    }
});

function renderStore(vehicles, categories) {
    let list = $("#vehicle-list");
    list.empty();

    // Agrupación por Secciones (Categorías)
    categories.forEach(cat => {
        let filteredVehs = vehicles.filter(v => v.category === cat.name);
        
        if (filteredVehs.length > 0) {
            list.append(`<div class="category-title">${cat.label}</div>`);
            
            filteredVehs.forEach(v => {
                list.append(`
                    <div class="veh-item" data-model="${v.model}" data-price="${v.price}" onclick="select(this)">
                        <span class="name">${v.name}</span>
                        <span class="price">$${v.price.toLocaleString()}</span>
                    </div>
                `);
            });
        }
    });
}

function select(el) {
    $(".veh-item").removeClass("active");
    $(el).addClass("active");

    selectedVeh = $(el).data("model");
    selectedPrice = $(el).data("price");

    $.post('https://simple-vshop/selectVehicle', JSON.stringify({
        model: selectedVeh
    }));
}

function startTest() {
    if (selectedVeh) {
        $.post('https://simple-vshop/testDrive', JSON.stringify({ model: selectedVeh }));
        closeUI(); 
    }
}

function buyVeh() {
    if (selectedVeh) {
        $.post('https://simple-vshop/buyVehicle', JSON.stringify({
            model: selectedVeh,
            price: selectedPrice
        }));
        
    }
}

function closeUI() {
    $.post('https://simple-vshop/close');
}

// Cerrar con la tecla ESC
document.onkeyup = function (data) {
    if (data.which == 27) {
        closeUI();
    }
};