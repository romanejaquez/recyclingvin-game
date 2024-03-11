import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:recyclingvin_web/helpers/enums.dart';

class AudioService {

  List<AssetsAudioPlayer> audios = [];

  AssetsAudioPlayer babyCrying = AssetsAudioPlayer();
  AssetsAudioPlayer badgeUnlock = AssetsAudioPlayer();
  AssetsAudioPlayer cardboardRide = AssetsAudioPlayer();
  AssetsAudioPlayer click = AssetsAudioPlayer();
  AssetsAudioPlayer laser = AssetsAudioPlayer();
  AssetsAudioPlayer lose = AssetsAudioPlayer();
  AssetsAudioPlayer trash = AssetsAudioPlayer();
  AssetsAudioPlayer win = AssetsAudioPlayer();
  AssetsAudioPlayer enemyHit = AssetsAudioPlayer();

  AssetsAudioPlayer bgSound = AssetsAudioPlayer();

  Map<RecyclingVinSounds, AssetsAudioPlayer> sounds = {};

  Future<void> initSounds() async {
    await babyCrying.open(Audio('/assets/sounds/babyCrying.mp3'), autoStart: false);
    await badgeUnlock.open(Audio('/assets/sounds/badgeUnlock.mp3'), autoStart: false);
    await cardboardRide.open(Audio('/assets/sounds/cardboardRide.mp3'), autoStart: false);
    await click.open(Audio('/assets/sounds/click.mp3'), autoStart: false);
    await laser.open(Audio('/assets/sounds/laser.mp3'), autoStart: false);
    await lose.open(Audio('/assets/sounds/lose.mp3'), autoStart: false);
    await trash.open(Audio('/assets/sounds/trash.mp3'), autoStart: false);
    await win.open(Audio('/assets/sounds/win.mp3'), autoStart: false);
    await enemyHit.open(Audio('/assets/sounds/enemyHit.mp3'), autoStart: false);

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
    };
  }

  Future<void> playSound(RecyclingVinSounds sound, { bool waitForSoundToFinish = false, bool loop = false,}) async {
    sounds[sound]!.play();
    if (loop) {
      sounds[sound]!.setLoopMode(loop ? LoopMode.single : LoopMode.none);
    }
  }

  Future<void> playBgSound() async {
    if (!bgSound.isPlaying.value) {
    await bgSound.open(Audio('/assets/sounds/vinSound.mp3'), autoStart: true, loopMode: LoopMode.single);
    }
  }

  Future<void> stopBgSound() async {
    await bgSound.stop();
  }

  Future<void> stopSound(RecyclingVinSounds sound) async {
    await sounds[sound]!.stop();
  }

  Future<void> stopAllSounds() async {
    for(var sound in sounds.values) {
      await sound.stop();
    }
  }

  void reset() {
    stopAllSounds();
    audios = [];
  }
}