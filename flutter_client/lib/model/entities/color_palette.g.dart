// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color_palette.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsaColorPaletteCollection on Isar {
  IsarCollection<IsaColorPalette> get isaColorPalettes => this.collection();
}

const IsaColorPaletteSchema = CollectionSchema(
  name: r'IsaColorPalette',
  id: 134612897078638749,
  properties: {
    r'label': PropertySchema(
      id: 0,
      name: r'label',
      type: IsarType.string,
    ),
    r'order': PropertySchema(
      id: 1,
      name: r'order',
      type: IsarType.long,
    ),
    r'paletteColors': PropertySchema(
      id: 2,
      name: r'paletteColors',
      type: IsarType.objectList,
      target: r'IsarColor',
    )
  },
  estimateSize: _isaColorPaletteEstimateSize,
  serialize: _isaColorPaletteSerialize,
  deserialize: _isaColorPaletteDeserialize,
  deserializeProp: _isaColorPaletteDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'IsarColor': IsarColorSchema},
  getId: _isaColorPaletteGetId,
  getLinks: _isaColorPaletteGetLinks,
  attach: _isaColorPaletteAttach,
  version: '3.1.0+1',
);

int _isaColorPaletteEstimateSize(
  IsaColorPalette object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.label;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.paletteColors;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[IsarColor]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              IsarColorSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  return bytesCount;
}

void _isaColorPaletteSerialize(
  IsaColorPalette object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.label);
  writer.writeLong(offsets[1], object.order);
  writer.writeObjectList<IsarColor>(
    offsets[2],
    allOffsets,
    IsarColorSchema.serialize,
    object.paletteColors,
  );
}

IsaColorPalette _isaColorPaletteDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsaColorPalette();
  object.id = id;
  object.label = reader.readStringOrNull(offsets[0]);
  object.order = reader.readLongOrNull(offsets[1]);
  object.paletteColors = reader.readObjectList<IsarColor>(
    offsets[2],
    IsarColorSchema.deserialize,
    allOffsets,
    IsarColor(),
  );
  return object;
}

P _isaColorPaletteDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readObjectList<IsarColor>(
        offset,
        IsarColorSchema.deserialize,
        allOffsets,
        IsarColor(),
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isaColorPaletteGetId(IsaColorPalette object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _isaColorPaletteGetLinks(IsaColorPalette object) {
  return [];
}

void _isaColorPaletteAttach(
    IsarCollection<dynamic> col, Id id, IsaColorPalette object) {
  object.id = id;
}

extension IsaColorPaletteQueryWhereSort
    on QueryBuilder<IsaColorPalette, IsaColorPalette, QWhere> {
  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsaColorPaletteQueryWhere
    on QueryBuilder<IsaColorPalette, IsaColorPalette, QWhereClause> {
  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension IsaColorPaletteQueryFilter
    on QueryBuilder<IsaColorPalette, IsaColorPalette, QFilterCondition> {
  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterFilterCondition>
      labelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'label',
      ));
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterFilterCondition>
      labelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'label',
      ));
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterFilterCondition>
      labelEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterFilterCondition>
      labelGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterFilterCondition>
      labelLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterFilterCondition>
      labelBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'label',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterFilterCondition>
      labelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterFilterCondition>
      labelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterFilterCondition>
      labelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterFilterCondition>
      labelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'label',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterFilterCondition>
      labelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'label',
        value: '',
      ));
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterFilterCondition>
      labelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'label',
        value: '',
      ));
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterFilterCondition>
      orderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'order',
      ));
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterFilterCondition>
      orderIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'order',
      ));
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterFilterCondition>
      orderEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'order',
        value: value,
      ));
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterFilterCondition>
      orderGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'order',
        value: value,
      ));
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterFilterCondition>
      orderLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'order',
        value: value,
      ));
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterFilterCondition>
      orderBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'order',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterFilterCondition>
      paletteColorsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'paletteColors',
      ));
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterFilterCondition>
      paletteColorsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'paletteColors',
      ));
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterFilterCondition>
      paletteColorsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'paletteColors',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterFilterCondition>
      paletteColorsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'paletteColors',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterFilterCondition>
      paletteColorsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'paletteColors',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterFilterCondition>
      paletteColorsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'paletteColors',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterFilterCondition>
      paletteColorsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'paletteColors',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterFilterCondition>
      paletteColorsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'paletteColors',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension IsaColorPaletteQueryObject
    on QueryBuilder<IsaColorPalette, IsaColorPalette, QFilterCondition> {
  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterFilterCondition>
      paletteColorsElement(FilterQuery<IsarColor> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'paletteColors');
    });
  }
}

extension IsaColorPaletteQueryLinks
    on QueryBuilder<IsaColorPalette, IsaColorPalette, QFilterCondition> {}

extension IsaColorPaletteQuerySortBy
    on QueryBuilder<IsaColorPalette, IsaColorPalette, QSortBy> {
  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterSortBy> sortByLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.asc);
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterSortBy>
      sortByLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.desc);
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterSortBy> sortByOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.asc);
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterSortBy>
      sortByOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.desc);
    });
  }
}

extension IsaColorPaletteQuerySortThenBy
    on QueryBuilder<IsaColorPalette, IsaColorPalette, QSortThenBy> {
  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterSortBy> thenByLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.asc);
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterSortBy>
      thenByLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.desc);
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterSortBy> thenByOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.asc);
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QAfterSortBy>
      thenByOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.desc);
    });
  }
}

extension IsaColorPaletteQueryWhereDistinct
    on QueryBuilder<IsaColorPalette, IsaColorPalette, QDistinct> {
  QueryBuilder<IsaColorPalette, IsaColorPalette, QDistinct> distinctByLabel(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'label', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsaColorPalette, IsaColorPalette, QDistinct> distinctByOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'order');
    });
  }
}

extension IsaColorPaletteQueryProperty
    on QueryBuilder<IsaColorPalette, IsaColorPalette, QQueryProperty> {
  QueryBuilder<IsaColorPalette, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsaColorPalette, String?, QQueryOperations> labelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'label');
    });
  }

  QueryBuilder<IsaColorPalette, int?, QQueryOperations> orderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'order');
    });
  }

  QueryBuilder<IsaColorPalette, List<IsarColor>?, QQueryOperations>
      paletteColorsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paletteColors');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const IsarColorSchema = Schema(
  name: r'IsarColor',
  id: 2232408357637797596,
  properties: {
    r'a': PropertySchema(
      id: 0,
      name: r'a',
      type: IsarType.long,
    ),
    r'b': PropertySchema(
      id: 1,
      name: r'b',
      type: IsarType.long,
    ),
    r'g': PropertySchema(
      id: 2,
      name: r'g',
      type: IsarType.long,
    ),
    r'r': PropertySchema(
      id: 3,
      name: r'r',
      type: IsarType.long,
    )
  },
  estimateSize: _isarColorEstimateSize,
  serialize: _isarColorSerialize,
  deserialize: _isarColorDeserialize,
  deserializeProp: _isarColorDeserializeProp,
);

int _isarColorEstimateSize(
  IsarColor object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _isarColorSerialize(
  IsarColor object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.a);
  writer.writeLong(offsets[1], object.b);
  writer.writeLong(offsets[2], object.g);
  writer.writeLong(offsets[3], object.r);
}

IsarColor _isarColorDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarColor();
  object.a = reader.readLongOrNull(offsets[0]);
  object.b = reader.readLongOrNull(offsets[1]);
  object.g = reader.readLongOrNull(offsets[2]);
  object.r = reader.readLongOrNull(offsets[3]);
  return object;
}

P _isarColorDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension IsarColorQueryFilter
    on QueryBuilder<IsarColor, IsarColor, QFilterCondition> {
  QueryBuilder<IsarColor, IsarColor, QAfterFilterCondition> aIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'a',
      ));
    });
  }

  QueryBuilder<IsarColor, IsarColor, QAfterFilterCondition> aIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'a',
      ));
    });
  }

  QueryBuilder<IsarColor, IsarColor, QAfterFilterCondition> aEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'a',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarColor, IsarColor, QAfterFilterCondition> aGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'a',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarColor, IsarColor, QAfterFilterCondition> aLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'a',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarColor, IsarColor, QAfterFilterCondition> aBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'a',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarColor, IsarColor, QAfterFilterCondition> bIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'b',
      ));
    });
  }

  QueryBuilder<IsarColor, IsarColor, QAfterFilterCondition> bIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'b',
      ));
    });
  }

  QueryBuilder<IsarColor, IsarColor, QAfterFilterCondition> bEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'b',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarColor, IsarColor, QAfterFilterCondition> bGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'b',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarColor, IsarColor, QAfterFilterCondition> bLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'b',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarColor, IsarColor, QAfterFilterCondition> bBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'b',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarColor, IsarColor, QAfterFilterCondition> gIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'g',
      ));
    });
  }

  QueryBuilder<IsarColor, IsarColor, QAfterFilterCondition> gIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'g',
      ));
    });
  }

  QueryBuilder<IsarColor, IsarColor, QAfterFilterCondition> gEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'g',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarColor, IsarColor, QAfterFilterCondition> gGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'g',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarColor, IsarColor, QAfterFilterCondition> gLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'g',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarColor, IsarColor, QAfterFilterCondition> gBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'g',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarColor, IsarColor, QAfterFilterCondition> rIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'r',
      ));
    });
  }

  QueryBuilder<IsarColor, IsarColor, QAfterFilterCondition> rIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'r',
      ));
    });
  }

  QueryBuilder<IsarColor, IsarColor, QAfterFilterCondition> rEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'r',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarColor, IsarColor, QAfterFilterCondition> rGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'r',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarColor, IsarColor, QAfterFilterCondition> rLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'r',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarColor, IsarColor, QAfterFilterCondition> rBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'r',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension IsarColorQueryObject
    on QueryBuilder<IsarColor, IsarColor, QFilterCondition> {}
