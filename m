Return-Path: <linux-arch+bounces-10236-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ED0A3CD82
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 00:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F711895AF4
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 23:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CDF25E471;
	Wed, 19 Feb 2025 23:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="nWJytGph"
X-Original-To: linux-arch@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazolkn19013087.outbound.protection.outlook.com [52.103.2.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA99C1D7E30;
	Wed, 19 Feb 2025 23:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740007765; cv=fail; b=QyZQerSjv+dRKcTXR9LjutAbkHoLbJ4Dbul0iT8J3RS9hcRKsMh72heiUQ4+cFUbAnB/p9IF+w+rAozb2g+lQ38/5ZPVZtkpur+Jt2x7uKvnDOCiohrgYg65IzsdOOetj93waftrYqMxdiQy0mr+xYRf0AjSQ5mG3J3PL0eYzU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740007765; c=relaxed/simple;
	bh=WGJXxIERFslxA4bdc7nFSt0GSwkwtA4V+5xNWcEC7SY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FfXTdr2tpJgHlNoHz7bw0PfxrdOLvA23vmAQ8LVNqtmbMRExR7Z6HlAaVJH9i0W4esA50tPzbXa+H7n/aN16uVZvC4JKt+ccx5RxJIFjvZCtBRwysuXtV7znfxdEl8l7J2UoGalygpXRBrgPZlpv4vQa6gdj17FpPgNv5ye8AVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=nWJytGph; arc=fail smtp.client-ip=52.103.2.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+coIBeMdOKXCi2jOo+Db9zwHQMl1RQKrc93GtZNZNpU5T1i40ojFuYWTJ/fdjvkQYbrT+EbMZ1xlqpSI4sfc5niCp1gHriS1XLgmnNvBRKBoHJfo6xgw5VclQ4Gd24gNT0vVLv2KCL/QfK+EjODg9W04s9FLpDyzScJhvnFu4YAvVdE/fAgZAdiUgs/vw5eCR13zAoY92vkdNFdELltqp/mMJG+pdQLV78dQmcnaRykRHHqaOPXtaK64CemcRCSdO6LcrGgC1NqW1avlRRXwSI0s50jiUIBRQdKBFCL+wiSkMtMv79n4NX8IWIC91pJYfEhoMx3pHw8h4WYhpdquw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8TExdE2TXQs1iahrYLiN1k6wNuzEb4P5o4VuDvDl5c=;
 b=OOxGIMdbdYIq0rQ+VoFQQn0yABfUxyvQE0o0Jt9ItZWZ0mNBQj0HfdxjNUlSkh5l7PZiRpIRC9gUnCYcb2SsV4+zJQhap9bFX1Pvs8pfz/PIKl/l7B/9JRq4a2f44JKQ7cMZ3lKrRKvynhX8diZ2h1oNNmN2+BfPUFedTmyJipou3UN0lThbqLWp7kw/aoCOc1JkoNuSjL04gx5Obn6QOknAxH+6OT7tmyV5UoRnO0SR/21uroe3Td3fBBk586o1U4O7mqeqOJleieexMQgS/OWn/WPqOvgUZcyLgv3Ielk5uAPTzispHufUMFpI94hGnPGlTFFNoxyt38X7yy7DPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8TExdE2TXQs1iahrYLiN1k6wNuzEb4P5o4VuDvDl5c=;
 b=nWJytGphavBX8QCJP5k/ls4eU9I3FtnBbZv+PEv5j/q9T5zmMWur/5CeL0Vtdh7cOsQMzoemnzIZAXo2pTfCa5Ro1zslddEbgnTmUB0dJ/avZzMGuZ3LuO+pZYP3mU9guKmBvxieFHkC22gFwof8eOH9P24tPJ5bWUkt/IsDTtLUdBvX4XpHGC8GUV49iURwq3tPj9F3Um0m/8BbljVDfJqsx9i/6VmSQ9Or2Tq3dmu4JCOP/mgFdjXvlsTyWYYHbW5IhsX0KtY4+W1W9uor6KYnvdlOxjZKapSTvICnAbqn0vGVqHfkbOgtB/P2sCSqSqPEB95qtWHRHrpd5Qqnsg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY8PR02MB9623.namprd02.prod.outlook.com (2603:10b6:930:7c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 23:29:18 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 23:29:18 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "will@kernel.org" <will@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "benhill@microsoft.com" <benhill@microsoft.com>, "bperkins@microsoft.com"
	<bperkins@microsoft.com>, "sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v4 6/6] PCI: hv: Get vPCI MSI IRQ domain from
 DeviceTree
Thread-Topic: [PATCH hyperv-next v4 6/6] PCI: hv: Get vPCI MSI IRQ domain from
 DeviceTree
Thread-Index: AQHbfO/DM9VUz2f6/UWlLb6SJ31p+7NPT/7w
Date: Wed, 19 Feb 2025 23:29:18 +0000
Message-ID:
 <SN6PR02MB4157911BEF8664EDE2B62835D4C52@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250212014321.1108840-1-romank@linux.microsoft.com>
 <20250212014321.1108840-7-romank@linux.microsoft.com>
In-Reply-To: <20250212014321.1108840-7-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY8PR02MB9623:EE_
x-ms-office365-filtering-correlation-id: de3826f9-6aab-488c-58e7-08dd513d3b39
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|8060799006|19110799003|15080799006|461199028|3412199025|440099028|12091999003|41001999003|102099032|56899033;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?cKSHMMOMSWIYQ03eqjJ4i7GbftbxxwKnmOenx69aHy1T32Yo/JxaY2kWBbsO?=
 =?us-ascii?Q?Vw5P46gx6m1I9Wthzn82BFLeJsi2j072OW4xcZUzu6VOdrG2bUn4VkOme5St?=
 =?us-ascii?Q?hw3jT6/roRgVMZ4YBPY3OdXYcxt5nfFV4/SC0luc8Ftr9F8KjeCJRwFHAwyu?=
 =?us-ascii?Q?ewrd2jkJ6r9zqYFh9n6oq6x0X0GrsJ/78oxGPuSvwnpOM7scpf1tuXnigStV?=
 =?us-ascii?Q?2h0XWEWYwywd8mNRABvCzUmldU3YOYYNIaEo4wfeO7hM+ON7IGR2TWeid6BA?=
 =?us-ascii?Q?0i3z+UcAgmF4uwdJ6zvlljr6lvuphNNAeNaJ7C7iTjfpgywiU0/Onfyn1Xxi?=
 =?us-ascii?Q?iXAHOMQ0uv9FBXysPnPfHmxjjglA/NwaWfzaqesGsbBxaithyGYWX/JW8V3f?=
 =?us-ascii?Q?rGwa1pN3tWZBiaIxsZ6pL+S7WKWblj4Og1M9ezXlTYd94M9qOTzYz4hsV26m?=
 =?us-ascii?Q?Pg8JZ1yClJHz9W/Y8cZUwG7cpJUnc/k88Cdm5s7bhtxPNiCul7Luld39l6Ui?=
 =?us-ascii?Q?rthOU0fBhpe8IAMJ9aWhfIe/zFygEUykpms+H035rL898tUiFe/KHRyQFjp9?=
 =?us-ascii?Q?fH418H6hmrQMuS6PQ+JzuQKOWNxhnLlLmTRgWhGkEAVfIrDsfiTDhAvNGz/T?=
 =?us-ascii?Q?YxsTTEd0usCMAVN34ToKlD/DH5x/6H6WIFw+j0ZHkRvrjjK/iHYz0dJuM/Tz?=
 =?us-ascii?Q?rN3+UstwzN+uotNL1CgslvmHXFQg4m31XeLDa00gco6ftncP7rHD4AlULPx1?=
 =?us-ascii?Q?Ymdjt+Wran5b9MsFvwqCXXnl6kuROk071u4617maFb4JtBQ2RvjLKX9ehmRQ?=
 =?us-ascii?Q?5Il07JBav2RG8NEk3LHC5T8ms2j19dIDawCfQlSt0Tbns8Lve4N8FPNuASnh?=
 =?us-ascii?Q?Y5EFD+ls9exfWlDdeDERNEe2qdA9E9SfM+iQ5kkUzHnwO4vZg+yYaAVDm6Kx?=
 =?us-ascii?Q?Ga9SENVsP7K2x592L0KWY76cACYB7zwEAbOOXsJehbECTkZ/E1O1Lizvjmfq?=
 =?us-ascii?Q?4LonrvfXJ5MC6x0BCr8NmxTUT/J/5qGIOwksz0pYyg8iOdzu/yJVbUaC+o3v?=
 =?us-ascii?Q?E49P5vkX/TCARVsNAa4MUiLd4VE60SVZwKDEqymtPzk1ciL3EQQ=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qj8PSUCkt4Cjb0rTyG7anWdqXbPdSleFHc5OFbX57SX40Kq7Kn9t0Bu+JqsL?=
 =?us-ascii?Q?ooUkE/KJ6Ig4oV6XCbtgDMiMh1hjtpUgG8xnYy6eimX0K01dwhjeppjyqR8f?=
 =?us-ascii?Q?cVc9MarRLYBOvl3zMjv3uT+5b/OU6rfmbOoXAwQjkkA0Rr66eGKHGemtnS4i?=
 =?us-ascii?Q?jR+FB3r0DN+vuD0jdCSJ73C/dVLHuoF9ohoY7Nd579Ux16UxVmNXuaZmccA+?=
 =?us-ascii?Q?Js1wLXbrpoBmL0Uvz9BlCdnsGcl2lOgG85tPzmKl3tiKMvxHZscW2Wa5pIVO?=
 =?us-ascii?Q?cjDUNBSxh7D/RC4whhsaNNgYu78RZDb42zS8UvlQYJxIlHYNjOEcF/NsV3qw?=
 =?us-ascii?Q?ozFhoVsDwxFUr9zay4ebtjQ6Ba4b76QvHkuTMwMS3QA6k6jy3jVCZsLv9J7m?=
 =?us-ascii?Q?ZlkB5QhtcdTn6FJv/JdlJuOWAs9B0WIDsjHc86/QjBvXJ10Ac5/IJi7GxS0q?=
 =?us-ascii?Q?Herr+OK/f9NrgbBUXlKrgqAt4Cqdx3eilz9LQASLXmoSGftOtRl8GMXn34Ne?=
 =?us-ascii?Q?3DlJa8rPPq5QVDZmqfWEV/TBqrKUT4yT/X49ZFqCKvFmIu/kb5HZSxLLMbni?=
 =?us-ascii?Q?zomTRRI+VxVHICr0WSJBcArtz1R2gbLYHlqHaHWXLbeR3YB3tN5a4ZBKZrQc?=
 =?us-ascii?Q?a6njxyyVw8UT08HvZXX/jSLP76nc18wT1VTHiwDkWc1C4x9bLdW07rufbmfE?=
 =?us-ascii?Q?bwxPteGpzfboh6ibXeD+f1xVKnp19exqrLrxBU0hqFFKzyzhqS8G3qTckMA0?=
 =?us-ascii?Q?viFcGSgoFWduoHLj/lxDxzWEJEJ4B2xt7M/E1CnvJ/NZPyntzvbHz1y4vJ+h?=
 =?us-ascii?Q?xfr8nhnoFnZlY/TzxZCMhd47FiafJ/sj9oT0KdEbY/QzTi3fggLnwumLpkbJ?=
 =?us-ascii?Q?3lrwvDKhwZ7BHRq02nHvpfjTZOLTiM1dUGwqKshlioYI5MchmowO6ZJRvmkK?=
 =?us-ascii?Q?RYJ4p/8RqO9SJZf5GBaKHIlKQf/AtW2IU3BKPnZADO/4t1NY1aBl7l7PQHcV?=
 =?us-ascii?Q?7bv6/trZsb+K9lQyNR9Hz/qhVhF6t0STK9yUxws2CUq0944rFm1/B/gbgXRW?=
 =?us-ascii?Q?cUB2IB1j8aCqwSYhtghisBYbI3IeYjZlMEGA8R4awEVYx96kw7eZKf3tMGUV?=
 =?us-ascii?Q?EXHtkEPaeXDpjNFcL4QPNwLtb9HQHOWsk4m6M6vv4IWJ5OPKy6CrZXR3Er+U?=
 =?us-ascii?Q?yGWuqsK/unkX1GvxisQwW+gFKl/fpnMEJ08ZTRQjLOwKg3DnSlZUF6ZKkI0?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: de3826f9-6aab-488c-58e7-08dd513d3b39
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 23:29:18.4538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9623

From: Roman Kisel <romank@linux.microsoft.com> Sent: Tuesday, February 11, =
2025 5:43 PM
>=20
> The hyperv-pci driver uses ACPI for MSI IRQ domain configuration on
> arm64. It won't be able to do that in the VTL mode where only DeviceTree
> can be used.
>=20
> Update the hyperv-pci driver to get vPCI MSI IRQ domain in the DeviceTree
> case, too.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c              | 23 ++++++----
>  drivers/pci/controller/pci-hyperv.c | 69 ++++++++++++++++++++++++++---
>  include/linux/hyperv.h              |  2 +
>  3 files changed, 80 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 9d0c2dbd2a69..3f0f9f01b520 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -45,7 +45,8 @@ struct vmbus_dynid {
>  	struct hv_vmbus_device_id id;
>  };
>=20
> -static struct device  *hv_dev;
> +/* VMBus Root Device */
> +static struct device  *vmbus_root_device;
>=20
>  static int hyperv_cpuhp_online;
>=20
> @@ -80,9 +81,15 @@ static struct resource *fb_mmio;
>  static struct resource *hyperv_mmio;
>  static DEFINE_MUTEX(hyperv_mmio_lock);
>=20
> +struct device *hv_get_vmbus_root_device(void)
> +{
> +	return vmbus_root_device;
> +}
> +EXPORT_SYMBOL_GPL(hv_get_vmbus_root_device);
> +
>  static int vmbus_exists(void)
>  {
> -	if (hv_dev =3D=3D NULL)
> +	if (vmbus_root_device =3D=3D NULL)
>  		return -ENODEV;
>=20
>  	return 0;
> @@ -861,7 +868,7 @@ static int vmbus_dma_configure(struct device *child_d=
evice)
>  	 * On x86/x64 coherence is assumed and these calls have no effect.
>  	 */
>  	hv_setup_dma_ops(child_device,
> -		device_get_dma_attr(hv_dev) =3D=3D DEV_DMA_COHERENT);
> +		device_get_dma_attr(vmbus_root_device) =3D=3D DEV_DMA_COHERENT);
>  	return 0;
>  }
>=20
> @@ -1920,7 +1927,7 @@ int vmbus_device_register(struct hv_device *child_d=
evice_obj)
>  		     &child_device_obj->channel->offermsg.offer.if_instance);
>=20
>  	child_device_obj->device.bus =3D &hv_bus;
> -	child_device_obj->device.parent =3D hv_dev;
> +	child_device_obj->device.parent =3D vmbus_root_device;
>  	child_device_obj->device.release =3D vmbus_device_release;
>=20
>  	child_device_obj->device.dma_parms =3D &child_device_obj->dma_parms;
> @@ -2282,7 +2289,7 @@ static int vmbus_acpi_add(struct platform_device *p=
dev)
>  	struct acpi_device *ancestor;
>  	struct acpi_device *device =3D ACPI_COMPANION(&pdev->dev);
>=20
> -	hv_dev =3D &device->dev;
> +	vmbus_root_device =3D &device->dev;
>=20
>  	/*
>  	 * Older versions of Hyper-V for ARM64 fail to include the _CCA
> @@ -2373,7 +2380,7 @@ static int vmbus_device_add(struct platform_device =
*pdev)
>  	struct device_node *np =3D pdev->dev.of_node;
>  	int ret;
>=20
> -	hv_dev =3D &pdev->dev;
> +	vmbus_root_device =3D &pdev->dev;
>=20
>  	ret =3D of_range_parser_init(&parser, np);
>  	if (ret)
> @@ -2692,7 +2699,7 @@ static int __init hv_acpi_init(void)
>  	if (ret)
>  		return ret;
>=20
> -	if (!hv_dev) {
> +	if (!vmbus_root_device) {
>  		ret =3D -ENODEV;
>  		goto cleanup;
>  	}
> @@ -2723,7 +2730,7 @@ static int __init hv_acpi_init(void)
>=20
>  cleanup:
>  	platform_driver_unregister(&vmbus_platform_driver);
> -	hv_dev =3D NULL;
> +	vmbus_root_device =3D NULL;
>  	return ret;
>  }

These changes to rename hv_dev to vmbus_root_device, along with the
introduction of hv_get_vmbus_root_device(), seem like a separate
patch from the vPCI changes. The rename is definitely needed because
"hv_dev" as a symbol is very overloaded. But the rename is "no functional
change", and it doesn't touch the pci-hyperv.c file. You don't have a
consumer for hv_get_vmbus_root_device() until the vPCI changes, but
that seems OK to me to be in the subsequent patch.

>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index cdd5be16021d..24725bea9ef1 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -50,6 +50,7 @@
>  #include <linux/irqdomain.h>
>  #include <linux/acpi.h>
>  #include <linux/sizes.h>
> +#include <linux/of_irq.h>
>  #include <asm/mshyperv.h>
>=20
>  /*
> @@ -817,9 +818,17 @@ static int hv_pci_vec_irq_gic_domain_alloc(struct ir=
q_domain *domain,
>  	int ret;
>=20
>  	fwspec.fwnode =3D domain->parent->fwnode;
> -	fwspec.param_count =3D 2;
> -	fwspec.param[0] =3D hwirq;
> -	fwspec.param[1] =3D IRQ_TYPE_EDGE_RISING;
> +	if (is_of_node(fwspec.fwnode)) {
> +		/* SPI lines for OF translations start at offset 32 */
> +		fwspec.param_count =3D 3;
> +		fwspec.param[0] =3D 0;
> +		fwspec.param[1] =3D hwirq - 32;
> +		fwspec.param[2] =3D IRQ_TYPE_EDGE_RISING;
> +	} else {
> +		fwspec.param_count =3D 2;
> +		fwspec.param[0] =3D hwirq;
> +		fwspec.param[1] =3D IRQ_TYPE_EDGE_RISING;
> +	}
>=20
>  	ret =3D irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
>  	if (ret)
> @@ -887,6 +896,35 @@ static const struct irq_domain_ops hv_pci_domain_ops=
 =3D {
>  	.activate =3D hv_pci_vec_irq_domain_activate,
>  };
>=20
> +#ifdef CONFIG_OF
> +
> +static struct irq_domain *hv_pci_of_irq_domain_parent(void)
> +{
> +	struct device_node *parent;
> +	struct irq_domain *domain;
> +
> +	parent =3D of_irq_find_parent(hv_get_vmbus_root_device()->of_node);
> +	domain =3D NULL;
> +	if (parent) {
> +		domain =3D irq_find_host(parent);
> +		of_node_put(parent);
> +	}
> +
> +	/*
> +	 * `domain =3D=3D NULL` shouldn't happen.
> +	 *
> +	 * If somehow the code does end up in that state, treat this as a confi=
guration
> +	 * issue rather than a hard error, emit a warning, and let the code pro=
ceed.
> +	 * The NULL parent domain is an acceptable option for the `irq_domain_c=
reate_hierarchy`
> +	 * function called later.
> +	 */
> +	if (!domain)
> +		WARN_ONCE(1, "No interrupt-parent found, check the DeviceTree data.\n"=
);
> +	return domain;
> +}
> +
> +#endif
> +
>  static int hv_pci_irqchip_init(void)
>  {
>  	static struct hv_pci_chip_data *chip_data;
> @@ -906,10 +944,29 @@ static int hv_pci_irqchip_init(void)
>  	 * IRQ domain once enabled, should not be removed since there is no
>  	 * way to ensure that all the corresponding devices are also gone and
>  	 * no interrupts will be generated.
> +	 *
> +	 * In the ACPI case, the parent IRQ domain is supplied by the ACPI
> +	 * subsystem, and it is the default GSI domain pointing to the GIC.
> +	 * Neither is available outside of the ACPI subsystem, cannot avoid
> +	 * the messy ifdef below.
> +	 * There is apparently no such default in the OF subsystem, and
> +	 * `hv_pci_of_irq_domain_parent` finds the parent IRQ domain that
> +	 * points to the GIC as well.
> +	 * None of these two cases reaches for the MSI parent domain.
>  	 */
> -	hv_msi_gic_irq_domain =3D acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_N=
R,
> -							  fn, &hv_pci_domain_ops,
> -							  chip_data);
> +#ifdef CONFIG_ACPI
> +	if (!acpi_disabled)
> +		hv_msi_gic_irq_domain =3D acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_=
NR,
> +			fn, &hv_pci_domain_ops,
> +			chip_data);
> +#endif
> +#if defined(CONFIG_OF)
> +	if (!hv_msi_gic_irq_domain)
> +		hv_msi_gic_irq_domain =3D irq_domain_create_hierarchy(
> +			hv_pci_of_irq_domain_parent(), 0, HV_PCI_MSI_SPI_NR,
> +			fn, &hv_pci_domain_ops,
> +			chip_data);
> +#endif
>=20
>  	if (!hv_msi_gic_irq_domain) {
>  		pr_err("Failed to create Hyper-V arm64 vPCI MSI IRQ domain\n");
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 4179add2864b..2be4dd83b0e1 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1333,6 +1333,8 @@ static inline void *hv_get_drvdata(struct hv_device=
 *dev)
>  	return dev_get_drvdata(&dev->device);
>  }
>=20
> +struct device *hv_get_vmbus_root_device(void);
> +
>  struct hv_ring_buffer_debug_info {
>  	u32 current_interrupt_mask;
>  	u32 current_read_index;
> --
> 2.43.0
>=20


