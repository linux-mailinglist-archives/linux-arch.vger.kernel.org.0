Return-Path: <linux-arch+bounces-10665-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1918A5AEA6
	for <lists+linux-arch@lfdr.de>; Tue, 11 Mar 2025 00:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342511892FA5
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 23:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38ED221F03;
	Mon, 10 Mar 2025 23:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZOh5hLIz"
X-Original-To: linux-arch@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012052.outbound.protection.outlook.com [52.103.2.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08921DE3D2;
	Mon, 10 Mar 2025 23:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741650127; cv=fail; b=iIC4sIbydIgn3rgSOEVGb2OHXAKcUg0I0YN6mKRyF5iZ+Wsx2YvLSfOjW4XQfvA9fFFUMYU5/X98uzDkqJAi6JiDIq0P5hZWlcgwgnWybv6y+72LmmQEK5x0fUSzdzIvVHnuJLMmDMchQN6Hj+af5ic4jQTNs1WBGPvFUn6gucQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741650127; c=relaxed/simple;
	bh=1fGTfAogzp5qeVqBpzVCoFrnxNxppYxD5aDsHsFp3eU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j14ZI6kRCGcmVoIC0O+ZF6p+KNORCdhaJ2nN3GN1rNpTTJP2YfBmyb7ndSiWpklLD7N+S9WEKqU6Fn8rMXKet2AA2Bysjc3etoD+Mh4YF19fwvfaxEcCv/uhImOo3sHqHbPNAzfG20Br6eKtEFIX0DACqC2o/aU3OX+CqMbR6Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZOh5hLIz; arc=fail smtp.client-ip=52.103.2.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NAi5ILOiBrXogn1VbGqh7XZylrLXTSTSTmXYuEnrZ//BwJpk5IlbMplTDEPztu4V/p120ydAkcUyisY1u+5HTRAFlduK/cIseyLG14beFbwiO6+hj9IuGA6O33rhH2s0qtnzATFM5fIjWfj3iEY8HKr2lAoZlcxJ6z4XQwOGqStnLSqrgSlsAiqb5+uwBefpkIupzpFn+GVup2R5PoednVVkoOYVRYjYDiEGi7/Iso4iQ6z1JuHHVO96IxKl80K0uZImjHrzu7lwci9IziKibV8HYzC0nz+tZLiNsV/+5Y5F9+m7WOzbFQwKq+OcxMb12CgVkFcQtXOKaeU74ORfRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xi6BMJ2S1d8wCSOgoXMUuMKz9nEwODTNYCL65GwQ8Lw=;
 b=seo4QtWAQeelPKHAm1K98IS4ftHRqvI2paI668bpXpassa0NGN2pdsfM835v8thAIUhX4aVBT3D1Gxm5fmuHfftfXB/f1W9q0SLo2LSAsSffGrE40kz/LZk91qjLj6enuBAF/jVZbbGSy6sg09JIzMbnYwXe9p2QBIDg0zLCImsbdDVGZSas4ZqIsdy4zIMQ30ohp5dKLRL14F5AKJgFcFHLDDVfvZ6NGNZHxp9jIK0szw3N4K+kITTsYjU8xzB5nvb2ZJI91o6NubYBcq74oatLA8tm01SIYg47SmdTbjd7wX9amv+UEiUj3qSqi22reuAftA9MV6jb3d1Avis5+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xi6BMJ2S1d8wCSOgoXMUuMKz9nEwODTNYCL65GwQ8Lw=;
 b=ZOh5hLIz5oB4NDdA06QsF3wCG5xRDrkeszXd0OruW55jr+tdo31AkGY/InIRZIKBvfRFBPAr+9ZE+yBpXJ/VRSlRYVyCAhZ0Ak5d4mDlyg4r8DMTUJ5RInhel6nyerxhHyxI65U0EhIyhUEl1rdVHfb/lO/OalbDK8j0cFS3aADB1UqC4xfpeFlTgegtklJuLgKp9dV+Gi5bK7Qt7qlxLiOiCj+ChpTVICqA3hd3oQA46V+vsgzLHTnBzQLLVeaLqPGxPcW/6KbxLqxmvle9p4DDRPkJpzWos+48BtYY3Vv2mHoCYgZZH/R300YnzGnPjO/GzP6LmksiUi5ZpYzOag==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB7439.namprd02.prod.outlook.com (2603:10b6:a03:295::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Mon, 10 Mar
 2025 23:42:02 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 23:42:02 +0000
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
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v5 11/11] PCI: hv: Get vPCI MSI IRQ domain
 from DeviceTree
Thread-Topic: [PATCH hyperv-next v5 11/11] PCI: hv: Get vPCI MSI IRQ domain
 from DeviceTree
Thread-Index: AQHbj60+s6/ZI2Ez5UqL6yl7lUAhFrNtCWbw
Date: Mon, 10 Mar 2025 23:42:02 +0000
Message-ID:
 <SN6PR02MB4157FB49E2120B206294D439D4D62@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250307220304.247725-1-romank@linux.microsoft.com>
 <20250307220304.247725-12-romank@linux.microsoft.com>
In-Reply-To: <20250307220304.247725-12-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB7439:EE_
x-ms-office365-filtering-correlation-id: c2f3ac24-f2a7-4cd2-68be-08dd602d286e
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|15080799006|461199028|8062599003|8060799006|12091999003|41001999003|440099028|102099032|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?wVG905riZSPBtfocoeP3UGgYLzt51VgD1ZUneetgWC5vh9rYVOImrUO1UJIH?=
 =?us-ascii?Q?hOYqc//BT5GJaN5+/z/Tsz4PIpYfDHdwfst/iMHmp8PCUEwQla91UMPHBY5x?=
 =?us-ascii?Q?djNzNPVTyzbjn4arxniDbuk/31yFzQ5zHKJYP7+dAnaH38DQ8jHjHO3RrL1z?=
 =?us-ascii?Q?d3pBoCRu1ETAMK9VLv5//dqTxyZR0ZdvKyA5cBm9NynM3h9fmdbqBKKw2DYt?=
 =?us-ascii?Q?gIFP3lbBWf8Z2rPHg2hH8IV15QrejIYaAWPhQMMvMwi5iAKiJCtgAXPWQ47g?=
 =?us-ascii?Q?Wt946Hh6jXwO9OTDGk4Pg5HELgDb53IVGQGc/cEfHUUxaEGJiI9QTBzYCUfd?=
 =?us-ascii?Q?2B+eQG5OTIx1iLmFqAeQ4xRWYYCfjErhk5NQBe7mi5tP6jkL+Q//MLaRQnes?=
 =?us-ascii?Q?EunQCv95CAWW+YRh77CGnraB98529LxSq52F4rLyaqXgyDt324fwFEziRd9V?=
 =?us-ascii?Q?EhokZv2oMJS+UwTF/WTJZQ6ZTg6A0vHnaL5YHqXZc0aNw75sabe5osQ/GEjx?=
 =?us-ascii?Q?URK7Ps9/taWiQ5HA3Y7UkWOS05pS3hJR5DjGQs1Ny4clpEGPdBNVHTRkFOro?=
 =?us-ascii?Q?qdfuxft3EuGsC62/I1/uORmrxZQjcyA7JZNM+x1qaIJ0lRVs/XhrakW3ZV5Y?=
 =?us-ascii?Q?OR6bBp8th80ii8MwlZukImCw858wNVJkLAOs7xeTCzT1TVPWnYnQ4911dqeJ?=
 =?us-ascii?Q?uzmgqy0NOBu2nIdMmM7QVYWIIrDQrO+0QmB35WQBPu/+hzWJ9xEYF5a7uq4J?=
 =?us-ascii?Q?5dT0DlRT/Gsd85v/GhAu1IAM7jap0wWfONE6tUlHxAwo2JLNERYx8kj+kl0B?=
 =?us-ascii?Q?VE9vDKi2pL0frmvCQH1qph7Dwladz2P/uRJvOEVPMCD5m5VCFA3A3LJm85D3?=
 =?us-ascii?Q?3Avx76zhwPbKPoQfPJmptkC2ISJ/X2k9kB8yh7FMi7fwDYcq7MUBcUz/Yh9c?=
 =?us-ascii?Q?fV4IkMiBn5amLZElvrRH9MCdusqvrV1mjXyJO87L+aSjppmUErJdUSfMsm9l?=
 =?us-ascii?Q?Odqq6xd0ut9Wa9RcMq4Gx5gb1CLJ5ECkRfuqId/x9Sc8uA5EIpsK+BpkgVc6?=
 =?us-ascii?Q?FjAtA6nq3OGVG3XF83kp50LxxmCFk/3mXJfs8UH9IzLx4sIuwtk=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?p+c7bCf0nHYQYSokrhIkt2vaeMuvHc6BbYv0pR+RbOqChvYgBZcDhIseGAux?=
 =?us-ascii?Q?/FqW5T46I5K9CX5gnNIghik4b/XfQzpi8BLetCnIAXoodHl8iBaeB2akRjp8?=
 =?us-ascii?Q?zZuxvIyZFazMP7YCneFDAueKYkEQBAfbIemcfkuLjEHNCEilRB6F5JOu/gkE?=
 =?us-ascii?Q?Z4o25jiMl3ptkzcJQVxEFVTiC5kjgfPzozuMZLeWK9oA+sSL1CVc7KyeI6ht?=
 =?us-ascii?Q?5A/C+8QICoBaERy5LPpNRmXvMcYiRPB2sqv5VtUyzKb7CIDWLhlXZT/ib4Yn?=
 =?us-ascii?Q?pyb0Pdc478ZMlDhJNDkF9nNRUuXp6619eu+v049oKVrFTTShFedBLo24UsfY?=
 =?us-ascii?Q?Gf4/UBEkBpgbjLoEj+O2E1LdS4nzKnw8TguFFOE1pCGqaxF8VZe3cvIbjcG3?=
 =?us-ascii?Q?4n1q27ITJg72qtgi6LdlkFbSaMSb9y7IaZVXJBd8NYEeXYzUjhJ7M5Wd4xmJ?=
 =?us-ascii?Q?+RmtoBGPSpWDS95FTFjtr0STOwofp9qcJh2j70PF5D9+lceVRhUYqAAeXdlW?=
 =?us-ascii?Q?3R7HXijJqFQBuP2CMPXDWLzG4dtpDB7n8wVY8V96dEoL1mSvOkWVUQP7RA5/?=
 =?us-ascii?Q?6J2sDKT65fl28mAd/DUxi74LyTFWKxqCClRCa1GTH2IQ4qzCtX9KYKS0I51z?=
 =?us-ascii?Q?MPR1Z90B1sF+uXAA8pGM2vicrRwk6TxlWqKLN6zdfI3gHruf2Z8CNWIO97wy?=
 =?us-ascii?Q?Q3lQH3TGP7mmUf9j9IDNSA6dwDKvH/uLOqjWjFYj6DI+5xpawtH+HifDPZox?=
 =?us-ascii?Q?s+uli79yTUWf6/EwRIUWl1vdZBI0m0cIii7ORQlKgN6wgWJ8rl2Nmx06Jz4J?=
 =?us-ascii?Q?s9bY1/hIyP2/EYdtqRdbKMxqXI3TF1CP/1ey9r9Zxz9UqTSA1asMgTnIHBOE?=
 =?us-ascii?Q?zBmyvmsQ7zbFvyBSYrOWILc/XlCcsmlMTUbXLLdoHwbAxl4H4shEf03DVLCW?=
 =?us-ascii?Q?x2+akkENcU3edmAQKZBvfIW2REj+bGxXVQpmxQ4ugbsBtpnAxlaLqwACGIsH?=
 =?us-ascii?Q?PGvbPycIahb7zY6oJUdW3RREGFUV06aIcCVbUkjEkUWDT0F78HMUCI/EHFQh?=
 =?us-ascii?Q?5ZBe/yRrbg4eAB97L52oRhCpnVMUazdX/wAAh09hQq8v3gDf0vtMNE8F95O0?=
 =?us-ascii?Q?qlsYhsU1G3GXBC/a2hyT4npFzbVPPnOAP3gSjtxsD2dLzFjPTwHsmCYsB+kW?=
 =?us-ascii?Q?IFeQ4XAU/Vp91FgnEMw1c6ECO7o8Mv2iApZM8hElHroOFzXZ7+VbEbDZyvQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f3ac24-f2a7-4cd2-68be-08dd602d286e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 23:42:02.4498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7439

From: Roman Kisel <romank@linux.microsoft.com> Sent: Friday, March 7, 2025 =
2:03 PM
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
>  drivers/pci/controller/pci-hyperv.c | 79 ++++++++++++++++++++++++++---
>  1 file changed, 73 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 6084b38bdda1..9740006a8c73 100644
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
> @@ -887,10 +896,53 @@ static const struct irq_domain_ops hv_pci_domain_op=
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
> +	domain =3D NULL;
> +	if (parent) {
> +		domain =3D irq_find_host(parent);
> +		of_node_put(parent);
> +	}
> +
> +	return domain;
> +}

You could insert the following and avoid the #ifdef's in hv_pci_irqchip_ini=
t():

#else
static struct irq_domain *hv_pci_of_irq_domain_parent(void) {return NULL;}

> +
> +#endif
> +
> +#ifdef CONFIG_ACPI
> +
> +static struct irq_domain *hv_pci_acpi_irq_domain_parent(void)
> +{
> +	struct irq_domain *domain;
> +	acpi_gsi_domain_disp_fn gsi_domain_disp_fn;
> +
> +	if (acpi_irq_model !=3D ACPI_IRQ_MODEL_GIC)
> +		return NULL;
> +	gsi_domain_disp_fn =3D acpi_get_gsi_dispatcher();
> +	if (!gsi_domain_disp_fn)
> +		return NULL;
> +	domain =3D irq_find_matching_fwnode(gsi_domain_disp_fn(0),
> +				     DOMAIN_BUS_ANY);
> +
> +	if (!domain)
> +		return NULL;
> +
> +	return domain;
> +}

Same here:

#else
static struct irq_domain *hv_pci_acpi_irq_domain_parent(void) {return NULL;=
}

I don't know if it's better or not. Just a suggestion -- keep what you have=
 if
you prefer.

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
> @@ -907,9 +959,24 @@ static int hv_pci_irqchip_init(void)
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
> +#if defined(CONFIG_OF)
> +	if (!irq_domain_parent)
> +		irq_domain_parent =3D hv_pci_of_irq_domain_parent();
> +#endif
> +	if (!irq_domain_parent) {
> +		WARN_ONCE(1, "Invalid firmware configuration for VMBus interrupts\n");
> +		ret =3D -EINVAL;
> +		goto free_chip;
> +	}
> +
> +	hv_msi_gic_irq_domain =3D irq_domain_create_hierarchy(
> +		irq_domain_parent, 0, HV_PCI_MSI_SPI_NR,
> +		fn, &hv_pci_domain_ops,
> +		chip_data);
>=20
>  	if (!hv_msi_gic_irq_domain) {
>  		pr_err("Failed to create Hyper-V arm64 vPCI MSI IRQ domain\n");
> --
> 2.43.0
>=20

Overall, I think the code looks right, though I'm not an expert in this are=
a. I'll
give my Reviewed-by: once Bjorn's coding suggestions are incorporated.

Michael

