import 'package:bkapp_flutter/Constants.dart';
import 'package:bkapp_flutter/utils/GenresUtil.dart';
import 'package:flutter/material.dart';
import 'package:bkapp_flutter/entity/movie/results.dart';

//Created by 1vPy on 2019/10/21.

class MovieListItem extends StatefulWidget {
  final Results results;

  final Function toDetail;

  final String tag;

  MovieListItem(this.results, this.toDetail, this.tag);

  @override
  State<StatefulWidget> createState() => MovieListItemState();
}

class MovieListItemState extends State<MovieListItem> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        height: 120,
        child: GestureDetector(
          child: Card(
            child: Row(
              children: <Widget>[
                Hero(
                    tag: '${widget.tag}${widget.results.id}',
                    child: Container(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: FadeInImage.assetNetwork(
                        width: 80,
                        height: 120,
                        placeholder: "images/movie_placeholder_image.png",
                        image:
                            '${Constants.image_prefix}/w200/${widget.results.poster_path}',
                        fit: BoxFit.cover,
                      ),
                    ))),
                Container(
                  margin: EdgeInsets.only(left: 5, top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.results.title,
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        '原名：${widget.results.original_title}',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        '类型：${GenresUtil.instance.id2Genres(widget.results.genre_ids)}',
                        style: TextStyle(fontSize: 12),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('评分：', style: TextStyle(fontSize: 12)),
                          Text(
                            widget.results.vote_average,
                            style: TextStyle(
                                fontSize: 12, color: Colors.redAccent),
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 5),
                              child:
                                  Text('热度：', style: TextStyle(fontSize: 12))),
                          Text(
                            widget.results.popularity.toString(),
                            style: TextStyle(
                                fontSize: 12, color: Colors.amberAccent),
                          )
                        ],
                      ),
                      Text(
                        '首映：${widget.results.release_date}',
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                )
              ],
            ),
            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          ),
          onTap: () {
//            _toDetail(_items[index]);
            widget.toDetail(widget.results);
          },
        ));
  }
}
