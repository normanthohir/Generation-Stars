// Container(
//             margin: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.1),
//                   spreadRadius: 2,
//                   blurRadius: 8,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: ListTile(
//               leading:
//                   const Icon(Icons.calendar_today, color: Color(0xFF6F35A5)),
//               title: Text(
//                 'Pilih Tanggal',
//                 style: GoogleFonts.poppins(
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               subtitle: Text(
//                 DateFormat('EEEE, d MMMM y').format(_selectedDate),
//                 style: GoogleFonts.poppins(),
//               ),
//               trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//               onTap: () => _selectDate(context),
//             ),
//           ),