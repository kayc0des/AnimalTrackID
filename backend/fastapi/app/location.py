import geocoder

# Get your location based on your IP address
g = geocoder.ip('me')

# Print the location details
if g.ok:
    print("Your approximate location:")
    print(f"Latitude: {g.latlng[0]}")
    print(f"Longitude: {g.latlng[1]}")
    print(f"City: {g.city}")
    print(f"State: {g.state}")
    print(f"Country: {g.country}")
    print(f"Address: {g.address}")
else:
    print("Failed to retrieve location.")