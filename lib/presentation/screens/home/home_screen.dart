import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets_app/config/menu/menu_item.dart';
import 'package:widgets_app/presentation/widgets/side_menu.dart';

class HomeScreen extends StatelessWidget {
  static const String name = "HomeScreen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    //* Este key se puede construir dentro de un StatelessWidget, ya que
    // * este no se va a volver a contruir, pero no se puece hacer dentro
    // * de un StatefullWidget
    // * Este scaffoldKey (GlobalKey) va a guardar el ScaffoldState, es decir
    // * tine la referencia al estado actual de Scaffold (tiene drawer, etc.)
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Flutter + Material 3'),
      ),
      body: const _HomeView(),
      //* drawer es una propiead de Scaffold que saca un menú lateraldesde la izquierda
      // * tambien se dispone de endDrawer que saca el menú desde la derecha
      // * Para no sobrecargar esta vist se crea un widget customizado en
      // * otro archivo: lib\presentation\widgets\side_menu.dart
      drawer: SideMenu(scaffoldKey: scaffoldKey,),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: appMenuIntems.length,
      itemBuilder: (context, index) {
        final menuItem = appMenuIntems[index];

        return _CustomListTile(menuItem: menuItem);
      },
    );
  }
}

class _CustomListTile extends StatelessWidget {
  const _CustomListTile({
    required this.menuItem,
  });

  final MenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon(
        menuItem.icon,
        color: colors.primary,
      ),
      trailing: Icon(Icons.arrow_forward_ios_rounded, color: colors.primary),
      title: Text(menuItem.title),
      subtitle: Text(menuItem.subtitle),
      onTap: () {
        //? Con Navigator (Propio de Flutter)
        /* Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ButtonsScreen())); */
        //? Con router (Propio de Flutter)
        /* Navigator.pushNamed(context, menuItem.link); */

        //?Con GoRouter por link (Propio de GoRouter)
        context.push(menuItem.link);
        //?Con GoRouter por nombre de ruta (Propio de GoRouter)
        //*Para usar este método habria que añadir otro parámetro más al menItem (name)
        /* context.pushNamed( CardsScreen.name ); */
      },
    );
  }
}
