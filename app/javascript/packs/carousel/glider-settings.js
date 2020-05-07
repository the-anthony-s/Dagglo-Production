import "packs/carousel/glider";

window.addEventListener("turbolinks:load", function () {


    if ($(".glider-gallery")[0]) {
        new Glider(document.querySelector('.glider-gallery'), {
            slidesToShow: 1,
            dots: '#GalleryDots',
            draggable: false,
            scrollLock: true,
            arrows: {
                prev: '.glider-prev',
                next: '.glider-next'
            }
        });
    }



    if ($(".glider-categories")[0]) {
        new Glider(document.querySelector('.glider-categories'), {
            // Mobile-first defaults
            slidesToShow: 1.2,
            slidesToScroll: 1,
            scrollLock: true,
            scrollPropagate: true,
            duration: 0.5,
            arrows: {
                prev: '.glider-prev',
                next: '.glider-next'
            },
            responsive: [
                {
                    // screens greater than >= 775px
                    breakpoint: 768,
                    settings: {
                        // Set to `auto` and provide item width to adjust to viewport
                        slidesToShow: 2.2,
                    }
                }, {
                    breakpoint: 992,
                    settings: {
                        slidesToShow: 3.2,
                    }
                }, {
                    // screens greater than >= 1024px
                    breakpoint: 1200,
                    settings: {
                        slidesToShow: 5.1,
                        slidesToScroll: 1,
                    }
                }
            ]
        });
    }


});
