import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets_app/config/menu/menu_item.dart';

//* En el SideMenu se va a necesitar saber cual es la opción seleccionada porque
// * se van cambiar y activar aopciones, es por ello debe ser un StatefulWidget
class SideMenu extends StatefulWidget {
  //* Recibe el estado del widget anterior (home_screen)
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({super.key, required this.scaffoldKey});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  //Para saber cual de las opciones del menú está seleccionada
  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    //* viewPadding indica cual es el padding que se tiene de una dirección (top, bottom, left, right)
    // Se puede estimar que si viewPadding.top > 35, es que el movil tiene un notch
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;

    //* Esto es un widget que tiene flutter por defecto y que está optimizado para
    // * que funcione como menú lateral
    return NavigationDrawer(
      //Esta propiedad hace que aparezca destacado el elemento del indice que se
      // le indica (navDrawerIndex)
      selectedIndex: navDrawerIndex,
      // Esta propiedad recoge el valor del indice del ultimo elemento pulsado y
      // mediante un método se puede guardar ese indice (navDrawerIndex) para usarlo
      // en la propiedad selectedIndex
      onDestinationSelected: (value) {
        setState(() {
          navDrawerIndex = value;
        });

        //* Para que navege a la opción seleccionada, hay que tender que el valúe
        // * indica el indice que ocupa la opción en la lista appMenuIntems
        // * así pues se obtiene el item que se encuentra en el indic "value",
        // * indexando en la lista appMenuIntems.
        // * Tras ello podemos acceder a la propiedad link del item y hacer un
        // * context.push a esa ruta.
        //!Ojo: recuerda que la navegacion context.push es gracias a la dependencia de go_router
        final menuItem = appMenuIntems[value];
        context.push(menuItem.link);
        //* Aquí se accede al estado del scaffold del home_screen para cerrar el drawer
        // * en caso de que esté abierto
        widget.scaffoldKey.currentState?.closeDrawer();
      },
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(28, hasNotch ? 5 : 20, 16, 10),
          child: const Text('Main '),
        ),
        //* Se debe construir los NavigationDrawerDestination atraves de los appMenuIntems
        // *Para ello se puede usar el operador spread:  ...
        // * y racorremos todos los elementos de la lista mediante un map que va a devolver
        // * un NavigationDrawerDestination por cada elementos de la lista appMenuIntems
        // * y se va a poder acceder a las propiedades de los mismo para mostrarlas/usarlas
        /* const NavigationDrawerDestination(
            icon: Icon(Icons.add), label: Text('Home Screen')), */
        /*  ...appMenuIntems.map((item) => NavigationDrawerDestination(
            icon: Icon(item.icon), label: Text(item.title))) */
        //* Se puede dar mejor aspecto al menú subdividiendolo y añadiendo barras divisorias
        ...appMenuIntems.sublist(0, 3).map((item) =>
            NavigationDrawerDestination(
                icon: Icon(item.icon), label: Text(item.title))),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
          child: Text('More Options '),
        ),
        ...appMenuIntems.sublist(3).map((item) => NavigationDrawerDestination(
            icon: Icon(item.icon), label: Text(item.title))),
      ],
    );
  }
}
