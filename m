Return-Path: <linux-arch+bounces-11778-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA409AA69AD
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 06:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10F3A4C3565
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 04:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD9C19B5B4;
	Fri,  2 May 2025 04:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="eWZXNHDV"
X-Original-To: linux-arch@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013076.outbound.protection.outlook.com [52.103.20.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C2128F1;
	Fri,  2 May 2025 04:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746158915; cv=fail; b=o/cz3wFUeT+v0ea3fZxYDXHj1Pr9+UVAyuH8JhoIYjAMn2Ag/VheiTkOvdIbKsJbZxXJtt7NLHZAx3Agz14ZIzv7vn1bC/+H2NeBnZqRYOMcYFynLpU0NodpcE7kKi2Blk34qrK7YquBIJXjKvVXGuBMhBu7rUwBs0Lvo7ULfZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746158915; c=relaxed/simple;
	bh=Ipd9emE2DQhrjGPD935THLYkgfSDo7Nimw286XrRBKs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ueWW5HIEXvGUndmJZ6NM/gJnp+ddFDZ+NF8Uev6T4uO1mdPNdtQYJBb67WuQN6zWuqUV4J6EGbZ5QY9aCbtWFsoUYQCAwNLFoIkCuIgoWKh5Da/evnu9qZ5TNeBcHRDk0Ml9VwBj1WcXUpnwInjnYQoujgPLVNVy1oXCQSfWzos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=eWZXNHDV; arc=fail smtp.client-ip=52.103.20.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vn3rGm9y/N4U74MNXXYBdOVLIZEb4mr907ETC9IMArepvR2PRIbARTNhxAvYtnwjtcF3HbtgpVWaEFEyZWrlNa1bC1d1aaxGbv77necOEZyDPvOpxkcRzFYOZN5CsDX0UPYJ6PF96A/nW0DN1QnpxfH+rsTN7DO0jpJMv0YFtYETXDJdlpTUEKGFY3zbHH0hY9Wgbg/2NDHvZiwRt+4jR3fxV+3eiUGofI0JkKnTmyUW40UMbmAJZ8MxYzq791ciAVqybz/wWKwxJ2LPDGEYl8r+Z4cBTIunmptocmtBnZxWBmFgyG3/WV8yfbTxv77dnZIE4Y+5tYtPuVNdsKx1CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuldBf2vD5Ueodak/LG2QmCsYGRG6HHCVDQXm91jIsw=;
 b=FpU8BfZEOO0F6V5YiVQGF2LRaWMlUbZXle9TPOi5URrdPK1hRypoWW3RGCG7dqE8s49/sfojsvOmXniFFXqqf0tGJYKaaFNrwcqOtsW0P0I0NAZvcZYjDlBqzM/5YtWPfyhCyTi+cnCRmyOt19el0AdKXvvR2uObyofZ8vbOJszbxREYbPRyRSfWRIVK5X1xfnDoNMae6jRQB3vGP8NyX1tsG8UPjbGAHT9PQY0ql1lBQkNf2AQMdJQUQZQgXdYCU62R+ulpuFosJ/gnfIVQ9OIVZP27N3YZZLys96oL0+/yXDKJdGE/UHPYTdpcuVYhSOjrzT7dpc1uCCpJ6g0lzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuldBf2vD5Ueodak/LG2QmCsYGRG6HHCVDQXm91jIsw=;
 b=eWZXNHDVpmt5XKAJWuAi18ktp4f1T4SyxSImd/IhB6zJ+m0Vt0RduWlP8nG9tCZOgARvz1vI2mEs8empbKsDCwFgUTgho708LNkVDc8N6IOuoUg9Ft/HEanwmK4d3h+L1P56Izj4aKEmoBBRVOruJmcKm9kNF7AOFuorOqTAxz1Ky4OsgCPANjiIOOBrsx5BQf7N+EPME83DKMDC7TtG/GasmHzrfQQ9PKPLMMDBms6NwUbXH/p9Eq8cH2pntv2j0U4oCcgAaXv6AtOwUTgcJrYU9KB02kLuRd+7QZU27VsNgdZ5sP5PEGe1vQt1Cbj/r2qXlM2uOgidu5QHc3oDIg==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by PH0PR02MB8646.namprd02.prod.outlook.com (2603:10b6:510:10e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Fri, 2 May
 2025 04:08:29 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911%4]) with mapi id 15.20.8699.010; Fri, 2 May 2025
 04:08:29 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "joey.gouly@arm.com" <joey.gouly@arm.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "lenb@kernel.org" <lenb@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "maz@kernel.org"
	<maz@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "rafael@kernel.org"
	<rafael@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>, "suzuki.poulose@arm.com"
	<suzuki.poulose@arm.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "will@kernel.org"
	<will@kernel.org>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v9 11/11] PCI: hv: Get vPCI MSI IRQ domain
 from DeviceTree
Thread-Topic: [PATCH hyperv-next v9 11/11] PCI: hv: Get vPCI MSI IRQ domain
 from DeviceTree
Thread-Index: AQHbuIIGiFt9aynoMUK6tNHuTgnFP7O+vmPw
Date: Fri, 2 May 2025 04:08:28 +0000
Message-ID:
 <BN7PR02MB4148C37D53E84A5BBAB999F8D48D2@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20250428210742.435282-1-romank@linux.microsoft.com>
 <20250428210742.435282-12-romank@linux.microsoft.com>
In-Reply-To: <20250428210742.435282-12-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|PH0PR02MB8646:EE_
x-ms-office365-filtering-correlation-id: c55fbe45-7705-4e35-b193-08dd892efe75
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|8060799006|8062599003|19110799003|461199028|440099028|3412199025|12091999003|41001999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sSGUMc6YxWe/gGiDo/aCfkMIiUef44vfc9FclxLJQHXfSbBtmZsuTacZRfcu?=
 =?us-ascii?Q?Tlor6MzFACnecpewPUF9Fnk3tRrjZCRJmzDyqMWyUCqk2Aj+ox9OHns3NW1o?=
 =?us-ascii?Q?53IsCUOF9mz35ehNTNy18a57nOp3304CnStDwYaSQZrVbAnL4UVEnYlfb8zm?=
 =?us-ascii?Q?WyeHQN4Vr+D18ha5riwGmYFzcVlvY2GX7Lvi1VVtl+TRszkNy8DK12tVjRAQ?=
 =?us-ascii?Q?9uUYKaSQ6/cJuf2BeaV2KjeO0bVsClFnbLjCE41ErDtg3Di4NxHnfkPGKVMV?=
 =?us-ascii?Q?7FxvpCHmezQsE6hnjcNr56em84Jgfdw3KYWpoQvvIMdqtRsKUdfeQcxB9at3?=
 =?us-ascii?Q?3PrrANkfhU+mX/z5n6hWCaVOPNNC3DSdpNh+JnsZokx3s7OFXluQG5gh3+uM?=
 =?us-ascii?Q?l7cm0dF//gSDL+eXsq68VJLfLSeDe8l6ErOPDjxBuhROBylXVeOVozyq+4bk?=
 =?us-ascii?Q?CM6A5xrd9aVcOPCrOL8+ckX4yRRbyUDu/IWQDzQu84+/RmcnkArfvn6dc8zO?=
 =?us-ascii?Q?5mmGex+RsPZEDHpCTDct8imSG2ysrnM6hGGiQbO7gbC0LW+kpaYqov0lq3uU?=
 =?us-ascii?Q?fRfPywUn/lVDULzxIMZpl5IOLr4kVcjlhoAlnEhlyCD+rmjVZeXOan6/BTCQ?=
 =?us-ascii?Q?nC9fS9SJ0nGzhC2yr8A/Do3cKKrCGMEz7oKQOhdgb01kXBWljv2f/8cIhJ+l?=
 =?us-ascii?Q?i0ciKrZrJed9AmvtUqH9rRbJeaGEUaxYHWzTCOmNg/JmY1MQ+D+95DjpC/p6?=
 =?us-ascii?Q?x0iutfTOL/mEKHtsd6Lw3G2PGUV5v3mgmX3XyBWCg7Cre2gpksiEv43sfDzt?=
 =?us-ascii?Q?1twuQthkifLV/fiV+WNQx1sN9UaGSjxJfXqixIYNZLqWz426Lyy6euUWIPqo?=
 =?us-ascii?Q?f6CED9VW7ex6kg5xdmePcIZa8dHwdKnn8OuqWVJPZKiDxdDWzZcj7hIAr6Oj?=
 =?us-ascii?Q?JDdRhh9/9l6+Q0htxKk6CeSQHvi6zMLJXB0QfkImImgFXvXrPZVToomyJl31?=
 =?us-ascii?Q?aaIosr/DSGdz/EwrrnyIIpiPxj0wMa1eCD3+6mKz+V8Vd+gjAFnwYwcg19OT?=
 =?us-ascii?Q?jQxwrhP6Jmi88dLh8QK0gmpr+/LgA/5nSb3ZlhOucJgnznbRFDQPgc7r0fw4?=
 =?us-ascii?Q?nq4sjw0OG04W+hSDYQjcmECZwOfB0xsZzg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4fiNAP8E1MuxVkSOBa3fhp3BgBsy5xnHDXRhcLoTd0LgzkZM+ImrVyKYJEj7?=
 =?us-ascii?Q?rMmZd1blnzCqYX9hwTJFt5CFK98VfGzUu/NRfmlw8SwMEQILn1sPxQl/3ohV?=
 =?us-ascii?Q?ej0ZD9eplRpDgZdZ8dQ1SQEg6nyzLmPcqrf+9u96Kuz4HuJKVwxGCoC/dUS9?=
 =?us-ascii?Q?Ih4FrTlDoFVcrhPe10tJbAINiIa2WYrOTE7aOBr5Gp0yikNfG7xXqey8PZIa?=
 =?us-ascii?Q?PaE1UzUYgEvroMv/9WlzoEzm5JOxa0ow1ejl63Mh1gzzdrVdG0xTAxOYcC9I?=
 =?us-ascii?Q?KaCisKIUlzhlzsoyqtpULwqxhggz7meMse1Mq6mtM/Nbfm9tS2EBeXaId4we?=
 =?us-ascii?Q?mZ0Q6ZHUusuWwpwZ4QWPjiZ/v4fXlL5uI+/JBcoJaOxxB6ws9QKhz6YwK9Rr?=
 =?us-ascii?Q?F7vlaklA6TIcHPQEUYmdMgnhJ8f14BkBLcIukccrqmZbWTJwXm9kUXaqD9rN?=
 =?us-ascii?Q?udO+YFDNzVr8MQ+WDpiuDrNsLjNsX/VGXHnQbFs3VuBcUD3GSYHitD8F12w1?=
 =?us-ascii?Q?vk6Ivf46c968OxfcDJoFzyBoPLzgjAifR6skV0jcK8STbw7UABBUxS3gS+gz?=
 =?us-ascii?Q?k//NsiksAo/r0pYJeNOMHMpOXXPG/EDVEHzTWNL6O12d1lrGaDtX8BNWFvNN?=
 =?us-ascii?Q?UyhqJyLAOIERjSFr21YtJCXw3C04UpuKgcStXPqXbHoQNsASoxfZHB8V/U/8?=
 =?us-ascii?Q?fnw7jc5zsVJ6ARodvo1HKCnaavih0Gv20X58HWiGYMQpNOQ8rROp+T2Y8sHr?=
 =?us-ascii?Q?uB27OmUEYIYUrVBWFKfp4Jzwx889hACUi4+122bvg0HibrP7BF42BTicWoiv?=
 =?us-ascii?Q?yV3jigcMARK0Af5tYnU4Bz3jCLsoCKkT+i9Y/0smb7vjTOUqxvUz9J0JU5Id?=
 =?us-ascii?Q?W4P4hnvzrXnjj+YqUB1dbY9DpmtT4Tg68+31C9p6UBI0QlrUyJ1jMwnbymIL?=
 =?us-ascii?Q?ugVXLRLNgoZC9SNbhHJOOTzwU/ygOzN3w5nLGWWyoHvJNl8RMgqFjQ5Wyndv?=
 =?us-ascii?Q?2lvXzN++gyNJ7cbbJIjZdkCLtgywPmiqadlKBHd1PNpSb4JLxDjYv6OItfKC?=
 =?us-ascii?Q?yMM3GYSNBUuzi/7hDsXvDZbGBy0pqmp9mGZvNEn3U7UswEaxB5HEGAJx+NI4?=
 =?us-ascii?Q?1LC4fSM251eACl4Q+QTGThZ9mlzbvmnZW9VTnMs1k/8uFOC1jLBnhh/JqSui?=
 =?us-ascii?Q?7pxXY2f4YnO8gwiylxXopk2lfXUPOeF0YwzKILJCVwgmxenP9EM12wTjnOQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c55fbe45-7705-4e35-b193-08dd892efe75
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2025 04:08:28.6901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8646

From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, April 28, 2025=
 2:08 PM
>=20
> The hyperv-pci driver uses ACPI for MSI IRQ domain configuration on
> arm64. It won't be able to do that in the VTL mode where only DeviceTree
> can be used.
>=20
> Update the hyperv-pci driver to get vPCI MSI IRQ domain in the DeviceTree
> case, too.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  drivers/pci/controller/pci-hyperv.c | 70 ++++++++++++++++++++++++++---
>  1 file changed, 64 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 6084b38bdda1..a48524d2a1eb 100644
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
q_domain
> *domain,
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
> @@ -887,10 +896,44 @@ static const struct irq_domain_ops hv_pci_domain_op=
s =3D {
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
> +	if (!parent)
> +		return NULL;
> +	domain =3D irq_find_host(parent);
> +	of_node_put(parent);
> +
> +	return domain;
> +}
> +
> +#endif
> +
> +#ifdef CONFIG_ACPI
> +
> +static struct irq_domain *hv_pci_acpi_irq_domain_parent(void)
> +{
> +	acpi_gsi_domain_disp_fn gsi_domain_disp_fn;
> +
> +	gsi_domain_disp_fn =3D acpi_get_gsi_dispatcher();
> +	if (!gsi_domain_disp_fn)
> +		return NULL;
> +	return irq_find_matching_fwnode(gsi_domain_disp_fn(0),
> +				     DOMAIN_BUS_ANY);
> +}
> +
> +#endif
> +
>  static int hv_pci_irqchip_init(void)
>  {
>  	static struct hv_pci_chip_data *chip_data;
>  	struct fwnode_handle *fn =3D NULL;
> +	struct irq_domain *irq_domain_parent =3D NULL;
>  	int ret =3D -ENOMEM;
>=20
>  	chip_data =3D kzalloc(sizeof(*chip_data), GFP_KERNEL);
> @@ -907,9 +950,24 @@ static int hv_pci_irqchip_init(void)
>  	 * way to ensure that all the corresponding devices are also gone and
>  	 * no interrupts will be generated.
>  	 */
> -	hv_msi_gic_irq_domain =3D acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_N=
R,
> -							  fn, &hv_pci_domain_ops,
> -							  chip_data);
> +#ifdef CONFIG_ACPI
> +	if (!acpi_disabled)
> +		irq_domain_parent =3D hv_pci_acpi_irq_domain_parent();
> +#endif
> +#ifdef CONFIG_OF
> +	if (!irq_domain_parent)
> +		irq_domain_parent =3D hv_pci_of_irq_domain_parent();
> +#endif
> +	if (!irq_domain_parent) {
> +		WARN_ONCE(1, "Invalid firmware configuration for VMBus
> interrupts\n");
> +		ret =3D -EINVAL;
> +		goto free_chip;
> +	}
> +
> +	hv_msi_gic_irq_domain =3D irq_domain_create_hierarchy(irq_domain_parent=
, 0,
> +		HV_PCI_MSI_SPI_NR,
> +		fn, &hv_pci_domain_ops,
> +		chip_data);
>=20
>  	if (!hv_msi_gic_irq_domain) {
>  		pr_err("Failed to create Hyper-V arm64 vPCI MSI IRQ domain\n");
> --
> 2.43.0
>=20


