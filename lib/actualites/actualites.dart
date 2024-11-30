import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:my_app/widgets/bottom_bar.dart';
import 'package:my_app/contact/contact.dart';

class Actualites extends StatelessWidget {
  const Actualites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: const Color(0xFF094FC6),
        elevation: 0,
        title: const Text(
          'Actualités',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: () {
              // TODO: Implémenter le filtre
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Section des catégories
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    _buildCategoryChip('Tous', true),
                    _buildCategoryChip('Urgences', false),
                    _buildCategoryChip('Sécurité', false),
                    _buildCategoryChip('Santé', false),
                    _buildCategoryChip('Routes', false),
                  ],
                ),
              ),
            ),

            // Liste des actualités
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  _buildNewsCard(
                    title: 'Nouveau centre médical d\'urgence',
                    description: 'Un nouveau centre médical d\'urgence ouvre ses portes à Conakry...',
                    image: 'assets/images/img_numurgence.jpeg',
                    date: '2 heures',
                    category: 'Santé',
                  ),
                  _buildNewsCard(
                    title: 'Alerte météo : Fortes pluies',
                    description: 'Des fortes pluies sont attendues dans la région de Conakry...',
                    image: 'assets/images/img_numurgence.jpeg',
                    date: '5 heures',
                    category: 'Urgences',
                  ),
                  _buildNewsCard(
                    title: 'Campagne de vaccination',
                    description: 'Une nouvelle campagne de vaccination débute cette semaine...',
                    image: 'assets/images/img_numurgence.jpeg',
                    date: '1 jour',
                    category: 'Santé',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomBar(currentIndex: 1),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: FadeInUp(
        child: FilterChip(
          label: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF094FC6),
              fontWeight: FontWeight.w500,
            ),
          ),
          selected: isSelected,
          onSelected: (bool value) {
            // TODO: Implémenter la sélection de catégorie
          },
          backgroundColor: Colors.white,
          selectedColor: const Color(0xFF094FC6),
          checkmarkColor: Colors.white,
          side: BorderSide(
            color: isSelected ? Colors.transparent : const Color(0xFF094FC6),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget _buildNewsCard({
    required String title,
    required String description,
    required String image,
    required String date,
    required String category,
  }) {
    return FadeInUp(
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: Image.asset(
                    image,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 15,
                  right: 15,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Text(
                      'Il y a $date',
                      style: const TextStyle(
                        color: Color(0xFF094FC6),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF094FC6).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      category,
                      style: const TextStyle(
                        color: Color(0xFF094FC6),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // TODO: Implémenter le partage
                          },
                          icon: const Icon(Icons.share_outlined),
                          label: const Text('Partager'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF094FC6),
                            side: const BorderSide(color: Color(0xFF094FC6)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // TODO: Implémenter la lecture complète
                          },
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text('Lire plus'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF094FC6),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
