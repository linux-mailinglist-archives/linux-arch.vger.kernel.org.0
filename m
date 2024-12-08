Return-Path: <linux-arch+bounces-9303-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE0C9E8344
	for <lists+linux-arch@lfdr.de>; Sun,  8 Dec 2024 04:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A8AB281A0F
	for <lists+linux-arch@lfdr.de>; Sun,  8 Dec 2024 03:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2652D15AF6;
	Sun,  8 Dec 2024 03:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="iXfjNvk5"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2066.outbound.protection.outlook.com [40.92.19.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B7B2595;
	Sun,  8 Dec 2024 03:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733626904; cv=fail; b=W0XsJXVa6RpUla78FnX2FsfcXpjdH9kZ1bAgo7ZzOBnx1+5Drw84nhQk4MfUH8+9eE2/H3I/p81uQ/q728l4/GqSrHBhuyif2n8sB0tMSLg7meA4rB5r1sPR3AzZejaqxe+QMAHTssmZZJP42GV8V6B3OlnsZlnLwWIyB9d3RTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733626904; c=relaxed/simple;
	bh=KrI0o++4qdoQ+k512gk8RxbpVJw1Ax1dqHiyqsMZCKI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Uq2susD+cOWHLOrxQD43rPg+fYbg4G2PMamf4v2bUWfosn5hepyNed/WCk6WReuC/TueDB/uDU3an1biezSsr7yle6oTJRy2fl4bbj+W7+cWh0G31XTdgNGAJIHTR7yxM5bNm+Z4s1u9ChEVEwBadQzalKPyKdusXxc2kDeou88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=iXfjNvk5; arc=fail smtp.client-ip=40.92.19.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTbvmMItKIKRG73wDf2S1PDxlLTHQfuqp37AIdznOOLETsnwFyXQbhQHO0CzWBGn7qOgEyOpLCnX6XNOx8XBjfHtyiksD0RHQxy/2dfuB3lQfaUmHG/6pGELoL3JHQeKPDdK6rdkapVOBukGZ4f6b74pSVbpZ2c7BA20BfpLK3AxTI4ZijQnCe9UFPzeE9ye0TCaBZs6uczqe9qnglWtSkqJTrHXWb0mDHnlDv5okE3FHQOOdiPn5K8UQbJteF0W9sd0DQmheLQIxHrrZDyOmwxlZOtukk+cPUwrAX9IfxC5RHvZe8TEU04ltbveBpO7y5X/yD2dH1fVnhTIh8lZSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMpB2zmwbtNHoCnj8KE12gin4kuY+riNAOeSYHAWEL0=;
 b=tapMNmkfK1BLW7AQ/FK29Dwk8/4dBtk0l35M8OR6qwcuj5tFF1hiPPl6pGzI1sXy2l29bvcD6VGRomt1I0NYRK39LTJs9hLexis2UXi56wi59/IoRlrJJIH2gmke+DCzR2Zh0x89jyaSVuxyi1X8AgCLvFVu3ZHIEFgtSywBrRTz2dnbwwiWdR17llHRHxX4yBRimCVGUFt68KO1aL2dmvkQ5HV7S5nDGhKICxayMNPktTWLBj6wXTafy8TIAtoDlOBQQh6ysLA1VFJSnkJ8umLEtWrlJqcQXxqhBoCQ4fSwJBdTmQPz6ogFX/bSyGDPs5eMnzyQ4cuD43VO2T81zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMpB2zmwbtNHoCnj8KE12gin4kuY+riNAOeSYHAWEL0=;
 b=iXfjNvk57BHkazlowtJQn5VlKtGP2TW2NmrSiFQ4J0gP8d2awOj3ICxBKeVgzFtuH+USWH1KHYcN4SV0pPlWZ9ML62r66rKMNLRTaBxYPDRIqTeJFNSxbon/8OagrjjWTreis3opcy+kucgTUo4LoDlU51gvoLl9BfLxWhFnGUY9JMiTqJckJ/HbOtaHtOVaJSAtu/2o1YCwZzGr5yBVcEvJ3bojyYBUrwrEKHh9fI+jKK00R3uf3VdvTuAiIMjaJP2nO1KWzR0DTaNvRHXr0QEqL3HXPiPwTZ99inIQ1dP76UdLIVFNbXG2lwMNA+VL2xOT+zNpiMb9Ecyj+0qoWw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB8485.namprd02.prod.outlook.com (2603:10b6:510:10e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Sun, 8 Dec
 2024 03:01:37 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8207.020; Sun, 8 Dec 2024
 03:01:37 +0000
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
Subject: RE: [PATCH 1/2] hyperv: Move hv_current_partition_id to arch-generic
 code
Thread-Topic: [PATCH 1/2] hyperv: Move hv_current_partition_id to arch-generic
 code
Thread-Index: AQHbSC1SlKeIbxTgOEeBI9kSVxnqxLLa+6tw
Date: Sun, 8 Dec 2024 03:01:37 +0000
Message-ID:
 <SN6PR02MB4157E39FBEFB18EB9A695EECD4332@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1733523707-15954-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1733523707-15954-2-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1733523707-15954-2-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB8485:EE_
x-ms-office365-filtering-correlation-id: e9eebfb9-7abe-4c1a-11db-08dd1734a1ad
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|8060799006|19110799003|8062599003|461199028|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UmKylziJvcpwPz7JFAn0K1uXqlPQeqb4ENlVxxM2JSHdk1XPuPgzjIo/SS3i?=
 =?us-ascii?Q?nRnvpiBMoqYCuFz1+Z2PbdLDagxSpwsIUpPCoq7QQno34zRJ0XVZyleg2RTW?=
 =?us-ascii?Q?+L2XKBro/MIRuKlYhrXG6wCzwZPZMNqPbQwf8OfN6vJDyOSEf5j00G/T3sDS?=
 =?us-ascii?Q?iz1J0xzIHEI9rPTZsyTE6JQBWiw4poOcBDWnRo6C7TopJC5oaf8iJlGhCc6c?=
 =?us-ascii?Q?Cdhz1nD7pXQ+hgjuqTYmuuuXoNRafN19RvAL0tulF6WYgBkUO/g+uUmbiqJD?=
 =?us-ascii?Q?Ru6k9VH6miycaPk9F/LgMMP4hD0yFRviGB1wBUZKxB226LTaBAtBQA0Vmu0s?=
 =?us-ascii?Q?ZwwGShzyzQzJNrSaWbMcun0DX2fRNI3insi6oVhSVikyPqqv3XSbb+jvvuPo?=
 =?us-ascii?Q?Kjaq7vFxTZOlZFNk2tY2NTkdtu3ZTaUQi893TbzlJf10WpzmJF4kKogzeeUh?=
 =?us-ascii?Q?TtopRmwLWNvb+/Bc3/xJZK4rI8GwjqYdhxPImizMM6zRV0Ncs0qOA/fLvYTr?=
 =?us-ascii?Q?/qFbuPTNKB/cBhw4cl+eS4ZOe2KE6zKVGZU1mq4UmG48BIluOKhO5FW0nRie?=
 =?us-ascii?Q?9RGi5VrW8rQo/8GnHg2So+jmzn40cZ3ZcGSjYc7+cyrcTkr5Q4CHTvKKQ1Ef?=
 =?us-ascii?Q?TlVu2vOOLKOhh8M3unSM/poggnkURDNWm6apWHahI9MpmHW1YB/4sIIUdVbU?=
 =?us-ascii?Q?cDJ/fDkhiIEBRfIV2fKex/yk4Tzw05dYWjY35C0qIZKQQPmdrpeqVkzoQNBm?=
 =?us-ascii?Q?KMmDiaYlXXxRJcgxgiLjLVydXZ8cLozNOZQRZnc4rp+KYFpNjwJpJIHeXmqO?=
 =?us-ascii?Q?neid7Lym1ZbPAUwc5kMAYsFuodUCHNQynVV/WaW0fOOITgxkM6Zo1X0Pl0gG?=
 =?us-ascii?Q?+ZJqVwmUg8g14uDXmSbs0654fIG1I6Fz6Hsi1+tgQ7y+S/x39Pwk8fozitGi?=
 =?us-ascii?Q?KI9BzqwKsJfojC7ecUOdk78012AWXVDmb1FLLcsIRcVLs6oOZOzW8CrldUSa?=
 =?us-ascii?Q?NeG1v7ar5UG7vy+sa0HhOKSiyg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?X+jOPJEFeyKFxQfdUsZlJXAsWCiT8wiq2kAdQ3DuuPv91IYwmTYw+ZKM9Mvl?=
 =?us-ascii?Q?622bPj+aRxu5KsnaxYSDwOB6aj7+Gq8jJ1qMyBUMIU1MxPeJ9OhJPHO4BNX/?=
 =?us-ascii?Q?efoW7T1pESS9U/6yYprFq0T/tm5wsQvVeXFvZTl7Jp+4phPIIDTHj8V4lOlP?=
 =?us-ascii?Q?D82tyt3RCz4mIF9kvH39xBZSyxKqehL8KZQNHE3vsT6L1sz+OSkgpeJgevO1?=
 =?us-ascii?Q?rcGONh3yjEPPdE4FiJvkfYkEKQreWMy9VdQZ8mErmTQaDmgxY6tcNKQZu2ia?=
 =?us-ascii?Q?i3tYd4mMLbLk0aSpSOo39o+sh85E/DHSlRgnXbtL44vy+IuxOo0jjGR8Pd+l?=
 =?us-ascii?Q?uXc+JSdbf3sFJZ1pa6fgmNRGZ3RMG4+eqBmX6p/PTUtYq7HYnXy70ApnsHiS?=
 =?us-ascii?Q?/YMONNUPrygukdBDdaLfhmlOFT7u4ibI2hxVswp70JAYgJRPqyKjTPht47q1?=
 =?us-ascii?Q?d0pxOBeNKgVjiQYtc3ZxPREmfU7LJ8kIbQfzaht0Ihv4v3N9F585xVvlZgDh?=
 =?us-ascii?Q?4SbEJozw715VS6qe2xgq2sth5PeWL+2jdJT+HSx89ZKmEsF81ryJU1K5G/qi?=
 =?us-ascii?Q?MwhMDdpSjpw6sh3Ssp2b/Rf7JbrA96bN7wJTUzu3e4gjTgCoORPzItgT5bM/?=
 =?us-ascii?Q?/AkzrPEB5UcJ3DSvm0Bp2hSIwYkaQh5MPFDgyyLtmxSrO56EAUATo2nesZih?=
 =?us-ascii?Q?6r9P9K+l7H2jWmNYwDbFZNBbSFK7Jguux7rGJ8gSWTwQXgIzzby3Ed/BgvXO?=
 =?us-ascii?Q?CYkmGlXRefv+SxeU7Z04cVsgWpkLFus6uoipAKl+M9KB+dXYmggTiVvWUCCp?=
 =?us-ascii?Q?bh3Zqhnh6PnAPIUMh5bXqnsbKg/Aw0mJLRyuWLBBJ2e8gEAqR9bBIfWoUC44?=
 =?us-ascii?Q?xymhGJawZ+FtfPFYm3uQYVLgD0hztQk7Gp2GUydBy65jChBqAqZoyma5EMTF?=
 =?us-ascii?Q?owehYlHXAD7SSEQyxvPzEC9HgQrdMLy10g3WyUiy2N2G6CDX9NQV/UGXi+oA?=
 =?us-ascii?Q?wcZeSkacsd3lpI8PGpWoMILCDRcEhth68oxxpFaFzv/9QpZYU4tQIuoaztg7?=
 =?us-ascii?Q?/0KFPQfIXdi4gqWHOP8mCbFZqONu0ZsbxRzxHCSYbjx3v8iLmSSvS+SkMtFM?=
 =?us-ascii?Q?BEn41874t3ktr3EoUT2BUI8OmMTJiJWoGpyhFtp+7JiW/AeCWMUTUbnuV9Lc?=
 =?us-ascii?Q?YFtfOgYY48m54XWy+xTtVDJGj0Hya14PHe9V4xOmEHqFb0BVovIfbKgq1hg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e9eebfb9-7abe-4c1a-11db-08dd1734a1ad
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2024 03:01:37.4566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8485

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, Decem=
ber 6, 2024 2:22 PM
>=20
> Make hv_current_partition_id available in both x86_64 and arm64.
> This feature isn't specific to x86_64 and will be needed by common
> code.
>=20
> While at it, replace the BUG()s with WARN()s. Failing to get the id
> need not crash the machine (although it is a very bad sign).
>=20
> Signed-off-by: Nuno Das Neves <nudasnev@microsoft.com>
> ---
>  arch/arm64/hyperv/mshyperv.c    |  3 +++
>  arch/x86/hyperv/hv_init.c       | 25 +------------------------
>  arch/x86/include/asm/mshyperv.h |  2 --
>  drivers/hv/hv_common.c          | 23 +++++++++++++++++++++++
>  include/asm-generic/mshyperv.h  |  2 ++
>  5 files changed, 29 insertions(+), 26 deletions(-)
>=20
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index b1a4de4eee29..5050e748d266 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -19,6 +19,9 @@
>=20
>  static bool hyperv_initialized;
>=20
> +u64 hv_current_partition_id =3D HV_PARTITION_ID_SELF;
> +EXPORT_SYMBOL_GPL(hv_current_partition_id);
> +

Instead of adding a definition of hv_current_partition_id on
the arm64 side, couldn't the definition on the x86 side in
hv_init.c be moved to hv_common.c (or maybe somewhere
else that is specific to running in the root partition, per my
comments in the cover letter), so there is only one definition
shared by both architectures?

>  int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
>  {
>  	hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION,
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 95eada2994e1..950f5ccdb9d9 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -35,7 +35,7 @@
>  #include <clocksource/hyperv_timer.h>
>  #include <linux/highmem.h>
>=20
> -u64 hv_current_partition_id =3D ~0ull;
> +u64 hv_current_partition_id =3D HV_PARTITION_ID_SELF;
>  EXPORT_SYMBOL_GPL(hv_current_partition_id);
>=20
>  void *hv_hypercall_pg;
> @@ -394,24 +394,6 @@ static void __init hv_stimer_setup_percpu_clockev(vo=
id)
>  		old_setup_percpu_clockev();
>  }
>=20
> -static void __init hv_get_partition_id(void)
> -{
> -	struct hv_get_partition_id *output_page;
> -	u64 status;
> -	unsigned long flags;
> -
> -	local_irq_save(flags);
> -	output_page =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> -	status =3D hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output_page);
> -	if (!hv_result_success(status)) {
> -		/* No point in proceeding if this failed */
> -		pr_err("Failed to get partition ID: %lld\n", status);
> -		BUG();
> -	}
> -	hv_current_partition_id =3D output_page->partition_id;
> -	local_irq_restore(flags);
> -}
> -
>  #if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
>  static u8 __init get_vtl(void)
>  {
> @@ -606,11 +588,6 @@ void __init hyperv_init(void)
>=20
>  	register_syscore_ops(&hv_syscore_ops);
>=20
> -	if (cpuid_ebx(HYPERV_CPUID_FEATURES) & HV_ACCESS_PARTITION_ID)
> -		hv_get_partition_id();
> -
> -	BUG_ON(hv_root_partition && hv_current_partition_id =3D=3D ~0ull);
> -
>  #ifdef CONFIG_PCI_MSI
>  	/*
>  	 * If we're running as root, we want to create our own PCI MSI domain.
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 5f0bc6a6d025..9eeca2a6d047 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -44,8 +44,6 @@ extern bool hyperv_paravisor_present;
>=20
>  extern void *hv_hypercall_pg;
>=20
> -extern u64 hv_current_partition_id;
> -
>  extern union hv_ghcb * __percpu *hv_ghcb_pg;
>=20
>  bool hv_isolation_type_snp(void);
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 7a35c82976e0..819bcfd2b149 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -278,11 +278,34 @@ static void hv_kmsg_dump_register(void)
>  	}
>  }
>=20
> +static void __init hv_get_partition_id(void)
> +{
> +	struct hv_get_partition_id *output_page;
> +	u64 status;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	output_page =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> +	status =3D hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output_page);
> +	if (!hv_result_success(status)) {
> +		local_irq_restore(flags);
> +		WARN(true, "Failed to get partition ID: %lld\n", status);
> +		return;
> +	}
> +	hv_current_partition_id =3D output_page->partition_id;
> +	local_irq_restore(flags);
> +}
> +
>  int __init hv_common_init(void)
>  {
>  	int i;
>  	union hv_hypervisor_version_info version;
>=20
> +	if (ms_hyperv.priv_high & HV_ACCESS_PARTITION_ID)
> +		hv_get_partition_id();

hv_get_partition_id() uses the hyperv_pcpu_output_arg, and at
this point, hyperv_pcpu_output_arg isn't set. That setup
is done later in hv_common_init().

> +
> +	WARN_ON(hv_root_partition && hv_current_partition_id =3D=3D HV_PARTITIO=
N_ID_SELF);
> +

Since the hypercall will fail cleanly if the calling VM doesn't
have the HV_ACCESS_PARTITION_ID privilege, could the
above be simplified to just this?

	if (hv_root_partition)
		hv_get_partition_id():

A non-root partition VM doesn't need to get the partition ID, while a
root partition should have the privilege. If the hypercall fails, there's
already a WARN, so there's no value in doing another WARN. Also if
the hypercall succeeds, it presumably returns a specific partitionID, not
HV_PARTITION_ID_SELF, so we know we have what we want.

There's already an "if (hv_root_partition)" statement for setting up
the hyperv_pcpu_output_arg. The call to hv_get_partition_id() could
go under that existing "if" *after* the hyperv_pcpu_output_arg is
set. :-)

Michael

>  	/* Get information about the Hyper-V host version */
>  	if (!hv_get_hypervisor_version(&version))
>  		pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index 8fe7aaab2599..8c4ff6e9aae7 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -60,6 +60,8 @@ struct ms_hyperv_info {
>  extern struct ms_hyperv_info ms_hyperv;
>  extern bool hv_nested;
>=20
> +extern u64 hv_current_partition_id;
> +
>  extern void * __percpu *hyperv_pcpu_input_arg;
>  extern void * __percpu *hyperv_pcpu_output_arg;
>=20
> --
> 2.34.1


