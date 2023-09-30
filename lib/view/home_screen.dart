import 'package:flutter/material.dart';
import 'package:mvvm_architecture/data/responses/status.dart';
import 'package:mvvm_architecture/res/app_colors.dart';
import 'package:mvvm_architecture/utils/Routes/routes_name.dart';
import 'package:mvvm_architecture/view_modal/movie_list_view_model.dart';
import 'package:mvvm_architecture/view_modal/user_view_model.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  MovieViewViewModel movieViewViewModel = MovieViewViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieViewViewModel.fetchMovieData();
  }

  @override
  Widget build(BuildContext context) {

    final userpreference = Provider.of<UserViewModel>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.appBarColor,
          title: const Text("Home"),
          actions: [
            Center(
              child: InkWell(
                onTap: (){
                  userpreference.logOut().then((value){
                    Navigator.pushNamed(context, RoutesName.login);
                  }).onError((error, stackTrace) => null);
                },
                child: const Text("Logout"),
              ),
            ),
          ],

        ),
        body: ChangeNotifierProvider<MovieViewViewModel>(create: (BuildContext context) => movieViewViewModel,
        child: Consumer<MovieViewViewModel>(
          builder: (context, value, _){
            switch(value.movieList.status){
              case Status.LOADING:
                return const CircularProgressIndicator();
              case Status.ERROR:
                return Text(value.movieList.message.toString());
              case Status.COMPLETED:
                return ListView.builder(
                    itemCount: value.movieList.data!.movies!.length,
                    itemBuilder: (context, index){
                  return Card(
                    child: ListTile(
                      leading: Image(
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                        image: NetworkImage(value.movieList.data!.movies![index].posterurl.toString()),
                      errorBuilder: (context, error, stack){
                        return const Icon(Icons.error, color: Colors.red,);
                      },
                      ),
                      title: Text(value.movieList.data!.movies![index].title.toString()),
                      subtitle: Text(value.movieList.data!.movies![index].year.toString()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(Utils.averageRating(value.movieList.data!.movies![index].ratings!).toStringAsFixed(1)),
                          const Icon(Icons.star,color: Colors.redAccent,)
                        ],
                      ),
                    ),
                  );
                });
              default :
                return const Text("Noting to display");
            }
          },
        ),
        )
      ),
    );
  }
}
