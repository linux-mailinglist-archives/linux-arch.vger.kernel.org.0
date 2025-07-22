Return-Path: <linux-arch+bounces-12890-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C828B0E2D6
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jul 2025 19:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93314164E38
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jul 2025 17:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BE1281376;
	Tue, 22 Jul 2025 17:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="tC3Xrhuo"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2054.outbound.protection.outlook.com [40.92.20.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E062820BA;
	Tue, 22 Jul 2025 17:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206265; cv=fail; b=duu+jgir20qsbaNKPDAAuhxyIlgRaL0MYYUqacUlxwqhY3cqKqbeiolQpq3763Xbw7LNclKn53CaUJzNy/tWVqeS1waNOMBCXLd9TbJwdAY8JCzvh/lphaFQ0LghNpSDJHbJagwED9N0g1HggwFlJUybW37xFgh/MEAZ9HPvgkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206265; c=relaxed/simple;
	bh=rDKSYzLt4lm8acc0GKz9A/7VgkaWzrgkMMGstdT7JW8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fOJ2eqzFPGyPK2eEWb5aeeCyXCKJeSEMNbJg/GBgNr8RJbZgvnCf1cczuQK/yf1psaR3X5hk9uiCpQRQORijgLanZ5zxO80yQhLfC3+BgVOqv+l49kAaDPuw31VEco7HPRrUrkHlpezejxe2wPx1sZ+A6Dovr5Ida9XX4VJcRC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=tC3Xrhuo; arc=fail smtp.client-ip=40.92.20.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVeZuxu0lJJsF+O/jwplLI+e5k+YmpstLUypEBNPJqPqkzRMaMMGm2PpobLZRQmoD8Y3U0h1aQpqpGnOYZPw6bzOTlxxwI+oA8ZcsYv9AKnSpyY4dl8t8Rq8dSr9J3s+pclZJyyjY0X9Vhe9o2HXrr9pXFfHkz+BmEQs0PkKaOIOaQOTcspeJyXyN/MUYQdpdQfS5A1tuiuW6CQAYjYt02gYyyjuasCsBgpsDbzl97PqLJywmhIDr8Ftiqa6uBECR8f5ZBSPuqPBd1D/NMk0Fa7nvSqcWnZ8Ez5yJLXH/1JFXq3SMJZ3dYcGFvPeX4B2YXf3RN75gfxR+foVSTv/Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jxf7osS1/Zed5namm+d2OmQCe8dMshMg1/YBM059+cg=;
 b=wl0MX/+5skmsNoQIwnXVfqRwrgSq7E/sw5A1s0npf0HtReE/q1TG716CGflRj541TX3/+JfsetXLyCMOf47hy6JDn1YzCxPEElFNy8O8AUASrvw/nupnT1sc5YGPykvpEyeYIdnpl6NcP5ypA0m8gGnEPdfsE+BEASifME2GNQdF9yI9IB9Xs3PCSK0twnHW0YkjRF3BQi8C/XJ/ccf5tASqjkXSIDTQCltfzEZWteXge08+nfY5hIYOJtiuuOqW+Mg9P/4mMIfGHdjKjJaD0fZvz9v0OaGNfbO9ilWEaaFYKGJr+mTmvs8U2ymL2LeODRchcdsFVxGnY+bFDrUT6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jxf7osS1/Zed5namm+d2OmQCe8dMshMg1/YBM059+cg=;
 b=tC3Xrhuodf5fdCHxDfrH02M5EjYRaDGlhaG0Dt8ak+OXqg37A/ELARFxFvsSGtB5xlAIwcKd5mBzAATT/VRYg29Irz2vaHdde+DoEn2cgnt6WEIHOu7UBXBdnLIQph5l9UtAXliXuqO3SVBmtk1wgunEgEpZuZYiZzxdjwga2/YkQzOz7MzrKjWz9HUFe0dQX39hgANbXnMzn3C18XK92EGw+LrYhZOH8jN5Lng6TjNLDB4mhGeH+zs/GiQ0ewF1mpVQJuljRP/wATmjjUzKCHOJ4hHGI6Wd/sJHjFsj9qjmb/y7HSbtwcyIKQn94XB9gt5yXUjBxQ2rZg8va3/GUw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY8PR02MB9201.namprd02.prod.outlook.com (2603:10b6:930:9c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Tue, 22 Jul
 2025 17:44:20 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 17:44:20 +0000
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
Subject: RE: [PATCH hyperv-next v4 07/16] Drivers: hv: Post messages through
 the confidential VMBus if available
Thread-Topic: [PATCH hyperv-next v4 07/16] Drivers: hv: Post messages through
 the confidential VMBus if available
Thread-Index: AQHb9QzbP385w3Op9kiG/2yu3wV7xLQ4mL1Q
Date: Tue, 22 Jul 2025 17:44:20 +0000
Message-ID:
 <SN6PR02MB415784965C57E09973A80241D45CA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250714221545.5615-1-romank@linux.microsoft.com>
 <20250714221545.5615-8-romank@linux.microsoft.com>
In-Reply-To: <20250714221545.5615-8-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY8PR02MB9201:EE_
x-ms-office365-filtering-correlation-id: 9cb6b9fb-8672-412c-f779-08ddc947634a
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|461199028|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nnkAMLQZzDN6pf9XevfqgHfr3AGTD+f21MR+Da368ZZguDqDY8kSxCzrgdzl?=
 =?us-ascii?Q?FB56b5NXmhcyk5rWE78+/+O3cdAdf5k9v5Dot/vLB4ojQw/7+Qeyhu6558ez?=
 =?us-ascii?Q?42/4ZKEUMAJDSjbd+5Sf5HpqKeccO9aw2TabQM1Pos6uOxLt00cb2TuJX+qi?=
 =?us-ascii?Q?HZBB/2Jky+cdXuRTR2yRGEcPvu6s3i9wq2CYtRPwBSguKIGpke9wVZFHwHRF?=
 =?us-ascii?Q?DsTqPmmUST+TJb3IPG08XF+AJKgYCBPYUS1MRAO2fV5Io4/oaZeTgBgoY/q1?=
 =?us-ascii?Q?8WQKD/t8JYoHTQdgoKL4gf1tg96ZcAqQ+EWxFY032UAx65pbRF/K7v+Hut3n?=
 =?us-ascii?Q?jsygvF3JK5peuQBaWmtMX4blcMmO31bw7yELmH+SUgYJbgeVMrjQ2f6BV+tF?=
 =?us-ascii?Q?RNVe4mVFEAk0HVDHMq+my6kFqgK+qjG2Z/VLHXEdpgohWq3wt3oeZKf8e5F9?=
 =?us-ascii?Q?IiUNnng1glrqJzVXfao8+2fGiLaUbiLs7lEg0x9Uczz4AMwYXVkmHeMMLQf3?=
 =?us-ascii?Q?KYFEh+4xqdu202dtpAMA6wrVBvbQIDeiYr176MK6B9cXgIdaF2+tgEiGxZ6J?=
 =?us-ascii?Q?h2w7DTw7Vc9YYoSOvKaKw3Bp/ub7GiROJllVhCVN5LOehU261uKX/Cx7g2Zs?=
 =?us-ascii?Q?ZF9gETvQPoSOHuHeubrNqOWpK3idUa8FadrkF1pux8SM9eTfLJLmJVRspByo?=
 =?us-ascii?Q?L0zIZ8gg9xWiGNfFtEwwbkDDn5oHqBLC7dXaTEedoOmE7T/8NdRG0F+XQmJG?=
 =?us-ascii?Q?NyG5Wy5e/SfYVCb6yPiROpv+TCHqRzBEW3jODF6Q18T792g0SwxyrPzCXWVV?=
 =?us-ascii?Q?pXdRjQkWQU/r0vA0PiG0NjWuOEnqppMciKlFvcfVZ/DRiJPeF2CD5iu08C/J?=
 =?us-ascii?Q?tfbJEhshGfkef2VxSxCeW1IPIRwwrNiAPiSVw+ad/mHzbNFx6gPsHinnH8jI?=
 =?us-ascii?Q?PCHkKAQPFuJgxxO52QI91uHt/1eInDrcfHb8Wid3EDDs1qkjF9sfz7zla3Tc?=
 =?us-ascii?Q?LY9XFkHkImVeZPsQBsBQy/jqNg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?E6fW738royCHU3pWo6t8rXemnSj31TT0oA2knrSZ4a+PuQ6o+C8riTSk+kYH?=
 =?us-ascii?Q?i9V6nCKHlHIrA0G7GtrrCT73Kcua8RiGIoUQanBTeSmuevHo1PpU0Xw0G9HJ?=
 =?us-ascii?Q?NzQOmbXq1HIWXjDehjNud3cmo/SNt/fS3imtM2DVW1eDRe1ckLmtq1/mzO7b?=
 =?us-ascii?Q?b0h8Qh1tYIDw7cv+iNbSmsRj4fzhnevsn2j4v5hlSMCoeNJl256t8MDCMwWw?=
 =?us-ascii?Q?2oQ7PdW70B+JEoq/50p0+dOPYaU9yet+MAdCbBbNsNfASqQL/oO1aLOSoSgu?=
 =?us-ascii?Q?EjfE6QozBHJXi0dHKPUs7ziqxGHN1girQnoblVKcFcrtHGR449bs/4lqcmAW?=
 =?us-ascii?Q?tLqPAniUVgrlcMRDx09pAAuQl3TAUUhMFJN4zzkK9yxtIN1nFpH1PYg3Xzzd?=
 =?us-ascii?Q?RXwKnfj9uk8TDaI/pRBRyoiI7OfLGudOe8HBSuzwB79sB0/gs8egJinuM34M?=
 =?us-ascii?Q?/a2CctmI++C1zKLzpARrTWeKGRAfTmcLnYOGv2giv+GjWzZ6IZNzQw4IujHP?=
 =?us-ascii?Q?eDXjHvyrhxRqDUmlVqCXkxR+Tju1sYldmR+RrBjU/JMkCQkwToBirp42pisT?=
 =?us-ascii?Q?aV5QGssaDA3dUNSH/ls0EYwNRWRL1dbschwhfGPeUD9mGYAJO419pq2SIn1v?=
 =?us-ascii?Q?UVQIUZ3psplLbyarQk2kiUZSufVk3leKjmxxCuO94zj5mNhVHI8zohRBcUdP?=
 =?us-ascii?Q?rim352OcU03bfNDMLItqiGvLaoxEDa6MuAWF6gibdRvd2XERI2pHtyQEnSAl?=
 =?us-ascii?Q?xZpTj7vwSS6fPPoHZCTf2QxMG+sxlLeHhnCb3lXupfdLVo7lz08ZkCyi/GqT?=
 =?us-ascii?Q?wpetU2ZT1BffAgoehuPhL2mKFmG/LSDhDV16GpLGSGemYA4nWLdcCXDJRG/E?=
 =?us-ascii?Q?pPt7IaTlOjk+cj4YW2dbC3A6sfDvXz+8q3lB3P/4dHkk/0aTh+R7OB62JK5n?=
 =?us-ascii?Q?AureSmbn8JZyImwtNkeCKY1yxkD2diFvZj+bvC5o2fD20xuoPBINaFal7gLp?=
 =?us-ascii?Q?LABeI7V0z1wBcRz83aK7yjzkl/6Rtl2RSgiefDbgGY9pJ1htE1YzuUlYu2Ey?=
 =?us-ascii?Q?zE1Lk3inwY6efZr9A7Czzej7jp+j4gKxSCIOkDti8TasIx0pR8tSMPpL7Vtv?=
 =?us-ascii?Q?GCcKdFAScyhJMF0UzFDTsg434DMVN+/Qay6cFco/Qcps7zoyBxKDrLWVZa3B?=
 =?us-ascii?Q?4bqo0pUxMhg5+vUCfFkdThle9/wBbWCQQLpz0Tp1N63OhKtWKhdB0YaXFvY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb6b9fb-8672-412c-f779-08ddc947634a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 17:44:20.1665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9201

From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, July 14, 2025 =
3:16 PM
>=20
> When the confidential VMBus is available, the guest should post
> messages to the paravisor.
>=20
> Update hv_post_message() to post messages to the paravisor rather than
> through GHCB or TD calls.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  drivers/hv/hv.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index e9ee0177d765..816f8a14ff63 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -74,7 +74,11 @@ int hv_post_message(union hv_connection_id connection_=
id,
>  	aligned_msg->payload_size =3D payload_size;
>  	memcpy((void *)aligned_msg->payload, payload, payload_size);
>=20
> -	if (ms_hyperv.paravisor_present) {
> +	if (ms_hyperv.paravisor_present && !vmbus_is_confidential()) {
> +		/*
> +		 * If the VMBus isn't confidential, use the CoCo-specific
> +		 * mechanism to communicate with the hypervisor.
> +		 */
>  		if (hv_isolation_type_tdx())
>  			status =3D hv_tdx_hypercall(HVCALL_POST_MESSAGE,
>  						  virt_to_phys(aligned_msg), 0);
> @@ -85,6 +89,11 @@ int hv_post_message(union hv_connection_id connection_=
id,
>  		else
>  			status =3D HV_STATUS_INVALID_PARAMETER;
>  	} else {
> +		/*
> +		 * If there is no paravisor, this will go to the hypervisor.
> +		 * In the Confidential VMBus case, there is the paravisor
> +		 * to which this will trap.
> +		 */
>  		status =3D hv_do_hypercall(HVCALL_POST_MESSAGE,
>  					 aligned_msg, NULL);
>  	}
> --
> 2.43.0


