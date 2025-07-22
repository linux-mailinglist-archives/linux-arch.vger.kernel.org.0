Return-Path: <linux-arch+bounces-12899-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3957B0E2FA
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jul 2025 19:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAEAC3BDE2B
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jul 2025 17:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9954E284B3C;
	Tue, 22 Jul 2025 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OYA6F+xs"
X-Original-To: linux-arch@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazolkn19013086.outbound.protection.outlook.com [52.103.2.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4071C283695;
	Tue, 22 Jul 2025 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206338; cv=fail; b=WEfuaWLdjtqq1MpLLEQQ4M7+U1pykrC/EODefIAPB2Fx2m1ULhT8HjosdmsRw0p1AIk2XI0/tFb8q1pHohzHO12ki4ADG3mlNX93MzcFPvEJB6bh3ohPW84sQQRLAEsOuLJmLqz9dxeKHnDFDVxG7FYNf+nNFKvAQsh8xeiBN6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206338; c=relaxed/simple;
	bh=fa1L0LM4noQK9KsP47GfiGtglZx29fDLXkXvAALicdg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lC9NDVLDH57zuBg57eL8VyOHPGa/RhCnhkCb0zzfMic5shwgNBcB/qTB4bxpajDPVGPCiR8rUBv0AvALKXWMan8BswDWeIjCryg0zs3qbzC7W8NPEnDwDurBCX/5arIbF6nIRha0NXt5hqDdshE/CW8pW2enH8KZxgfXgYFIZJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OYA6F+xs; arc=fail smtp.client-ip=52.103.2.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lmquqaob2EBw1xqyGTMnsgNTCqJbdI3JITs5yr7htc4GEfeCCKtZ+XNllixt2G7Y2g1PcIkm9u9y8b4nrpEwuquoPzawxeVmTGB/C+kITOHBvqPqaWfteFbrrxRxrqCVzzGBuIUV1xgBNO9zNJ3JamrvdnwP5GvzEF+hBZZfClur4gJdvPcH56fcHjTP35B/oyWV3a8TOJzLB+VCDRapvlj3gvpDzKcJ8esxsrDPqdol7SjVKrSBnHc9mbpD0E2vEJ0Jvv9tjJrybe7eSA9apxknJ4FxCPPM3GaT8g4xsSXgfJ84FRvdmfqaUnv32dc7D+HfFmZlOubM56YhkCqyWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkUgYEPyqULsDtQNWEGW3x57yPHyg36rZgWlgpVgfz4=;
 b=qnZPemHg3RFsjaqhCtOTUka16r2JSewuzYQQ51RfrRD/lv1kWcfp2yWwxvvzUfLvdkPGDOGF3EFiWrHa1j7tobtAjP//hEAg8S6HLKwD/3X4Ju8Du2zuZAks8psuj0Vp7jBZAyFMr6i4D1u2/CSTIO6hLpFdFgJFZV0uM958L/utfO5hV9pr/WijEpXxLyJxYLXOXgjBwWDjjqmiWO2nW536vSO16XyFdNotFaA1F2rOJY0mGk7HBcenb4ur1RWGRTlXW4S213rFoB5v1BayoevnrdnjsW1I525+BLctCMZfKT6+KO++VVu006MGT0oe8lpV3NjSoN19OO/eqyZhHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkUgYEPyqULsDtQNWEGW3x57yPHyg36rZgWlgpVgfz4=;
 b=OYA6F+xsVyc7MjOXPqOCFp8YBfCil5YLr/biVwqNqQxBL6C5YzPADmOUUXe4qJB4+saaPeFHTVd4QArmJl8RFSyb5zJWwX0WykCU4ECV5RcVQQNEz5jxkRaUeFnqOJcH6E1xcFtNxb1R3wzWihHe1RyY3DhE9BnifxhlMPr6d45pox60SaDEP9hu7b7n0DI3OgCaW5uvsenNRPWOml/AMhhHaJTeVaW1gsU8SfgItFh+nzqRDg1Tup+wJF1XPmifO4DpM3Amane7HjiarLckvL4sUAmUDdLQ2+cKlhTE/W2wrLFix1Q1w8LZzA6lLsHQ9jQc/oUH6+I5AWN24MzuJQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BN0PR02MB8141.namprd02.prod.outlook.com (2603:10b6:408:164::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 17:45:30 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 17:45:30 +0000
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
Subject: RE: [PATCH hyperv-next v4 16/16] Drivers: hv: Set the default VMBus
 version to 6.0
Thread-Topic: [PATCH hyperv-next v4 16/16] Drivers: hv: Set the default VMBus
 version to 6.0
Thread-Index: AQHb9Qzc5ArfoRHPp0eKmacB2h9gbbQ4zFrQ
Date: Tue, 22 Jul 2025 17:45:30 +0000
Message-ID:
 <SN6PR02MB4157729EF896F0941E71DA47D45CA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250714221545.5615-1-romank@linux.microsoft.com>
 <20250714221545.5615-17-romank@linux.microsoft.com>
In-Reply-To: <20250714221545.5615-17-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BN0PR02MB8141:EE_
x-ms-office365-filtering-correlation-id: 4ad25bce-8c69-4d6f-f191-08ddc9478ce9
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|461199028|440099028|40105399003|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7qopXvDsMo1mMWaI5BibLcucpW02dTFH8RqyeI/2/3aVtDvhp87dCtUWTG5b?=
 =?us-ascii?Q?oJTElq2n/MlKcRd15XVnygA3/ucMx+UCKA70MpTGLRGEt19uk+HLaJf6rbA+?=
 =?us-ascii?Q?w3OPZkJydNDO3gNP5KN3mkzuR86DhmIgIlDNgLy8w81T+CtygLq7BuylM9Eu?=
 =?us-ascii?Q?x4+93yeKIjmr+f2wbW3tdLHgkgGJE0L4gSWfiGwT/XB1DPekLbxfhgmhKtZO?=
 =?us-ascii?Q?8EtjsxOvPfHTI0R4FL4Ua8dvzp+6xwy+IyDiCiTXJbjG/jBY9x2+SiQ2xjhO?=
 =?us-ascii?Q?VS3H3PKpQ2mp1+Sh86pLnvRmGD/2S3deDcxsm3xN4dTo/M8zEDMBJ0gOcsmh?=
 =?us-ascii?Q?hkuVLB0ip7MsRJZ89FF/wMCMg1c5IEgZ1M0wJ6VGa1R6iHLRnu2okuKeuSYb?=
 =?us-ascii?Q?EEV36t7eybCz19c7lQJ1cro6cXvDylYY0OOQy7DHCUcX+W3BmuVOXacLoGZQ?=
 =?us-ascii?Q?FcPT/TuNTL1166QrkaoZElMDe6Sskona7lNaV/fBoT2CnetwhzQyDD7Z8iWy?=
 =?us-ascii?Q?iHv0c5CBysNwE0g7mtL0jyInMhx5HuuoHPjViKaQz4F0luWluIcMHBG/itus?=
 =?us-ascii?Q?ld4CaJ2ncyZkKZQhQF8J5Y6Lhi3IOYyARFrdj4wM7wYXFg1rs9iKNdN2HLg0?=
 =?us-ascii?Q?+/3h0c19BKGhECxEwgxgjDkw0Qw09Nw4ZyMd/chf9peenO3+wS0XrUUKtLP9?=
 =?us-ascii?Q?0UqXxUlS5P1sfiaaehxYpMBSmTXrl1nwW7GahwiCRXf/J0V3Hgu7QPpXmkVk?=
 =?us-ascii?Q?G5ZBrQlRpydG0Ixhco4dc6Z5OshfAguR+ePD34KecYJGBYJ4cooS9z5CUqML?=
 =?us-ascii?Q?UrZ5aPPUBCWnSOkggcu614kNnaOKgLjq7pFGkSB0aDcBTc9vlb23FUY5o3J4?=
 =?us-ascii?Q?JDPH5nXLdGbtXFPvR0MxlnFpL0nc8peRgTE6TrOvJmCB1GXveANh+9tzYe3T?=
 =?us-ascii?Q?L2ndKcECt8mCG1odV9h35irJNwOCdW2W91w9kJWvfMWC8IeiRuAmOhkWIeAq?=
 =?us-ascii?Q?dQM6ogyCrJnCidCUDwamd6MBVQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ajEdnIwdjDqyNy9YznQ/mZKBRLeugwsTVjuMnS13UUwmNiEhRDu/ep4oEAch?=
 =?us-ascii?Q?ZUavBfxy3Vu40Wd2dD2kd/HMqhkhnoUB/yL4qBD0kiLL/DEXv+E62cgKHdVr?=
 =?us-ascii?Q?/QnlO/+awruD7M4vAfcQ2jxRfRc0BlnZJISQ1afX4uMeZtV+HK9I8TEktjS+?=
 =?us-ascii?Q?l+0OX4Py8NiSPrzXQg9YhIg67KxL8yuwxGhXlUEsHSvKMIg6D4nAV2K6PkJ8?=
 =?us-ascii?Q?gYDlKmc/Q6vTmQZXbm425p/o0vbkmjgtxNwRT+wF71/WF6fjw/Naowl5FuAw?=
 =?us-ascii?Q?fR+TjqR89fwwJCJ7j5VM2g1g1BxZw8C3MyJdz1yKdzkXa5tihXd9D8aC2QKO?=
 =?us-ascii?Q?/CBQqYCs9pdNtZrkPqtN7yDiXZNAbTGQK+7Vf36fmzBbYrS0+3eJercF08G3?=
 =?us-ascii?Q?ECViX5E0ZfFUcwAJC4mXAiebFtHeyByyAO1cTUFNjEaIrWc7G2RPkJVmd4c/?=
 =?us-ascii?Q?dIZj8YKYua5OuSnioyT4+9Tw27z+nN3nmOos0+7Hqc0MCJcGsM/EeaIO2mXx?=
 =?us-ascii?Q?bz/O9s7EQJndkD5b9zzYRK4oAn4zRCtyo0GcUq2RO+sN1UMctgRLsVYkyfIC?=
 =?us-ascii?Q?PKsSwNlKyYSIMVeqfZONjJ1NKomtQjpkcj5+27Hd2An5xf+j01EVIj/SYdZi?=
 =?us-ascii?Q?gMFjjFyKz6IzJCQ8LDif0HUxfVt/s17MYUGSwOpFFd2bOlBgNaTF5gzWeuZz?=
 =?us-ascii?Q?jmAxB1pR4Lq3iAgOWdvWY3g54P6RGtrcKdlVhzF+L9mp57wrdqjoyG5gPmlt?=
 =?us-ascii?Q?oH+eb4Gk0Ky9I44NjAMKqS7VOWRZXhj+b6UkNfeQnDufWRQdwgx7zwpCBqM7?=
 =?us-ascii?Q?lCI28NfSKcoUoQX9pOfk/oQDjcztrNzjT7S5WxiK2zXkP2MB0aUnj27loLtN?=
 =?us-ascii?Q?lG6PnWQnanqSTpt5OJWqR1oyH7tas401qIin8pqPg6BB/eHHbyGgST/bCJBp?=
 =?us-ascii?Q?8X3kZem3uYIPXdok/oqb8kdsD8+E0MH4+GnUiWtIXhc7G0tHprxOllT7T8uf?=
 =?us-ascii?Q?u4TmnE99dqTV7oSuDFT0K2fDSrzUZ8BwyhPbJXO2znjabUrHeUW1M1dS00Oc?=
 =?us-ascii?Q?yXu08H6EAdV3MF2xkFmMCCas5a3apaepdjqBZKIJyspOpyG0IQHtOb2IGd9l?=
 =?us-ascii?Q?lxnMJP+6IrfhvX+FYUiWLzh+igGWz62P6ivY/RbEkIX65J/tRmbUptJukBir?=
 =?us-ascii?Q?ETa+qbNu3ZEqiCEKMR3D1jXh14czgo20wTjYOL0hY4h4U/hnAhDqZOfr+dY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad25bce-8c69-4d6f-f191-08ddc9478ce9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 17:45:30.0355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8141

From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, July 14, 2025 =
3:16 PM
>=20
> The confidential VMBus is supported by the protocol version
> 6.0 onwards.
>=20
> Attempt to establish the VMBus 6.0 connection thus enabling
> the confidential VMBus features when available.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/hv/connection.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index eeb472019d69..7cd43463f969 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -51,6 +51,7 @@ EXPORT_SYMBOL_GPL(vmbus_proto_version);
>   * Linux guests and are not listed.
>   */
>  static __u32 vmbus_versions[] =3D {
> +	VERSION_WIN10_V6_0,
>  	VERSION_WIN10_V5_3,
>  	VERSION_WIN10_V5_2,
>  	VERSION_WIN10_V5_1,
> @@ -65,7 +66,7 @@ static __u32 vmbus_versions[] =3D {
>   * Maximal VMBus protocol version guests can negotiate.  Useful to cap t=
he
>   * VMBus version for testing and debugging purpose.
>   */
> -static uint max_version =3D VERSION_WIN10_V5_3;
> +static uint max_version =3D VERSION_WIN10_V6_0;
>=20
>  module_param(max_version, uint, S_IRUGO);
>  MODULE_PARM_DESC(max_version,
> --
> 2.43.0

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


