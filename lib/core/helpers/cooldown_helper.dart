class CooldownManager {
  static final CooldownManager _instance = CooldownManager._internal();
  factory CooldownManager() => _instance;
  CooldownManager._internal();

  final Map<String, DateTime> _cooldowns = {};
  static const Duration defaultCooldown = Duration(minutes: 2);

  bool canPerformAction(String actionKey) {
    if (!_cooldowns.containsKey(actionKey)) {
      return true;
    }

    final lastActionTime = _cooldowns[actionKey]!;
    final now = DateTime.now();
    final difference = now.difference(lastActionTime);

    return difference >= defaultCooldown;
  }

  Duration getRemainingCooldown(String actionKey) {
    if (!_cooldowns.containsKey(actionKey)) {
      return Duration.zero;
    }

    final lastActionTime = _cooldowns[actionKey]!;
    final now = DateTime.now();
    final difference = now.difference(lastActionTime);
    final remaining = defaultCooldown - difference;

    return remaining.isNegative ? Duration.zero : remaining;
  }

  int getRemainingSeconds(String actionKey) {
    return getRemainingCooldown(actionKey).inSeconds;
  }

  void setCooldown(String actionKey) {
    _cooldowns[actionKey] = DateTime.now();
  }

  void resetCooldown(String actionKey) {
    _cooldowns.remove(actionKey);
  }

  void resetAll() {
    _cooldowns.clear();
  }

  String getFormattedTime(String actionKey) {
    final seconds = getRemainingSeconds(actionKey);
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
