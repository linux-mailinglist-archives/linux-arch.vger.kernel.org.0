Return-Path: <linux-arch+bounces-12893-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DDFB0E2E3
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jul 2025 19:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96370563E21
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jul 2025 17:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA51283FE6;
	Tue, 22 Jul 2025 17:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Vp7S/2PR"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2025.outbound.protection.outlook.com [40.92.41.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7255283FE5;
	Tue, 22 Jul 2025 17:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206286; cv=fail; b=BmqFnC/362Hh8dXnll7AMHLmlzgtTuzmHeJvamD96AeStLZWlTbaxr8xo8nsMUYewBzzI/npkTbfLVzy1KypX6hBGVAayUqXOV5itU/CwWEJuMVd86orCNJmJ8b2v8PvKSjFPqU9V4ZAHkml1waqttlt5z5rIfVpLfUoEybyI/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206286; c=relaxed/simple;
	bh=zkNsTMNQYlhNCnLB0gLQa13OCmunXEQmkcVt3n8Cats=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PDDuQcisARY4DxqhUwkuscxACllqtWnm9beDgv+dHPwEoqge65u+pCFCZ+Hb02A6P6j3FpLI+yx0XEHyU/XKAIOiebEmHT62WuNXuJIrNG2ow7gJ3TcuvFYS7HOlZXyG24vDtjndHgATFCJy7UevAclXrgisSZa18eyb2IxN5gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Vp7S/2PR; arc=fail smtp.client-ip=40.92.41.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G9mUW1zk3pvtgE2WyrNKiB5byoVYypPNPZEo1zBou2n2TjGk3MvzwYzUKqjQCT+k2h7fuNaZRQo2tBzVZ2qmZAh+KDJf8ARhbSmi5zNKtkTwoBiVBaSiEIoiFXZKO798w/V5ajWg3kF1nlDesHfYnFeM9KzFk3dykEv9gU615nXIJ8zgwQ10A2q8Z+DdmL9N3JQNe7BmWIYzzo20huCcq0RXqEmXNVZXPLInmciHtCCg9KQS/00GdwnOHpryyuvyJOqKLa1Qmf4UZXX/OO/ZOSZfGB/qrzjqukJyQzC4sS1SjZ2nhal+1UsFe3cXG6aa0skd6DKEnd4hjoAsNUrqlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77sfAm1jXhKXWz84Qj5vrsNqnfC6N7NQ6qUsYSl8HUw=;
 b=GsW9p9qCC++7yrSQXD8u6YHQVIDlfTvsVag6ChLrwdzCcofAjahyPO0mB+unCtuD96DfmOH036qReVIMCIstEHBPm/j+e92r/M24ZskKiA+Pq/ara49wMIALSe9TbhzIMiZlpiOKzpOJl2o5TBcuEYeBEtovcekpems9XqC8fXd2ULNSC7eAOM9aUTIPPy+OQ7Y/rXefxcJ+h/vb/6KsliYnwdMj3zAHgQf0jrno3Si/cr/QrTcTGhaHFGCMhIY/ung+yyoXxLN2UUeZ2BjpbFqICM++ulPaTnpYv+F4PoelA+MM15kYHozlw76+DSiI2mjmL9iLeE8uB71SWjAn1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77sfAm1jXhKXWz84Qj5vrsNqnfC6N7NQ6qUsYSl8HUw=;
 b=Vp7S/2PR6izXSteDwuaOfsiQ0SFOlv1UCW5erk5wbrgZlcv88GWcv+5oz5/qG2CDhKHbJaZSQEAYCqp5agBlChigHZfa+NnhrsXMSZP052nXDEogDCzzaEhoeXqxUyMXIdfiYtPx+aRYza9+9La6sdgHpGYohmNgaQ0EoOZIb7onzys5hWOMdGmP0sf38sDpDZoX7nzpyps6JXPuQvg0DI2rVA3CcZicnG1g4r48pDRYdu3Wjg4DqG3Vs7sonLqy+K7miqCc3N8LdcnOm252NAWDfWdUikhmVdjqTRrl6HoaLrgG2e/8EwsmvJwepf5PMz96AYpWbxnQlkZKKBF5Kw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY8PR02MB9201.namprd02.prod.outlook.com (2603:10b6:930:9c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Tue, 22 Jul
 2025 17:44:41 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 17:44:41 +0000
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
Subject: RE: [PATCH hyperv-next v4 10/16] Drivers: hv: Rename the SynIC enable
 and disable routines
Thread-Topic: [PATCH hyperv-next v4 10/16] Drivers: hv: Rename the SynIC
 enable and disable routines
Thread-Index: AQHb9Qzc5KtxPdsuSkybfEfhH+3e0bQ4myOA
Date: Tue, 22 Jul 2025 17:44:41 +0000
Message-ID:
 <SN6PR02MB4157E01A2FFB276C3E79AC54D45CA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250714221545.5615-1-romank@linux.microsoft.com>
 <20250714221545.5615-11-romank@linux.microsoft.com>
In-Reply-To: <20250714221545.5615-11-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY8PR02MB9201:EE_
x-ms-office365-filtering-correlation-id: 0cdd01a3-8b62-4e14-de04-08ddc9476fb9
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|461199028|41001999006|40105399003|3412199025|440099028|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?WkVKGLYanr8rx1s5jTlcisc+dQ3niOTMDOImjX/1dAyV1qKvKMI0RHbm7paK?=
 =?us-ascii?Q?5ZoPBEdtb3LvAJQAxVcdSNR/VWejzp/Es1bARdey93EUgH7x1OmdpbnxNsGf?=
 =?us-ascii?Q?3lucvwvSW3paUElrVzwlJ/7iLmbohTHjFxfx4Pb4pG42Fzro87cmgb8f24mN?=
 =?us-ascii?Q?ddbDp5KMTmVt2npc0c5cA/HUM//Worg32FgvRem6GzAB2MlVE7UD8+CYJHfQ?=
 =?us-ascii?Q?jFPu3vkfs1lnWyeAnbMwTrdVLERw1+W4kAP4TXJHJ8tYTs4UZ8l5aZ9Xr/xr?=
 =?us-ascii?Q?8ZO1cy5ObXZelQZwTx50uTJ8qo5iq6V1RwtfFEmTIcEMh/stgRxW/vu1+Qa2?=
 =?us-ascii?Q?ZJa/yT+nI+H/qApSsKA0c+4+bNj5zu+rGs0fP/ZqTxl5AL80CZ14hrdLNdKw?=
 =?us-ascii?Q?+mxnuLuazgZWcRxzLWVy0Dx0Nrq52RI9XWDqPMtFDyf7SsuHrBgudH4VqoC1?=
 =?us-ascii?Q?A3aZ1XRFQXDfVSEUqBtQFniGbS/bQmPJFlP71Pj7QCPxSBrBSqqWnoomkRA/?=
 =?us-ascii?Q?AK55HyqGuGx1/7rFGN8DxFVthSR47fqnsEUJDDKwUXOOYlZeCclHGhDv/Bjf?=
 =?us-ascii?Q?cl2KkXQPhiicIgqyln7Iya0FoeZqLAlISLkko52NNnCd/ye9hwOugiFEomV4?=
 =?us-ascii?Q?aNFUxV7xhoNeBjYtEQ6w178IF+60DOs3HSsXYDjdC7omsPtRMeHJ03v0+FM9?=
 =?us-ascii?Q?rZF+a8KjgEGL8VVLHEam8OiYrAtKkaT9oQxnmukQjc+1x9uiPISXt6d/8TcU?=
 =?us-ascii?Q?7a2FiD7y4eUTj5oauKv8lou+Y4lCut5N7Xdra4oI4zoBINYz2IMv5NDJxgsd?=
 =?us-ascii?Q?8eg3758EhxWoy4WEJ+/JNJG/CiXpKlnx14I8oCASiguv4f0UN3ee2Wpdyayu?=
 =?us-ascii?Q?d80jpLVxv3wHpBhiGypnu7andapkpSs48XH3CQiWtAWRhM4Pb9HhGT7tMRxB?=
 =?us-ascii?Q?WYDwrfN+abaitoQIzQuntV4KVTaGJFf8r0CIiU4awWTCrSUFwAxcw04sblPi?=
 =?us-ascii?Q?wJKUoyio5fPrRg1vA+A/xNDywcgsMrlt35wL82vO/gtY7/i2IT1+9GNldjjH?=
 =?us-ascii?Q?qNR1iYONYW3aN7gbHESchB7hz2FNHQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/ag8d7QUa4JZLZBIjK390kuBbp6SuI/rr+rVcylmHFjxfJ/vriBTra4s/YLI?=
 =?us-ascii?Q?JlxWJc0ozsOfXcAuaCMTj1Am3FCSkZ7lbq8pR5LiayvEXMzbY+vxY74W+r72?=
 =?us-ascii?Q?cw4qUkcakrETzluCABN2H+0CKgJbY9mn2IajwfT/0Cw0ehg7Bblg+rUlgTQk?=
 =?us-ascii?Q?YnwanYylAibDhz/+CO7flM2q9iDG+aqAhJw7g8vZk4YB/+h5YWpoj6cmZ2Wc?=
 =?us-ascii?Q?fTJRCLgz5cYgVcu/utGjlSh/KUDswC1gPh4Iau5jhuCaJ7/ASB9/MBHKn7E5?=
 =?us-ascii?Q?/zcfxcMnCYW0FD41kjFv3CzldT/WXuOx0dJSyPtoGSgiLf7+gETZZ51uJLgY?=
 =?us-ascii?Q?kMvLOyZQUl+M8I4To5FDBOttqqxjtgnYqICSLcczw5iiwH8DqGcVJzR5O3MY?=
 =?us-ascii?Q?XlGVAt2jbQfkZcq6uRH/L/feaBdM+UYSDt0fSmND3awxG16s9/bk2QsgexQG?=
 =?us-ascii?Q?MdpOaFeUIwcbPUYvjigfje/iFfcvmDg3Hn3r7KMcmg84LNA57jXy1wLJMSOx?=
 =?us-ascii?Q?yOUegp+U0P5q9+jKvgUfoi5sU/c0pZY7JyuonF6IAJoConjlMjlGdgFU4CdQ?=
 =?us-ascii?Q?F8N+NqzPWyrjZLmmGXgksZBP30hLKxW/QitCXaPdHmNEzBeVOqubEUXckCuM?=
 =?us-ascii?Q?yj7ErFKmp0PK31a9qN1BAMuGt5ncQfoUGx/7qPch2oJ4/bCUmRfAVooD88fv?=
 =?us-ascii?Q?WwjipmQ4NGCefd+CU6k6y7ut/Q4Aj2LjEUI5EzsYaFNol3LRN7UEQYBrOwpH?=
 =?us-ascii?Q?Ty5t7Ku0UAiLZO2ChRbAziOEwghJ3VRMETiSCi6kNhbGSUprTlNlEH04CUcE?=
 =?us-ascii?Q?Vw4Q9eqItAaF7W8Hi+XkGbsPheKcTUTRskRU6gF3R3LSH130G8fw5ncyjTry?=
 =?us-ascii?Q?4Un0Qj7rXHXngjuc/SCjWJo+PzII/faXaSUXkUv8WNWNlVR2sBw7YBVUh19C?=
 =?us-ascii?Q?klkuB7NMffh7pho3EPJUmQYDbrHf2Vs5F3lvOBQQknIL7qifKcCOHuNhwLwi?=
 =?us-ascii?Q?Ayp6rxduKaSyvU7AIQyQVmakKk+LnsQSfdgGx0/nfARTRCrnU7e0XTDZX5eo?=
 =?us-ascii?Q?QDOy1JccNACqXU1V2ivFfkaNJfV41VR72w815TBknOsnyco60dvr9jP5LsRq?=
 =?us-ascii?Q?ux/rIPz8Ql/GY4YX2kSG5TbxNVSP2yqSGVqHXku02C7IvYX7pdC5UZK8g3kX?=
 =?us-ascii?Q?t0jvInI66iTBX+igoAOw28KbidRFQwESSpadIXbFg8JHZzZwNYmjkMhik7Y?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cdd01a3-8b62-4e14-de04-08ddc9476fb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 17:44:41.0217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9201

From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, July 14, 2025 =
3:16 PM
>=20
> The confidential VMBus requires support for the both hypervisor
> facing SynIC and the paravisor one.
>=20
> Rename the functions that enable and disable SynIC with the
> hypervisor. No functional changes.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  drivers/hv/channel_mgmt.c |  2 +-
>  drivers/hv/hv.c           | 11 ++++++-----
>  drivers/hv/hyperv_vmbus.h |  4 ++--
>  drivers/hv/vmbus_drv.c    |  6 +++---
>  4 files changed, 12 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 6f87220e2ca3..ca2fe10c110a 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -845,7 +845,7 @@ static void vmbus_wait_for_unload(void)
>  			/*
>  			 * In a CoCo VM the hyp_synic_message_page is not allocated
>  			 * in hv_synic_alloc(). Instead it is set/cleared in
> -			 * hv_synic_enable_regs() and hv_synic_disable_regs()
> +			 * hv_hyp_synic_enable_regs() and
> hv_hyp_synic_disable_regs()
>  			 * such that it is set only when the CPU is online. If
>  			 * not all present CPUs are online, the message page
>  			 * might be NULL, so skip such CPUs.
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index a8669843c56e..94a81bb3c8c7 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -266,9 +266,10 @@ void hv_synic_free(void)
>  }
>=20
>  /*
> - * hv_synic_enable_regs - Initialize the Synthetic Interrupt Controller.
> + * hv_hyp_synic_enable_regs - Initialize the Synthetic Interrupt Control=
ler
> + * with the hypervisor.
>   */
> -void hv_synic_enable_regs(unsigned int cpu)
> +void hv_hyp_synic_enable_regs(unsigned int cpu)
>  {
>  	struct hv_per_cpu_context *hv_cpu =3D
>  		per_cpu_ptr(hv_context.cpu_context, cpu);
> @@ -334,14 +335,14 @@ void hv_synic_enable_regs(unsigned int cpu)
>=20
>  int hv_synic_init(unsigned int cpu)
>  {
> -	hv_synic_enable_regs(cpu);
> +	hv_hyp_synic_enable_regs(cpu);
>=20
>  	hv_stimer_legacy_init(cpu, VMBUS_MESSAGE_SINT);
>=20
>  	return 0;
>  }
>=20
> -void hv_synic_disable_regs(unsigned int cpu)
> +void hv_hyp_synic_disable_regs(unsigned int cpu)
>  {
>  	struct hv_per_cpu_context *hv_cpu =3D
>  		per_cpu_ptr(hv_context.cpu_context, cpu);
> @@ -528,7 +529,7 @@ int hv_synic_cleanup(unsigned int cpu)
>  always_cleanup:
>  	hv_stimer_legacy_cleanup(cpu);
>=20
> -	hv_synic_disable_regs(cpu);
> +	hv_hyp_synic_disable_regs(cpu);
>=20
>  	return ret;
>  }
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 16b5cf1bca19..2873703d08a9 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -189,10 +189,10 @@ extern int hv_synic_alloc(void);
>=20
>  extern void hv_synic_free(void);
>=20
> -extern void hv_synic_enable_regs(unsigned int cpu);
> +extern void hv_hyp_synic_enable_regs(unsigned int cpu);
>  extern int hv_synic_init(unsigned int cpu);
>=20
> -extern void hv_synic_disable_regs(unsigned int cpu);
> +extern void hv_hyp_synic_disable_regs(unsigned int cpu);
>  extern int hv_synic_cleanup(unsigned int cpu);
>=20
>  /* Interface */
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 72940a64b0b6..13aca5abc7d8 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2809,7 +2809,7 @@ static void hv_crash_handler(struct pt_regs *regs)
>  	 */
>  	cpu =3D smp_processor_id();
>  	hv_stimer_cleanup(cpu);
> -	hv_synic_disable_regs(cpu);
> +	hv_hyp_synic_disable_regs(cpu);
>  };
>=20
>  static int hv_synic_suspend(void)
> @@ -2834,14 +2834,14 @@ static int hv_synic_suspend(void)
>  	 * interrupts-disabled context.
>  	 */
>=20
> -	hv_synic_disable_regs(0);
> +	hv_hyp_synic_disable_regs(0);
>=20
>  	return 0;
>  }
>=20
>  static void hv_synic_resume(void)
>  {
> -	hv_synic_enable_regs(0);
> +	hv_hyp_synic_enable_regs(0);
>=20
>  	/*
>  	 * Note: we don't need to call hv_stimer_init(0), because the timer
> --
> 2.43.0


