# apple.md


## developer account
a) developer.apple.com
<br/>
b) create account
<br/>
c) registration info
<br/>
d) agree to legal
<br/>
e) confirmation email
<br/>
f) ios developer program - join today
<br/>
g) $99/year - enroll now
<br/>
h) sign in using existing/new apple ID - continue
<br/>
i) individual
<br/>
j) personal information
<br/>
k) ios developer program - continue
<br/>
l) payment information ($99.00+$7.43=$106.43)
<br/>
m) email notification - order is being processed 
n) after a few minutes/hours account will be updated
<br/>
o) 
<br/>
p) 
<br/>



## certs
developer.apple.com > 
App ID Description: Mystery Game App
Explicit App ID: com.johnandrichie.mystery
Enable Services: Push Notifications
(Game Center & In App Purchases by default)
> Complete > Done


developer.apple.com > (iOS) Certificates > + (New) >
* iOS App Development
> Create CSR:
  Keychain Access > Certificate Assistant > Request Certificate From a Certificate Authority
  <br/>
  User Email: zirbsster@gmail.com
  <br/>
  Common Name: Zirbsster
  <br/>
  * Saved to Disk
  <br/>
> Continue > Choose File > (Select) > Generate > Download > Done
<br/>
* Production > App Store & Ad Hoc
  (Create CSR)
> Continue > Choose File > (Select) > Generate > Download > Done



<br/>



## devices
developer.apple.com > Devices > + (New) >
Name: Richie iPhone5
UDID: e86c92f35ac6f0e48086567936f3ae1c7bac7fdf
> Register


## profiles

Provisioning Profiles > 
* iOS App Development > + (New) >
> App ID: mystery
> Certificates: Zirbsster
> Devices: (select)
> Profile Name: Mystery Development Profile
> Download

* Distribution > + (New) >
* iOS App Distribution
> App ID: mystery
> Certificates: Zirbsster
> Devices: (select)
> Profile Name: Mystery Profile Distribution Ad Hoc
> Download


Development / Development
Development / Ad Hoc
Development / App Store
Distribution / Development
Distribution / Ad Hoc
Distribution / App Store







## components

* Private Key (person)
    - certificate list

* Developer Certificate (Dev Account)
	- private key
	- profile list

* Device (physical iOS device)
	- UDID
	- provisioning profile list

* Application (app)
	- AppID
	- profile list

* Provisioning Profile
	- application
	- developer cert
	- device list
	- root cert

* Apple Root Certificate





