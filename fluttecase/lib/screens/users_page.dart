import 'package:fluttecase/models/user.dart';
import 'package:fluttecase/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().fetchUsers();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showUserDetails(UserModel user) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'POPUP',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(user.photoUrl ?? ''),
              ),
              const SizedBox(height: 16),
              Text(
                user.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('@${user.username}'),
              const SizedBox(height: 16),
              _detailRow('Email:', user.email),
              _detailRow('Telefon:', user.phone),
              _detailRow(
                  'Adres:', '${user.address.street}, ${user.address.suite}'),
              _detailRow('Şehir:', user.address.city),
              _detailRow(
                  'Konum:', '${user.address.geo.lat}/${user.address.geo.lng}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'User Directory',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: userProvider.searchUsers,
                      decoration: InputDecoration(
                        hintText: 'Kullanıcı Ara',
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        suffixIcon: userProvider.searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _searchController.clear();
                                  userProvider.clearSearch();
                                },
                              )
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: userProvider.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : userProvider.filteredUsers.isEmpty
                            ? const Center(
                                child: Text(
                                  'Kullanıcı Bulunamadı!',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: userProvider.filteredUsers.length,
                                itemBuilder: (context, index) {
                                  final user =
                                      userProvider.filteredUsers[index];
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      border: Border.all(
                                          color: Colors.grey.shade300),
                                    ),
                                    child: ListTile(
                                      onTap: () => _showUserDetails(user),
                                      leading: CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(user.photoUrl ?? ''),
                                      ),
                                      title: Text(user.name),
                                      subtitle: Text('@${user.username}'),
                                      trailing: const Icon(Icons.chevron_right),
                                    ),
                                  );
                                },
                              ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
