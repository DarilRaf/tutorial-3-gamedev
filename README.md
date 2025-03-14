## Latihan Mandiri - Tutorial 3

Dalam pengerjaan tutorial 3, saya mengimplementasikan beberapa fitur tambahan selain yang wajib diimplementasikan (dash, double jump, crouch), 
yaitu fitur animasi pada sprite karakter menggunakan node "AnimatedSprite2D" menggunakan aset tileset yang sudah disediakan. Kemudian, saya menambahkan 4 jenis animasi
yaitu idle, running, crouching, dan jump dimana masing-masing tersebut akan diplay sesuai dengan pergerakan dari karakter dalam game. Sprite dari karakter juga akan sesuai dengan
arah pergerakan karakter dengan memanfaatkan properti "flip_h" pada node AnimatedSprite2D.

Untuk implementasi dash, double jump, dan crouch, saya memanipulasi kecepatan dari karakter, dan mengecek apakah input baru saja ditekan menggunakan node Timer. Referensi saya dapatkan dari
dokumentasi godot dan bertanya-tanya dengan ChatGPT.


## Latihan Mandiri - Tutorial 5

Dalam pengerjaan tutorial 5, saya menambahkan karakter baru berupa entitas Enemy yang bergerak ke kiri dan ke kanan secara looping, dan juga memberikannya animasi. Apabila player menyentuh
Enemy tersebut, maka akan muncul SFX dan kemudian player akan terjatuh dan scene akan reload.

Saya juga menambahkan background music yang dimainkan secara looping.
