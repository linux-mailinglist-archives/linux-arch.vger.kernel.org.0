Return-Path: <linux-arch+bounces-12939-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D96A8B114A1
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 01:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 231741CE4131
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 23:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EDE242D92;
	Thu, 24 Jul 2025 23:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mJamJBJF"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2108.outbound.protection.outlook.com [40.92.19.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBB3242D80;
	Thu, 24 Jul 2025 23:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753400096; cv=fail; b=A9RpbAqa5E96vB/RCOCoxqVVEhoFjERwUUN5q03rr6lSSXuz6O7/3YpQt0B7lblA9lXAY66uh/etApBgOoyQ5XgABL6tMlcj9zNxBNJYC72QNoSp9Ut6sgIZYxDhjjJoOj5ihPIljl21D85Ye3Wbtk5bqK/jvNDYAiurb/tdz7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753400096; c=relaxed/simple;
	bh=0690d39kNyoHS26h6f4iAn3aXCwmbHvHAliJOXV3qZ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dnpzm6Op2QSrBvYF0KOh0dRa0DfH1fMB4gJj1dq/Hh4NOMfzPRauDOjC6+eo85uLPInJg7ZUf0G/3DO0pQGeS4TnI5qK20/h78hu3dz0sImFG/c1u2jqXc1kntv7/rPRcM2F59oJKfJKgpnZhBeHjXn2sGOpHDtcSssU8BlfdFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mJamJBJF; arc=fail smtp.client-ip=40.92.19.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GU3av6DIcqOKSodluIKsAJ54X+1sGtJ847AtSO41Re+Jwc5lLI/3/3FfRrTocMnJD9zCcu3vG9f2yq8UlrK21WWiel/Jz1G8inxZBOjVbSVff4PrTclYJ6UjE3rkv9JtKCXBWY0R4VVkLBGGW08dROrjgvAr+CEhnUK4gyPjo1zn34CQAxj2+zYvp6xFLNf8AT9cTafoqNU+zEc1ZLewRDDncKMiq+N63jO1r+zjeLQsWh1kTPqnwcBy4ElCKdUo9NHtC+HMkmfsfy8uvMxmUqmroBu6Da1KDVeXhzmMgMsAY2H8SEQLGjr9l5fl1XNXT5RPeoUABX2lMzEqZFOjlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=km1mETgsx0C3AMCJEfax067Bt0Moo/txWYU2Ndcs4HU=;
 b=GpfIaqJNG+cs8vZFTiY3eTVpZs13F+aVIxoP9JbHiuJLpa+sYtqq7CMKLdh3eKoYruEcyuFv8IK7RT4fXK8gJu1DX/42TwtBR7H4btZ+Eam+OMRD1YWH8yQbELOgddIX438cjR169AYRB7M4vym4V0gvON++mw7Z99FM2OEPYNkoDrzVczNWvpn3mI9ajNolZ1r/eUBePk7e5RNJ0R/Lnzjs2hGUlVrQLXiLvSpRkTyBpqaVg+WMfbX5XFY8SGKjKWfotBDfuqRC4pM0yquIpqQn4epksN3KUtDc7o4elI2FtffSlSoSia3eKbR7XLlSpv7jCyTrPrMCzJfhkuXCNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=km1mETgsx0C3AMCJEfax067Bt0Moo/txWYU2Ndcs4HU=;
 b=mJamJBJFlFe5INXO+wlvIpe5f8ko9xpmAaCZsm/JR4EQjBhngqrt92GN5OuTgsV93WCD1habvxmtYXMDrlgPS7vrChM/kL6gx+nwyplkOWtRzuQGVWHCpoEZTK2rPy4azs9KpY/qgqoS8dRLb8bps462/yfNcbYNPfliGOmcJX9rSlWupcj3/bWSlOTHrWn3tx2xa9Qh5cjyN1ZhXrZgDaeKVZ83X9KsAuZMXJfs5mh76Qiigs0YZCa599i/8K2Log3D10P14dA4PI5fvykxduGFgNXBUos/DkoUsADr/w00EgCyQVD470uEBh8plK2lhbnFemN7bjL2SwrTfe+KCQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS0PR02MB9498.namprd02.prod.outlook.com (2603:10b6:8:df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 23:34:52 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 23:34:52 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Tianyu Lan <ltykernel@gmail.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "arnd@arndb.de"
	<arnd@arndb.de>, "Neeraj.Upadhyay@amd.com" <Neeraj.Upadhyay@amd.com>
CC: Tianyu Lan <tiala@microsoft.com>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH V3 3/4] x86/Hyper-V: Don't use auto-eoi when Secure
 AVIC is available
Thread-Topic: [RFC PATCH V3 3/4] x86/Hyper-V: Don't use auto-eoi when Secure
 AVIC is available
Thread-Index: AQHb/ASZZn/KY6vueUCTlNnz1sbC0LRB3x3w
Date: Thu, 24 Jul 2025 23:34:52 +0000
Message-ID:
 <SN6PR02MB4157FC3B69C9E6FB6884CE99D45EA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250723190308.5945-1-ltykernel@gmail.com>
 <20250723190308.5945-4-ltykernel@gmail.com>
In-Reply-To: <20250723190308.5945-4-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS0PR02MB9498:EE_
x-ms-office365-filtering-correlation-id: 7c773cc5-0e08-427c-ae0e-08ddcb0ab03c
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799012|8060799015|8062599012|15080799012|440099028|40105399003|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/zOlMw55teZcQSu121T84yztcBPALcVLwY9NJ26askCMpX2zXiKwlgI9uCHg?=
 =?us-ascii?Q?10RPLs/nHQSSOKdUwRo7UEB3obudfvl7P1nFtEE8HkuIC4isIClbhLp5UTpB?=
 =?us-ascii?Q?rNj7+3ta8ZHQMQL+qk1gdYTB4BXJQ61U9ue2Js2gFX3H0O7ptjyPP/1oe4Ny?=
 =?us-ascii?Q?aEVq79yyyclNKDpv/UQ+EY9VsdrzLCLF8qHde+HeDN9Em141cjgipr4+AVRL?=
 =?us-ascii?Q?J736glcTwP1HNj8SvtClBKV4YDN4sKmWtzCq8bDfmSHsawrUc0XKrKT4qLml?=
 =?us-ascii?Q?wFPKDRJKLJaeytjbGXBSp3vJh5ymxDyKvz+VCx7GT5LSORrisUs8IG2c9rNL?=
 =?us-ascii?Q?VP1W4t6eevo4VYZfX+Tt/aCAePNk1NZ2F8IslPMu58LdqlQFKrTtNq3e9hB/?=
 =?us-ascii?Q?x8JGY5S10tSAwCkUxPgTerf0byAOVKKb7xbg4KLUZg0KGOpseY7QwONkXlqP?=
 =?us-ascii?Q?4YMKn+0RPjxsudB6sI3QfsjZLtgNgT1zkQzqgnXVASW57GIE5ENcyLbbjEC7?=
 =?us-ascii?Q?A5JqUOIE40RxpTBAaqSFwtsxnJyvale1cm+jAvvGEhrV3xevilxg0+5ltnA0?=
 =?us-ascii?Q?l5xk5iLIBgsjR+LgyASEEOfo9l/dH/0Y91TJ32UD9OlcPAecj56aekjQWpFh?=
 =?us-ascii?Q?MzjsXjbfLyRwydGW48O5byq18f/dcLsTzO8m1GuACFwRCuUmzOgY9Egrhc3R?=
 =?us-ascii?Q?banZcvxlUxx5QeCEXl+TQCqf/zkBA6STJvSM87Rp+qaxGfKfn3xtUeVZLWEQ?=
 =?us-ascii?Q?v04Sfu4PCveCgw89J0aCzxB041mILYR59g7vH14B8KkQGjKhHqMpc3MdAXFl?=
 =?us-ascii?Q?04kzH474AHHb+eg6zDnHY61DC6JWQlUkuftARLvVxLZqrq0osH5OyWHmGpfU?=
 =?us-ascii?Q?DQ08AK2Xq+w2SQau4364t53gAFdHTN4Ha/LSfYfW8g2FQKKCsAKkEHMudJwp?=
 =?us-ascii?Q?QiBamewAYMowFuRo7TpPtf8xs7g+4GdGropUAtZRIXbqrQsEM32VRudp1wt/?=
 =?us-ascii?Q?YTjXXH+a7z5KIKNcE90GF9rSorBPGd5o9xS7H9csdFdDy52PKn1P3eBsYMox?=
 =?us-ascii?Q?YMfdNmb5B1ibIL9lTcQFAoFCaNqS0u7ZJRX4GaSZT70RroNsRDo3W4rMJOJl?=
 =?us-ascii?Q?GRUGqg1912Gd?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?V77G4KFO2C4CavSbckuDvIEV4Z+Lc62ErjtH4CGtFB/pPkX6GzY81ZZwX6mZ?=
 =?us-ascii?Q?nvm3erRav2WxXobS0mPImVZz9DCZzy1g0jp2bgIeOxNgWrympDvCPMpcvAGk?=
 =?us-ascii?Q?YkhU+jpAzBSxi+vtj0yogyHByeFdGWqDz7YevM1T8cbHM7fx7/y5FG8csh+m?=
 =?us-ascii?Q?qlza0223WYbH7F4wwNGb/Jnd9waBUw7pPV0p2hbWeZ8tAeUgU31UnujsNATr?=
 =?us-ascii?Q?kfSl0CplHuj/k3vweMruDqOtyuWnLwNN0M36LbdzUji3ESglYXLNuISAacr+?=
 =?us-ascii?Q?OULRH9EBpGSENDcyW99Sv/1hqkERx2nvMCN2zahHh1kCm7QLdcHEdJiwq3PX?=
 =?us-ascii?Q?HlkH1Q5T35fOxPnT1soPIyOm1UYrzkfzmszJO5xlNoukWXOcLXKQ0prYgFRi?=
 =?us-ascii?Q?iHNoq6Cbxg/P+oeLnafGsqextnBhAiXzCB3UAPBrHc+7Hi4497xUMXMCo0/2?=
 =?us-ascii?Q?gCzYMwfOEWcR+QhQK4AExJGWtnAKNb5g00PRQeDa+kwyu3OQlerdv+DgmJT0?=
 =?us-ascii?Q?8jbKSMxJVOgwFeSW9dK69YPvRlDHLsaO0w5J24NzvJDpTHE8kQNcVA2O9MKC?=
 =?us-ascii?Q?LNv07V3CEOPP00/kmWzZb2b37dixtipObXV8D0bhynZNpjtZ5OAfr7gUI2cn?=
 =?us-ascii?Q?9oovJs2lkgJ9gdlGpXVFLEpBK3cIrqQpHwwVTrn+tvmNEpN/gzRqLCmoWIaH?=
 =?us-ascii?Q?obaeuvNNuHPKXtzpEz1k+XHshZCuxnp0iKXXpTqyRTMTRVxiPu9XS0/Xr9cn?=
 =?us-ascii?Q?Qerl+oGD69fS51Vnl/Rucv6vR6gJARzcDsdyIBXqVewGfFPZ6dBOBke/LcSC?=
 =?us-ascii?Q?bOYOANA0DiXjinRQ1xTQia9rU+bvVX7eXf9TxI0HlVKijArfiAvcToj/1gPD?=
 =?us-ascii?Q?h111g8mvP89/hL5hENzLPdG0SRoNzyOacQytfFRaThv7dQbwi8XYMfxCCuae?=
 =?us-ascii?Q?6Ic7YfUrI5cxrwe+ljPl50rcy2DTPSIxw9SDENnDepAO8F2fQFI+REho/9WR?=
 =?us-ascii?Q?aFOikitE92jPGmWAb8mci89BkoibeOzNsvNSU41gy6VzSiLbi9dfrDZXRuyf?=
 =?us-ascii?Q?ADx8QvweTH6MVLbri+EJXOyzUF8wVh03FcSY0uCmWi/lHJ0aEY9/tVmIqydH?=
 =?us-ascii?Q?mFmXIAR3SLU+be/p4mBtSY4m+NiD1KbhNJTn3btzwnEWgMybROug5v0v734v?=
 =?us-ascii?Q?ohd3OXJjJGB/PaizCRvc6yIytWAoicv8zp8ACbCTzcLyYkI0KE5NFIaF094?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c773cc5-0e08-427c-ae0e-08ddcb0ab03c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 23:34:52.3244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9498

From: Tianyu Lan <ltykernel@gmail.com> Sent: Wednesday, July 23, 2025 12:03=
 PM
>=20

I'm nit-picking, but the patch Subject: line prefix should be "x86/hyperv:"
for consistency with past patches. Note that there's no capitalization
or dash. I know not everyone is consistent on this if you look at the git l=
og
for mshyperv.c, but I try to flag it and encourage consistency.

> Hyper-V doesn't support auto-eoi with Secure AVIC.
> So set the HV_DEPRECATING_AEOI_RECOMMENDED flag
> to force writing the EIO register after handling an interrupt.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index c78f860419d6..8f029650f16c 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -463,6 +463,8 @@ static void __init ms_hyperv_init_platform(void)
>  		 ms_hyperv.max_vp_index, ms_hyperv.max_lp_index);
>=20
>  	hv_identify_partition_type();
> +	if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
> +		ms_hyperv.hints |=3D HV_DEPRECATING_AEOI_RECOMMENDED;
>=20
>  	if (ms_hyperv.hints & HV_X64_HYPERV_NESTED) {
>  		hv_nested =3D true;
> --
> 2.25.1
>=20


