# props_provider

Lightweight props provider for Flutter with fine-grained rebuilds powered by `InheritedModel`.

When data is passed through widget constructors, even a small change can force large parts of the UI to rebuild. `props_provider` lets widgets subscribe only to the specific piece of data they depend on, which keeps most of your subtree const and reduces render cost.

## Highlights

- Subscribe only to what a widget reads — avoid rebuild storms.
- Keep large subtrees const — move changing props into a local wrapper.
- Fine-grained updates using `select` with optional custom equality.
- No extra dependencies — built on Flutter primitives, works with any state management.

## Install

```bash
flutter pub add props_provider
```

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:props_provider/props_provider.dart';

class UserCard extends PropsProvider<UserCard> {
  const UserCard({
    super.key,
    required this.name,
    required this.surname,
    required this.avatarUrl,
  }) : super(child: const _UserCard());

  final String name;
  final String surname;
  final String avatarUrl;

  @override
  List<Object?> get identityProps => [name, surname, avatarUrl];

  static const of = PropsOf<UserCard>();
  static const select = PropsSelect<UserCard>();
  static const read = PropsRead<UserCard>();
}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final name = UserCard.select(context, (u) => u.name);
    return Text(name);
  }
}

class _Subtitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final surname = UserCard.select(context, (u) => u.surname);
    return Text(surname);
  }
}

class _Avatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final url = UserCard.select(context, (u) => u.avatarUrl);
    return Image.network(url);
  }
}
```

```dart
import 'package:flutter/material.dart';
import 'package:props_provider/props_provider.dart';

class UserEntity {
  UserEntity({
    required this.id,
    this.updatedAt,
    required this.name,
  });
  final String id;
  final DateTime? updatedAt;
  final String name;
}

class UserProps extends PropsProvider<UserProps> {
  const UserProps({
    super.key,
    required this.user,
    required super.child,
  });

  final UserEntity user;

  @override
  List<Object?> get identityProps => [
        user.id,
        user.updatedAt,
      ];

  static const of = PropsOf<UserProps>();
  static const select = PropsSelect<UserProps>();
  static const read = PropsRead<UserProps>();
}

class UsersList extends StatelessWidget {
  const UsersList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        UserProps(
          user: UserEntity(id: 'id', name: 'name'),
          child: const UserCard(),
        ),
      ],
    );
  }
}

class UserCard extends StatelessWidget {
  const UserCard({super.key});

  @override
  Widget build(BuildContext context) {
    final name = UserProps.select(context, (u) => u.user.name);

    return Card(
      child: ListTile(
        title: Text(name),
      ),
    );
  }
}
```

## API Overview

- `PropsProvider<T>` — wrap children and define `identityProps`
- `PropsSelect<T>` — subscribe to a specific value
- `PropsOf<T>` — get and subscribe to full provider
- `PropsRead<T>` — get without subscribing

## Recommendations

- Prefer `select` over `of` in leaf widgets to limit rebuilds.
- Keep `identityProps` minimal and immutable.
- Use `read` in callbacks where updates are irrelevant.


