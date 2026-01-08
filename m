Return-Path: <linux-arch+bounces-15712-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B18A1D05A5E
	for <lists+linux-arch@lfdr.de>; Thu, 08 Jan 2026 19:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 243E5304AE5A
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jan 2026 18:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8568B322B96;
	Thu,  8 Jan 2026 18:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="k3UAsTgV"
X-Original-To: linux-arch@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013095.outbound.protection.outlook.com [52.103.20.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9823A25DD1E;
	Thu,  8 Jan 2026 18:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767898027; cv=fail; b=n1+E5zz77CI+D3WwYu6eQ3CAezYb4YP1k0KQgGo8a3anpHCOWGNulVGhJzANXAbY83NyTNEXNcwe7xRcBTFgm8FIAqhLwffO8uGtgESCef/p+J+cshHuXiuLqwWvL4EXjbTqNk/HQWpYSnbvJVHTS3QNrmr0NSmuqz4ZceZxaFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767898027; c=relaxed/simple;
	bh=buTcrRCAi+Rb0V2jyQosuYzPF+nTD8z+lcYJq8+2UMg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IuAZGBqG1KSpdH9RJC2gBbQZOMNaDW8zTbX02u/T/8Q3ZwTfH4nQ4wPoC5wCfN2Sva21xCwcTo1gyfyCHOyFH5Iw0k7es14c8YDpQgqLbXqVawdRdtZH/ybria4gq/7uBjvbqTkrgqLiWsOWMRy30QeppaQ2Z4dW7y+w+pkNY2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=k3UAsTgV; arc=fail smtp.client-ip=52.103.20.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fznJ3FYwb8GyYZHT1mbZbg9bIvgij8+t1eJxRF0BqaYKJ9r5P/0Yk56V7UdaGcqIL8frW0b60gvKMtS9R46/jgP86YEHEoagMYF0hE6Csbzl1Uo4H7oymyuw7AuiKGDXaQ8C1tcMSY8eJqpvLAAbwtANRqQCt5FRLRMtd+b2Ch5yyFUth//arB1mPvyoOC9AEe0LyDjTWLJZjSccPXYpEIPLuxGuvHXr8VPPnICdW55+QFnmHBha/eeDvOVosM2m+OVCJDT7RigJlOPA63ihj1ybDuyDUr/JGATyeOSQLxxz1zKYeVc8uHuYcxr0UXsFntJnQr+J+AqNzyHXCaoyaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEsJQWR7eiLGeEhw8Nb/YpmC5vtcNpWXH+bhWWeA1ZE=;
 b=GLnTRzm64XMBdkBBfUas6pyt5lUO3lz7EUbhKGW9sz+a66gtYjJMOuVYYAwRpT43qR9DlRhUHPTOxiBQI5x4BG3xH/vbdlRWt1DLhWaKZc0IiEkcnLS+y7kjJNZphEwCtBPMaGEbJE7rYrF1hYKsxQhDdSFSpVesf4OxWCLqyfVilN+w76BoXkaVO7lyxkoK/3c3F1mBHBGOd2ps9OA+GmAZQn1Y52J8UoRIRn/eYX0RdW9XzZ5FLSpzpxVh+FDlKbJ6OVfC+55plNVHaQETt7t+l4NZQw4MV63Qrt1+5pK2BxO8SrrfvDpYlZK/b+B9zjM3D/KiA+Dj+kKij+rNNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEsJQWR7eiLGeEhw8Nb/YpmC5vtcNpWXH+bhWWeA1ZE=;
 b=k3UAsTgVW7KOYepxzJ1OV3ixMlf2moMB4097mlO1c+lrtfWvQK1BCZaPuhRkvbzJRvQzkDG7K/VxGbH05UfdLzKVDydKBbFmjGo7l1Cg5wnwDzNyQ+sbNQKHGRPQpRo3vGVzYv++tQXPAJlw0eLnRlYvx7nnHnZ0jNI198WQ45nYPK2YHRUzV0Y8FGY+p6bK/pOsOgnjO0gIemKwzXxPokFaGwKBMvybJ1N9mPr86CO4O3cK8p+6G4Qx2437/OLqeWcu/bvA87BxEk4JFz79V+lUd30GqeWSKYf3s6ua/VQd+J5cnfqwfcfkaTaQ8ITPmxCP/hCFrCAQ2a3X4srArA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7542.namprd02.prod.outlook.com (2603:10b6:510:51::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 18:47:02 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 18:47:02 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Yu Zhang <zhangyu1@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"easwar.hariharan@linux.microsoft.com"
	<easwar.hariharan@linux.microsoft.com>, "jacob.pan@linux.microsoft.com"
	<jacob.pan@linux.microsoft.com>, "nunodasneves@linux.microsoft.com"
	<nunodasneves@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [RFC v1 3/5] hyperv: Introduce new hypercall interfaces used by
 Hyper-V guest IOMMU
Thread-Topic: [RFC v1 3/5] hyperv: Introduce new hypercall interfaces used by
 Hyper-V guest IOMMU
Thread-Index: AQHcaMpUCD6VSZQZOU6EcthBZLbCPrVIporQ
Date: Thu, 8 Jan 2026 18:47:02 +0000
Message-ID:
 <SN6PR02MB415755B0CED30E8BEB062942D485A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20251209051128.76913-1-zhangyu1@linux.microsoft.com>
 <20251209051128.76913-4-zhangyu1@linux.microsoft.com>
In-Reply-To: <20251209051128.76913-4-zhangyu1@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7542:EE_
x-ms-office365-filtering-correlation-id: 9d3fd0e7-72f9-47e5-5229-08de4ee64fff
x-ms-exchange-slblob-mailprops:
 qdrM8TqeFBv5zL3Pq3ogIg0sNnRYStpoJoLAvAV+E3al6L5j+yVD7ofGID+NKPU/1gQmjqsfeObEY6naiYN+ZK67aU3f1a+BSTKaMYLnDPEDLmmssLzt4vt3KY1YqIlvMMDAJYO1nhHsBF1mz98ftJ+mhWymt1KwBI1qtZ1M6StDiQRHQQlf2r/X8o2OuDnk037n+OpNPRlqUQ7ldSejUTxjr1QhMErxC/ml7DJS4GMKfsgsbmmSjGlPqbSk9avIkFfO6KPihVKH1D00vOCldZt9/8w8fuavOUgH7wBVSC15cxycRIvb8oVj9kR5IQUekqpaKoYiDHWiTxXAyK/YcxqmDZ7jzsYy8F6YmzF0sfFjZhqo96cbvvJgHKrZrnGFuoAK9GMF06orQhPcnSkPgQM+xCz+xLFV6qi22p7to1u3sV2lxLqvrPMPb0Hde5E6TQMQbbn3oQJX8P9icuUQ3NuzpYbEWhfdRl6jh8SwlMqKkLgjXtM7hZ8JqLwcDhCWNJcmkJS7gMGGZJv/21lWrVhbJBowrC9BT/ltj6avA3pBUZlCVE306MXJMrhQItRPHN3oRlzAJu5TMhwi6Ge4RLc9aHwZX2sB23JGVQLtruTNZclR+AZty65s9JCKagB8J9j0ZwMWc673JXhMAonFN93tAvxV/BeuFF3NgjbVsPg8t16o2XoYThwvCK0lnkcZXRqOYnnRaoAvHaW8ljNro9edIcBhqeW4VBknJsZWIK6tVGxHZb+/fAZ3cN2+DWAzxTS8jII7PqQ4VjqGRMsLyntsdxFZfC8T
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|19110799012|12121999013|8060799015|8062599012|461199028|41001999006|51005399006|15080799012|31061999003|56899033|3412199025|440099028|40105399003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Z2G/UMMWOgBYlSApqmcdQKARP/CrpoZp+61tZf6B5GLg46CGUdWjXepXhdw4?=
 =?us-ascii?Q?1uwptBi5PlnAzA4Ou8oYQshDFkWBhVNhl4sRN6lcYq8I+3jsyDVB56Pggx0Q?=
 =?us-ascii?Q?rGQBwoxkkiBSLFHh5f0/C1sm1PXCOQOJxngfyK+atTubjezxbxzm06YiKu6v?=
 =?us-ascii?Q?DcNK06hiT/YFlXhck/IW6QUQ3BOvivEO7hukXR43RDhB4Xcm8bY/1pBaubVY?=
 =?us-ascii?Q?tj1SQJpjS0wTydkb+9AlsixlV2bgSGtmpNfaSQxBiDoD2zZywnMVkIokx0dv?=
 =?us-ascii?Q?n68heloGEOC2KtE9x4NkdP0ad+jRRjI4urh/tJMiwqh8ROZ6gFrXXDUKXcTn?=
 =?us-ascii?Q?KOtN0TUl27NaM+LoP9ORxlt7jjC6S04jX5mLxSnHpbgQBCArP+9qJvf1Jtqx?=
 =?us-ascii?Q?fiHsAB5j0COWCQlNuI1d3y14NrK82DjVvlIKjlRBh+mwOMzwjbfqGwP8ceDR?=
 =?us-ascii?Q?Jg5waVABm8HlsaowGTxOvO/KGMBM2VGnsgcrAjrQRErqX4drmt6ELLreYQej?=
 =?us-ascii?Q?Gx7G0wyiehUZTw+KUOksugGNh0JH4tK/LFta+2uptA1GYrORlTT+lfAZ7wnE?=
 =?us-ascii?Q?NWS4RLaNuHdOYd2a5491MyITgxHqGuMPGq57FJvUe8RRCaiFsoa63NddNKBs?=
 =?us-ascii?Q?PlYHGftDJBCZTA7yiqhlILc/hr64eAFmwqYAHEcuMweFxEiDdJbVjg/eNPAt?=
 =?us-ascii?Q?RCBpcjtJ+nPZ5++1d9TjHNvAKltCUiObOJOJPtQfHUz4wpn5BDR2oC64diqx?=
 =?us-ascii?Q?VFwlKqTY1WO+RNoITQH+rc5M719qYTFWuyWNgtk9E+2lNioSMvqGizxrXlCy?=
 =?us-ascii?Q?SGimowAJhNcbwh9a+cS8zLxghJKSEb2XA766geqZvpjTN7q0hBtypY4Gk0Xt?=
 =?us-ascii?Q?tAhU9SFkA9UWcQf1WVL+i0Ay7gPl2i7MiDTcqvf33AGqDrKYpgMldIzlQ5kR?=
 =?us-ascii?Q?Srltb5TgLUmBfWqBxFX99zppu5eWYPXE/fUVvspg1/UUQkfS8rSIMlffabeT?=
 =?us-ascii?Q?kjScaRy9uzshk7+AyQOpEcz7y7JtC7AMuv8cq98ZWBFWNuoBYFh8AIwZuJ2o?=
 =?us-ascii?Q?RIiBo5pYisnw0GL77kSnPNKkNWuc1WbZ0teLNo8g6QATiAgmjBvHFb9aFbqU?=
 =?us-ascii?Q?4ouycX3jZJWfuO81SAxgJiAUx9vQgJma33+8rdceAohUrX9u4U5bHDUZPZYq?=
 =?us-ascii?Q?+6oBRaZfuOT/cOt0XuS8e9Kh+8CvMovLieL1JVNEMWXbXGeHe4Np9dDN8Y0j?=
 =?us-ascii?Q?gCb/vudaZ5YJ512X8T4IeMO271MXywUURDH1mojBYQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3ijPXR6RszrUZ3UM1BjYeEvQ7Kdnmuda9ys+LYE9B3GCVo6z1V6sY6eOdYQ0?=
 =?us-ascii?Q?8tupLUsRdam08zHHBt4wGvLtyneM0Na7WCsaIjttr13Iqy5cafIuPjhJp/fR?=
 =?us-ascii?Q?Zxn7Qd/PdDR+/8oz8C+LVEcZH8G/RV3mR41l8cCzaspX/lnZFH7MKxaoDF44?=
 =?us-ascii?Q?nANhEDzma9cZZpssfVaKvgO5tSXWdXxdWXLh/6NIv7bQew9uahkJwS7scBbm?=
 =?us-ascii?Q?Uoixi/rxLldr//V1oCqN+73tyq+ZklXxtITIrl9JufotRnYbVUEQ5HoLHcDk?=
 =?us-ascii?Q?oQgF+jcjRKX8Ot53q/KDsixE3FexGoevtJ8ccSzn+kdiU3EhcsM9+2ymfJ9o?=
 =?us-ascii?Q?jv43YYcEE+zZbf+NgPjueuplxUOY+6LhHCVposQ7O9TFyhK1eUwcXMGAeanz?=
 =?us-ascii?Q?3voQ+DYnPGmyFYcgnXUvEsQOklBxqe27akVhwJpm9DvI04VDLgD3HD6MRsfG?=
 =?us-ascii?Q?3sR+4kgx25AAGsgmwrd0e1Ci88X8GPdsGS0WuzP4YBcBauEi6IlyqDsNfk37?=
 =?us-ascii?Q?i8ix/qYhVKR06ZtEWySC9OTDjL9SYhILOSEwYuWegvf8Dz7R/L/tXVC/atEl?=
 =?us-ascii?Q?78bckbEF6CdO9uX6Oi5xG7AeWZ5FewNZJ7uhWsVetGalNZLy75LZ9M0xuwSY?=
 =?us-ascii?Q?p8pp/lixln/f4IkKOTbZgAh0LGk10T0ucZLTIMUeyq4touyJD1kBfog+Rwzf?=
 =?us-ascii?Q?Uf9uM2Tne/x23YRaAL/7FGeE3UnwTEKFrH3ZTOFXEz0+NFPUrauUfWvZOMRm?=
 =?us-ascii?Q?nsK/bAcK7mClx90zVj8lPJy8vK2jLxTB8yU/vN0ROn6+SvbgSgmMUztHqPX5?=
 =?us-ascii?Q?bHkZxi6YEgrBHwewQMbG7Y2pYuE/9LgL/cSyeTmf1pfsy+C/oo2inSdJZoSp?=
 =?us-ascii?Q?PKXQP7Gfp98SSCjY3KPquZBueXkme7Uj/SrosIT3gpIJEMBjRQZIDyOpn1Sh?=
 =?us-ascii?Q?sGeeZohkuF4GD3MF0RWp1wuKdfw4mIKbHepKmAO85yQ6wLD08cJroqBPSpCb?=
 =?us-ascii?Q?Kb+RnMO1tTWIbmLSQbCGqyxiopFakQdMa8cLjhLBwIszOiCCb5NrFOekOnU8?=
 =?us-ascii?Q?A1cb4sHdrayQSmPLrTolvKU0umpw5hCisyrYT2oIrQpj2ZNKD8yk/p7qYASW?=
 =?us-ascii?Q?Ztv/MDGAZK5GeHCB9vvOB8kewKrhNyNhkZxwPtjH5CuTWZ8VKWDpKRBE11VP?=
 =?us-ascii?Q?JfvBpePJiL7P4CNL1V34YajxYvVtivP6cM+2f9pmnCmI45EV/chyrL80tHA9?=
 =?us-ascii?Q?9SSa6ER7c0AgKVsTwAzpZ2UMfsyL/xkG3RmflnKE2MT+bvGELNPl4UF1PwIo?=
 =?us-ascii?Q?3Fl5aTnj/IPlhZESzbjyKgXMCGGHgAOq7M0qnzJBeVVaJK9+11TgwufXp4wE?=
 =?us-ascii?Q?KsJt1Pk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3fd0e7-72f9-47e5-5229-08de4ee64fff
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 18:47:02.4381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7542

From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday, December 8, 202=
5 9:11 PM
>=20
> From: Wei Liu <wei.liu@kernel.org>
>=20
> Hyper-V guest IOMMU is a para-virtualized IOMMU based on hypercalls.
> Introduce the hypercalls used by the child partition to interact with
> this facility.
>=20
> These hypercalls fall into below categories:
> - Detection and capability: HVCALL_GET_IOMMU_CAPABILITIES is used to
>   detect the existence and capabilities of the guest IOMMU.
>=20
> - Device management: HVCALL_GET_LOGICAL_DEVICE_PROPERTY is used to
>   check whether an endpoint device is managed by the guest IOMMU.
>=20
> - Domain management: A set of hypercalls is provided to handle the
>   creation, configuration, and deletion of guest domains, as well as
>   the attachment/detachment of endpoint devices to/from those domains.
>=20
> - IOTLB flushing: HVCALL_FLUSH_DEVICE_DOMAIN is used to ask Hyper-V
>   for a domain-selective IOTLB flush(which in its handler may flush

Typo:  Add a space after "IOTLB flush" and before the open parenthesis.

>   the device TLB as well). Page-selective IOTLB flushes will be offered
>   by new hypercalls in future patches.
>=20
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Co-developed-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> Co-developed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Co-developed-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> ---
>  include/hyperv/hvgdk_mini.h |   8 +++
>  include/hyperv/hvhdk_mini.h | 123 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 131 insertions(+)
>=20
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 77abddfc750e..e5b302bbfe14 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -478,10 +478,16 @@ union hv_vp_assist_msr_contents {	 /*
> HV_REGISTER_VP_ASSIST_PAGE */
>  #define HVCALL_GET_VP_INDEX_FROM_APIC_ID			0x009a
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE	0x00af
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST	0x00b0
> +#define HVCALL_CREATE_DEVICE_DOMAIN			0x00b1
> +#define HVCALL_ATTACH_DEVICE_DOMAIN			0x00b2
>  #define HVCALL_SIGNAL_EVENT_DIRECT			0x00c0
>  #define HVCALL_POST_MESSAGE_DIRECT			0x00c1
>  #define HVCALL_DISPATCH_VP				0x00c2
> +#define HVCALL_DETACH_DEVICE_DOMAIN			0x00c4
> +#define HVCALL_DELETE_DEVICE_DOMAIN			0x00c5
>  #define HVCALL_GET_GPA_PAGES_ACCESS_STATES		0x00c9
> +#define HVCALL_CONFIGURE_DEVICE_DOMAIN			0x00ce
> +#define HVCALL_FLUSH_DEVICE_DOMAIN			0x00d0
>  #define HVCALL_ACQUIRE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d7
>  #define HVCALL_RELEASE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d8
>  #define HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY	0x00db
> @@ -492,6 +498,8 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_=
ASSIST_PAGE */
>  #define HVCALL_GET_VP_CPUID_VALUES			0x00f4
>  #define HVCALL_MMIO_READ				0x0106
>  #define HVCALL_MMIO_WRITE				0x0107
> +#define HVCALL_GET_IOMMU_CAPABILITIES			0x0125
> +#define HVCALL_GET_LOGICAL_DEVICE_PROPERTY		0x0127
>=20
>  /* HV_HYPERCALL_INPUT */
>  #define HV_HYPERCALL_RESULT_MASK	GENMASK_ULL(15, 0)
> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index 858f6a3925b3..ba6b91746b13 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h
> @@ -400,4 +400,127 @@ union hv_device_id {		/* HV_DEVICE_ID */
>  	} acpi;
>  } __packed;
>=20
> +/* Device domain types */
> +#define HV_DEVICE_DOMAIN_TYPE_S1	1 /* Stage 1 domain */
> +
> +/* ID for default domain and NULL domain */
> +#define HV_DEVICE_DOMAIN_ID_DEFAULT 0
> +#define HV_DEVICE_DOMAIN_ID_NULL    0xFFFFFFFFULL
> +
> +union hv_device_domain_id {
> +	u64 as_uint64;
> +	struct {
> +		u32 type: 4;
> +		u32 reserved: 28;
> +		u32 id;
> +	} __packed;
> +};
> +
> +struct hv_input_device_domain {
> +	u64 partition_id;
> +	union hv_input_vtl owner_vtl;
> +	u8 padding[7];
> +	union hv_device_domain_id domain_id;
> +} __packed;
> +
> +union hv_create_device_domain_flags {
> +	u32 as_uint32;
> +	struct {
> +		u32 forward_progress_required: 1;
> +		u32 inherit_owning_vtl: 1;
> +		u32 reserved: 30;
> +	} __packed;
> +};
> +
> +struct hv_input_create_device_domain {
> +	struct hv_input_device_domain device_domain;
> +	union hv_create_device_domain_flags create_device_domain_flags;
> +} __packed;
> +
> +struct hv_input_delete_device_domain {
> +	struct hv_input_device_domain device_domain;
> +} __packed;
> +
> +struct hv_input_attach_device_domain {
> +	struct hv_input_device_domain device_domain;
> +	union hv_device_id device_id;
> +} __packed;
> +
> +struct hv_input_detach_device_domain {
> +	u64 partition_id;
> +	union hv_device_id device_id;
> +} __packed;
> +
> +struct hv_device_domain_settings {
> +	struct {
> +		/*
> +		 * Enable translations. If not enabled, all transaction bypass
> +		 * S1 translations.
> +		 */
> +		u64 translation_enabled: 1;
> +		u64 blocked: 1;
> +		/*
> +		 * First stage address translation paging mode:
> +		 * 0: 4-level paging (default)
> +		 * 1: 5-level paging
> +		 */
> +		u64 first_stage_paging_mode: 1;
> +		u64 reserved: 61;
> +	} flags;
> +
> +	/* Address of translation table */
> +	u64 page_table_root;
> +} __packed;
> +
> +struct hv_input_configure_device_domain {
> +	struct hv_input_device_domain device_domain;
> +	struct hv_device_domain_settings settings;
> +} __packed;
> +
> +struct hv_input_get_iommu_capabilities {
> +	u64 partition_id;
> +	u64 reserved;
> +} __packed;
> +
> +struct hv_output_get_iommu_capabilities {
> +	u32 size;
> +	u16 reserved;
> +	u8  max_iova_width;
> +	u8  max_pasid_width;
> +
> +#define HV_IOMMU_CAP_PRESENT (1ULL << 0)
> +#define HV_IOMMU_CAP_S2 (1ULL << 1)
> +#define HV_IOMMU_CAP_S1 (1ULL << 2)
> +#define HV_IOMMU_CAP_S1_5LVL (1ULL << 3)
> +#define HV_IOMMU_CAP_PASID (1ULL << 4)
> +#define HV_IOMMU_CAP_ATS (1ULL << 5)
> +#define HV_IOMMU_CAP_PRI (1ULL << 6)
> +
> +	u64 iommu_cap;
> +	u64 pgsize_bitmap;
> +} __packed;
> +
> +enum hv_logical_device_property_code {
> +	HV_LOGICAL_DEVICE_PROPERTY_PVIOMMU =3D 10,
> +};
> +
> +struct hv_input_get_logical_device_property {
> +	u64 partition_id;
> +	u64 logical_device_id;
> +	enum hv_logical_device_property_code code;

Historically we've avoided "enum" types in structures that are part of
the hypervisor ABI. Use u32 here?

Michael

> +	u32 reserved;
> +} __packed;
> +
> +struct hv_output_get_logical_device_property {
> +#define HV_DEVICE_IOMMU_ENABLED (1ULL << 0)
> +	u64 device_iommu;
> +	u64 reserved;
> +} __packed;
> +
> +struct hv_input_flush_device_domain {
> +	struct hv_input_device_domain device_domain;
> +	u32 flags;
> +	u32 reserved;
> +} __packed;
> +
>  #endif /* _HV_HVHDK_MINI_H */
> --
> 2.49.0


