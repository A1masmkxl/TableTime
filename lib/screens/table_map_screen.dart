import 'package:flutter/material.dart';
import 'package:tabletime/models/restaurant_model.dart';
import 'package:tabletime/models/table_model.dart';
import 'package:tabletime/screens/booking/booking_screen.dart';

class TableMapScreen extends StatefulWidget {
  final Restaurant restaurant;

  const TableMapScreen({super.key, required this.restaurant});

  @override
  State<TableMapScreen> createState() => _TableMapScreenState();
}

class _TableMapScreenState extends State<TableMapScreen> {
  RestaurantTable? selectedTable;
  late List<RestaurantTable> tables;
  String _filter = 'all'; // all, available, 2-seater, 4-seater, 6-seater

  @override
  void initState() {
    super.initState();
    _initializeTables();
  }

  void _initializeTables() {
    tables = [
      RestaurantTable(
        id: 't1',
        restaurantId: widget.restaurant.id,
        number: 1,
        capacity: 2,
        x: 15,
        y: 20,
        shape: TableShape.circle,
        isBooked: false,
      ),
      RestaurantTable(
        id: 't2',
        restaurantId: widget.restaurant.id,
        number: 2,
        capacity: 2,
        x: 45,
        y: 20,
        shape: TableShape.circle,
        isBooked: true,
      ),
      RestaurantTable(
        id: 't3',
        restaurantId: widget.restaurant.id,
        number: 3,
        capacity: 2,
        x: 75,
        y: 20,
        shape: TableShape.circle,
        isBooked: false,
      ),
      RestaurantTable(
        id: 't4',
        restaurantId: widget.restaurant.id,
        number: 4,
        capacity: 4,
        x: 15,
        y: 45,
        shape: TableShape.square,
        isBooked: false,
      ),
      RestaurantTable(
        id: 't5',
        restaurantId: widget.restaurant.id,
        number: 5,
        capacity: 4,
        x: 45,
        y: 45,
        shape: TableShape.square,
        isBooked: true,
      ),
      RestaurantTable(
        id: 't6',
        restaurantId: widget.restaurant.id,
        number: 6,
        capacity: 4,
        x: 75,
        y: 45,
        shape: TableShape.square,
        isBooked: false,
      ),
      RestaurantTable(
        id: 't7',
        restaurantId: widget.restaurant.id,
        number: 7,
        capacity: 6,
        x: 15,
        y: 75,
        shape: TableShape.rectangle,
        isBooked: false,
      ),
      RestaurantTable(
        id: 't8',
        restaurantId: widget.restaurant.id,
        number: 8,
        capacity: 6,
        x: 60,
        y: 75,
        shape: TableShape.rectangle,
        isBooked: true,
      ),
    ];
  }

  List<RestaurantTable> get filteredTables {
    switch (_filter) {
      case 'available':
        return tables.where((table) => !table.isBooked).toList();
      case '2-seater':
        return tables.where((table) => table.capacity == 2).toList();
      case '4-seater':
        return tables.where((table) => table.capacity == 4).toList();
      case '6-seater':
        return tables.where((table) => table.capacity == 6).toList();
      default:
        return tables;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Үстелді таңдаңыз',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.restaurant.name,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Легенда и статистика
          _buildLegendAndStats(),
          const Divider(height: 1),

          // Карта столов
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      // Фон ресторана
                      _buildRestaurantBackground(),
                      // Столы
                      ...filteredTables.map((table) {
                        return _buildTableWidget(
                          table,
                          constraints.maxWidth,
                          constraints.maxHeight,
                        );
                      }).toList(),
                      // Зоны ресторана
                      _buildRestaurantZones(constraints.maxWidth, constraints.maxHeight),
                    ],
                  );
                },
              ),
            ),
          ),

          // Панель выбранного стола
          if (selectedTable != null) _buildSelectedTablePanel(),
        ],
      ),
    );
  }

  Widget _buildLegendAndStats() {
    final availableTables = tables.where((table) => !table.isBooked).length;
    final totalTables = tables.length;

    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        children: [
          // Статистика
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem('Барлығы', '$totalTables', Colors.blue),
              _buildStatItem('Бос', '$availableTables', Colors.green),
              _buildStatItem('Бос емес', '${totalTables - availableTables}', Colors.red),
            ],
          ),
          const SizedBox(height: 12),
          // Легенда
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildLegendItem(Colors.grey.shade300, 'Бос'),
              _buildLegendItem(Colors.red.shade400, 'Бос емес'),
              _buildLegendItem(Colors.deepOrange, 'Таңдалған'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade400, width: 1),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildRestaurantBackground() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200, width: 2),
      ),
      child: Center(
        child: Opacity(
          opacity: 0.05,
          child: Icon(
            Icons.restaurant_rounded,
            size: 120,
            color: Colors.grey.shade800,
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurantZones(double maxWidth, double maxHeight) {
    return Stack(
      children: [
        // Зона у окна
        Positioned(
          left: 0,
          top: 0,
          child: Container(
            width: maxWidth * 0.3,
            height: maxHeight,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Colors.blue.shade100.withOpacity(0.5),
                  width: 2,
                ),
              ),
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Терезе жаны',
                  style: TextStyle(
                    color: Colors.blue.shade600,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
        // VIP зона
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            width: maxWidth * 0.4,
            height: maxHeight * 0.3,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.amber.shade300.withOpacity(0.5),
                  width: 2,
                ),
                left: BorderSide(
                  color: Colors.amber.shade300.withOpacity(0.5),
                  width: 2,
                ),
              ),
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'VIP алаң',
                  style: TextStyle(
                    color: Colors.amber.shade700,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTableWidget(RestaurantTable table, double maxWidth, double maxHeight) {
    final size = _getTableSize(table.shape, table.capacity);
    final isSelected = selectedTable?.id == table.id;

    Color tableColor;
    if (table.isBooked) {
      tableColor = Colors.red.shade400;
    } else if (isSelected) {
      tableColor = Colors.deepOrange;
    } else {
      tableColor = Colors.grey.shade300;
    }

    return Positioned(
      left: (table.x / 100) * maxWidth - size.width / 2,
      top: (table.y / 100) * maxHeight - size.height / 2,
      child: GestureDetector(
        onTap: table.isBooked
            ? () => _showTableInfo(table)
            : () {
          setState(() {
            selectedTable = selectedTable?.id == table.id ? null : table;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            color: tableColor,
            shape: table.shape == TableShape.circle ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: table.shape != TableShape.circle
                ? BorderRadius.circular(8)
                : null,
            border: Border.all(
              color: isSelected ? Colors.deepOrange.shade700 : Colors.grey.shade400,
              width: isSelected ? 3 : 2,
            ),
            boxShadow: isSelected
                ? [
              BoxShadow(
                color: Colors.deepOrange.withOpacity(0.4),
                blurRadius: 12,
                spreadRadius: 2,
              ),
            ]
                : [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${table.number}',
                  style: TextStyle(
                    color: table.isBooked || isSelected ? Colors.white : Colors.grey.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: table.capacity > 4 ? 16 : 18,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      table.isBooked ? Icons.lock_rounded : Icons.event_seat_rounded,
                      color: table.isBooked || isSelected ? Colors.white : Colors.grey.shade700,
                      size: table.capacity > 4 ? 12 : 14,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '${table.capacity}',
                      style: TextStyle(
                        color: table.isBooked || isSelected ? Colors.white : Colors.grey.shade700,
                        fontSize: table.capacity > 4 ? 10 : 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedTablePanel() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.event_seat_rounded,
                    color: Colors.deepOrange.shade700,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Үстел №${selectedTable!.number}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Сыйымдылығы: ${selectedTable!.capacity} адам',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.info_outline_rounded),
                  onPressed: () => _showTableInfo(selectedTable!),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookingScreen(
                        restaurant: widget.restaurant,
                        table: selectedTable!,
                      ),
                    ),
                  ).then((result) {
                    if (result == true) {
                      setState(() {
                        selectedTable!.isBooked = true;
                        selectedTable = null;
                      });
                    }
                  });
                },
                child: const Text(
                  'Брондауды жалғастыру',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Size _getTableSize(TableShape shape, int capacity) {
    switch (shape) {
      case TableShape.circle:
        return Size(capacity * 15 + 30, capacity * 15 + 30);
      case TableShape.square:
        return Size(capacity * 12 + 30, capacity * 12 + 30);
      case TableShape.rectangle:
        return Size(capacity * 12 + 40, capacity * 8 + 20);
    }
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Сүзгілер',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildFilterChip('Барлығы', 'all'),
                  _buildFilterChip('Бос үстелдер', 'available'),
                  _buildFilterChip('2 адам', '2-seater'),
                  _buildFilterChip('4 адам', '4-seater'),
                  _buildFilterChip('6+ адам', '6-seater'),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Қолдану'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterChip(String label, String value) {
    return ChoiceChip(
      label: Text(label),
      selected: _filter == value,
      onSelected: (selected) {
        setState(() {
          _filter = value;
        });
        Navigator.pop(context);
      },
      selectedColor: Colors.deepOrange,
      labelStyle: TextStyle(
        color: _filter == value ? Colors.white : Colors.black87,
      ),
    );
  }

  void _showTableInfo(RestaurantTable table) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: table.isBooked ? Colors.red.shade100 : Colors.green.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      table.isBooked ? Icons.lock_rounded : Icons.event_seat_rounded,
                      color: table.isBooked ? Colors.red.shade600 : Colors.green.shade600,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Үстел №${table.number}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          table.isBooked ? 'Бос емес' : 'Бос',
                          style: TextStyle(
                            color: table.isBooked ? Colors.red.shade600 : Colors.green.shade600,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildInfoRow('Сыйымдылығы', '${table.capacity} адам'),
              _buildInfoRow('Пішіні', _getTableShapeName(table.shape)),
              _buildInfoRow('Орналасуы', _getTableLocation(table.x, table.y)),
              const SizedBox(height: 24),
              Row(
                children: [
                  if (!table.isBooked) ...[
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            selectedTable = table;
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.deepOrange,
                          side: BorderSide(color: Colors.deepOrange.shade300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('Таңдау'),
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: table.isBooked ? Colors.deepOrange : Colors.grey.shade300,
                        foregroundColor: table.isBooked ? Colors.white : Colors.grey.shade600,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(table.isBooked ? 'Брондау' : 'Жабу'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            '$title:',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _getTableShapeName(TableShape shape) {
    switch (shape) {
      case TableShape.circle:
        return 'Дөңгелек';
      case TableShape.square:
        return 'Шаршы';
      case TableShape.rectangle:
        return 'Тік төртбұрыш';
    }
  }

  String _getTableLocation(double x, double y) {
    if (x < 33) return 'Терезе жаны';
    if (x > 66 && y > 66) return 'VIP алаң';
    if (y < 33) return 'Орталық алаң';
    return 'Негізгі зал';
  }
}