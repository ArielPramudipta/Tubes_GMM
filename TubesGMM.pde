int scene = 1; // Menggunakan variabel untuk mengontrol scene
float posX;
float walkCycle = 0; // Menyimpan siklus berjalan
boolean lyingDown = false;
boolean sitting = false;
int lyingStartTime = 0;
int sittingStartTime = 0;
int phase = 0; // Menggunakan fase untuk mengontrol tindakan karakter

// Variabel untuk burung
int numBirds = 5;
float[] birdX = new float[numBirds];
float[] birdY = new float[numBirds];
float[] birdSpeed = new float[numBirds];

void setup() {
  size(800, 600); // Perbesar ukuran kanvas
  posX = width; // Memulai gambar dari sisi kanan

  // Inisialisasi posisi dan kecepatan burung
  for (int i = 0; i < numBirds; i++) {
    birdX[i] = random(width);
    birdY[i] = random(100, 300);
    birdSpeed[i] = random(0.5, 2); // Kecepatan acak antara 0.5 dan 2
  }
}

void draw() {
  if (scene == 1) {
    drawFirstScene();
  } else if (scene == 2) {
    drawSecondScene();
  } else if (scene == 3) {
    drawThirdScene();
  } else if (scene == 4) {
    drawFourthScene();
  } else if (scene == 5) {
    drawFifthScene();
  } else if (scene == 6) {
    drawSixthScene();
  }
  
  // Memperbarui posisi horizontal hanya jika gambar belum mencapai tepi kiri
  if (!lyingDown && !sitting && posX > 0) {
    posX -= 2;
  }

  // Memperbarui siklus berjalan
  walkCycle += 0.1;
  if (walkCycle > TWO_PI) {
    walkCycle -= TWO_PI;
  }
}

void drawFirstScene() {
  background(220); // Warna abu-abu muda untuk kamar kost
  
  // Menggambar kamar kost
  drawRoom();
  
  // Menggambar meja belajar
  drawDesk(150, 300);
  
  // Menggambar tempat tidur
  drawBed(600, 300);
  
  if (phase == 0 && posX <= 650 && posX >= 600) {
    lyingDown = true;
    lyingStartTime = millis();
    phase = 1;
  }

  if (phase == 1 && millis() - lyingStartTime >= 7000) { // 7000 ms = 7 detik
    lyingDown = false;
    posX = 650; // Set posisi ke tempat tidur sebelum lanjut berjalan
    phase = 2;
  }
  
  if (phase == 2 && posX <= 180 && posX >= 150) {
    sitting = true;
    sittingStartTime = millis();
    phase = 3;
  }

  if (phase == 3 && millis() - sittingStartTime >= 7000) { // 7000 ms = 7 detik
    sitting = false;
    posX = 180; // Set posisi ke kursi sebelum lanjut berjalan
    phase = 4;
  }

  if (lyingDown) {
    drawHumanLying(630, 350);
  } else if (sitting) {
    drawHumanSitting(225, 400); // Disesuaikan posisi duduk
  } else {
    // Menggambar manusia
    if (phase < 2 && posX > 600) {
      drawHuman(posX, 500, walkCycle);
    } else if (phase == 2) {
      drawHuman(posX, 300, walkCycle);
    } else {
      drawHuman(posX, 500, walkCycle);
    }
  }
  
  // Pindah ke scene kedua setelah gambar mencapai tepi kiri
  if (posX <= 0 && phase == 4) {
    scene = 2;
    posX = width; // Reset posisi manusia ke sisi kanan
    phase = 0; // Reset fase untuk scene berikutnya
  }
}

void drawSecondScene() {
  background(135, 206, 235); // Warna langit biru muda untuk halaman luar kost
  
  // Menggambar rumput
  fill(34, 139, 34);
  rect(0, 400, width, 150);
  
  // Menggambar jalan
  drawRoad();
  
  // Menggambar lampu taman
  drawLampuTaman(100, 400);
  drawLampuTaman(300, 400);
  drawLampuTaman(500, 400);
  drawLampuTaman(700, 400);
  
  // Menggambar tanaman
  drawPlant(50, 400);
  drawPlant(200, 400);
  drawPlant(350, 400);
  drawPlant(500, 400);
  drawPlant(650, 400);
  
  // Menggambar manusia berjalan keluar dari kamar kost
  drawHuman(posX, 550, walkCycle);
  
  // Pindah ke scene ketiga setelah gambar mencapai tepi kiri
  if (posX <= 0) {
    scene = 3;
    posX = width; // Reset posisi manusia ke sisi kanan
  }
}

void drawThirdScene() {
  background(135, 206, 235); // Warna langit biru muda
  drawBG_Langit();
  candi(); // Menggambar Candi baru

  // Menggambar jalan
  drawRoad();
  
  // Menggambar manusia
  drawHuman(posX, 550, walkCycle);
  
  // Pindah ke scene keempat setelah gambar mencapai tepi kiri
  if (posX <= 0) {
    scene = 4;
    posX = width; // Reset posisi manusia ke sisi kanan
  }
}

void drawFourthScene() {
  background(135, 206, 235); // Warna langit biru muda
  
  // Gambar langit
  drawSky();
  
  // Menggambar perbukitan
  drawHills();
  
  // Menggambar burung terbang
  drawBirds();
  
  // Menggambar jalan
  drawRoad();
  
  // Menggambar manusia
  drawHuman(posX, 550, walkCycle);
  
  // Pindah ke scene kelima setelah gambar mencapai tepi kiri
  if (posX <= 0) {
    scene = 5;
    posX = width; // Reset posisi manusia ke sisi kanan
  }
}

void drawFifthScene() {
  background(255); // Warna putih untuk latar belakang
  
  // Gambar langit
  drawSky();
  
  // Menggambar Monumen Nasional Indonesia (Monas)
  drawMonas(400, 450);
  
  // Menggambar jalan
  drawRoad();
  
  // Menggambar manusia
  drawHuman(posX, 550, walkCycle);
  
  // Pindah ke scene keenam setelah gambar mencapai tepi kiri
  if (posX <= 0) {
    scene = 6;
    posX = width; // Reset posisi manusia ke sisi kanan
  }
}

void drawSixthScene() {
  background(135, 206, 235); // Warna langit biru muda

  // Menggambar laut
  drawSea();
  
  // Menggambar pantai
  drawBeach();
  
  // Menggambar matahari
  drawSun(700, 100, 80);
  
  // Menggambar jalan
  drawRoad();
  
  // Menggambar manusia
  drawHuman(posX, 550, walkCycle);
  
  // Reset posisi manusia jika mencapai tepi kiri di scene terakhir
  if (posX <= 0) {
    posX = width; // Reset posisi manusia ke sisi kanan
  }
}

void drawBG_Langit() {
  pushMatrix();
  fill(135, 206, 235); // Warna biru cerah untuk langit
  rect(0, 0, 1600, 900);
  popMatrix();
  
  noStroke();
  fill(41, 150, 0); // Warna hijau untuk rumput
  rect(0, 600, 1600, 300);
  
  pushMatrix();
  translate(0, -300);
  matahari();
  popMatrix();
}

void matahari() {
  // Gambar matahari
  noStroke();
  fill(255, 204, 0); // Warna kuning terang
  ellipse(1400, 200, 100, 100); // Posisi dan ukuran matahari
}

void candi() {
  float offsetX = width / 2 - 300; // Mengatur offset horizontal
  float offsetY = height / 2 - 300; // Mengatur offset vertikal
  bagianBelakang(offsetX, offsetY);
  bagianDepan(offsetX, offsetY);
}

public void bagianDepan(float offsetX, float offsetY) {    
 stroke(92, 95, 88);
  fill(92, 95, 88);
  rect(220 + offsetX, 480 + offsetY, 160, 80);
  
  stroke(147, 150, 143);
  fill(147, 150, 143);
  rect(240 + offsetX, 515 + offsetY, 20, 30);
  rect(290 + offsetX, 515 + offsetY, 20, 30);
  rect(340 + offsetX, 515 + offsetY, 20, 30);
  
  strokeWeight(20);    
  stroke(111, 113, 108);
  line(210 + offsetX, 495 + offsetY, 390 + offsetX, 495 + offsetY);
      
  stroke(123, 125, 120);
  line(220 + offsetX, 475 + offsetY, 380 + offsetX, 475 + offsetY);
    
  strokeWeight(10); 
  stroke(123, 125, 120);
  line(210 + offsetX, 560 + offsetY, 390 + offsetX, 560 + offsetY);
      
  stroke(138, 140, 135);
  line(215 + offsetX, 570 + offsetY, 385 + offsetX, 570 + offsetY);
    
  stroke(122, 124, 119);
  line(220 + offsetX, 580 + offsetY, 380 + offsetX, 580 + offsetY);
      
  stroke(137, 139, 134);
  line(225 + offsetX, 590 + offsetY, 375 + offsetX, 590 + offsetX);
}

public void bagianBelakang(float offsetX, float offsetY) {
   stroke(104, 106, 101);
  strokeWeight(21);
  line(70 + offsetX, 580 + offsetY, 530 + offsetX, 580 + offsetY);
    
  strokeWeight(11);
  stroke(108, 110, 105);
  fill(108, 110, 105);
  rect(125 + offsetX, 500 + offsetY, 350, 65);
  
  stroke(147, 150, 143);
  fill(147, 150, 143);
  rect(140 + offsetX, 530 + offsetY, 20, 30);
  rect(175 + offsetX, 530 + offsetY, 20, 30);
  rect(405 + offsetX, 530 + offsetY, 20, 30);
  rect(440 + offsetX, 530 + offsetY, 20, 30);
  
  strokeWeight(31);
  stroke(123, 125, 120);
  line(100 + offsetX, 500 + offsetY, 500 + offsetX, 500 + offsetY);
    
  strokeWeight(21);
  stroke(141, 144, 137);
  line(110 + offsetX, 475 + offsetY, 490 + offsetX, 475 + offsetY);
  
  stroke(183, 183, 183);
  strokeWeight(21);
  line(120 + offsetX, 455 + offsetY, 480 + offsetX, 455 + offsetY);
  
  strokeWeight(11);
  stroke(137, 139, 134);
  rect(140 + offsetX, 430 + offsetY, 320, 10);
  
  stroke(110, 112, 107);
  fill(110, 112, 107);
  rect(140 + offsetX, 390 + offsetY, 320, 30);
  
  stroke(142, 144, 139);
  fill(142, 144, 139);
  rect(160 + offsetX, 340 + offsetY, 280, 40);
  
  strokeWeight(21);
  stroke(110, 112, 107);
  line(150 + offsetX, 340 + offsetY, 450 + offsetX, 340 + offsetY);
  stroke(129, 131, 126);
  line(160 + offsetX, 320 + offsetY, 440 + offsetX, 320 + offsetY);
  
  stroke(110, 112, 107);
  line(170 + offsetX, 300 + offsetY, 430 + offsetX, 300 + offsetY);
  
  stroke(138, 140, 135);
  line(185 + offsetX, 280 + offsetY, 415 + offsetX, 280 + offsetY);
  
  strokeWeight(11);
  stroke(110, 112, 107);
  fill(110, 112, 107);
  rect(200 + offsetX, 235 + offsetY, 200, 30);
  
  stroke(138, 140, 135);
  fill(138, 140, 135);
  rect(200 + offsetX, 215 + offsetY, 200, 20);
   
  stroke(179, 181, 178);
  line(190 + offsetX, 210 + offsetY, 410 + offsetX, 210 + offsetY);
  
  stroke(158, 160, 157);
  line(220 + offsetX, 200 + offsetY, 380 + offsetX, 200 + offsetY);
  
  stroke(183, 183, 183);
  fill(183, 183, 183);
  rect(240 + offsetX, 170 + offsetY, 120, 20);
  
  stroke(206, 209, 202);
  fill(206, 209, 202);
  rect(260 + offsetX, 140 + offsetY, 80, 20);
  
  stroke(142, 144, 139);
  fill(142, 144, 139);
  rect(280 + offsetX, 110 + offsetY, 40, 20);
}

void drawSky() {
  noStroke();
  // Warna gradasi untuk langit biru
  for (int i = 0; i < height; i++) {
    stroke(0, 191, 255, map(i, 0, height, 255, 0)); // Gradasi dari biru terang ke biru tua
    line(0, i, width, i);
  }
}

void drawHills() {
  noStroke();
  fill(34, 139, 34); // Warna hijau untuk perbukitan
  beginShape();
  vertex(0, height);
  vertex(0, height - 100);
  bezierVertex(width / 4, height - 200, 3 * width / 4, height - 200, width, height - 100);
  vertex(width, height);
  endShape(CLOSE);
}

void drawBirds() {
  for (int i = 0; i < numBirds; i++) {
    drawBird(birdX[i], birdY[i]);
    birdX[i] += birdSpeed[i]; // Memperbarui posisi burung berdasarkan kecepatannya
    
    // Reset posisi burung jika keluar dari layar
    if (birdX[i] > width) {
      birdX[i] = 0;
      birdY[i] = random(100, 300);
      birdSpeed[i] = random(0.5, 2);
    }
  }
}

void drawBird(float x, float y) {
  noStroke();
  fill(0); // Warna hitam untuk tubuh burung
  
  // Menggambar sayap kiri
  beginShape();
  vertex(x, y);
  bezierVertex(x - 15, y - 10, x - 30, y - 20, x - 45, y - 10);
  endShape();
  
  // Menggambar sayap kanan
  beginShape();
  vertex(x, y);
  bezierVertex(x + 15, y - 10, x + 30, y - 20, x + 45, y - 10);
  endShape();
  
  // Menggambar tubuh burung
  ellipse(x, y, 20, 10);
  
  // Menggambar paruh burung
  fill(255, 165, 0); // Warna oranye untuk paruh
  triangle(x + 10, y, x + 15, y - 3, x + 15, y + 3);
}

void drawMonas(float x, float y) {
  noStroke();
  // Menggambar Monas (Monumen Nasional) lebih besar
  fill(255, 215, 0); // Warna emas untuk puncak Monas
  triangle(x - 40, y - 240, x + 40, y - 240, x, y - 320); // Memperbesar ukuran puncak
  fill(255, 255, 255); // Warna putih untuk badan Monas
  rect(x - 20, y - 240, 40, 200); // Memperbesar badan Monas
  fill(169, 169, 169); // Warna abu-abu untuk landasan Monas
  rect(x - 60, y - 40, 120, 40); // Memperbesar landasan Monas
}

void drawSea() {
  noStroke();
  fill(0, 105, 148); // Warna biru laut
  rect(0, height / 2, width, height / 2); // Menggambar laut setengah dari bawah kanvas
}

void drawBeach() {
  noStroke();
  fill(194, 178, 128); // Warna pasir pantai
  beginShape();
  vertex(0, height / 2); // Mulai dari titik kiri tengah
  vertex(width / 4, height / 2 + 50); 
  vertex(width / 2, height / 2 - 20); 
  vertex(3 * width / 4, height / 2 + 30); 
  vertex(width, height / 2); // Selesai di titik kanan tengah
  vertex(width, height); // Bawah kanan
  vertex(0, height); // Bawah kiri
  endShape(CLOSE);
}

void drawSun(float x, float y, float diameter) {
  noStroke();
  fill(255, 223, 0); // Warna kuning matahari
  ellipse(x, y, diameter, diameter); // Menggambar matahari
}

void drawRoad() {
  noStroke();
  fill(105, 105, 105); // Warna abu-abu gelap untuk jalan
  rect(0, 500, width, 100); // Menggambar jalan di bagian bawah kanvas
  stroke(255);
  for (int i = 0; i < width; i += 40) {
    line(i, 550, i + 20, 550); // Garis putus-putus putih di tengah jalan
  }
}

void drawHuman(float x, float y, float walkCycle) {
  float scale = 4.5; // Skala untuk memperbesar ukuran manusia
  
  pushMatrix();
  translate(x, 550); // Mengatur posisi manusia agar selalu berada di jalan
  scale(scale); // Memperbesar ukuran manusia
  
  noStroke();
  
  // Menggambar kepala
  fill(255, 224, 189); // Warna kulit untuk kepala
  ellipse(0, -30, 10, 10); // Kepala
  
  // Menggambar tubuh
  fill(168, 62, 50); // Warna hijau untuk baju
  rect(-5, -25, 10, 15); // Tubuh
  
  // Menggambar lengan kiri
  pushMatrix();
  fill(255, 224, 189); 
  translate(-5, -20);
  rotate(sin(walkCycle) * QUARTER_PI / 2);
  rect(-1, 0, 2, 10); // Lengan kiri
  popMatrix();
  
  // Menggambar lengan kanan
  pushMatrix();
  translate(5, -20);
  rotate(-sin(walkCycle) * QUARTER_PI / 2);
  rect(-1, 0, 2, 10); // Lengan kanan
  popMatrix();
  
  // Menggambar kaki kiri
  pushMatrix();
  fill(0,0,0);
  translate(-2.5, -10);
  rotate(-sin(walkCycle) * QUARTER_PI / 2);
  rect(-1, 0, 2, 15); // Kaki kiri
  popMatrix();
  
  // Menggambar kaki kanan
  pushMatrix();
  translate(2.5, -10);
  rotate(sin(walkCycle) * QUARTER_PI / 2);
  rect(-1, 0, 2, 15); // Kaki kanan
  popMatrix();
  
  popMatrix();
}

void drawHumanLying(float x, float y) {
  float scale = 4.5; // Skala untuk memperbesar ukuran manusia
  
  pushMatrix();
  translate(x, y);
  scale(scale); // Memperbesar ukuran manusia
  rotate(HALF_PI); // Putar karakter 90 derajat untuk posisi horizontal
  
  noStroke();
  
  // Menggambar kepala
  fill(255, 224, 189); // Warna kulit untuk kepala
  ellipse(0, -5, 10, 10); // Kepala
  
  // Menggambar tubuh
  fill(168, 62, 50); // Warna hijau untuk baju
  rect(-5, 0, 10, 15); // Tubuh
  
  // Menggambar lengan kiri
  fill(255, 224, 189); 
  rect(-5, 0, 2, 10); // Lengan kiri
  
  // Menggambar lengan kanan
  rect(3, 0, 2, 10); // Lengan kanan
  
  // Menggambar kaki kiri
  fill(0, 0, 0);
  rect(-5, 15, 2, 15); // Kaki kiri
  
  // Menggambar kaki kanan
  rect(3, 15, 2, 15); // Kaki kanan
  
  popMatrix();
}

void drawHumanSitting(float x, float y) {
  float scale = 4.5; // Skala untuk memperbesar ukuran manusia
  
  pushMatrix();
  translate(x, y);
  scale(scale); // Memperbesar ukuran manusia
  
  noStroke();
  
  // Menggambar kepala
  fill(255, 224, 189); // Warna kulit untuk kepala
  ellipse(0, -30, 10, 10); // Kepala
  
  // Menggambar tubuh
  fill(168, 62, 50); // Warna hijau untuk baju
  rect(-5, -25, 10, 15); // Tubuh
  
  // Menggambar lengan kiri
  fill(255, 224, 189); 
  rect(-5, -20, 2, 10); // Lengan kiri
  
  // Menggambar lengan kanan
  rect(3, -20, 2, 10); // Lengan kanan
  
  // Menggambar kaki kiri
  fill(0, 0, 0);
  rect(-5, -10, 2, 15); // Kaki kiri
  
  // Menggambar kaki kanan
  rect(3, -10, 2, 15); // Kaki kanan
  
  popMatrix();
}

void drawRoom() {
  fill(180); // Warna abu-abu untuk dinding
  rect(50, 50, 700, 500); // Menggambar dinding kamar kost
  
  fill(255,255,255); // Warna abu-abu muda untuk lantai
  rect(50, 450, 700, 100); // Menggambar lantai kamar kost
  
  fill(161, 112, 63); // Warna abu-abu tua untuk pintu
  rect(50, 200, 100, 250); // Menggambar pintu
  
  fill(255); // Warna putih untuk jendela
  rect(550, 150, 150, 100); // Menggambar jendela
  fill(135, 206, 250); // Warna biru langit untuk bagian terbuka jendela
  rect(555, 155, 140, 90); // Menggambar bagian terbuka jendela
  
  fill(255, 0, 0); // Warna merah untuk poster
  rect(200, 100, 100, 150); // Menggambar poster
}

void drawDesk(float x, float y) {
  // Menggambar meja
  fill(150, 75, 0); // Warna coklat kayu untuk meja
  rect(x, y, 200, 10); // Bagian atas meja
  
  // Kaki-kaki meja
  rect(x, y + 10, 10, 80); // Kaki kiri depan
  rect(x + 190, y + 10, 10, 80); // Kaki kanan depan
  rect(x, y + 10, 10, 80); // Kaki kiri belakang
  rect(x + 190, y + 10, 10, 80); // Kaki kanan belakang

  // Menggambar kursi
  fill(139, 69, 19); // Warna coklat lebih gelap untuk kursi
  rect(x + 50, y + 60, 40, 40); // Tempat duduk kursi
  
  // Kaki-kaki kursi
  rect(x + 50, y + 100, 5, 20); // Kaki kiri depan
  rect(x + 85, y + 100, 5, 20); // Kaki kanan depan
  rect(x + 50, y + 100, 5, 20); // Kaki kiri belakang
  rect(x + 85, y + 100, 5, 20); // Kaki kanan belakang
  
  // Sandaran punggung kursi
  rect(x + 50, y + 30, 40, 30); // Sandaran punggung kursi
}

void drawBed(float x, float y) {
  fill(245, 61, 61); // Warna merah untuk tempat tidur
  rect(x, y, 150, 100); // Menggambar tempat tidur
  fill(215, 237, 88); // Warna abu-abu untuk bantal
  rect(x + 20, y + 20, 50, 30); // Menggambar bantal
}

// Fungsi untuk menggambar lampu taman
void drawLampuTaman(float x, float y) {
  fill(50); // Warna hitam untuk tiang lampu
  rect(x, y - 50, 5, 50); // Tiang lampu
  fill(255, 255, 0); // Warna kuning untuk cahaya lampu
  ellipse(x + 2.5, y - 55, 20, 20); // Cahaya lampuS
}

// Fungsi untuk menggambar tanaman
void drawPlant(float x, float y) {
  fill(34, 139, 34); // Warna hijau untuk daun
  ellipse(x, y, 30, 50); // Daun kiri
  ellipse(x + 20, y, 30, 50); // Daun kanan
  fill(139, 69, 19); // Warna coklat untuk batang
  rect(x + 10, y + 25, 10, 20); // Batang
}
