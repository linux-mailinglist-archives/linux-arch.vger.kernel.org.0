Return-Path: <linux-arch+bounces-9414-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 222F79F553F
	for <lists+linux-arch@lfdr.de>; Tue, 17 Dec 2024 18:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C62177F60
	for <lists+linux-arch@lfdr.de>; Tue, 17 Dec 2024 17:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21201FC100;
	Tue, 17 Dec 2024 17:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Eq1uP11U"
X-Original-To: linux-arch@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013083.outbound.protection.outlook.com [52.103.7.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853431527B1;
	Tue, 17 Dec 2024 17:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734457685; cv=fail; b=gRPcFHDkg8Ywq4sctPvLkEZFJSDEvMbiU1cDy/9ynW5TIGEkNmXIquEks7KBonuiA2dELcFolJkxTjLwplRwXsSvABWbsLFtJy6AX4t7zfmvzugOy0bdftYgiilqHNpNm5MehG4xxClfqaW1XDPN6gvz/ZI3FmyX+TWmll/+p18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734457685; c=relaxed/simple;
	bh=F99uhG4YGAXI4LDmMGtdz2eAdhAimY77eGxmUqcvWcA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EpsNSYF40WBDP3r77ziMX4umTHKwrOSX1cQtbv9T1AD4WaTMc5GK4hy3dIDJGAS1QEwyzCHPBd4AwYeoaEMSgg1CniX59r/AReUD/sycipQy8ta2WoTVnwYUdDJuripMjSslxo5dBx8I3pkEo7IrhKoB+4MAehEwOCXHCW4ztj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Eq1uP11U; arc=fail smtp.client-ip=52.103.7.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksNtC2UiNaXF+20n85Yo8VbZ3kT0nypKfTuMuJixyGDCqBqn48XUymOYxOe5cMgIiBMjAdt6LxIMNMiu1EoyLc8apRBrdc+GKeFjIQn/wlIkddYiOGj3MrhPlBxHg1LzS0ACTkCO8dyUOslkQi8w0cGhuJVSRtu/5AS87LnK15dNO3S3Y5R5KEFeaINARB7vmo3b8cpTByCF0KAQvJWwTrg/xl/Zl6sPlpIu/uiMVQvLLuuFce7CC2U3z34e1x87BuR1yrgCBEEHgJccSisxnaYuvVqVlXuwfUZ4PWr1jZ+JwaX2kircvZ+YY7hrxAqXGt7VXZiE6yBl0BBRm2BeKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1PkUcvtrlYhlAFJi32iVwbP98gDV03VlDAOmOlvXdc=;
 b=qITNlvEBlL815r/puALqN8T93dAX6hgzH8IDkx1lya0oIXQZCSmg52yutmP+i/V1TtmxhVo2LAiAVJT1XZDXP8VvdC67jQM7NcVIKce/ZkSf5xPp798Y9Z0i36MlJuxFXTLTF2cNSL1SH71dZgdWOBptoL7RKBDBzz1SifrcVqdxA8t34jQeEQ4gze2jXApZ/7SQuBVBpnbVxw6l8/XQyvz1eMtznoUlnBwiAZAQMHP2+g0gDnM/PDkP4tJQEqlvhFyKYXSPKxwr70va1pQetBhNJ3g/dvCcW6bvmGrlPA2sB2Jri4Y/rrPM8/41AEIhitAwudIamWWDSNiZA/JvtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1PkUcvtrlYhlAFJi32iVwbP98gDV03VlDAOmOlvXdc=;
 b=Eq1uP11U7ULuYbqd6L+MkmH+DWFCzaSj+8GyJIIomjW5Z7GIgILEanBisxpuXdTQkDYiOp7Xsl0tLIg5kho7Xth46kiv0EvRJWETX1nCXP6Jwrb12s6oaWz5OtJqkEZ4krVRENDrlFltGUwpaqECA/S27n3QXneA+pipqyfydxcm8uLGvTlKV9kMC5cSi3wXYopL/LlsK1D8jBXaHAR0H1Vj7Ie9/FjvS8BNXNEPb8IkYT+hYmqANwvUlvlwhdJsSNrmK8wox16dSIdT6mzvlzgBzG6orepFuGJOrxgo4O3WMuUUcYKJR9P1ITifLvQJ1E4IV4wStJDpV9m3m6X6QQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB8810.namprd02.prod.outlook.com (2603:10b6:510:f4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 17:48:00 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 17:48:00 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "arnd@arndb.de"
	<arnd@arndb.de>, "jinankjain@linux.microsoft.com"
	<jinankjain@linux.microsoft.com>, "muminulrussell@gmail.com"
	<muminulrussell@gmail.com>, "skinsburskii@linux.microsoft.com"
	<skinsburskii@linux.microsoft.com>, "mukeshrathor@microsoft.com"
	<mukeshrathor@microsoft.com>
Subject: RE: [PATCH 0/2] hyperv: Move some features to common code
Thread-Topic: [PATCH 0/2] hyperv: Move some features to common code
Thread-Index: AQHbSC1So8GCRq0rV0qQjqDih6Q3h7La8lVAgANs0gCAAFTbQA==
Date: Tue, 17 Dec 2024 17:48:00 +0000
Message-ID:
 <SN6PR02MB415783BB8A3844F5ADD142B2D4042@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1733523707-15954-1-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB41573F55DBAAF124CFD92840D4332@SN6PR02MB4157.namprd02.prod.outlook.com>
 <6cf69fbd-b6a0-4e88-85a6-749a4e2dbdaa@linux.microsoft.com>
In-Reply-To: <6cf69fbd-b6a0-4e88-85a6-749a4e2dbdaa@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB8810:EE_
x-ms-office365-filtering-correlation-id: 17623cbb-a8d2-465e-5239-08dd1ec2f2d1
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|19110799003|8060799006|8062599003|461199028|102099032|10035399004|3412199025|440099028|4302099013|56899033|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?i9HHZ0edh9UQVvJu1waRVJY9jnupQv+MPM1Etx3IIBXW7hDkIvXjmHXN6wmo?=
 =?us-ascii?Q?DHxr5S4CCDxynvSDrU2YhdnVjam20FXweSqSD9o8W/CctjHYGBe+ksYDtffH?=
 =?us-ascii?Q?j4zR3MHr0w3rU0Ukk3JquqRNfkIEZIfzxGxFqXzr3fy9XqTkQhCL2u4bRB7q?=
 =?us-ascii?Q?/pAnmfnT/pruGGl8+j6luF+9ye+1lywT3eKKz4RdC8IvLuClqhf3kGFWidWJ?=
 =?us-ascii?Q?tuHlz+iWA53tsoJclSWVcwEQTn4cM78ywNVLYRGd2Upq/grym2GTBUKDVbyS?=
 =?us-ascii?Q?vqKXDANCw25e3/jjevAdjylermvrw5jUG9nbLI8DE1Ursy1BlUmoGPlHC6PK?=
 =?us-ascii?Q?C+D8DCrWv4f7BmyGionVAWMRf6RrvzKjiatwDLsxXZw4kRxjlu/MBV3Ajrzk?=
 =?us-ascii?Q?cutbh/s3lvqCujc+xKll44c1248iedSfHsMNwCoh4ATu/ypczySVdktmBRpI?=
 =?us-ascii?Q?vA+rq0iObhHQ2ZonoM5aCuLK+z8E7rMfaTvs652Ppldh7WkYKZmiH1nVA8dB?=
 =?us-ascii?Q?pqv5SbhSCRskUiGCfF1YlB3cowfs8nJb8C+uk3hWF7VTJEskCn6heNJ/fWKE?=
 =?us-ascii?Q?P0rBENgLKuAUmaWbzLBf50NEZv+q0YSvfAosuV3xOVPRaF5NxrAXTmj1cQhW?=
 =?us-ascii?Q?upVB75ql9RRei+dtnhETZQLcY7BBHdxPtzgLZJHzen7FSvuXmGTqTms8ud/2?=
 =?us-ascii?Q?I8476n+oz9MJ4HFs+WwKc6X1QuQplQJX6E7p154B+QrjY77tqPlgqoxDlFDa?=
 =?us-ascii?Q?I4xhyO6gXlWPaGXuIY6pZhlTET7vesbW8xnfEqI8YRNATqfO+zK80ALWzsDU?=
 =?us-ascii?Q?naEi/r4jQAUMvlmYaYrbkxMyOguSGOghCAJw67mjt/74QWhZwbndnfbwOW1V?=
 =?us-ascii?Q?S3Sn7ch2gob1vrxv7A8nQVEdbLpauT2ZhwMfM+rI0IRnF9SWd3tEjocI57LB?=
 =?us-ascii?Q?1hsALgQCQ8q9dsoOdvDxYhtFesE0OgROZsN7+7mzkQWC6yb/hlKomgiyLMRH?=
 =?us-ascii?Q?Upfc8+FY3Qz67bUMgiNrmjRGj3A95cKJAdVbtxPhqNQUECRhyG84u2vtCMSy?=
 =?us-ascii?Q?1lJW51AIZZJ1AI8eAGlzHBaX5geRNtgRXiduz6ZrTze2FnGVUyLDalDpfgRo?=
 =?us-ascii?Q?QRL93nLOH/0BcMZ388OxTBLyyJK21m1WbsvMQn7IfSLi4mKkCP/2hUw=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cJR9Uczsz2pki6LKt57NLacvxM0s/6d8iXq9wIKEkvwld11WW2+c1MwTjvxe?=
 =?us-ascii?Q?RISbTh1VvFWFSs7uZ+bj5VzMBgujslguwz/j8J8Jvl9Biwvm/7QOaYzyiW+3?=
 =?us-ascii?Q?NisOwguqKIF8wG/s+xKCC5w7kZyHa5ACfhWqXGgaiMtbcNSmXZPKYPeuBxfE?=
 =?us-ascii?Q?UhVjmehdbKhH3AYGdDYFI50q5XM4aFkV7mnwtx0Yw7KbgMOdIlW4A7amtb3P?=
 =?us-ascii?Q?Mg8+YOBL81bEKWsfuE79bvVaDgRuNrEIRrAEZFrUxrMlQVVuWQcLD0eUCzdp?=
 =?us-ascii?Q?PLAd9qHO69dD+De6zNMMRtdQ88jSR5Os08LVv+ipGuf0MrXr5IWjhNVTQIug?=
 =?us-ascii?Q?DzawTkN6X0xngFq1FxkocHVA87Lyoq45Yf7v+LjmPfzB833RuwVExxHutbEu?=
 =?us-ascii?Q?PBP+GIzrDLkB9SpY/GBu2NsCmsNsXlPZ9VTTfHPoJXVyyAz9g01E3vD0mkQv?=
 =?us-ascii?Q?2SV4JQ8uhjEX6e8vjeDmpO5r6vCt0DvsR9icBvTmEAfdpuhpH0ZEGWmwuHq6?=
 =?us-ascii?Q?e7RR5/GscThcFwXqT5361ZrK45oMjMGeM/PLLlHPE8bVJLRhsYQXj40VF+sC?=
 =?us-ascii?Q?7IgpUYcUmegHRUyGCm9SYOADcJAArn69SATbaSkD+P7QLGy0xqFGnR52Azmk?=
 =?us-ascii?Q?aNygntPATbrAkWjdQ61/8m7Y9QRI6IOYCUtZ/KAQu7W4j1nfTrixtDual+S8?=
 =?us-ascii?Q?YBEUrq8VVDpVoKLYK7piqD/UmNB6kxuWPz7mWA49ZtqlWHdpKAf/5F8XAYKD?=
 =?us-ascii?Q?lLETmq5D4vv/I16ekvroGFpu7W3fTiMMgH2A9KqVczSlEmbbdkcGID5eLg0w?=
 =?us-ascii?Q?ng7y4ppuQPWmJAEkoVLFZnz8ch8m4z+GbIxTHuBTCuBwao1CXyuBOT7jZR8c?=
 =?us-ascii?Q?F5UfLbiIOjm9fnchV1vIR3Mzw7mxQRjgI8yoekptzQi9H2wF/BjNByNJ/7Gc?=
 =?us-ascii?Q?+p36q/UMm73hKqpwWk/3W4KPv40x18F6lvQnoGp9SacVO7rjdfqfy7nBCH6M?=
 =?us-ascii?Q?/F8R2xMSXLooWCEouy/M27W4XRbyDZOWv8/2/Zl1HhvcwuILJhkyAhnSkvQ0?=
 =?us-ascii?Q?6PzItA/BfOZlnx2e73hBMwexIePht30wklMvGPvkP0Rf8YpG0HVGL4D33QjV?=
 =?us-ascii?Q?hKTJJoxHs2KGBOzAFEcMFvIoihUlMmGRQ2+ts2dNbw79smA+S5nCOPrEDV+o?=
 =?us-ascii?Q?8aRStaLZM2fcGSlCUGp1MqDqH9DtgDmjHacwsGpqjr22izybgbbRM+XE5kU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 17623cbb-a8d2-465e-5239-08dd1ec2f2d1
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 17:48:00.2579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8810

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Monday, Decem=
ber 9, 2024 12:20 PM
>=20
> On 12/7/2024 6:59 PM, Michael Kelley wrote:
> > From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, D=
ecember 6, 2024 2:22 PM
> >>
> >> There are several bits of Hyper-V-related code that today live in
> >> arch/x86 but are not really specific to x86_64 and will work on arm64
> >> too.
> >>
> >> Some of these will be needed in the upcoming mshv driver code (for
> >> Linux as root partition on Hyper-V).
> >
> > Previously, Linux as the root partition on Hyper-V was x86 only, which =
is
> > why the code is currently under arch/x86. So evidently the mshv driver
> > is being expanded to support both x86 and arm64, correct? Assuming
> > that's the case, I have some thoughts about how the source code should
> > be organized and built. It's probably best to get this right to start w=
ith so
> > it doesn't need to be changed again.
>=20
> Yes, we plan on supporting both architectures (eventually). I completely =
agree
> that it's better to sort out these issues now rather than later.
>=20
> >
> > * Patch 2 of this series moves hv_call_deposit_pages() and
> >    hv_call_create_vp() to common code, but does not move
> >    hv_call_add_logical_proc(). All three are used together, so
> >    I'm wondering why hv_call_add_logical_proc() isn't moved.
> >
>=20
> The only reason is that in our internal tree there's no common or arm64 c=
ode
> yet that uses it - there is no reason it can't also become common code!

Maybe I'm missing your point, but hv_call_add_logical_proc() and
hv_call_create_vp() are called in succession in hv_smp_prepare_cpus(),
so it seems like they very much go together. Presumably a similar
sequence will be needed on the arm64 side when running as the
root partition?

>=20
> > * These three functions were originally put in a separate source
> >    code file because of being specific to running in the root partition=
,
> >    and not needed for generic Linux guest support. I think there's
> >    value in keeping them in a separate file, rather than merging them
> >    into hv_common.c. Maybe just move the entire hv_proc.c file?
>=20
> Agreed. I think it should be renamed too - this file will eventually
> contain some additional hypercall helper functions, some of which may als=
o be
> shared by the driver code. Something like "hv_call_common.c"?

I went back and looked at your patch series from a year ago [1], and
got a better understanding of where this work is headed. I wanted
to comment on that series back then, but got subsumed in wrapping
things up for my retirement. :-(  I see significant portions of that
series have been posted independently and accepted, so my further
comments here assume the rest of the series is still the macro-level
approach you are taking.

From that series, you are planning three modules, controlled by
CONFIG_MSHV, CONFIG_MSHV_ROOT, and CONFIG_MSHV_VTL.
That makes sense, and addresses one of my top-level concerns,
which is that normal guest kernels shouldn't include all that code.
And apparently that code works as a module as well as built-in.

The code currently in hv_proc.c is similar to the code in hv_call.c
and mshv_root_hv_call.c from that series -- it's a wrapper around
Hyper-V hypercalls. But a difference is that the code in hv_proc.c
can't be a module because it is called from hv_smp_prepare_cpus(),
which must be built-in. So it can't be added to the proposed
hv_call.c without making all of hv_call.c built-in. Ideally, there
would be a separate source file just for the code that must be
built-in. I'm not familiar enough with root partition requirements
to understand what hv_smp_prepare_cpus() and its calls to
hv_call_add_logical_proc() and hv_call_create_vp() are doing.
Evidently it is related to bringing up CPUs in the root partition,
and not related to guest VMs. But those two hv_call_* functions
would also be used for managing guest VMs from /dev/mshv.

As for the name, I don't really like "common", even though I'm the
one who created "hv_common.c" back when doing the initial arm64
support on Hyper-V. :-( My thinking is that anything that isn't under
arch/x86 or arch/arm64 is by definition shared across architectures,
so having "common" in the name is superfluous. Maybe just
staying with hv_proc.c is OK.

>=20
> >    And then later, perhaps move the entire irqdomain.c file as well?
> Yes, may as well move it too.

irqdomain.c is also in that category of needing to be built-in. But
looking more closely, it is x86 specific and should stay where it is. I
can't immediately tell whether it's feasible to make the Hyper-V
IOMMU driver (and irqdomain.c) architecture neutral, or whether
a separate arm64 implementation will be needed. My guess is the
latter.

>=20
> >    There's also an interesting question of whether to move them into
> >    drivers/hv, or create a new directory virt/hyperv. Hyper-V support
> >    started out 15 years ago structured as a driver, hence "drivers/hv".
> >    But over the time, the support has become significantly more than
> >    just a driver, so "virt/hyperv" might be a better location for
> >    non-driver code that had previously been under arch/x86 but is
> >    now common to all architectures.
> >
> I'd be fine with using "virt/hyperv", but I thought "virt" was only for
> KVM.

Now that I see the bigger picture from your previous patch series,
keeping the files in drivers/hv seems OK to me. The 'mshv' code *is*
a driver that implements /dev/mshv. :-)

>=20
> Another option would be to create subdirectories in "drivers/hv" to
> organize the different modules more cleanly (i.e. when the /dev/mshv
> driver code is introduced).

Putting all the mshv and "running as root partition" files in a single
sub-directory might make sense. Multiple sub-directories might be
overkill. But I don't have a strong opinion either way. Putting them
all directly in drivers/hv seems OK, as does one or more sub-directories.

One thing I encountered back when first doing the arm64 support is
that everything in the drivers/hv directory could be built as a module.
The Hyper-V support under arch/x86 was always built-in, and the
arch/arm64 code I added was as well. But there was no obvious place
to put common code that must always be built-in. At the time, I thought
about introducing virt/hyperv, but had only a single relatively small sourc=
e
code file, and introducing that new pathname with its own Makefile, etc.
seemed like overkill. So drivers/hv/hv_common.c came into existence. I
tweaked the existing drivers/hv/Makefile so hv_common.c is always
built-in even when CONFIG_HYPERV=3Dm. It's a little messy, but not too
bad.

The difference in what can be built as a module vs. must be built-in
might be a factor in the directory structure, along with the
CONFIG options that control whether the root partition code
gets built at all (see below). The details will govern what works
well and what ends up being a bit of a mess.

>=20
> > * Today, the code for running in the root partition is built along
> >    with the rest of the Hyper-V support, and so is present in kernels
> >    built for normal Linux guests on Hyper-V. I haven't thought about
> >    all the implications, but perhaps there's value in having a CONFIG
> >    option to build for the root partition, so that code can be dropped
> >    from normal kernels. There's a significant amount of new code still
> >    to come for mshv that could be excluded from normal guests in this
> >    way. Also, the tests of the hv_root_partition variable could be
> >    changed to a function the compiler detects is always "false" in a
> >    kernel built without the CONFIG option, in which case it can drop
> >    the code for where hv_root_partition is "true".
> >
> Using hv_root_partition is a good way to do it, since it won't require
> many #ifdefs or moving the existing code around too much.
>=20
> I can certainly give it a try, and create a separate patch series
> introducing the option. I suppose "CONFIG_HYPERV_ROOT" makes sense as a
> name?

Now that I see you have CONFIG_MSHV, CONFIG_MSHV_ROOT, and
CONFIG_MSHV_VTL planned, could building the hv_root_partition code
just be under control of CONFIG_MSHV_ROOT without introducing
another CONFIG variable? Is any of the root partition code like
hv_proc.c and irqdomain.c needed if CONFIG_MSHV_ROOT=3Dn?
Stubs will be needed for functions called from the generic kernel code
when CONFIG_MSHV_ROOT=3Dn, but those are easily supplied in
asm/mshyperv.h. If hv_root_partition becomes a function whose
return value is gated by CONFIG_MSHV_ROOT, then the compiler
can know when the value is always "false" and drop even the code
that calls the stubs. But I'm pretty sure the stubs are still needed to
avoid compile errors, even when the compiler drops the code.

With this approach, you can avoid #ifdefs except in asm/mshyperv.h
for the stubs, and in the hv_root_partition() function.

One more code structure topic:  In the previous patch series,
some of the mshv code is x86 specific. There is x86 assembler
code, and references to x86 specific registers (all the HV_X64_*
registers). Do you plan to put architecture specific code under
drivers/hv, or under arch/[x86/arm64]/hyperv? We've made
drivers/hv be architecture neutral -- currently there's only one
"cheat" with an #ifdef CONFIG_ARM64 in the hv_balloon.c driver
that turns off some functionality.

As we discussed previously, the new Hyper-V #include files
provide the union of x86 and arm64 definitions, with just an
occasional #ifdef where needed. That was justified because
that's how the definitions come from the Windows/Hyper-V
world. But it seems like the mshv code should be structured
with arch specific code is under arch, not in drivers/hv with
#ifdefs. The Makefiles in arch/[x86,arm64]/hyperv will need
to use CONFIG_MSHV, CONFIG_MSHV_ROOT, and
CONFIG_MSHV_VTL to decide what to build, and whether to
build as a module vs. built-in.

Maybe putting the mshv code in a "mshv" subdirectory under
both drivers/hv and arch/[x86,arm64]/hyperv would conceptually
help tie together the arch neutral and arch specific portions.
Or something like that ....

>=20
> > * The code currently in hv_proc.c is built for x86 only, and validly
> >    assumes the page size is 4K. But when the code moves to be
> >    common across architectures, that assumption is no longer
> >    valid in the general case. Perhaps the intent is that kernels for
> >    the root partition should always be built with page size 4K on
> >    arm64, but nothing enforces that intent. Personally, I think the cod=
e
> >    should be made to work with page sizes other than 4K so as to not
> >    leave technical debt. But I realize you may have other priorities. I=
f
> >    there were a CONFIG option for building for the root partition,
> >    that option could be setup to enforce the 4K page size on arm64.
> >
> That makes sense. I suppose this can be done by selecting PAGE_SIZE_4KB
> under HYPERV in drivers/hv/Kconfig?

Since the PAGE_SIZE value is independently selectable in the .config
file, I'm not sure if you can override it when CONFIG_MSHV_ROOT is
set. But you can allow CONFIG_MSHV_ROOT to be set only if
PAGE_SIZE_4KB is selected on arm64. I'd have to look in more detail
to figure out the best way to create an appropriate dependency.

>=20
> I'm not how easy it will be to make the code work with different page
> sizes, since we use alloc_page() and similar in a few places, assuming 4k=
.

alloc_page() is not the problem as it is relatively easy to break up a
16K or 64K page into multiple 4K pages when depositing memory.
And you can round up the amount of deposited memory to the
larger boundary without doing any harm. But in your previous patch
series, I see hv_call_withdraw_memory(), wherein Hyper-V gives
back individual 4K pages in no particular order. That's the killer, as
it is not feasible to re-assemble a random set of 4K pages into larger
16K or 64K pages for free_page().

So scratch that idea. :-( The root partition must run with a page
size that matches the size Hyper-V uses to do memory deposits to
and from a partition, and that's 4K.

Michael

[1] https://lore.kernel.org/lkml/1696010501-24584-1-git-send-email-nunodasn=
eves@linux.microsoft.com/

