import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_app/models/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Kutils{

    //MQTT
    static const String topic = "demomqtt";

    //Colors
    static const Color GREEN_COLOR = Color.fromRGBO(19, 42, 19, 1);
    static const Color GREEN_OTHER_COLOR = Color.fromRGBO(215, 222, 137, 1);
    static const int APP_BAR_TESTE_SIZE = 20;
    static const double BORDER_WIDTH = 5;

    //Texte size
    static const int NAVBAR_TEXTE_SIZE = 18;

    // Widgets Size
    static const double BUTTON_HEIGTH = 45;
    static const double INPUT_HEIGTH = 50;

    //Topic Mqtt
    static const String TOPIC_SANSI_TECH = "sansitech/gn/sansitech/gn_sansitech/koulibaly/subscriber";
    static const String TOPIC_APK_RASPBERRY = "sansitech/koulibaly/apk/raspberry";
    static const String TOPIC_DJANGO_APK_NOTIFICATION = "sansitech/koulibaly/django/apk/notification";
    static const String TOPIC_APK_RASPBERRY_DISTANCE = 'sansitech/koulibaly/apk/raspberry/distance';
    static const String TOPIC_RASPBERRY_APK_DISTANCE = 'sansitech/koulibaly/raspberry/apk/distance';
    static const String TOPIC_DJANGO_APK_DISTANCE = 'sansitech/django/apk/distancePluie';
    static const String TOPIC_RASPBERRY_APK_PLUIE = 'sansitech/koulibaly/raspberry/apk/pluie';
    static const String TOPIC_RASPBERRY_APK_HUMIDITE = 'sansitech/koulibaly/raspberry/apk/humidite';
    static const String topic_django_apk_humidite = 'sansitech/koulibaly/django/apk/humidite';
    static const String TOPIC_DJANGO_APK_MALADIE_TOMATE = 'sansitech/djibril/django/apk/maladie/tomate';

    static const String topic_action_automatique_response_raspberry_apk_microcommandeArrosage = "sansitech/koulibaly/actionautomatique/response/raspberry/apk/microcommandeArrosage";
    static const String topic_action_automatique_response_raspberry_apk_microcommandeEngrais = "sansitech/koulibaly/actionautomatique/response/raspberry/apk/microcommandeEngrais";

    static const String topic_action_automatique_apk_django_microcommandeArrosage = "sansitech/koulibaly/actionautomatique/apk/django/microcommandeArrosage";
    static const String topic_action_automatique_apk_django_microcommandeEngrais = "sansitech/koulibaly/actionautomatique/apk/django/microcommandeEngrais";

    static const String topic_action_automatique_apk_raspberry_microcommandeArrosage = "sansitech/koulibaly/actionautomatique/apk/raspberry/microcommandeArrosage";
    static const String topic_action_automatique_apk_raspberry_microcommandeEngrais = "sansitech/koulibaly/actionautomatique/apk/raspberry/microcommandeEngrais";

    static const String topic_detection_automatique_esp32cam_image = "sansitech/djibril/detectionautomatique/esp32cam/raspberry/image";

    //Traductions
    //Soussou
    static const String traduction_feu_dans_le_champs_soussou = "Wo siga dé, Saansi nah gan fée";
    static const String traduction_aniamal_dans_le_champs_soussou = "Daali cé bara fa sansi ka na dé";
    static const String traduction_maladie_dans_le_champs_soussou = """
        Fouréndeh bara fôlô tamaassi ma.
         Kônô, tamaassi faamanai ratangadé haawo gui marassi raba:
        A sînguéh, woo sansi  ma galambou. A firiyandéh, wo na bourèkhè kobi baah na. Alako Ana ha fou ré radangui booré ma.
          Na nadangui, Wo  séri nan saama, nafoun-nè kobi touhouounssan fé ma.
             Anaaniyandhé, wonatamaassi makouya aboréra. a  fo'yé sôtôma afan-nyidi ra.
          Yôôô, hawo gui maarassi raba, wo haa sansi faamanê ratangadé aki nou,  akèyaah ma
    """;
    static const String traduction_pluie_dans_le_champs_soussou = "Daali cé bara fa sansi ka na dé";
    static const String traduction_maladie_tomate_1 = """
    tamaatiidjė maadhen nô mari nawnaarė. et
    hidha douhwaah dhåbhogôl kổ ponpétè kon,
    ponpaa. îtaa kaakii nangoudhidhin, yàadjinah
    hâckoudhè lêdhë tamaatidhen. yiltídhiraa
    awroudjídhin. harâ à awaaly piihoun gôtoun
    koûn touma kala
    """;

    // IP Addresse
    static const String IP = "192.168.43.134";
    static const String PORT = "8000";

    // EndPoints api
    static const String ENDPOINT_INSCRIPTION = "http://$IP:$PORT/sguser/add_user";
    static const String ENDPOINT_CONNEXION = "http://$IP:$PORT/sguser/login";
    static const String ENDPOINT_ADD_IMAGE = "http://$IP:$PORT/sguser/upload";
    static const String ENDPOINT_CREATE_ACTION = "http://$IP:$PORT/users/api/createAction";
    static const String ENDPOINT_NOTIFICATIONS = "http://$IP:$PORT/users/api/indexNotification";
    static const String ENDPOINT_ACTIONS = "http://$IP:$PORT/users/api/indexAction";
    static const String ENDPOINT_DELETE_ACTION = "http://$IP:$PORT/users/api/deleteAction";
    static const String ENDPOINT_UPDATE_USER = "http://$IP:$PORT/users/api/update_user";
    static const String ENDPOINT_SHOW_AUTOMATIQUEACTION = "http://$IP:$PORT/users/api/indexAction";
    static const String ENDPOINT_LIRE_TEXTE = "http://$IP:$PORT/users/api/text-to-speech/";
    static const String ENDPOINT_LIRE_TEXTE_NOW = "http://$IP:$PORT/media/audio/";
    static const String ENDPOINT_UPDATE_TOKEN_FIREBASE = "http://$IP:$PORT/tokenfirebase/update_token_firebase";
    static const String ENDPOINT_UPDATE_NOTIFICATION_READED = "http://$IP:$PORT/users/api/update_notification_readed";
    static const String ENDPOINT_WEBSOCKET_URI = "ws://$IP:$PORT/ws/chat/";

    static const double PAGE_BAR_SIZE = 18;

    static double map(double x, double in_min, double in_max, double out_min, double out_max)
    {
        return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
    }

    //concernant le npk
    static const n_title = "Azote (N)";
    static const n_moyen_value = "200 à 400";
    static const n_mauvais_value = "0 à 200";
    static const n_bon_value = "400 à 800+";
    static const n_icone = "assets/svgs/svg_21.svg";

    static const na_title = "Sodium (Na)";
    static const na_moyen_value = "100 à 200";
    static const na_mauvais_value = "0 à 100";
    static const na_bon_value = "200 à 400+";
    static const na_icone = "assets/svgs/svg_22.svg";

    static const PH_title = "Phosphore (PH)";
    static const PH_moyen_value = "20 à 50";
    static const PH_mauvais_value = "0 à 20";
    static const PH_bon_value = "50 à 80+";
    static const PH_icone = "assets/svgs/svg_23.svg";

    static const ph_title = "ph(ph)";
    static const ph_moyen_value = ">7";
    static const ph_mauvais_value = "<6";
    static const ph_bon_value = "6 à 7";
    static const ph_icone = "assets/svgs/svg_25.svg";

    static const k_title = "Potassium (P)";
    static const k_moyen_value = "150 à 250";
    static const k_mauvais_value = "0 à 150";
    static const k_bon_value = "250 à 400+";
    static const k_icone = "assets/svgs/svg_24.svg";

    //Meteo
    static const WEEK = ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche'];

    //Differentes langues
    static const String LANGUE_POULAR = "Poular";
    static const String LANGUE_FRANCAIS = "Français";
    static const String LANGUE_SOUSSOU = "Soussou";
    static const String LANGUE_MALINKE = "Malinké";
    static const String LANGUE_KISSI = "Kissi";

    static const int QUANTITE_PAR_METRE_CARRE = 5;
    static const double QUANTITE_PAR_LITRE = 0.0333;

    /*
    * retourne la quantite d'eau en litre pour arroser
     */
    static double surface_to_quantite_arrosage(double surface){
        return (surface*QUANTITE_PAR_METRE_CARRE);
    }

    static Future<bool> saveStudentSession(User? user) async {
        final prefs = await SharedPreferences.getInstance();
        if( user == null ) return await prefs.setString("user", "" );
        return await prefs.setString('user', jsonEncode(user.toJson()));
    }

    static Future<User> getUserLogin() async {
        final prefs = await SharedPreferences.getInstance();
        Map<String, dynamic> mapUser = jsonDecode( prefs.getString("user" )! );
        User user = User.fromJson(mapUser);
        return user;
    }

    static Future<bool> isStudentLoggedIn() async {
        final prefs = await SharedPreferences.getInstance();
        return prefs.getString('user')!.isEmpty ? false : true;
    }

    // static void onMessageReceivedWebsocketGlobal(dynamic event, AudioPlayer audioPlayer){
    //     Map<String, dynamic> map = jsonDecode(event);
    //     Map<String, dynamic> dt = jsonDecode(map['data']);
    //     if( dt["page"] != "all" ) return;
    //
    //
    //     Map<String, dynamic> values = jsonDecode(dt["data"]);
    //
    //     if( values.containsKey("microcommandeFumee") ) {
    //         NotificationService().showNotification(title: "Détection de flamme", body: "Nous avons detecté la presence de flamme sur ou à proximité de votre champs. En attendant des mesures sont prises par SANSITECH pour eteindre le feu." );
    //         APIService.createAudioFile(Kutils.traduction_feu_dans_le_champs_soussou).
    //         then((value) async {
    //             if( value.code != 200 ) return;
    //
    //             String audioPath = "${Kutils.ENDPOINT_LIRE_TEXTE_NOW}voie.mp3";
    //             await audioPlayer.play(UrlSource(audioPath));
    //         });
    //     }else if( values.containsKey("microcommandeRepulsif") ){
    //         NotificationService().showNotification(title: "Détection d'animaux", body: "Nous avons detecté la presence d'animaux sur ou à proximité de votre champs. En attendant des mesures sont prises par SANSITECH pour eteindre les chasser." );
    //         APIService.createAudioFile(Kutils.traduction_aniamal_dans_le_champs_soussou).
    //         then((value) async {
    //             if( value.code != 200 ) return;
    //
    //             String audioPath = "${Kutils.ENDPOINT_LIRE_TEXTE_NOW}voie.mp3";
    //             await audioPlayer.play(UrlSource(audioPath));
    //         });
    //     }else if( values.containsKey("microcommandePlante") ){
    //         NotificationService().showNotification(title: "Détection de maladies", body: "Nous avons detecté la presence de maladie de plante." );
    //         APIService.createAudioFile(Kutils.traduction_maladie_dans_le_champs_soussou).
    //         then((value) async {
    //             if( value.code != 200 ) return;
    //
    //             String audioPath = "${Kutils.ENDPOINT_LIRE_TEXTE_NOW}voie.mp3";
    //             await audioPlayer.play(UrlSource(audioPath));
    //         });
    //     }
    // }
    //
    // static int quantite_arrosage_to_delay(double surface){
    //     double quantite = surface_to_quantite_arrosage(surface);
    //     return ((quantite/QUANTITE_PAR_LITRE)*1000).toInt();
    // }

    // Obtenir le repertoire des fichiers d'application
    static Future<String> get _localPath async {
        final directory = await getApplicationDocumentsDirectory();
        return directory.path;
    }

    // Obtenir la reference au fichier
    static Future<File> get _localFile async {
        final path = await _localPath;
        return File('$path/auth.txt');
    }

    // Ecrire dans le fichier
    static Future<bool> writeToFile(String content) async {
        final file = await _localFile;
        if( await file.exists() ) {
            file.writeAsString(content);
        } else{
            await file.create();
            file.writeAsString(content);
        }
        return true;
    }

    static int boolToInt(bool value){
        return (value == true) ? 1 : 0;
    }

    // static void lecture_audio(String texte, AudioPlayer audioPlayer){
    //     APIService.createAudioFile(texte).
    //     then((value) async {
    //         if( value == null ) return;
    //         if( value.code != 200 ) return;
    //
    //         String audioPath = "${Kutils.ENDPOINT_LIRE_TEXTE_NOW}voie.mp3";
    //         await audioPlayer.play(UrlSource(audioPath));
    //     });
    // }

    // Lire dans le fichier
    static Future<Map<String, dynamic>> readFromFile() async {
        try {
            final file = await _localFile;

            // Vérifier si le fichier existe
            if (await file.exists()) {
                String content = await file.readAsString();
                return jsonDecode(content);
            } else {
                await file.create();
                await file.writeAsString('');
                return Map<String, dynamic>();
            }
        } catch (e) {
            return Map<String, dynamic>();
        }
    }
}