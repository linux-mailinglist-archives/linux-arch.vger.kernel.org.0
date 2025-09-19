Return-Path: <linux-arch+bounces-13698-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA22AB8B1C0
	for <lists+linux-arch@lfdr.de>; Fri, 19 Sep 2025 21:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E52A80B76
	for <lists+linux-arch@lfdr.de>; Fri, 19 Sep 2025 19:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F662BD586;
	Fri, 19 Sep 2025 19:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ipDocrk5"
X-Original-To: linux-arch@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012054.outbound.protection.outlook.com [52.103.10.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACA323E346;
	Fri, 19 Sep 2025 19:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758311307; cv=fail; b=abMyT3CvCoF7roC3CbyQwaCFb1K65+rAshW3QpLotLO+JH5/tlpXVHFJE57mlrl4IhOlKLpk9sRogHP+HxPvrLfNdw4DfvRVmFBFsuSuKkxvm0ejBwZLXh7TYV2RgBGpHUXoGQuythtyuu2sQ/jTJE74mXYc42EDLNMteFfQ6RE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758311307; c=relaxed/simple;
	bh=dW08FHnMAyxJ+XKTdM+fSP8Xqx/y2SqhcHAbci10puM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R/F3giQfZZHBZ0wpUQnKX6bDQK0JogcR4vhbnidah8QZkTdPmFzuJrrHPmYpIoLGsk+oOYtpVyhs2boEPZr36PgmAv56rZTYTsBiuW/g4t/rIJcim6Fmxnb+ODS5kV/ClTkAzOwRoDiZ0edYwl7/0mrxMv2mAqKnwbx2+XP9rgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ipDocrk5; arc=fail smtp.client-ip=52.103.10.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aeHfIDxZ1W6ZwmGksCEsvZ7UutGnDwn38kW4mtzU8/4g3HBTjvLoLS4mr7rnpDUpCqbMKhv5Xp8av74SnMkPCgBF2RL3+fFREQt4Ew7HUjD1m8IG8C15SokrzJ2xRQir2u6v4TNWP5H1+7e3iGZmhoirnzZlE3znWvh/MXwoKtCWhX+KreIrTOPgL8/SP6kmhxDDlRAlJFwXKEw0toPtCJC3RBFhtzlJMNU/JMZVwnoU51Csld04iew7X4HshIkXYv1ZWBAiZ0daKTYz3IsSH8wwODcvmUQSwRKhsO5zXKYSu1ZVDiHwGFyFK+QETjbdnx5QaiiA1/xgfUpQsHzDsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OM2UJZ0HlLdAgIPMarMjB12bijbf+Mxi8aXmIBcENQc=;
 b=kMwdWQAvXBLXUijDgYrOUXdwyqnAIizd2IAshVxSK4aKp5gThtB8DDSODX2MgfV72gb5CjV/yPZUPYWCjNbT1VSgVnjrbKPxWc2IkjkFyy5xvOMk6E7Qalkhwn4dY0Uqg/3f1D4JiwnU4BLUbLQYo1rIfK0fsfy7eEq65DwnENdFB7z5r9BrbSUxd3YkZANuuQfT2wvFZxebACdL5oDNywSSubZSa7YrBVnPZYWdZvkaA8uxad4r2mZwBWCRHWt2DBf8zrgZ3E79EqJwBumhp8HnUYpGk8OTUJUt0bYSLO+Uxh1niHkZ54Se8bqzmvDpfbXBSIjR3yOzUp4dghA97g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OM2UJZ0HlLdAgIPMarMjB12bijbf+Mxi8aXmIBcENQc=;
 b=ipDocrk52Ktgf0wRzWUneaDuDfxRjyhBbKGHtyf2pBgS7JvNysNc90xpJa01NL6ewj282I/LB6Jab2ielDj+mYR0Jn4tpo4nG0UFMWOY6FAurlMR0yH6/gCLu6GHCE4pe/yQ/xyHoZPqjGEXbyo8TlLIJlKIWqpMRl4lkOjo/QJ1KOnFE69xdVgaF7+UefjYp6KuKW/f1RlsB16dZUZoaDhoyAmlABGDNjbG1ps3jFKWuiC0PuiQie8+j//iPSRxMVc0imtOGzcyvUHDoXjTJT7Wfd1EB/zw1NSRrrViGDWronHRGiDcu7ULHnJHqDsEFrSrVdVbNAFPvSAYVVObow==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA1PR02MB9017.namprd02.prod.outlook.com (2603:10b6:208:3ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 19:48:20 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 19:48:18 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Mukesh R <mrathor@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"arnd@arndb.de" <arnd@arndb.de>
Subject: RE: [PATCH v1 5/6] x86/hyperv: Implement hypervisor ram collection
 into vmcore
Thread-Topic: [PATCH v1 5/6] x86/hyperv: Implement hypervisor ram collection
 into vmcore
Thread-Index: AQHcIeeHwOAc5qTPekmo9sfTvV5JMLSTKvtggANxwICAApl2cIAAoT4AgAEaMfA=
Date: Fri, 19 Sep 2025 19:48:18 +0000
Message-ID:
 <SN6PR02MB41573A4D6C19105E21E1709DD411A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250910001009.2651481-1-mrathor@linux.microsoft.com>
 <20250910001009.2651481-6-mrathor@linux.microsoft.com>
 <SN6PR02MB4157CD8153650CC9D379A03DD415A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <87cab5ec-ab76-b1cf-4891-30314e5dace6@linux.microsoft.com>
 <SN6PR02MB4157AFD23F088FC243A24C17D416A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <58e4f6b3-6ae3-4bf4-3e1f-0981d6af91ea@linux.microsoft.com>
In-Reply-To: <58e4f6b3-6ae3-4bf4-3e1f-0981d6af91ea@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA1PR02MB9017:EE_
x-ms-office365-filtering-correlation-id: 47c11f42-b076-4e8b-329e-08ddf7b57b52
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|31061999003|13091999003|8062599012|15080799012|8060799015|41001999006|19110799012|440099028|40105399003|3412199025|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xB5ul8/M8JgMO/3VssFssBgHGObtnFpGf6kW/5/yjdDzyNMMu9vzReBYLGVO?=
 =?us-ascii?Q?jkf3GqOiy1f6QRTcEpNt4CRlEn+E3VQuX6U9cBIKayDI4X+CbDeI77rVX8C1?=
 =?us-ascii?Q?lHpNtAVIhTIyX1FG5QWAwbbNY4Uyk2mIk+M/WEBppqhlrxxtxNcmyea/jPJO?=
 =?us-ascii?Q?agy0w/1iLc2Yjvs1iBekYaSbvkkYUXiB40A4Wd5vHiQuvQsvylFXXw8PXaet?=
 =?us-ascii?Q?r2JFfpZjDHNhTMB1sq/CKRLGajJu7NYM+yl1AVXZ4AUROejU0VfD7HwnLtGn?=
 =?us-ascii?Q?8NFrXzqIWYNsvGvup14ceSxU2RVaUy9kKEBra9gyGwsAAg8GcrgXTEBHu2Fq?=
 =?us-ascii?Q?8cHlBG20OsYLuBSBbjFtqeBR4A+m6ofWAjyGSGePfmsXTnq53Ctg1qhp+egv?=
 =?us-ascii?Q?4Z+FNE65bDKXugOG62Ms5ItQolSUZbhd/WILPG6iz9cU0R3ug+fzIEwyuvxZ?=
 =?us-ascii?Q?3RKtKVV7jVa8BBnGWtREoIdj6PYg+48X4YWDtzMHp7Jjop6NDDiDK3iaLBJH?=
 =?us-ascii?Q?mnLrHaYkJ1h83NJEZ7JQB3jO96IvgPV7g65xYQQhKMKJRql0HKqLysrjMJLT?=
 =?us-ascii?Q?lDoAT58CLL1Roam2MtyRYeooI5xakHW2V9dWbVFeoS2WuWUfMAtKia0rj2D/?=
 =?us-ascii?Q?8V3ooJZcj9kx+dNSFUO/ZvnSP8MArxWVFmPvDlmWasBuajb8upkYzssoufHr?=
 =?us-ascii?Q?kpEdqV9hy/DZDslqmZ2O1UKIGg1cFeoMXWfgQ3HcuYJI1JTwIqMAEQHUu6zi?=
 =?us-ascii?Q?ceyHERqM8Zed2zCRete+tEoJ50ucshONqbVuP807CPOuDZm7cM2xz2I+deJv?=
 =?us-ascii?Q?QqiNw5MSKVOAiRSXfK8CwJ7ExVQNs78k6y0pWlZHeHTOU2VzVIrfvP+s7rey?=
 =?us-ascii?Q?3K1Yms4Uy8UzwP4iYhbvgG0G0l4zxZ6uorHO7yDQMaG2U6ujePRPbw/6hQOP?=
 =?us-ascii?Q?paY8o6ZvPaV1Dhx5zZFWn455Nmd89ykkw85iqPrOSjl+jcv2trOrqIEJ31sC?=
 =?us-ascii?Q?AiAwTvm23OqyuUl2arV3pEFKYfOkHHp3xIDvFv0tKSYv4g87swimWfImoBSU?=
 =?us-ascii?Q?2XB435rvbVuXu9crtM1w/mKSqoYMpFhy2nwcpnq2Z01QJV2BuZJsX4c/eg60?=
 =?us-ascii?Q?J1n4S6XY1yqwSJl3iOXK7/3Sw99kKgOsfOOcf7aQCqhOjtUtBlAJZw7ITP3H?=
 =?us-ascii?Q?X1UYb5CdwzMW7FzJa/JNjI4lczOoF/cBYWOS6+pakStSdB5Ki3y9K12qqZc?=
 =?us-ascii?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YsUb+BCpt2R49VEoOzbw2bv5EilukmUAvfdzkXwykM1Nly6yXm9ckuprTb8o?=
 =?us-ascii?Q?JBn/2IsRPW2LTmJEKw+mzQCiSaCdZdruvUhpq6G5pHPLvNDANsZ/sVNUJZ1e?=
 =?us-ascii?Q?/9ms3AI2tmFpt6pHy0vKdFckcToZY9QcLHIE39FlSjkiZgAEQbQVjem5tFlQ?=
 =?us-ascii?Q?hkA+FX10+ro+8IBpixQEjgovs8FNt9x6pd9ANQKW7BQnuGDSpOz9wIwJNMUP?=
 =?us-ascii?Q?Jekqhjz2IGWy279DdJuMxs0e6g4c8BB2tE7PcoBwQA8fokjqzNhic6/0DgIq?=
 =?us-ascii?Q?rR9Fqi5fKQGE2IzKihBB0ubYvQO7iFOQIZQqxxjUrNG7DPtBprFijjCSoDCc?=
 =?us-ascii?Q?FKLz62LPYdbiPqkn8RroDfrtM3vCl/jtvKcQ6Bz4YdBV6RZenh43ME/8oeF+?=
 =?us-ascii?Q?l49fHFnmglzmg4qYa+8lYmjddrACMOVeODt4D4BRNAFn8ykLEBiN9cGB4vps?=
 =?us-ascii?Q?myCt3P6lGuRvf8wUQwUuz0i7etB0AudVHDz85Fke+dZqSocZaZHHa/eQ+NA7?=
 =?us-ascii?Q?c0/4KPuqNb1zXLyx2t2ziUYBnnANokE/25EzEJAYwlVGTGnVfv4uYQ49tFPy?=
 =?us-ascii?Q?xTZzKiiV06MCUqNSds80axX0ACGbcYP3bZ7kv1cQrYjM7fexvL6d3UKxmmWj?=
 =?us-ascii?Q?N2eKyk0xzaLAbT/O2mYdN3gT28BaO2NKWaa/6/6K502cP0ZojCDVVMZXnT82?=
 =?us-ascii?Q?DQdf6PuSHSzDFAvLsuW49kA6Ieno1sagmez+G0dLk6biaUlEBBd/PtrALTPT?=
 =?us-ascii?Q?/2XSDWi0FGcunVn8oFUypUwwQtZNfCOsy6+qwFqKaYow/8+Ar2QllzMJf+Lf?=
 =?us-ascii?Q?CiDsoshwbgZnq9hMIbnUieYuwZj6PAj0EntSwSoA8w9C2sHZ7tfAcDtQ4Q8u?=
 =?us-ascii?Q?x9udyJBdc5pr2FpMX0/geJ4LNkTZI3qJoTErtNNFHbEoGDWIUXX9LlnShLeG?=
 =?us-ascii?Q?+x7tuHltIMMAmtz1XDtuAFNLj0wK0fjICvSGRbC8YiIfHtx5iqf2ijXTeAp0?=
 =?us-ascii?Q?4JaN5ZAByV4vSD4PDScAD91+8lwTmYK7RFaCqRt2OUXsB3VQSMqt6GuPA9/o?=
 =?us-ascii?Q?seoCAru3gI7ea40O1OYdiuMZDTvK98WH6qPcnEghIuuP3CVNTy71I/r0Sgut?=
 =?us-ascii?Q?PSVbaWu+p83ordwEl/VCcj5HsCywaz6zwbXi1w8MmcMnbkNKvTV0fJL7qAZq?=
 =?us-ascii?Q?ucEg1VvuMf1cmejvv8AbwadtYmY4Quu0nnV3Vw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c11f42-b076-4e8b-329e-08ddf7b57b52
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 19:48:18.6478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9017

From: Mukesh R <mrathor@linux.microsoft.com> Sent: Thursday, September 18, =
2025 7:32 PM
>=20
> On 9/18/25 16:53, Michael Kelley wrote:
> > From: Mukesh R <mrathor@linux.microsoft.com> Sent: Tuesday, September 1=
6, 2025 6:13 PM
> >>
> >> On 9/15/25 10:55, Michael Kelley wrote:
> >>> From: Mukesh Rathor <mrathor@linux.microsoft.com> Sent: Tuesday, Sept=
ember 9, 2025 5:10 PM

[snip]

> >>>> +
> >>>> +/*
> >>>> + * Common function for all cpus before devirtualization.
> >>>> + *
> >>>> + * Hypervisor crash: all cpus get here in nmi context.
> >>>> + * Linux crash: the panicing cpu gets here at base level, all other=
s in nmi
> >>>> + *		context. Note, panicing cpu may not be the bsp.
> >>>> + *
> >>>> + * The function is not inlined so it will show on the stack. It is =
named so
> >>>> + * because the crash cmd looks for certain well known function name=
s on the
> >>>> + * stack before looking into the cpu saved note in the elf section,=
 and
> >>>> + * that work is currently incomplete.
> >>>> + *
> >>>> + * Notes:
> >>>> + *  Hypervisor crash:
> >>>> + *    - the hypervisor is in a very restrictive mode at this point =
and any
> >>>> + *	vmexit it cannot handle would result in reboot. For example, con=
sole
> >>>> + *	output from here would result in synic ipi hcall, which would re=
sult
> >>>> + *	in reboot. So, no mumbo jumbo, just get to kexec as quickly as p=
ossible.
> >>>> + *
> >>>> + *  Devirtualization is supported from the bsp only.
> >>>> + */
> >>>> +static noinline __noclone void crash_nmi_callback(struct pt_regs *r=
egs)
> >>>> +{
> >>>> +	struct hv_input_disable_hyp_ex *input;
> >>>> +	u64 status;
> >>>> +	int msecs =3D 1000, ccpu =3D smp_processor_id();
> >>>> +
> >>>> +	if (ccpu =3D=3D 0) {
> >>>> +		/* crash_save_cpu() will be done in the kexec path */
> >>>> +		cpu_emergency_stop_pt();	/* disable performance trace */
> >>>> +		atomic_inc(&crash_cpus_wait);
> >>>> +	} else {
> >>>> +		crash_save_cpu(regs, ccpu);
> >>>> +		cpu_emergency_stop_pt();	/* disable performance trace */
> >>>> +		atomic_inc(&crash_cpus_wait);
> >>>> +		for (;;);			/* cause no vmexits */
> >>>> +	}
> >>>> +
> >>>> +	while (atomic_read(&crash_cpus_wait) < num_online_cpus() && msecs-=
-)
> >>>> +		mdelay(1);
> >>>> +
> >>>> +	stop_nmi();
> >>>> +	if (!hv_has_crashed)
> >>>> +		hv_notify_prepare_hyp();
> >>>> +
> >>>> +	if (crashing_cpu =3D=3D -1)
> >>>> +		crashing_cpu =3D ccpu;		/* crash cmd uses this */
> >>>
> >>> Could just be "crashing_cpu =3D 0" since only the BSP gets here.
> >>
> >> a code change request has been open for while to remove the requiremen=
t
> >> of bsp..
> >>
> >>>> +
> >>>> +	hv_hvcrash_ctxt_save();
> >>>> +	hv_mark_tss_not_busy();
> >>>> +	hv_crash_fixup_kernpt();
> >>>> +
> >>>> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> >>>> +	memset(input, 0, sizeof(*input));
> >>>> +	input->rip =3D trampoline_pa;	/* PA of hv_crash_asm32 */
> >>>> +	input->arg =3D devirt_cr3arg;	/* PA of trampoline page table L4 */
> >>>
> >>> Is this comment correct? Isn't it the PA of struct hv_crash_tramp_dat=
a?
> >>> And just for clarification, Hyper-V treats this "arg" value as opaque=
 and does
> >>> not access it. It only provides it in EDI when it invokes the trampol=
ine
> >>> function, right?
> >>
> >> comment is correct. cr3 always points to l4 (or l5 if 5 level page tab=
les).
> >
> > Yes, the comment matches the name of the "devirt_cr3arg" variable.
> > Unfortunately my previous comment was incomplete because the value
> > stored in the static variable "devirt_cr3arg" isn?t the address of an L=
4 page
> > table. It's not a CR3 value. The value stored in devirt_cr3arg is actua=
lly the
> > PA of struct hv_crash_tramp_data. The CR3 value is stored in the
> > tramp32_cr3 field (at offset 0) of that structure, so there's an additi=
onal level
> > of indirection. The (corrected) comment in the header to hv_crash_asm32=
()
> > describes EDI as containing "PA of struct hv_crash_tramp_data", which
> > ought to match what is described here. I'd say that "devirt_cr3arg" oug=
ht
> > to be renamed to "tramp_data_pa" or something else parallel to
> > "trampoline_pa".
>=20
> hyp needs trampoline cr3 for transition, we pass it as an arg. we piggy
> back extra information for ourselves needed in trampoline.S. so it's
> all good.
>=20

That's a pretty important "detail" that hasn't heretofore been mentioned.
It means the layout of struct hv_crash_tramp_data is not entirely at Linux'=
s
discretion. The tramp32_cr3 field must be first so the hypervisor finds it
where it expects it. Please add code comments describing that the
hypervisor uses the tramp32_cr3 field.

With this new information, I agree the code works. But the devirt_cr3arg
variable is still named incorrectly, and the "PA of trampoline page table L=
4"
comment is still incorrect. The value in "devirt_cr3arg" is the PA of a mem=
ory
location in the trampoline page that contains the devirt CR3 (which itself =
is
the PA of trampoline page table L4). The CR3 value is in the tramp32_cr3 fi=
eld
of struct hv_crash_tramp_data in the trampoline page. The CR3 value is
not in static variable devirt_cr3arg, which is why I object to the naming o=
f that
variable.

So rename devirt_cr3arg to devirt_cr3arg_pa. And the comment
becomes "PA of PA of trampoline page table L4", which is rather unwieldy, s=
o
could be shortened to "PA of devirt CR3 value" or something similar. You co=
uld
also use "PA of struct hv_crash_tramp_data" as the comment, as I suggested
previously.
=20
Michael

