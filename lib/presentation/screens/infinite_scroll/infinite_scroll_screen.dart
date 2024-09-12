import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InfiniteScrollScreen extends StatefulWidget {
  static const name = "infinite_scroll_screen";
  const InfiniteScrollScreen({super.key});

  @override
  State<InfiniteScrollScreen> createState() => _InfiniteScrollScreenState();
}

class _InfiniteScrollScreenState extends State<InfiniteScrollScreen> {
  List<int> imagesIds = [0, 1, 2, 3, 4, 5];
  final ScrollController scrollController = ScrollController();
  //* Bandera para simular carga en conexion asincrona
  bool isLoading = false;
  //* Bandera para comprobar que el usuario no se sale durante la carga de nuevos elementos
  bool isMounted = true;

  //* Al trbajajar con un controlador hay que iniciar/terminar el ciclo de vida del mismo
  //* En el initState el super.initState debe estar al pricipio
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      //Posicion actual: scrollController.position.pixels;
      //Posicion maxima alcanzable: scrollController.position.maxScrollExtent;

      if ((scrollController.position.pixels + 500) >=
          scrollController.position.maxScrollExtent) {
        //* El método addFiveImages es inmediato así que se implementa
        // * este método para simular una conexión asincrona, en la que se espera a
        // * la respuesta del servidor
        loadNextPage();
      }
    });
  }

  //* En el dispose el super.disposer debe estar al final
  //* El dispose se llama cuando el componente está siendo destruido o está marcado para ser destruido
  @override
  void dispose() {
    scrollController.dispose();
    //* Se modifica el valor aqui, en el punto en el que el componente va a ser destruido
    isMounted = true;
    super.dispose();
  }

  Future loadNextPage() async {
    //* Previene que se lance la petición Si ya está cargando
    if (isLoading) return;
    isLoading = true;
    setState(() {});
    //? Hasta este punto todo era sincrono
    await Future.delayed(const Duration(seconds: 2));
    addFiveImages();
    isLoading = false;
    //* Revisar si está montado el componente / widget
    // Como la carga es asincrona, si el usuario se sale pop durante la carga,
    // Se puede lanzar el setState en el componente / y producir exepcions y/o romper la app
    //? Aquí es donde hay que revisar si todo está montado o no
    if (!isMounted) return;

    setState(() {});
     //* Una vez iniciada la carga de los nuevos elementos se produce el scroll hacia abajo
     // * para que el usuario sepa que hay más elementos hacia abajo
    moveScrollToBotton();
  }

  Future<void> onRefresh() async {
    isLoading = true;
    setState(() {});
    await Future.delayed(const Duration(seconds: 3));
    if (!isMounted) return;

    isLoading = false;
    final lastId = imagesIds.last;
    // Esto borra el contenido de la lista:
    imagesIds.clear();
    imagesIds.add(lastId + 1);
    addFiveImages();

    setState(() {});
  }

  void moveScrollToBotton() {
    //*Hay que determinar la posición del usuario, para que solo se vaya hacia abajo cunado
    // * esté muy cerca del final
    // Si el usuario está en la posición de pixels (scrollController.position.pixels) 100 y
    // la posición másxima (scrollController.position.maxScrollExtent) es 110, lacondición
    // del if no se cumple u haría scroll automatico hasta el final.
    // En caso de no cumplir la condición el usuario se cumpueda donde está
    if (scrollController.position.pixels + 150 <=
        scrollController.position.maxScrollExtent) return;

    scrollController.animateTo(scrollController.position.pixels + 120,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn);
  }

  void addFiveImages() {
    //* .last obtiene el ultimo valor de una lista
    final lastId = imagesIds.last;

    //* .addAll añade todos los resultados del map, a la lista sobre la que se ejecuta
    imagesIds.addAll([1, 2, 3, 4, 5].map((e) => lastId + e));
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      /* appBar: AppBar(
        title: const Text('InfiniteScroll'),
      ), */

      //* Este widget MediaQuery.removePadding sirve para elimiar la barra superior
      // * donde se muestra la bateria, notificaiones etc.
      // * Y casos de otros móviles tambien la barrrar inferior
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: RefreshIndicator(
          edgeOffset: 10,
          strokeWidth: 2,
          //* Debe llamar al método onRefresh para ejecutar la llamada a la 'API' y controlar el estado de la carga
          onRefresh: onRefresh,
          //* El builer hace que los elementos se construyan bajo demanda, y no tener el
          // * Screen con todos los elementos cargados, ya que sería poco eficiente
          // * El builer sabe cuando estan apunto de entrar en pantalla para así generarlos
          // * Tambien maneja en caché las imagenes por lo que no se van a perder (es muy eficiente)
          child: ListView.builder(
              controller: scrollController,
              //* indica la cantidad de elementos que se deben/pueden cargar
              itemCount: imagesIds.length,
              //* Construye los elementos a cargar
              itemBuilder: (context, index) {
                // * Permite cargar una imagen y mientras se carga la imagen muestra un placeholder
                return FadeInImage(
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 300,
                  placeholder:
                      const AssetImage('assets/images/jar-loading.gif'),
                  image: NetworkImage(
                      'https://picsum.photos/id/${imagesIds[index]}/500/300'),
                );
              }),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => isLoading ? null : context.pop(),
        backgroundColor: colors.primary,
        child: isLoading
            ? SpinPerfect(
                infinite: true,
                child: const Icon(
                  Icons.refresh_rounded,
                  color: Colors.white,
                ))
            : const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
      ),
    );
  }
}
