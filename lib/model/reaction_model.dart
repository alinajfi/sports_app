// models/reaction_model.dart
enum ReactionType {
  like,
  love,
  laugh,
  wow,
  sad,
  angry,
}

class Reaction {
  final ReactionType type;
  final String emoji;
  final String label;

  const Reaction({
    required this.type,
    required this.emoji,
    required this.label,
  });

  static const List<Reaction> allReactions = [
    Reaction(type: ReactionType.like, emoji: '👍', label: 'Like'),
    Reaction(type: ReactionType.love, emoji: '❤️', label: 'Love'),
    Reaction(type: ReactionType.laugh, emoji: '😂', label: 'Haha'),
    Reaction(type: ReactionType.wow, emoji: '😮', label: 'Wow'),
    Reaction(type: ReactionType.sad, emoji: '😢', label: 'Sad'),
    Reaction(type: ReactionType.angry, emoji: '😡', label: 'Angry'),
  ];

  static Reaction getReaction(ReactionType type) {
    return allReactions.firstWhere((reaction) => reaction.type == type);
  }
}
