Return-Path: <linux-arch+bounces-12376-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6643ADF265
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 18:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB11D188082B
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 16:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40312F0035;
	Wed, 18 Jun 2025 16:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kwqPU96R"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2067.outbound.protection.outlook.com [40.92.41.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B0E2EBBB7;
	Wed, 18 Jun 2025 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263549; cv=fail; b=rJT95mB8z5Tjyf1wS/dsddY7z6wjJ8yZk+r0h2DWu9bxj3+gQwkpJ3GpSOa5J0Z8N0Wuq0wKJpIokvAjMxEotbmxh9SAwfB4XFdMe/VWMkYI/sX/AEmZlxfI65BQ5CRpZd4rpLkXGv4NPbphYUkgYSj69+Gd8fW3V6T8wgX+Dj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263549; c=relaxed/simple;
	bh=7ZUEUT4WIDeg0CRgUo0Iw+IO2fBF57faWqFsKeGrorI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z6UOQsuEEl+qgohSC/O0XCSMt+wgZ6rp1F3iEhrk5eVDCiami+N43LNEl0EOCCezZmBEi+qLTpb3LcDknsYWN9veQSKGFRNY0W/qCS2uLiCFcHLDmLOeFuQ/55FEahZlb42DEfSbBX2v/c4BEr8XrQQjCk/Lz55zp1JV0ZG+BC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kwqPU96R; arc=fail smtp.client-ip=40.92.41.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwXpNx5IepPPN8JJFXS1ADhlFsiPCIV2DiITshprWZ+T3cfStWpBi//dJvYBFhBkqEofFG0z3/yQ9C7soD0eCo0HYDJ0MzxAjHTt/RSBtoAOqtfcNT5+HT+D6YtaQXLyqUs9PjPmZs/aVNwF34xGPEGvjXX4awYghSmYxJJpedE93xOKrvTzDNF/SIp2eXHfRzkpx9k9K8LxBOVa47Jck/ZUF+QS56oPpGhmeBpLkagHTKcg+QHhB5MXOMCu/Yejh3cdrh8sZLAz/3KfJtAkLHaqdqGOF832xqBe9Pt/bnQWmsN8AsjIuPJLl4BZNXuu5627CCZcrd9XRxepYeI+Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPd55u/nQbwgaY9Xy+vnwktWfLjiGTvDAWIXBRgnp8Q=;
 b=DCrFfK7cUF6ofylBQ8LORfWTHi2kVjqQrai/OF0z9rtb6mPeplgkPLjVL9+cA1645V3DIzQ7BknHyMsGp0XL/Zxdw8ms3RRIntt9lWyIx4pTkbpryxBRAOSztrkTMLxnQpbeJageF2Y9nATUXgYWhejX0EwiJoyg7qnV7Ft2Y+BxVbFjMGp6sENZ3ncl7+zDOJsTfMybrZ4pT9t/CM1Jv1bBpEq1sAbqgZsSGqYyOtkTvmqFrUArYbbAc3ITgbW5ICTko9/vgEvqC3UFlom+fpZeNU/sqxuvRdcCchgks495wR1kJSpjO0ABvKAurMevv2dgAL/IPIreHF6V1NaeWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPd55u/nQbwgaY9Xy+vnwktWfLjiGTvDAWIXBRgnp8Q=;
 b=kwqPU96Rv7W+qIzcXVYPSVe0QFLr+04oHos+KDrPZCrHQmuHJyky/JQl+QS7/Av9vvYk1sbl0fh3G/TgjJllzJw2+Z70rcMDDQCUREMBo3yzsjt0BLYRyXOV5HulW8MhXwnUOwv+aoLkX8dPisYleJ/Q8MQ2grl6fU9ahdkHgXNzUiEG7rXmhbGOAZvgGTWMGPANmWOIeQStRizQsvplqtV7hynLs3BbdWZ61wNRzjiwD/N+2KYP+RbkKdlN1MmtHua7yaNUQeNeLIq+JHr5rigIIMrKjlB4EAakQc4SnBd9YgbbbTU52QOzjdjdQJTRhru/bZ66S6MhDugprPCVsA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA1PR02MB8462.namprd02.prod.outlook.com (2603:10b6:806:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 16:19:03 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 16:19:03 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "alok.a.tiwari@oracle.com"
	<alok.a.tiwari@oracle.com>, "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de"
	<bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v3 10/15] Drivers: hv: Rename the SynIC enable
 and disable routines
Thread-Topic: [PATCH hyperv-next v3 10/15] Drivers: hv: Rename the SynIC
 enable and disable routines
Thread-Index: AQHb1Om8+bXYoP2+Rk6m6ViM1VdnP7QF6sfA
Date: Wed, 18 Jun 2025 16:19:03 +0000
Message-ID:
 <SN6PR02MB41579B825874B212C7DD5445D472A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250604004341.7194-1-romank@linux.microsoft.com>
 <20250604004341.7194-11-romank@linux.microsoft.com>
In-Reply-To: <20250604004341.7194-11-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA1PR02MB8462:EE_
x-ms-office365-filtering-correlation-id: 44b53869-705f-4a42-1c8e-08ddae83d7a6
x-ms-exchange-slblob-mailprops:
 ZILSnhm0P3k1KuhwzYdE6C/ocrAmq9m0ECC0r9kjbASAymPnRHyDq5ds/XxA3/WkwpoBnQoUwwbGxcdoYYNOS7FJOnyG+XsipoZOyXi9xVp62BJHfQzxH6ilTAwjJO1NTkqINZKF06fYx2Ve7WzsWGN5obYawHQ6vW3vSeabemkMyhciRBjbGF61wr8dXYPdg0dDjgAF/E/EHkTnYxnJ2F1iPAVVJaNBuhBx3ooQ52kTWXexVB9Y3WuNlH9M2Xoh7J/5ouzvWhBuHIYVXx6bsfWCXsPR/AoAHbQn6UL7tSrx8b0qg6MDk7N2pMfpHIDHTf0mSFhrFJZCIejE2GqKUgF4JPc/WLBliiW5pu87yTUvskJ5DN+zvfrhGOrBWgatOgnkE3dpLXhUgxH3isk5kc6OBzyriIXEo51pJVPrZ/BC5n0cUkb5dYlQcJJJP5QHnW7FY8F15+ndUXdDktGCKR1wEPfWZ/KD+zekqQDYw2dxXK+/LvXTU0Zo1kJWOoZJJX9iYaZQCdJC5zwOFHZEHZ35gVOc0alJ1OgQ9B/2kFHZk3CidOfBkgwYiXwAxunYu8ot82zn/vL5Wl3jAE+78/P2QV6DVIwzcYFVLgcX1mawNKdg74mN3wVp64V8k2OLDTMOK3GySfVGuA1BtE38i5ERfgYV5Jsw6RFbvFqlPy/hjh7gEpC+DKXlW7U9xsB2zrLvMDKz+7CTI/gc6ooOKRGHejvooZ2kg8xP9it9kRAoZkMznWa4HWuEGQ9ps1iSWvnkwZDcwYwAJXLoh/Co8HdGUpj33FBO
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799006|8062599006|15080799009|8060799009|41001999006|3412199025|440099028|40105399003|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?v9zbS+I8NYBZ9uoEBnjPrv8xJVD6i8hMF61RBnsiqHDjJyA2PIaU+Kpc1elG?=
 =?us-ascii?Q?IivjJzpRZSzMOOWc/8Aq6klr85uFh5K1KQodToI/LsqtYbhQTAyw1+o4b2Gw?=
 =?us-ascii?Q?k383CWmlr1/rdMzh+eqljTiefWesODuLjRHlzcAI70d74QDSjjs0wCEmNQOK?=
 =?us-ascii?Q?k9CKbeqqYLwSMqsXf9ub4lK7rk+SbjmrcoFY423jbrSN4KgSLuYbUjmYvnI2?=
 =?us-ascii?Q?L+8cFNefxYxM9FcImdwYltaTZAETUlQPKF/60RcnQ0SUQ/GZ1y0pf/R15BcJ?=
 =?us-ascii?Q?6gFL8u83SYfh9YnVw+xBad9mxsuw/BeZpuieHdbXeSHIX1lTDIFfGubvXyJh?=
 =?us-ascii?Q?3cEMADgU3zinS5MCdtYqw8zBXFPxmXzKTnUoIHIIF49t9CXzgp6w8qJBEAG0?=
 =?us-ascii?Q?MDbkipi32roGVgBJ0wtdntBRMdLiti/YRZOvs1AgYvCeR8AfepbBPiqHVnf3?=
 =?us-ascii?Q?Ax4ttGrDI+3S5aojgMEhmv2abrzHlc8K/VFMguntWjSnDSz8F3kbm0J4lPSJ?=
 =?us-ascii?Q?1aKYoSjbK3VcMhYwLF0ctl28KXR9Tt3PuS0fNLVdXmMDd7n0OITzyc7vCjM7?=
 =?us-ascii?Q?5S6pgpKscFdRRkafhbAN2/xj+5wzrdS3fFafsPSh2ar82Spqbl+ThWSpo+kq?=
 =?us-ascii?Q?3+PI6tD1LMxi+dxJ15qN3iwRK3bhpR3BlJysa2VlXgakn/OY4Ers8CkO9eSU?=
 =?us-ascii?Q?Z9CU9zJ8fudw6F+TY8saZq8UY78HwCxzZ/JIH/gYB9pgKq6ERpSYnA1kxYbg?=
 =?us-ascii?Q?66EfiKCCAhvkIEDXmIk2iAjvO/dwWFZfWiM7srQsPgNoEUyTTjoJUE/RkD6Z?=
 =?us-ascii?Q?+7AILv+xajjjGL94qXfz3dan3HQf33IyHU8Fl68XcUhFSCrgJtu1Wd2zRY5k?=
 =?us-ascii?Q?N9OyHlNNo9NbnG3BBjHBHKDu2CZSPbcOfkT50HBlACDRi7D690cx5zy/l9MF?=
 =?us-ascii?Q?cD1O4fRIhodP6Ol+5AiLb4kxK0osMW6S1smULrb4vWkFxnEOHZle0HFLXmjc?=
 =?us-ascii?Q?jQahIvyv61mPkUP0cZTi8+PfnZusDrvhNHMehDA1A6phSTf4CD5yns4/l0ui?=
 =?us-ascii?Q?oFbnRJSXqOTk6miGn0OPYS3jnNlrbVdFORkbkgRSVSJe3TO9843tHxE/qcOH?=
 =?us-ascii?Q?aDJEO6FOhq7mIwhzGPeFm4KiCg4tTgZ5VNlJzeh3Z+Vwuym47Yr1MzA=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?geS/Su5LJ3kJC79i8CVJh/cwGJA/h/NIFqKARpa0QYxxc5LH12EI5oId/8TH?=
 =?us-ascii?Q?P/Qigljo+J+1V74vo5J2jgOZkgoRBC0W/JSNM5BfotEFUNmBQ+70MCt1KwYR?=
 =?us-ascii?Q?cXvpOh6mCsNdwbB0zXHSaDZKtnZnIilNqn2wyprYmnix2TqDOj0IksCS6vF6?=
 =?us-ascii?Q?MY4NegynRBL+KdLuZsr4dUE7ayiSLrv7wUaxzsAbnqaZS9LrfG3RhcCvFscj?=
 =?us-ascii?Q?sDn4TYzlmEA3cHzfa1extTVYnsCrierik3g0Bxvx9hTzT20+Cx5o/ZGH7wZy?=
 =?us-ascii?Q?APIeo+hA4U+GtktqGks38eiv76urACrHa1BlpJGJufUgUV+6lnm6vwUqm0NA?=
 =?us-ascii?Q?B8u/eOvB2ySTdJV97c7oweKblvKou4sZq9Tu4Rl8vX4QUam25UCaX6rQJ/zS?=
 =?us-ascii?Q?iqAJLRYZ7YD+QfehF5HGiKrDIxVKRQlgIhwHMdRHEJVEnIKTVg4aLYgQavmk?=
 =?us-ascii?Q?Mj+I/Yq7ZGVGUI+P04bR8PxYS18RlzxWvE9+B5QdZd3rVQ2SftXVB4cbHSq5?=
 =?us-ascii?Q?oDQaDsx+eUDM9rl76zJz3Okku3mftZ0dM7taz9qlFIxPdu49xnUZ0wKvABMb?=
 =?us-ascii?Q?E6aAANpMRmvYHa6CyWUqOqodw3SaFd5CU898mhRvkGQIdvKRCGUuYVk8gHHN?=
 =?us-ascii?Q?KK56POxiMGMDRR54JTdjCzshKlW4gRNnifphxTz5lprSnQ7PlOlHYEjW3sB9?=
 =?us-ascii?Q?L1RkWO+N6ewFCzDb6khd6Zc3GDxZ1Ac1N/GqSDl5qxxt3ea8nznuxlz6plP1?=
 =?us-ascii?Q?XwAF5Ya0sL9OqRuGaLjOS+koZZpdtnWMQmZV9ymd7a91GMBGouYsPbkhcNFY?=
 =?us-ascii?Q?BhCkpaSDUdcReRhhPnkQEIlgMH2QOgwIUtxPZGIV2wiyE1yv/9/y1/BxWedM?=
 =?us-ascii?Q?+rb84Bs5WtlD4/Rk4vZmGDI5LRovzqO97cHUAJKt35N1ZgRgfjv1yoZexncl?=
 =?us-ascii?Q?B57QNvRGXYfOiNZaVFVJ9eeAfEAhX0chA3HA5s9+zNwewM4jeXhYTmFAKXYS?=
 =?us-ascii?Q?HQn2wDOHURUKrLS0630sqtj7SyLIsNb8ay9bmJOcgNVCTn8bVVl+b9oErc9z?=
 =?us-ascii?Q?S5jafeH4ugXhbtviwrn3QsLeq+Vt1tb1c3CEtZKgFaM8iNcpbuDHNKHr08/7?=
 =?us-ascii?Q?0NSTbPMhOlxBVaKCDmQJI163B0o7As+hT5VfitZZkpFoX/dHYVnT3ABOvDRX?=
 =?us-ascii?Q?Ycf8seC16dp3f7B3EPnXQ1tq1HMabMLS/0gs9oEyUZLNc2HTp2gdtEbenZU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b53869-705f-4a42-1c8e-08ddae83d7a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 16:19:03.8238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8462

From: Roman Kisel <romank@linux.microsoft.com> Sent: Tuesday, June 3, 2025 =
5:44 PM
>=20
> The confidential VMBus requires support for the both hypervisor
> facing SynIC and the paravisor one.
>=20
> Rename the functions that enable and disable SynIC with the
> hypervisor.

Add "No functional changes"?

>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/hv/channel_mgmt.c |  2 +-
>  drivers/hv/hv.c           | 11 ++++++-----
>  drivers/hv/hyperv_vmbus.h |  4 ++--
>  drivers/hv/vmbus_drv.c    |  6 +++---
>  4 files changed, 12 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 6f87220e2ca3..ca2fe10c110a 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -845,7 +845,7 @@ static void vmbus_wait_for_unload(void)
>  			/*
>  			 * In a CoCo VM the hyp_synic_message_page is not allocated
>  			 * in hv_synic_alloc(). Instead it is set/cleared in
> -			 * hv_synic_enable_regs() and hv_synic_disable_regs()
> +			 * hv_hyp_synic_enable_regs() and hv_hyp_synic_disable_regs()
>  			 * such that it is set only when the CPU is online. If
>  			 * not all present CPUs are online, the message page
>  			 * might be NULL, so skip such CPUs.
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 9a66656d89e0..2b561825089a 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -257,9 +257,10 @@ void hv_synic_free(void)
>  }
>=20
>  /*
> - * hv_synic_enable_regs - Initialize the Synthetic Interrupt Controller.
> + * hv_hyp_synic_enable_regs - Initialize the Synthetic Interrupt Control=
ler
> + * with the hypervisor.
>   */
> -void hv_synic_enable_regs(unsigned int cpu)
> +void hv_hyp_synic_enable_regs(unsigned int cpu)
>  {
>  	struct hv_per_cpu_context *hv_cpu =3D
>  		per_cpu_ptr(hv_context.cpu_context, cpu);
> @@ -325,14 +326,14 @@ void hv_synic_enable_regs(unsigned int cpu)
>=20
>  int hv_synic_init(unsigned int cpu)
>  {
> -	hv_synic_enable_regs(cpu);
> +	hv_hyp_synic_enable_regs(cpu);
>=20
>  	hv_stimer_legacy_init(cpu, VMBUS_MESSAGE_SINT);
>=20
>  	return 0;
>  }
>=20
> -void hv_synic_disable_regs(unsigned int cpu)
> +void hv_hyp_synic_disable_regs(unsigned int cpu)
>  {
>  	struct hv_per_cpu_context *hv_cpu =3D
>  		per_cpu_ptr(hv_context.cpu_context, cpu);
> @@ -515,7 +516,7 @@ int hv_synic_cleanup(unsigned int cpu)
>  always_cleanup:
>  	hv_stimer_legacy_cleanup(cpu);
>=20
> -	hv_synic_disable_regs(cpu);
> +	hv_hyp_synic_disable_regs(cpu);
>=20
>  	return ret;
>  }
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 9619edcf9f88..c1df611d1eb2 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -188,10 +188,10 @@ extern int hv_synic_alloc(void);
>=20
>  extern void hv_synic_free(void);
>=20
> -extern void hv_synic_enable_regs(unsigned int cpu);
> +extern void hv_hyp_synic_enable_regs(unsigned int cpu);
>  extern int hv_synic_init(unsigned int cpu);
>=20
> -extern void hv_synic_disable_regs(unsigned int cpu);
> +extern void hv_hyp_synic_disable_regs(unsigned int cpu);
>  extern int hv_synic_cleanup(unsigned int cpu);
>=20
>  /* Interface */
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 695b1ba7113c..f7e82a4fe133 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2809,7 +2809,7 @@ static void hv_crash_handler(struct pt_regs *regs)
>  	 */
>  	cpu =3D smp_processor_id();
>  	hv_stimer_cleanup(cpu);
> -	hv_synic_disable_regs(cpu);
> +	hv_hyp_synic_disable_regs(cpu);
>  };
>=20
>  static int hv_synic_suspend(void)
> @@ -2834,14 +2834,14 @@ static int hv_synic_suspend(void)
>  	 * interrupts-disabled context.
>  	 */
>=20
> -	hv_synic_disable_regs(0);
> +	hv_hyp_synic_disable_regs(0);
>=20
>  	return 0;
>  }
>=20
>  static void hv_synic_resume(void)
>  {
> -	hv_synic_enable_regs(0);
> +	hv_hyp_synic_enable_regs(0);
>=20
>  	/*
>  	 * Note: we don't need to call hv_stimer_init(0), because the timer
> --
> 2.43.0


