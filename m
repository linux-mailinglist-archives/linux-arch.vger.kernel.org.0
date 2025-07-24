Return-Path: <linux-arch+bounces-12940-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 569C1B114A4
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 01:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 380DD1CE3D87
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 23:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6017D23FC54;
	Thu, 24 Jul 2025 23:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="sNhqj4hp"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2067.outbound.protection.outlook.com [40.92.19.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19955D8F0;
	Thu, 24 Jul 2025 23:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753400108; cv=fail; b=sn7YB/ozpcbJwE6qeTj4GoDs2zKeHIyBg/pGokAmNb3GSsd9FAHvqcs01M8t8wMfkyZZrpWB/i2GnW69uc//5VfGMG9wP+/koT9pl8KSHHkiqzs/IP4xNHS7lLPat3vFtHAgxSLEoj17biLF4iXA+9J/caHfX9+KZVLF33DPG1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753400108; c=relaxed/simple;
	bh=VAuYqBj0KJ+TB+cH0Gaql2ea6+hpMEYQm6yE8D0wHGE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o4N7CqCAdJ39GALv7y3eTw2sgIcAmGAVhbf09twYCIC+adkA75IjTVrtFWYkmVdXyvsQMg+qbOGKJYDLIl1Msn654S7SWaoiBNqm2EPQp/7huwT+2dNsKawXMeTpACv2ChRkkVZ9CgSzyuv5NSdehd9N5cr+GEfTTqlqEX7D52s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=sNhqj4hp; arc=fail smtp.client-ip=40.92.19.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDzxkggaEM82POzlqBm2w9hcCjE17/pCKxWXTlLAJM57WXgBEBGx3JSccK6XQR+zYiVnzdktFFxBoYwob6MCkgzPYAP+i/cQ1AvSQNyqlJZANZOAm8189sGef1jC6aJdSthjFLrciwRMEB6HxfoFQk7Ei1CHu9bfqDoqlWrqlvCiCCv++wps98P8267A1bWewpBftwkVVoEI4Do7ENd1m5ZvSdjhaBrRWVGh+GHRYD7YohiTbrxIQj8f2qo3LxEe/q2qZcPqSLbelT/RUkkfJu8i7ZWEoPLKCRfY3twtiwFagdnY2OkekCcC6FkMyHJr3WWEbfMvcCQC9aNHhKJFEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfImfGXnWxL1nCEXBxL/UcpqUHf3nftoYS5/RVBrxm8=;
 b=ghPhzt66oWfDJyFt231uVGji5EBMZYjiZTHksj62MolsEPzIwnmnisqtRUp0hnpfAIZnE6Rv7XCND6cjkxBc6ysV5SARtudSRGP9nVwowolucXTV9tnE3OKNyDlrVoYll+yzxAPr7F5kAtiKrktnS++Iq7dA+02DNzSBeRCmlVgM8z9YS2suFjP4vQemrYetJbUBh64WX4SldTevIs105OBmjuaoCCKSE3KBSiR9M+uDqGUtZSmSrRfMQfEeSr18uludZxndkqfsJU53+JA58KlzWAjlax9NQvbfhb6wvM5/H8odhmoccQ1nx/8vA4y2RsMCdyi5geqNaWkJh2EcZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfImfGXnWxL1nCEXBxL/UcpqUHf3nftoYS5/RVBrxm8=;
 b=sNhqj4hpgVl3O3gRGUz6p3Xo7b23YMu8uNgslpgRREpG4v54yp9anXgfNUcTdOx/tUxSMJr3Z3lQVZn4NSex6YWhh1XG2KLH5+a2qbxxtiIoQQRQWAlNZDupGGjJef+xeF77UUTUft6DztfJrqYikRNIA9qOhikdSE2AeQNlgN4vImdCDu7P3ICcqSjrF+15Qu4eCCQvLoRRkCcasNHfq+2ZfX6LkRXYDOPWVvZIJWe9ZT4vY/1tYTyPonYvPst1f4PQ+r8w6EtyCB1cSGysGXVceEkKV/DpTS2xn3Ldqwm861+x6069OroB+lmm7VYOhw2qhU+u5jktDZE3Ow2qhg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS0PR02MB9498.namprd02.prod.outlook.com (2603:10b6:8:df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 23:35:04 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 23:35:04 +0000
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
Subject: RE: [RFC PATCH V3 4/4] x86/hyperv: Allow Hyper-V to inject STIMER0
 interrupts
Thread-Topic: [RFC PATCH V3 4/4] x86/hyperv: Allow Hyper-V to inject STIMER0
 interrupts
Thread-Index: AQHb/ASg8tbpRbyKK0eIdlAzezyw37RB5Vsw
Date: Thu, 24 Jul 2025 23:35:04 +0000
Message-ID:
 <SN6PR02MB4157E36F3C23833A4C9F393AD45EA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250723190308.5945-1-ltykernel@gmail.com>
 <20250723190308.5945-5-ltykernel@gmail.com>
In-Reply-To: <20250723190308.5945-5-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS0PR02MB9498:EE_
x-ms-office365-filtering-correlation-id: 7a7fba1f-7948-4cf6-8bed-08ddcb0ab7b9
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799012|41001999006|8060799015|8062599012|15080799012|440099028|40105399003|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Lnc6YSl5+HOBLbnZLUEGZ9cp10+tckHBfo910X4DDW7RgIk8RxipZLjmmD7I?=
 =?us-ascii?Q?vCwM89C13Z2WIvfbnr3RHe6LD+JJqPz0Aw7ipzTtUdJdxGhd4MUfK4kJP1Mk?=
 =?us-ascii?Q?wlNmtoh6lRVm1ysIWYBj3NQLRL2R7Rp4HejfcUGkTjcI0c0H+iM5Ezen0AAP?=
 =?us-ascii?Q?8KvUJ3j7QuO6DZQMVKdR/oq17/3Brkq1uZOjHH9wnEs6WdUy4ReUgURA377S?=
 =?us-ascii?Q?35F1Fs/Uqb5qPnXVoI4VWDSv4uta92jTnuqgabB8zl5QunixCduvs2/RiAJa?=
 =?us-ascii?Q?6CAZVWCbxgSuf9SirWQzmp8klXL/fR/6x+TaynQ3Wd6tiEIJUXG8+59O2bVP?=
 =?us-ascii?Q?HFcwEpCy86caoyjlpYD1Ct9nBAsQJEdAdSExNJEGlMxvO2c3cMEEIPb7dMej?=
 =?us-ascii?Q?B9Ob2FxhoKFCTF79x8b9kOh0BhEec/5qi+WZeq8A+u6F00Ne//U6T9VkC55t?=
 =?us-ascii?Q?GnsrFlWob4d7qNPi9JCr34X/kYC3DjV0JT6T/Icyh1ZGVSFzUJ4ERB/310b5?=
 =?us-ascii?Q?9+Gzd38Gg15KO1dSvJxoRmUxzZ3ZJleg0uRN5FIhgmTvO++eibNJ+AV72YoA?=
 =?us-ascii?Q?hlz0kNjMnqLgAZz68iXUuHB2AM/Esu5XKKBMn0AlMOBZ5G6tufWObjP6+5MJ?=
 =?us-ascii?Q?9j57o5crioaftw8Tcdd4+qkLHM2Z7BIxeAkW2bdymyB3wSohish4puAPC0i8?=
 =?us-ascii?Q?HJijNuF2ji6e32ynDxRFASU2d/OMElL241PozcB3D0HkDOiah8Xt57eN6sfq?=
 =?us-ascii?Q?+QB21/jERloak0F3/gHJwkSziDuSz5JLrWs7SUns7FfAJc3AAybHYziO3cb6?=
 =?us-ascii?Q?dW4GygA8uo30ZX5s0TevuAtFGdf3b1Y8onNJS04+3IxxuXciI25Zf+r6Vw8C?=
 =?us-ascii?Q?RWk27Lb3mpNbllUfik6H3b3Ah9jabC8rzFkPNJARVnreNYZQdYaY3QVwy9nk?=
 =?us-ascii?Q?O2Uvj0/OQKDlY+kyNP9cerDBOO1fw/roQxmABTjRUayGwNEPCUD5HQD1Byj/?=
 =?us-ascii?Q?5vxVUn9fBKQeJ11ooGCmhp5ujh/3HQ9meWx8LRV7Wid/t7KCv5IS0X/x2txs?=
 =?us-ascii?Q?gRp4t4yrFVQoCGW4Ipt0OjoE9QdSogZPl9R2r0WenUDd7aPy0MZO/jmYQ10b?=
 =?us-ascii?Q?4WlRL6IbAOMcyHaPMe/vaaG3HW5DYJgQ6A=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gojwwOoJVmRVI3tHR4fnBJb3+odHRqQf+0kkuw26mtrUr31ISX/7iF7GIZpW?=
 =?us-ascii?Q?p6wkxoflN3+9MqqGc8kAkg4KIDNfWQ2ScnUOGBZXDeU8y0FkqDwp9aanYmDf?=
 =?us-ascii?Q?w+phACZ48LEIn7DnMP3P+b5j8re2Ws878Mrmz+GYMnWixiLoAngrh2qnyTEG?=
 =?us-ascii?Q?j1uxDmFOIt08CBI9bxyEI3W8eA2GZSS22tyf5+FNoz8JtDyVFmR5bCAAwiVU?=
 =?us-ascii?Q?uYUHvcfqSob6I7BwUM6P8ZvhgNwujFstJPghQC0+s3CL5du0UPK+om/Hnix4?=
 =?us-ascii?Q?bOUcBLTyW0fV/sE5jmVR0V8RyRidX1KiEtZga2RYidBSJVq7ao7ouL/rRzoj?=
 =?us-ascii?Q?S79ip8liWpTPGm1Gp3cjLzY/+TtITsoz/jaUe4b1X2Ii1EvPW9DSHaB6rNl6?=
 =?us-ascii?Q?ABTdtEGbFzwrlSygjnXvlqdk1SEcGASz30APdnMvMVCO57TfiMd0L8TigPx8?=
 =?us-ascii?Q?IJUo4pJsgq8CdAFnUUNiVuXq+p0C4DaynTMOHi1a94Dg9J/EUHtEv0Mq2CY3?=
 =?us-ascii?Q?WSUasuM4lPoN92yYbbtggvYB+7qZ3KmIvRaPyaDpneVZ6DjaauLB3tteK30J?=
 =?us-ascii?Q?HeM+inn5Azeo77orSm26zIGibk8kgf90RLo30V2VnPGopVU6rEn0uiH8VIKy?=
 =?us-ascii?Q?ZaSAGDsP5aeDZklMtK1haqjSZCqXUJ9zFcCAxyfwLQY74zVaU0DU84IFlhnV?=
 =?us-ascii?Q?0AtPA6o9ftWoFVrFSVx4dMXsyF3GAY31K5HmyTkh7YpRP2ukB23sSeyOFGph?=
 =?us-ascii?Q?HzIKaLjdIOUsrOlCpRUphJvKHuF3iGjnQGDFGrwYRQ1swq9g8iWfXo/at9a0?=
 =?us-ascii?Q?8DVS+Q+zmLKAR92m4/uLG9jgYG3IMwmQ0uhJcOJXnGv317GjHmd44zms6Smh?=
 =?us-ascii?Q?aiEzaR48boaVzf5UbBMva26NSYyzDCmqrEpx2dFQ49XdmfohJ/JgqjUgtaIr?=
 =?us-ascii?Q?a6RfiVVNi4y5glJbonoF+6EUlKLPe2KHhBbfUMSO0uc7IhmfpZMgfV0Ehhm1?=
 =?us-ascii?Q?ccxnJ5e/lrt7UtdfNn9lNtO1VY70mj23DZ7cIcuqifGJjupIz+yM+ApweHst?=
 =?us-ascii?Q?5roaEgPy/82ieBZjWs9zZ1Ncg74+I9CgEEwVwz7uqAE6/IPrJfrpVoiXB+gY?=
 =?us-ascii?Q?aUomOdiUJzKZ60sL4B1zZHBkkXvY8pvhgUL1sZo3V+svLw0Hw7UlImtpnL2N?=
 =?us-ascii?Q?s5Nu85z8/pKFefBgJVBDpQrg8y2usDFFZsJ/7z31FfpOX9Oy0R8cf5SSTCM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7fba1f-7948-4cf6-8bed-08ddcb0ab7b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 23:35:04.8860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9498

From: Tianyu Lan <ltykernel@gmail.com> Sent: Wednesday, July 23, 2025 12:03=
 PM
>=20
> When Secure AVIC is enabled, call Secure AVIC
> function to allow Hyper-V to inject STIMER0 interrupt.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 3d1d3547095a..591338162420 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -132,6 +132,10 @@ static int hv_cpu_init(unsigned int cpu)
>  		wrmsrq(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
>  	}
>=20
> +	/* Allow Hyper-V stimer vector to be injected from Hypervisor. */
> +	if (ms_hyperv.misc_features & HV_STIMER_DIRECT_MODE_AVAILABLE)
> +		apic_update_vector(cpu, HYPERV_STIMER0_VECTOR, true);
> +
>  	return hyperv_init_ghcb();
>  }
>=20
> @@ -239,6 +243,9 @@ static int hv_cpu_die(unsigned int cpu)
>  		*ghcb_va =3D NULL;
>  	}
>=20
> +	if (ms_hyperv.misc_features & HV_STIMER_DIRECT_MODE_AVAILABLE)
> +		apic_update_vector(cpu, HYPERV_STIMER0_VECTOR, false);
> +
>  	hv_common_cpu_die(cpu);
>=20
>  	if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
> --
> 2.25.1
>=20

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


