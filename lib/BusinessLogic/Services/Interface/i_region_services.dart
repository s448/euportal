import 'package:eup/Model/region_model.dart';

abstract class IRegionService {
  deleteRegion(String id);
  Stream<List<Region>> regionsStream();
  addRegion(Region region);
}
