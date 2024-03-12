import 'package:flutter/material.dart';
import 'ConfirmationPage.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  int _guests = 1;
  int _rooms = 1;

  void _incrementGuests() {
    setState(() {
      _guests++;
    });
  }

  void _decrementGuests() {
    if (_guests > 1) {
      setState(() {
        _guests--;
      });
    }
  }

  void _incrementRooms() {
    setState(() {
      _rooms++;
    });
  }

  void _decrementRooms() {
    if (_rooms > 1) {
      setState(() {
        _rooms--;
      });
    }
  }

  void _navigateToConfirmation() {
    Navigator.pushNamed(
      context,
      '/Second',
      arguments: {
        'guests': _guests,
        'rooms': _rooms,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotels'),
      ),
      body: Column(
        children: [
          // Location row
          Row(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.edit_location,
                    size: 36.0,
                  ),
                  Text(
                    'Las Vegas, NV',
                    style: TextStyle(fontSize: 24.0),
                  ),
                ],
              ),
            ],
          ),
          // Guests row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.people,
                    size: 36.0,
                  ),
                  Text(
                    '$_guests Guests',
                    style: TextStyle(fontSize: 24.0),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: _decrementGuests,
                    icon: Icon(Icons.remove),
                  ),
                  IconButton(
                    onPressed: _incrementGuests,
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
          // Rooms row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.bed,
                    size: 36.0,
                  ),
                  Text(
                    '$_rooms Room',
                    style: TextStyle(fontSize: 24.0),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: _decrementRooms,
                    icon: Icon(Icons.remove),
                  ),
                  IconButton(
                    onPressed: _incrementRooms,
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
          // Check-in row
          Row(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.arrow_right,
                    size: 36.0,
                  ),
                  Text(
                    'Today',
                    style: TextStyle(fontSize: 24.0),
                  ),
                ],
              ),
            ],
          ),
          //Check-out row
          Row(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.arrow_left,
                    size: 36.0,
                  ),
                  Text(
                    'Tomorrow',
                    style: TextStyle(fontSize: 24.0),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 50.0,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'You are trying to book $_guests guests and $_rooms rooms',
                      ),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.green,
                    ),
                  );
                });
              },
              child: Text(
                'Reserve',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 350.0,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _navigateToConfirmation,
              child: Text(
                'Book Hotels',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
