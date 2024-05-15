Return-Path: <linux-arch+bounces-4421-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0538C677E
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 15:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15CB91C2191B
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 13:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786C5126F33;
	Wed, 15 May 2024 13:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QpkjijuZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2041.outbound.protection.outlook.com [40.92.23.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7842074407;
	Wed, 15 May 2024 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715780330; cv=fail; b=f9UhKAOp4ql9SUza/JomXD3THXTiBG+9yyHDoFDCSfSNDw3ellN5KnDSNvf4NBFb8asNhhBETWKIv/3wO7antNS4VU8uTOivt0FmLaq/+otIi/4jX8KW3J0DtB2FvJSLMCKNx02FF90Ra4ok+0vhCA0Uxfi0j/z8pigLQMvgAKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715780330; c=relaxed/simple;
	bh=rBkJTRL4QdmxVP0fLaLTKAhWC2SA7whROaTemRRJP0g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=twR8gXo7QfE7EqYnNP2WEEMDK/NUWUHVgRUH6GOhp9LvJ3mBEnIl6WkBPM5ZPc08oog4kllh39yY6gfrsAOW3TcRgfdmh/3U9muIINkCG9EyJRpf43PuftfsaS1miqGaZOcQ4kTLlKRxUIv3lSuEbEQXt6tfiZzeIe5+g6aWj/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QpkjijuZ; arc=fail smtp.client-ip=40.92.23.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nm+gOozSMPCfGjJf9/W3+BUeLjLpybaR2VuSweqSJUWeE+7WO/3MjFlQAxPl38WV1UXVmQlUqoWLMfHoHVqXqgQR2o/zS8pqI6WtFy15EM1V9XKbQbqnISSUfEYDJAysO2u3LN8xY4gNvcTDEtKxXjGUPBOZpmm96dO5qC1j0iizHD4yMFdSiIm/v4FTELlMwt4RelMpacmMC6rXHUPQsXrzpxW8LdktMMva13PrqNENir0t8EKZAcy0Hq9pAFuBKZ5j1+tsSKXUK/8rK1LHavbHtxABAG+e003li8h1/uUnFXRW9ovAQcmLsu/ikc2XHWzQ9kQzEkSuVoZLkOtpng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4RQk5EpFyhy7qRg1paTHBKPFgjqlTl77zQGlJ0P30o=;
 b=gpoygTagptwVbEgEDcPEsrCda6IzLxixUuO761F0piXX+3hahi+YNWzQLbdtj3GfB0XdYrlUSDTJCzBdBDRS4NSGVyO++6VDisHlXzvGsW+0x8VqqVJdfG2RTsp8dRCs45ZBokysaSodesxDALI1mXfDPkdVtdQbsyw0iX1A71yHOj2LsuBCZxlm0VvrnoLlWfMA4U4Aufaf6LFGS1sD1N3SCzRu3Xty8P/5Zc3WEkxuqhLkF7/srqkr85ZG9EkgxPv8iYwPHK6kLzXf/EgmpKBIsyskn1li/6L2vLPhxIdglhIheAvCYm4lZUXKHpKVJdo2BBYs9WXnwZe9HGwBXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4RQk5EpFyhy7qRg1paTHBKPFgjqlTl77zQGlJ0P30o=;
 b=QpkjijuZepLuS+Y69TRH2NBQfN+bl98HHDNjDe7/18CzBLw7GX8E6lkRZvHlPup/gj9jfokzZ9ZE+ihtQiYYuygeCHcrICpf5vQcO2/pvZga/6w+RvxbJa35WbA45YbAQtdOcowneN4DAUpi16K7kbQET3ttHvqgFiyKuwcuwUfDXFo/tHJp5Yt2pZO5OTku/V11x5geaokADdVLTwOqBQry3z3PFNS7bhT2jzwFtssysuGUlu10lBitlyC+xfqvFuwEjv+/heqBjnbUH0eBuQOlEj166HUm5gRS4OcDMJK39/GRqX0LZZoFVK8bN7yfqSzYso5lFf0EudQkmEmmOg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB8465.namprd02.prod.outlook.com (2603:10b6:a03:3f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Wed, 15 May
 2024 13:38:42 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 13:38:42 +0000
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
Subject: RE: [PATCH v2 3/6] drivers/hv: arch-neutral implementation of
 get_vtl()
Thread-Topic: [PATCH v2 3/6] drivers/hv: arch-neutral implementation of
 get_vtl()
Thread-Index: AQHaplCOjZgqPcpOiE6DmO9TB53GeLGXjYsw
Date: Wed, 15 May 2024 13:38:42 +0000
Message-ID:
 <SN6PR02MB4157A676809A7A97313C909DD4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240514224508.212318-1-romank@linux.microsoft.com>
 <20240514224508.212318-4-romank@linux.microsoft.com>
In-Reply-To: <20240514224508.212318-4-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [i5/FsO3zQuZxlBLBePsy9H3I5Sug05QH]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB8465:EE_
x-ms-office365-filtering-correlation-id: 2822421f-118d-4ac2-5406-08dc74e455cc
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199019|102099023|3412199016|440099019;
x-microsoft-antispam-message-info:
 vcIpMpFEjmdDZXB4gLDzDJVvpNtMmwr4+n69vJoLQxVIFNMTjj1Hl9jW5LSu9h6IOt3wzm3ney1X2EiiLkYoDjigJnkNgSMnT4PUzifO+w8P60cquZ6bnUaKEC0U4teB6Q6jCoRqsXckLe7ioq8ADvW7tkAGUHOBORPYCA8xGSZciPq19zeZDl6BtZ2IZIQwso9jt6B+w0ipLbMvi+4MDO2l1A+czkLrAvZ/xB2NNEqR4UdcJUt9SqjkUoAZr4UMAs8UngTelW9W6OzLQFBvtIF3hXZPPurf/Xlcja3sgfk1cqOcK6m8UoFziiIal7U6ZzW9PJvPQPIgdQY12VrjhiJ9LAml+EK5+RTNsIuo9Ww1oJUho7/FESi/HCDttryBgdAM9HDe4RgoU34HbdLWtOSqyLMLaPggF6d6teZ5m9aNHrKyuzg7tIlwBpp3utREanYcZCDxT0f8ILi3qKy2gzoRJVx7LS+OAQOfeG1M3mWxEy/fNDUCrzXxJ7yFey1zNjMhqqIWUAHLe3gYZaYFxjbgns+yNfH/0yOViyv2EGE5xdFHxS6Liw+n9VHUGBwU
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Q7j1mInd2aUWGaY2VDbLjPZoGuBmxBAaTaN0ClhDHSU+oHqGn324aUswrNz1?=
 =?us-ascii?Q?nTuGUZkd7hluQYAQ6fF4Mc3nF/4JkZaI8vDDoKs5hjS1Gf7Ba8fdCRfITOSn?=
 =?us-ascii?Q?bvjp0HxvkB6kSDZtHscjMoAVg1TMlkQHazX3SfWdGf9CiQm/ssFr6UsrWvd6?=
 =?us-ascii?Q?T3T3q/acnk8AVhHgNAkxRiCEtYF9No02rGxLd/Wi+MtYX3E7TD1WfHa4M/JX?=
 =?us-ascii?Q?fvFqg9CeWjVGHbZjvuNjZ0UYht7D+WjtASkLBiaBPwLiKgm1vjHcYD7EmR4i?=
 =?us-ascii?Q?DlJU7OfQ9JKU7XsryhNoi7BhMd6Ai5DuVBjAEYxliRH8WdwgVTAEteMDxrIc?=
 =?us-ascii?Q?GbXavwjBfwMNy6sSLSVtLhdIRidQjoWRQkIFpIfRrGZctKPU96ZWP6Lj8uVB?=
 =?us-ascii?Q?YqLsjtIeTt3SOHB7ugYoaG6N8g5GgANJMQYIRmf4RXzA3cgsM8MNiLzB6QAp?=
 =?us-ascii?Q?P9OisH/Z/zZ9ZUumvcgP/XDeCr4bAWLg8YFzvixNM+G3uH9zR3keu7EPBGZH?=
 =?us-ascii?Q?GBryYesGfDi8rL1j5qx0nU37PPWyBd0cLeSZvL7TzV+LMQvUWah5AIx/ZyXZ?=
 =?us-ascii?Q?XFHkSNwjjFHEJNosbSHm6GMwxAZrAo1KhCXPhbwmruSrSHRYx5jp+krSgisd?=
 =?us-ascii?Q?5BIFqtpOKKzSTGw7tVQpLJYVRWPX0hVM9fkHYcVK93q0hyKthWLFSxFiz/aQ?=
 =?us-ascii?Q?hzGljpbQi4PFBI46Q1m5GRMWt2tEVHbb36X6zkya6qGyxOcw+K8dOTZLln2C?=
 =?us-ascii?Q?Di287UqZF/kzK2yRVO7uBKsAe8ho2K8Hu2SjzdRhwi6/6uZLhlPeZhG4+G1r?=
 =?us-ascii?Q?LFaYg4jHiMv6thEP1Y4bwNCbweeCko5+hNjKaQeYZvr2a/txpraQrg/gmhzq?=
 =?us-ascii?Q?9jg2l+PyzGqLfImfx2x3vGJaRsYs7ePvq15ejJ+eGCGlxutKr2YrcNIB+MrI?=
 =?us-ascii?Q?saDZPrz4Rt8sfmVDsGcQi6vQonCeaXtP7O41qP8u1eYEiY0o/iUEfiLEPHx5?=
 =?us-ascii?Q?HsTpwgryFeCmuUlxmvguBp9mFaEQ9oIl30XvFQKGmWoT/JIyyFwpvyYExVOI?=
 =?us-ascii?Q?KExU7vz+4ZPTHYJt0HwL+qNjibpYDR9if1yYE1LkKs8otyiPY9AhT+TGBCkk?=
 =?us-ascii?Q?mU4fe8bo8hG8201YL3SXyYlmPtn1bGRzypyBUq9JwkERm6ZWwH2fn1Um3NiS?=
 =?us-ascii?Q?FWIdrMhf/9qtWwEfR4tUP1LBiaWZWV3KFewbbu01QdPqSV9Wbsk7zothN3o?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2822421f-118d-4ac2-5406-08dc74e455cc
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 13:38:42.0186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8465

From: Roman Kisel <romank@linux.microsoft.com> Sent: Tuesday, May 14, 2024 =
3:44 PM
>=20
> To run in the VTL mode, Hyper-V drivers have to know what
> VTL the system boots in, and the arm64/hyperv code does not
> have the means to compute that.
>=20
> Refactor the code to hoist the function that detects VTL,
> make it arch-neutral to be able to employ it to get the VTL
> on arm64.

Nit:  In patches that just refactor and move some code around,
patch authors will often include a statement like "No functional
changes" (or the slightly more doubtful "No functional changes
intended") as a separate line at the end of the commit message.
It's just something the reader/reviewer can cross-check against.

>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c          | 34 -----------------------
>  arch/x86/include/asm/hyperv-tlfs.h |  7 -----
>  drivers/hv/hv_common.c             | 43 ++++++++++++++++++++++++++++++
>  include/asm-generic/hyperv-tlfs.h  |  7 +++++
>  include/asm-generic/mshyperv.h     |  6 +++++
>  5 files changed, 56 insertions(+), 41 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 17a71e92a343..c350fa05ee59 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -413,40 +413,6 @@ static void __init hv_get_partition_id(void)
>  	local_irq_restore(flags);
>  }
>=20
> -#if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
> -static u8 __init get_vtl(void)
> -{
> -	u64 control =3D HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
> -	struct hv_get_vp_registers_input *input;
> -	struct hv_get_vp_registers_output *output;
> -	unsigned long flags;
> -	u64 ret;
> -
> -	local_irq_save(flags);
> -	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> -	output =3D (struct hv_get_vp_registers_output *)input;
> -
> -	memset(input, 0, struct_size(input, element, 1));
> -	input->header.partitionid =3D HV_PARTITION_ID_SELF;
> -	input->header.vpindex =3D HV_VP_INDEX_SELF;
> -	input->header.inputvtl =3D 0;
> -	input->element[0].name0 =3D HV_X64_REGISTER_VSM_VP_STATUS;
> -
> -	ret =3D hv_do_hypercall(control, input, output);
> -	if (hv_result_success(ret)) {
> -		ret =3D output->as64.low & HV_X64_VTL_MASK;
> -	} else {
> -		pr_err("Failed to get VTL(error: %lld) exiting...\n", ret);
> -		BUG();
> -	}
> -
> -	local_irq_restore(flags);
> -	return ret;
> -}
> -#else
> -static inline u8 get_vtl(void) { return 0; }
> -#endif
> -
>  /*
>   * This function is to be invoked early in the boot sequence after the
>   * hypervisor has been detected.
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hy=
perv-tlfs.h
> index 3787d26810c1..9ee68eb8e6ff 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -309,13 +309,6 @@ enum hv_isolation_type {
>  #define HV_MSR_STIMER0_CONFIG	(HV_X64_MSR_STIMER0_CONFIG)
>  #define HV_MSR_STIMER0_COUNT	(HV_X64_MSR_STIMER0_COUNT)
>=20
> -/*
> - * Registers are only accessible via HVCALL_GET_VP_REGISTERS hvcall and
> - * there is not associated MSR address.
> - */
> -#define	HV_X64_REGISTER_VSM_VP_STATUS	0x000D0003
> -#define	HV_X64_VTL_MASK			GENMASK(3, 0)
> -
>  /* Hyper-V memory host visibility */
>  enum hv_mem_host_visibility {
>  	VMBUS_PAGE_NOT_VISIBLE		=3D 0,
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index dde3f9b6871a..d4cf477a4d0c 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -660,3 +660,46 @@ u64 __weak hv_tdx_hypercall(u64 control, u64 param1,=
 u64
> param2)
>  	return HV_STATUS_INVALID_PARAMETER;
>  }
>  EXPORT_SYMBOL_GPL(hv_tdx_hypercall);
> +
> +#if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
> +u8 __init get_vtl(void)
> +{
> +	u64 control =3D HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
> +	struct hv_get_vp_registers_input *input;
> +	struct hv_get_vp_registers_output *output;
> +	unsigned long flags;
> +	u64 ret;
> +
> +	local_irq_save(flags);
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output =3D (struct hv_get_vp_registers_output *)input;

I gave some bad advice on the original version of the above code.  Rather
than allocating a separate hypercall output area, I had suggested just sett=
ing
the hypercall output to be the same as the input area, which is done
above.  While the overlap doesn't cause any problems for a hypercall return=
ing
the value of single register, the TLFS says to never set up such an overlap=
.

Since this code is being moved anyway, there's an opportunity to fix
this by setting output to "input" + "struct_size(input, element, 1)".  Or
put the output at the start of the second half of the page (note that the
size is HY_HYP_PAGE_SIZE, not PAGE_SIZE).  The input and output for 1
register are relatively small and both easily fit with either approach. The=
y
just shouldn't overlap.

Some might argue this tweak should be made in a separate patch, but
in my judgment, it's OK to do it here if you note it in the commit
message.  Your call.  Of course, if you make this change, my previous
comment about "No functional changes" no longer applies. :-)

Michael

> +
> +	memset(input, 0, struct_size(input, element, 1));
> +	input->header.partitionid =3D HV_PARTITION_ID_SELF;
> +	input->header.vpindex =3D HV_VP_INDEX_SELF;
> +	input->header.inputvtl =3D 0;
> +	input->element[0].name0 =3D HV_REGISTER_VSM_VP_STATUS;
> +
> +	ret =3D hv_do_hypercall(control, input, output);
> +	if (hv_result_success(ret)) {
> +		ret =3D output->as64.low & HV_VTL_MASK;
> +	} else {
> +		pr_err("Failed to get VTL(error: %lld) exiting...\n", ret);
> +
> +		/*
> +		 * This is a dead end, something fundamental is broken.
> +		 *
> +		 * There is no sensible way of continuing as the Hyper-V drivers
> +		 * transitively depend via the vmbus driver on knowing which VTL
> +		 * they run in to establish communication with the host. The kernel
> +		 * is going to be worse off if continued booting than a panicked one,
> +		 * just hung and stuck, producing second-order failures, with neither
> +		 * a way to recover nor to provide expected services.
> +		 */
> +		BUG();
> +	}
> +
> +	local_irq_restore(flags);
> +	return ret;
> +}
> +#endif
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hype=
rv-tlfs.h
> index 87e3d49a4e29..682bcda3124f 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -75,6 +75,13 @@
>  /* AccessTscInvariantControls privilege */
>  #define HV_ACCESS_TSC_INVARIANT			BIT(15)
>=20
> +/*
> + * This synthetic register is only accessible via the HVCALL_GET_VP_REGI=
STERS
> + * hvcall, and there is no an associated MSR on x86.
> + */
> +#define	HV_REGISTER_VSM_VP_STATUS	0x000D0003
> +#define	HV_VTL_MASK			GENMASK(3, 0)
> +
>  /*
>   * Group B features.
>   */
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index 99935779682d..ea434186d765 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -301,4 +301,10 @@ static inline enum hv_isolation_type
> hv_get_isolation_type(void)
>  }
>  #endif /* CONFIG_HYPERV */
>=20
> +#if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
> +u8 __init get_vtl(void);
> +#else
> +static inline u8 get_vtl(void) { return 0; }
> +#endif
> +
>  #endif
> --
> 2.45.0
>=20


