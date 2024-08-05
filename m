Return-Path: <linux-arch+bounces-5957-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C81E94738A
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 05:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E79231F21445
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 03:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0646113C820;
	Mon,  5 Aug 2024 03:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="djCesNAa"
X-Original-To: linux-arch@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010003.outbound.protection.outlook.com [52.103.7.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103AC1D540;
	Mon,  5 Aug 2024 03:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722826923; cv=fail; b=TBj2Hs7Pgf622W34La1+LEXyIhQpClqOS/Q2PLNZLAd1lZSjcjtyVWZ452ht5xor65Pftd9qDgdpQdhEc8osco8Sqddsfy0s2BYE3plprFTnn2xBUrH6FzHOB6jDVFMS/ZvvCSPB8hWO2m34fHqNMSl7mSsxWDnvZLai/yaIztM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722826923; c=relaxed/simple;
	bh=YM8yRnLLNWSnkuSFzi1XVvLTLzOv8U2L0ce2NlCkMf8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GnTlalyWHEepQJ/8mPaXc1N2DVCWqFst6psa58FK585Fu3QbQ8l9743knk3RhZXmY8xoorjX/zdJXWO7m+FeUFzNH6PyUG2qAXkxTXIA8w9f5ENL57FjqFRa0mJzRhOiFOcoMVLmwLsxa72y6745gqKR0RHl0MC8rqqZqm5uT44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=djCesNAa; arc=fail smtp.client-ip=52.103.7.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7hLrjQnXWC9eamLTmfP05sD04UQ5IQBcSTrF/CbBaD4gqR3JMB8ngWQDAX7FkEXBr4uVHWuFF5GNO5bxch9u89bClhWl/pcNkR69CYFr7U7zjD2/yi5Ti+WEIuZGN512SRX1Bxii62R8RPTnRgGHF6FezuLUZ7vz3g8xqskWKP8qsoMoTqYg/dMCGHwsoNw3V0V6P5Ao16h01HXBu5cadSKy3sWI5nAkKDAgVaOyI1rSamPvA87JdvjxHIxrqh8jTC0gY6QuVwWreSPWrLPZiymUPBlaVyB5T5L93PXRl4G/7QdXk6ZaCQAZpp1dRqLfwRhjvAZlQF7pRFf4vaZ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=of6gelj8stUlB2YdWIz6PA4VaRuyZtRB/nGSistvyww=;
 b=pYT30adQi5DhR/wX+YvFvCHYiNetUIten8Vjp2HC3iS50svm2KYbSt/0tWoQeZFSf0umIYZ0qy/H9qolbpEbMof9sESAltBGS2TQ4sDMR7xIjFjv5qHlJ/5ZFi+78hIdDU4Kgemd8udZ6eJlU8/0Awgb9+ld5qdB5aovbsA1RnTtz6d6LnipRscxAUd1badaGivZfCBmweXZXR35JTOCL/kCxUStoLaGHtKSNedlv8GglGm9qiYrSfs2N7+LK5YT9LPhrV/Xe2h2EXF3rBbqXap1nt2r50JBcOVYCMy/I26kcRYFZkTWopLrVQXyAljjEpXz97RU0k1UGKkUKH9h0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=of6gelj8stUlB2YdWIz6PA4VaRuyZtRB/nGSistvyww=;
 b=djCesNAaM9aBamUYPgSMFVzDtjF+MbBMwpJeEBUy/9WnwHM3c3OnbyEUQcfDMdWSjAtSYb2b6STFqv6gVJ7zu7o86AnBvCX5K2Pt1iQ0CnUGKX/asqHMPo83BWtGp4CJaUhr1Bv9LfAv/X7qe0acVHjxvcy1NA4txvCu6YO++Itq742jBbWoWrSlqu/NSszgdjr2+VdoF5vUHFClf6aJNy6De+0jap04lE+zrJd+dTrJcsYdtLYfCZUxdeSFrnw5qGRlaq82JFgDQrDNsZ9ZwBoY40TuFVwbsiTKF0KzgCYr/QPPxOlStNdswdkd1KanL7ehjK/AtEzoiETCQCwT6Q==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA0PR02MB9464.namprd02.prod.outlook.com (2603:10b6:208:408::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 03:01:58 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.7807.026; Mon, 5 Aug 2024
 03:01:58 +0000
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
Subject: RE: [PATCH v3 2/7] Drivers: hv: Enable VTL mode for arm64
Thread-Topic: [PATCH v3 2/7] Drivers: hv: Enable VTL mode for arm64
Thread-Index: AQHa36+bZ2NhttEXkUO+7UvkTiCvrrIXTMEQ
Date: Mon, 5 Aug 2024 03:01:58 +0000
Message-ID:
 <SN6PR02MB4157824AC8ECA000559F5160D4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240726225910.1912537-1-romank@linux.microsoft.com>
 <20240726225910.1912537-3-romank@linux.microsoft.com>
In-Reply-To: <20240726225910.1912537-3-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [B1CWFJjIlGIsmXNawDO/te9Mc4Y4U6XI]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA0PR02MB9464:EE_
x-ms-office365-filtering-correlation-id: 8b20a6dd-399c-4f16-75d8-08dcb4faf8b0
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799006|19110799003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 0ErEsFbEvXJWdi9ExfZsnbZm4M1d0MD1ydz6oqYipAJ/UQuEf/a0YFkopTRdo55vO/3vuZyP4oQ8Qd2TTIrGlD7s350IZv+Z2QKvgUMHtcFIyCdcYoTGV4AFKWl4Hky0U/QfntcWcUSIACxYsEQenNUruHOegkPp1JSe2JnJ5nxB2Q0h2NMtu4ToM4PvSLnv8pN1zJlHg9OVPVCWf76tkvrvyg3MLgakW7r5CYtO5d7wqFFUBU7PWUq6yOefL/a358ZyS1r80OxKed2ormdXFZpI1tu9J3AClRqVyeyZtPUxyZQ4bc74S400OuqaCVy+kCWx7o+9dtR0dHT6/VJ1xEZIHrCKrPBLurhJfmn9uc1Fp5v030kZgwwKs6GDOtfPFIFhUIg8vi1nxSeXBe4ytW58cyij27Ie3CxmqgF755Je25Lju7jLaB6Z1++lXg3AdISBryVPIOCuheuQv3Xw+1suBGE5IptlpQv2GDS5IT7qQ4gw+jSvxBoX1aQwfsGwZtaA15khzzG0oO79TgZKhALIHrEdNBT67JosZRWKXlCyOXIw90treHMSRhMClKWrnVZ4i+SJKc1+o2PRLCWWUGzIASrvgS80gDnLCX6FYh9GDUgVJX3dTSuhcEKaoXREZ7QLU8uJ0m9ggus/GxErbBdxVso6WBHo88Blg909ArIWmC1gPsX5waCGUj3QUwya
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?k+mjJbT5Sm9esZp87ykocvmKCr1oRqJ8sVB+CICB0gxt1Mw3+KsntiBVlcuD?=
 =?us-ascii?Q?xlpczromAlerimYPOiFpY1XQEsTWObhbsMsyiZ5Vna6xPu9KsDMdmKgQH8Wn?=
 =?us-ascii?Q?C3wdLm5E8/heVjR+BmFV2UUC/1EjW4u1zeN1mB9upCl+C3+P32cCH/U1LMiA?=
 =?us-ascii?Q?h/8SISnF+BzZbhm0JMTy1HFc7qcHpnkXrL/1zIH39Rv081R1VJljFnxdDzIC?=
 =?us-ascii?Q?ZHIVBNYuXJDeESAPm3qJXWn4OcJ3OK7aH+ZmPdVSRWeayAghdzH2nzgiEGXm?=
 =?us-ascii?Q?16OSRpLYkUVcRM/B+O5v7e3JyW6fDw7HjKj4sS5dBLbfFFbS3sCI4PQpkN6H?=
 =?us-ascii?Q?/Z5HhEW6FHwPP9UtuF5vxvSsaGFPBGktTk4IKM/6ungtykTKQPflIxWCfDgb?=
 =?us-ascii?Q?2MNbuclBMGGfqgKOzl+MNZXjBRsdhSdrw/SlLGF4oMKLj142nFea3ezrPU/x?=
 =?us-ascii?Q?X+DZBJioJuVk2XvDXV7GcMPDHL4CQAB9mve/kstNS5aG8giJnGMjGzXfof3A?=
 =?us-ascii?Q?MtDxgIFx2SNeJNtTCdWkwoKhSasM64cwnU9j5NHb5tU8KJAJ5fu3PyAQnFXl?=
 =?us-ascii?Q?ZpzXhQOHzglH8xkree5WfYB5lGBFSCSDQUMnNzT/IUpRvDx1vnIqwLBwZer+?=
 =?us-ascii?Q?b1yyfMCmId6prUTOdbskVQBVjSBErugqrPJqtK3FHRlAgOM9SwgdU9SG0JyB?=
 =?us-ascii?Q?qs0rpPHCV+EQhNS1JSMr4mGiM3ONsbpr2u3nUTaxn39URF4eTFZhDWcA7UXi?=
 =?us-ascii?Q?R0ETefcYDlWiq0TVngnSmDeyuiovAp+y/fwiWT0pw9+mYeqFQId+U1i8bwlK?=
 =?us-ascii?Q?nhjjRTsC1kcwCHC/NmORNlaamjo/kP14TPI6a9TQK9lvU3wTFsEKo70DY38g?=
 =?us-ascii?Q?NsnGJaHyC3jCQcQsNeNYPKd58QMhCgR8aBr37C/B3qBiwYR2XF2EZENR79rA?=
 =?us-ascii?Q?k6K+ze0346lX9hkw/YbCB9+AfG1SPN59Hsgmp459sx2pIUTyJdoKNNcp2OJN?=
 =?us-ascii?Q?ZMW+njVGQVo/33SX+8v1pkNEZxGaISaCALB+/zJBSO1rfbffv87FPVtGtl7O?=
 =?us-ascii?Q?IOW14jvxhPEvOv1LW0JSqFzndKXviQ9dUhzv8NME/gCQfp2HMqF5PXX3kVWt?=
 =?us-ascii?Q?J00/1x57NgIL9Y+BrLFdt8XHMyQS7AQa6DHFoj7in60RU0JOXWj9T/+DYXTm?=
 =?us-ascii?Q?c4hYQhfh5FN+GeIIGyyGngkKOcVfwRZsu/EIePbBWNwJXpXfkbZ6YtqvG1Q?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b20a6dd-399c-4f16-75d8-08dcb4faf8b0
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 03:01:58.6265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9464

From: Roman Kisel <romank@linux.microsoft.com> Sent: Friday, July 26, 2024 =
3:59 PM
>=20
> Kconfig dependencies for arm64 guests on Hyper-V require that be ACPI ena=
bled,
> and limit VTL mode to x86/x64. To enable VTL mode on arm64 as well, updat=
e the
> dependencies. Since VTL mode requires DeviceTree instead of ACPI, don't r=
equire
> arm64 guests on Hyper-V to have ACPI.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/hv/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 862c47b191af..a5cd1365e248 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -5,7 +5,7 @@ menu "Microsoft Hyper-V guest support"
>  config HYPERV
>  	tristate "Microsoft Hyper-V client drivers"
>  	depends on (X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
> -		|| (ACPI && ARM64 && !CPU_BIG_ENDIAN)
> +		|| (ARM64 && !CPU_BIG_ENDIAN)
>  	select PARAVIRT
>  	select X86_HV_CALLBACK_VECTOR if X86
>  	select OF_EARLY_FLATTREE if OF
> @@ -15,7 +15,7 @@ config HYPERV
>=20
>  config HYPERV_VTL_MODE
>  	bool "Enable Linux to boot in VTL context"
> -	depends on X86_64 && HYPERV
> +	depends on HYPERV
>  	depends on SMP
>  	default n
>  	help
> @@ -31,7 +31,7 @@ config HYPERV_VTL_MODE
>=20
>  	  Select this option to build a Linux kernel to run at a VTL other than
>  	  the normal VTL0, which currently is only VTL2.  This option
> -	  initializes the x86 platform for VTL2, and adds the ability to boot
> +	  initializes the kernel to run in VTL2, and adds the ability to boot
>  	  secondary CPUs directly into 64-bit context as required for VTLs othe=
r
>  	  than 0.  A kernel built with this option must run at VTL2, and will
>  	  not run as a normal guest.
> --
> 2.34.1
>=20

In v2 of this patch, I suggested [1] making a couple additional minor chang=
es
so that kernels built *without* HYPER_VTL_MODE would still require
ACPI.  Did that suggestion not work out?  If that's the case, I'm curious
about what goes wrong.

Michael

[1] https://lore.kernel.org/all/SN6PR02MB4157E15EFE263BBA3D8DFC51D4EC2@SN6P=
R02MB4157.namprd02.prod.outlook.com/

