import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ModernImageCarousel extends StatefulWidget {
  final List<String> imageUrls;

  const ModernImageCarousel({super.key, required this.imageUrls});

  @override
  State<ModernImageCarousel> createState() => _ModernImageCarouselState();
}

class _ModernImageCarouselState extends State<ModernImageCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: _pageController,
          itemCount: widget.imageUrls.length,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.imageUrls[index]),
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            );
          },
        ),

        // Page Indicator
        Positioned(
          left: 0,
          right: 0,
          bottom: 30,
          child: Center(
            child: SmoothPageIndicator(
              controller: _pageController,
              count: widget.imageUrls.length,
              effect: const ExpandingDotsEffect(
                dotWidth: 8,
                dotHeight: 8,
                activeDotColor: Colors.white,
                dotColor: Colors.white54,
                spacing: 8,
                expansionFactor: 3,
              ),
            ),
          ),
        ),

        // Optional: Page Number Indicator
        // Positioned(
        //   top: MediaQuery.of(context).padding.top + 20,
        //   right: 20,
        //   child: Container(
        //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        //     decoration: BoxDecoration(
        //       color: Colors.black.withOpacity(0.5),
        //       borderRadius: BorderRadius.circular(20),
        //     ),
        //     child: Text(
        //       '${_currentPage + 1}/${widget.imageUrls.length}',
        //       style: const TextStyle(
        //         color: Colors.white,
        //         fontSize: 14,
        //         fontWeight: FontWeight.w500,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
