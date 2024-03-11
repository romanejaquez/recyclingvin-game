import 'package:assets_audio_player/assets_audio_player.dart' as aap;
import 'package:audiofileplayer/audiofileplayer.dart';
import 'package:recyclingvin_web/helpers/constants.dart';
import 'package:recyclingvin_web/helpers/enums.dart';

class AudioService {

  late Audio babyCrying;
  late Audio badgeUnlock;
  late Audio cardboardRide;
  late Audio click;
  late Audio laser;
  late Audio multiLaser;
  late Audio lose;
  late Audio trash;
  late Audio win;
  late Audio enemyHit;
  late Audio enemyKill;
  late Audio frackingstein;

  late aap.AssetsAudioPlayer bgSound;

  Map<RecyclingVinSounds, Audio> sounds = {};

  Future<void> initSounds() async {
    // using AssetsAudioPlayer only for the bgSound as
    // it has a better looping mechanism
    bgSound = aap.AssetsAudioPlayer();
    bgSound.open(aap.Audio('${Constants.soundAssets}bgSound.mp3'), volume: 0.5, loopMode: aap.LoopMode.single);

    // using audiofileplayer for the rest
    // as it handles parallel sounds better
    babyCrying = Audio.load('${Constants.soundAssets}babyCrying.mp3');
    badgeUnlock = Audio.load('${Constants.soundAssets}badgeUnlock.mp3');
    cardboardRide = Audio.load('${Constants.soundAssets}cardboardRide.mp3');
    click = Audio.load('${Constants.soundAssets}click.mp3');
    laser = Audio.load('${Constants.soundAssets}laser.mp3');
    lose = Audio.load('${Constants.soundAssets}lose.mp3');
    trash = Audio.load('${Constants.soundAssets}trash.mp3');
    win = Audio.load('${Constants.soundAssets}win.mp3');
    enemyHit = Audio.load('${Constants.soundAssets}enemyHit.mp3');
    enemyKill = Audio.load('${Constants.soundAssets}enemyKill.mp3');
    frackingstein = Audio.load('${Constants.soundAssets}frackingstein.mp3');

    sounds = {
      RecyclingVinSounds.babyCrying: babyCrying,
      RecyclingVinSounds.badgeUnlock: badgeUnlock,
      RecyclingVinSounds.cardboardRide: cardboardRide,
      RecyclingVinSounds.click : click,
      RecyclingVinSounds.laser : laser,
      RecyclingVinSounds.lose : lose,
      RecyclingVinSounds.trash : trash,
      RecyclingVinSounds.win : win,
      RecyclingVinSounds.enemyHit : enemyHit,
      RecyclingVinSounds.enemyKill : enemyKill,
      RecyclingVinSounds.frackingstein: frackingstein,
    };
  }

  Future<void> playSound(RecyclingVinSounds sound) async {
    await sounds[sound]!.play();
  }

  Future<void> playBgSound() async {
    await bgSound.play();
  }

  Future<void> stopBgSound() async {
    await bgSound.stop();
  }

  Future<void> stopSound(RecyclingVinSounds sound) async {
    await sounds[sound]!.pause();
  }

  Future<void> stopAllSounds() async {
    for(var sound in sounds.values) {
      await sound.pause();
    }
  }

  void reset() {
    stopAllSounds();
  }
}