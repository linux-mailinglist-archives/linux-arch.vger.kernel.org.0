Return-Path: <linux-arch+bounces-10321-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E80CA4017D
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 21:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6BC217F8E4
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 20:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D762253B66;
	Fri, 21 Feb 2025 20:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="r/SKjdNS"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2082.outbound.protection.outlook.com [40.92.21.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F36D1F3BA9;
	Fri, 21 Feb 2025 20:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740171549; cv=fail; b=B3oWsB1VwumAl/b9yjWGW5C+jhFAbu7iKw7Hhuwph92VQ8AO8OvGPMFQgRm3DZJXupfKTufD6Ecv1wU3j2dexqBpH+f3XW1R+cNppggUM8p2iuMf4itikxAI6npyQ3AtTwS9HYUXzgFrTee4DqxJP830crtxh3QHJxkUXAq5By8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740171549; c=relaxed/simple;
	bh=Oaj1NlevlEEKcwUFUazFL7BhpWyK+ik4koaxRwYaPdM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LTZty9hgdpI0lVTx80H6EZgExUYpTE/U6s1BW7N92Ni9uNo/L/Xvh7nDLLYQqOVMqsodoHCQxd8vd1RS/eDTb8lRP0E6Oq9yEzE/+M+A0r1iEQ7taWbRF3z7h+1N6snq1iyXgaPzOEGgWxc7HIdEcSjB5kWTYdzf5Y+LrfaFcxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=r/SKjdNS; arc=fail smtp.client-ip=40.92.21.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7j218YFx+UCfEzsNcK2uGnvNnplDVegyTq8KYq4G4N1JjwUWryMXC9sW5Q48L/XwrpY0lzEp4g8JdJrOcEGv47JuWbs82hVAvm+BKWmg4UaNyvpudP7+AUO8bsjEsbPRBiaEVARyAtvnm/5fHYctSvcgVacatdwn0fh6bLI7Xsw0ffbA8rWNXTJYNn0d4d2sznETHZPnHZpGZJ2E3eyY/hfHIIS6aWPhSVoqOe6oL5B/tp7DCQ4njeprxyiLbsxkLK3x+MLwGxFeHwOM2Xn5+QmeeoANJ0YwbKleHBRHVmuNfKykxHCnuJSwhVB0UkALPDAdK7oD13JSoqLdUUQfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+f3FQWYC/ImwMZrZA6HkN5UtbBQxAhTHP5w0xIoTGbY=;
 b=ZKh3boJf92oRf2SvCdt0bPG8d66IpMmwpGUY1pXcMlUmZ7CU/X2IQEaKLgPBS5EnomrIclj4LVgftFGP2NGjCUjpMdS4LqUdKXwqpULc7N352pVzZDmQ7VyRQsDeXBnmyk2SLTHS2Vojtg9fJI00SoaHFBfz4k29CwUhsAQWforq0oDGzBTlc6EBnqHwLdj/IYxNHXdylni9RCu6tEhcalscdWR/84w5NLnkr5KbORCfWV3YIMnMAuKMklM/mHaqRAsIrct82PIZ6S/szEGxWfJwquCatoRpxY7Dl7nG+cyou/gUEnQlc+cYmiw0hcXyPGe7Rdng3Ko3Y2w95AwjLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+f3FQWYC/ImwMZrZA6HkN5UtbBQxAhTHP5w0xIoTGbY=;
 b=r/SKjdNSSZev2eNM4AUrQTpWHNIpKMphrPAJMxOaOLWKeVycguUnvTn+8QweVAYor0UTGkp3eUQtMHtuBkEjLz4+S9ZmUw708ZcTvKN9xs1BPw34dpJQrj2fa5nkzQ+FzokmIG99xtEWL1A5TrpGHNL+HmT1Z5i5NkURyZCW5k4x54fgJq1shTrVxopKZ8L0aBS5kHO8CP5ObqAwjBZj4K7j9pnSNuR8QxCr0B/26MfJuK4uDgnzWeVFZP0vox1q2k/cFmwugneVMncs9iQEOXM1Zzzr9R4vdxrTs4NUJGVwOMXrCSdB76zCPaAwdu4m74Ngbp0aqBXxMnFD5FLwCw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH0PR02MB8195.namprd02.prod.outlook.com (2603:10b6:610:f1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 20:59:05 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8466.013; Fri, 21 Feb 2025
 20:59:05 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "eahariha@linux.microsoft.com"
	<eahariha@linux.microsoft.com>, "mukeshrathor@microsoft.com"
	<mukeshrathor@microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "joro@8bytes.org"
	<joro@8bytes.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "jinankjain@linux.microsoft.com"
	<jinankjain@linux.microsoft.com>, "muminulrussell@gmail.com"
	<muminulrussell@gmail.com>, "skinsburskii@linux.microsoft.com"
	<skinsburskii@linux.microsoft.com>
Subject: RE: [PATCH v3 3/3] hyperv: Add CONFIG_MSHV_ROOT to gate root
 partition support
Thread-Topic: [PATCH v3 3/3] hyperv: Add CONFIG_MSHV_ROOT to gate root
 partition support
Thread-Index: AQHbhJq8yi+IlJcpz0qSOgKep2rZULNSPV8Q
Date: Fri, 21 Feb 2025 20:59:05 +0000
Message-ID:
 <SN6PR02MB41570A2F04AF7C196D477BF6D4C72@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1740167795-13296-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740167795-13296-4-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1740167795-13296-4-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH0PR02MB8195:EE_
x-ms-office365-filtering-correlation-id: d5b19f04-50c0-4468-5ec5-08dd52ba93a2
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999004|8062599003|461199028|8060799006|15080799006|19110799003|102099032|3412199025|440099028|41001999003|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?PF1X6LjHeH+vGu2thWhWVm8pFetQmDkb0qiqCVB9mD5a9tH1xAHi1zRh7VaH?=
 =?us-ascii?Q?11RwmIaKdCLVjwMdHrTDAN3L2MHkHKAhOYQr6Q63IkizykvKhofa3qzTgMjE?=
 =?us-ascii?Q?mxr1+VS4fzhccSokk42hv/RX02thqyiHp2lp+X1T5O5AfeBWwvjlBLlbB6tA?=
 =?us-ascii?Q?OcZ7PXpWA7SfU6JexGgsMynu9EGynmGxFlSYnIb/kamOuQo3DKgXAaH1OS1s?=
 =?us-ascii?Q?xAH20l9w4Ac2rgrDAv9Kvp6fbLSdtDTVGsAk7oNIWn8awS+9iKhexA+kBxU8?=
 =?us-ascii?Q?QsxCvep3VgJEFLamLpiYFHoqbfIpAPo/rqcskjuc1YuAc+OJ6dNEDEapOtE2?=
 =?us-ascii?Q?L81HIp7QaqMVIPQj45SY6rc8DOg8jyTzdOC1wG8bK8OQZjNqOjG1znRyE/jU?=
 =?us-ascii?Q?SG7kWbXBGz3FYKPawAx23NtyiVPqhT0kBweEN5sZdctzuHtbPSthJ+MLJjbx?=
 =?us-ascii?Q?+AVzgCVWKsPPuFxlHRl9ZUzZY3IGbbN4C/o2bHV/4AfbmsI6ozZBY47ZtddV?=
 =?us-ascii?Q?h7WqRWPp5lcoxRLYvB7oSMHr/SKUyG0ZJ4dzBXRUSZVvFQXGgFIVUfgrdra0?=
 =?us-ascii?Q?ZpfDy3DOAEpJP6+SJs/o6t9Z5Vy+TvOMTXCbFY3OWFfmtRSCsp7WJxaV88UO?=
 =?us-ascii?Q?LDZlWCJqxNqEQ6yIAgFnHKvU/csgB9vQIFupHS6gsJTwgoRYYp6KvIlbrY6j?=
 =?us-ascii?Q?OVFNrpzLXYwycfaD+Gh+tfCqzgFSAl7dShtYsC/y3YXg5sowz1kUM9JaN0qq?=
 =?us-ascii?Q?moNePGZYCr+HtQ477ESJQdsIp/1Z3/JHWBdHUGaScsW0PpYX1EvIQeN9umNy?=
 =?us-ascii?Q?ZXd/Forjn3ZmpA0zRIFYJn/ED0H+ewR2Lh5ZT2ki95P+f4aB2W8OeOTVRfWI?=
 =?us-ascii?Q?XymZi9fbL7JWruWNvifDGqmiN/nqiJefOjE6c7YA9GA24xtT0RpSOUnXAKNd?=
 =?us-ascii?Q?sPdQHDgoKuzGhv7wVjMHvSmGwcuM6pu3jEXmMELGd4UYGKVi1XwxAEVAI+S5?=
 =?us-ascii?Q?2pi/cNFjOIOYkfktbl4Bkl8j7TczE4ODTqssVqOb4eFPP5FKRLrncWp5mnXa?=
 =?us-ascii?Q?WinXkGcN3BiFwA8n0zDJS5CSO5WQkDwHmGqKKtYbIWlzXvsxuQRrQkUvwrUG?=
 =?us-ascii?Q?Hniv0a3STIm+AKvbUk/Abb4YV45cnAZnFA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?f+X92EaX8BRdqFiAglb2ns+cIVGSwZETYAbk8O3Vy4jlA7gmeCJbJ1Qc96UD?=
 =?us-ascii?Q?YuzlCJ2EUiCFAjeYzuOiWjp59S3gg6EGPxYantsUozDnRVPtF+98hm9ZIWVt?=
 =?us-ascii?Q?Fu4jA3WWekHzl+ZH/lheUlzEVY1/IT94/Akuhvuy0YyNaJ6RXO9LqPQTL3Bc?=
 =?us-ascii?Q?X1ZDRqXVpIZRM/uvq64ljXFk9uozZgAvxAUhWmmx2eBi1LETvK1kb3s1KLZJ?=
 =?us-ascii?Q?j66rBiccgvv2F8u0A+0qOJny/++MGlO5PkuU3j8PxEYKQrgMsLx2jdkQ5n95?=
 =?us-ascii?Q?AHL7qM0o5CXa4eDB6rneOeuV0qhkxLd3a661xnJPqYkCxtKtzPhoKbM6uCc5?=
 =?us-ascii?Q?R+0uiZY8oEYHpcSbGy3l5J909Mi//xSC4lSMviEVD8nSJzk4A7uu37Yo+o6r?=
 =?us-ascii?Q?9QcQivXrqiaLrFuN1EUZk454SuGC0Nwnsd/1bceQDK6YRqOsPBQrNywOBCnX?=
 =?us-ascii?Q?dB8rIPUxunddOX4d0BWYydpeOkXZaNWw3dMmXcsXTgOAzpvl5e+oaFB2js1Q?=
 =?us-ascii?Q?E1b8jXn/sOhuw2BCLzFD7m2v8fdquIv+imfFlZyVuPLr1Ian2QF+D5sPctQX?=
 =?us-ascii?Q?q7vJ0ooyNtjS6QYMVD1co+eD0BbTyNILOGqSBR/+zAorLMiiefJX5h9XDFUI?=
 =?us-ascii?Q?CYZLtWxlJLGZiKoptf4Tp/CwNUDvns8vDV8SBoCOTkVuW3MRUh11KzHAwFk0?=
 =?us-ascii?Q?VrxiYTwyM2cVWl/I2JjCDBM74KZe1QQANqhrBmhrHA4YWWTeLE69uMjK7TaJ?=
 =?us-ascii?Q?ncT208hbqDRB/blH2+dlKv04oSIDIznLdfbIp1fbNQ6YExZtDWM0gAIvaUZb?=
 =?us-ascii?Q?kNBzM3GegUFTMvu1cF2N3vzXybKxCvSBkIfo3KrpdyaEUxxGoUPyR6BZS6QS?=
 =?us-ascii?Q?8cadxAGL8L6dFKmDMrZ1riRKxHnoUPmX2YKITVyNfHwiS7+5AGwtNrH2FbkO?=
 =?us-ascii?Q?H1tQI8LW9fD/CLSVeG+j3CFYca7b0JHQuqk9GUbfTJ3Fin8oxRCKabEin6Q4?=
 =?us-ascii?Q?4B/y4hGWliGQ8WpN3V1qnEVmlnOeQO4lH8U/6WPmyfj/W7n0SHSrmMxBcnHd?=
 =?us-ascii?Q?PWjI6WRRBq82N8F7n+BREcLuuCOIkj67xSoVXdw0AGVh7naP+aC31xU+bJHG?=
 =?us-ascii?Q?GGFlnPPZeJjO77EGfjfoa3oqqSuzuxszjriZQNCSP2TxcHSojn3Epx17p5pc?=
 =?us-ascii?Q?2KfF+Dc51nR13TjVuE4SbBvRn1kY9nNztcCJpHq4u++Ul90UCvWqXwlni1c?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b19f04-50c0-4468-5ec5-08dd52ba93a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 20:59:05.0178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8195

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, Febru=
ary 21, 2025 11:57 AM
>=20
> CONFIG_MSHV_ROOT allows kernels built to run as a normal Hyper-V guest
> to exclude the root partition code, which is expected to grow
> significantly over time.
>=20
> This option is a tristate so future driver code can be built as a
> (m)odule, allowing faster development iteration cycles.
>=20
> If CONFIG_MSHV_ROOT is disabled, don't compile hv_proc.c, and stub
> hv_root_partition() to return false unconditionally. This allows the
> compiler to optimize away root partition code blocks since they will
> be disabled at compile time.
>=20
> In the case of booting as root partition *without* CONFIG_MSHV_ROOT
> enabled, print a critical error (the kernel will likely crash).
>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>  drivers/hv/Kconfig             | 16 ++++++++++++++++
>  drivers/hv/Makefile            |  3 ++-
>  drivers/hv/hv_common.c         |  5 ++++-
>  include/asm-generic/mshyperv.h | 24 ++++++++++++++++++++----
>  4 files changed, 42 insertions(+), 6 deletions(-)

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

>=20
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 862c47b191af..794e88e9dc6b 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -55,4 +55,20 @@ config HYPERV_BALLOON
>  	help
>  	  Select this option to enable Hyper-V Balloon driver.
>=20
> +config MSHV_ROOT
> +	tristate "Microsoft Hyper-V root partition support"
> +	depends on HYPERV
> +	depends on !HYPERV_VTL_MODE
> +	# The hypervisor interface operates on 4k pages. Enforcing it here
> +	# simplifies many assumptions in the root partition code.
> +	# e.g. When withdrawing memory, the hypervisor gives back 4k pages in
> +	# no particular order, making it impossible to reassemble larger pages
> +	depends on PAGE_SIZE_4KB
> +	default n
> +	help
> +	  Select this option to enable support for booting and running as root
> +	  partition on Microsoft Hyper-V.
> +
> +	  If unsure, say N.
> +
>  endmenu
> diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
> index 9afcabb3fbd2..2b8dc954b350 100644
> --- a/drivers/hv/Makefile
> +++ b/drivers/hv/Makefile
> @@ -13,4 +13,5 @@ hv_vmbus-$(CONFIG_HYPERV_TESTING)	+=3D hv_debugfs.o
>  hv_utils-y :=3D hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
>=20
>  # Code that must be built-in
> -obj-$(subst m,y,$(CONFIG_HYPERV)) +=3D hv_common.o hv_proc.o
> +obj-$(subst m,y,$(CONFIG_HYPERV)) +=3D hv_common.o
> +obj-$(subst m,y,$(CONFIG_MSHV_ROOT)) +=3D hv_proc.o
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 3d9cfcfbc854..9804adb4cc56 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -734,6 +734,9 @@ void hv_identify_partition_type(void)
>  	    (ms_hyperv.priv_high & HV_CPU_MANAGEMENT) &&
>  	    !(ms_hyperv.priv_high & HV_ISOLATION)) {
>  		pr_info("Hyper-V: running as root partition\n");
> -		hv_curr_partition_type =3D HV_PARTITION_TYPE_ROOT;
> +		if (IS_ENABLED(CONFIG_MSHV_ROOT))
> +			hv_curr_partition_type =3D HV_PARTITION_TYPE_ROOT;
> +		else
> +			pr_crit("Hyper-V: CONFIG_MSHV_ROOT not enabled!\n");
>  	}
>  }
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index 54ebd630e72c..b13b0cda4ac8 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -223,10 +223,6 @@ void *hv_alloc_hyperv_page(void);
>  void *hv_alloc_hyperv_zeroed_page(void);
>  void hv_free_hyperv_page(void *addr);
>=20
> -int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
> -int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
> -int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flag=
s);
> -
>  /**
>   * hv_cpu_number_to_vp_number() - Map CPU to VP.
>   * @cpu_number: CPU number in Linux terms
> @@ -327,9 +323,29 @@ static inline enum hv_isolation_type
> hv_get_isolation_type(void)
>  }
>  #endif /* CONFIG_HYPERV */
>=20
> +#if IS_ENABLED(CONFIG_MSHV_ROOT)
>  static inline bool hv_root_partition(void)
>  {
>  	return hv_curr_partition_type =3D=3D HV_PARTITION_TYPE_ROOT;
>  }
> +int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
> +int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
> +int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flag=
s);
> +
> +#else /* CONFIG_MSHV_ROOT */
> +static inline bool hv_root_partition(void) { return false; }
> +static inline int hv_call_deposit_pages(int node, u64 partition_id, u32 =
num_pages)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline int hv_call_add_logical_proc(int node, u32 lp_index, u32 a=
cpi_id)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline int hv_call_create_vp(int node, u64 partition_id, u32 vp_i=
ndex, u32 flags)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif /* CONFIG_MSHV_ROOT */
>=20
>  #endif
> --
> 2.34.1


