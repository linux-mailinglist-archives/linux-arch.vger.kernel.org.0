Return-Path: <linux-arch+bounces-10266-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8E7A3E4FB
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 20:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912FF420532
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 19:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7638B24BD10;
	Thu, 20 Feb 2025 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="KZZpm8eL"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2024.outbound.protection.outlook.com [40.92.21.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820D2213E80;
	Thu, 20 Feb 2025 19:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740079376; cv=fail; b=Mx62HaOT1kgLuxLUyu2LNHz9o0YGIr8kDCgMQONNHZ8+hAwsxDKpWhMi5kc5/9iT1B6cS9BbqIsCL9qV/S6f5i+tTUtB111unr/UHXzltRpLJNYHPUJic+k5u91HQZ8ge7tAM9GJb+RGdGM1MT2Yd2So5JoIj+CVpPE04+O7I50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740079376; c=relaxed/simple;
	bh=jz7Ng/+fAEGJXBOU6S0O5Vax5ZQGTdOExGzul8QVh50=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hjiufXoYkYdjl2fttOw3Qu3/1b5NrlNHq06Stp39s/wmBx3SDK6chrAHKoqLmm61GZ3Xf0sEx8oPkrKkKVhYHF9CEYo2lwOphzAAqKiWDhyUBnsxBeZqjQSLPpvim+CzIlq4Jkhny8r0oNGGCrAtmfkLL7ubt3MJrlOOt2O2/o8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=KZZpm8eL; arc=fail smtp.client-ip=40.92.21.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tWpxmrr3EkELWB4tzuRTbDQZOPGwCMVGLyFdgOK1txU9ptePdsDCv38o/MRsQyf9JCAyuUge7j1dNguxE5Rv85TPj2NBDjVWSgzmoEnKPwPdfq5fhLHDa2N8rqJgk2B1kXSTCqmbnwXHkQ5W7vW5lJ+2r3MIm8nlRT5bQmZ0+HSn/LoZp2vYZUbV1g0J6vXz+gb+ThS2sebhvyTJF4YayDnHsS9u+ffpvCKB88tW4oXVkC95CLNJ8dGysaXjsK6WN7Yr9k2ABNYhwb3/aADbtdhZnXhu1rw42zxKapacfea2nE33ZmDMGr8/tPwJ+UxPr/NWYWwGXiJ78pOH6mygGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0qS+tGAtZg9AsfLrkKO/GtvvKoL3p3J8XYwDKGzxog=;
 b=mspQYq87CzNAIQHK5ukJp0kHgIhdTUcRzcBYXzig27WPVvybd9gqHjtL+Sq+UcJAU3KepbgrxzM37gNR+C3wWabvAFmu8v9VDwDyW8e3VC143KKBGe/o0cp9VHk9H6S37OQMV3nX++IC5rOWHZawxtTx4Wu/z/KO56auVhwjH0HLvfxijFHRd7etOI5pSuTUiZEg2a4wL9nyHDeHXJjWivBcfawlvgLlWOGvFEi77VPXwJz8/iDMhikem+rnJT+PWF6oUAYth8F+gN/A4UjxNb/kB508QQ1lKoxVv72yh5RdVuLLlkdleZgxK4h87SW6A2KCPKd77aFdcZ2Nphr3lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0qS+tGAtZg9AsfLrkKO/GtvvKoL3p3J8XYwDKGzxog=;
 b=KZZpm8eLIGOXz9610uPBjUF8TZwBbWuvgwZyPUjSMOcEL9GC5x12pVLuKL0kEtREtVcnO40EXxpRnADc8xgUtdYU0q1IdGoidY3Kg+E9Cekex9lk58Q7tkSVdwY6QDvl9PLAA810Aki8S330o+z2BIl9vfumZhmu1Dc9rMh960b4ty6nsU6FObxsN/RKT4PhgO0hZINwbVv7h+xi8Uju0SEFMK9cUQZBkngI8cOBif15P7p76Sms3XHpJxAUBl7bBJDBxpBZLyMaAnrefebZ5ANtLSYcqpBuoxtK5jR4a4HTAJrVEH+ooSggj1M2PwAw2SPadFwwD2D7sxF5pabVlQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MWHPR02MB10353.namprd02.prod.outlook.com (2603:10b6:303:285::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 19:22:50 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 19:22:50 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "eahariha@linux.microsoft.com"
	<eahariha@linux.microsoft.com>
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
	<skinsburskii@linux.microsoft.com>, "mukeshrathor@microsoft.com"
	<mukeshrathor@microsoft.com>
Subject: RE: [PATCH v2 3/3] hyperv: Add CONFIG_MSHV_ROOT to gate root
 partition support
Thread-Topic: [PATCH v2 3/3] hyperv: Add CONFIG_MSHV_ROOT to gate root
 partition support
Thread-Index: AQHbg8X2KgtXuEdR60irnoVh382rZrNQjh4w
Date: Thu, 20 Feb 2025 19:22:50 +0000
Message-ID:
 <SN6PR02MB415731B00FF74784141275B1D4C42@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1740076396-15086-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740076396-15086-4-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1740076396-15086-4-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MWHPR02MB10353:EE_
x-ms-office365-filtering-correlation-id: e1d004d0-0962-410e-a35b-08dd51e3f765
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|19110799003|8062599003|12121999004|461199028|15080799006|3412199025|440099028|12091999003|41001999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vZKfspKy9FOHwG3lhOe/yIXnSMe8dEGz9G8CDZw3RUpj5YGUXHlMuyCNlHuJ?=
 =?us-ascii?Q?yGJFl65hlRHXHtkp0JytsD3eKz12TlUQuFF6tQTDQESzxa84EZvIYz5muglg?=
 =?us-ascii?Q?1jqIAPsJvqRCr3uqxIgIV09bV54iHrTuYVIN8hzHAM6DjrdWX0V0xylRKgRv?=
 =?us-ascii?Q?hX5IcYrRr+PZAKeoFP0szUPupmCautGANNqoyIb8kERLquEZ8fvrM17aE/JT?=
 =?us-ascii?Q?wugRZS18C0JUlOLfXVz59gk3LgPIWhPxda0qfkRjqije47o7mrqXjc4a3k33?=
 =?us-ascii?Q?sdMSHmzA4hK8pwWwvJN5AK/I30/5ZSIM+r/IgbB1zM8glX4iLPaTJ4PkSSd2?=
 =?us-ascii?Q?kaoZsrtUOm+6asH/h35eX2el6/ERU+gNMzxnsqH/GuKi+/3k01/Bv7o2ej3q?=
 =?us-ascii?Q?WRWu0VBRNRbzvhqeRNyBCnjWZ0HzSWJfi5+vsKm5bYFZ7zI5fip7hxuvkg+g?=
 =?us-ascii?Q?xZ5Z2Q6sxWaPAaLhSuMktnvtha8q76oN3WROOgZOfooHpLEqqlo9ogMvuDvI?=
 =?us-ascii?Q?7HkMvQOj7xP7W9BjQwnYWFjfVk9kQunSQ75Ip44po9WOcWHmXIUpkRfqj2gm?=
 =?us-ascii?Q?GwFP1I6Fe3vTBVt3n0H+YJrUVLC+MC7IllvBJvr6DiSsm3mhPbabLw2HgLmw?=
 =?us-ascii?Q?GuCf9vD2dds5lK6qvIuQ1l9xhPdzEVM1sSj58fWCUb8vZy7gl4meX7XkR/UF?=
 =?us-ascii?Q?H0VBwmyfHy0vcrayLU0v0fcl8cQn44OStxDeluvZBO2FOYHWNVL58PJX+B2F?=
 =?us-ascii?Q?/6KA7H2IObjzl84tWDeB5sky5+YCMjphGCZ9j/UW4TZnTYcptT0YZFh4KVlS?=
 =?us-ascii?Q?vkdyEcaIXmohJ2UknM7qtJm8oJitZREQjI23XRRiKVuUW2OP68k+Ze9K0DAr?=
 =?us-ascii?Q?n2rnOYoiBeJk1PQf/pSaU/vUX2ttwxhkLsM5jNOi4BfHLMru7m/wPSkaXHED?=
 =?us-ascii?Q?1CvVzyAfAM25PKevMCFwjg/zBPmZiAc/OsRNrsCdguckMN6Zu+OEh1Xgv+pE?=
 =?us-ascii?Q?wM0OFGWPAJhGeNgqjN70kDZnfp4f6pbqJ19rL3KfEB7OYdpJSF2VDXG3UOLx?=
 =?us-ascii?Q?3ZEoP5OqIkhvHFAmZf5O8jRoXfOSkGMDzA63z51uLhAw8pjt0S+E+KU7wxx8?=
 =?us-ascii?Q?1HEirVMzICN+3e4OnU+dKADfrm0ECv4YBA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+qz6ZREjlMdgRPGHlmx+KZncfhHbDQvnu/kMnekQmEFUtIivuPJZnO/Myzra?=
 =?us-ascii?Q?NzItSwEkVPOWPb5rdUmpYbk6+OK0DiiX3uQ1QLUOOAXsvOJkBp3dzSxW3mk5?=
 =?us-ascii?Q?jLhzW7skz2AF2uha3OBZJdbwjKn25wTd3v+jpAiIjYRBPIpz3h/AUPl8cgFI?=
 =?us-ascii?Q?bT+mEzGvWriwbKuerf5L8peCB7U04ua58dK3pOrm5zx+f2184HbRv/YXqlCY?=
 =?us-ascii?Q?XGgu+euTNE6hDOw0V1FRbBta0l9zTpVP5ACm1dgw+ZNWp2cF/D8KGIx56CVR?=
 =?us-ascii?Q?eGcdrLhI1I/PlajdK0OR2tyySI1dEd7MFO3nDyTRUIrJ+LftHjP4r/cY0KgL?=
 =?us-ascii?Q?RMj5AN/JTrr/kMHxQLYvr3json5h95iSUVuRV6D/kBDScE8utSmhejKWsRkv?=
 =?us-ascii?Q?Zsj2Ha0tCv+FmFYaABut+u/jCgJFYeaqf4SZayCu2NZavN4Fo3ji3ekJcppL?=
 =?us-ascii?Q?UuJVZz03xPpG1vFniQ2xGboP3J8sHW1qU/vjOz5cV4NAw67CFtTC9wVoj1I1?=
 =?us-ascii?Q?hvqnBOyXxutfvuZnQX6HLNej2vfIkzSC86FDDG4DVcPk5AUkFYIOb+wZHbmY?=
 =?us-ascii?Q?qBUztWyGS1/ZPooed0jkTCpJiDsM1OScELzLLpXvmD0xpXTAHgSSG3We1CB8?=
 =?us-ascii?Q?rdpxNhDLEOaLHrn3+ylgw4yZK8LNaCpxsBFJK8ihecUTstFqOjGxoQ68pSNn?=
 =?us-ascii?Q?c6vKtZjI1BGxB+EuDSrhWGftbnr/wWOGSSFLR3wzluAM/MJRq96zI7nl74Wx?=
 =?us-ascii?Q?C42MUxKXGHZukQC/fxejJ7Y+lWfnYigPDnrK13YfYfTWhS9UTeW3r8Jp8QbG?=
 =?us-ascii?Q?gG3qALP1xHnP3wj6DvWKrK0+1oqvvUg5kRa+zWNuVXROI50VC916FCAouYSq?=
 =?us-ascii?Q?J0lUdRjyv3BY4X9/SklOkumtNZrSP9KkMcvHh+90pv3lwOa8NTYgr4TEHyn6?=
 =?us-ascii?Q?+j2YwgNxTwPWx9AF41jP1aH8l3vMuRzlURmubbqEoiatDGM2y67WdRTD2+6F?=
 =?us-ascii?Q?EHIDO0We2NqC5vzvs7w0uhkV50f4ZoCbRy6LDTqmWorRkgQ5NJviqVLm8eJr?=
 =?us-ascii?Q?G2MCB0xsuzkrmg0G55+9Plpr3k5wwl3zGSL2YgZNQHUoiP91e/4Y4OyiQPPR?=
 =?us-ascii?Q?Xz4MQd1a8tiq9Ph2eF8DP+j/HKpVfBZGUzn1DjATPAzzbfLygPFL7HZtUJSO?=
 =?us-ascii?Q?F7G9nFziQC14UQyTMoEYMY0upAjgQrVHLk6Eh+1nY7FwVgKMQbe8nE+pFwA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d004d0-0962-410e-a35b-08dd51e3f765
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 19:22:50.6432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB10353

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, Feb=
ruary 20, 2025 10:33 AM
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
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/Kconfig             | 16 ++++++++++++++++
>  drivers/hv/Makefile            |  3 ++-
>  include/asm-generic/mshyperv.h | 24 ++++++++++++++++++++----
>  3 files changed, 38 insertions(+), 5 deletions(-)
>=20

This code LGTM, but I'll wait on my Reviewed-by: until the dependency
with Patch 2 of the series is sorted out.

Michael Kelley


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
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index d2b1a8fc074c..b29357cff2f7 100644
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
>  	return hv_current_partition_type =3D=3D HV_PARTITION_TYPE_ROOT;
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


