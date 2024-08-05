Return-Path: <linux-arch+bounces-5958-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E939947391
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 05:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D9BDB20925
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 03:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F57B13C820;
	Mon,  5 Aug 2024 03:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cJyZpogg"
X-Original-To: linux-arch@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010012.outbound.protection.outlook.com [52.103.13.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CB62F50A;
	Mon,  5 Aug 2024 03:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722826951; cv=fail; b=RYmiWwqAD5iykVJ2CBtV7LUhtlL89tM7gKhfGjLDeo2WXUcExzZBWysgyhwEFPL77k5Z0WispFQvgIaHx2f6zncRIgW8jaIDwRgS7emexM3l7xm7kWMD4hMb0rCw0dgECM0ESswdrg3BWl6A4KD+DSFxpmEpxdmeurEnzvrHp7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722826951; c=relaxed/simple;
	bh=pTVxgmF6TPJ27Cll3EWcMqqo8I9pJd/j3BSvHM9VeQ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ny4Q5VVscvdmeGLpj+dCksjX4fEllOKr9LsG04pTRs4u3imZUtQ7UpRcyzqXuAH/P5zIWDsPKwnuxZ75lCVgwanfVhnb/emFOkCzk/XMoUTKTF0dj97/XKjTwrvVjLE0PP8uQG3T5cX7yirmK7iu/MLBCqK9cRo0IzPBc9X759w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cJyZpogg; arc=fail smtp.client-ip=52.103.13.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HoGkxrtFMgLCuZyPZexZWgXg74NivesuokRMOLzZHSTBG3sFoAvs8foIsv66Yx9IlNX/gNGBp/3ElvmvM2uhYrbhQhGGAcqfd2l9qiezHUmeEKi/VyX6V4sFPMv4dJ/dSwnQHd6uaLRxNUKgKaEIPCyKH6QLeg+G1pr2GoY9K7yOocbEOPzj9eWd/DYf7W5L7DMvq3PoUvjK1m3VJFMsSq9L2T03zjrUSOqb0xllk4WsotCTTz4F1uMe08mMlAK9vLPxMaGWNzbzHclEnEBECKjru8BnGFPrPg4a/J7z9QvE+UWYwqcc1byMVfKo9wHaq/XijTZIqc/1nJbgf1Srhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JM+UeM8Eg5bnn8mPWElsFzYwyGN3nQ6oduJsj1qHrMc=;
 b=DORbuCtDJXc/C/Umx9ZmTL5ZXNC8mQhuT1WEjCriVsy27pdYfy3GYJfq4wRnXDocZNEJucWK01HUFHRJJP99EgErja8kRPRIk1GPUgh5E3gZdQWx7h0WCVKXKnNriLXMM6Hwcz7pak2yM8SqQQZb0aZ2ckMBVQzoyM1+fAfqWMPNNG+N2W/ZP0FHmZQ705STCpwl2Zz+nBVf1SmPVwQlZFoj/LIGXl7SuAhlPjKAwzwhbdFjaeilCgjNYrU+nWsNpPB8sNOgz+oeEHRo4doCdUL1BZbS0uCXBr7/DuELlxyQy/9gSs5vlU9w3MiNRdn+C17GVYGumnSfLrCwHN8Isw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JM+UeM8Eg5bnn8mPWElsFzYwyGN3nQ6oduJsj1qHrMc=;
 b=cJyZpoggEXE8XsB/vKugShVgGEdUQYXqD9K5eBys9TDN469+CRBMwNrm2Xk4ypK+QNm/+9/6jCS9Tr56QY8Hb71nA3sfAaew5rKJM3AduEU2UtarmOgM+NbjFxWuThHhyAJDOPfgA6/sZZ/ExZ+d5JpAD0MW1ESy4MmIZJeTJngjAIzIQ5SDhcfRFuvw+30XIRTc/wjvoEZhnvBt27D6KyYNVLu/EMy4R45K0/CuA0AzfG2ezpsGfSj/mTvqG8u7sO1mBE7sCk92rPhYysfAWoP20LluJGjjnrP2Dy+OyDhGPW2FV6YGHK8ZOMIAIho/dfnZHV2Ads5T4c27y0V/rg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA0PR02MB9464.namprd02.prod.outlook.com (2603:10b6:208:408::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 03:02:26 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.7807.026; Mon, 5 Aug 2024
 03:02:25 +0000
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
Subject: RE: [PATCH v3 3/7] Drivers: hv: Provide arch-neutral implementation
 of get_vtl()
Thread-Topic: [PATCH v3 3/7] Drivers: hv: Provide arch-neutral implementation
 of get_vtl()
Thread-Index: AQHa36+rCNifEohEckuGLNQ9pio1DrIXTyyw
Date: Mon, 5 Aug 2024 03:02:25 +0000
Message-ID:
 <SN6PR02MB415759676AEF931F030430FDD4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240726225910.1912537-1-romank@linux.microsoft.com>
 <20240726225910.1912537-4-romank@linux.microsoft.com>
In-Reply-To: <20240726225910.1912537-4-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [ftMRn92yRY63hxw4DC1UxguAGfmABveE]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA0PR02MB9464:EE_
x-ms-office365-filtering-correlation-id: 2d68dfaf-59df-4915-6000-08dcb4fb08f2
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799006|19110799003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 zfG5YUa9qneQ1NUXp2apdjghXB+SwCVMGDvoJzzKrNdUFg8BByGw3r/bT9YQ6lMwyw0Rqbr+hs6Rp8c+g02lDoUT+X9BjFFwuzwvWt1AaI52JAzgLJH+IeEu2AVB/DWPNnpFR0u+5Pzaif5fsTXf1b82O6BS1P1KAn+KLhUtevD2nbVhj+QOKTDsCCHry0xP6X81SY37jj6SUAWDvxTtp7WBR2trmyDY6iFkXnscRbLpwX/H0AOtyXyX/FfWZ0biXddEzEdQgl8Uky1hLRb3rWWdcQx+xn1vKhhzCbZ6ONbpk0ZPFGH+GG68eGRCGGAD/bxWGrp46XFLwLmIdFGjfbCKkHmHQ+REhis7PRkdPTVEQD/omDMAU+hD9K80oPQR9EfCtHu8GTdc89tAB4XuH+TdLdCs6HZk9U7fSMMhBN/1lVlVgqqCxAHCOp0Li2F4MsTgePwSan5NWlXEwf1XsJVyH9w4vYW5t+ORfgWtaNeWeXHU3iODoXI7Iouo+XUTE+UlG8BQndTA8teH+hrOCubyBHBL1u3gmM0pQI9xQLjFFO/6K53jm1FVhHcb0WwUKnkM7PcZZR5P24bWsIrEWrIb7yyjw8HvKwANfrPNF266r4rjFDJnYmBXN7lriVdWjwQ17phms19ZgN2HlwAlZg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kNP0jQjbcaYr637/yW8qq2hpYdtKOh2/amXCLb7E/x2tpWKGxEXLF0j0s24q?=
 =?us-ascii?Q?HjHtt2ieAP2THxrVQzyCMFENjfJQc+9ptpPUAkuzBAuTuq2feiV5wWqn50/M?=
 =?us-ascii?Q?84XOGy4mY+T7JkGPyUyb9IQ2Z6mM81jSARHj/SkQmZqOemEYyErRFpJSJWGP?=
 =?us-ascii?Q?lMbRInvmoCmN9MrkI3KMqodjSC9Xc7OP1krf+z3/METIbORvWBFvwiAxlpkv?=
 =?us-ascii?Q?Cz/t5T3yMXdOVolizlkyuK0PFuLSQhX6niKGyNdwMREtnKPjRVSgbgRK7f55?=
 =?us-ascii?Q?cR+OE9eKNrXpH9K2Pq+8y1ww+hjpbZT4+cKDZvupsvbYQu7TkbZdVGDaIEEL?=
 =?us-ascii?Q?PbP7SpqPr3FTDSFeuGiqij8mBGbcJl4VHXyOgq051BmpGJgNvILUgokrLGEn?=
 =?us-ascii?Q?h/niTLT+/ozPlclYTdzv+T0bKURWZ7WNTa4iUQM+K487r6xXFIIksKo++0QT?=
 =?us-ascii?Q?UL6na+bRduQAXMiwDu1YvEa14x9ZLFSKM+gG/aCpcyUdEfpG5qPZQnaA3fFn?=
 =?us-ascii?Q?F0J9rvE+Su8S3ZUv5ohZJ3MiKpM+xPWIabys/mC0PhWRkw4yqNqLycpXJ6LP?=
 =?us-ascii?Q?VBgOwnNlc7GJ387zQbnZ/gE9kygaozoxf1hyy4lAdyenxzjC4ZqCzi867YvG?=
 =?us-ascii?Q?TJGCieI7l8eW3Ic+K6etw80QmuGmh61toUGe9pCfMSSDjQxR95t7BKa3bK25?=
 =?us-ascii?Q?cn2E8MF7llTslfCFLXo48kyfTTPazueD8zxKI2A2Is+c6m8jOYudrtUhEQac?=
 =?us-ascii?Q?tleiroqy5fPur8RcZIMfM0jz2ZTQ6+qXqN8AYrfPtQvOeF3T/S1YYGjuxc+j?=
 =?us-ascii?Q?5feLjof2uoNhn3Wdxj9w9i0uyoErr/6ELX/8/NbFvOIM9RA091fUL3ql8eOr?=
 =?us-ascii?Q?46tW5+/GHd2rBuudGp5h0kNyFYlzxvjDDTTIrzorolxeTHDfg+G1yZbIMZDq?=
 =?us-ascii?Q?06vqQaBG5c6RGtYoW3bNRs+f00YiyngT2jo1WVlO23mFbVVv+uAQ6qGamCQ5?=
 =?us-ascii?Q?+6IDRcNRswfZkXRoUhcRIcJGn/yGbo8824fhyuFCJFMszah9aP0joFkZWZ5U?=
 =?us-ascii?Q?qJ9fpCHQUplKt7/ybAylIN4tbW6YBSJHfuMDLPsihz16hMdGu7g6eOxYPv9/?=
 =?us-ascii?Q?KhQbMh49S5jxo2wGlX1eM2MGj/zj5lDGhfce2yiL6XmWoNwqePFFHGr/tRXC?=
 =?us-ascii?Q?4L/WkyQfGUL6C2ZCr8QdsI9KGMNM5OOH6zArrP2l/2GtTkLeiYlT1PpG6gA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d68dfaf-59df-4915-6000-08dcb4fb08f2
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 03:02:25.9388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9464

From: Roman Kisel <romank@linux.microsoft.com> Sent: Friday, July 26, 2024 =
3:59 PM
>=20
> To run in the VTL mode, Hyper-V drivers have to know what
> VTL the system boots in, and the arm64/hyperv code does not
> have the means to compute that.
>=20
> Refactor the code to hoist the function that detects VTL,
> make it arch-neutral to be able to employ it to get the VTL
> on arm64. Fix the hypercall output address in `get_vtl(void)`
> not to overlap with the hypercall input area to adhere to
> the Hyper-V TLFS.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c          | 34 ---------------------
>  arch/x86/include/asm/hyperv-tlfs.h |  7 -----
>  drivers/hv/hv_common.c             | 47 ++++++++++++++++++++++++++++--
>  include/asm-generic/hyperv-tlfs.h  |  7 +++++
>  include/asm-generic/mshyperv.h     |  6 ++++
>  5 files changed, 58 insertions(+), 43 deletions(-)
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
> index 9c452bfbd571..7d6c1523b0b5 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -339,8 +339,8 @@ int __init hv_common_init(void)
>  	hyperv_pcpu_input_arg =3D alloc_percpu(void  *);
>  	BUG_ON(!hyperv_pcpu_input_arg);
>=20
> -	/* Allocate the per-CPU state for output arg for root */
> -	if (hv_root_partition) {
> +	/* Allocate the per-CPU state for output arg for root or a VTL */
> +	if (hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE)) {
>  		hyperv_pcpu_output_arg =3D alloc_percpu(void *);
>  		BUG_ON(!hyperv_pcpu_output_arg);
>  	}
> @@ -656,3 +656,46 @@ u64 __weak hv_tdx_hypercall(u64 control, u64 param1,=
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
> +	output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);

Rather than use the hyperv_pcpu_output_arg here, it's OK to
use a different area of the hyperv_pcpu_input_arg page.  For
example,

	output =3D (void *)input + HV_HYP_PAGE_SIZE/2;

The TLFS does not require that the input and output be in
separate pages.

While using the hyperv_pcpu_output_arg is conceptually a
bit cleaner, doing so requires allocating a 4K page per CPU that
is not otherwise used. The VTL 2 code wants to be frugal with
memory, and this seems like a good step in that direction. :-)

The hyperv_pcpu_output_arg was added for the cases where up
to a full page is needed for input and output on the same hypercall.
So far, the only case of that is when running in the root partition.

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
> index 814207e7c37f..271c365973d6 100644
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

s/there is no an associated/there is no associated/

> + */
> +#define	HV_REGISTER_VSM_VP_STATUS	0x000D0003
> +#define	HV_VTL_MASK			GENMASK(3, 0)

Further down in hyperv-tlfs.h is a section devoted to register
definitions. It seems like this definition should go there in
numeric order, which is after HV_REGISTER_STIMER0_COUNT.

Michael

> +
>  /*
>   * Group B features.
>   */
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index 8fe7aaab2599..85a5b8cb1702 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -315,4 +315,10 @@ static inline enum hv_isolation_type
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
> 2.34.1
>=20


