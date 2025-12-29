import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart';
import '../services/offline_service.dart';
import 'offline_dashboard.dart';

class MainContainer extends StatefulWidget {
  const MainContainer({super.key});

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  late final WebViewController _controller;
  int _selectedIndex = 0;
  String _currentTitle = "Home";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  void _initWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
              _updateTitle(url);
            });
            _injectCustomScripts(url);
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            // Handle external links or specific logic here
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(AppConstants.homeUrl));
  }

  void _injectCustomScripts(String url) {
    if (url.contains("hleduroom.com") && !url.contains("blogs.thehiteshsir.com")) {
      _controller.runJavaScript(AppConstants.jsHideHeaderFooter);
    }
  }

  void _updateTitle(String url) {
    String pageName = "Home";
    if (url.contains("/courses")) pageName = "Courses";
    else if (url.contains("/resources")) pageName = "Resources";
    else if (url.contains("/mock")) pageName = "Tests";
    else if (url.contains("/profile")) pageName = "Profile";
    else if (url.contains("/notes")) pageName = "Notes";
    else if (url.contains("/live")) pageName = "Live Class";
    else if (url.contains("/blogs")) pageName = "Blogs";
    
    setState(() {
      _currentTitle = pageName;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
    String url = AppConstants.homeUrl;
    switch (index) {
      case 0: url = "${AppConstants.homeUrl}"; break; // Home
      case 1: url = "${AppConstants.homeUrl}/courses"; break;
      case 2: url = "${AppConstants.homeUrl}/resources"; break;
      case 3: url = "${AppConstants.homeUrl}/mock"; break;
      case 4: url = "${AppConstants.homeUrl}/profile"; break;
    }
    _controller.loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    final offlineService = Provider.of<OfflineService>(context);

    if (offlineService.isOffline) {
      return const OfflineDashboard();
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(45),
        child: AppBar(
          title: Text("H.L.-Eduroom | $_currentTitle"),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: AppColors.primary,
              height: 1.0,
            ),
          ),
        ),
      ),
      drawer: _buildDrawer(),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Courses'),
          BottomNavigationBarItem(icon: Icon(Icons.library_books), label: 'Resources'),
          BottomNavigationBarItem(icon: Icon(Icons.quiz), label: 'Tests'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: AppColors.primary),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.school, color: Colors.white, size: 40),
                SizedBox(height: 10),
                Text(
                  'H.L.-Eduroom',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          _drawerItem(Icons.home, 'Home', () => _loadUrl(AppConstants.homeUrl)),
          _drawerItem(Icons.note, 'Notes', () => _loadUrl("${AppConstants.homeUrl}/notes")),
          _drawerItem(Icons.live_tv, 'Live Class', () => _loadUrl("${AppConstants.homeUrl}/live")),
          _drawerItem(Icons.notifications, 'Notices', () {}),
          const Divider(),
          _drawerItem(Icons.download, 'Downloads', () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/offline');
          }),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary, size: 20),
      title: Text(title, style: const TextStyle(fontSize: 12)),
      onTap: () {
        Navigator.pop(context); // Close drawer
        onTap();
      },
    );
  }

  void _loadUrl(String url) {
    _controller.loadRequest(Uri.parse(url));
  }
}
