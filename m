Return-Path: <linux-arch+bounces-15714-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F495D05AEB
	for <lists+linux-arch@lfdr.de>; Thu, 08 Jan 2026 19:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAFC030E5E8F
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jan 2026 18:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3A22FFDEC;
	Thu,  8 Jan 2026 18:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="XsRi1RVz"
X-Original-To: linux-arch@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010018.outbound.protection.outlook.com [52.103.7.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4190E248F6F;
	Thu,  8 Jan 2026 18:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767898144; cv=fail; b=aenWLSgnHP29qfYTOdGa1NSp9now90J3KHp8VYuDcL+hy7+XJO8SO93pjx7qvOUz4z5rYl+dpyWsMZi0leHisylzg8t5dzyA87gZxtlxoPu9l2DlNWD/qBChiC4zm6ttNO/XTVF6W2mFTohFIBnglz5owpGiuFvR2K+pSGhwZh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767898144; c=relaxed/simple;
	bh=hCJnEMjUKt/YqcRzcEQJfTzI9pT5toTQ5ZgYkvCnFvY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o8VilBohAYE66phAAFo6PtNbPRtTKwUdkCrrK7bdRPTxuuGlWc5s54Pu+BCcbRCOdpGvyGmLH9Gd2SNA7Tpry+csbYo24TWW2zEj599RRu6tjT+afQUDqZD1cPlL8NZ+SCupWqZBK5Q7+QybNK6NbvoFIOru0t0eKaj7yPGesUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=XsRi1RVz; arc=fail smtp.client-ip=52.103.7.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHUS4q+MCFxOnZmdDU6mNmfOInIkMr+bdFl3RWpImGdDeo5Nj6vK+92aRFl4hZQhzrnTStSKe0kb1rVwnnVm2jB3GNvo24N0oVxlqB9m/CULHFPaXHVmkHPqOAWXgHuAdpY96TVvblyECfIsKqHEhpIKKlVOA/MU8vziYXa2tvCLshfKcB9VXwhbE37l8fyQRvbiwc70+jAxBInHQHfTZ4FM7JEZ/S0RF+qwy0P4bYpWNyUd1FBfpu6YmlouVzSiRODGxV9Vo4BE26T2iy0JKZmgdNJYHYfZUhIQjyS6v+nQcNLE0wZx/a0//dvhRYxDT/H4dyluYsfREtGiWkdeVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVCLRVJvVekevB0Wm2cQa5Oz22Ssg1OsD0ElfAtfWls=;
 b=GFWNiH75qHFFq9zhrZ++KI+pggUY2po8h8Uy+GXdR0twD8Xq6BtwM3Fyo4YcNdzHsUag5iUO5PqUn2Ee6b+JX+aAxuEbVShrJh0lEbRFgZBG6uUyovvgH+lddGnkyDe/Zy8JisVlvrkDTcuKOf8EW8pYrdoYqk+w2D4J0j8iADS6QssAfAbZ3+VSjO0gL+ZPtRpo1to4Xy+5uilcVojr49Cdx7GBwK+yTxeyYahozz71HuJ0FdUg/dJ9cQpWdJMkpSp4jOAEh+uDyvg0cMdrYxtddSMapQpikZ45w4qrj4Xh7xuDzJRVWVAfwvLMaixVrEu7vxjbKn57OEPK2anjtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVCLRVJvVekevB0Wm2cQa5Oz22Ssg1OsD0ElfAtfWls=;
 b=XsRi1RVzBon7ZbB5w4u7MVWughsYmYsT+zJIq1RWtbQZ+w9ArVauS+4f5umCg3bVPTvCqz9yXi04SmceBqHgstgbRHhdCTeccr59xWZaW/WaSwdf791PSLCR6A6fZkBsrA45lzU+r8S+bq226JVv00BnxlxXFQPxIKfaVezo/wbCMpvzCj0vY7Fty3JXENMXToJ1hstgvDRcBKGgHU2x39evi6a2GHK3N5taoPl0BsoDMlcBhipNOfM0F0dnHjBVgaYEYv9L39PIypiR5lXA8/Z+yUNjhvGQxlI+vNJhIaMRusN/NEA70gDm/kPdxFFCxJYd+sipePoixjom/GPoQQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7542.namprd02.prod.outlook.com (2603:10b6:510:51::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 18:48:59 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 18:48:59 +0000
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
Subject: RE: [RFC v1 5/5] iommu/hyperv: Add para-virtualized IOMMU support for
 Hyper-V guest
Thread-Topic: [RFC v1 5/5] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Thread-Index: AQHcaMpb286bdBhc60y7Ts6ZOD3veLVIruwg
Date: Thu, 8 Jan 2026 18:48:59 +0000
Message-ID:
 <SN6PR02MB41572D46CF6C1DE68974EAA1D485A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20251209051128.76913-1-zhangyu1@linux.microsoft.com>
 <20251209051128.76913-6-zhangyu1@linux.microsoft.com>
In-Reply-To: <20251209051128.76913-6-zhangyu1@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7542:EE_
x-ms-office365-filtering-correlation-id: 4d248f89-e2dc-41af-01b1-08de4ee69582
x-ms-exchange-slblob-mailprops:
 qdrM8TqeFBv5zL3Pq3ogIg0sNnRYStpoVeZPWVM2ZuuQg9okJ2VK7M6ap3kaoEl71fJISyUfkwKt2Qn6dbaAWBD3iEwZaFqMkAMsftqNCrYZUGoVF1TM4H0Nl8rt2Mv0t9ohKCrDQheffKf1zKS9Swzt2+fjMlQzG1ERXjrSM3OWtkAXwvfT594BIKQAAdSOj/qGPzOoUHRnUeJOJLY0Srdh6zW81LQ7SE0c9dmuIzH2wT9cHQtId9/inFy1VBKRvJq1NOJrE6pdMEYva5sKjGO3nvSVepdzNjT0bo12ErEf9xcXGBEjtI4uUpNaSLCh+9Jbus59ZoKcvXsgXYZxNlnQgAuzXjQsr1EudXjAAKGR8J3WNYJ1aKn3ZvGNeRjgIw+8Tv46aQL+SMRuLo060dCgYLr0iggyYp4pLoM437boTDM+N+70fml/yYA+gO7f8WWeyCaI7XL4z3f4jq+LOFubD38OCF5TxJMatXBP8aAfcSQI4otE0qQuyVaWSpmAxKzA600a/zunRgMMiqOFLlOw6dHT58PY21xQ2ah5d9+0w6+vg0YRYF/EAafYb1iBJ8AsN/nD+dd91JcVFJO/WkbK/hxo2q1l/MGJoQ5h9c2/mbF9KdWna7Uxk5B2SEptlHKc82dilPvGXC5XBIrUbFXCSxEOw5U4P9STIwlPwAC3qiwvIQHvK9IBbbGKH4YHl9Fm9cpnhfCWCrg7wRvRqejuFcnvzy78utMq5pnukXyIIeYx8M8fvqcjf1HwPuuwn2rpIr8m/F2WeIphB3kf0t3U7oiU8ZA5
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|19110799012|8060799015|8062599012|461199028|41001999006|51005399006|15080799012|31061999003|56899033|3412199025|440099028|40105399003|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fohx/860NtO0IU13q7XZOe+OwJiOVF9ESrIQXcuLbYEgoh1uncOIwH9iqp1I?=
 =?us-ascii?Q?Hz6yZtoYHLTYzfIOQcqm6UuyZh4SXQhvvMvnPYTOyESThpOWQ8Ade4vFaA6y?=
 =?us-ascii?Q?vWwsRK5aZ0W9ivb2cgE0jLrv5U0v/UZzfaLT6b30Old2RtyMcmsPMQMpPnXB?=
 =?us-ascii?Q?T5Q9JEBFwuh3UbI6+XrAiAwPl+84/rA1z//utOXjGDKKYRpQf5bZOSBbK8Jp?=
 =?us-ascii?Q?s/BNkzsciD6zaU7jmRvCiVL1qHbn1CxL3EWwo4jyK5MW57iYF9q4UYX022Ga?=
 =?us-ascii?Q?tPYCFiP33KYj7F5aDHJ30yOR4xmS0eEFL6AxHOpG5cyPzfUkhKQyX07QgUd9?=
 =?us-ascii?Q?MN+VXv4Vu/E2adYl/gsVm9ZmbY/g66nwIHaWmepnzbRUrgVqYnJPwg+RWpEN?=
 =?us-ascii?Q?XdMb/B8Kpf4vj3d/byYiIAWresHJORbIDVTcotADFaGppuJ0dgHFVHLY8CQB?=
 =?us-ascii?Q?joCh3pVZW4v3dcbOw3OVYRyRAlhgokg/4CJe5C159h9nFo5wUSDZAUyvoKcu?=
 =?us-ascii?Q?9jU27vVsjx3xKcoGplWDL2exG/hjltIgGA1hB8H2kM0IrrDtn30J4UDB3lH4?=
 =?us-ascii?Q?r2tAL8t6tnrC6Y12CAOi+Oc5dG3HmqAqB4asQMpkUV+z3hFn736xilnB/AmX?=
 =?us-ascii?Q?Z6O6DrQ2egu3JbpUwW2vtxLVOsqiDv30Zs2Ml+zdnbda8GL6fr9pPEarmvcv?=
 =?us-ascii?Q?7Svup7PMbLgPf6isTy0tpl+CNI/Pemy0P9NR3oK7Rcg9ZTqS1AD1c5PugZTL?=
 =?us-ascii?Q?ycbpzTj/3etuVk3cgThscAkoDoIAr8uJcuF5lizSxNbamHIBu861WhLI+CHn?=
 =?us-ascii?Q?DTvXFAbTPPApd3B6ZkaStT1RCWMan9c9Qmp2yMi8/6miyeTmwFKN1kzoE2/g?=
 =?us-ascii?Q?lxiKjfl/Zk/IrOp+tj0K8T66jnP0/DFghA70voM6t3cr6jKlLVQUZKt4Fabv?=
 =?us-ascii?Q?QWqgANMVJ19EsGtT1DraosPDM7tSryCNBlNa3kPj7vAK+Rcwyo96AxBE01MF?=
 =?us-ascii?Q?SWdxcJfGbKsPD3SmOKAgjE7V8ojJ5dJpnwiCnqnr22GEnKosf/GC7LXqqRhW?=
 =?us-ascii?Q?72PP71Zt0apg8kWXev4auoc8flD6INZSLg1niuZEXFVMqqTMgp0bd6ZeKALj?=
 =?us-ascii?Q?kginP6FS3V8GUZEjlSQAHoQFeJTAyRpMp7vUUBD5NmdDAjp0ez5pGtTxQJTY?=
 =?us-ascii?Q?kIOWuvW9CriSxtfuwJOca21HZE78ehICVZsOZbmcc/7NVpeRny5jKv7/Xm3Q?=
 =?us-ascii?Q?XKwgHzFtu3+Q3OUdQVz+gl6n+i1upHLc1YbhFa4OJQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KnR99xYEenRXQDpznifpkoia+foNwbIEHVtH+bX2Nah3SDl11VgZrcIZsRqm?=
 =?us-ascii?Q?2oiE/0phD1rMgwOYeY5WGXZvBnuLATzaG+6H7Bj+CKWug4kVvCFsJL9pok1N?=
 =?us-ascii?Q?zkx2QmLfurBxcMbsUc7gKfLmiBvIEFBC+1Q0JnJgntGmVbARPBwIaLhdAU1o?=
 =?us-ascii?Q?nB/6GmCc3uxVgjISdXEGRRpUVxuu/MWY4oaFMaZfhoMo52nGPIfCAxmMV70F?=
 =?us-ascii?Q?wmrkvo9wlrvHptFAROf1PfKWA6VRb7uDGxHzS1SjCDXsFcUaw2L5IHISgbSf?=
 =?us-ascii?Q?uPoFH26L1gB/vkX0B9Vw/ojBvj6/0ZLwHydyF830MaTyO1jZTFHCBFgt1exW?=
 =?us-ascii?Q?k1GcPrN2o/BkAeFMTCnknGLnckLIXNoB7lH5oJ5KQ4tnMuadgeDgF4lR85rh?=
 =?us-ascii?Q?T4G0K4v9Bch7MpoIRhoG+Vg7fF3EEptvVJ6a3R2vQb/sxTilKcG2AuliV2qt?=
 =?us-ascii?Q?y9KC6gaPxghRSTbelU/+MLpIjpIUVaByThMHA8DwUHDxWlshx3YqxxQ2OvLi?=
 =?us-ascii?Q?9DRU+Q9wdByGxeYdGR2gzudF7z3behdLbojkctwq7ZxPI5ZI28ZtSAov1tCS?=
 =?us-ascii?Q?9n4510IOmaXTuXb2VBCSQF1loqT+Ksw0O1atCE4Yab6O643iTJxVhAltuOT5?=
 =?us-ascii?Q?tM9qFcWhTTN2eGT2UNJDSMA5iFDH9QFgiNmza3pmzbrGrOv0HorI1D0wjEjm?=
 =?us-ascii?Q?dubjolmE8cG/iW20fatimyUii3ZmGf/Cw7pIrBXVvU/SlXzeNaWgpOrkkcOj?=
 =?us-ascii?Q?4tumG0DEL17MZbM0JvUq3SXwair475uLNTOGX5pIBWY9sroEOZU8SUntcqo8?=
 =?us-ascii?Q?qnYmE3skHkeOoFU1hvSZPD7gnWoLO/+8FmknK5id9a6NIjg/yVZnZK4vvwse?=
 =?us-ascii?Q?Asw722eyeWsStYX50CbKly5dDLGOtHDeFTEw/Ct5c1Wv6OiEf5xU9znDvKm2?=
 =?us-ascii?Q?n6k78ImGS+R3UkVpOJyC763S9zGBG/PtvdWPG0p3ArF3j9SyiTedoESzuLut?=
 =?us-ascii?Q?2xvIVQzNxqGocE4ujW8OV9HymQ6hRAF8tmJMh0pUtZpNiLs+zcNRgufC9G1w?=
 =?us-ascii?Q?u5UTdIg5MhrPMye75Hlt3FRRoiCBZgLezczT5/ToBREhRyj3rCazdKRwrT/d?=
 =?us-ascii?Q?ZJCj37lLENaQaGP89JQ8YYb61MWFwO82LrR4TbtizCDN8UIi6rVbFnO3YRpN?=
 =?us-ascii?Q?DlAn8c2PsjIHDSau4Z+GtMfAapqIscCYk1z7dwyiNY2hf5Q3nK2CR/V/VmiQ?=
 =?us-ascii?Q?6bJn6v7/Txjm4uzSX8TFtP+S/tnHLbvJVFgKmoqgAGOBcgXQkONF3Xxo+qFi?=
 =?us-ascii?Q?eNy6uHtXkZJsK5BP2cPPjs4IGzAC6w6TK8f7p2b41h4MKi9dPa0hVWoCQhYC?=
 =?us-ascii?Q?o2wh36w=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d248f89-e2dc-41af-01b1-08de4ee69582
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 18:48:59.0753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7542

From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday, December 8, 202=
5 9:11 PM
>=20
> Add a para-virtualized IOMMU driver for Linux guests running on Hyper-V.
> This driver implements stage-1 IO translation within the guest OS.
> It integrates with the Linux IOMMU core, utilizing Hyper-V hypercalls
> for:
>  - Capability discovery
>  - Domain allocation, configuration, and deallocation
>  - Device attachment and detachment
>  - IOTLB invalidation
>=20
> The driver constructs x86-compatible stage-1 IO page tables in the
> guest memory using consolidated IO page table helpers. This allows
> the guest to manage stage-1 translations independently of vendor-
> specific drivers (like Intel VT-d or AMD IOMMU).
>=20
> Hyper-v consumes this stage-1 IO page table, when a device domain is

s/Hyper-v/Hyper-V/

> created and configured, and nests it with the host's stage-2 IO page
> tables, therefore elemenating the VM exits for guest IOMMU mapping

s/elemenating/eliminating/

> operations.
>=20
> For guest IOMMU unmapping operations, VM exits to perform the IOTLB
> flush(and possibly the device TLB flush) is still unavoidable. For

Typo: Add a space after "flush" and before the open parenthesis.

> now, HVCALL_FLUSH_DEVICE_DOMAIN	is used to implement a domain-selective

Typo:  Extra white space after HVCALL_FLUSH_DEVICE_DOMAIN

> IOTLB flush. New hypercalls for finer-grained hypercall will be provided
> in future patches.
>=20
> Co-developed-by: Wei Liu <wei.liu@kernel.org>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Co-developed-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> Co-developed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> ---
>  drivers/iommu/hyperv/Kconfig  |  14 +
>  drivers/iommu/hyperv/Makefile |   1 +
>  drivers/iommu/hyperv/iommu.c  | 608 ++++++++++++++++++++++++++++++++++
>  drivers/iommu/hyperv/iommu.h  |  53 +++
>  4 files changed, 676 insertions(+)
>  create mode 100644 drivers/iommu/hyperv/iommu.c
>  create mode 100644 drivers/iommu/hyperv/iommu.h
>=20
> diff --git a/drivers/iommu/hyperv/Kconfig b/drivers/iommu/hyperv/Kconfig
> index 30f40d867036..fa3c77752d7b 100644
> --- a/drivers/iommu/hyperv/Kconfig
> +++ b/drivers/iommu/hyperv/Kconfig
> @@ -8,3 +8,17 @@ config HYPERV_IOMMU
>  	help
>  	  Stub IOMMU driver to handle IRQs to support Hyper-V Linux
>  	  guest and root partitions.
> +
> +if HYPERV_IOMMU
> +config HYPERV_PVIOMMU
> +	bool "Microsoft Hypervisor para-virtualized IOMMU support"
> +	depends on X86 && HYPERV && PCI_HYPERV

Depending on PCI_HYPERV is problematic as pointed out in my comments
on Patch 1 of this series.

> +	depends on IOMMU_PT

Use "select IOMMU_PT" instead of "depends"? Other IOMMU drivers use
"select".

> +	select IOMMU_API
> +	select IOMMU_DMA

IOMMU_DMA is enabled by default on x86 and arm64 architectures.
Other IOMMU drivers don't select it, so maybe this could be dropped.

> +	select DMA_OPS

DMA_OPS doesn't exist.  I'm not sure what this is supposed to be.

> +	select IOMMU_IOVA
> +	default HYPERV
> +	help
> +	  A para-virtualized IOMMU for Microsoft Hypervisor guest.
> +endif
> diff --git a/drivers/iommu/hyperv/Makefile b/drivers/iommu/hyperv/Makefil=
e
> index 9f557bad94ff..8669741c0a51 100644
> --- a/drivers/iommu/hyperv/Makefile
> +++ b/drivers/iommu/hyperv/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_HYPERV_IOMMU) +=3D irq_remapping.o
> +obj-$(CONFIG_HYPERV_PVIOMMU) +=3D iommu.o
> diff --git a/drivers/iommu/hyperv/iommu.c b/drivers/iommu/hyperv/iommu.c
> new file mode 100644
> index 000000000000..3d0aff868e16
> --- /dev/null
> +++ b/drivers/iommu/hyperv/iommu.c
> @@ -0,0 +1,608 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Hyper-V IOMMU driver.
> + *
> + * Copyright (C) 2019, 2024-2025 Microsoft, Inc.
> + */
> +
> +#include <linux/iommu.h>
> +#include <linux/pci.h>
> +#include <linux/dma-map-ops.h>
> +#include <linux/generic_pt/iommu.h>
> +#include <linux/syscore_ops.h>
> +#include <linux/pci-ats.h>
> +
> +#include <asm/iommu.h>
> +#include <asm/hypervisor.h>
> +#include <asm/mshyperv.h>
> +
> +#include "iommu.h"
> +#include "../dma-iommu.h"
> +#include "../iommu-pages.h"
> +
> +static void hv_iommu_detach_dev(struct iommu_domain *domain, struct devi=
ce *dev);
> +static void hv_flush_device_domain(struct hv_iommu_domain *hv_domain);

With some fairly simple reordering of code in this source file, these
two declarations could go away. Generally, the best practice is to order
so such declarations aren't needed, though that's not always possible.

> +struct hv_iommu_dev *hv_iommu_device;
> +static struct hv_iommu_domain hv_identity_domain;
> +static struct hv_iommu_domain hv_blocking_domain;

Why is hv_iommu_device allocated dynamically while the two
domains are allocated statically? Seems like the approach could
be consistent, though maybe there's some reason I'm missing.

> +static const struct iommu_domain_ops hv_iommu_identity_domain_ops;
> +static const struct iommu_domain_ops hv_iommu_blocking_domain_ops;
> +static struct iommu_ops hv_iommu_ops;

I'm wondering if this declaration could also be eliminated by some
reordering, though I didn't take time to figure out the details. Maybe
this is one of those cases that can't be avoided.

> +
> +#define hv_iommu_present(iommu_cap) (iommu_cap & HV_IOMMU_CAP_PRESENT)
> +#define hv_iommu_s1_domain_supported(iommu_cap) (iommu_cap & HV_IOMMU_CA=
P_S1)
> +#define hv_iommu_5lvl_supported(iommu_cap) (iommu_cap & HV_IOMMU_CAP_S1_=
5LVL)
> +#define hv_iommu_ats_supported(iommu_cap) (iommu_cap & HV_IOMMU_CAP_ATS)
> +
> +static int hv_create_device_domain(struct hv_iommu_domain *hv_domain, u3=
2 domain_stage)
> +{
> +	int ret;
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_create_device_domain *input;
> +
> +	ret =3D ida_alloc_range(&hv_iommu_device->domain_ids,
> +			hv_iommu_device->first_domain, hv_iommu_device->last_domain,
> +			GFP_KERNEL);
> +	if (ret < 0)
> +		return ret;
> +
> +	hv_domain->device_domain.partition_id =3D HV_PARTITION_ID_SELF;
> +	hv_domain->device_domain.domain_id.type =3D domain_stage;
> +	hv_domain->device_domain.domain_id.id =3D ret;
> +	hv_domain->hv_iommu =3D hv_iommu_device;
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->device_domain =3D hv_domain->device_domain;
> +	input->create_device_domain_flags.forward_progress_required =3D 1;
> +	input->create_device_domain_flags.inherit_owning_vtl =3D 0;
> +	status =3D hv_do_hypercall(HVCALL_CREATE_DEVICE_DOMAIN, input, NULL);
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status)) {
> +		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
> +		ida_free(&hv_iommu_device->domain_ids, hv_domain->device_domain.domain=
_id.id);
> +	}
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +static void hv_delete_device_domain(struct hv_iommu_domain *hv_domain)
> +{
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_delete_device_domain *input;
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->device_domain =3D hv_domain->device_domain;
> +	status =3D hv_do_hypercall(HVCALL_DELETE_DEVICE_DOMAIN, input, NULL);
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
> +
> +	ida_free(&hv_domain->hv_iommu->domain_ids, hv_domain->device_domain.dom=
ain_id.id);
> +}
> +
> +static bool hv_iommu_capable(struct device *dev, enum iommu_cap cap)
> +{
> +	switch (cap) {
> +	case IOMMU_CAP_CACHE_COHERENCY:
> +		return true;
> +	case IOMMU_CAP_DEFERRED_FLUSH:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static int hv_iommu_attach_dev(struct iommu_domain *domain, struct devic=
e *dev)
> +{
> +	u64 status;
> +	unsigned long flags;
> +	struct pci_dev *pdev;
> +	struct hv_input_attach_device_domain *input;
> +	struct hv_iommu_endpoint *vdev =3D dev_iommu_priv_get(dev);
> +	struct hv_iommu_domain *hv_domain =3D to_hv_iommu_domain(domain);
> +
> +	/* Only allow PCI devices for now */
> +	if (!dev_is_pci(dev))
> +		return -EINVAL;
> +
> +	if (vdev->hv_domain =3D=3D hv_domain)
> +		return 0;
> +
> +	if (vdev->hv_domain)
> +		hv_iommu_detach_dev(&vdev->hv_domain->domain, dev);
> +
> +	pdev =3D to_pci_dev(dev);
> +	dev_dbg(dev, "Attaching (%strusted) to %d\n", pdev->untrusted ? "un" : =
"",
> +		hv_domain->device_domain.domain_id.id);
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->device_domain =3D hv_domain->device_domain;
> +	input->device_id.as_uint64 =3D hv_build_logical_dev_id(pdev);
> +	status =3D hv_do_hypercall(HVCALL_ATTACH_DEVICE_DOMAIN, input, NULL);
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status)) {
> +		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
> +	} else {
> +		vdev->hv_domain =3D hv_domain;
> +		spin_lock_irqsave(&hv_domain->lock, flags);
> +		list_add(&vdev->list, &hv_domain->dev_list);
> +		spin_unlock_irqrestore(&hv_domain->lock, flags);
> +	}
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +static void hv_iommu_detach_dev(struct iommu_domain *domain, struct devi=
ce *dev)
> +{
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_detach_device_domain *input;
> +	struct pci_dev *pdev;
> +	struct hv_iommu_domain *hv_domain =3D to_hv_iommu_domain(domain);
> +	struct hv_iommu_endpoint *vdev =3D dev_iommu_priv_get(dev);
> +
> +	/* See the attach function, only PCI devices for now */
> +	if (!dev_is_pci(dev) || vdev->hv_domain !=3D hv_domain)
> +		return;
> +
> +	pdev =3D to_pci_dev(dev);
> +
> +	dev_dbg(dev, "Detaching from %d\n", hv_domain->device_domain.domain_id.=
id);
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->partition_id =3D HV_PARTITION_ID_SELF;
> +	input->device_id.as_uint64 =3D hv_build_logical_dev_id(pdev);
> +	status =3D hv_do_hypercall(HVCALL_DETACH_DEVICE_DOMAIN, input, NULL);
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
> +
> +	spin_lock_irqsave(&hv_domain->lock, flags);
> +	hv_flush_device_domain(hv_domain);
> +	list_del(&vdev->list);
> +	spin_unlock_irqrestore(&hv_domain->lock, flags);
> +
> +	vdev->hv_domain =3D NULL;
> +}
> +
> +static int hv_iommu_get_logical_device_property(struct device *dev,
> +					enum hv_logical_device_property_code code,
> +					struct hv_output_get_logical_device_property *property)
> +{
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_get_logical_device_property *input;
> +	struct hv_output_get_logical_device_property *output;
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> +	memset(input, 0, sizeof(*input));
> +	memset(output, 0, sizeof(*output));

General practice is to *not* zero the output area prior to a hypercall. The=
 hypervisor
should be correctly setting all the output bits. There are a couple of case=
s in the new
MSHV code where the output is zero'ed, but I'm planning to submit a patch t=
o
remove those so that hypercall call sites that have output are consistent a=
cross the
code base. Of course, it's possible to have a Hyper-V bug where it doesn't =
do the
right thing, and zero'ing the output could be done as a workaround. But suc=
h cases
should be explicitly known with code comments indicating the reason for the
zero'ing.

Same applies in hv_iommu_detect().

> +	input->partition_id =3D HV_PARTITION_ID_SELF;
> +	input->logical_device_id =3D hv_build_logical_dev_id(to_pci_dev(dev));
> +	input->code =3D code;
> +	status =3D hv_do_hypercall(HVCALL_GET_LOGICAL_DEVICE_PROPERTY, input, o=
utput);
> +	*property =3D *output;
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +static struct iommu_device *hv_iommu_probe_device(struct device *dev)
> +{
> +	struct pci_dev *pdev;
> +	struct hv_iommu_endpoint *vdev;
> +	struct hv_output_get_logical_device_property device_iommu_property =3D =
{0};
> +
> +	if (!dev_is_pci(dev))
> +		return ERR_PTR(-ENODEV);
> +
> +	if (hv_iommu_get_logical_device_property(dev,
> +						 HV_LOGICAL_DEVICE_PROPERTY_PVIOMMU,
> +						 &device_iommu_property) ||
> +	    !(device_iommu_property.device_iommu & HV_DEVICE_IOMMU_ENABLED))
> +		return ERR_PTR(-ENODEV);
> +
> +	pdev =3D to_pci_dev(dev);
> +	vdev =3D kzalloc(sizeof(*vdev), GFP_KERNEL);
> +	if (!vdev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	vdev->dev =3D dev;
> +	vdev->hv_iommu =3D hv_iommu_device;
> +	dev_iommu_priv_set(dev, vdev);
> +
> +	if (hv_iommu_ats_supported(hv_iommu_device->cap) &&
> +	    pci_ats_supported(pdev))
> +		pci_enable_ats(pdev, __ffs(hv_iommu_device->pgsize_bitmap));
> +
> +	return &vdev->hv_iommu->iommu;
> +}
> +
> +static void hv_iommu_release_device(struct device *dev)
> +{
> +	struct hv_iommu_endpoint *vdev =3D dev_iommu_priv_get(dev);
> +
> +	if (vdev->hv_domain)
> +		hv_iommu_detach_dev(&vdev->hv_domain->domain, dev);
> +
> +	dev_iommu_priv_set(dev, NULL);
> +	set_dma_ops(dev, NULL);
> +
> +	kfree(vdev);
> +}
> +
> +static struct iommu_group *hv_iommu_device_group(struct device *dev)
> +{
> +	if (dev_is_pci(dev))
> +		return pci_device_group(dev);
> +	else
> +		return generic_device_group(dev);
> +}
> +
> +static int hv_configure_device_domain(struct hv_iommu_domain *hv_domain,=
 u32 domain_type)
> +{
> +	u64 status;
> +	unsigned long flags;
> +	struct pt_iommu_x86_64_hw_info pt_info;
> +	struct hv_input_configure_device_domain *input;
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->device_domain =3D hv_domain->device_domain;
> +	input->settings.flags.blocked =3D (domain_type =3D=3D IOMMU_DOMAIN_BLOC=
KED);
> +	input->settings.flags.translation_enabled =3D (domain_type !=3D IOMMU_D=
OMAIN_IDENTITY);
> +
> +	if (domain_type & __IOMMU_DOMAIN_PAGING) {
> +		pt_iommu_x86_64_hw_info(&hv_domain->pt_iommu_x86_64, &pt_info);
> +		input->settings.page_table_root =3D pt_info.gcr3_pt;
> +		input->settings.flags.first_stage_paging_mode =3D
> +			pt_info.levels =3D=3D 5;
> +	}
> +	status =3D hv_do_hypercall(HVCALL_CONFIGURE_DEVICE_DOMAIN, input, NULL)=
;
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +static int __init hv_initialize_static_domains(void)
> +{
> +	int ret;
> +	struct hv_iommu_domain *hv_domain;
> +
> +	/* Default stage-1 identity domain */
> +	hv_domain =3D &hv_identity_domain;
> +	memset(hv_domain, 0, sizeof(*hv_domain));

The memset() isn't necessary. hv_identity_domain is a static variable, so i=
t is already
initialized to zero.

> +
> +	ret =3D hv_create_device_domain(hv_domain, HV_DEVICE_DOMAIN_TYPE_S1);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D hv_configure_device_domain(hv_domain, IOMMU_DOMAIN_IDENTITY);
> +	if (ret)
> +		goto delete_identity_domain;
> +
> +	hv_domain->domain.type =3D IOMMU_DOMAIN_IDENTITY;
> +	hv_domain->domain.ops =3D &hv_iommu_identity_domain_ops;
> +	hv_domain->domain.owner =3D &hv_iommu_ops;
> +	hv_domain->domain.geometry =3D hv_iommu_device->geometry;
> +	hv_domain->domain.pgsize_bitmap =3D hv_iommu_device->pgsize_bitmap;
> +	INIT_LIST_HEAD(&hv_domain->dev_list);
> +
> +	/* Default stage-1 blocked domain */
> +	hv_domain =3D &hv_blocking_domain;
> +	memset(hv_domain, 0, sizeof(*hv_domain));

Same here.

> +
> +	ret =3D hv_create_device_domain(hv_domain, HV_DEVICE_DOMAIN_TYPE_S1);
> +	if (ret)
> +		goto delete_identity_domain;
> +
> +	ret =3D hv_configure_device_domain(hv_domain, IOMMU_DOMAIN_BLOCKED);
> +	if (ret)
> +		goto delete_blocked_domain;
> +
> +	hv_domain->domain.type =3D IOMMU_DOMAIN_BLOCKED;
> +	hv_domain->domain.ops =3D &hv_iommu_blocking_domain_ops;
> +	hv_domain->domain.owner =3D &hv_iommu_ops;
> +	hv_domain->domain.geometry =3D hv_iommu_device->geometry;
> +	hv_domain->domain.pgsize_bitmap =3D hv_iommu_device->pgsize_bitmap;
> +	INIT_LIST_HEAD(&hv_domain->dev_list);
> +
> +	return 0;
> +
> +delete_blocked_domain:
> +	hv_delete_device_domain(&hv_blocking_domain);
> +delete_identity_domain:
> +	hv_delete_device_domain(&hv_identity_domain);
> +	return ret;
> +}
> +
> +#define INTERRUPT_RANGE_START	(0xfee00000)
> +#define INTERRUPT_RANGE_END	(0xfeefffff)
> +static void hv_iommu_get_resv_regions(struct device *dev,
> +		struct list_head *head)
> +{
> +	struct iommu_resv_region *region;
> +
> +	region =3D iommu_alloc_resv_region(INTERRUPT_RANGE_START,
> +				      INTERRUPT_RANGE_END - INTERRUPT_RANGE_START + 1,
> +				      0, IOMMU_RESV_MSI, GFP_KERNEL);
> +	if (!region)
> +		return;
> +
> +	list_add_tail(&region->list, head);
> +}
> +
> +static void hv_flush_device_domain(struct hv_iommu_domain *hv_domain)
> +{
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_flush_device_domain *input;
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->device_domain.partition_id =3D hv_domain->device_domain.partitio=
n_id;
> +	input->device_domain.owner_vtl =3D hv_domain->device_domain.owner_vtl;
> +	input->device_domain.domain_id.type =3D hv_domain->device_domain.domain=
_id.type;
> +	input->device_domain.domain_id.id =3D hv_domain->device_domain.domain_i=
d.id;
> +	status =3D hv_do_hypercall(HVCALL_FLUSH_DEVICE_DOMAIN, input, NULL);
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
> +}
> +
> +static void hv_iommu_flush_iotlb_all(struct iommu_domain *domain)
> +{
> +	hv_flush_device_domain(to_hv_iommu_domain(domain));
> +}
> +
> +static void hv_iommu_iotlb_sync(struct iommu_domain *domain,
> +				struct iommu_iotlb_gather *iotlb_gather)
> +{
> +	hv_flush_device_domain(to_hv_iommu_domain(domain));
> +
> +	iommu_put_pages_list(&iotlb_gather->freelist);
> +}
> +
> +static void hv_iommu_paging_domain_free(struct iommu_domain *domain)
> +{
> +	struct hv_iommu_domain *hv_domain =3D to_hv_iommu_domain(domain);
> +
> +	/* Free all remaining mappings */
> +	pt_iommu_deinit(&hv_domain->pt_iommu);
> +
> +	hv_delete_device_domain(hv_domain);
> +
> +	kfree(hv_domain);
> +}
> +
> +static const struct iommu_domain_ops hv_iommu_identity_domain_ops =3D {
> +	.attach_dev	=3D hv_iommu_attach_dev,
> +};
> +
> +static const struct iommu_domain_ops hv_iommu_blocking_domain_ops =3D {
> +	.attach_dev	=3D hv_iommu_attach_dev,
> +};
> +
> +static const struct iommu_domain_ops hv_iommu_paging_domain_ops =3D {
> +	.attach_dev	=3D hv_iommu_attach_dev,
> +	IOMMU_PT_DOMAIN_OPS(x86_64),
> +	.flush_iotlb_all =3D hv_iommu_flush_iotlb_all,
> +	.iotlb_sync =3D hv_iommu_iotlb_sync,
> +	.free =3D hv_iommu_paging_domain_free,
> +};
> +
> +static struct iommu_domain *hv_iommu_domain_alloc_paging(struct device *=
dev)
> +{
> +	int ret;
> +	struct hv_iommu_domain *hv_domain;
> +	struct pt_iommu_x86_64_cfg cfg =3D {};
> +
> +	hv_domain =3D kzalloc(sizeof(*hv_domain), GFP_KERNEL);
> +	if (!hv_domain)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret =3D hv_create_device_domain(hv_domain, HV_DEVICE_DOMAIN_TYPE_S1);
> +	if (ret) {
> +		kfree(hv_domain);
> +		return ERR_PTR(ret);
> +	}
> +
> +	hv_domain->domain.pgsize_bitmap =3D hv_iommu_device->pgsize_bitmap;
> +	hv_domain->domain.geometry =3D hv_iommu_device->geometry;
> +	hv_domain->pt_iommu.nid =3D dev_to_node(dev);
> +	INIT_LIST_HEAD(&hv_domain->dev_list);
> +	spin_lock_init(&hv_domain->lock);
> +
> +	cfg.common.hw_max_vasz_lg2 =3D hv_iommu_device->max_iova_width;
> +	cfg.common.hw_max_oasz_lg2 =3D 52;

FYI, when this code is rebased to the latest linux-next, need to set cfg.to=
p_level as well.

> +
> +	ret =3D pt_iommu_x86_64_init(&hv_domain->pt_iommu_x86_64, &cfg, GFP_KER=
NEL);
> +	if (ret) {
> +		hv_delete_device_domain(hv_domain);
> +		return ERR_PTR(ret);
> +	}
> +
> +	hv_domain->domain.ops =3D &hv_iommu_paging_domain_ops;
> +
> +	ret =3D hv_configure_device_domain(hv_domain, __IOMMU_DOMAIN_PAGING);
> +	if (ret) {
> +		pt_iommu_deinit(&hv_domain->pt_iommu);
> +		hv_delete_device_domain(hv_domain);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return &hv_domain->domain;
> +}
> +
> +static struct iommu_ops hv_iommu_ops =3D {
> +	.capable		  =3D hv_iommu_capable,
> +	.domain_alloc_paging	  =3D hv_iommu_domain_alloc_paging,
> +	.probe_device		  =3D hv_iommu_probe_device,
> +	.release_device		  =3D hv_iommu_release_device,
> +	.device_group		  =3D hv_iommu_device_group,
> +	.get_resv_regions	  =3D hv_iommu_get_resv_regions,
> +	.owner			  =3D THIS_MODULE,
> +	.identity_domain	  =3D &hv_identity_domain.domain,
> +	.blocked_domain		  =3D &hv_blocking_domain.domain,
> +	.release_domain		  =3D &hv_blocking_domain.domain,
> +};
> +
> +static void hv_iommu_shutdown(void)
> +{
> +	iommu_device_sysfs_remove(&hv_iommu_device->iommu);
> +
> +	kfree(hv_iommu_device);
> +}
> +
> +static struct syscore_ops hv_iommu_syscore_ops =3D {
> +	.shutdown =3D hv_iommu_shutdown,
> +};

Why is a shutdown needed at all?  hv_iommu_shutdown() doesn't do anything
that really needed, since sysfs entries are transient, and freeing memory i=
sn't
relevant for a shutdown.

> +
> +static int hv_iommu_detect(struct hv_output_get_iommu_capabilities *hv_i=
ommu_cap)
> +{
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_get_iommu_capabilities *input;
> +	struct hv_output_get_iommu_capabilities *output;
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> +	memset(input, 0, sizeof(*input));
> +	memset(output, 0, sizeof(*output));
> +	input->partition_id =3D HV_PARTITION_ID_SELF;
> +	status =3D hv_do_hypercall(HVCALL_GET_IOMMU_CAPABILITIES, input, output=
);
> +	*hv_iommu_cap =3D *output;
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +static void __init hv_init_iommu_device(struct hv_iommu_dev *hv_iommu,
> +			struct hv_output_get_iommu_capabilities *hv_iommu_cap)
> +{
> +	ida_init(&hv_iommu->domain_ids);
> +
> +	hv_iommu->cap =3D hv_iommu_cap->iommu_cap;
> +	hv_iommu->max_iova_width =3D hv_iommu_cap->max_iova_width;
> +	if (!hv_iommu_5lvl_supported(hv_iommu->cap) &&
> +	    hv_iommu->max_iova_width > 48) {
> +		pr_err("5-level paging not supported, limiting iova width to 48.\n");
> +		hv_iommu->max_iova_width =3D 48;
> +	}
> +
> +	hv_iommu->geometry =3D (struct iommu_domain_geometry) {
> +		.aperture_start =3D 0,
> +		.aperture_end =3D (((u64)1) << hv_iommu_cap->max_iova_width) - 1,
> +		.force_aperture =3D true,
> +	};
> +
> +	hv_iommu->first_domain =3D HV_DEVICE_DOMAIN_ID_DEFAULT + 1;
> +	hv_iommu->last_domain =3D HV_DEVICE_DOMAIN_ID_NULL - 1;
> +	hv_iommu->pgsize_bitmap =3D hv_iommu_cap->pgsize_bitmap;
> +	hv_iommu_device =3D hv_iommu;
> +}
> +
> +static int __init hv_iommu_init(void)
> +{
> +	int ret =3D 0;
> +	struct hv_iommu_dev *hv_iommu =3D NULL;
> +	struct hv_output_get_iommu_capabilities hv_iommu_cap =3D {0};
> +
> +	if (no_iommu || iommu_detected)
> +		return -ENODEV;
> +
> +	if (!hv_is_hyperv_initialized())
> +		return -ENODEV;
> +
> +	if (hv_iommu_detect(&hv_iommu_cap) ||
> +	    !hv_iommu_present(hv_iommu_cap.iommu_cap) ||
> +	    !hv_iommu_s1_domain_supported(hv_iommu_cap.iommu_cap))
> +		return -ENODEV;
> +
> +	iommu_detected =3D 1;
> +	pci_request_acs();
> +
> +	hv_iommu =3D kzalloc(sizeof(*hv_iommu), GFP_KERNEL);
> +	if (!hv_iommu)
> +		return -ENOMEM;
> +
> +	hv_init_iommu_device(hv_iommu, &hv_iommu_cap);
> +
> +	ret =3D hv_initialize_static_domains();
> +	if (ret) {
> +		pr_err("hv_initialize_static_domains failed: %d\n", ret);
> +		goto err_sysfs_remove;
> +	}
> +
> +	ret =3D iommu_device_sysfs_add(&hv_iommu->iommu, NULL, NULL, "%s", "hv-=
iommu");
> +	if (ret) {
> +		pr_err("iommu_device_sysfs_add failed: %d\n", ret);
> +		goto err_free;
> +	}
> +

Extra blank line.

> +
> +	ret =3D iommu_device_register(&hv_iommu->iommu, &hv_iommu_ops, NULL);
> +	if (ret) {
> +		pr_err("iommu_device_register failed: %d\n", ret);
> +		goto err_sysfs_remove;
> +	}
> +
> +	register_syscore_ops(&hv_iommu_syscore_ops);

Per above, not sure why this is needed.

> +
> +	pr_info("Microsoft Hypervisor IOMMU initialized\n");

Could this be changed to fit the "standardized" messages that are output
about Hyper-V specific code? They all start with "Hyper-V: ", such as these=
:

[    0.000000] Hyper-V: privilege flags low 0xae7f, high 0x3b8030, ext 0x62=
, hints 0xa0e24, misc 0xe0bed7b2
[    0.000000] Hyper-V: Nested features: 0x0
[    0.000000] Hyper-V: LAPIC Timer Frequency: 0xc3500
[    0.000000] Hyper-V: Using hypercall for remote TLB flush
[    0.019223] Hyper-V: PV spinlocks enabled
[    0.052575] Hyper-V: Hypervisor Build 10.0.26100.7462-7-0
[    0.052577] Hyper-V: enabling crash_kexec_post_notifiers
[    0.052633] Hyper-V: Using IPI hypercalls

Maybe "Hyper-V: PV IOMMU initialized"?

> +	return 0;
> +
> +err_sysfs_remove:
> +	iommu_device_sysfs_remove(&hv_iommu->iommu);
> +err_free:
> +	kfree(hv_iommu);
> +	return ret;
> +}
> +
> +device_initcall(hv_iommu_init);

I'm concerned about the timing of this initialization. VMBus is initialized=
 with
subsys_initcall(), which is initcall level 4 while device_initcall() is ini=
tcall level 6.
So VMBus initialization happens quite a bit earlier, and the hypervisor sta=
rts
offering devices to the guest, including PCI pass-thru devices, before the
IOMMU initialization starts. I cobbled together a way to make this IOMMU co=
de
run in an Azure VM using the identity domain. The VM has an NVMe OS disk,
two NVMe data disks, and a MANA NIC. The NVMe devices were offered, and
completed hv_pci_probe() before this IOMMU initialization was started. When
IOMMU initialization did run, it went back and found the NVMe devices. But
I'm unsure if that's OK because my hacked together environment obviously
couldn't do real IOMMU mapping. It appears that the NVMe device driver
didn't start its initialization until after the IOMMU driver was setup, whi=
ch
would probably make everything OK. But that might be just timing luck, or
maybe there's something that affirmatively prevents the native PCI driver
(like NVMe) from getting started until after all the initcalls have finishe=
d.

I'm planning to look at this further to see if there's a way for a PCI driv=
er
to try initializing a pass-thru device *before* this IOMMU driver has initi=
alized.
If so, a different way to do the IOMMU initialization will be needed that i=
s
linked to VMBus initialization so things can't happen out-of-order. Establi=
shing
such a linkage is probably a good idea regardless.

FWIW, the Azure VM with the 3 NVMe devices and MANA, and operating with
the identity IOMMU domain, all seemed to work fine! Got 4 IOMMU groups,
and devices coming and going dynamically all worked correctly. When a devic=
e
was removed, it was moved to the blocking domain, and then flushed before
being finally removed. All good! I wish I had a way to test with an IOMMU
paging domain that was doing real translation.

> diff --git a/drivers/iommu/hyperv/iommu.h b/drivers/iommu/hyperv/iommu.h
> new file mode 100644
> index 000000000000..c8657e791a6e
> --- /dev/null
> +++ b/drivers/iommu/hyperv/iommu.h
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Hyper-V IOMMU driver.
> + *
> + * Copyright (C) 2024-2025, Microsoft, Inc.
> + *
> + */
> +
> +#ifndef _HYPERV_IOMMU_H
> +#define _HYPERV_IOMMU_H
> +
> +struct hv_iommu_dev {
> +	struct iommu_device iommu;
> +	struct ida domain_ids;
> +
> +	/* Device configuration */
> +	u8  max_iova_width;
> +	u8  max_pasid_width;
> +	u64 cap;
> +	u64 pgsize_bitmap;
> +
> +	struct iommu_domain_geometry geometry;
> +	u64 first_domain;
> +	u64 last_domain;
> +};
> +
> +struct hv_iommu_domain {
> +	union {
> +		struct iommu_domain    domain;
> +		struct pt_iommu        pt_iommu;
> +		struct pt_iommu_x86_64 pt_iommu_x86_64;
> +	};
> +	struct hv_iommu_dev *hv_iommu;
> +	struct hv_input_device_domain device_domain;
> +	u64		pgsize_bitmap;
> +
> +	spinlock_t lock; /* protects dev_list and TLB flushes */
> +	/* List of devices in this DMA domain */

It appears that this list is really a list of endpoints (i.e., struct
hv_iommu_endpoint), not devices (which I read to be struct
hv_iommu_dev).=20

But that said, what is the list used for?  I see code to add
endpoints to the list, and to remove then, but the list is never
walked by any code in this patch set. If there is an anticipated
future use, it would be better to add the list as part of the code
for that future use.

> +	struct list_head dev_list;
> +};
> +
> +struct hv_iommu_endpoint {
> +	struct device *dev;
> +	struct hv_iommu_dev *hv_iommu;
> +	struct hv_iommu_domain *hv_domain;
> +	struct list_head list; /* For domain->dev_list */
> +};
> +
> +#define to_hv_iommu_domain(d) \
> +	container_of(d, struct hv_iommu_domain, domain)
> +
> +#endif /* _HYPERV_IOMMU_H */
> --
> 2.49.0


