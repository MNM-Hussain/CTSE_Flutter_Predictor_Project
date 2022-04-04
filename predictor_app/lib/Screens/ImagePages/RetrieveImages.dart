import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:predictor_app/Screens/ImagePages/UploadImage.dart';

class RetreiveImages extends StatefulWidget {
  const RetreiveImages({Key? key}) : super(key: key);

  @override
  State<RetreiveImages> createState() => _RetreiveImagesState();
}

class _RetreiveImagesState extends State<RetreiveImages> {
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<List<Map<String, dynamic>>> loadImages() async {
    List<Map<String, dynamic>> files = [];

    final ListResult result = await storage.ref('images').list();
    final List<Reference> allFiles = result.items;

    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      final FullMetadata fileMeta = await file.getMetadata();
      files.add({
        "url": fileUrl,
        "path": file.fullPath,
        "uploaded_by": fileMeta.customMetadata?['uploaded_by'] ?? 'Nobody'
      });
    });

    return files;
  }

  Future<void> DeleteImage(String ref) async {
    await storage.ref(ref).delete();
    // Rebuild the UI
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Motivation"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => UploadImage(),
                fullscreenDialog: true,
              ));
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: loadImages(),
                builder: (context,
                    AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        final Map<String, dynamic> image =
                            snapshot.data![index];

                        // return Card(
                        //   margin: const EdgeInsets.symmetric(vertical: 10),
                        //   child: ListTile(
                        //     dense: false,
                        //     leading: Image.network(image['url']),
                        //     trailing: IconButton(
                        //       onPressed: () {},
                        //       icon: const Icon(
                        //         Icons.delete,
                        //         color: Colors.red,
                        //       ),
                        //     ),
                        //   ),
                        // );

                        // return Padding(
                        //     padding: const EdgeInsets.all(10.0),
                        //     child: Image.network(image['url']));

                        return Card(
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            children: [
                              Image.network(image['url']),
                              if (image['uploaded_by'] == user!.uid)
                                ButtonBar(
                                  alignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () =>
                                          DeleteImage(image['path']),
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                )
                            ],
                          ),
                        );

                        ///
                      },
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
