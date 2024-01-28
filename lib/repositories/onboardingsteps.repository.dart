import 'package:recyclingvin_web/helpers/colors.dart';
import 'package:recyclingvin_web/helpers/enums.dart';
import 'package:recyclingvin_web/models/onboardingstep.model.dart';

class OnboardingStepsRepository {

  List<OnboardingStepModel> onboardingSteps() {
    return [
      OnboardingStepModel(
        title: 'Meet Vin', 
        content: "Join Vin, our eco-friendly warrior\nand spirited kid-hero in making\nimpactful choices to save the planet.", 
        titleColor: RecyclingVinColors.vinGreen,
        badge: OnboardingBadgeOptions.vinbadge,
      ),
      OnboardingStepModel(
        title: 'Frackingsteins', 
        content: "Destroy frackingsteins as you\nadvance, a crop of evil monsters\nthat contaminate the earth.\nDon’t let them touch you!", 
        titleColor: RecyclingVinColors.frackensteinPurple,
        badge: OnboardingBadgeOptions.frackensteinbadge,
      ),
      OnboardingStepModel(
        title: 'BXL-79 Laser', 
        content: "With your BXL-79, a \nbrussels sprout laser,\nyou will destroy Frackensteins.\nCollect recyclables to power it.", 
        titleColor: RecyclingVinColors.laserGunGreen,
        badge: OnboardingBadgeOptions.seedgunbadge,
      ),
      OnboardingStepModel(
        title: 'Recycle as you go!', 
        content: "Pick up recyclable material \nto power your seed laser, earn badges\nand clean the environment.", 
        titleColor: RecyclingVinColors.recycleRed,
        badge: OnboardingBadgeOptions.recyclingbadge
      ),
    ];
  }
}