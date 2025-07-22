Return-Path: <linux-arch+bounces-12886-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08668B0E2C8
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jul 2025 19:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DA12564F3A
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jul 2025 17:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D9A28136C;
	Tue, 22 Jul 2025 17:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="nv1nBVNo"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2012.outbound.protection.outlook.com [40.92.41.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED85A280308;
	Tue, 22 Jul 2025 17:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206229; cv=fail; b=eI+Ox4WW5D3IHVszzV1wDlvnGm8+wPhLuhtT0hwaDUmATigrkZn8LZQexUPqAU05+PTvQ7DCLObkruXLqw5DlrD4WALOtwOwnquQCsDC4ynEbG0EwBxFI72GmL5s9yaedB/gPXGoH/Rrx7uiK3L9iOizMd4NdLiK05TaMv27qRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206229; c=relaxed/simple;
	bh=5Gqr3xfYWj4LlAydGJb/ZBfPMMcn/Hqhn2PMWx7zhdM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pz8pz0fvPNSeH6thzHy7gDm8QNck7bab3N91t45kCcpVAUsRB5W93yXJSbN+hpvulrz7nNtzq4eoUbHSIz/qoYhHlT1ssbjvGJyzy9xLqweKUBiHPPiA2VurXCQqogl0ON95y0co5aX2Cj5EMvt+Bl5xtneCJj7ofNY88gvPEbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=nv1nBVNo; arc=fail smtp.client-ip=40.92.41.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FAM/skxahBYse4+7jiZKDoAppcpclZCfJRBcaN2I18NMUL/PbZp/IbbwL6BE5EJlRXXT2tXmgVwHlSdEHy0XstM6aZasYHX1RYXdlfxGUI8iehzFxY1P29/oDWsXgwR5xv1Gv4FyrSyRaEZWuqMBQeWTNfbEoCHkTtgwBhh8C0Ccx4uhsIPvnUSzDu8fBGrigUxpXQ5dHUENZEOOc8n1pnNZjkXV2X1lhThyWcPL4gv5+KeNt58aoJN7wwtrt8NgaInOJIbh/Ozh6YTi0lG8YxSSwyoXA9tJdpzdrsbKkkMqlvPKzfVtpqjLfv+v8zYsicUXjcNfkEulIC3bnC21Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caK9C8Th/Mkui5vEu0HKRt/b/HoyQWWMETHpnxyx6WE=;
 b=GNLlbcUEztVJ7/qGzRNeO1ImLne3lGGO2n3ePY2Eb13dE1G3PliiWso7qCbTxjeTrSlVYGjRHfDYtvOwqm/PtyAQqHwPxPSeztkEBQKj50V9YNN1EzFkQzgM06UbJua2ND2T4LsZ3JH52fp+kg7yLo1s/VuHY2QjvR/661468XDNzkAAnjNhAkm/43XVLRAPpKfBL/jCRjmI7xE/WRxjvsOsQ82GuaWuyRNZD0wLb0XcyermXmXLnDQ7IwRAaq7p0r/cifZVDVAzEMylMHQH4pWJs1JxhyIHhBJAxOx5zJAN6kKqO0cI9x7u8/a5SvmvZmJRdvJdJw+8Xee34DD6dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caK9C8Th/Mkui5vEu0HKRt/b/HoyQWWMETHpnxyx6WE=;
 b=nv1nBVNorTZJddIoj4HvLXoZUxjwBFlQMPHS9ZNgSVd/y6y0ZVMG1o1bFSgyfesLi9xyb6FYB9P/RuV/9bZWcbbvIXNRp3SpKHLTmfLiLV3H46U6wYapbp6B1e8dHFTbzZsf3XbT8RqNfh2Sz3eujyzCT6+QKEHEVuaovSubXFSqSedadC7RHGF29a+I3hRbvvk3ngJEEGvxmoU7AwFRr3DbyCVXQeBBKO4x/ozck0Lq+F9Z974ZHSgW1Tde7PRmeWMVFYuXr6jcqKbz7e9h0sAmzZ+52PrPKgIP7LKIUzUhmORRGhThG75UUgdhf7qMuJp8b1cBHR+nFqpxhxg24g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY8PR02MB9201.namprd02.prod.outlook.com (2603:10b6:930:9c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Tue, 22 Jul
 2025 17:43:45 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 17:43:43 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "alok.a.tiwari@oracle.com"
	<alok.a.tiwari@oracle.com>, "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de"
	<bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "Tianyu.Lan@microsoft.com"
	<Tianyu.Lan@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v4 03/16] arch: hyperv: Get/set SynIC
 synth.registers via paravisor
Thread-Topic: [PATCH hyperv-next v4 03/16] arch: hyperv: Get/set SynIC
 synth.registers via paravisor
Thread-Index: AQHb9QzcX6OpWDG/Ek+7YukU8dI+oLQ4S4Ug
Date: Tue, 22 Jul 2025 17:43:43 +0000
Message-ID:
 <SN6PR02MB4157C9A80037D1D37FCFB56DD45CA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250714221545.5615-1-romank@linux.microsoft.com>
 <20250714221545.5615-4-romank@linux.microsoft.com>
In-Reply-To: <20250714221545.5615-4-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY8PR02MB9201:EE_
x-ms-office365-filtering-correlation-id: 1fd48242-aca1-4470-1fdb-08ddc9474d9a
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|461199028|41001999006|40105399003|3412199025|440099028|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vqFaJBJpZLkSR1FzoOcm2OI+TKpc8kQ989z3ygD2BltMboODXhDbtQtfjL2F?=
 =?us-ascii?Q?Cf4hN26ruWscPoIuMp8wjFQ18rBfHajB5zJfJyQEQSTuwc41XSYl6wWxjHcj?=
 =?us-ascii?Q?E5XT1bRiC7hGY0Xk+lh0FAkgGo3y0dkdwgiojQfvdlcOKUZxsbRGV1XtZ3NH?=
 =?us-ascii?Q?YGrEf0lX6HLnlmGBw/3JKJgV6cmxvmQF3rimn/aYXW0B7tTcZPsks2E5yV0B?=
 =?us-ascii?Q?qSl8pAFua1TamssugI58cYX6hXNlARfGazRQSs5fBPJmf79bpY+pF3agYjiu?=
 =?us-ascii?Q?puW2R78t1zMFd21Rp5s/qxdmoC8ZOFVrNIHlKV7YcP2miq26PpGX5Z2gZr3S?=
 =?us-ascii?Q?7feEZAGPXw0xmj47eaj2jAcomrJ8prQTAwji2zmdTx8jc3nkeZaYR/00OQYI?=
 =?us-ascii?Q?SwNx5bWGLfC3/ulzns0dtTE2oa7IlxtQAlFGfLXU236y3g9QWtqwOqgSfKGg?=
 =?us-ascii?Q?X0w2mNTGMJppNW9L6v6iSM+UlKkOBYbTbFfJwh47laReikFPd5b56W/BJB8S?=
 =?us-ascii?Q?ppKP4T9s/QmDcUGtjujK4mlo8kLLotJPDKxlKOj9ko82iVjp5l/Pyw72isB6?=
 =?us-ascii?Q?62pSgh96aCMlDFnIR5ht5Za1sLqGcVotctbf5ZC3cOSm1lnb4riSf0eAVwL/?=
 =?us-ascii?Q?vsMufPrLl+0G7zZoTTPIDQvoI1OZFqy2y21pXB1nD7apr1rfnrd+DvIrjsna?=
 =?us-ascii?Q?AKOjlwK7fw71fc4n3prUKyMxv62rvQXydfr4v7wsS3A2jJH5ey+0uZ+W47hQ?=
 =?us-ascii?Q?4nx9Pn9xoFMIZqSZ/PLd2ZkE6CQfyu8FQUXsDLFGEuyLSQ/P42RxwWWlpdtk?=
 =?us-ascii?Q?vklVXktiU44xUKCt/Fq2vhCWWMZmtuUP0nHYaMtB578yduGHsl+ONSL4LJCP?=
 =?us-ascii?Q?uljTsi8/vM0CIpe3ct2z0THC1G8vX4E5ZRYhRnPxlL7E9xDkgVG+G2rtdkSA?=
 =?us-ascii?Q?o0VvoWmIes+g7iHkxWTqCBEBtcOEu2VekmYC4J/skEQsmlQrFgwEBEOgQBRL?=
 =?us-ascii?Q?vcJRmnaZJB8HE6W/ZUrrnSbIxzcMDVv9ylpNNRqAZN2pIZfuxlAgZ8Dy0+2w?=
 =?us-ascii?Q?TVkwav4IJLMJ982nxe04w6VAIcS8ng=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6XaLyKOygRfKuVujTMi7aUrghYQWxNDAQc/dxZNITAaQ2tB8eKIpsYK2HNuH?=
 =?us-ascii?Q?gtPOgrJ01P5Hjaq+7aDFyPYkTyUqLz7p2pgeO+8pwfIIvw/RdRcUt6Tu2g1i?=
 =?us-ascii?Q?m269ljSziInvSAOOHI2Saq2gPadNZeagX8ciGsKgyUzEXHuYKqUz63SoOEpF?=
 =?us-ascii?Q?/KEfs7M92CPz545AoI5FeXgJ2SUvkPRvRQnz5yTR8AkVAaCOi7R4tYzIXzKx?=
 =?us-ascii?Q?tntBUsFrUHKFgcOxb2gsfK81jy9R05afmdleE+bEPC0+uhcCEFy2/9FPZxEq?=
 =?us-ascii?Q?gx8eUhZLNSdXVzvRd2aKsUGILAF4BwjcVgmyL2P6ffXbiGqltY0RkGtLy2uR?=
 =?us-ascii?Q?7ai/N/oWseLlkghH5xrZzUW57Jv4CApN0R5Mb+8ZXN6kWiTDxsFbjMtTll1i?=
 =?us-ascii?Q?fU9J6+e2u1YllEBK/hwK8l/Wno2VxFgj0NIKmESnjk0kFdowYsr5iSscyHFE?=
 =?us-ascii?Q?F20+Tzrz09eC0n/+xUXi5V277lzxRn8zGJ3jwZ7X8U/S5JvoVEY4Bvm+xxDl?=
 =?us-ascii?Q?NhM637KdaeeXju1333p+qUnevlBA6waXGwXTRg4WYRWxZ8wIHD+k7/FnhfiI?=
 =?us-ascii?Q?bZReSq7ft/Q5gfDnbi73il2dmYfyVcyqSu1D6u/UBr+yyUOXX+8o/ABxBYPQ?=
 =?us-ascii?Q?0dTGLjssy3FIn1njpE3AF/aaeFewCW0BFiwobqFq1xsAQ00JTCMjYSUN1/u5?=
 =?us-ascii?Q?zobKUy4xDjYztSvK4Fluby+fYQBEpqr79l3DeGe/62ANRjvIZUoGlHzp9Sj3?=
 =?us-ascii?Q?rw66XB80P1LqesPMpvRl5KkWt3X1SG5wZreMXRxsjQcU+jmV5JpEYhWQyjgN?=
 =?us-ascii?Q?MHbJMGRpj+hOgvevnWoKL5Oas05/wXOETU4My7Vl48/e1UDeXJa8kXaaaNLV?=
 =?us-ascii?Q?QNBXvjZOcl5jgI7qGILticAfM8IvDOjzEyhjiraaUssT/emSPpH9y8viJ33U?=
 =?us-ascii?Q?VVeB0PpILiBullodjMTJztQyPIDG1fIHVZl4Qp5rYX7C2+bgv4h3WhWXbjvV?=
 =?us-ascii?Q?pxRVKoI2hwhjFLphE0cvT8qCVugjuiAyxlw2tM//G2L/XhOlvK/D676k3alI?=
 =?us-ascii?Q?TC20zvAYbWFBrDHXQxiiOzDUhnHmpXY/+4j2Lfarkf6yBjThHBIHBcLrQO4F?=
 =?us-ascii?Q?AqoocVullgVgHpoquVYaQVTunXSEvIJ1uWnvL09MqrNhqI8ac0O9x3WSWrpT?=
 =?us-ascii?Q?bL4zb2ozDGxDjZUMwh4GFyKr2PvP9QO4lyZBLDlFeWrCY4m2EAObTCx4TK8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd48242-aca1-4470-1fdb-08ddc9474d9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 17:43:43.8181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9201

From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, July 14, 2025 =
3:16 PM
>=20
> The existing Hyper-V wrappers for getting and setting MSRs are
> hv_get/set_msr(). Via hv_get/set_non_nested_msr(), they detect
> when running in a CoCo VM with a paravisor, and use the TDX or
> SNP guest-host communication protocol to bypass the paravisor
> and go directly to the host hypervisor for SynIC MSRs. The "set"
> function also implements the required special handling for the
> SINT MSRs.
>=20
> But in some Confidential VMBus cases, the guest wants to talk only
> with the paravisor. To accomplish this, provide new functions for
> accessing SynICs that always do direct accesses (i.e., not via
> TDX or SNP GHCB), which will go to the paravisor. The mirroring
> of the existing "set" function is also not needed. These functions
> should be used only in the specific Confidential VMBus cases that
> require them.
>=20
> Provide functions that allow manipulating the SynIC registers
> through the paravisor.

This last paragraph seems to be a leftover from a previous
version of the commit message. I think it can be deleted since
the second paragraph now covers the topic.

>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 39 ++++++++++++++++++
>  drivers/hv/hv_common.c         | 13 ++++++
>  include/asm-generic/mshyperv.h | 75 ++++++++++++++++++----------------
>  3 files changed, 92 insertions(+), 35 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index c78f860419d6..07c60231d0d8 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -90,6 +90,45 @@ void hv_set_non_nested_msr(unsigned int reg, u64 value=
)
>  }
>  EXPORT_SYMBOL_GPL(hv_set_non_nested_msr);
>=20
> +/*
> + * Attempt to get the SynIC register value from the paravisor.
> + *
> + * Not all paravisors support reading SynIC registers, so this function
> + * may fail. The register for the SynIC of the running CPU is accessed.
> + *
> + * Writes the SynIC register value into the memory pointed by val,
> + * and ~0ULL is on failure.
> + *
> + * Returns -ENODEV if the MSR is not a SynIC register, or another error
> + * code if getting the MSR fails (meaning the paravisor doesn't support
> + * relaying VMBus communucations).
> + */
> +int hv_para_get_synic_register(unsigned int reg, u64 *val)
> +{
> +	if (!hv_is_synic_msr(reg))
> +		return -ENODEV;
> +	return native_read_msr_safe(reg, val);
> +}
> +
> +/*
> + * Attempt to set the SynIC register value with the paravisor.
> + *
> + * Not all paravisors support setting SynIC registers, so this function
> + * may fail. The register for the SynIC of the running CPU is accessed.
> + *
> + * Sets the register to the value supplied.
> + *
> + * Returns: -ENODEV if the MSR is not a SynIC register, or another error
> + * code if writing to the MSR fails (meaning the paravisor doesn't suppo=
rt
> + * relaying VMBus communucations).
> + */
> +int hv_para_set_synic_register(unsigned int reg, u64 val)
> +{
> +	if (!hv_is_synic_msr(reg))
> +		return -ENODEV;
> +	return native_write_msr_safe(reg, val);
> +}
> +
>  u64 hv_get_msr(unsigned int reg)
>  {
>  	if (hv_nested)
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 49898d10faff..a179ea482cb1 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -716,6 +716,19 @@ u64 __weak hv_tdx_hypercall(u64 control, u64 param1,=
 u64 param2)
>  }
>  EXPORT_SYMBOL_GPL(hv_tdx_hypercall);
>=20
> +int __weak hv_para_get_synic_register(unsigned int reg, u64 *val)
> +{
> +	*val =3D ~0ULL;
> +	return -ENODEV;
> +}
> +EXPORT_SYMBOL_GPL(hv_para_get_synic_register);
> +
> +int __weak hv_para_set_synic_register(unsigned int reg, u64 val)
> +{
> +	return -ENODEV;
> +}
> +EXPORT_SYMBOL_GPL(hv_para_set_synic_register);
> +
>  void hv_identify_partition_type(void)
>  {
>  	/* Assume guest role */
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index 9722934a8332..9447558f425b 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -162,41 +162,6 @@ static inline u64 hv_generate_guest_id(u64 kernel_ve=
rsion)
>  	return guest_id;
>  }
>=20
> -/* Free the message slot and signal end-of-message if required */
> -static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_=
type)
> -{
> -	/*
> -	 * On crash we're reading some other CPU's message page and we need
> -	 * to be careful: this other CPU may already had cleared the header
> -	 * and the host may already had delivered some other message there.
> -	 * In case we blindly write msg->header.message_type we're going
> -	 * to lose it. We can still lose a message of the same type but
> -	 * we count on the fact that there can only be one
> -	 * CHANNELMSG_UNLOAD_RESPONSE and we don't care about other messages
> -	 * on crash.
> -	 */
> -	if (cmpxchg(&msg->header.message_type, old_msg_type,
> -		    HVMSG_NONE) !=3D old_msg_type)
> -		return;
> -
> -	/*
> -	 * The cmxchg() above does an implicit memory barrier to
> -	 * ensure the write to MessageType (ie set to
> -	 * HVMSG_NONE) happens before we read the
> -	 * MessagePending and EOMing. Otherwise, the EOMing
> -	 * will not deliver any more messages since there is
> -	 * no empty slot
> -	 */
> -	if (msg->header.message_flags.msg_pending) {
> -		/*
> -		 * This will cause message queue rescan to
> -		 * possibly deliver another msg from the
> -		 * hypervisor
> -		 */
> -		hv_set_msr(HV_MSR_EOM, 0);
> -	}
> -}
> -
>  int hv_get_hypervisor_version(union hv_hypervisor_version_info *info);
>=20
>  void hv_setup_vmbus_handler(void (*handler)(void));
> @@ -333,6 +298,8 @@ bool hv_is_isolation_supported(void);
>  bool hv_isolation_type_snp(void);
>  u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_=
size);
>  u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
> +int hv_para_get_synic_register(unsigned int reg, u64 *val);
> +int hv_para_set_synic_register(unsigned int reg, u64 val);
>  void hyperv_cleanup(void);
>  bool hv_query_ext_cap(u64 cap_query);
>  void hv_setup_dma_ops(struct device *dev, bool coherent);
> @@ -375,6 +342,44 @@ static inline int hv_call_create_vp(int node, u64 pa=
rtition_id,
> u32 vp_index, u3
>  #endif /* CONFIG_MSHV_ROOT */
>  bool vmbus_is_confidential(void);
>=20
> +/* Free the message slot and signal end-of-message if required */
> +static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_=
type)
> +{
> +	/*
> +	 * On crash we're reading some other CPU's message page and we need
> +	 * to be careful: this other CPU may already had cleared the header
> +	 * and the host may already had delivered some other message there.
> +	 * In case we blindly write msg->header.message_type we're going
> +	 * to lose it. We can still lose a message of the same type but
> +	 * we count on the fact that there can only be one
> +	 * CHANNELMSG_UNLOAD_RESPONSE and we don't care about other messages
> +	 * on crash.
> +	 */
> +	if (cmpxchg(&msg->header.message_type, old_msg_type,
> +		    HVMSG_NONE) !=3D old_msg_type)
> +		return;
> +
> +	/*
> +	 * The cmxchg() above does an implicit memory barrier to
> +	 * ensure the write to MessageType (ie set to
> +	 * HVMSG_NONE) happens before we read the
> +	 * MessagePending and EOMing. Otherwise, the EOMing
> +	 * will not deliver any more messages since there is
> +	 * no empty slot
> +	 */
> +	if (msg->header.message_flags.msg_pending) {
> +		/*
> +		 * This will cause message queue rescan to
> +		 * possibly deliver another msg from the
> +		 * hypervisor
> +		 */
> +		if (vmbus_is_confidential())
> +			hv_para_set_synic_register(HV_MSR_EOM, 0);

As reported by the kernel test robot, this function call is generating an
error because there's no declaration for hv_para_set_synic_register()
when built with !CONFIG_HYPERV.

One solution is to add a stub higher up in this source code file in
the existing !CONFIG_HYPERV section.

But a better solution might be move vmbus_signal_eom() out of this
file entirely and put it in drivers/hv/hyperv_vmbus.h. Then no stub
for !CONFIG_HYPERV is needed. vmbus_signal_eom() is very much
a VMBus function, and it's only called from vmbus_wait_for_unload(),
__vmbus_on_msg_dpc(), and vmbus_message_sched().

The file asm-generic/mshyperv.h should be focused on the Hyper-V
interface, not on VMBus, so it's not clear to me why vmbus_signal_eom()
is in asm-generic/mshyperv.h in the first place. There's no reason to expos=
e
vmbus_signal_eom() to code that needs definitions related to Hyper-V,
such as the x86 MTRR code or the Hyper-V emulation code in KVM
(which is where the kernel test robot detected the error). Note that
drivers/hv/hyperv_vmbus.h will need to add #include <asm/mshyperv.h>
in order for the move to work.

I've tested build with CONFIG_HYPERV and !CONFIG_HYPERV on
x86 and on arm64, and the proposed move seems to work OK.

Sorry my suggestion in v3 of your patch set to handle HV_MSR_EOM
here in vmbus_signal_eom() turned out to be more complicated than
I originally contemplated. :-(

> +		else
> +			hv_set_msr(HV_MSR_EOM, 0);
> +	}
> +}
> +
>  #if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
>  u8 __init get_vtl(void);
>  #else
> --
> 2.43.0


