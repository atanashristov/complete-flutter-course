/// Address information used for shipping.
class Address {
  const Address({
    required this.address,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
  });

  final String address;
  final String city;
  final String state;
  final String postalCode;
  final String country;

  @override
  String toString() {
    return 'Address(address: $address, city: $city, state: $state, postalCode: $postalCode, country: $country)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Address &&
        other.address == address &&
        other.city == city &&
        other.state == state &&
        other.postalCode == postalCode &&
        other.country == country;
  }

  @override
  int get hashCode {
    return address.hashCode ^ city.hashCode ^ state.hashCode ^ postalCode.hashCode ^ country.hashCode;
  }
}
