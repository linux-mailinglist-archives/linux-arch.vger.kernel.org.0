Return-Path: <linux-arch+bounces-10932-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58375A67D60
	for <lists+linux-arch@lfdr.de>; Tue, 18 Mar 2025 20:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86A2425768
	for <lists+linux-arch@lfdr.de>; Tue, 18 Mar 2025 19:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD4321149C;
	Tue, 18 Mar 2025 19:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ScpAvU4y"
X-Original-To: linux-arch@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19010013.outbound.protection.outlook.com [52.103.11.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0500C207A01;
	Tue, 18 Mar 2025 19:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742327696; cv=fail; b=B7enVyQ3NaIOgo6Y5ouoflczGhxFaAoHpr1xjuqAPBSLWUj6/w9m2s9rfgjq7v1xVJjx7I4ys+XoXENdOn57Inx+DbqzYSu24NZPfj4rX9tMFfZ9mLMwytFjwxGqJ6juvFOXxN/OEjyEigwIUIcwfVFznhddsh2rAaodF35rnm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742327696; c=relaxed/simple;
	bh=ipwH3HykQ1ee3mR9kj3HPdWXuX1AFcYu1D04lqv7Sco=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ANkDigL7QvQiwfCH58xViCLRx5X06zloHhn/WPI3rVD5V7Cqf2ljNYfOPTDbh1G/RYzgiKBGbXJj3ad2UnDCMSRZuvfGTr6PDSqNiJPYzL7iZB+iKp+W76klFmCfOz78x28bZCBOWfyT8tjXFL6x7HV9Spfmg5o9lLZmhfti/Dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ScpAvU4y; arc=fail smtp.client-ip=52.103.11.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kyMN+MGpw/dzI1d4Hdg1HtzU+TRmB0xw1nmmhoxgM746Oy8XV5X2vHTouVWifhSTCtQSDlMLsKJYI5qbrkQiE9j5wOi1polJenCcMFcCdBj3avIH8ZRVOG9TjZ9DbgBKk1dONbf13pBJOni9bMm+EbIRWEYjZZbkyxz2e4GBwE793QTYWP/0nxhxsHObfA37SMzGqrOWEP576Fg42Ydmr7r65tVVWGAxRkkQN5ScVJOlk33nJVnhOxQhZZYtdLSdktfgu+Loly83HC661rdhn/d+aUCHrFp2H9aIJUWq8Q4fxEP44QTTnWEHH9wP+F1YwBosDe1Suv+IAJBAN449Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Azz7whBTenxG92fkFLvM3E+yjOlKC75QID7t7cCW1c=;
 b=Hq0J/071Kczqit5R9E87Uno7kW0evAeVOkkJNoNVAjjJImtNQ1VgUg91G4NWQrPR8ewcz4Yda9WEaH9dtK9CNIUfWAvyzYJS4oFPL0Sxae25rxOESJgYKA4jOiNAzxjTJZjJOX+gdfoeWwifZRrA5IFktTi2tHoj0FkbZiCG+uKEhhVRV9q1w0Vsh9FNFKJiyCerAalCJgWlq/9mItuntAS/0EPjp4Z+1XZpJjO/ZfppoaLRWyr6WXQRimx16SD0mL3s5IkSWiSRNZ7eJgE8W6B1njd/aqMvzoz7LioAyEyiwly8jO2fUaHb7GKg2qJB5AhcsT3SMOL3HoCOhAG03A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Azz7whBTenxG92fkFLvM3E+yjOlKC75QID7t7cCW1c=;
 b=ScpAvU4ySkR0fT6tvI9diiFliaXUDluzHemSOWZHFV8ndKZpYGAbq+6gf85ySmVOf5dRn043IIoyR0AXHeET4LI09KN5vVdCylhV2fSidVYqKp3Dlhd/l9AlvgJyFjmRGzMSL1+xX2NoT2uM9bxxpSdipnqzD9/hwTVhw7u8AG/OlmpxJdHS2d3BOEm54vAK8npPS+mNzw5oiLFcswWmcsVmmU6HsYss2pP+YRPexN8fgp/uIQqwXJhRfCf45G3pGm3Pvyre5sFQiLb/wLJ5JdUQp4PJLafxOizLvDgQVJlL/SeIdJERTbubSVa/X5dysvtQeVtfP/VaR+caqDcFKA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA6PR02MB10479.namprd02.prod.outlook.com (2603:10b6:806:40a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 19:54:49 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 19:54:49 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "ltykernel@gmail.com" <ltykernel@gmail.com>,
	"stanislav.kinsburskiy@gmail.com" <stanislav.kinsburskiy@gmail.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"eahariha@linux.microsoft.com" <eahariha@linux.microsoft.com>,
	"jeff.johnson@oss.qualcomm.com" <jeff.johnson@oss.qualcomm.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
	"muminulrussell@gmail.com" <muminulrussell@gmail.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
	"mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"apais@linux.microsoft.com" <apais@linux.microsoft.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "prapal@linux.microsoft.com"
	<prapal@linux.microsoft.com>, "anrayabh@linux.microsoft.com"
	<anrayabh@linux.microsoft.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH v6 10/10] Drivers: hv: Introduce mshv_root module to
 expose /dev/mshv to VMMs
Thread-Topic: [PATCH v6 10/10] Drivers: hv: Introduce mshv_root module to
 expose /dev/mshv to VMMs
Thread-Index: AQHblRdnpUjohn3xT068AvEhHN692rN5UJDA
Date: Tue, 18 Mar 2025 19:54:49 +0000
Message-ID:
 <SN6PR02MB4157261B9C4AA8CF89A30317D4DE2@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1741980536-3865-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1741980536-3865-11-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1741980536-3865-11-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA6PR02MB10479:EE_
x-ms-office365-filtering-correlation-id: e3c641c2-6fb1-449e-8cd4-08dd6656bde9
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|461199028|8062599003|19110799003|8060799006|12121999004|102099032|3412199025|440099028|41001999003|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YrldPbDzPpYwGCsSnAS7yxEXueU9lT8Kr8EYhqz7L1QFaDQtArT6sLAwDDMh?=
 =?us-ascii?Q?Io4CovbCakQRX1Ub8hORvnhvznAIzpxCPlQZy5t3afVWZdf+Ncs8DK/nIdee?=
 =?us-ascii?Q?omGZDzq/ShEfHuC+px6tPrUNIRGmKKdgCbz9cB3phBioga1ZvRB2WE5/VeT8?=
 =?us-ascii?Q?/2nTxRJ0IHB33Ti9RbuBBf1vBZVCKA7bRFlr9JXEOlfUfgqS9jJNQhlcTp1N?=
 =?us-ascii?Q?TkV8hFMlDuBcuBuHH34aKGeOowhD3bpPax8VG7M1a+Yls53TcC1fEScItOQi?=
 =?us-ascii?Q?/Vm/GlSNT8QtU5QTgY71+lpDiWELubKaOigRU6XYnzPYiw2FX6UZ6VqfJ2v5?=
 =?us-ascii?Q?qrYnNsIkt1M+eSXr81IEvT2fuJidgQinyAUEewh63Qmh1WYut+R+rvl4Sz39?=
 =?us-ascii?Q?pgLuwsZCvodH2icsRiviUmVgS+PKqyuioUbAezJ+V0phXV1YhRLYSrphxC0e?=
 =?us-ascii?Q?jwiwZRMqngTXibP/3PgWTXUm+unWK3z76gJhTL3XaPlU4PlZXmtX4X7do3xZ?=
 =?us-ascii?Q?UPSKhUI3xkKqqxYwusoVcVGeoh3ToBilU6s+/orPFgDxukZ/erCOc6QfbyBm?=
 =?us-ascii?Q?OKyMvprE9T3DnTEAaBO/TEiDQHgDMdeiyDQRgqb0oZvYlaDKhu7YksxGUlRc?=
 =?us-ascii?Q?Zzbx02kxO+3ubgt98WQO6UrQOoNjR7aZaAyEwCTgrifm/RhS7gzhdzd2y2Wn?=
 =?us-ascii?Q?Zdqn7voFu9tvQBUkdyD45yXe8nUReN8jiube2pFLST+oYYmW7XX+KR7WVafv?=
 =?us-ascii?Q?RMxrU1gpv3Hp2w55IlMzIyY+EhH33nkqxGYY8UhdA0w/0kvUg+Sd+XpXSMC7?=
 =?us-ascii?Q?bwhuEuDAOjj3VBcN8OvfvPWB+pB+Kv2v9Uj/x4cKwr6tSl6lk8mcxAc7kTOz?=
 =?us-ascii?Q?+KIGh3+Qmc5ftFo3P6CqEYJNmRdQNdNiS9afnjMz4g84T4wr8B9xPL+IfUCq?=
 =?us-ascii?Q?J028JS20Y0qGyes+hZziCRxFgyW5gWTVOFTQ3feROjDwOrIgJFYYUKOGCbAb?=
 =?us-ascii?Q?Y9bkfRkDl2jgEq9YHb0CsXvI7pGCR1HBtjo88pS/Vh5kH4r8cbd3ZGVJwKw+?=
 =?us-ascii?Q?bq9H8IqNo/PgLlz1Ec3XwKpWnJ5+eAb7mE9QL2QtrrC98W74Ld+ZctgmOM1b?=
 =?us-ascii?Q?m2E7Q1Y+ClEKry54tRCnvXy8apvs8NdcttuFfU9BjK0WXOAd5yd8drObAuZZ?=
 =?us-ascii?Q?xTgHMlQjIJbeK6Az?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JrtVrplUvHztfOP81Hi6dCa3Lc88rqoNqBRj2pEvIXNHD+cTtrfBGl/80/FO?=
 =?us-ascii?Q?I7B9FsLIDefiXCfX7JYFYxHoLacKRbxTc/78dcv6hDiKKoKMPbl1c1L3VVJB?=
 =?us-ascii?Q?idV9YYPk1WNSb8PRhljzql6ZnyjMsa7MK8H4ffS/wbMQ/Ee6GEfZKUtHOjgu?=
 =?us-ascii?Q?fy97hi7KT8QjRzRjTRlbbJ+Gw76z+8zEWXOpkyWZ5sutEdsCLLTwMxUhoLbE?=
 =?us-ascii?Q?C85WRvfNNRYwUGUj4ozm9XETtXLZT2G6zQ3qlYhJ1aVgili3yB3Mzs177tQL?=
 =?us-ascii?Q?V5YHB85kldBrXg+/n1KOYvANvydGdGnrMDJAF0eXZizk/FweXFO79bM++b5l?=
 =?us-ascii?Q?W+1qsvdzopLYX2NSt1p2CaabF2YzeBJ7KYTQTk5s85Ai6g4r6RY00i+u1yH4?=
 =?us-ascii?Q?icrTXol+1h7rsxEiQz/zXZk7AL6noAraT8vWtHGT5O6LxLZqjdDen6mdc4qE?=
 =?us-ascii?Q?1KwY8uJJkaAmRM8K9N89ehD0o17nTItPpQTno0HHPrHXSMgdjPt2JkH17Fp7?=
 =?us-ascii?Q?MBqTvw8aI2gqBbAq5tXg7yIturLpLXsh015D1z9Bra4U0ecuW6zK0K3oYhMG?=
 =?us-ascii?Q?ToPwj7VmAgepIpcVb7pkJq1iG4CExf0bF9MzC5Cjl+PajSui2tJtN8wC0WAA?=
 =?us-ascii?Q?wAoJ+nckRKVOSSYisEw+9T0Ib5+aPDEPQe/z1UVfL13e/lYzvse5aAw6ELsJ?=
 =?us-ascii?Q?wHFlOEdE0c58Bqvo8MQ2IikG1DDiCeQTnJfQObz33bZpO7rcU9BHLR8mZJtO?=
 =?us-ascii?Q?SA+zhvT3TGPzUNwJpK7OHmzIYPLcIOdHuqY+m8Z7KBKz8SkXae58HH/txe7U?=
 =?us-ascii?Q?ybeMtT8twDHfQ1thWJ5tTiI0KLC2AJjOAtsE8OsknT2eO4O6YQkM6pDzXGth?=
 =?us-ascii?Q?MWGWfa0I0Jx6W0PFHyRxyV4rZm5KIohRdtG4ETs2kSuuSLPmOoWoRlEB6ZnG?=
 =?us-ascii?Q?1U40kIa/7JxO6TniG79Ec6XS0LRzvVPZa5sZVRcwz0V/rj/bUlIyqo/TrXlX?=
 =?us-ascii?Q?rhgYbaEsIdTbhex4buMwCl+TuAhAbEDumP4QIe/FN3I1UIGx9z20MV0PxgJ3?=
 =?us-ascii?Q?pg4NJkKoX2IRuy2dvjd17QJkvkYXCexaL5sIt4cmRsqnWSdHjqv5DY837ObK?=
 =?us-ascii?Q?20fe6rrSIupmkIVxpaoUecpmWs1MyZK4b7GUwEqeGApkR05louzeKVfFqdVE?=
 =?us-ascii?Q?pW6lNLVc4JpoaYLHfF1eylPSPEV0xbIkiaxnEXVcx/ZWgg9qyjY2jT1AcSs?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c641c2-6fb1-449e-8cd4-08dd6656bde9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 19:54:49.5880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR02MB10479

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, March=
 14, 2025 12:29 PM
>
> Provide a set of IOCTLs for creating and managing child partitions when
> running as root partition on Hyper-V. The new driver is enabled via
> CONFIG_MSHV_ROOT.
>=20

[snip]
=20
> +
> +int
> +hv_call_clear_virtual_interrupt(u64 partition_id)
> +{
> +	unsigned long flags;

This local variable is now unused and will generate a compile warning.

> +	int status;
> +
> +	status =3D hv_do_fast_hypercall8(HVCALL_CLEAR_VIRTUAL_INTERRUPT,
> +				       partition_id);
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +int
> +hv_call_create_port(u64 port_partition_id, union hv_port_id port_id,
> +		    u64 connection_partition_id,
> +		    struct hv_port_info *port_info,
> +		    u8 port_vtl, u8 min_connection_vtl, int node)
> +{
> +	struct hv_input_create_port *input;
> +	unsigned long flags;
> +	int ret =3D 0;
> +	int status;
> +
> +	do {
> +		local_irq_save(flags);
> +		input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +		memset(input, 0, sizeof(*input));
> +
> +		input->port_partition_id =3D port_partition_id;
> +		input->port_id =3D port_id;
> +		input->connection_partition_id =3D connection_partition_id;
> +		input->port_info =3D *port_info;
> +		input->port_vtl =3D port_vtl;
> +		input->min_connection_vtl =3D min_connection_vtl;
> +		input->proximity_domain_info =3D hv_numa_node_to_pxm_info(node);
> +		status =3D hv_do_hypercall(HVCALL_CREATE_PORT, input, NULL);
> +		local_irq_restore(flags);
> +		if (hv_result_success(status))
> +			break;
> +
> +		if (hv_result(status) !=3D HV_STATUS_INSUFFICIENT_MEMORY) {
> +			ret =3D hv_result_to_errno(status);
> +			break;
> +		}
> +		ret =3D hv_call_deposit_pages(NUMA_NO_NODE, port_partition_id, 1);
> +
> +	} while (!ret);
> +
> +	return ret;
> +}
> +
> +int
> +hv_call_delete_port(u64 port_partition_id, union hv_port_id port_id)
> +{
> +	union hv_input_delete_port input =3D { 0 };
> +	unsigned long flags;

Unused local variable.

> +	int status;
> +
> +	input.port_partition_id =3D port_partition_id;
> +	input.port_id =3D port_id;
> +	status =3D hv_do_fast_hypercall16(HVCALL_DELETE_PORT,
> +					input.as_uint64[0],
> +					input.as_uint64[1]);
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +int
> +hv_call_connect_port(u64 port_partition_id, union hv_port_id port_id,
> +		     u64 connection_partition_id,
> +		     union hv_connection_id connection_id,
> +		     struct hv_connection_info *connection_info,
> +		     u8 connection_vtl, int node)
> +{
> +	struct hv_input_connect_port *input;
> +	unsigned long flags;
> +	int ret =3D 0, status;
> +
> +	do {
> +		local_irq_save(flags);
> +		input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +		memset(input, 0, sizeof(*input));
> +		input->port_partition_id =3D port_partition_id;
> +		input->port_id =3D port_id;
> +		input->connection_partition_id =3D connection_partition_id;
> +		input->connection_id =3D connection_id;
> +		input->connection_info =3D *connection_info;
> +		input->connection_vtl =3D connection_vtl;
> +		input->proximity_domain_info =3D hv_numa_node_to_pxm_info(node);
> +		status =3D hv_do_hypercall(HVCALL_CONNECT_PORT, input, NULL);
> +
> +		local_irq_restore(flags);
> +		if (hv_result_success(status))
> +			break;
> +
> +		if (hv_result(status) !=3D HV_STATUS_INSUFFICIENT_MEMORY) {
> +			ret =3D hv_result_to_errno(status);
> +			break;
> +		}
> +		ret =3D hv_call_deposit_pages(NUMA_NO_NODE,
> +					    connection_partition_id, 1);
> +	} while (!ret);
> +
> +	return ret;
> +}
> +
> +int
> +hv_call_disconnect_port(u64 connection_partition_id,
> +			union hv_connection_id connection_id)
> +{
> +	union hv_input_disconnect_port input =3D { 0 };
> +	unsigned long flags;

Unused local variable.

> +	int status;
> +
> +	input.connection_partition_id =3D connection_partition_id;
> +	input.connection_id =3D connection_id;
> +	input.is_doorbell =3D 1;
> +	status =3D hv_do_fast_hypercall16(HVCALL_DISCONNECT_PORT,
> +					input.as_uint64[0],
> +					input.as_uint64[1]);
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +int
> +hv_call_notify_port_ring_empty(u32 sint_index)
> +{
> +	union hv_input_notify_port_ring_empty input =3D { 0 };
> +	unsigned long flags;

Unused.

> +	int status;
> +
> +	input.sint_index =3D sint_index;
> +	status =3D hv_do_fast_hypercall8(HVCALL_NOTIFY_PORT_RING_EMPTY,
> +				       input.as_uint64);
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +int hv_call_map_stat_page(enum hv_stats_object_type type,
> +			  const union hv_stats_object_identity *identity,
> +			  void **addr)
> +{
> +	unsigned long flags;
> +	struct hv_input_map_stats_page *input;
> +	struct hv_output_map_stats_page *output;
> +	u64 status, pfn;
> +	int ret;
> +
> +	do {
> +		local_irq_save(flags);
> +		input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +		output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> +
> +		memset(input, 0, sizeof(*input));
> +		input->type =3D type;
> +		input->identity =3D *identity;
> +
> +		status =3D hv_do_hypercall(HVCALL_MAP_STATS_PAGE, input, output);
> +		pfn =3D output->map_location;
> +
> +		local_irq_restore(flags);
> +		if (hv_result(status) !=3D HV_STATUS_INSUFFICIENT_MEMORY) {
> +			if (hv_result_success(status))
> +				break;

If this "break" is taken, "ret" may be uninitialized and the return value i=
s
stack garbage. This bug was also in v5 and I didn't notice it in my
previous review.

> +			return hv_result_to_errno(status);
> +		}
> +
> +		ret =3D hv_call_deposit_pages(NUMA_NO_NODE,
> +					    hv_current_partition_id, 1);
> +		if (ret)
> +			return ret;
> +	} while (!ret);
> +
> +	*addr =3D page_address(pfn_to_page(pfn));
> +
> +	return ret;
> +}
> +
> +int hv_call_unmap_stat_page(enum hv_stats_object_type type,
> +			    const union hv_stats_object_identity *identity)
> +{
> +	unsigned long flags;
> +	struct hv_input_unmap_stats_page *input;
> +	u64 status;
> +
> +	local_irq_save(flags);
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +
> +	memset(input, 0, sizeof(*input));
> +	input->type =3D type;
> +	input->identity =3D *identity;
> +
> +	status =3D hv_do_hypercall(HVCALL_UNMAP_STATS_PAGE, input, NULL);
> +	local_irq_restore(flags);
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages=
,
> +				   u64 page_struct_count, u32 host_access,
> +				   u32 flags, u8 acquire)
> +{
> +	struct hv_input_modify_sparse_spa_page_host_access *input_page;
> +	u64 status;
> +	int done =3D 0;
> +	unsigned long irq_flags, large_shift =3D 0;
> +	u64 page_count =3D page_struct_count;
> +	u16 code =3D acquire ? HVCALL_ACQUIRE_SPARSE_SPA_PAGE_HOST_ACCESS :
> +			     HVCALL_RELEASE_SPARSE_SPA_PAGE_HOST_ACCESS;
> +
> +	if (page_count =3D=3D 0)
> +		return -EINVAL;
> +
> +	if (flags & HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE) {
> +		if (!HV_PAGE_COUNT_2M_ALIGNED(page_count))
> +			return -EINVAL;
> +		large_shift =3D HV_HYP_LARGE_PAGE_SHIFT - HV_HYP_PAGE_SHIFT;
> +		page_count >>=3D large_shift;
> +	}
> +
> +	while (done < page_count) {
> +		ulong i, completed, remain =3D page_count - done;
> +		int rep_count =3D min(remain,
> +				HV_MODIFY_SPARSE_SPA_PAGE_HOST_ACCESS_MAX_PAGE_COUNT);
> +
> +		local_irq_save(irq_flags);
> +		input_page =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +
> +		memset(input_page, 0, sizeof(*input_page));
> +		/* Only set the partition id if you are making the pages
> +		 * exclusive
> +		 */
> +		if (flags & HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_EXCLUSIVE)
> +			input_page->partition_id =3D partition_id;
> +		input_page->flags =3D flags;
> +		input_page->host_access =3D host_access;
> +
> +		for (i =3D 0; i < rep_count; i++) {
> +			u64 index =3D (done + i) << large_shift;
> +
> +			if (index >=3D page_struct_count)
> +				return -EINVAL;
> +
> +			input_page->spa_page_list[i] =3D
> +						page_to_pfn(pages[index]);
> +		}
> +
> +		status =3D hv_do_rep_hypercall(code, rep_count, 0, input_page,
> +					     NULL);
> +		local_irq_restore(irq_flags);
> +
> +		completed =3D hv_repcomp(status);
> +
> +		if (!hv_result_success(status))
> +			return hv_result_to_errno(status);
> +
> +		done +=3D completed;
> +	}
> +
> +	return 0;
> +}

Stopping here because that's where I stopped in Part 1 of my v5 review
of this patch.

Michael

