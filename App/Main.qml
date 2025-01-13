// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only
import QtQuick
import QtQuick.Controls

ApplicationWindow{
    title: qsTr("GameSelect")
    width: 1920
    height: 1080
    visible: true
    property bool itemsEnabled: true

    function makeQuery() {
        let query = "MATCH (g:Game) ";
        query += "WHERE g.Price >= "+Math.round(sliderPrecio.first.value)+" AND g.Price <= "+Math.round(sliderPrecio.second.value)+"\n"
        query += "AND g.`Required age` >= "+Math.round(sliderEdad.first.value)+" AND g.`Required age` <= "+Math.round(sliderEdad.second.value)+"\n"
        query += "AND g.Positive >= 50 AND g.Negative >= 50\n"

        query += "AND ("
            for(let i = Math.round(sliderAnios.first.value); i <= sliderAnios.second.value; i++){
                query+= "g.`Release date` CONTAINS '"+i+"' "
                if (i !== sliderAnios.second.value){
                    query+="OR "
                }else{
                    query+=")\n"
                }
            }

            if (j_unJugador.checked){
                query += "AND toLower(g.Tags) CONTAINS 'singleplayer'\n"
            }else if (j_multijugador.checked){
                query += "AND toLower(g.Tags) CONTAINS 'multiplayer'\n"
            }

            if (accion.checked){
                query += "AND toLower(g.Genres) CONTAINS 'action'\n"
            }
            if (aventura.checked){
                query += "AND toLower(g.Genres) CONTAINS 'adventure'\n"
            }
            if (rpg.checked){
                query += "AND toLower(g.Genres) CONTAINS 'rpg'\n"
            }
            if (deportes.checked){
                query += "AND toLower(g.Genres) CONTAINS 'sport'\n"
            }
            if (indie.checked){
                query += "AND toLower(g.Genres) CONTAINS 'indie'\n"
            }
            if (estrategia.checked){
                query += "AND toLower(g.Genres) CONTAINS 'strategy'\n"
            }
            if (simulacion.checked){
                query += "AND toLower(g.Genres) CONTAINS 'simulation'\n"
            }
            if (carreras.checked){
                query += "AND toLower(g.Genres) CONTAINS 'racing'\n"
            }
            if (mmo.checked){
                query += "AND toLower(g.Genres) CONTAINS 'massively multiplayer'\n"
            }
            if (terror.checked){
                query += "AND toLower(g.Tags) CONTAINS 'horror'\n"
            }
            if (disparos.checked){
                query += "AND toLower(g.Tags) CONTAINS 'shooter'\n"
            }
            if (sandbox.checked){
                query += "AND toLower(g.Tags) CONTAINS 'sandbox'\n"
            }
            if (plataformas.checked){
                query += "AND toLower(g.Tags) CONTAINS 'platform'\n"
            }
            if (puzles.checked){
                query += "AND toLower(g.Tags) CONTAINS 'puzzle'\n"
            }
            if (fantasia.checked){
                query += "AND toLower(g.Tags) CONTAINS 'fantasy'\n"
            }
            if (cienciaFi.checked){
                query += "AND toLower(g.Tags) CONTAINS 'sci-fi'\n"
            }


            if (espaniolT.checked){
                query += "AND toLower(g.`Supported languages`) CONTAINS 'spanish'\n"
            }
            if (inglesT.checked){
                query += "AND toLower(g.`Supported languages`) CONTAINS 'english'\n"
            }
            if (italianoT.checked){
                query += "AND toLower(g.`Supported languages`) CONTAINS 'italian'\n"
            }
            if (alemanT.checked){
                query += "AND toLower(g.`Supported languages`) CONTAINS 'german'\n"
            }
            if (francesT.checked){
                query += "AND toLower(g.`Supported languages`) CONTAINS 'french'\n"
            }
            if (chinoT.checked){
                query += "AND toLower(g.`Supported languages`) CONTAINS 'chinese'\n"
            }
            if (japonesT.checked){
                query += "AND toLower(g.`Supported languages`) CONTAINS 'japanese'\n"
            }
            if (espaniolA.checked){
                query += "AND toLower(g.`Full audio languages`) CONTAINS 'spanish'\n"
            }
            if (inglesA.checked){
                query += "AND toLower(g.`Full audio languages`) CONTAINS 'english'\n"
            }
            if (italianoA.checked){
                query += "AND toLower(g.`Full audio languages`) CONTAINS 'italian'\n"
            }
            if (alemanA.checked){
                query += "AND toLower(g.`Full audio languages`) CONTAINS 'german'\n"
            }
            if (francesA.checked){
                query += "AND toLower(g.`Full audio languages`) CONTAINS 'french'\n"
            }
            if (chinoA.checked){
                query += "AND toLower(g.`Full audio languages`) CONTAINS 'chinese'\n"
            }
            if (japonesA.checked){
                query += "AND toLower(g.`Full audio languages`) CONTAINS 'japanese'\n"
            }

            if (windows.checked){
                query += "AND g.Windows = true\n"
            }
            if (linux.checked){
                query += "AND g.Linux = true\n"
            }
            if (mac.checked){
                query += "AND g.Mac = true\n"
            }

            query += "RETURN g.AppID, g.Name, g.Price, g.`Header image`, g.`About the game`\n"

            if (comboBox.currentIndex === 0){
                query += "ORDER BY g.`Peak CCU` DESC\n"
            }else if (comboBox.currentIndex === 1){
                query += "ORDER BY g.`Average playtime two weeks` DESC\n"
            }else{
                query += "ORDER BY g.Positive / g.Negative DESC\n"
            }

            query += "LIMIT "+sliderResultados.value+"\n"

            return query
    }

    Rectangle {
        id: rectangle
        width: parent.width
        height: parent.height
        visible: true
        color: "#f5f5f5"

        Rectangle {
            id: rectangle1
            x: 0
            y: 0
            width: parent.width
            height: 189
            color: "#7a57b5"
            radius: 1
            border.color: "#7a26a0"
            border.width: 0

            Image {
                id: image
                x: 703
                y: 13
                width: 514
                height: 165
                source: "./GameSelectLogo.png"
                fillMode: Image.PreserveAspectFit
            }
        }

        Column {
            x: 30
            y: 208
            width: 208
            height: 714
            enabled: itemsEnabled

            Text {
                id: generos
                width: 147
                height: 41
                text: qsTr("Géneros")
                font.pixelSize: 31
                horizontalAlignment: Text.AlignHCenter
                style: Text.Normal
                font.styleName: "Semibold"
            }

            CheckBox {
                id: accion
                width: 180
                height: 40
                text: qsTr("Acción")
                font.pointSize: 18
                font.bold: false
                display: AbstractButton.TextOnly
                checkState: Qt.Unchecked
            }

            CheckBox {
                id: aventura
                width: 180
                height: 40
                text: qsTr("Aventura")
                font.pointSize: 18
                font.bold: false
                display: AbstractButton.TextOnly
                checkState: Qt.Unchecked
            }

            CheckBox {
                id: rpg
                width: 180
                height: 40
                text: qsTr("RPG")
                font.pointSize: 18
                font.bold: false
                display: AbstractButton.TextOnly
                checkState: Qt.Unchecked
            }

            CheckBox {
                id: deportes
                width: 180
                height: 40
                text: qsTr("Deportes")
                font.pointSize: 18
                font.bold: false
                display: AbstractButton.TextOnly
                checkState: Qt.Unchecked
            }

            CheckBox {
                id: indie
                width: 180
                height: 40
                text: qsTr("Indie")
                font.pointSize: 18
                font.bold: false
                display: AbstractButton.TextOnly
                checkState: Qt.Unchecked
            }

            CheckBox {
                id: estrategia
                width: 180
                height: 40
                text: qsTr("Estrategia")
                font.pointSize: 18
                font.bold: false
                display: AbstractButton.TextOnly
                checkState: Qt.Unchecked
            }

            CheckBox {
                id: simulacion
                width: 180
                height: 40
                text: qsTr("Simulación")
                font.pointSize: 18
                font.bold: false
                display: AbstractButton.TextOnly
                checkState: Qt.Unchecked
            }

            CheckBox {
                id: carreras
                width: 180
                height: 40
                text: qsTr("Carreras")
                font.pointSize: 18
                font.bold: false
                display: AbstractButton.TextOnly
                checkState: Qt.Unchecked
            }

            CheckBox {
                id: mmo
                width: 180
                height: 40
                text: qsTr("MMO")
                font.pointSize: 18
                font.bold: false
                display: AbstractButton.TextOnly
                checkState: Qt.Unchecked
            }

            CheckBox {
                id: terror
                width: 180
                height: 40
                text: qsTr("Terror")
                font.pointSize: 18
                font.bold: false
                display: AbstractButton.TextOnly
                checkState: Qt.Unchecked
            }

            CheckBox {
                id: disparos
                width: 180
                height: 40
                text: qsTr("Disparos")
                font.pointSize: 18
                font.bold: false
                display: AbstractButton.TextOnly
                checkState: Qt.Unchecked
            }

            CheckBox {
                id: sandbox
                width: 180
                height: 40
                text: qsTr("Sandbox")
                font.pointSize: 18
                font.bold: false
                display: AbstractButton.TextOnly
                checkState: Qt.Unchecked
            }

            CheckBox {
                id: plataformas
                width: 180
                height: 40
                text: qsTr("Plataformas")
                font.pointSize: 18
                font.bold: false
                display: AbstractButton.TextOnly
                checkState: Qt.Unchecked
            }

            CheckBox {
                id: puzles
                width: 180
                height: 40
                text: qsTr("Puzles")
                font.pointSize: 18
                font.bold: false
                display: AbstractButton.TextOnly
                checkState: Qt.Unchecked
            }

            CheckBox {
                id: fantasia
                width: 180
                height: 40
                text: qsTr("Fantasía")
                font.pointSize: 18
                font.bold: false
                display: AbstractButton.TextOnly
                checkState: Qt.Unchecked
            }

            CheckBox {
                id: cienciaFi
                width: 209
                height: 40
                text: qsTr("Ciencia Ficción")
                font.pointSize: 18
                font.bold: false
                display: AbstractButton.TextOnly
                checkState: Qt.Unchecked
            }
        }

        Column {
            x: 257
            y: 208
            enabled: itemsEnabled

            Text {
                id: jugadores
                width: 189
                height: 41
                text: qsTr("Jugadores")
                font.pixelSize: 31
                horizontalAlignment: Text.AlignHCenter
                style: Text.Normal
                font.styleName: "Semibold"
            }

            RadioButton {
                id: j_unJugador
                text: qsTr("Un Jugador")
                font.pointSize: 18
            }

            RadioButton {
                id: j_multijugador
                width: 185
                height: 37
                text: qsTr("Multijugador")
                font.pointSize: 18
            }

            RadioButton {
                id: j_cualquiera
                width: 185
                height: 37
                text: qsTr("Cualquiera")
                font.pointSize: 18
                checked: true
            }
        }

        Text {
            id: minMoney
            x: 522
            y: 286
            text: Math.round(sliderPrecio.first.value) + "$"
            font.pixelSize: 25
        }

        Text {
            id: maxMoney
            x: 682
            y: 286
            text: Math.round(sliderPrecio.second.value) + "$"
            font.pixelSize: 25
        }

        Column {
            x: 515
            y: 208
            enabled: itemsEnabled

            Text {
                id: precio
                width: 189
                height: 41
                text: qsTr("Precio")
                font.pixelSize: 31
                horizontalAlignment: Text.AlignHCenter
                style: Text.Normal
                font.styleName: "Semibold"
            }

            RangeSlider {
                id: sliderPrecio
                stepSize: 1
                snapMode: RangeSlider.SnapAlways
                second.value: 50
                live: true
                first.value: 0
                to: 150
            }
        }

        Column {
            x: 791
            y: 210
            enabled: itemsEnabled

            Text {
                id: edadMin
                width: 201
                height: 41
                text: qsTr("Rango Edad")
                font.pixelSize: 31
                horizontalAlignment: Text.AlignHCenter
                style: Text.Normal
                font.styleName: "Semibold"
            }

            RangeSlider {
                id: sliderEdad
                first.value: 0
                second.value: 21
                snapMode: RangeSlider.SnapAlways
                to: 21
                stepSize: 1
            }
        }

        Text {
            id: minEdad
            x: 805
            y: 286
            text: Math.round(sliderEdad.first.value)
            font.pixelSize: 25
        }

        Text {
            id: maxEdad
            x: 955
            y: 286
            text: Math.round(sliderEdad.second.value)
            font.pixelSize: 25
        }


        Column {
            x: 257
            y: 390
            enabled: itemsEnabled

            Text {
                id: idiomasT
                width: 189
                height: 41
                text: qsTr("Idiomas (texto)")
                font.pixelSize: 31
                horizontalAlignment: Text.AlignHCenter
                style: Text.Normal
                font.styleName: "Semibold"
            }

            CheckBox {
                id: espaniolT
                width: 180
                height: 40
                text: qsTr("Español")
                font.pointSize: 18
                font.bold: false
                display: AbstractButton.TextOnly
                checkState: Qt.Unchecked
            }

            CheckBox {
                id: inglesT
                width: 180
                height: 40
                text: qsTr("Inglés")
                font.pointSize: 18
                font.bold: false
                display: AbstractButton.TextOnly
                checkState: Qt.Unchecked
            }

            CheckBox {
                id: italianoT
                width: 180
                height: 40
                text: qsTr("Italiano")
                font.pointSize: 18
                font.bold: false
                display: AbstractButton.TextOnly
                checkState: Qt.Unchecked
            }

            CheckBox {
                id: alemanT
                width: 180
                height: 40
                text: qsTr("Alemán")
                font.pointSize: 18
                font.bold: false
                display: AbstractButton.TextOnly
                checkState: Qt.Unchecked
            }

            CheckBox {
                id: francesT
                width: 180
                height: 40
                text: qsTr("Francés")
                font.pointSize: 18
                font.bold: false
                display: AbstractButton.TextOnly
                checkState: Qt.Unchecked
            }

            CheckBox {
                id: chinoT
                width: 180
                height: 40
                text: qsTr("Chino")
                font.pointSize: 18
                font.bold: false
                display: AbstractButton.TextOnly
                checkState: Qt.Unchecked
            }

            CheckBox {
                id: japonesT
                width: 180
                height: 40
                text: qsTr("Japonés")
                font.pointSize: 18
                font.bold: false
                display: AbstractButton.TextOnly
                checkState: Qt.Unchecked
            }
        }

        Column {
            x: 532
            y: 390
            enabled: itemsEnabled

            Text {
                id: idiomasA
                width: 189
                height: 41
                text: qsTr("Idiomas (audio)")
                font.pixelSize: 31
                horizontalAlignment: Text.AlignHCenter
                style: Text.Normal
                font.styleName: "Semibold"
            }

            CheckBox {
                id: espaniolA
                width: 180
                height: 40
                text: qsTr("Español")
                font.pointSize: 18
                font.bold: false
                display: AbstractButton.TextOnly
                checkState: Qt.Unchecked
            }

            CheckBox {
                id: inglesA
                width: 180
                height: 40
                text: qsTr("Inglés")
                font.pointSize: 18
                font.bold: false
                display: AbstractButton.TextOnly
                checkState: Qt.Unchecked
            }

            CheckBox {
                id: italianoA
                width: 180
                height: 40
                text: qsTr("Italiano")
                font.pointSize: 18
                font.bold: false
                display: AbstractButton.TextOnly
                checkState: Qt.Unchecked
            }

            CheckBox {
                id: alemanA
                width: 180
                height: 40
                text: qsTr("Alemán")
                font.pointSize: 18
                font.bold: false
                display: AbstractButton.TextOnly
                checkState: Qt.Unchecked
            }

            CheckBox {
                id: francesA
                width: 180
                height: 40
                text: qsTr("Francés")
                font.pointSize: 18
                font.bold: false
                display: AbstractButton.TextOnly
                checkState: Qt.Unchecked
            }

            CheckBox {
                id: chinoA
                width: 180
                height: 40
                text: qsTr("Chino")
                checkable: true
                font.pointSize: 18
                font.bold: false
                display: AbstractButton.TextOnly
                checkState: Qt.Unchecked
            }

            CheckBox {
                id: japonesA
                width: 180
                height: 40
                text: qsTr("Japonés")
                font.pointSize: 18
                font.bold: false
                display: AbstractButton.TextOnly
                checkState: Qt.Unchecked
            }
        }

        Column {
            x: 802
            y: 347
            enabled: itemsEnabled

            Text {
                id: os
                width: 170
                height: 41
                text: qsTr("OS")
                font.pixelSize: 31
                horizontalAlignment: Text.AlignHCenter
                style: Text.Normal
                font.styleName: "Semibold"
            }

            CheckBox {
                id: windows
                width: 180
                height: 40
                text: qsTr("Windows")
                enabled: true
                checkable: true
                font.pointSize: 18
                font.bold: false
                display: AbstractButton.TextOnly
                checkState: Qt.Unchecked
            }

            CheckBox {
                id: linux
                width: 180
                height: 40
                text: qsTr("Linux")
                font.pointSize: 18
                font.bold: false
                display: AbstractButton.TextOnly
                checkState: Qt.Unchecked
            }

            CheckBox {
                id: mac
                width: 180
                height: 40
                text: qsTr("Mac")
                font.pointSize: 18
                font.bold: false
                display: AbstractButton.TextOnly
                checkState: Qt.Unchecked
            }
        }

        Column {
            x: 302
            y: 753
            width: 363
            height: 110
            enabled: itemsEnabled

            Text {
                id: ordenarPor
                width: 176
                height: 41
                text: qsTr("Ordenar Por:")
                font.pixelSize: 31
                horizontalAlignment: Text.AlignHCenter
                style: Text.Normal
                font.styleName: "Semibold"
            }

            ComboBox {
                id: comboBox
                width: 390
                height: 54
                model: ["Máximo de jugadores concurrentes", "Horas de media jugadas recientemente", "% Reseñas positivas"]
                font.pointSize: 15
            }
        }

        Column {
            x: 792
            y: 551
            enabled: itemsEnabled

            Text {
                id: anios
                width: 189
                height: 41
                text: qsTr("Rango de Año")
                font.pixelSize: 31
                horizontalAlignment: Text.AlignHCenter
                style: Text.Normal
                font.styleName: "Semibold"
            }

            Text {
                width: 189
                height: 41
                text: qsTr("de Lanzamiento")
                font.pixelSize: 31
                horizontalAlignment: Text.AlignHCenter
                style: Text.Normal
                font.styleName: "Semibold"
            }

            RangeSlider {
                id: sliderAnios
                stepSize: 1
                snapMode: RangeSlider.SnapAlways
                second.value: 2023
                live: true
                first.value: 1999
                to: 2023
                from: 1999
            }
        }

        Text {
            id: aniosMin
            x: 793
            y: 671
            text: Math.round(sliderAnios.first.value)
            font.pixelSize: 25
        }

        Text {
            id: aniosMax
            x: 940
            y: 671
            width: 52
            height: 34
            text: Math.round(sliderAnios.second.value)
            font.pixelSize: 25
        }

        Rectangle {
            id: rectangle2
            x: 1086
            y: 272
            width: 760
            height: 163
            color: "#cfcfcf"
            ScrollView {
                id: scrollView
                width: parent.width
                height: parent.height

                TextArea {
                    id: promptAI
                    x: -10
                    y: -6
                    width: parent.width
                    height: parent.height
                    text: "Escriba su prompt aquí"
                    font.pixelSize: 20
                    clip: true
                    readOnly: true
                    wrapMode: Text.Wrap
                }
            }
        }

        Switch {
            id: switchBusquedaAI
            x: 1080
            y: 206
            width: 766
            height: 51
            text: qsTr("Habilitar búsqueda por lenguaje natural (IA)")
            font.weight: Font.DemiBold
            font.bold: false
            font.pointSize: 25
            checked:false

            onToggled: {
                itemsEnabled = !itemsEnabled;

                if (rectangle2.color == "#ffffff"){
                    rectangle2.color = "#cfcfcf";
                    promptAI.readOnly = true;
                }else{
                    rectangle2.color = "#ffffff";
                    promptAI.readOnly = false;
                }
            }
        }

        Text {
            x: 1080
            y: 441
            width: 153
            height: 41
            text: qsTr("Resultado:")
            font.pixelSize: 31
            horizontalAlignment: Text.AlignHCenter
            style: Text.Normal
            font.styleName: "Semibold"
        }

        Rectangle {
            id: rectangle3
            x: 31
            y: 910
            width: 966
            height: 63
            color: "#7a57b5"
            radius: 32

            Button {
                id: button
                x: 0
                y: 0
                width: parent.width
                height: parent.height
                visible: true
                text: qsTr("REALIZAR BÚSQUEDA")
                font.bold: true
                font.pointSize: 30
                highlighted: false
                flat: true
                onClicked:
                    if (!switchBusquedaAI.checked){
                        backend.runQuery(makeQuery())
                    }else{
                        let request = ""
                        request += promptAI.text
                        backend.runQueryAI(request)
                    }
            }
        }

        Rectangle {
            id: rectangle4
            x: 1086
            y: 492
            width: 760
            height: 481
            color: "#ffffff"

            ScrollView {
                id: scrollView1
                width: parent.width
                height: parent.height

                TextArea {
                    id: textoResultado
                    x: 0
                    y: 0
                    width: parent.width
                    height: parent.height
                    font.pixelSize: 12
                    wrapMode: Text.Wrap
                    readOnly: true
                    clip: true
                    text: backend.texto
                }
            }
        }

        Column {
            x: 786
            y: 754
            enabled: itemsEnabled

            Column {
                width: 211
                height: 81

                Text {
                    width: 197
                    height: 41
                    text: qsTr("Nº Resultados")
                    font.pixelSize: 31
                    horizontalAlignment: Text.AlignHCenter
                    style: Text.Normal
                    font.styleName: "Semibold"
                }

                Slider {
                    id: sliderResultados
                    value: 10
                    stepSize: 1
                    snapMode: RangeSlider.SnapAlways
                    to: 20
                    from: 1
                }
            }

            Text {
                id: _text7
                width: 192
                height: 28
                text: sliderResultados.value
                font.pixelSize: 25
                horizontalAlignment: Text.AlignHCenter
            }
        }

        states: [
            State {
                name: "clicked"
            }
        ]
    }
}

