Return-Path: <linux-arch+bounces-11985-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C28CAABB1A4
	for <lists+linux-arch@lfdr.de>; Sun, 18 May 2025 23:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62A657A81D1
	for <lists+linux-arch@lfdr.de>; Sun, 18 May 2025 21:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2709818DB02;
	Sun, 18 May 2025 21:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZQLhvNX9"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2092.outbound.protection.outlook.com [40.92.15.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD90E2A1D8;
	Sun, 18 May 2025 21:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.15.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747602923; cv=fail; b=sEtMyk35hZaPj9vqS6oSfUrNoE42/jDi+KmO4Fs8/DP6UJbCZ5Po/cP7zoiJqvboS/zTmsiqM7XWLWbQVitd/yDk6yksLWhRg/p1alr+z4CbrYyw+RhFFv7hlc3Ng1U7acXhJRkeRsta6b1XeIqPsTbOvA1Ww1Hw50HMcOFVWc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747602923; c=relaxed/simple;
	bh=VrMAQ1WCDcJPYw7Hv6tSnm80iVxivgMAM4Ts86G+CMw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VvMoyjiJum17w0jNpKTMtEctQJA3Kgr6nvulo+07z+qqjidXKp2xV8ReR9ay/64S9N8R6TyU+S8PVojKkKuuZbNiypQBdO1VBlDWyxb21lp4CzB0Gn0InL1LIQ//gpRC58/TS/Xtc1QD1YGNQAqCf1yBTIKSnYPgOsKbGyInT30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZQLhvNX9; arc=fail smtp.client-ip=40.92.15.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSiNFdp3UGHV/3jifledL7y7i+la0cTxeowminJdYAwM8v5OxzgDiTevT/hPOYq/nWPRPGGanJZQHHpyJiOE1ChstMawwKdiqvzA9jtBP0mlty5wM9zxgCuXoUmv+srgjClZiqSd3Tf/W1UI5cVzR6QuHWbbXho2crsNHxLgOoYuiBk//pJ2XHCV5A7h8hvblzRIVHKSKO2J4ZDq9/VsrcU9GTKJfCwA/aKIBY3bE+SRc4hWkotDEaT6ZGby/X0Qn+OEGhWIl4Q+tAvi2j5vRRdZF4OeYWX+buYca/9RdVl6cPf41c/cqTVp+4UYAaRQ55fPsMEv8RG6z5Nj5cuqiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udgXnSKLywvUmwFbj/J3I6jFxu9FHjzKBpKBhA7l5x0=;
 b=DI0XUwvzlpKV5O6MJW3aHbWNWhE+qRYy8BSnwlMstO1gtXppdtmwlRflhSgvXRdJfyW7YcWYfQI2nBi0TSVTAjDRYE/j511c0mSw7koo0ZrGczJhcuoJYduIi3fmfR1gsn6LM6i2BGUp3TeLt+g2ZbN8wgMs0QUWvfztiZymyB6KCSG77A6HvEJb8y6gloVkRJviKC/QLKUPwTdScGX4KElJNtDLdWewB0Hz4i290BdPp8zwEwx2Gy8v/DmsIZYeyAsGMCWO3QesrqriZ3Mrw7v079fj5BWFK1cl9lL2GbgFMOD9gCys0Zo+LduX7MglA2OsePF/PBUPoQVmo05TeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udgXnSKLywvUmwFbj/J3I6jFxu9FHjzKBpKBhA7l5x0=;
 b=ZQLhvNX91xTanFKEfjxoxZy7737TbsSU91CDghegGCMb6w6BRnqCeJYKBYdoYnl3ETxOjIa+f1ZcR6s0HfeEda05XY7NZGZ5yYu69HdRtRHi2G6lYmlLDQ3RC7Hf4L5h0AdzvUt/B8apU/p3ff9O+uhtvgMpFDO5NyP6kqg+5c4/XOdfEhuefGiTZei8iu+MMr4GfsIRNYpq4kfADgrPPlfrl6+tbhZsnUKRLL9Ez7v4zES74mbL0RT88OvqAtv7DM+A5BfegxjxkvIfAOppDM+YcvIO48RH1Ye7Q2aCTcaHEekmBUcp4wV6F0BXBiXuLkdV8P6egTepI3iyowdV9A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM4PR02MB9189.namprd02.prod.outlook.com (2603:10b6:8:10b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.16; Sun, 18 May
 2025 21:15:17 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8722.027; Sun, 18 May 2025
 21:15:17 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"bp@alien8.de" <bp@alien8.de>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "will@kernel.org"
	<will@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v2 1/4] Documentation: hyperv: Confidential
 VMBus
Thread-Topic: [PATCH hyperv-next v2 1/4] Documentation: hyperv: Confidential
 VMBus
Thread-Index: AQHbwsmqSLUA2AuTG0u4fWBiv1HBa7PTwvJw
Date: Sun, 18 May 2025 21:15:17 +0000
Message-ID:
 <SN6PR02MB4157DC69BA25D889CD838D04D49DA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250511230758.160674-1-romank@linux.microsoft.com>
 <20250511230758.160674-2-romank@linux.microsoft.com>
In-Reply-To: <20250511230758.160674-2-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM4PR02MB9189:EE_
x-ms-office365-filtering-correlation-id: 3c5cbd75-808d-4136-d4a8-08dd965116fb
x-ms-exchange-slblob-mailprops:
 70qbaZjg4mt4rOODFaDgc+BZl13aFtIX+cgmWX797IqczNZt093LAkz2+CN2og4qDFG9lcnBsD9FGB5tBjcqnOCKjZKaIH1JA4qZL34riVuaJjJSeVpCdhowG15z6GZ77HwxdrdY1wxMYauA61v1fuBZZNhUR7ycSaSzAO/ZpJh1G8a71xFw8XzvBSlXi3XKFMANDWDJpo8AhcZvCa0M3i4wSZ8vpjBHmoceA3u6P2V4ll5Skb+3+DCRgy0S++88sLeqqNbTHdPSqAgBGl5xHVq5K3gNNcbcUGTiws0P8vDAkdluiOjmIgadF4hdNwx/Qyc4qRkUAM7rteFbmsETsRv5fP6+X0RJUT4lv1ws11hxThA/L1Y+0BXmJsdSdnPmMAmhzTyrmBvznSf87qSIJhcDii4HKhenyPZ9TRw3vUV6ib4sk7nR4xZsdYfen9CQ6FQGOawBjdAaQDfpcgPu5X90k2y+oXGFT/bREHIUn5VAeaa/5cKqaGcki7Ikl3umgYaYVaAqzWEdciKdRE8cDfnPru83ERNCqIFeu+tdZlLyloBGmsOPQzGkPABIZ0xsvTTIsllrH9rVSLX1bh1uD7+SkGBniKjTbHVR6TioV3EjJRGNQV8Q9AoU1BoV6tnvgiPPqrcOo6UZO/OODA/Ql1OxuG4qaJc1lA0pIRpI0X5z4VJ1f8yIfpnEq9e2zzdoik+AP5gbmSVo0/wDHkgYYIb/rHnMBDbceVTFAEi5sDjhrzHGjcy1qQ==
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799006|8062599006|8060799009|15080799009|3412199025|440099028|12091999003|56899033|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JZA8Gyn731HAbdQng97ZgHAuB5hpNacrsPHKP/mZlTAxgXzzcDcJp59hY5in?=
 =?us-ascii?Q?FRbR5JWEouV2Iqo0oy6tnB9uVthe2NkOFiJ5df707cVkz4XT4gmTMeCkgM0z?=
 =?us-ascii?Q?LTm+iOKL8bYtKelXNfG4kDtf3Olt434jGlW/s5QHduhFn7hCIP+h34/Sb6Vv?=
 =?us-ascii?Q?ygFWPWHQpMQjlN8p7aglJ30c78GXWXJYCt19DIt3cv5YoPR3umSvCXNaPqGZ?=
 =?us-ascii?Q?0SoES6a95M2vYeZnuUTyzw6Fl1Xy76T6t9+URFO/Wmbf0SBQ0sKqbugh9kEU?=
 =?us-ascii?Q?aMkV0tXDmG9GpuieCOqjdDiVDS1W8A5nKqREXOEX7eS58i7IL9BKcb5rE6z6?=
 =?us-ascii?Q?jCPcbfalV25SYX+LeMdbkpdWpME4chZrSqgfyl/kGUA75QnMwRzdv0+eve0l?=
 =?us-ascii?Q?k5AoSLfuH4ZK9aY1F08EYcaa4Kq20/eFaftitcvs34yOhKCyf9FR7x1PkDDz?=
 =?us-ascii?Q?Q8TBiOPLRy3PIXVsp+ftQWewqh2RhlcXRKZsnVnTv3Avs1rfbKzaMFTMk+gB?=
 =?us-ascii?Q?VnYCHSgi9bXMaJ+ub4xzqcOW01SwL8PmZbgEltMCo3CBTb8Eu7corh0gWVij?=
 =?us-ascii?Q?HX0H2zamiu1N14wXw7/BIkzX7H88GgM//JJIA/2fSv5Ta+20RedIPX+I16O0?=
 =?us-ascii?Q?3V08xviTP/vq1Jw9SKSe7NtJONhEIrJbMedT3S3M7o7BIEiJEPiCPOVJckGP?=
 =?us-ascii?Q?lfbRTPHNvtxmo1B1jODy95A+jZ43SIZgjCx96piq0w6DYf087h+3Tdc6WQev?=
 =?us-ascii?Q?RtzuEwLc0nb1nC22R+24KSQSxZGbdbUZ3HhN5REDjjj16hrsY/a6KUwU6M6v?=
 =?us-ascii?Q?TVgnaOzrTZX3sFhIMEQaTk4O1Nu9iLB8Dn4ahXjlrFDUWnd/Pg60xTTyQdio?=
 =?us-ascii?Q?3C5FmBKrFb/DdnWwPTk5j9H40qogLrpkNKHga9mYET1fDR6SPfSptwyhCBsp?=
 =?us-ascii?Q?p30qG6e0STSK0DvNY0KmeSa9fQfnDcl2MvbjY9gUAe+eyxiBNW6WwA2exXKh?=
 =?us-ascii?Q?1HBlEpL6VFcqxeu2AiwAfc6L63QUF4qj+KgxIL7fx8F+4HS2RGkL1GJJ8iiL?=
 =?us-ascii?Q?SPoc6hIuy8QYJJFLdi5aY49iMlaR/M9FXZ7/Wu+e4Xafzy78Izg=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?E8pkLCf432UDGm9Z8CGPgN/Nss+ITS2pnG1sbS7W4rXc4jkVy46Q0MiDoIRv?=
 =?us-ascii?Q?P7tOFMEAVUiKP0INgESU6f5Xltf5rv/X3eK89CIu13QPAHS4cL+IvxcDazAm?=
 =?us-ascii?Q?YRNvGkhGoxnk6+AyxnHm/eVndjpKS8JUx/1+N7DbjPEzZcKidc6ad3tz2yIX?=
 =?us-ascii?Q?lWMEoU3nYvmQWtEn4pyQaGbeLWWER39iYLqpKVLeMXoA7XAsmGk+l2sqdPXG?=
 =?us-ascii?Q?vyWSAVTB+WdRm68aKz9S7Ch0x0+KL2HfpWUk8Pn13OdIdbq8YA1pBi8DAkvt?=
 =?us-ascii?Q?PubgoWNHWAyQx26AvZAR10H2PKVEqP1AjfwLqI0fJZh3T2lYz7NbLsnrAcYo?=
 =?us-ascii?Q?hyiaCsoQ41nyFwgO7e8O1fhcMYjnCOAKv1sAbgYuXc6loMagiMzAqez64k1R?=
 =?us-ascii?Q?Ajzu8kx0w7xkLfKbheYHFkq4GYzVJHRf9emZPBDbsDmwtlhqA3FJZR8Clvjq?=
 =?us-ascii?Q?rLVPHpxZSeGSB8bsWc2ELv9OpQUrWERAmbf01PcmFfkzbOOkGtvBfzagYTuo?=
 =?us-ascii?Q?jXdSmvlMZ/9tnJgMyBy2rBDs6NdVOl9JLJOnhdpn5XT67NXUy2VMJYylH6au?=
 =?us-ascii?Q?KqNFkFafYNVDzqT1NaJkQPOM/8WM3flqovE4cdn5rspLSXiHhnN164eycb9I?=
 =?us-ascii?Q?/cJTqNWATzWYrT9n9gWng3jiXL1sbBtp56hk98Qsr0HM8Du8RjQgtv3jAVxK?=
 =?us-ascii?Q?kNIeeEPYWlg0kjwrtWfspCEUJmXo1GZxSZC9XeiIGDJg1w/Puf3kfV5defcC?=
 =?us-ascii?Q?XC7NJ2/VSW2lr4jIHuqcKv/gAvottj1ujhZ5MnERBWN8zgG3Q8tKjgRSzZlS?=
 =?us-ascii?Q?IZpiXy3roJ8yzzOnJSNtFQk+EDBfjJ87h21FbHfXYZ8lzzAR4jy4DQ9IKjlE?=
 =?us-ascii?Q?w2lShiGDolUkCHSSA873RdftiXEijvbIAjt63p3BBf+Lxwp/KcO3iK8U/j19?=
 =?us-ascii?Q?cEdaj5MH6uZLgufnnuD8fxnDGP99LynYwJTVYNtGMJ0KZv5vUZm6fuC2ioaE?=
 =?us-ascii?Q?OySPaccXAECPDuyvtCq+bn6Sg/go0pFlSoTlKAvknfHUrSgdN3kOiWWwdx1h?=
 =?us-ascii?Q?KKnJW+Nn6+MBFYzddkxlyCYtn/ugjF7ISzTGnSuMAgwPORZEG5uTsLqizSZo?=
 =?us-ascii?Q?5RzwEEiE3BZfEkw6g3aU6q73KRUzk39XByBpnrx/aQFpNLOBIxb+wgB9AuTZ?=
 =?us-ascii?Q?IaDUj2Yz2wXvCJJZPkDB4NOwTqI7ZhjuoN+4juerNkU0SONXkUzTXz3XU5s?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5cbd75-808d-4136-d4a8-08dd965116fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2025 21:15:17.8098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB9189

From: Roman Kisel <romank@linux.microsoft.com> Sent: Sunday, May 11, 2025 4=
:08 PM
>=20
> Define what the confidential VMBus is and describe what advantages
> it offers on the capable hardware.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  Documentation/virt/hyperv/vmbus.rst | 41 +++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>=20
> diff --git a/Documentation/virt/hyperv/vmbus.rst
> b/Documentation/virt/hyperv/vmbus.rst
> index 1dcef6a7fda3..ca2b948e5070 100644
> --- a/Documentation/virt/hyperv/vmbus.rst
> +++ b/Documentation/virt/hyperv/vmbus.rst
> @@ -324,3 +324,44 @@ rescinded, neither Hyper-V nor Linux retains any sta=
te about
>  its previous existence. Such a device might be re-added later,
>  in which case it is treated as an entirely new device. See
>  vmbus_onoffer_rescind().
> +
> +Confidential VMBus
> +------------------
> +
> +The confidential VMBus provides the control and data planes where
> +the guest doesn't talk to either the hypervisor or the host. Instead,
> +it relies on the trusted paravisor. The hardware (SNP or TDX) encrypts
> +the guest memory and the register state also measuring the paravisor
> +image via using the platform security processor to ensure trusted and
> +confidential computing.
> +
> +To support confidential communication with the paravisor, a VMBus client
> +will first attempt to use regular, non-isolated mechanisms for communica=
tion.
> +To do this, it must:
> +
> +* Configure the paravisor SIMP with an encrypted page. The paravisor SIM=
P is
> +  configured by setting the relevant MSR directly, without using GHCB or=
 tdcall.
> +
> +* Enable SINT 2 on both the paravisor and hypervisor, without setting th=
e proxy
> +  flag on the paravisor SINT. Enable interrupts on the paravisor SynIC.
> +
> +* Configure both the paravisor and hypervisor event flags page.
> +  Both pages will need to be scanned when VMBus receives a channel inter=
rupt.
> +
> +* Send messages to the paravisor by calling HvPostMessage directly, with=
out using
> +  GHCB or tdcall.
> +
> +* Set the EOM MSR directly in the paravisor, without using GHCB or tdcal=
l.
> +
> +If sending the InitiateContact message using non-isolated HvPostMessage =
fails,
> +the client must fall back to using the hypervisor synic, by using the GH=
CB/tdcall
> +as appropriate.
> +
> +To fall back, the client will have to reconfigure the following:
> +
> +* Configure the hypervisor SIMP with a host-visible page.
> +  Since the hypervisor SIMP is not used when in confidential mode,
> +  this can be done up front, or only when needed, whichever makes sense =
for
> +  the particular implementation.
> +
> +* Set the proxy flag on SINT 2 for the paravisor.

I'm assuming there's no public documentation available for how Confidential
VMBus works. If so, then this documentation needs to take a higher-level
approach and explain the basic concepts. You've provided some nitty-gritty
details about how to detect and enable Confidential VMBus, but I think that
level of detail would be better as comments in the code.

Here's an example of what I envision, with several embedded questions that
need further explanation. Confidential VMBus is completely new to me, so
I don't know the answers to the questions. I also think this documentation
would be better added to the CoCo VM topic instead of the VMBus topic, as
Confidential VMBus is an extension/enhancement to CoCo VMs that doesn't
apply to normal VMs.

------------------------------------------

Confidential VMBus is an extension of Confidential Computing (CoCo) VMs
(a.k.a. "Isolated" VMs in Hyper-V terminology). Without Confidential VMBus,
guest VMBus device drivers (the "VSC"s in VMBus terminology) communicate
with VMBus servers (the VSPs) running on the Hyper-V host. The
communication must be through memory that has been decrypted so the
host can access it. With Confidential VMBus, one or more of the VSPs reside
in the trusted paravisor layer in the guest VM. Since the paravisor layer a=
lso
operates in encrypted memory, the memory used for communication with
such VSPs does not need to be decrypted and thereby exposed to the
Hyper-V host. The paravisor is responsible for communicating securely
with the Hyper-V host as necessary.  [Does the paravisor do this in a way
that is better than what the guest can do? This question seems to be core t=
o
the value prop for Confidential VMBus. I'm not really clear on the value
prop.]

A guest that is running with a paravisor must determine at runtime if
Confidential VMBus is supported by the current paravisor. It does so by fir=
st
trying to establish a Confidential VMBus connection with the paravisor usin=
g
standard mechanisms where the memory remains encrypted. If this succeeds,
then the guest can proceed to use Confidential VMBus. If it fails, then the
guest must fallback to establishing a non-Confidential VMBus connection wit=
h
the Hyper-V host.

Confidential VMBus is a characteristic of the VMBus connection as a whole,
and of each VMBus channel that is created. When a Confidential VMBus
connection is established, the paravisor provides the guest the message-pas=
sing
path that is used for VMBus device creation and deletion, and it provides a
per-CPU synthetic interrupt controller (SynIC) just like the SyncIC that is
offered by the Hyper-V host. Each VMBus device that is offered to the guest
indicates the degree to which it participates in Confidential VMBus. The of=
fer
indicates if the device uses encrypted ring buffers, and if the device uses
encrypted memory for DMA that is done outside the ring buffer. [Are these
two settings independent? Could there be a device that has one set, and the
other cleared? I'm having trouble understanding what such a mixed state
would mean.] These settings may be different for different devices using
the same Confidential VMBus connection.

Because some devices on a Confidential VMBus may require decrypted ring
buffers and DMA transfers, the guest must interact with two SynICs -- the
one provided by the paravisor and the one provided by the Hyper-V host
when Confidential VMBus is not offered. Interrupts are always signaled by
the paravisor SynIC, but the guest must check for messages and for channel
interrupts on both SynICs.  [This requires some further explanation that I
don't understand. What governs when a message arrives via the paravisor
SynIC vs. the hypervisor SynIC, and when a VMBus channel indicates an
interrupt in the paravisor SynIC event page vs. the hypervisor SynIC event
page? And from looking at the code, it appears that the RelIDs assigned
to channels are guaranteed to be unique within the guest VM, and not
per-SynIC, but it would be good to confirm that.]

[There are probably a few other topics to add a well.]

