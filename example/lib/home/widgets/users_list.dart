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
