Return-Path: <linux-arch+bounces-13437-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C021B49FAE
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 05:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01C7F446A0D
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 03:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6AC25A324;
	Tue,  9 Sep 2025 03:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Iiio6PXm"
X-Original-To: linux-arch@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19011008.outbound.protection.outlook.com [52.103.11.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EED25A2C7;
	Tue,  9 Sep 2025 03:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757387365; cv=fail; b=Py1GZ6TlUhtXi/fPYx3sWAQQOu85rZiGjGoDZtGlO3FUV9oSnc99jZo2qiUztFDA6iidkAZDEjJ2FlIcAGOpfRmFI5oFXfD6xNbmz+i3Gs69csFWutrOVk60dNHpBqE/lNFLhTYwI7+0VoLuFCUVLi3A+AJ8rfRiXn5po0ajZlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757387365; c=relaxed/simple;
	bh=VKVD5qOJ3m1scvnfr7nLl1qvHzUkNmey4xFZeh6ccJc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kma4B3IukEgSniXFndNN28h2+laa2yuiG5Vwe+D4Af0dmlQOvjQ0EgPLJb9sEnDryM2TqO/HkBRHuDz3D7Jc29WvQpOmnb9OnqXuFKbwqHfQ9dewOmsKVk5l1WWFJhw9JqZ6Ovdi8AW6Bb9Jxt4EY88cw+t0hCrpWoZGZ42I1j8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Iiio6PXm; arc=fail smtp.client-ip=52.103.11.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFUoz/P//soKXcC6w9RevKwmWrSUDfFw/EOLjpYNHQpAUpeqQe+tB/81l+hsbaiqxXrRY0YkwGeI4ldZcbM3aCVNU9roCF7853pyuV+ly3xGfopuPQO3yJbf1mrDLp53tJv6VJA0ggLK3R2RQiBgz8EOGujrMmbTN6vCEujzVu7Ol5Txs0sP5/sfSoUBhdznXsr9xEa5slAG3y6dyKFYGdHcTMYRL/0uVzJMYC/P7iIm2ueUFz22IpUhHAFwvwijSS5K6ge93t92C0WMCMMKnlx3PKBv+tIrIubaENad9titCQiNe6M7S6V+Ze8FdNHYiOUwkXiK0v23yIMFV/Bs3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzpTGTJwVKgL7Sj/XQL+ucmWlrHuW1DQ/Y0gXcnBZXM=;
 b=OUibp6HVPyCC4wz3tuBi9hR4l48XDhQV/YC/PsAlJi0xBFgbBTPNPg10GEVWCZXeQvW750OIZO22Uu5qZzZi1sLfpia8acGUoHd0TjUiEjpS6XDKOyBBycTOX/WaBcDLcX1+Ba3FSRH3tAxB7ceG4Bwa2xCBzHKi4Gxya+RkmU0P/P2ErY8kdtyb46Aw68oXaItpGS/BATHjF1YbBk/6C5ZNZedbJDim+lbqIAlY0ephEy9J+WYdavYoMEQFvaXFxj6PLinA0oBletLTvewE2RAsi7qz170IY/FD1+ca/0ZUDvWewXIf9RJ5ueM84atqifLt1m/UODAuVmeZBRnt6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzpTGTJwVKgL7Sj/XQL+ucmWlrHuW1DQ/Y0gXcnBZXM=;
 b=Iiio6PXmQpQQOLAurKqwVNIyifzUPHDlpi4UlIEACcNBn1LROFf1phHM5x1Cv/C4e3fu5NmK/GVgThccnekm2G3/tvaKWbnoFTkEzJXH68C0MJY2RQLqlP6F5So3zW8yQT7uyoLck+JXHoqxzCOfeyHPgJanPXO6EZ1sR2hsU/uLzwqDI7i3oDe4plCRjsP9CxNt5z0/F1fI1kdX1oh/xW/zhF3p7YrDyXrh9U17bN+F88I7arVIVECDHM69dF3qJmMup/oPQsnbfv8zRB1GQN5MpPkvt2Oik/FGzMe/O9ZpSkv4bmBqp7rzxWliVQOI+BrqlJIoC3PwHll/q6gmxw==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by DM8PR02MB8055.namprd02.prod.outlook.com (2603:10b6:8:18::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Tue, 9 Sep
 2025 03:09:20 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef%4]) with mapi id 15.20.9094.018; Tue, 9 Sep 2025
 03:09:20 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "mikelley@microsoft.com"
	<mikelley@microsoft.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "Tianyu.Lan@microsoft.com"
	<Tianyu.Lan@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
CC: "benhill@microsoft.com" <benhill@microsoft.com>, "bperkins@microsoft.com"
	<bperkins@microsoft.com>, "sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v5 01/16] Documentation: hyperv: Confidential
 VMBus
Thread-Topic: [PATCH hyperv-next v5 01/16] Documentation: hyperv: Confidential
 VMBus
Thread-Index: AQHcF7f/mdWHUV1+6EKwR9hlD0+GS7SJ6lcg
Date: Tue, 9 Sep 2025 03:09:20 +0000
Message-ID:
 <BN7PR02MB41483CDBDB7475FAAB754BF1D40FA@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20250828010557.123869-1-romank@linux.microsoft.com>
 <20250828010557.123869-2-romank@linux.microsoft.com>
In-Reply-To: <20250828010557.123869-2-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|DM8PR02MB8055:EE_
x-ms-office365-filtering-correlation-id: 31c1209f-07cb-4d9b-0a25-08ddef4e453e
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|19110799012|8062599012|13091999003|461199028|31061999003|15080799012|10035399007|3412199025|440099028|40105399003|12091999003|102099032|56899033;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?esemdWQzSSGsY3f63NCvmgYxXy2GIOEpIKJFXqlTEDkyezkNH9hZPjTxvf2Q?=
 =?us-ascii?Q?XXq2llbpPSVw7ZbZlaQDmMTpBlti3XriGkujR7bX/f8F0F4aOgqRUHPLnCLX?=
 =?us-ascii?Q?NIuaA6BtyojbMb/6oYYXrxezGAJWe2kJrjviP/ibB+u6tvJxsWp2A6e8UM3h?=
 =?us-ascii?Q?TqFqBdkAQ4vA5BLVny+Ytv42dzKRNs2/1Rr6VSmVTPKdBNfFnLsjf67j3Jm0?=
 =?us-ascii?Q?quOV53iE4OQZk3c+EF7jGOAFnEW+8u7bhASPYpvxSyC3tYfYTPYtQLzOkLz5?=
 =?us-ascii?Q?xhecqhxryaAL4YOjCqDw+wqPZhzuiZaYI/yM9ubGDUCwBZPSnRC8fBFRWumh?=
 =?us-ascii?Q?BXBnlVxhbxRB7Nwu2WAx6GY4jrZOo/FecPLkHYdLeAw63mg2VxVipRXkFuC3?=
 =?us-ascii?Q?9InFz1AsPKbCnvA2rsTFUwjS04pQ7Ui6NN2YJ//uMO6ASszTEFaO8QkCYDFX?=
 =?us-ascii?Q?psxD03/B9K8HIkbsr+HhsN2Ao8Brj574wkH59MunmKtKuEYN5VpBu10NmRIu?=
 =?us-ascii?Q?UDpTxIECvL/dSXEmmZbkNSIfeHGSY1VYcRskjoCHYRkC3/A/08T5Cgm1gznZ?=
 =?us-ascii?Q?qpsMNqiCACydpzFWproZRTp8E/NJclV0JMbrEMef2L0D4s1AvJm2kdp7go3p?=
 =?us-ascii?Q?Fs7PWXO9RrBbqVExVA/sxx5lQGr0sI+ImdxCD8Xlp6rvxC9XVsxxtu4QZONs?=
 =?us-ascii?Q?XJ+abrla8mKcDo4hwYJHtOchiSh4LvKUqHQgYktcow54px+d9J7MVu6rGo1T?=
 =?us-ascii?Q?cRRRuZgGPk/Qrf49+T79j3WnpiiIAFhsFxwVRlzJXcvlF7NzqKYiWz2eNWVK?=
 =?us-ascii?Q?Juc8BSMrcBoHDdtWTEB4hoOapaoIEnu/0NJV4km0EQml5Gqv7rlAkIhckibH?=
 =?us-ascii?Q?/AyvFQTDr59hkc8PudbL717Pjl+g29uPZHXx+2Q6Yd/yJKFeVswua+x2Q/KV?=
 =?us-ascii?Q?1Vrbu9cOWyUKU7ZsToBrR9VnEcWk7fhVnjscTYazq3JQnRgdxxJQe/WzhdxO?=
 =?us-ascii?Q?+JydfpPeskBBWXM/kbEdpsEDhiGyqg9jwsZoXqQWodbKm78Z7cwfayCdE/ND?=
 =?us-ascii?Q?WiaWqYlbRVgw8dVkUcsOS7OqYWTLK00DQpnwbpicLZA5JLNH8VLvWr82Dm2O?=
 =?us-ascii?Q?XTFdfZ9ost2yw3CXn+zOEbhhOfpTy1rLWgSIcCO9/j4tpxQQjBa6qIWGI+cN?=
 =?us-ascii?Q?g//rpZedrx3lw8A/QzpD19FzJm94bwNWDRaVNf8mJswSyi8qI7ghf7xG2pM?=
 =?us-ascii?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?K7UjO6AVhKSM22C0FC6JtEmrz2mTTvgGVVpeklWgyMsNP9v+eLqF4Mcm05DB?=
 =?us-ascii?Q?8lQHTBiRY18O8FPks+WoaWn74/Wc0jX8Bl8gmjNFBAG2ExEwEuVbKgP7UPP2?=
 =?us-ascii?Q?O/BLvHnfywi6Q/bK/Y0WRbPxCbXXAFrdZpBMD67z+gHY8/up/WqzqHooKZ+/?=
 =?us-ascii?Q?nOLLdmY+AZqFpOmMVrUzqXLtAyaglVmUxzrGyyEb6apnPUvPQwrY/fLe94eJ?=
 =?us-ascii?Q?7R/ynYC50veO202S9sQV6//jx60FQkYzcIn7Mz8Bwz3a22Do4xXwKlGJvypR?=
 =?us-ascii?Q?OY/fxq88xc5Tz/GvBUH0cUWQ3+Ce938etpCton/YWfKGRqKAAZswxssTUvU/?=
 =?us-ascii?Q?5FCpdPi+uJj6OWlHtZrNhDuBj6Q9SC4fs3zsMkhBcJNDFUGJ+7JUANwuaS1W?=
 =?us-ascii?Q?nI4sSsEg6aTWKRhUzU4Z2ZA10g9vA4nTRb9my9e478oPd+KIojuU26NvaxMv?=
 =?us-ascii?Q?qWJmOCDwTJWKpHg/h/jUZY0iXsMZqwwf7WmhzE0ivYQjBJs2B0Mvi1GF9oWx?=
 =?us-ascii?Q?syjkEZ3S/ap9alQpBOlWJuxt96sCQpFngZi1ipRevW3LmdlessIs2Uef7yah?=
 =?us-ascii?Q?9cVCB+Rr8fVJmtGyQPTvr7QmsvGVU6Fmc/cFEepAgmRngvntCaw2to9wz5yf?=
 =?us-ascii?Q?8HtC6PHmkMSFoKj1bv0SfLGF+EFAXygdwVxQHeB4khLOffDNxc0VqAUElFxl?=
 =?us-ascii?Q?QSFGGRkf892PMbEEdbAuRR4llP81PxHRK8Sz4J4oUU9CdAbkD1kBZCHVxjTB?=
 =?us-ascii?Q?MSAs8pYHXo7newwl2k1bL+8EVbb6rdikUfXhwuMudUembtr7Ze+TxtozfO5A?=
 =?us-ascii?Q?OSlzaaxl0bd/FfKvnzorYPcaE9+XZzy61Syt01Kf9YmzyX4WX0fNrBM7rUUx?=
 =?us-ascii?Q?RonkBYPcJrCCDX1NVHBCIojaRwTinBCty2FWqLqcmqqxjxWgmhcXOZkXDcHt?=
 =?us-ascii?Q?PF1BNSsCmwHmsHm3XNI/IRJztT91Pm9m2Zo+mLQyTrK1pujBqfXUT5WX8GVP?=
 =?us-ascii?Q?raPAPPjFDYUzG+EsPrLh7QrS4zqeqinYfzEjd5V0qhdi47nvxGNK1nTYWsyC?=
 =?us-ascii?Q?hM1DtptAYAuEjLsb1nqbx4pbtJeAKChuNKsxZEiSh+O1X8m4A8p7UyoNIqkF?=
 =?us-ascii?Q?XwOySq4zocw1wM/0fMEWSuv3ezaEFR9UBRaNC/jCGacsolbicXz9ifI6bmqy?=
 =?us-ascii?Q?+2uudqWmZRTLn0auQOrY744wkWO+svAefO6yEqIazTokQ7+lvAdu72YPp10?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c1209f-07cb-4d9b-0a25-08ddef4e453e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 03:09:20.4360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8055

From: Roman Kisel <romank@linux.microsoft.com> Sent: Wednesday, August 27, =
2025 6:06 PM
>=20
> Define what the confidential VMBus is and describe what advantages
> it offers on the capable hardware.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  Documentation/virt/hyperv/coco.rst | 143 ++++++++++++++++++++++++++++-
>  1 file changed, 142 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/virt/hyperv/coco.rst b/Documentation/virt/hype=
rv/coco.rst
> index c15d6fe34b4e..38900aec761c 100644
> --- a/Documentation/virt/hyperv/coco.rst
> +++ b/Documentation/virt/hyperv/coco.rst
> @@ -178,7 +178,7 @@ These Hyper-V and VMBus memory pages are marked as
> decrypted:
>=20
>  * VMBus monitor pages
>=20
> -* Synthetic interrupt controller (synic) related pages (unless supplied =
by
> +* Synthetic interrupt controller (SynIC) related pages (unless supplied =
by
>    the paravisor)
>=20
>  * Per-cpu hypercall input and output pages (unless running with a paravi=
sor)
> @@ -232,6 +232,147 @@ with arguments explicitly describing the access. Se=
e
>  _hv_pcifront_read_config() and _hv_pcifront_write_config() and the
>  "use_calls" flag indicating to use hypercalls.
>=20
> +Confidential VMBus
> +------------------
> +The confidential VMBus enables the confidential guest not to interact wi=
th
> +the untrusted host partition and the untrusted hypervisor. Instead, the =
guest
> +relies on the trusted paravisor to communicate with the devices processi=
ng
> +sensitive data. The hardware (SNP or TDX) encrypts the guest memory and =
the
> +register state while measuring the paravisor image using the platform se=
curity
> +processor to ensure trusted and confidential computing.
> +
> +Confidential VMBus provides a secure communication channel between the g=
uest
> +and the paravisor, ensuring that sensitive data is protected from hyperv=
isor-
> +level access through memory encryption and register state isolation.
> +
> +Confidential VMBus is an extension of Confidential Computing (CoCo) VMs
> +(a.k.a. "Isolated" VMs in Hyper-V terminology). Without Confidential VMB=
us,
> +guest VMBus device drivers (the "VSC"s in VMBus terminology) communicate
> +with VMBus servers (the VSPs) running on the Hyper-V host. The
> +communication must be through memory that has been decrypted so the
> +host can access it. With Confidential VMBus, one or more of the VSPs res=
ide
> +in the trusted paravisor layer in the guest VM. Since the paravisor laye=
r also
> +operates in encrypted memory, the memory used for communication with
> +such VSPs does not need to be decrypted and thereby exposed to the
> +Hyper-V host. The paravisor is responsible for communicating securely
> +with the Hyper-V host as necessary.
> +
> +The data is transferred directly between the VM and a vPCI device (a.k.a=
.
> +a PCI pass-thru device, see :doc:`vpci`) that is directly assigned to VT=
L2
> +and that supports encrypted memory. In such a case, neither the host par=
tition
> +nor the hypervisor has any access to the data. The guest needs to establ=
ish
> +a VMBus connection only with the paravisor for the channels that process
> +sensitive data, and the paravisor abstracts the details of communicating
> +with the specific devices away providing the guest with the well-establi=
shed
> +VSP (Virtual Service Provider) interface that has had support in the Hyp=
er-V
> +drivers for a decade.
> +
> +In the case the device does not support encrypted memory, the paravisor
> +provides bounce-buffering, and although the data is not encrypted, the b=
acking
> +pages aren't mapped into the host partition through SLAT. While not impo=
ssible,
> +it becomes much more difficult for the host partition to exfiltrate the =
data
> +than it would be with a conventional VMBus connection where the host par=
tition
> +has direct access to the memory used for communication.
> +
> +Here is the data flow for a conventional VMBus connection (`C` stands fo=
r the
> +client or VSC, `S` for the server or VSP, the `DEVICE` is a physical one=
, might
> +be with multiple virtual functions)::
> +
> +  +---- GUEST ----+       +----- DEVICE ----+        +----- HOST -----+
> +  |               |       |                 |        |                |
> +  |               |       |                 |        |                |
> +  |               |       |                 =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D                |
> +  |               |       |                 |        |                |
> +  |               |       |                 |        |                |
> +  |               |       |                 |        |                |
> +  +----- C -------+       +-----------------+        +------- S ------+
> +         ||                                                   ||
> +         ||                                                   ||
> +  +------||------------------ VMBus --------------------------||------+
> +  |                     Interrupts, MMIO                              |
> +  +-------------------------------------------------------------------+
> +
> +and the Confidential VMBus connection::
> +
> +  +---- GUEST --------------- VTL0 ------+               +-- DEVICE --+
> +  |                                      |               |            |
> +  | +- PARAVISOR --------- VTL2 -----+   |               |            |
> +  | |     +-- VMBus Relay ------+    =3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D            |
> +  | |     |   Interrupts, MMIO  |    |   |               |            |
> +  | |     +-------- S ----------+    |   |               +------------+
> +  | |               ||               |   |
> +  | +---------+     ||               |   |
> +  | |  Linux  |     ||    OpenHCL    |   |
> +  | |  kernel |     ||               |   |
> +  | +---- C --+-----||---------------+   |
> +  |       ||        ||                   |
> +  +-------++------- C -------------------+               +------------+
> +          ||                                             |    HOST    |
> +          ||                                             +---- S -----+
> +  +-------||----------------- VMBus ---------------------------||-----+
> +  |                     Interrupts, MMIO                              |
> +  +-------------------------------------------------------------------+
> +
> +An implementation of the VMBus relay that offers the Confidential VMBus
> +channels is available in the OpenVMM project as a part of the OpenHCL
> +paravisor. Please refer to
> +
> +  * https://openvmm.dev/, and
> +  * https://github.com/microsoft/openvmm
> +
> +for more information about the OpenHCL paravisor.
> +
> +A guest that is running with a paravisor must determine at runtime if
> +Confidential VMBus is supported by the current paravisor. It may do that=
 by
> +first trying to establish a Confidential VMBus connection with the parav=
isor
> +using standard mechanisms where the memory remains encrypted. If this su=
cceeds,
> +then the guest can proceed to use Confidential VMBus. If it fails, then =
the
> +guest must fallback to establishing a non-Confidential VMBus connection =
with
> +the Hyper-V host.=20

Is it appropriate to document the "fallback" approach, given that on x86-64
there's an explicit CPUID indicator, and that ARM64 will be hardwired to
assume Confidential VMBus? Mentioning an unimplemented approach has
the potential for causing confusion.

> +The x86_64-specific approach may rely on the CPUID
> +Virtualization stack leaf; the ARM64 implementation is expected to suppo=
rt
> +the Confidential VMBus unconditionally when running the ARM CC guests.
> +
> +Confidential VMBus is a characteristic of the VMBus connection as a whol=
e,
> +and of each VMBus channel that is created. When a Confidential VMBus
> +connection is established, the paravisor provides the guest the message-=
passing
> +path that is used for VMBus device creation and deletion, and it provide=
s a
> +per-CPU synthetic interrupt controller (SynIC) just like the SynIC that =
is
> +offered by the Hyper-V host. Each VMBus device that is offered to the gu=
est
> +indicates the degree to which it participates in Confidential VMBus. The=
 offer
> +indicates if the device uses encrypted ring buffers, and if the device u=
ses
> +encrypted memory for DMA that is done outside the ring buffer. These set=
tings
> +may be different for different devices using the same Confidential VMBus
> +connection.
> +
> +Although these settings are separate, in practice it'll always be encryp=
ted
> +ring buffer only, or both encrypted ring buffer and external data. If a =
channel
> +is offered by the paravisor with confidential VMBus, the ring buffer can=
 always
> +be encrypted since it's strictly for communication between the VTL2 para=
visor
> +and the VTL0 guest. However, other memory regions are often used for e.g=
. DMA,
> +so they need to be accessible by the underlying hardware, and must be
> +unencrypted (unless the device supports encrypted memory). Currently, th=
ere are
> +not any VSPs in OpenHCL that support encrypted external memory, but futu=
re
> +versions are expected to enable this capability.
> +
> +Because some devices on a Confidential VMBus may require decrypted ring =
buffers
> +and DMA transfers, the guest must interact with two SynICs -- the one pr=
ovided
> +by the paravisor and the one provided by the Hyper-V host when Confident=
ial
> +VMBus is not offered. Interrupts are always signaled by the paravisor Sy=
nIC,
> +but the guest must check for messages and for channel interrupts on both=
 SynICs.
> +
> +In the case of a confidential VMBus, regular SynIC access by the guest i=
s
> +intercepted by the paravisor (this includes various MSRs such as the SIM=
P and
> +SIEFP, as well as hypercalls like HvPostMessage and HvSignalEvent). If t=
he
> +guest actually wants to communicate with the hypervisor, it has to use s=
pecial
> +mechanisms (GHCB page on SNP, or tdcall on TDX). Messages can be of eith=
er
> +kind: with confidential VMBus, messages use the paravisor SynIC, and if =
the
> +guest chose to communicate directly to the hypervisor, they use the hype=
rvisor
> +SynIC. For interrupt signaling, some channels may be running on the host
> +(non-confidential, using the VMBus relay) and use the hypervisor SynIC, =
and
> +some on the paravisor and use its SynIC. The RelIDs are coordinated by t=
he
> +OpenHCL VMBus server and are guaranteed to be unique regardless of wheth=
er
> +the channel originated on the host or the paravisor.
> +
>  load_unaligned_zeropad()
>  ------------------------
>  When transitioning memory between encrypted and decrypted, the caller of
> --
> 2.43.0
>=20


