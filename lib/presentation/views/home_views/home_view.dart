
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upComingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    final initialLoading = ref.watch(initialLoadingProvider);
    if ( initialLoading ) return const FullScreenLoader();

    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upComingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    return CustomScrollView(
      slivers: [

          const SliverAppBar(
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: CustomAppbar(),
            ),
          ),


          SliverList(delegate: SliverChildBuilderDelegate(
            (context, index){
              return  Column(
        children: [
          MoviesSlideshow(movies: slideShowMovies),
      
          MovieHorizontalListView(
            movies: nowPlayingMovies,
            title: 'En Cines',
            subTitle: 'Miercoles 15',
            loadNextPage: () {
              ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
            },
            
            ),
              MovieHorizontalListView(
            movies: upcomingMovies,
            title: 'Proximamente',
            subTitle: 'Este Mes',
            loadNextPage: () {
              ref.read(upComingMoviesProvider.notifier).loadNextPage();
            },
            
            ),
            MovieHorizontalListView(
            movies: popularMovies,
            title: 'Populares',
            // subTitle: 'Miercoles 15',
            loadNextPage: () {
              ref.read(popularMoviesProvider.notifier).loadNextPage();
            },
            
            ),

              MovieHorizontalListView(
            movies: topRatedMovies,
            title: 'Mejor Calificadas',
            subTitle: 'Desde Siempre',
            loadNextPage: () {
              ref.read(topRatedMoviesProvider.notifier).loadNextPage();
            },
            
            ),
            const SizedBox(height: 10)
          // Expanded(
          //     child: ListView.builder(
          //   itemCount: nowPlayingMovies.length,
          //   itemBuilder: (context, index) {
          //     final movie = nowPlayingMovies[index];
          //     return ListTile(
          //       title: Text(movie.title),
          //     );
          //   },
          // ))
        ],
      );
            },
            childCount: 1,
          )),
      ]
     
    );
  }
}
