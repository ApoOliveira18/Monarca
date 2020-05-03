// -------------- Check password Strenght -------------- // CRchibeni

        function passStr() {
            senha = document.getElementById("senha").value;
            forca = 0;
            corforca = document.getElementById("senha");
            if (senha.length <= 7) {
                forca += -200;
            } else
            if (senha.match(/[a-z]+/)) { // LETRAS MINUSCULAS
                forca += 20;
            }
            if (senha.match(/[A-Z]+/)) { // LETRAS MAIUSCULAS
                forca += 20;
            }
            if (senha.match(/\d/)) { // NUMEROS
                forca += 20;
            }
            if (senha.match(/\W+/)) { // CARACTERES ESPECIAIS
                forca += 20;
            }
            if ((forca > 60) && (senha.length >= 20)) {
                forca += 200;
            }
            return mostra_res();
        }
        function mostra_res() {
            if (forca <= 40) {
                corforca.style.borderBottomColor = "red";
            } else if ((forca > 40) && (forca <= 60)) {
                corforca.style.borderBottomColor = "#FFBC00";
            } else if ((forca > 60) && (forca <= 200)) {
                corforca.style.borderBottomColor = "green";
            } else if (forca > 200) {
                corforca.style.borderBottomColor = "blue";
            }
        }