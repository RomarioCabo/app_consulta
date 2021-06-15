import 'package:cached_network_image/cached_network_image.dart';
import 'package:consulta_estados_cidades/shared/model/state_dto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StateTile extends StatefulWidget {
  final StateDTO state;

  StateTile({@required this.state});

  @override
  _StateTileState createState() => _StateTileState();
}

class _StateTileState extends State<StateTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 8,
        child: InkWell(
          onTap: (){},
          child: Row(
            children: [
              SizedBox(
                height: 88,
                width: 100,
                child: CachedNetworkImage(
                  imageUrl: widget.state.urlImage,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${widget.state.name} - ${widget.state.acronym}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Capital: ${widget.state.capital}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Região: ${widget.state.region}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
