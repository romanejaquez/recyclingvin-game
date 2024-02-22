import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/helpers/utils.dart';

class BadgeAchievementMetadata {

  final String id;
  final String issuerId;
  final String issuerEmail;
  final String walletId;
  final RecyclingBadgeOptions badgeOption;
  final String imgName;
  final String badgeColorHex;

  BadgeAchievementMetadata({
    required this.id,
    required this.issuerId,
    required this.walletId,
    required this.issuerEmail,
    required this.badgeOption,
    required this.imgName,
    required this.badgeColorHex,
  });

  String walletPayload() {
    return
      """ 
      {
        "iss": "$issuerEmail",
        "aud": "google",
        "typ": "savetowallet",
        "origins": [],
        "payload": {
          "genericObjects": [
            {
              "id": "$issuerId.$id",
              "classId": "$issuerId.$walletId",
              "genericType": "GENERIC_TYPE_UNSPECIFIED",
              "hexBackgroundColor": "$badgeColorHex",
              "logo": {
                "sourceUri": {
                  "uri": "https://romanejaquez.github.io/recyclingvin-assets/badges/recyclingvinlogo.png"
                }
              },
              "cardTitle": {
                "defaultValue": {
                  "language": "en",
                  "value": "${Utils.labelFromBadge(badgeOption)}"
                }
              },
              "subheader": {
                "defaultValue": {
                  "language": "en",
                  "value": "Recycling Vin"
                }
              },
              "header": {
                "defaultValue": {
                  "language": "en",
                  "value": "Vin Greenthumb"
                }
              },
              "barcode": {
                "type": "QR_CODE",
                "value": "$id"
              },
              "heroImage": {
                "sourceUri": {
                  "uri": "https://romanejaquez.github.io/recyclingvin-assets/badges/$imgName.png"
                }
              },
              "textModulesData": [
                {
                  "header": "GAME ACHIEVEMENT",
                  "body": "200",
                  "id": "bags"
                }
              ]
            }
          ]
        }
      }
  """;
  }
}