Return-Path: <linux-arch+bounces-12894-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B411AB0E2E7
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jul 2025 19:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8D21C8555C
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jul 2025 17:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D026F283124;
	Tue, 22 Jul 2025 17:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DSTBMOys"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2043.outbound.protection.outlook.com [40.92.20.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1752280CD5;
	Tue, 22 Jul 2025 17:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206295; cv=fail; b=ryBJFF71YDslzg8UKhtXWIeQM/ZMTV2VGD6pQmWT5RKyZBT/W1vSy/tEYcGDyjEJSiTSNxvaIBIO0h25JYYwtrMKkQDTmu+LNeBxTzNmRBrOnbEZ8fLtxAWUX4aQcRDKXCHkVp0XVNpjQL6YZeubbPKyyXUgNK2+OUrRhGMvvSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206295; c=relaxed/simple;
	bh=uF914qubEIkWy1xicHCcPh2rxTnghsE3mJ4dEoyU8Ag=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p4q8COw6xmEzPMwocXZrxOj6u+dbKg7CJCnO53C4F77mE2orSFY6fbvxCKApKIxDYIEMhiXQpIla1kv6ym+zN8VGQ/y+dSWGRxdG2nqet9tn8uIOTC7Nkwx+7qjFSpi92G/tQmGp/Lum6mS1wPSs8SsbTuht1K++M5I703MvYFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DSTBMOys; arc=fail smtp.client-ip=40.92.20.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZIBq5KfoQTMRPEquFBjVLhusfo2xd8G0TXkBQMftUOd/R1BUoNlMlHuz8AHV7Is4EOlureVc5LQII5Oa71b2j1S8+5lJe5OP4oRc4GNJV8xRkH+mrMgRpwa8Jl8R33FH/Xx5OB5D54H/If9jdjivukKjpeP7wFi/3tASwsHPleNJZVXTv/wCmVPoxjgTt1ZnMC49KcCTlANuBvHX6Z63s8nEIT4d17SeO8EsRS+1GFlBh/tLiYeB9jHc2tfz6fXx1sOPz7uqpefRMRLKt2BZa81Nf2aDaMVb+TRp9JwJ68tVFsz70QIQ/fibEV68quwMm5H2XwkifgU0dgtL0bj9PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3U3clk92HF7P+2MQP6naLI/nRUwzdR78DWApD+zVp8=;
 b=gdRZH1oxof8IvL4EX2EJlqF8DjuZeW8SmLFEvNkcGgygM/qUlx9639lA/k9B4e4SDwChpt4xP9ekYgVzrA7qOI4H5oeSYiq6qhi537NYRZS8WenCaR9itPuZfVyuRecOIdQGNiKtiA0opsf9UiJ6+uP3LeLrcLgYL5HtmHdFM9A6njEJGoC7RdRGF0u5SidgAtrCjdXg9GQJedzzg7k0IEwWgw6/ebWb67eZ6UCK5sRMNkzD8b75HlWQuZIgU5LwZtHzZrY/RZ3rJPtSR3s00mhhGwOUd7E7jRKd53nDLefqZ3JY4rcyOGwCVriJKRjkXKvPHBBKq3u/rmdy4QYqSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3U3clk92HF7P+2MQP6naLI/nRUwzdR78DWApD+zVp8=;
 b=DSTBMOys118yuf3Q3FtSWVshqVGo/yUjIjK+o2hCX5jZnL4BrUEQxDjs7k/qc6x4u/twsp5pIalCnQKye5KgCzOvg8SFmiSVmrayxGF6a6U15LWqvU2nj7ezVhLYOzGEptsgj3y2u5dZzdCDAM/fKS12ogOwXof9b5IdRJ6NGB0Wb7R5vinL1dWbBtUVzureN4/HYAJHbI8sCgFyA47qU8XGoP/mj2oWR/TqAOGcnM1Xj1DHiJxigjXkobf6YFD0lwujnFifAjDx1ABLlxoJrusov68fFjNp5Avt7Dpk8mUm2ozih7D0MFLUeGs/4JlzTVrFsb5aTb7Q58YLpYyLxw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY8PR02MB9201.namprd02.prod.outlook.com (2603:10b6:930:9c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Tue, 22 Jul
 2025 17:44:49 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 17:44:49 +0000
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
Subject: RE: [PATCH hyperv-next v4 11/16] Drivers: hv: Functions for setting
 up and tearing down the paravisor SynIC
Thread-Topic: [PATCH hyperv-next v4 11/16] Drivers: hv: Functions for setting
 up and tearing down the paravisor SynIC
Thread-Index: AQHb9Qzd+C+jxXe5VUuRLdwhjD6dOLQ4m6iQ
Date: Tue, 22 Jul 2025 17:44:49 +0000
Message-ID:
 <SN6PR02MB415792CF274383E808ABCD79D45CA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250714221545.5615-1-romank@linux.microsoft.com>
 <20250714221545.5615-12-romank@linux.microsoft.com>
In-Reply-To: <20250714221545.5615-12-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY8PR02MB9201:EE_
x-ms-office365-filtering-correlation-id: e669871a-1869-4118-c006-08ddc94774f5
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|461199028|41001999006|56899033|40105399003|3412199025|440099028|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?q6/KZbH1Ha9HfvPhe8CgiakXRSJ2vr/+ffl7R0ms5MNoqQ9e3IZH8CyqWold?=
 =?us-ascii?Q?lm3ACkTHAgvxIwIIp80FUHa84L4uo5I1Nzw6eNf4fnr2rh/kIFKnTnibQ8Od?=
 =?us-ascii?Q?Gmeno2e8Vc6Xlmo6pJX6A7ZHINF7wYQdtPZWdO0AVXm8Mc1EQ4dOGu3J/ebq?=
 =?us-ascii?Q?uagYIGsDA2r+qY+PK9kkUA0+RFqo9gOslsvsdXFWE302E922koROz7SGMK76?=
 =?us-ascii?Q?IKFPefu41GdQLH3N4Uk5yA9U7xaQGittNO7607e1IVAveGG81eKOmPy8A9fU?=
 =?us-ascii?Q?lWi7wfqVgLue16EiEajWv6laLujI9vpCt1HAQNDVvEYhlrR/XzoURGQD4X7z?=
 =?us-ascii?Q?06ayzIs8lx5UxftNaZSl56oGkQ4YaXC4j/bID6xiKvihQb5/81GBeaASAyQF?=
 =?us-ascii?Q?sJdVFRbaoS21TEbVG2IteWlW8HVRbeBA5eQUEsUyv+JSn+0aIIbQEKfZPSet?=
 =?us-ascii?Q?GMjECW7onjNmSZtARzUdR9dSVVBixstiJQvZmcixWXXMhEl7l7Ynzru9YWNJ?=
 =?us-ascii?Q?QUVb8gv3yHqe2h8MwNez8SVdeIarGiF2kDEbmaqCeocwaEGAtXObIlY8Ie69?=
 =?us-ascii?Q?UaRIfJeXQuRp4xocsrumd0USB+J1IFN+YqRIw9EqNnqjUrm8KR6U+Q/DtRxA?=
 =?us-ascii?Q?rVEYVnLzKxJwebyV7w5tc40a5Sq/woP+PQqVIGi3j/Y6MBpnh4DJDU5BUREf?=
 =?us-ascii?Q?gHXvUlc6Pa9rRUXkx//YdnjnhLY/ZMjkX6/eyogjdeyjicP7Y3qSB/0nE9lU?=
 =?us-ascii?Q?Dbt+kOPg3y9P6iH82G36M91sIpx0WLM50/cAkAckF3bS3zGI202SFGepT3RW?=
 =?us-ascii?Q?psis5YgLeJpteUgqaSRO247NM4T3YBBNYqGW4L6pupgzmhmBdXFzYPYJSoxL?=
 =?us-ascii?Q?KTQo3COGXhSU5OoH39Ay2plBEPDGQ/mx2Nidv5DTxU+jCUXhzOCuY+MB0AX5?=
 =?us-ascii?Q?rBSObfOZtp2o5jJKR3xn0BfrOKO3rbvvA5BVgVzkmB7jvWZR6I+7nkQqbpXR?=
 =?us-ascii?Q?QLjJgSe9XDTxE5L0t3akwqYuci6YjZZZ/FzoiWgsM00AKTu0wc1HrdXMt25J?=
 =?us-ascii?Q?lYWFJ4k7ifP9uAItbnmVc/itjhHk9A=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?avRFsIRfrZh9tK7fNTYSnoinVwofkw8kG9osMoPTePRz5fPqKCq9rHugz3B3?=
 =?us-ascii?Q?W2W7M4a84Uh6C6AzsRwdAzEE4mBNlFUy8J5dGo9XlicGDIAyHqU0ciVOf3O+?=
 =?us-ascii?Q?F2bQXU6AQRYczTRl+DjhQlPSx0H8L0Zbx1+JgcambvE3hm2Qqv0IuzzO/PJi?=
 =?us-ascii?Q?Cq5KL+Au0p8an4QLOjH77hHcvaZnKT4GZ8h56pY+Zb2jUMA5YcJeiV9Xrjw0?=
 =?us-ascii?Q?E1SNwjBtfH0gqisH3lF1CU7fG+YLZnPG7ruOyU/wO8tZBGu26fEQec2taP7w?=
 =?us-ascii?Q?/QJefGXY6Ics7MDiZsOqZDHmkvhdllrXYhEHIEgrQ1onfbKDZUxjwTYb/7Uo?=
 =?us-ascii?Q?1IB1n+xo+jSAwp6EvPn2x1qQd3QgqNckFPiYWriqNPvFD4DR+ksNvPh4YjPD?=
 =?us-ascii?Q?pMuHXrZB18qu2LAzsRwXSJlCDqVb6DEB8PNlSMw62Y5K5n9wamJBfi0cPf8P?=
 =?us-ascii?Q?l/h97jj2A/ikJaf5L7RMS2j83e8vHaAhMQwXYveIFmBa5esnVgOqsOsvljdF?=
 =?us-ascii?Q?7IFPGwQWL3VaptqDNIS6wAaERaiI3gEidbVm2lthNqS46P+TyQqPPc3bYNl0?=
 =?us-ascii?Q?TiZIttO9Fw1gYS6cAAzjcUJpAbjakmQusJeUic8+4UfPfv4Wi7p7pQH3igzH?=
 =?us-ascii?Q?nmpKmy+Xez8jDiq6MiyKDRs9u7ZjAvfPnX0Oncx9KMw8DGGHKjQ4JFR0ENDM?=
 =?us-ascii?Q?ZitDdbXWGsyd98W0eMfBPsFhieAIAAeCaAgXMfwSzgV1sbpdvrIAEuEm2Kdf?=
 =?us-ascii?Q?Yr0CnvuUfPiyWwkBlxXWvPOWlksipqNviRlvVOvJq/+iuky2pQCiiy9ux1PD?=
 =?us-ascii?Q?HWxH0oqm7Xx3RaYCeKUh8TZPO4Z7/QwMGE1DDSF+9cJceR/VC48IBPoDl4/1?=
 =?us-ascii?Q?3GJF6Pj9LAi2s29YXDBLm6z2tb1dvspqMnL5xVJ/OZn1dvdvACb4GkjVQLX3?=
 =?us-ascii?Q?ypntm1Did65a3TAEmoSQrcYmfmbuB1IQfwbwRyauFlXG8nP/d6XsH1vn6wKK?=
 =?us-ascii?Q?3kXcT00JeUXsSA/cDnvjochLN8C+mzGX7G2mx3fNZojkbOocjJSdIb8tcKap?=
 =?us-ascii?Q?43+JR1fYPe3aFApnhBtJViEa62fCfLhdhf1qa2SbBDLOD9d2X6QfLoXZcwZ7?=
 =?us-ascii?Q?eqwm3PoxmKSWJ1zUu/g9HOLr74dfEtuqLcbnnPH/gyCjIiq1SR5eTPFSBgXB?=
 =?us-ascii?Q?cbgiupNZi4BD0to7v31uu0n3V2lUSiY+O8BzDIgY5wXmf8qZsfJolotpS1s?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e669871a-1869-4118-c006-08ddc94774f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 17:44:49.8039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9201

From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, July 14, 2025 =
3:16 PM
>=20
> The confidential VMBus runs with the paravisor SynIC and requires
> configuring it with the paravisor.
>=20
> Add the functions for configuring the paravisor SynIC. Update
> overall SynIC initialization logic to initialize the SynIC if it
> is present. Finally, break out SynIC interrupt enable/disable
> code into separate functions so that SynIC interrupts can be
> enabled or disabled via the paravisor instead of the hypervisor
> if the paravisor SynIC is present.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>

See some comments below about the comments in the code.
Those notwithstanding,
Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  drivers/hv/hv.c | 197 +++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 185 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 94a81bb3c8c7..9d85d5e62968 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -276,9 +276,8 @@ void hv_hyp_synic_enable_regs(unsigned int cpu)
>  	union hv_synic_simp simp;
>  	union hv_synic_siefp siefp;
>  	union hv_synic_sint shared_sint;
> -	union hv_synic_scontrol sctrl;
>=20
> -	/* Setup the Synic's message page */
> +	/* Setup the Synic's message page with the hypervisor. */
>  	simp.as_uint64 =3D hv_get_msr(HV_MSR_SIMP);
>  	simp.simp_enabled =3D 1;
>=20
> @@ -297,7 +296,7 @@ void hv_hyp_synic_enable_regs(unsigned int cpu)
>=20
>  	hv_set_msr(HV_MSR_SIMP, simp.as_uint64);
>=20
> -	/* Setup the Synic's event page */
> +	/* Setup the Synic's event page with the hypervisor. */
>  	siefp.as_uint64 =3D hv_get_msr(HV_MSR_SIEFP);
>  	siefp.siefp_enabled =3D 1;
>=20
> @@ -325,6 +324,11 @@ void hv_hyp_synic_enable_regs(unsigned int cpu)
>  	shared_sint.masked =3D false;
>  	shared_sint.auto_eoi =3D hv_recommend_using_aeoi();
>  	hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
> +}
> +
> +static void hv_hyp_synic_enable_interrupts(void)
> +{
> +	union hv_synic_scontrol sctrl;
>=20
>  	/* Enable the global synic bit */
>  	sctrl.as_uint64 =3D hv_get_msr(HV_MSR_SCONTROL);
> @@ -333,13 +337,100 @@ void hv_hyp_synic_enable_regs(unsigned int cpu)
>  	hv_set_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
>  }
>=20
> +/*
> + * The paravisor might not support proxying SynIC, and this
> + * function may fail.
> + */
> +static int hv_para_synic_enable_regs(unsigned int cpu)
> +{
> +	int err;
> +	union hv_synic_simp simp;
> +	union hv_synic_siefp siefp;
> +	struct hv_per_cpu_context *hv_cpu
> +		=3D per_cpu_ptr(hv_context.cpu_context, cpu);
> +
> +	/* Setup the Synic's message page with the paravisor. */
> +	err =3D hv_para_get_synic_register(HV_MSR_SIMP, &simp.as_uint64);
> +	if (err)
> +		return err;
> +	simp.simp_enabled =3D 1;
> +	simp.base_simp_gpa =3D virt_to_phys(hv_cpu->para_synic_message_page)
> +			>> HV_HYP_PAGE_SHIFT;
> +	err =3D hv_para_set_synic_register(HV_MSR_SIMP, simp.as_uint64);
> +	if (err)
> +		return err;
> +
> +	/* Setup the Synic's event page with the paravisor. */
> +	err =3D hv_para_get_synic_register(HV_MSR_SIEFP, &siefp.as_uint64);
> +	if (err)
> +		return err;
> +	siefp.siefp_enabled =3D 1;
> +	siefp.base_siefp_gpa =3D virt_to_phys(hv_cpu->para_synic_event_page)
> +			>> HV_HYP_PAGE_SHIFT;
> +	return hv_para_set_synic_register(HV_MSR_SIEFP, siefp.as_uint64);
> +}
> +
> +static int hv_para_synic_enable_interrupts(void)
> +{
> +	union hv_synic_scontrol sctrl;
> +	int err;
> +
> +	/* Enable the global synic bit */
> +	err =3D hv_para_get_synic_register(HV_MSR_SCONTROL, &sctrl.as_uint64);
> +	if (err)
> +		return err;
> +	sctrl.enable =3D 1;
> +
> +	return hv_para_set_synic_register(HV_MSR_SCONTROL, sctrl.as_uint64);
> +}
> +
>  int hv_synic_init(unsigned int cpu)
>  {
> +	int err;
> +
> +	/*
> +	 * The paravisor may not support the confidential VMBus,
> +	 * check on that first.
> +	 */
> +	if (vmbus_is_confidential()) {
> +		err =3D hv_para_synic_enable_regs(cpu);
> +		if (err)
> +			goto fail;
> +	}
> +
> +	/*
> +	 * The SINT is set in hv_hyperv_synic_enable_regs() by calling

s/hv_hyperv_synic_enable_regs/hv_hyp_synic_enable_regs/

> +	 * hv_set_msr(). hv_set_msr() in turn has special case code for the
> +	 * SINT MSRs that write to the hypervisor version of the MSR *and*
> +	 * the paravisor version of the MSR (but *without* the proxy bit when
> +	 * VMBus is confidential). Then the code above enables interrupts

This reference to "the code above" is wrong. It's actually the code below.
Perhaps just do "Then enable interrupts via the paravisor ...." as a new
paragraph in the comment.

> +	 * via the paravisor if VMBus is confidential, and otherwise via the
> +	 * hypervisor.
> +	 */
> +
>  	hv_hyp_synic_enable_regs(cpu);
> +	if (vmbus_is_confidential()) {
> +		err =3D hv_para_synic_enable_interrupts();
> +		if (err)
> +			goto fail;
> +	} else
> +		hv_hyp_synic_enable_interrupts();
>=20
>  	hv_stimer_legacy_init(cpu, VMBUS_MESSAGE_SINT);
>=20
>  	return 0;
> +
> +fail:
> +	/*
> +	 * The failure may only come from enabling the paravisor SynIC.
> +	 * That in turn means that the confidential VMBus cannot be used
> +	 * which is not an error: the setup will be re-tried with the
> +	 * non-confidential VMBus.
> +	 *
> +	 * We also don't bother attempting to reset the paravisor registers
> +	 * as something isn't working there anyway.
> +	 */
> +	return err;
>  }
>=20
>  void hv_hyp_synic_disable_regs(unsigned int cpu)
> @@ -349,7 +440,6 @@ void hv_hyp_synic_disable_regs(unsigned int cpu)
>  	union hv_synic_sint shared_sint;
>  	union hv_synic_simp simp;
>  	union hv_synic_siefp siefp;
> -	union hv_synic_scontrol sctrl;
>=20
>  	shared_sint.as_uint64 =3D hv_get_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT)=
;
>=20
> @@ -361,7 +451,7 @@ void hv_hyp_synic_disable_regs(unsigned int cpu)
>=20
>  	simp.as_uint64 =3D hv_get_msr(HV_MSR_SIMP);
>  	/*
> -	 * In Isolation VM, sim and sief pages are allocated by
> +	 * In Isolation VM, simp and sief pages are allocated by
>  	 * paravisor. These pages also will be used by kdump
>  	 * kernel. So just reset enable bit here and keep page
>  	 * addresses.
> @@ -391,14 +481,64 @@ void hv_hyp_synic_disable_regs(unsigned int cpu)
>  	}
>=20
>  	hv_set_msr(HV_MSR_SIEFP, siefp.as_uint64);
> +}
> +
> +static void hv_hyp_synic_disable_interrupts(void)
> +{
> +	union hv_synic_scontrol sctrl;
>=20
>  	/* Disable the global synic bit */
>  	sctrl.as_uint64 =3D hv_get_msr(HV_MSR_SCONTROL);
>  	sctrl.enable =3D 0;
>  	hv_set_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
> +}
>=20
> -	if (vmbus_irq !=3D -1)
> -		disable_percpu_irq(vmbus_irq);
> +static void hv_para_synic_disable_regs(unsigned int cpu)
> +{
> +	/*
> +	 * When a get/set register error is encountered, the function
> +	 * returns as the paravisor may not support these registers.
> +	 */
> +	int err;
> +	union hv_synic_simp simp;
> +	union hv_synic_siefp siefp;
> +
> +	/*
> +	 * Don't deallocate memory here as the function is called on
> +	 * CPU online and offline operations. The guest will find
> +	 * itself without means of communication when resumed.
> +	 */

This comment feels unnecessary because deallocating memory in
this function should not be an expectation. Lacking that expectation,
there's no reason to explain why it is not done. Looking at the larger
context, the paired function hv_para_synic_enable_regs() doesn't
allocate memory, and the parallel function hv_hyp_synic_disable_regs()
also doesn't do memory deallocation. FWIW, the first sentence of the
comment is slightly inaccurate because the function is called only
when a CPU goes offline. But I would remove the comment entirely
so as to not imply that it's reasonable to expect the deallocation
should be done here.

CPU offlining is not the justification for why deallocation is not done
here. In my comments on v3 of this patch, my intent was to use CPU
offlining just as an example of why deallocating here would break
things. The deallocation is already properly done in hv_synic_free().

> +
> +	/* Disable SynIC's message page in the paravisor. */
> +	err =3D hv_para_get_synic_register(HV_MSR_SIMP, &simp.as_uint64);
> +	if (err)
> +		return;
> +	simp.simp_enabled =3D 0;
> +
> +	err =3D hv_para_set_synic_register(HV_MSR_SIMP, simp.as_uint64);
> +	if (err)
> +		return;
> +
> +	/* Disable SynIC's event page in the paravisor. */
> +	err =3D hv_para_get_synic_register(HV_MSR_SIEFP, &siefp.as_uint64);
> +	if (err)
> +		return;
> +	siefp.siefp_enabled =3D 0;
> +
> +	hv_para_set_synic_register(HV_MSR_SIEFP, siefp.as_uint64);
> +}
> +
> +static void hv_para_synic_disable_interrupts(void)
> +{
> +	union hv_synic_scontrol sctrl;
> +	int err;
> +
> +	/* Disable the global synic bit */
> +	err =3D hv_para_get_synic_register(HV_MSR_SCONTROL, &sctrl.as_uint64);
> +	if (err)
> +		return;
> +	sctrl.enable =3D 0;
> +	hv_para_set_synic_register(HV_MSR_SCONTROL, sctrl.as_uint64);
>  }
>=20
>  #define HV_MAX_TRIES 3
> @@ -411,16 +551,18 @@ void hv_hyp_synic_disable_regs(unsigned int cpu)
>   * that the normal interrupt handling mechanism will find and process th=
e channel interrupt
>   * "very soon", and in the process clear the bit.
>   */
> -static bool hv_synic_event_pending(void)
> +static bool __hv_synic_event_pending(union hv_synic_event_flags *event, =
int sint)
>  {
> -	struct hv_per_cpu_context *hv_cpu =3D this_cpu_ptr(hv_context.cpu_conte=
xt);
> -	union hv_synic_event_flags *event =3D
> -		(union hv_synic_event_flags *)hv_cpu->hyp_synic_event_page + VMBUS_MES=
SAGE_SINT;
> -	unsigned long *recv_int_page =3D event->flags; /* assumes VMBus version=
 >=3D VERSION_WIN8 */
> +	unsigned long *recv_int_page;
>  	bool pending;
>  	u32 relid;
>  	int tries =3D 0;
>=20
> +	if (!event)
> +		return false;
> +
> +	event +=3D sint;
> +	recv_int_page =3D event->flags; /* assumes VMBus version >=3D VERSION_W=
IN8 */
>  retry:
>  	pending =3D false;
>  	for_each_set_bit(relid, recv_int_page, HV_EVENT_FLAGS_COUNT) {
> @@ -437,6 +579,17 @@ static bool hv_synic_event_pending(void)
>  	return pending;
>  }
>=20
> +static bool hv_synic_event_pending(void)
> +{
> +	struct hv_per_cpu_context *hv_cpu =3D this_cpu_ptr(hv_context.cpu_conte=
xt);
> +	union hv_synic_event_flags *hyp_synic_event_page =3D hv_cpu->hyp_synic_=
event_page;
> +	union hv_synic_event_flags *para_synic_event_page =3D hv_cpu->para_syni=
c_event_page;
> +
> +	return
> +		__hv_synic_event_pending(hyp_synic_event_page, VMBUS_MESSAGE_SINT) ||
> +		__hv_synic_event_pending(para_synic_event_page, VMBUS_MESSAGE_SINT);
> +}
> +
>  static int hv_pick_new_cpu(struct vmbus_channel *channel)
>  {
>  	int ret =3D -EBUSY;
> @@ -529,7 +682,27 @@ int hv_synic_cleanup(unsigned int cpu)
>  always_cleanup:
>  	hv_stimer_legacy_cleanup(cpu);
>=20
> +	/*
> +	 * First, disable the event and message pages
> +	 * used for communicating with the host, and then
> +	 * disable the host interrupts if VMBus is not
> +	 * confidential.
> +	 */
>  	hv_hyp_synic_disable_regs(cpu);
> +	if (!vmbus_is_confidential())
> +		hv_hyp_synic_disable_interrupts();
> +
> +	/*
> +	 * Perform the same steps for the Confidential VMBus.
> +	 * The sequencing provides the gurantee that no data

s/gurantee/guarantee/

> +	 * may be posted for processing before disabling interrupts.
> +	 */
> +	if (vmbus_is_confidential()) {
> +		hv_para_synic_disable_regs(cpu);
> +		hv_para_synic_disable_interrupts();
> +	}
> +	if (vmbus_irq !=3D -1)
> +		disable_percpu_irq(vmbus_irq);
>=20
>  	return ret;
>  }
> --
> 2.43.0


