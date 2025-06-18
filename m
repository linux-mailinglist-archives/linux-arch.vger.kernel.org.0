Return-Path: <linux-arch+bounces-12373-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C2DADF257
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 18:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC3A71BC2462
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 16:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B605B2EFD94;
	Wed, 18 Jun 2025 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="UhLs8SP2"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2091.outbound.protection.outlook.com [40.92.40.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A172280CD1;
	Wed, 18 Jun 2025 16:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263515; cv=fail; b=hNPa3pgch7AhpwjLIqrzX7AZ3X+yIjsCS+Xv9azODuR9SYdjGhmN5j4cTBroQqLEmG2vToNPXJAFxy/1/udBC6F0YoKbjXjsjgAg4o5/ho5jNzdS67YHXzzDjZYzkYOrq+Rofl9GAeAQgEQPLddxTWt7OkP0OPV0IDFQwC704DI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263515; c=relaxed/simple;
	bh=/hi0ByysYZc9mlz23ITgJA54f4vXhZhdt1cz/l304oQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mO4HA6jYpOW+SstpJby53H9SePEr5YDXdI2Yre0yRPEzj7sPYYcCb8rVUc0dfZukI0T2vBw4dApjw1LFAO9uMN13We1WZs8rjr5O+cj8UPa1rHPcyOY5YjHAaDIZL3VW0uJoZNBaUebnZpDtAGabuXOjHX9oEDirAzBe3FS4yzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=UhLs8SP2; arc=fail smtp.client-ip=40.92.40.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfN7Q/4WlSR0MC11tt5wZgfXUKvmEc2cvr+YbHSE2+4iDLCpGYGdoMA4oi9uu/aDMQoQD4rht1UAVA38Smkwz7VkmBYeY8e4dYdo2RjDao5GT1cuJjIjLgqQwkVsNfTHHNCWIFaAETqydo0/eSRe69VPFQrP1Rk50veovvo8lqhyJXJW9q5aouHtvwpP4lXe6WFiE4mjc2tHLczfi85vhP9ImzNAfVqaL7baF7MFCuLMwwRJIi13EX2kPbCq221Mnsl+GIv70jFdncVJGbIYi6/QwsKhURjhEoMsXi1QKd4lPNNTt8P42OgkdN36NWh46jeODS0jZh6vmT/R0HL+bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYdDABq5hj/bF3fAMakhgZL9FFulIqt6mBmCA0Znf0k=;
 b=arVUeCPPWg8u9LnR9i4GuSWa7FBjUgnsn7qyPZmBAhOVOMb9jNjML07fvvshaN/ir4aaksglgvry2UvQ6jVE/2N7eJDB3zOUhloWncSDTTe4LTxIZoeMSYsnsQuRtobJ0xYOWfk771s8XgmTxH1rUKb+Vt4Fu8bpdnQ7QcFTSSAU32uWOWNfbm226ZHtiDdyq/CQNgflpNM3zSWSwNE2x8i7l3wozDapT41o6EMtO/VzafYRv9CUlSAuHEC+G2XaDh2CTab/tWReZi8R4dC20Nm7ZvIyXasSXS0oOgf3qI/hYrpB8BITLPueU1+eDMNyo/zp30ooDyGhmLyjKaR5+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYdDABq5hj/bF3fAMakhgZL9FFulIqt6mBmCA0Znf0k=;
 b=UhLs8SP2NWs8rUwtpurxVRarFsCaO/w6J88RiCbp9jQtOS5dNURZu1dEVYCPS3upuBIlS6Fn61P+SgBlKk+/9c2OUxIeNmiannkGBpMqA34mVeurAa4121z963Fcaro0xtxLVRxDulVBWYV1wjJ/4dTMxFoqgGKhnJffWQnMzF9LYkYE9aQFlIsWbJzFerk8brHFLLqrY0OjeiN/xcPR7kULFpCXNO5DpTPk9UFDio3c2pIDxUPRssipYkiljjSdElQDXdtumEdx5FtTDwvRaXPLpvfyGC5Z97hVvs9dwOWbAvvIml4/4KcdzZv9csZpA30bYqRy7Mdv+5ogKjsnvw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA1PR02MB8462.namprd02.prod.outlook.com (2603:10b6:806:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 16:18:30 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 16:18:30 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "alok.a.tiwari@oracle.com"
	<alok.a.tiwari@oracle.com>, "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de"
	<bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v3 06/15] Drivers: hv: Allocate the paravisor
 SynIC pages when required
Thread-Topic: [PATCH hyperv-next v3 06/15] Drivers: hv: Allocate the paravisor
 SynIC pages when required
Thread-Index: AQHb1Om+ydqFUw+Ccka77Wp0aoF2mLQF7BcA
Date: Wed, 18 Jun 2025 16:18:30 +0000
Message-ID:
 <SN6PR02MB41576FC45B824CAD588DC04DD472A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250604004341.7194-1-romank@linux.microsoft.com>
 <20250604004341.7194-7-romank@linux.microsoft.com>
In-Reply-To: <20250604004341.7194-7-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA1PR02MB8462:EE_
x-ms-office365-filtering-correlation-id: 583da72a-b38c-4f5c-82bd-08ddae83c3d4
x-ms-exchange-slblob-mailprops:
 ZILSnhm0P3k1KuhwzYdE6C/ocrAmq9m0tsFnf5G6XbxzHH9OQdqIbXJVwrtnaDiLfA8ZoXv3EmXgex/C0RSXiFUjy/YL2cRj16EWO6fdxuCp48kxBJPjD+YODU0vhRPp+iQj/3TTktFYDGWkodS/92lTKSnAj5kCushC+sKqgrvKdAHRRo5G1FzMnBr7GIs/wLLxoQHD9GoCmceWRe0ov8tUEkVESgOTVXVkc5gULzb6m1Z1Ye+8cvt7NduxUSLywTbBgf0kKB/RIcInObcraGba8mpbHv2EJTa2NdJ+SxoC0iKbBKnqZdjbAr5POsYaFlJsKh+SKCQDl1h+Y3AEW7hkFVGUc1PrU8vNwxb17mfDSQRMQpqCu3LdWCb2LI/E3/+eVnrLyTJJqd59Eyr4W0ar9Sy9CdqKUDPfXYBdS6newyuwnjL8fBPYbHgYlR98dvAA742GB6lOfcTFFxHubCUcTC37d3NonZZNybAXghiuQxEn7S0Y2RUjgZfIf/s3NwZ+qvhLF5Uxe2k+NIBR6PVy/zsZCGKireoqRnTpz/zS2S1ueBfxA7uArzhATZ+NrrJuGFSNsFbxSEvup+MEvptC9kRn09tRKAurlS7FPeYHmENGUv94vZzyWTf8w637KeIIbIWHLW9nOBw9pQ2Ea7Lcph9PTLS0WuoTRLqnwCkeMofsylIaKicLARLx5obMRTnVLQIAmJkSHsSI3mnBGsWOg9kGaB/8Ccn9SAB/ea14bHCfjl0OnFxzlBmWLjrmyrSAX682DH+2e7aNT9UvPbGvylfGhyIX
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799006|8062599006|15080799009|8060799009|41001999006|12121999007|3412199025|440099028|40105399003|12091999003|102099032|56899033;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sp7RUam63pkLcQ6fr2mszGuqVUe6qqrZMquDpR+aPI51m/edIfDQBoevJdYS?=
 =?us-ascii?Q?s5GrDCu/UqsHtVqFxP+HXwcrPzMenMRYrxDVf5DWaF0fsViqDqtuoV3o2Ra+?=
 =?us-ascii?Q?FUKD4oiJCeqxO7ApH/EeQSOxT+N2IF8U1FBgbdadX4/RSiVG9jZH1gi4suuc?=
 =?us-ascii?Q?N+Yjo1nYFvfidAapGFWogJAyDlWBcrcWFc23YVeDk4JQbpvOvgg0tewwuqSQ?=
 =?us-ascii?Q?bQSpsXNTiMXGra0Gb1EXOl552VgtSr3piTNuGZvILRAEQi3rXxghdSuYMFL6?=
 =?us-ascii?Q?8mMbnwxw/HNJ6jvUtK+vTWr2z3tHLGlwaicYmk6c+qfEUJHlvKgtMbIfg29E?=
 =?us-ascii?Q?m2qSRAeg9QLnKGomM9y2gIobGN3GNBe8C5RvBOB95SfMxbxM7zmoqn7rDenv?=
 =?us-ascii?Q?FQ8326Ye4O2uKFZ3ilirOKYLZU0Hzhrt0tfxJwqBWfMkRHvDfZ88I58MJqL2?=
 =?us-ascii?Q?r36v20s4cmqk1q3aSWFRVAGZyged9IBXlJqRmLmTcdS2DY/Twev8afWNa2q1?=
 =?us-ascii?Q?jR+ipDpkOMygVbEEYhvUeXpu3OSvL4IOb37zeTNFak3hofGVjxpgQFmn0swh?=
 =?us-ascii?Q?ipAPos/c6ZtvvRubv0kowX7oRn3yGbH5TI48jN9IEi0Hi+oF8Kln5qT1aRzO?=
 =?us-ascii?Q?7bV8C4cOwsQ8YOhEKFcFkkCNkhd2U+uWTaOGMyFajbXwRL1L35AhN82vj06L?=
 =?us-ascii?Q?dxq5RUNDj/EYu3SFRtb/GvJrLQvbm/+NQEb4vzGOuzPqUcrM+/praO3Tcu7L?=
 =?us-ascii?Q?kMEzmtHBN9x+swZquBoofEPs+T8jfyecin/XU0BLlfNgPsLU2H9y7TWqvc+C?=
 =?us-ascii?Q?XfKhlBq0eZ7DBcQp54JbS0xOpB5wzSo0gBNCKomexLP/8TcNvCFu7zqa5m9o?=
 =?us-ascii?Q?hsFZfQEKLr+UPeRFNIyNGvEt/FVvUiURkP+SLcVkSxxMNV/PAIdfbiI+TrP4?=
 =?us-ascii?Q?ojp3hYOwUhQETX+1/QuZorJO8DD8NIJOOJPbvMy9R2ygBSJo7XymiDw69DrH?=
 =?us-ascii?Q?Iw00pV7E37b9A1KlkEDAS4t/WVyRlMfk2kwACpYljOoF9VgjEV1YFMpp4SB/?=
 =?us-ascii?Q?oPBZ/FdG2A3lQp69nmJxL6Ffi3qAyIvloMaSxmxFZOKxUiYSpixwkexnRTVu?=
 =?us-ascii?Q?qerKE+k4QxAvAsJTnHLEG1mzZDGNBjejcZWiepNj+soBu8LNsR5JaJs82WXk?=
 =?us-ascii?Q?Wj5ptLRTwVUG3NyjqgrumNfpOq8fPJbeKXVtFg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pn7Wx8s2GtDpwOMlEYpitbzfc5EPpeyF4MK9sFfHimcY888wsCwghlLrWnIv?=
 =?us-ascii?Q?+r6PVM8u/sDcmYYwYVRh70bbKHmU4w+RsBL0tTgcMLmYp+sFjZzgQ0eqQBIO?=
 =?us-ascii?Q?hmK9yPebknLFYogM9STb+EY+ykUHP5GqhLtNOKKbAib/arhgYS024ZD/hTzw?=
 =?us-ascii?Q?xSSdPxO4i9qB0GLPvZHekVZBZnPdo+Qwd4lS4T0XxXhNox7rPYtqdEAJWh+o?=
 =?us-ascii?Q?7WWJD0vEjEvN8h1Z1XlJbPpFaO0OmRk0gNXg5/30Er4LbRqvze9kKb+gJ4Ji?=
 =?us-ascii?Q?aK7Jp62mFnMEoAESbig7TGRSjqLOlieo5krGn2Pn4PELI4KoJyzBtONoB+dR?=
 =?us-ascii?Q?fbez2DoCBqN+ULPYralA21NBbQyoJx+nLJ17PMhaHEbTIcXoshgOMlK6rs16?=
 =?us-ascii?Q?qhxdkmu/Gym05O3LQBNVz0EFcJyD0TOmv5BuumhzLtZj0jIPWMNuYKNVqzpI?=
 =?us-ascii?Q?KmayWneE0q2Znl46my5fl/jvVL4ODYng/c4m3nJX6Yc06nd+8dNtl/90txJv?=
 =?us-ascii?Q?eFrb1ZbJ9InQ1pfWIfhaPri3WIR5fNaUlOOkYJ9icybV3dAl4CHSKyO4lJrX?=
 =?us-ascii?Q?o1eS+iJ03Pn0b4MuFl3NJiM86KunvF04fZ18dcfr8ygnnrlddIRRyRvqKVDe?=
 =?us-ascii?Q?shmlWJ6qt4K4noU/Y2yPtvd15aIxpdLEwfOjiSGc4mF2vh7mE+x3N2qAZQb2?=
 =?us-ascii?Q?IWRvsQbpTOXM2vrn7Std5nf8IaxY0qBzeFh7HOs+HwNmJBZqfKjfnBmY816z?=
 =?us-ascii?Q?75w3gQaVT+xJLGDMgieSb9TEGW6/42epg66dy3RmjB4CQv0yCYhfbzhQxThV?=
 =?us-ascii?Q?104C1nO06Rx32/j63zXoNLoFF2WZvmB062DTeFlewAAyY7/nlJaSFpJghqdI?=
 =?us-ascii?Q?GC86Ca3620NGOrfOonHW0G9r2i4P6503DzjHhBYq87KTgHwZOBn3dRapBoya?=
 =?us-ascii?Q?AaR0b3YN5NPUrXgqfVMVtWrWKrNhlI6hZSoj/3did4yoLJujWu//wu70JHN3?=
 =?us-ascii?Q?MRK5Bjl8rIVuALBUdHU0p6N15wBjCrYu8hFF+OE3jwnSNR90zrnTlaY3V6ri?=
 =?us-ascii?Q?scZfIUdc8tQL5tnZoyYGTeEth0t+1yYxjGVsF8vjICF2KBVI0JPPPUTSrSvH?=
 =?us-ascii?Q?mFeDFNm1fVjVqcziTL03lkbIZL+SZwNqiqBJj4A8xEEZqokZuhVwNQDvKSMh?=
 =?us-ascii?Q?/3WxC69DvSqVVIj106KE3V3FDTXI33Uk9cG8NWVQQZ1jGruqOv7K/2jdpGY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 583da72a-b38c-4f5c-82bd-08ddae83c3d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 16:18:30.5407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8462

From: Roman Kisel <romank@linux.microsoft.com> Sent: Tuesday, June 3, 2025 =
5:44 PM
>=20
> The paravisor needs the SynIC pages to communicate with the guest
> via the confidential VMBus.
>=20
> Refactor and extaned the exisitng code to account for that.

Suggest adding a bit more context to the commit message:

Confidential VMBus requires interacting with two SynICs -- one
provided by the host hypervisor, and one provided by the paravisor.
Each SynIC requires its own message and event pages.

Refactor and extend the existing code to add allocating and freeing
the message and event pages for the paravisor SynIC when it is
present.

>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/hv/hv.c           | 184 +++++++++++++++++++-------------------
>  drivers/hv/hyperv_vmbus.h |  17 ++++
>  2 files changed, 111 insertions(+), 90 deletions(-)
>=20
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 964b9102477d..e25c91eb6af5 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -94,10 +94,70 @@ int hv_post_message(union hv_connection_id connection=
_id,
>  	return hv_result(status);
>  }
>=20
> +static int hv_alloc_page(unsigned int cpu, void **page, bool decrypt,
> +	const char *note)

Why have a "cpu" argument to this function? It's not used anywhere.

> +{
> +	int ret =3D 0;
> +
> +	/*
> +	 * After the page changes its encryption status, its contents might
> +	 * appear scrambled on some hardware. Thus `get_zeroed_page` would
> +	 * zero the page out in vain, we do that ourselves exactly once.

s/we do that/so do that explicitly exactly once/

Avoid personal pronouns like "we".

> +	 *
> +	 * By default, the page is allocated encrypted provided the system
> +	 * supports that.

More precise: "the page is allocated encrypted in a CoCo VM"

> +	 */
> +	*page =3D (void *)__get_free_page(GFP_KERNEL);
> +	if (!*page)
> +		return -ENOMEM;
> +
> +	if (decrypt)
> +		ret =3D set_memory_decrypted((unsigned long)*page, 1);
> +	if (ret)
> +		goto failed;
> +
> +	memset(*page, 0, PAGE_SIZE);
> +	return 0;
> +
> +failed:
> +

Don't need a blank line here.

> +	pr_err("allocation failed for %s page, error %d when allocating the pag=
e, decrypted %d\n",

The "when allocating the page" portion of the above message is somewhat red=
undant.
Compare with the similar message in hv_free_page().

> +		note, ret, decrypt);
> +	free_page((unsigned long)*page);

I don't think the page should be freed here. When set_memory_decrypted() fa=
ils, the
encryption state of the memory is unknown, so it should not be put back on =
the free list.
It's the same situation as in hv_free_page().

> +	*page =3D NULL;
> +	return ret;
> +}
> +
> +static int hv_free_page(void **page, bool encrypt, const char *note)
> +{
> +	int ret =3D 0;
> +
> +	if (!*page)
> +		return 0;
> +
> +	if (encrypt)
> +		ret =3D set_memory_encrypted((unsigned long)*page, 1);
> +
> +	/*
> +	 * In the case of the action failure, the page is leaked.
> +	 * Something is wrong, prefer to lose the page and stay afloat.
> +	 */
> +	if (ret) {
> +		pr_err("deallocation failed for %s page, error %d, encrypt %d\n",
> +			note, ret, encrypt);
> +	} else
> +		free_page((unsigned long)*page);
> +
> +	*page =3D NULL;
> +
> +	return ret;
> +}
> +
>  int hv_synic_alloc(void)
>  {
>  	int cpu, ret =3D -ENOMEM;
>  	struct hv_per_cpu_context *hv_cpu;
> +	const bool decrypt =3D !vmbus_is_confidential();
>=20
>  	/*
>  	 * First, zero all per-cpu memory areas so hv_synic_free() can
> @@ -123,73 +183,37 @@ int hv_synic_alloc(void)
>  			     vmbus_on_msg_dpc, (unsigned long)hv_cpu);
>=20
>  		if (ms_hyperv.paravisor_present && hv_isolation_type_tdx()) {
> -			hv_cpu->post_msg_page =3D (void *)get_zeroed_page(GFP_ATOMIC);
> -			if (!hv_cpu->post_msg_page) {
> -				pr_err("Unable to allocate post msg page\n");
> -				goto err;
> -			}
> -
> -			ret =3D set_memory_decrypted((unsigned long)hv_cpu->post_msg_page, 1)=
;
> -			if (ret) {
> -				pr_err("Failed to decrypt post msg page: %d\n", ret);
> -				/* Just leak the page, as it's unsafe to free the page. */
> -				hv_cpu->post_msg_page =3D NULL;
> +			ret =3D hv_alloc_page(cpu, &hv_cpu->post_msg_page,
> +				decrypt, "post msg");
> +			if (ret)
>  				goto err;
> -			}
> -
> -			memset(hv_cpu->post_msg_page, 0, PAGE_SIZE);
>  		}
>=20
>  		/*
> -		 * Synic message and event pages are allocated by paravisor.
> -		 * Skip these pages allocation here.
> +		 * If these SynIC pages are not allocated, SIEF and SIM pages
> +		 * are configured using what the root partition or the paravisor
> +		 * provides upon reading the SIEFP and SIMP registers.
>  		 */
>  		if (!ms_hyperv.paravisor_present && !hv_root_partition()) {
> -			hv_cpu->hyp_synic_message_page =3D
> -				(void *)get_zeroed_page(GFP_ATOMIC);
> -			if (!hv_cpu->hyp_synic_message_page) {
> -				pr_err("Unable to allocate SYNIC message page\n");
> +			ret =3D hv_alloc_page(cpu, &hv_cpu->hyp_synic_message_page,
> +				decrypt, "hypervisor SynIC msg");
> +			if (ret)
>  				goto err;
> -			}
> -
> -			hv_cpu->hyp_synic_event_page =3D
> -				(void *)get_zeroed_page(GFP_ATOMIC);
> -			if (!hv_cpu->hyp_synic_event_page) {
> -				pr_err("Unable to allocate SYNIC event page\n");
> -
> -				free_page((unsigned long)hv_cpu->hyp_synic_message_page);
> -				hv_cpu->hyp_synic_message_page =3D NULL;
> +			ret =3D hv_alloc_page(cpu, &hv_cpu->hyp_synic_event_page,
> +				decrypt, "hypervisor SynIC event");
> +			if (ret)
>  				goto err;
>  			}
> -		}
>=20
> -		if (!ms_hyperv.paravisor_present &&
> -		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
> -			ret =3D set_memory_decrypted((unsigned long)
> -				hv_cpu->hyp_synic_message_page, 1);
> -			if (ret) {
> -				pr_err("Failed to decrypt SYNIC msg page: %d\n", ret);
> -				hv_cpu->hyp_synic_message_page =3D NULL;
> -
> -				/*
> -				 * Free the event page here so that hv_synic_free()
> -				 * won't later try to re-encrypt it.
> -				 */
> -				free_page((unsigned long)hv_cpu->hyp_synic_event_page);
> -				hv_cpu->hyp_synic_event_page =3D NULL;
> +		if (vmbus_is_confidential()) {
> +			ret =3D hv_alloc_page(cpu, &hv_cpu->para_synic_message_page,
> +				decrypt, "paravisor SynIC msg");

Shouldn't the "decrypt" parameter just always be passed as "false"? That's =
the
fundamental tenet of Confidential VMBus -- these pages should not be decryp=
ted.

> +			if (ret)
>  				goto err;
> -			}
> -
> -			ret =3D set_memory_decrypted((unsigned long)
> -				hv_cpu->hyp_synic_event_page, 1);
> -			if (ret) {
> -				pr_err("Failed to decrypt SYNIC event page: %d\n", ret);
> -				hv_cpu->hyp_synic_event_page =3D NULL;
> +			ret =3D hv_alloc_page(cpu, &hv_cpu->para_synic_event_page,
> +				decrypt, "paravisor SynIC event");

Same here.  "decrypt" is always "false".

> +			if (ret)
>  				goto err;
> -			}
> -
> -			memset(hv_cpu->hyp_synic_message_page, 0, PAGE_SIZE);
> -			memset(hv_cpu->hyp_synic_event_page, 0, PAGE_SIZE);
>  		}
>  	}

Refactoring this function with the hv_alloc_page() helper function works ou=
t
very nicely! The code is simpler and the error handling is much easier to g=
et right.

>=20
> @@ -205,48 +229,28 @@ int hv_synic_alloc(void)
>=20
>  void hv_synic_free(void)
>  {
> -	int cpu, ret;
> +	int cpu;
> +	const bool encrypt =3D !vmbus_is_confidential();
>=20
>  	for_each_present_cpu(cpu) {
>  		struct hv_per_cpu_context *hv_cpu =3D
>  			per_cpu_ptr(hv_context.cpu_context, cpu);
>=20
> -		/* It's better to leak the page if the encryption fails. */
> -		if (ms_hyperv.paravisor_present && hv_isolation_type_tdx()) {
> -			if (hv_cpu->post_msg_page) {
> -				ret =3D set_memory_encrypted((unsigned long)
> -					hv_cpu->post_msg_page, 1);
> -				if (ret) {
> -					pr_err("Failed to encrypt post msg page: %d\n", ret);
> -					hv_cpu->post_msg_page =3D NULL;
> -				}
> -			}
> +		if (ms_hyperv.paravisor_present && hv_isolation_type_tdx())
> +			hv_free_page(&hv_cpu->post_msg_page,
> +				encrypt, "post msg");
> +		if (!ms_hyperv.paravisor_present && !hv_root_partition()) {
> +			hv_free_page(&hv_cpu->hyp_synic_event_page,
> +				encrypt, "hypervisor SynIC event");
> +			hv_free_page(&hv_cpu->hyp_synic_message_page,
> +				encrypt, "hypervisor SynIC msg");
>  		}
> -
> -		if (!ms_hyperv.paravisor_present &&
> -		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
> -			if (hv_cpu->hyp_synic_message_page) {
> -				ret =3D set_memory_encrypted((unsigned long)
> -					hv_cpu->hyp_synic_message_page, 1);
> -				if (ret) {
> -					pr_err("Failed to encrypt SYNIC msg page: %d\n", ret);
> -					hv_cpu->hyp_synic_message_page =3D NULL;
> -				}
> -			}
> -
> -			if (hv_cpu->hyp_synic_event_page) {
> -				ret =3D set_memory_encrypted((unsigned long)
> -					hv_cpu->hyp_synic_event_page, 1);
> -				if (ret) {
> -					pr_err("Failed to encrypt SYNIC event page: %d\n", ret);
> -					hv_cpu->hyp_synic_event_page =3D NULL;
> -				}
> -			}
> +		if (vmbus_is_confidential()) {
> +			hv_free_page(&hv_cpu->para_synic_event_page,
> +				encrypt, "paravisor SynIC event");
> +			hv_free_page(&hv_cpu->para_synic_message_page,
> +				encrypt, "paravisor SynIC msg");

As with hv_synic_alloc(), for these two calls, always "false" for the "encr=
ypt"
parameter.

>  		}
> -
> -		free_page((unsigned long)hv_cpu->post_msg_page);
> -		free_page((unsigned long)hv_cpu->hyp_synic_event_page);
> -		free_page((unsigned long)hv_cpu->hyp_synic_message_page);
>  	}

Same here on the refactoring. Very nice!

>=20
>  	kfree(hv_context.hv_numa_map);
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index fc3cdb26ff1a..9619edcf9f88 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -120,8 +120,25 @@ enum {
>   * Per cpu state for channel handling
>   */
>  struct hv_per_cpu_context {
> +	/*
> +	 * SynIC pages for communicating with the host.
> +	 *
> +	 * These pages are accessible to the host partition and the hypervisor,
> +	 * so they can only be used for exchanging data when the host partition
> +	 * and the hypervisor are trusted.

This comment isn't quite accurate. The hypervisor SynIC and its message/eve=
nt
pages are used in today's CoCo VMs (without Confidential VMBus) where the h=
ost
partition and hypervisor are not trusted. The guest must be prepared for ma=
licious
behavior by the SynIC, but that doesn't prevent today's CoCo VMs from provi=
ding
the intended confidentiality.

> +	 */
>  	void *hyp_synic_message_page;
>  	void *hyp_synic_event_page;
> +	/*
> +	 * SynIC pages for communicating with the paravisor.
> +	 *
> +	 * These pages can be accessed only from within the guest partition.
> +	 * Neither the host partition nor the hypervisor can access these pages=
,
> +	 * so they can be used for exchanging data when the host partition and
> +	 * the hypervisor are not trusted, such as in a confidential VM.

Same here on this comment.

> +	 */
> +	void *para_synic_message_page;
> +	void *para_synic_event_page;
>=20
>  	/*
>  	 * The page is only used in hv_post_message() for a TDX VM (with the
> --
> 2.43.0


