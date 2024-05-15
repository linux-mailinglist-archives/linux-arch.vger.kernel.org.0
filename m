Return-Path: <linux-arch+bounces-4422-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A188C6786
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 15:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03FE51C218C4
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 13:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418DD126F33;
	Wed, 15 May 2024 13:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FcmLRaxD"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2062.outbound.protection.outlook.com [40.92.23.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BE374407;
	Wed, 15 May 2024 13:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715780375; cv=fail; b=MES7EFNcTmHzOWvDPMFFR3uiSvHcjk7GQU07ku8cnhWIrLuwboTxzauFRtx8g7+r/pDlaSD2plcaNYAYnfHkjxxSN0irJKlpS/XqDDf4YVHfJyJ5LBzSEBPE+FrIKvYK7E6URHuELYSA94AAcRw8uHDPNjqbqu5Y1DVchR5ciS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715780375; c=relaxed/simple;
	bh=/y0wDufxejP41cALddHP+/QYQI8G09SD/cz4PbFbHqs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b1J1qDwO30yKLI+hHE2bxWoRlYzfMo/6KRFA9AeRksYC1XssUj82VcgxwlOs5DuhQiLBvYVhnMcucD9oDjTZMUPBSuq1AzoqFy5l4WGpEH0E6+BlQEEPnnXi6E2Zt3rbBaOAH5/+TRAF7JKQrhLquiKr6JehtdZ5wftvgbvVFnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FcmLRaxD; arc=fail smtp.client-ip=40.92.23.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqwjmZwi7ovC2MII451yT6PhppqSQJ7Wl/ZNoGcBMY5AZNv+TkCxUo5zT13IgO0TFkaTiKIXFXI8pkEDBVxn18QiacKfGTt1HaiQ2+S4aYvtr4momdMHOr1owuuNHnQ1NzJ0i4NqlEbj1+Ss9U0EXoTipWgzhAF3SOFHeletAryeTmhSIbq0OjatyPERjtyBsj28uNwlm+sTyNd1EKWGFm/7Vuhw4c7YTBDFTxuZOexra5AWzgwTClt2jupHQg0mikaBwpoLbc38ANy7uoX1e4sYBb8LRW2y/z/Z+9G9KpizdG7I8ssTYXsZrvgsn5IqEjG6bQ+AbMdhrlI1qvGPig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjkEUe8g+NJLsMfyRLshCucuVNiW8qsppnabSjxK1f0=;
 b=eXAQf+aVH079Ks1U3bMljwl2/PIMOAIsSw3hM2s7bX1oX816DpsrL40goQ9N2HMapODgMVAXnVEZeGTy0zm8k8UTibq2c6L3D+bnvEYhPU8icu773CZepMFm9tOXj16+Dfzbph7YlhfWPDHbgrqozpqvuqjM/nNikTsR/RyKDog0yhYcPx82Ps3XgURNrDmRX68/JKGUSgyBGsxDGFk89YRq2JJadApBemo7k5o9gC+F+bUod44R1OOBcaxhWqMp3n9A/7KTnWqqKI/44lAu6bTySnWHfr5jORm4uBWwwhr9NUPhPZIF9hOuPScwfseih46g29AQyoebexL7Uwdyuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjkEUe8g+NJLsMfyRLshCucuVNiW8qsppnabSjxK1f0=;
 b=FcmLRaxDfMXo8RAwg5+scHPX4bpUlvt4uVrt0c+iN0kwIsY5/GjkFitqosNOiL1GVLaf2OoLMVSicrQWjlgotyIGWiRcf+remEyogC1n+5pt5rCALmhVSDi+Paze2H/vedjz7TxP0+csIVOARJ3ZC2GyxDTcdyfA1NMPh4rn8Moj8kIS69QQfI7H1wzr82UkqryBzCI/2yhhMRUp+Q2Ntc6Gj2RLQlUeLkise94tIADWKp2zFhFvP80U0XQ4/49hxpALKCNtzHNUsptDDeKtqnSs7o4rXadwPnl42Ah4TddFVbwodwci822VdJdLIP8oFHYzbnm9kFth7+XHFXvsjg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB8465.namprd02.prod.outlook.com (2603:10b6:a03:3f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Wed, 15 May
 2024 13:39:27 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 13:39:27 +0000
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
CC: "ssengar@microsoft.com" <ssengar@microsoft.com>, "sunilmut@microsoft.com"
	<sunilmut@microsoft.com>, "vdso@hexbites.dev" <vdso@hexbites.dev>
Subject: RE: [PATCH v2 4/6] arm64/hyperv: Boot in a Virtual Trust Level
Thread-Topic: [PATCH v2 4/6] arm64/hyperv: Boot in a Virtual Trust Level
Thread-Index: AQHaplCUXamnIjdmx0+xkzDtTqaEOLGXkUyw
Date: Wed, 15 May 2024 13:39:27 +0000
Message-ID:
 <SN6PR02MB415778D73832B587A2758BD0D4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240514224508.212318-1-romank@linux.microsoft.com>
 <20240514224508.212318-5-romank@linux.microsoft.com>
In-Reply-To: <20240514224508.212318-5-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [5/owsNJv55iyx2TkjaEv2zQE53GhxZTM]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB8465:EE_
x-ms-office365-filtering-correlation-id: 326f3352-0ca5-4672-1f9f-08dc74e47119
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199019|102099023|3412199016|440099019;
x-microsoft-antispam-message-info:
 8ArvXz5fz+ZigIhBNRcFPYKfLBs9cb/5zw07FU+KhuVPT4f7nLC2bVXoBMd9qVj/DnCTI/uKuXiMMzDFCo3DyBo0AZZxUz4xYPRbKwHGn609ifmxn/jrYBge4H0Q/Exr5iWvZAz60Mhxv1SNnjaQ/AhGF5qWl94riWlqMiD8tfLMnFKQjpN26IXBJGxM1QZ52/cLhLsP6EVsoRN48XKQUbw1doSplyvCOAoWSBUcl9ZTRI7Np8A3n/CdMtSdkGQ9/dv+JYhcWTs5XtGZUmmF7IH1AT5y/am8VW/cgC/YTOu9HRw/+pGQNCpPsZiKVafAkLwaL8orLt267f7I2gWX6T/VYJ7s4+hczazl0PwS1lmGZMX7D0Z9JhIi6qHIaFRx/elIYntqymKrQZvyrSuQmdhlPkmR+GRccYanKh19OqveKU5qTa6PpWKmEv4uR5FtO3O7vZ0omW19ASbPiq40igx2hTkrkTzUYXtL+9uq2G4t1hQUASBeF2AKo3AXaSoGI/63iqN4gI8PmKym58D2A79nsj7IY/7K/+dEyVpstfb3eQiF9m9nQUUy0uTiZCJV
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?j4gCvWCN4n9cMAPJviCmnML3OCS2Jwimk1szV9CzGAjKSf3zEoJK2+Rqlsxf?=
 =?us-ascii?Q?7+DxkEo6jAlIWqT21YNaKklitzp7E6gNDot7JUonkkyPEumnNLqfMnPyEjZp?=
 =?us-ascii?Q?PFo9qdBCOQTumPHJVoSTzuYEpisfKagOSi9liSV6nsyLBgYT1UWAVbUIWSEZ?=
 =?us-ascii?Q?XkuW4SxgOIjxV1+wJl+95upUeABSGRP4sI5RwvaZGZvgHRzYW8xdFCVDVKzx?=
 =?us-ascii?Q?TjjdibtCLzNVXmZJNnOUaDtIEuSErYvSuzYrTdGYyWZzjSviRKaauJl6DFli?=
 =?us-ascii?Q?3QxxRBWeKJQsIxSghtv4umeV05vAeolTFOUBqyHP94HixG+RFtN9B4aMPhaY?=
 =?us-ascii?Q?n9KiVaFre/UY/iQD1Sq18moDFW7Sr7pokdEgCp2AR0Usa3hlyfbWxzSfSaLj?=
 =?us-ascii?Q?ZRwN+iRFEJg58DEm40/NVhPh4kOzu4gr8PT/y4yrcf0wmJxUB6zjzOySK3gy?=
 =?us-ascii?Q?X/3b0j3K2FEcJ1LxHGJM7G6PwAODqsjO10Q5m7/UzpKbzMRLRl2mTs6hPv+C?=
 =?us-ascii?Q?DF9j4fkxuvm/BtuhUS9kfdFKbiM50/05SqJdAWYeLWGLeQ8jM4zHkWjQuhdB?=
 =?us-ascii?Q?EeLr+zAAEaAV0avFaTyZf6gkbQTTfms7g4bIQpLk/R/+T8mlqPPD7+RPj5hk?=
 =?us-ascii?Q?BvvioE4XsqVqGv9rg/mK33LzkxuomkSMWqq5ZC+9F1tWy0oNzXWF72uX79SS?=
 =?us-ascii?Q?dAHxpEVLAt3KmTjpM4hLju8M/W+k1tmYoySMc26Yvx1TOQ3a3qIMpni5AwXs?=
 =?us-ascii?Q?ItmG4dO9dXlHd3k6TEvMIJIPAPEzRl9G2e1TEUXkihw28rigeXakxcJ8i12d?=
 =?us-ascii?Q?6CYivzvGgZ4Yvjz7iy6g26+AvbI0LrPruDKMJ2l2Vm4U0tBoZQ6wX9SfPQbF?=
 =?us-ascii?Q?COcvYCLCGFW3kRyB2Y0fZNV/OLoADjNJHhx9C+T7iSIZpvef3fi9re6BX8PS?=
 =?us-ascii?Q?EZJ2u6F+oYHQ7orYGi/7AvrOCdG/Efs2eJ8QZsvR4n+qnUYeQldE6Qmzhra3?=
 =?us-ascii?Q?5ozytF1nlds/41Zki9ezi/NnHtORkPxFyaa4IdJF2plWffWVtvZzwnlR4klC?=
 =?us-ascii?Q?rkYZlFAebajN69X2XrK4nJbuVSY4so3JvMUA5G2t3y3IJmi2Ov20aBbX+P+Q?=
 =?us-ascii?Q?/kF5VlNiBJbZfRbmV95ErP8Oxnnpt9qEgCn7eGqNk7kvTYZnAyyt17BIwqxb?=
 =?us-ascii?Q?w+BYloYp7SUakuleLfdZ0qI+xfU7idfWtxltjpkp7/w+jJT/Q8rdQuX6EJc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 326f3352-0ca5-4672-1f9f-08dc74e47119
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 13:39:27.8526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8465

From: Roman Kisel <romank@linux.microsoft.com> Sent: Tuesday, May 14, 2024 =
3:44 PM
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
>  arch/arm64/hyperv/hv_vtl.c        | 19 +++++++++++++++++++
>  arch/arm64/hyperv/mshyperv.c      |  6 ++++++
>  arch/arm64/include/asm/mshyperv.h |  8 ++++++++
>  arch/x86/hyperv/hv_vtl.c          |  2 +-
>  5 files changed, 35 insertions(+), 1 deletion(-)
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
> index 000000000000..9b44cc49594c
> --- /dev/null
> +++ b/arch/arm64/hyperv/hv_vtl.c
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023, Microsoft, Inc.
> + *
> + * Author : Roman Kisel <romank@linux.microsoft.com>
> + */
> +
> +#include <asm/mshyperv.h>
> +
> +void __init hv_vtl_init_platform(void)
> +{
> +	pr_info("Linux runs in Hyper-V Virtual Trust Level %d\n", ms_hyperv.vtl=
);
> +}
> +
> +int __init hv_vtl_early_init(void)
> +{
> +	return 0;
> +}
> +early_initcall(hv_vtl_early_init);
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index 208a3bcb9686..cbde483b167a 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -96,6 +96,12 @@ static int __init hyperv_init(void)
>  		return ret;
>  	}
>=20
> +	/* Find the VTL */
> +	ms_hyperv.vtl =3D get_vtl();
> +	if (ms_hyperv.vtl > 0) /* non default VTL */
> +		hv_vtl_early_init();

Since hv_vtl_early_init() doesn't do anything on arm64, is the above
and the empty implementation of hv_vtl_early_init() really needed?
I thought maybe a subsequent patch in this series would populate
hv_vtl_early_init() to do something, but I didn't see such.  I realize
the functions hv_vtl_init_platform() and hv_vtl_early_init() parallel
equivalent functions on x86, but I'd say drop hv_vtl_early_init() on
arm64 if it isn't needed.

Note too that the naming on the x86 side is arguably a bit messed
up. hv_vtl_init_platform() runs *before* hv_vtl_early_init().  But
typically in the Linux kernel, functions with "early init" in the name
run very early in boot, and that's not the case here.  hv_vtl_init_platform=
()
is actually the function that runs very early in boot, but its name is
set up to parallel ms_hyperv_init_platform(), which calls it.  On the
x86 side, I'd would argue for renaming hv_vtl_init_platform() to
hv_vtl_early_init(), and then hv_vtl_early_init() becomes hv_vtl_init().
But that's probably a separate patch.  Here on arm64, perhaps all
you need is hv_vtl_init().

Michael

> +
> +	hv_vtl_init_platform();
>  	ms_hyperv_late_init();
>=20
>  	hyperv_initialized =3D true;
> diff --git a/arch/arm64/include/asm/mshyperv.h
> b/arch/arm64/include/asm/mshyperv.h
> index a975e1a689dd..4a8ff6be389c 100644
> --- a/arch/arm64/include/asm/mshyperv.h
> +++ b/arch/arm64/include/asm/mshyperv.h
> @@ -49,6 +49,14 @@ static inline u64 hv_get_msr(unsigned int reg)
>  				ARM_SMCCC_OWNER_VENDOR_HYP,	\
>  				HV_SMCCC_FUNC_NUMBER)
>=20
> +#ifdef CONFIG_HYPERV_VTL_MODE
> +void __init hv_vtl_init_platform(void);
> +int __init hv_vtl_early_init(void);
> +#else
> +static inline void __init hv_vtl_init_platform(void) {}
> +static inline int __init hv_vtl_early_init(void) { return 0; }
> +#endif
> +
>  #include <asm-generic/mshyperv.h>
>=20
>  #endif
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 92bd5a55f093..ae3105375a12 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -19,7 +19,7 @@ static struct real_mode_header hv_vtl_real_mode_header;
>=20
>  void __init hv_vtl_init_platform(void)
>  {
> -	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
> +	pr_info("Linux runs in Hyper-V Virtual Trust Level %d\n", ms_hyperv.vtl=
);
>=20
>  	x86_platform.realmode_reserve =3D x86_init_noop;
>  	x86_platform.realmode_init =3D x86_init_noop;
> --
> 2.45.0
>=20


