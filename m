Return-Path: <linux-arch+bounces-10233-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 678A7A3CD38
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 00:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBD133B80DC
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 23:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BED825B664;
	Wed, 19 Feb 2025 23:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="RrH3FqG6"
X-Original-To: linux-arch@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010006.outbound.protection.outlook.com [52.103.7.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AE32417C3;
	Wed, 19 Feb 2025 23:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740006887; cv=fail; b=mjBShtnM81C3VY4zKna3XbgmU0/Ywln5jiJwckOHruLl5FWL9Z+Bu0lf+H1WFldSFqYsuRiJ+uDreanz/GdCNtDYmcEQ1RZL2lGYTDJMdjpy4y2o+k/8q4uxPS+4ybmup1Paba7W756z/SfRDff3xARDTPS7+Dk5tN/eghPISp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740006887; c=relaxed/simple;
	bh=pX8JDO8783b4wtDGMHJlv2wfgYhs/BXgpUeMHqypXl4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AqMJJZUVX3fZD+2AcN6ixCX2+6tXVO0qEMGs6t5an6B272e0HpOcQfKp2VUv2S4JD2jHJFRwp2Hl4TO7mdsdv1dfZOppXKgMadFsOkPdxvW0v4yA2qnErcBjlFoEIkr9OUmrbwrfMryvfeerdW0YQHqs3+AxaKW/E+jEk+/xexc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=RrH3FqG6; arc=fail smtp.client-ip=52.103.7.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xmYO3e9+twGRbrchZfFF9e1Em9Qjy5C6OZsHoRbEGgODoYjOjS9h+nj6gP99VbXKkvHRAFjQrlsIU0UKKWNR9OqeRo4HttYgxIRiGkxlkXAU+MRCVnSJvXsqSHpwElfMGxaGkEtthvhomBb9kSt/G/RL3GAKXRGWKNmpQpq4e3rybLLzEMH+WOET+nU1emU4eVrQVbzgv9rN93O5HLvQx1DLonWujRH5F1lIbexPsCM492H5xWyosjdiyetw1j8pmGF2/n6qAyktp56NJFzWwAMHBxbS9EGxhN6HEIk46tEf0QNjuFhjdoQ0T5/uxQgEUyI/RZnQ+gDdWLtxdWwkfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLRcIAw4fWE8r/McKVAXVdimJmtOR5MwStBP63aI8CU=;
 b=VvralBtFaQKhFKsAtazj901twCQ9eSFi8xofCBkfW9Lt9myuc33Z0HlmS/nEtMiOP05UgxgFXBC1b/q4/R3z0Lo1BP2kWzoi3raA/6Izdo/Swx0FGdzwL33Ql+LLVejaCx8x3VOpG14lXTwPlRrnuzl7EJxTyQoui2VScpF9lXtZv48+E4YaoF6Q9vRpyQKRJmTgHSEMKUvRcwfr/herpcEYCW+bz9zmm78pfpzFAORcKnTYT8xhZQiyQVS3fbEBus28JZIQJyShw8N8jGzmYxAX7F4Llqpp1aabICONVVq2d2deS+3KKETACRIgOqwokjm1EaMQGafraGqxJ7XWJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLRcIAw4fWE8r/McKVAXVdimJmtOR5MwStBP63aI8CU=;
 b=RrH3FqG6brm9bXdL3c4W588A63z/4r5a8bEu6np2kiUC42RLCXYN7wLMHwmOkvbhhkwYMAFn4d89PH0Xag9zmaCkuk+XpWCuBcEPtYpm6ZRmOIP0hIso+rVDjd8k21bUiQId3lZo6OxQbVjSoMLqblGgjtMhMt320tYCQQQZWOyp12fnycnF2khgO/2PVyDBgCqlHS906GcSqkDExad5kIj9YmHkUSFYmbelfY0zXBoZ45Etk+nN6YTjU5aSxat1M/Gnb9YdXhXTefp/CGLeyX9/kwDzRJ7wdVCFJvfZI83/PHORDD5r0Tm92RECOu+D4CmADcfubXnS601LMPFy7w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM4PR02MB9192.namprd02.prod.outlook.com (2603:10b6:8:108::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Wed, 19 Feb
 2025 23:14:43 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 23:14:43 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "will@kernel.org" <will@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "benhill@microsoft.com" <benhill@microsoft.com>, "bperkins@microsoft.com"
	<bperkins@microsoft.com>, "sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v4 2/6] Drivers: hv: Enable VTL mode for arm64
Thread-Topic: [PATCH hyperv-next v4 2/6] Drivers: hv: Enable VTL mode for
 arm64
Thread-Index: AQHbfO+lJFjHltF1pka2zhJ+RNLtn7NPKR/g
Date: Wed, 19 Feb 2025 23:14:42 +0000
Message-ID:
 <SN6PR02MB4157EFEE74BD71B6392502A0D4C52@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250212014321.1108840-1-romank@linux.microsoft.com>
 <20250212014321.1108840-3-romank@linux.microsoft.com>
In-Reply-To: <20250212014321.1108840-3-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM4PR02MB9192:EE_
x-ms-office365-filtering-correlation-id: ca7df768-1de1-48a7-bff9-08dd513b3161
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|19110799003|461199028|8060799006|15080799006|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pGxawtngTWksMY9Rb4LM5mQRHhRx1ZbLSsTo0S2hun8IYhp5WABC0eM6bgXb?=
 =?us-ascii?Q?XDYQ4IOjzdxYoLApT/464bT9abrwMBit8/jXSidPTMhdI7QpqyUPrMAPuqvW?=
 =?us-ascii?Q?+eCwVPJ4KNeVIPW6Yg5qwou5nF6Nfjk/GtoGAVu6gV5dVFKxxg1+DA+AILMU?=
 =?us-ascii?Q?D+T7j1bfQ8dTAqR9BhITj6uKSPXWndEHJc48dF8ZRCRGsbPOzaiipzr5pj+/?=
 =?us-ascii?Q?vwNNDeQ23TZ6bVoSSEa/pTR0g+jNnepmeQf3mFH9Zl1ITceZY2IV7YQ5uPan?=
 =?us-ascii?Q?DUuRSeGDB1hKpHaDHI6hex+oe+W2HQYqDTTbB6KDDcI6fIXK+qbhV9W2687p?=
 =?us-ascii?Q?09MmcxKOwrvUmyak8IKgGkcDjCyktay9Sb6GVwY2k4prpzb5tY4u3+cVFMfl?=
 =?us-ascii?Q?eIxFKT3fFERqNk565odkuLLoegj9BH4tEo+J7wuMIB4FCHKeuCDp/aVqEM92?=
 =?us-ascii?Q?3mxJ+k7bD/3Dz8DM+2Wj1B+kRbc/GrR7ymg4qQ0ljID8IzZI+i2hOLmKO1Uu?=
 =?us-ascii?Q?IeMAHd6tHbOtZuGea3cb5C1d28r5vIvfW+PzpslZv0JTwwqI7QIMVYw6XxeA?=
 =?us-ascii?Q?z7kykFLOiq5FTdOkbwKzffysLed/+7TM/V71tlq4z0y8zdtrZy5b95AHDigH?=
 =?us-ascii?Q?QnbrJe13spLAEu2Dii+ign/Nz7y3Yjm1mYpi9CnbobGgMcRSJslfMJFmKl4q?=
 =?us-ascii?Q?0J2cgdZWCiXLhbmMAJri5e6Dpanw2KbHsxy7FVttmiVjw4T1U5aFUKFF7835?=
 =?us-ascii?Q?X3x5w8Q86+t+wL46vMYAUPyIY4XMtLWYBddoShmkexArX7M3uHsxGT4pdVQ8?=
 =?us-ascii?Q?APwh4Ecd0MccsuQvthqRR9lsYbCvSpJDCR03arniup9VCWbwGTPJbvVcH5p/?=
 =?us-ascii?Q?VfK7cMSaieIJq5BX1QaaS9FpLaJnYE4EphlzEAj4Y5gCE23qLarsmsHcwIPV?=
 =?us-ascii?Q?HnKPySsQKxgM2EgE5V495Eu3uQHPbHEXNEX6/MAET5r5kWmkhadvP5BHXfT5?=
 =?us-ascii?Q?8gSKMansPSRT0BHwfVAJEZibl5qv2kLJyV35vQY14hXehbY=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Af/GPUSQfH2ITiJ6jIwkDGEhxIIty2Au9q76+qhMWm60t86DjPSJP/Q1FYHU?=
 =?us-ascii?Q?1W8gPXikW6ZJWTku9cQGD0aQzgYvDN6EyfV9Vs9qxTXPWYAZcBOYO0CyeJzz?=
 =?us-ascii?Q?UzAAB+GWByCiQ/TnGnSeJnlnPL4OheDXw5SMjOlYMso/fNxicggtFn+L8kuH?=
 =?us-ascii?Q?7EHLo9gYmhFwcJCYSWJYYNlwib7cvM4taWj12R7Hf0TdpoPmO13Kd9uF26uK?=
 =?us-ascii?Q?2xA2tTqpCcHUZ7V3QNpXAZW5ISGcAaDjemWRVjaDMFglURaDKFBjypjQ7f/X?=
 =?us-ascii?Q?0gIC6rEDH1TcQABz1EBJ0/xKXaTv7sGpFTIWb6CIf6QJcvQ5Xxl+13My+wvw?=
 =?us-ascii?Q?8XKyTZIjlYfCuUe3fm4SEkz6UlQmlEcQK3TTegVAWsUKutI3Mj8yMyHHW6tF?=
 =?us-ascii?Q?g2UJQ1Sd/xp4SFxc0NE+hWDjKAvhw4XkkCnpJcYsORX+JHAzTwYJqh1fdzey?=
 =?us-ascii?Q?eDEixDVPp7Szh5oYQQMoTNbTir7hvk+r0qS+HB1Vz5zgqgMi9PA/ksn7lZu4?=
 =?us-ascii?Q?vuzP6JfFGkJ7jMuioFm5vu183evBnXtlVeW0+crME+xWK4CePz2tR1IziDnv?=
 =?us-ascii?Q?apTeiojLHj3sEza2CGGHxry4ZCrfcXuDRa9pgAAa9zTbmUlzAXTlk4Sx3WUr?=
 =?us-ascii?Q?f8D3R6988VVjoPZmikz+a1qbnBBdbOObJkDxjaffuGPjjTcrRgazYuUOyTHo?=
 =?us-ascii?Q?gt6qhs8LADXjf7PyUcQ2/Tl61v2vhOP5uiqBlmp11LFzEjfbElA3eU/sC9xT?=
 =?us-ascii?Q?9WiLYgtE7ZR+coGMUi86i6/7nlpye0+nJoPMNv35mtBx2bnyhnaX2zjy6jBe?=
 =?us-ascii?Q?ghuY2kDwuqz3IW/f/heKj1JaIBH5zZodoxaFJSm41vHc2nuIO/D9z9vi3x/W?=
 =?us-ascii?Q?7IL+k8Vv9GqmkkP3xgFjM3GehiEHuoWSrrknZtQpv5PNk7CvIUyTtzv/Xvcr?=
 =?us-ascii?Q?ueM/2a0u60hCjCQ7WS1B2l9mI6ZbJUYo/ETQJqSgGSGrhiLtLSGGW56xiIVQ?=
 =?us-ascii?Q?YP8+kNQZ7nF9xKYilV8MeKszwQ4pTfpCe6hXINMFFIIAxDt1hTLLqIW4DOG6?=
 =?us-ascii?Q?N5i2a5AL0M17ifMExZvyxV90rwN6YysQupy8cNupOTtXG8B4Vr0JIO/hoDUd?=
 =?us-ascii?Q?slDR6I/Yz47kyGECKtq+CPHx+tRrUJJNvx3BKMKE4lZ/SDik5lrVVfGtjzmP?=
 =?us-ascii?Q?cYB1170HMPdF6i3J992QGnVGCWO51DPIZV0sCXkATSmX2Wwtohpim0owST4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7df768-1de1-48a7-bff9-08dd513b3161
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 23:14:42.9451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB9192

From: Roman Kisel <romank@linux.microsoft.com> Sent: Tuesday, February 11, =
2025 5:43 PM
>=20
> Kconfig dependencies for arm64 guests on Hyper-V require that be
> ACPI enabled, and limit VTL mode to x86/x64. To enable VTL mode
> on arm64 as well, update the dependencies. Since VTL mode requires
> DeviceTree instead of ACPI, don't require arm64 guests on Hyper-V
> to have ACPI unconditionally.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/hv/Kconfig | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 862c47b191af..db9912ef96a8 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -5,18 +5,20 @@ menu "Microsoft Hyper-V guest support" config HYPERV
>  	tristate "Microsoft Hyper-V client drivers"
>  	depends on (X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
> -		|| (ACPI && ARM64 && !CPU_BIG_ENDIAN)
> +		|| (ARM64 && !CPU_BIG_ENDIAN)
> +	depends on (ACPI || HYPERV_VTL_MODE)
>  	select PARAVIRT
>  	select X86_HV_CALLBACK_VECTOR if X86
> -	select OF_EARLY_FLATTREE if OF
>  	help
>  	  Select this option to run Linux as a Hyper-V client operating
>  	  system.
>=20
>  config HYPERV_VTL_MODE
>  	bool "Enable Linux to boot in VTL context"
> -	depends on X86_64 && HYPERV
> +	depends on (X86 || ARM64)

Any reason to choose "X86" instead of "X86_64"? I can't
imagine VTL mode making any sense for 32-bit, but maybe
I'm wrong! :-)

>  	depends on SMP
> +	select OF_EARLY_FLATTREE
> +	select OF
>  	default n
>  	help
>  	  Virtual Secure Mode (VSM) is a set of hypervisor capabilities and
> @@ -31,7 +33,7 @@ config HYPERV_VTL_MODE
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
> 2.43.0
>=20


