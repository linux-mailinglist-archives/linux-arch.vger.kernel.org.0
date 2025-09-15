Return-Path: <linux-arch+bounces-13636-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0185B5841E
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 19:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5471F4C327C
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 17:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429762BEFE6;
	Mon, 15 Sep 2025 17:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Ih7ja9tn"
X-Original-To: linux-arch@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012086.outbound.protection.outlook.com [52.103.20.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0452BD016;
	Mon, 15 Sep 2025 17:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757958978; cv=fail; b=PphgiF7HozDvnooMRObHK9AK9VZbEuQM0+CqdIGfyNxofyfe17AzqP/pRM7eu8qAOZJOwOt8zuC3G9GMXiCwwHr0iU458ZAiEN6KS0iqR5eOEkx/LtqhD3SRqdyVZhCxcTAg+a6wZcxeFecA2rfo1HmB22lO26xNWvC55gEt9Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757958978; c=relaxed/simple;
	bh=A2V9axL0CK3Mk3Eg9PAktAVxkNmLOdCLDCfDb0llcWM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MW6N53Ahed7zHgZAJVmzvbpk8QqQ/ujlhymXtJlVx03bJlw7v9I1QSJpRWmSs9o01eTLGN66syTYcJLj200+KdUdR/xOYmYW7jeVG1VodoQzWAnnS3YPAetwFMkqhJw+zlyrooXDZIo1h6M+UhIXBfRXvXtnVPWrkK8VBoWBCOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Ih7ja9tn; arc=fail smtp.client-ip=52.103.20.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/vvhPGqQQA9NmYhrm7qorijTFQxUMktboM0usv0Xd+ug1VqzLt3RiseY5p9nMI+nZKbnto/qXu/cPJ9NJEAHdY01ad4507fXaPlbCHcGxfDdq0Ro2nxMFwuKVTIeQ3fxfBPpRV6Etihi7NPE2pv6wpruIZ3JUOBTK+fje5pCGOVoqqusrGVk6Nxg7WrvA10InqNYv5inLsMnkcmZX7ok8gyCbxLuzmFQf4lZMRYjLA0xkeskSztJRdeef5ule3wH7CV3UCTFjdtlUJjv+uVOP/V3VarwYk1D0G94ZR4LdmqVydBSHzR9lT5fUKZ27GODhztpoAam5aVSY0YmidWaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tl6YLICMu2uTOwAq9CpBZwOiHgEoMxX3ABozcvr3Qsc=;
 b=wvucBIh+8TMqKyNw+BMcZOQ0K6wjgIp2V7UcM4LJx1pxb7lv0OB9CdzP9NwPGvQdZAqdjkPkBTYvht0yu5lcahl8UKKxK6ZERJHZDib0nuTyEH+Euyhs09753j1dyw2s3cSKq/VIOwgy8ymLFgyu2RHu4vFIotKHrE/amnF58CRzG18w3jeR91vkk8EdItUocsZP8lqyDzKqEYE3LG1OvVrfJ3PSQoYqpmdjV6VvtNgi4ozH93VQ7JBZ9k2NiK8U+XlitkumsV1aSxUjTtCUppc/PReo68pnGeX+qXcoGsnOB29YO24CEzFBdnyAl0rzu3t0Zrn8cirKj5CylHDCoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tl6YLICMu2uTOwAq9CpBZwOiHgEoMxX3ABozcvr3Qsc=;
 b=Ih7ja9tng4p+yOUGXjcroSPDduNgKye3N6Hs8JxFhQyHtPpA7M8ZvAhG6j+6rmyaQHDgrSZZgeKFDphBNugevT2GUms9ESydNsWw2R1nNIasaP0/n7XIlny2kYcnJoIDQ1jmmqLOB3dMRMwODBefGaarQw5Tp+5zQ291RaMyK4s39g9H6wEO4AcstkThf12b/17Ulmve7XyVdxL4dWJHbkng7JBiwHWyDZXZyfs+SRORCyC3PVk6v+aXOAfaC9SnNc7PLUQIKOX+DlxltDo0evHM8lvEPgA40gvaxzgjMA9rhz9Vx48m3/+xRfD3a0VHyTff4Ehew7YVYk/uNUPIxg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV3PR02MB10056.namprd02.prod.outlook.com (2603:10b6:408:19a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 17:56:14 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 17:56:13 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Mukesh Rathor <mrathor@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"arnd@arndb.de" <arnd@arndb.de>
Subject: RE: [PATCH v1 6/6] x86/hyperv: Enable build of hypervisor crashdump
 collection files
Thread-Topic: [PATCH v1 6/6] x86/hyperv: Enable build of hypervisor crashdump
 collection files
Thread-Index: AQHcIeeD/3QUCmD7EEewGvIyXSLQYbSUe5GA
Date: Mon, 15 Sep 2025 17:56:13 +0000
Message-ID:
 <SN6PR02MB415730C50D722D289E33296ED415A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250910001009.2651481-1-mrathor@linux.microsoft.com>
 <20250910001009.2651481-7-mrathor@linux.microsoft.com>
In-Reply-To: <20250910001009.2651481-7-mrathor@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV3PR02MB10056:EE_
x-ms-office365-filtering-correlation-id: e256ef43-ce9b-474f-58de-08ddf481295e
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|41001999006|8062599012|8060799015|461199028|19110799012|13091999003|31061999003|3412199025|440099028|40105399003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?58wNXqj0gHYMGcLknMlAAgeGPosGbceZMHqMpra9hV41vvY3OFE0YTXhXKYb?=
 =?us-ascii?Q?HCcbDN18iPF4TfRZqz0J36XQSMCA80EH2mNxaveDCpqTPDUJok1JQKBCSd2u?=
 =?us-ascii?Q?Z/asN7WRIEU0SA3gxf9e03dNZ9qXXlReVophNL2bBWe9PlLGRzjr7Hh3vKMj?=
 =?us-ascii?Q?XxpNKhnRQk6jkxNTJgkfE8TXx7kPw9vtFTe8LeB0+WUWeGuFQ8vOGiofyZoG?=
 =?us-ascii?Q?o5izSv9O/Ym/nlc0Dm7H7F8MgufxzpJ24TMw7txO7YpsrFc2mndJd2gaLsln?=
 =?us-ascii?Q?ntiJQu1vgLj1OvijI6otKxUBxTKWL9u0Q3pgkmUD1WI7v0Mg6DZm4CVQky8y?=
 =?us-ascii?Q?UlNGnrCMVedHQo5y+UUQvDUZ7fcvBp3ZK+eacWalieVLP/NJMNa9XlfQN87q?=
 =?us-ascii?Q?qSna76g2pluqPdTdyHTEuU8FYVHez0j54SD8GMQx80xs8pGFakqj7VBPHvbK?=
 =?us-ascii?Q?9ERFV9OnYsZ4mM+WH2dWy2Mmbo/129WQRxBcsOL8yR6X0kzICji6Zxqn67p7?=
 =?us-ascii?Q?SqHzPEmydXNuM3exNI/qjDK8JiN6ekBbtXDmpoMrVtwOpuUTDXIXsRsCvAts?=
 =?us-ascii?Q?kg0F1IfoVBO3xA919CkPlhq0Y6fudE1mchm4Oh+bCmG5eU8sNhQBhxfDEB+S?=
 =?us-ascii?Q?YTZNyqttS7mMTnQzLPVVsEIVdSog1mnjml5RT52BS9GBfLL9Hzun+U+3B9Bp?=
 =?us-ascii?Q?nHEwwtl2+cGJlSDL+rSepd+0Phne99/3xjlVJHAd5Xu10vvE6YqrVJx0t8xy?=
 =?us-ascii?Q?XoDXMa8zLA5hPOZ2zPCp5/tmgQiDg9iFtEmYjWX4pfKOa7XQrdGl1bGm+06b?=
 =?us-ascii?Q?wdJcKigDvoIBMybirX6QHH/AjvZhX27jhB2hA3D2065OqKdMyKedUIUNoF0I?=
 =?us-ascii?Q?PeNdeSyDS8VsVdiS3o9chijP6prp6jf2Pizrjao4wZeYazfGm/+x8J12E8ir?=
 =?us-ascii?Q?BAc3gNjAjp9BQ9jsQhK0/W8GsGOZ9HbNQKTqh+8nL5ajIZbp7SxEPP3eSE9L?=
 =?us-ascii?Q?tu7/Nfq9YQxeErNuijN+NYfkR46Rshu6SZWR2eamgPW1IpA2HQUXLx5QD+8V?=
 =?us-ascii?Q?vY93gk+ZyH4MdPO+Z6GKGrleohnaYRPEJRsxD7iqUFMHCUXWbwzV2t0EPjAg?=
 =?us-ascii?Q?wpVrTsbvKw0+jmPKMR0Y42ISLHRnuQwR3VcAx5px0H/OnXCxD0F3qB9nhVka?=
 =?us-ascii?Q?fBsNpTdO6zxsZwA4mckJTKIE9nExujOhvEFcTA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Smrk/9lFO+fTFG+dYk3cZ+QH6vxaWI7NEPLSpi/8KxB4tFrkvHrcOrVKtW3k?=
 =?us-ascii?Q?U4PPZR9XjyPm9tN1pbxwtmDdlE5hBlxSh5slwHljt87U4fj4XQHBet/4frE4?=
 =?us-ascii?Q?NF7VJo5pbLjok1/+lYbW6YtNhmBVT0Au86+nKgpWICyYawbs0suR7YgF7uR7?=
 =?us-ascii?Q?0OaSRj1cck2AhmtTrF0k59Lb+eYOzV2L2XYXvwT3PbneX/Xg1hpN25Fku04B?=
 =?us-ascii?Q?oMCAao2nTxLIdz5P0aIFD87oDm7UWMHRlS/dK3fzk0Lskt/Mp6QZaOECylVY?=
 =?us-ascii?Q?iLO729xzpodfbkh7bYVc0dDd+3EE3szGuMOcGBkazlddW3yKJxjEZ6o1zdux?=
 =?us-ascii?Q?9ZkDgHgHkw1YgZtcF4TuUlAtpt/+eR7DjLBoDQJjHOkzDfZBCIllF5ZghlcM?=
 =?us-ascii?Q?kP2XeeVlnBVPwWoY+t1BaE4H0SXThrerIqk/sLQEOe9A3f3sJI+c18pk35O+?=
 =?us-ascii?Q?EROIqM+UCjvEZt+KkH9Mwg3yI73XklVqYaeoE+60hMmRsitLplaussKaDSWV?=
 =?us-ascii?Q?qrgeXdRcpDsOE3PJ9cyskNEZriEneyXqbO1/faupQ4aimkhHzulVd+dS0VLs?=
 =?us-ascii?Q?PW7JwapvO+Ka0pAEVdC73Flv2H5+5cFKzDiPHfUJ0Tq4fTt0AvGh534KHqOC?=
 =?us-ascii?Q?3gDAMI3Bbr3jKvRfDBamoWxOd16gskWH4IAEVgSwsiKL9B71r8L8xzSiTqOb?=
 =?us-ascii?Q?t8IOwkMBZyD/d8WfK8KlA2wIrmzRi1G2PkqiQxqsNqns06/yz9MEeG0SJuyH?=
 =?us-ascii?Q?KOEPREeE4K5qx/YmiuRcv/Md3CrBUGuZVdfRVCXmfsiKgmOo2tSN2zAQCQ/E?=
 =?us-ascii?Q?1T8xMf1+RNU/mypCJHh9JwNcpFEjGCXCh2zygrZy74Gjb5NqHyCyluoWD8oH?=
 =?us-ascii?Q?YsdoBjs/qh/XGLb7tPBf9Dr+XM5qcfovkn4QCXWQRfwWwGGonR/SJLktwtDE?=
 =?us-ascii?Q?jMYTwb8OJFqaarmMpUsyHxXnL4FtXyU0sGGaMezKtVaKC+xKJUboPFMkY+Fs?=
 =?us-ascii?Q?2OIOJCZWEm+3DW84SbS2s0AYj6ypgk2xuOzTGr+c7FBMGxjwCLf36w2sNBzk?=
 =?us-ascii?Q?GFNSJM0uUj8FWFbmyDM8Q1CPeJf2EoNqglg/YwlbhD32fFty2S1OrZdDjDj0?=
 =?us-ascii?Q?8snNTas7/Mo24Gg2vjcd7kxuFzD1TJUYVKldFJQDBWJJo2bR5sSFIA4VKlSi?=
 =?us-ascii?Q?RIgKJTQDO2ltdBdGEtR64DhnMi3VYp8Clr7Tze3Q+atX1yo71Ta6QKC+2XU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e256ef43-ce9b-474f-58de-08ddf481295e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2025 17:56:13.8024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10056

From: Mukesh Rathor <mrathor@linux.microsoft.com> Sent: Tuesday, September =
9, 2025 5:10 PM
>=20
> Enable build of the new files introduced in the earlier commits and add
> call to do the setup during boot.
>=20
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> ---
>  arch/x86/hyperv/Makefile       | 6 ++++++
>  arch/x86/hyperv/hv_init.c      | 1 +
>  include/asm-generic/mshyperv.h | 9 +++++++++
>  3 files changed, 16 insertions(+)
>=20
> diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
> index d55f494f471d..6f5d97cddd80 100644
> --- a/arch/x86/hyperv/Makefile
> +++ b/arch/x86/hyperv/Makefile
> @@ -5,4 +5,10 @@ obj-$(CONFIG_HYPERV_VTL_MODE)	+=3D hv_vtl.o
>=20
>  ifdef CONFIG_X86_64
>  obj-$(CONFIG_PARAVIRT_SPINLOCKS)	+=3D hv_spinlock.o
> +
> + ifdef CONFIG_MSHV_ROOT
> +  CFLAGS_REMOVE_hv_trampoline.o +=3D -pg
> +  CFLAGS_hv_trampoline.o        +=3D -fno-stack-protector
> +  obj-$(CONFIG_CRASH_DUMP)      +=3D hv_crash.o hv_trampoline.o
> + endif
>  endif
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index afdbda2dd7b7..577bbd143527 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -510,6 +510,7 @@ void __init hyperv_init(void)
>  		memunmap(src);
>=20
>  		hv_remap_tsc_clocksource();
> +		hv_root_crash_init();
>  	} else {
>  		hypercall_msr.guest_physical_address =3D vmalloc_to_pfn(hv_hypercall_p=
g);
>  		wrmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index dbd4c2f3aee3..952c221765f5 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -367,6 +367,15 @@ int hv_call_deposit_pages(int node, u64 partition_id=
, u32
> num_pages);
>  int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
>  int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flag=
s);
>=20
> +#if CONFIG_CRASH_DUMP
> +void hv_root_crash_init(void);
> +void hv_crash_asm32(void);
> +void hv_crash_asm64_lbl(void);
> +void hv_crash_asm_end(void);
> +#else   /* CONFIG_CRASH_DUMP */
> +static inline void hv_root_crash_init(void) {}
> +#endif  /* CONFIG_CRASH_DUMP */
> +

The hv_crash_asm* functions are x86 specific. Seems like their
declarations should go in arch/x86/include/asm/mshyperv.h, not in
the architecture-neutral include/asm-generic/mshyperv.h.

>  #else /* CONFIG_MSHV_ROOT */
>  static inline bool hv_root_partition(void) { return false; }
>  static inline bool hv_l1vh_partition(void) { return false; }
> --
> 2.36.1.vfs.0.0
>=20


