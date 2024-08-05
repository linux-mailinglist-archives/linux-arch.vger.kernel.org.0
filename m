Return-Path: <linux-arch+bounces-5959-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FE4947395
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 05:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAF401F2150F
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 03:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5279A13CFA1;
	Mon,  5 Aug 2024 03:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fVcS/XV+"
X-Original-To: linux-arch@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010003.outbound.protection.outlook.com [52.103.13.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE865FEE4;
	Mon,  5 Aug 2024 03:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722826970; cv=fail; b=Ktxh8gGr35mu5d3L5NU0UzAaCgmWxCQV5bRJFpjoTk3LG6lNnf/+bsV3+DEj5080It8pBxr+osyMf77PbrSCd/F3GkrX3O6rQkbt3Zpx8vvF9/W+IMS0M0fT/xxrfT9mrb1Qbx9mrO7MLmUO56DdtCrRFivVKwpiv4MdEUiIDaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722826970; c=relaxed/simple;
	bh=HgSyqOYXSEGrq3SNCUN7N4R5lrYzG1TgCKn6/5vJroM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FTNX8z36AYk3VSbrlVehSQLtGQaivrfOQB8zSl2P1fQ+eEZvT+IlyI7DuKFAz1toT2xTECkE/T/kM5/WBNKJlK4xb1QQra287wznQGnnAK2hL+GIOOikZvvq6Uht38xdde/nztW2ChECbOvUNuyeywxFND75wnrgP7iMASXPlFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fVcS/XV+; arc=fail smtp.client-ip=52.103.13.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FKR00z2sQOwGy8TDLK7HS+oxImIvYZzA7QtbqxEEkbPh9kua/bpXUVUYL3IlYettvmHt7owCvG4h4qtztnadv0Cm+/FWSW2/nS8du2ZlXsLcNp+WmKPj+GW3PkLMyyyr/Blcz7rTZFdPOSC3WRWNSdDF+Jfc9ngW0wI7iynvvHcJex8KiKe+aPlncm9xNgrvJNNNJZxWEEffBTdygiD7GZ9hZ9mwvbzz3XKbs6Kadcn8uLiH/I28UygptiofM6iMKOUT3kN3hHjdzrSGy/dPI4i6CKqywDt2KRZbsydJzUK19AHA7FC5qsTHBk1A4J7u7jh0ZddY//aSpEzXB6JqBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+wLRi8ZnFJfZhjT2dCYJE5mWnLtPDjYxe3eJ6mKNrg=;
 b=s4To0Vc/mnBOGaAyyMNKyQ/sB6x5P7dRivoCUUB47YbuGuG/VHs3ifGRmUrraA/CLjHM0zQgwOLuj4figQtU8fJBHPlbOIMbPu9lilvW8Io7ytLTFXltNgZuvWK+gqL4t1OFLbXHHxaLx2PorNwbzmFCnP2GxFBrzSh7tXP9qGmpxccpG7pl/Vk3IU0Jj9UYX618ljfbj9UMOOPAehBEyuKo2R5Mh4ZaTz2SdUYuTNT8v1jblC1YiGeYEaqqs9cGPSzc3sFZ/0SzXTkerTiyfSSuujEzJw4tYiwK4XaDC+0IQm9Ky32T3/YOtJzXARBTVSkNd6ptV2kKp76xQHnNzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+wLRi8ZnFJfZhjT2dCYJE5mWnLtPDjYxe3eJ6mKNrg=;
 b=fVcS/XV+d9h3hoWrJSkZlhJdHjSf9jEQEL1gAqa2KejGqQlQ7iYUJkFvKHX4Zrs9YVJ5rfdYEHr5xOonm7eR2vptbL+jjPlRmN+bdgYrfjWUtaq6QdY3eEz2CjOPBCsn31ohqU6HcHo3Zudd2lsK30NRs+7nQMPNUcylwBdZwrLwbcNLYKAEw8e4M6ExOo7JJyXJkPdwwXeHHhENFLqFXRleWyJK0C0ds85z15I65aWNwLdxYxz/ppH4zQiA0QkWRqI7GcKqIqlO6z9lg85wQLDM9U7450fgVSj0+BKwsI4kWQYxb00SlzczuGC39NeEKPh4JmcVUj3K90djzjU6+w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV3PR02MB10738.namprd02.prod.outlook.com (2603:10b6:408:28b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Mon, 5 Aug
 2024 03:02:44 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.7807.026; Mon, 5 Aug 2024
 03:02:44 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>, "kw@linux.com"
	<kw@linux.com>, "kys@microsoft.com" <kys@microsoft.com>, "lenb@kernel.org"
	<lenb@kernel.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "will@kernel.org" <will@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "ssengar@microsoft.com" <ssengar@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>, "vdso@hexbites.dev"
	<vdso@hexbites.dev>
Subject: RE: [PATCH v3 4/7] arm64: hyperv: Boot in a Virtual Trust Level
Thread-Topic: [PATCH v3 4/7] arm64: hyperv: Boot in a Virtual Trust Level
Thread-Index: AQHa36+nznmt0HyBTkiU+27mz+o6srIXU6GQ
Date: Mon, 5 Aug 2024 03:02:43 +0000
Message-ID:
 <SN6PR02MB41575867724F85CB7A1551E6D4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240726225910.1912537-1-romank@linux.microsoft.com>
 <20240726225910.1912537-5-romank@linux.microsoft.com>
In-Reply-To: <20240726225910.1912537-5-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [ZotqbaooZkRSVly2xofnbCIovLlhhZvd]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV3PR02MB10738:EE_
x-ms-office365-filtering-correlation-id: 33a33826-e071-4381-7006-08dcb4fb13c2
x-ms-exchange-slblob-mailprops:
 EgT5Wr3QDKySeO45n6y2Duvfl28/PrK72DJaZbh73zWFEuZOnzQhdp26JTjUiANpCqN0VuutU4E04kGkwwCum/AJDLTN8oJG3iRMA7n/8MuanOEglaP9kDxn6sTKjI6PbnGBCqOaQ1TEsjah2yNmvJYGbG/lDEkbq68rPtW2XGX8BsBxkOaFs5nrB82yrhpnIRsAu/ZjKLnP57vcvnK/z08Y8DHOeO1Q1URKofiYQs4ItCdG9+sdnEfmH4mcpruAJPm278tf6XGJ8Sc/E70qDsdCfWuTzheVd33tjfudDfuBmmFBnDA6HCGFWYZioB6OxgsVPLDxLphz+ZpuRkVxga6g6ue6lawMM8Yp4by8Cyq4lii/rWp/KpijswAFxzZN7TBPxhZBz6sDDZf0GFrPz9LJU3SkcY/NkAejSYkx1pJQScomurLeYFBfDY+GvnF+pcLxLp1X+XAJL7t9dCFRiwChChb5VqreZR/Paz/oD3z9kR34r1oHq/7krNB5gthJvYTKqKpp2cWNWxeo/FZGiGilkFqnVMhk39xX0fSban5m1FAIJmrycB1WEUqlVVEXsnUgLNlKWTcilBX0Vb0qdPkcd4AYaywH8VpBT4FDHafLE88TD+dIsUfdXGpOQQwEcGq1VzhZrd2mmRxBP+sKtCC0sAfPG4PneYw1pWfmwduE9xC8f/kAFxDwtLTJnEo/TfWQjZnq2vQI8ChUg1Gn0bjkJ0AUjlWGZoWsZBo1cg4=
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|8060799006|461199028|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 Wfs8i5xoVwPvzBqKJzx1sabMbDEfso4NCALWB+FvpSk85PCvXY4QWZ3Tv4AKQPQjPEe9rV/4DeSkkLfl9zgr6YPFginsF5B+qSzhXzuNAr93qPL8SveujOugPCQzLA/4wsBoW7DVgKIm1jIapKnIhTzfBZlROfBSCCszbIYXlHYgynEEJQ2ncETCKPK07FTkeGsAJiVo97i075aOcKYUpgSSkWzoU7iXDJc/6YdSC8eoCAzPaGVxrXiDlfSkdwWoaBpin+KuRePx0yKFx3x7Nup9BJ1fsLrJ+IN2nGct1UIHGWWkufB9SNPvJ8udW6Qsc48vWiaHUa1xK9OscPEBY1aVc6pkx2JzEoivkRDAijwyO2Vv3RpDiFK+NBxH5aUkFCLd6xJcq9UUmAFCVlw/kFZFljhAvrLQfljOyus/U5Ovn76skmo40LyrbASZkwZY/MiOb0S8VaUjg4uqkMBn836qdKuqXYGZv3CZo1W9Y0BN/TRb0o+VohIkHDva/WOw9+f9SuYTbpdckFttsLjT7P5OUAE+8dggGyX4preaDN7dubr54sU2RvdI2r7LN6GeZCaTBDWvmVN0qkv1DsBYXNk6Brk6rOqm9bGwspIvIlAYvDS11PvbLQc9+oNxZI0RkOw2c1H7PsISIJBZf0Gh2Q==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BMQeN3wnucTciacp/VzVTYK3VqjamcTjTH/V+UrcUvV7joQ5rTtFpsrGdFBg?=
 =?us-ascii?Q?b0T6yhmboyjLN2LgUFU06DOLWaZmvfIW4LRd3w85I5KyvhmSd2FXB4XxycOM?=
 =?us-ascii?Q?CcxtiaPnF+95Op9BDSpl+80BgYgi0kn4gMFw3/hyV1lvU9MdUiJCvG294Qs2?=
 =?us-ascii?Q?FjdKSOPBjM6y63BpICoPrEFjj3sU8e9HdKdgwrfBuQqK1LL5y0AQWZF4Ckw/?=
 =?us-ascii?Q?qcTriMa7jVz2Adksu3gnPPrZNGnhUhGElptdapKdIo9eHC7z/Rmzf9Bj7sNz?=
 =?us-ascii?Q?+5LrmrJ+aJDjGlX4/oxXpGxPc/DwIIVtRWDcB0ZSbpVR3zVARnkfOJoc1U6h?=
 =?us-ascii?Q?50hXzKGOHt+emFqh8Qay9pW39BsLB4O8alcLFNwJl30YwqKnsimWZ0W+fHte?=
 =?us-ascii?Q?udTYpxuGcsprTRDGV/HRQp0J+HlMTn/tsrdoCn2JavHgipUoAKnvfZ/zjyoQ?=
 =?us-ascii?Q?+TyHsu2NK83Wegzcp6ajLh8Hl9x5O+N0i1Xu2iAxEcgD7YkCssG9g12MgTAQ?=
 =?us-ascii?Q?jm0eA3Ccfw7YdbNEss2a1YsqBKaffeVgQpdddPR0rWLLQkzbhhJDJI20yREh?=
 =?us-ascii?Q?p5R2GmPumWX62EM/ZdPFEkNsGQP6FnT6rvcu/1Us5GCRcl3oF/Pr8ypngAX4?=
 =?us-ascii?Q?Iqd052ogFBjm31bPwCiFyFNQXDpwUOc2/unU5NQIavXlS5gSUDIdYYFW9hdI?=
 =?us-ascii?Q?K0k6ui5zMbRZifXInHz9bLfkeFJJV/cKDJ8hqSPH89xNY7iluIlc04CX1eQA?=
 =?us-ascii?Q?vQU8+5OJrZ70s3OimlLxE9jigWf44Rg4/h/n3rRh7xvwfOd/yFZOO9yNmytC?=
 =?us-ascii?Q?D2Fl/IBfjop8gY8cf+TC2CJgy8uSYPwyeISdADb3KlMlNMuMR7FVvMcfAv9C?=
 =?us-ascii?Q?UHwklSLG00hWVt8LWR+9Fc0gRUHOUG20igei7AKJc1nvb7X4MAs94dGBe0XO?=
 =?us-ascii?Q?YdEwkc2nHcXZ4vzsLz1sLNLweDfgpdfHsP/Z7dGoXzeyWhlnv4l2kydfjNP6?=
 =?us-ascii?Q?4MWNlenNKxbzKNegZbWfGVLwmRFG4e1suqqIXJIx0xfYdEtPnM27QJbnKaXV?=
 =?us-ascii?Q?tFZmso9h+KOfmEDSPaq9tAKdlwRfc/yw/hXIdIyPNJJFju/R0Xbc1YJGifDU?=
 =?us-ascii?Q?BVdorraEHDup0ytE5qoTLDq23qytPKXGEWHF9SKRCS9TM+lPe6nRoUno9IQg?=
 =?us-ascii?Q?RKlv+FVRsO8UFJyJFkxZlTP3ffe6STnm1ODk1yDq/3wC0ktyurVSI6WIhLA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a33826-e071-4381-7006-08dcb4fb13c2
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 03:02:44.0516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10738

From: Roman Kisel <romank@linux.microsoft.com> Sent: Friday, July 26, 2024 =
3:59 PM
>=20
> To run in the VTL mode, Hyper-V drivers have to know what
> VTL the system boots in, and the arm64/hyperv code does not
> update the variable that stores the value.
>=20
> Update the variable to enable the Hyper-V drivers to boot
> in the VTL mode and print the VTL the code runs in.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  arch/arm64/hyperv/Makefile        |  1 +
>  arch/arm64/hyperv/hv_vtl.c        | 13 +++++++++++++
>  arch/arm64/hyperv/mshyperv.c      |  4 ++++
>  arch/arm64/include/asm/mshyperv.h |  7 +++++++
>  4 files changed, 25 insertions(+)
>  create mode 100644 arch/arm64/hyperv/hv_vtl.c
>=20
> diff --git a/arch/arm64/hyperv/Makefile b/arch/arm64/hyperv/Makefile
> index 87c31c001da9..9701a837a6e1 100644
> --- a/arch/arm64/hyperv/Makefile
> +++ b/arch/arm64/hyperv/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-y		:=3D hv_core.o mshyperv.o
> +obj-$(CONFIG_HYPERV_VTL_MODE)	+=3D hv_vtl.o
> diff --git a/arch/arm64/hyperv/hv_vtl.c b/arch/arm64/hyperv/hv_vtl.c
> new file mode 100644
> index 000000000000..38642b7b6be0
> --- /dev/null
> +++ b/arch/arm64/hyperv/hv_vtl.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024, Microsoft, Inc.
> + *
> + * Author : Roman Kisel <romank@linux.microsoft.com>
> + */
> +
> +#include <asm/mshyperv.h>
> +
> +void __init hv_vtl_init_platform(void)
> +{
> +	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
> +}
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index 341f98312667..8fd04d6e4800 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -98,6 +98,10 @@ static int __init hyperv_init(void)
>  		return ret;
>  	}
>=20
> +	/* Find the VTL */
> +	ms_hyperv.vtl =3D get_vtl();
> +	hv_vtl_init_platform();
> +
>  	ms_hyperv_late_init();
>=20
>  	hyperv_initialized =3D true;
> diff --git a/arch/arm64/include/asm/mshyperv.h
> b/arch/arm64/include/asm/mshyperv.h
> index a7a3586f7cb1..63d6bb6998fc 100644
> --- a/arch/arm64/include/asm/mshyperv.h
> +++ b/arch/arm64/include/asm/mshyperv.h
> @@ -49,6 +49,13 @@ static inline u64 hv_get_msr(unsigned int reg)
>  				ARM_SMCCC_OWNER_VENDOR_HYP,	\
>  				HV_SMCCC_FUNC_NUMBER)
>=20
> +#ifdef CONFIG_HYPERV_VTL_MODE
> +void __init hv_vtl_init_platform(void);
> +int __init hv_vtl_early_init(void);

This declaration is spurious since you removed the function.

Michael

> +#else
> +static inline void __init hv_vtl_init_platform(void) {}
> +#endif
> +
>  #include <asm-generic/mshyperv.h>
>=20
>  #define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_0	0x7948734d
> --
> 2.34.1
>=20


