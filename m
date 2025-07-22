Return-Path: <linux-arch+bounces-12891-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E46B0E2DB
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jul 2025 19:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2731C8291E
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jul 2025 17:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E3F280325;
	Tue, 22 Jul 2025 17:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ArXYZa37"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2066.outbound.protection.outlook.com [40.92.42.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CFA2836B5;
	Tue, 22 Jul 2025 17:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206270; cv=fail; b=OW8cukwjkwDST9iFmceQJhIeu8leu5N5BePePnd191qRO6u+xoRR52hieg84SV+02HqBoD6Dee6RbdR1N10H7UOKdPkt0rKcRMk8ekBamPsxOk1tzQw1SQD3wXq3lPIF4gJ0hu6cEN1lIsUpz2yGigPyJi5OTSSyScdZSOXxPNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206270; c=relaxed/simple;
	bh=WVoS2setsDXHAZluygdeaCajH2kG6GYKne02wHF4Yss=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LuUr90e7mhHgm6A9+sQO4bMHhkNq6YUgd6vAmvEv9rQa2lltCMBrve+o5VMB5K7VbLEbFOMUk1GKc136b6Kd/awHAnMhvjtIQ5/43NCUOdxMz+pU0xZVn8sz3TM3aLMooxRTcs3hwfedrlUz2ly0Q0GBgmLLxXKKplQroMlNNGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ArXYZa37; arc=fail smtp.client-ip=40.92.42.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7lofKFNQRqkAXv8mgLskooEzPIZRBquhoq6YzyWjGnx4i5E5l6QQW39NcGCA7IVuoKPGi9cRDQAwuECtam9gLfA+zE6zV6h8nWvcZ4NQS2O9SJEFf7MF2mh+PscrfZwyj40j2j6e22RkThzIS5duxMc8/qNXTFaVpRIMweXXrkcZHfbjxBQye/UXSo5iYnGQdyZeSEl0DkFqRTdMv4pAyJrZ6t3e58LOsQHx8tj9VGlyEUlOIK3k0lQ00u8ZyHm+8E4WpXe4aaijJrcOzzP0g+oCAay5au2kYibbzTC8bedcHfINzmMf11LfkP4eTj/5wZTrnrppbwKFduYM0gtgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROEFRzy/ckQ9z11UhOaqbkrhQD4ZQ8m9+JGi23rRSSI=;
 b=tB9Z1aSZ1BRrIaBgn+3hqr5Zx2SD6ray9aaxcp+azVWRbPZQOgJB3w/+nb6Ksi1PQfyOID7Gqr5OEvLChS6LncHXcdctGPc/XZJEVKHLW3+RPpjke3Q5gUqe7O8rv7lh1ulyRwvwKWVN5UiLmQ6Bq48giwfTD0PwyKMfixRDzsJHtciSoDAezacdqCPpLUQSQqf69czXngNQLUzVTwWGtZDKpifEHmnGHaP+/IEpNpuZpXIY6Q0FSgDyikQvoz4259vDTlg4pIf99NZ5P+bGiF/ctBKEdrHYlcRfRcxfWP1KxrIjqDJOzXJL/17QC6w6/nkrzUupP6Zq0EQVzgBoZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROEFRzy/ckQ9z11UhOaqbkrhQD4ZQ8m9+JGi23rRSSI=;
 b=ArXYZa37UF4w6n836eliAA4PVXr7dYSyXtKOiSEirMEwb3NfLwc3pJxfcUTvGM9ySdAvl2ZVSQ3bH0whgLSliMx8/PS51s5S8dEAQdP3BxA+faWbWHrr2Z2g9MYFPBbzyJjHJZWnFwEo6AHI/laF/zVl886WTwB98ZZEiZd21GMjDgLg0T9zCGowyTYcS7pKeWYeJ9RzRejs2nRnrpWuNJHCQilIi/Inh3p2K3OsB3DDA0a2bqlh6awV6XATMMpubep6DwF3EcMPhifKLoW8RpIGSM0bPuJu3WEy5DFpyPL/fl6sEOj7NSA39P4U+alTZS9XpmX1DLyvsx97R+Jjbg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY8PR02MB9201.namprd02.prod.outlook.com (2603:10b6:930:9c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Tue, 22 Jul
 2025 17:44:26 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 17:44:26 +0000
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
Subject: RE: [PATCH hyperv-next v4 08/16] Drivers: hv: remove stale comment
Thread-Topic: [PATCH hyperv-next v4 08/16] Drivers: hv: remove stale comment
Thread-Index: AQHb9QzcMhfeI14T3kOkJTAnAq+iw7Q4mUSw
Date: Tue, 22 Jul 2025 17:44:26 +0000
Message-ID:
 <SN6PR02MB41574D1B88657B4A63F67730D45CA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250714221545.5615-1-romank@linux.microsoft.com>
 <20250714221545.5615-9-romank@linux.microsoft.com>
In-Reply-To: <20250714221545.5615-9-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY8PR02MB9201:EE_
x-ms-office365-filtering-correlation-id: 209a72ea-8170-47c0-dd2e-08ddc947673d
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|461199028|40105399003|3412199025|440099028|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sTq69YHKoq8D8ZtrzbpkqBNqEFwRsosH0Nh1GlbcK6C7IHGqEb4QbzNP6av9?=
 =?us-ascii?Q?qi9xmhRwsL21fJ+l64kPjyXqvvRg0XX0fg6xXdwP9P8e0qVAlzMZ4cfqb6R3?=
 =?us-ascii?Q?POaThwPUy4+245xJy1Hls4llbOsIIohcJPVPXfPJsHXe7TFv9AFQR+khlu6k?=
 =?us-ascii?Q?ytwiPk9C/hgte0TNxlBX62HtLnUUgoRXzlWeV1llqeb8+GH+27veSgKX9T2p?=
 =?us-ascii?Q?Fl/n4WzFcGK4iNB3NdjrJ8O7aDPPJX+DTR7CQp0x98iOZagPaVoGgkVdrjRJ?=
 =?us-ascii?Q?DLHcy6X2gf6Wnm6T4iTxvuqBEX5Fgt6XGutjfVjhzzdS/gSi8C+mikPPPKPR?=
 =?us-ascii?Q?hC48r+Pno4l2AvZcT8jTPdI7MWSrUsSeuzv9/yxok3xRNifIuUSqhJdhhvai?=
 =?us-ascii?Q?CdATm640dvLz1HZbT4PS30oS9Ew0yE1637mqkwSLMc58ZR1EiYOHbmAb9Mwn?=
 =?us-ascii?Q?NlYMIuD5w6V6KyD8u8MlC7sNbKUciPnVvDYj6UxjwLEl5AWu5im7ZNDxHxfh?=
 =?us-ascii?Q?R4lFI3ZWfj2y5GvM4PphKXnxS8QIwPaxrg+JfG1KR72+kje5o/7Dz74YWj5K?=
 =?us-ascii?Q?uFGG2Ds/XHY0k7aZxF88ipTCU4pRumu8Ntu+wfdz6PCtDmOIQzey9jvnkosG?=
 =?us-ascii?Q?O0Az9yVCu+XfAI4392sS1RgXnau1JaSsLdSLA6MyqBcfTDOUYKX/pl+ftNuo?=
 =?us-ascii?Q?Y6/b5PczRJlJZRAIIK8ZT3LZthhC+x3Y2RU3aJb4E1WOwJOmjH2tDZ3EQhZa?=
 =?us-ascii?Q?S+WY2Eip1lfLRJz2Wkn7wyAVE2MccinDFgNjbjlHL31Lj01Jc8WYuN8BpXU3?=
 =?us-ascii?Q?WBhFkqdUx6J9EqskWwLjapczvFoQNcQ5iDMZ54/4Wwuc6GonVO0/uLOvKoYb?=
 =?us-ascii?Q?u2EiH41w+Go+rCfd3ksd9P2A7bU7jHwhVVZooe7vWvEpW9SfFRAoZdPndBJ4?=
 =?us-ascii?Q?CE9Pcw5e2RW5InYEZWGX8jFHwBYvwjlkllhtmeeytvdJEPrOq9E09brM5OK0?=
 =?us-ascii?Q?hzPepTXm6LRRNf5EtpI51SgYf92gdCmKGH6i4uFCCKVgZhA+/YjDAeE4/tHT?=
 =?us-ascii?Q?paEOCHNP?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iduejIl2GtzF9T/6WxLifvwICudcByWM9M3XFAkNwuVIFTfdDyBPnx87JMON?=
 =?us-ascii?Q?UeeNkpZ84+c/Ger3paJTnUcXGNf9ksfKRbaYxRwO5fV8Rufvdd3vz//NgobX?=
 =?us-ascii?Q?nz3xexYApZtSExkH6KBaQwIQ7PguBjPa/s8XaadyiVPY7KYdHBclrjZudlth?=
 =?us-ascii?Q?b4uFd/DtVmBI/PxsrunsSmtT3xcJ+OuIIAHZPRlgcrCFV6IULcwQiRaKxBub?=
 =?us-ascii?Q?2hOXGqzDpedqoSJSmlXTBFra3apW+ZjI91FRCEJEW73ZR6DQq6/S5J4BRklL?=
 =?us-ascii?Q?WYA+tsQZuN7bTEk6RIVimanVHWv53rmscgsiVc7+WvzeE7lAg3BkQP+FBC5b?=
 =?us-ascii?Q?O24DvKon/enRgo2725mHE2vRqjk58WqicWMlk225nnDHCrJ3EZF6IjV3ZP4u?=
 =?us-ascii?Q?LtgF2hy+dtOw6GFWLMWiwfPvvFPnQScGzStitbx4zqkZ3dv31JKQeetee8AL?=
 =?us-ascii?Q?FFrIQBi16yqFLCIpB+Ek87eYV7Eg3ENLwFC5O7HE9UbzDTCIXbAfBVmJoNxr?=
 =?us-ascii?Q?vJCQ7QbPzFM9zbcn+3e67ELrVP7PLMuBvTzw9/eV/ziNT+B815JAw2LsliCL?=
 =?us-ascii?Q?kI6HeORwavtwf/v0XlwKmFlhAloUMTCo/kiu2m5OA9489Fg/172dbhXjGmgT?=
 =?us-ascii?Q?oFUnoBESspe4Kt28HEhAxgmqrtBQnEPpz1/QGMwGhwXgwxvsDg8P6cl+UECE?=
 =?us-ascii?Q?rC0GizRCTpMz8F7e+MkyCGj4e1R/9cwybWfy3X8oKocxpmJm/Cu6rhkYxLpx?=
 =?us-ascii?Q?Zv73xILk8XvTfj/MqoKC9Hvy/nWOjxSvDp8q45Z6PXS++UTv1upPK9R9JJsJ?=
 =?us-ascii?Q?FLmt2Hzad2d9AVVLk0MkLckMix06PVBxG0xU8Ev/fi/hOhuh2tywTq5jF7kJ?=
 =?us-ascii?Q?bUP/t0NLE9M8yFdjgKunq3EQQVjAQzTRnNb3yHZvIRFQnIGsS6c8w6erFTKf?=
 =?us-ascii?Q?onPz6yQM+FlCHC6JRRBRnFazu0zh4dDlmmRxGs9Kf0D9cJUCJEu6FVuLcNzN?=
 =?us-ascii?Q?r+O9xiCZU+ZqjRXqmGTxl4+j+1AjM5pMI2xdYJ50J8xQQxa7FIMIalLGxrvg?=
 =?us-ascii?Q?FaRIBZU1gW/84cSr+ZXpmZ1xmXYJJdKJuLzyAHM+TFJ+wGrA4yS85KR9gzs8?=
 =?us-ascii?Q?Xiv6H+KFMmQDuHied6yuo5SDUKtfqu6dY6yJUZmu54WgZF8sfG+6S69w5i2y?=
 =?us-ascii?Q?oQPRBI7BJIuclGw0kEQdLmHAh9i1v8du5lVB/xpefobB4CLQC8pXJ1WeCRM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 209a72ea-8170-47c0-dd2e-08ddc947673d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 17:44:26.7985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9201

From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, July 14, 2025 =
3:16 PM
>=20
> The comment about the x2v shim is ancient and long since incorrect.
>=20
> Remove the incorrect comment.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/hv/hv.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 816f8a14ff63..820711e954d1 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -266,11 +266,7 @@ void hv_synic_free(void)
>  }
>=20
>  /*
> - * hv_synic_init - Initialize the Synthetic Interrupt Controller.
> - *
> - * If it is already initialized by another entity (ie x2v shim), we need=
 to
> - * retrieve the initialized message and event pages.  Otherwise, we crea=
te and
> - * initialize the message and event pages.
> + * hv_synic_enable_regs - Initialize the Synthetic Interrupt Controller.
>   */
>  void hv_synic_enable_regs(unsigned int cpu)
>  {
> --
> 2.43.0

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

