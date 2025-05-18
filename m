Return-Path: <linux-arch+bounces-11987-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7006EABB1AD
	for <lists+linux-arch@lfdr.de>; Sun, 18 May 2025 23:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 003A97A9EDD
	for <lists+linux-arch@lfdr.de>; Sun, 18 May 2025 21:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793BF1AAA1E;
	Sun, 18 May 2025 21:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jUvZXlNm"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02olkn2078.outbound.protection.outlook.com [40.92.44.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D23682866;
	Sun, 18 May 2025 21:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.44.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747602964; cv=fail; b=VVbKfAee6PUzuY+Bok29TaSHCHNJShwVb0fnG32N2mex0Nfob9Tr92p416P1jYIwuC7OVEvwQU+CYsibwa6RQ+Fdb4rRruaC/sH1jqRMzXJkvMwE4TBKO+/XTwg1sH/F0MAxwqbthzeA/4mLXJjS+ZfDaLmmOmC+G8S6PUT1JT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747602964; c=relaxed/simple;
	bh=m5aHdJnKxAdD8ibcTuXxmGboC+dE4/f3XIeTJNoFS50=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=obuO+9NoyoCMOjwDjdcjaduuB7pR0RvmGY9q/g8Fgqop1P5l0m4at35Av4ZavX1L/p6/NiVxeWv6GyKeIw/UUst3VOXx+gqhJyEI/PoqUhLun+Ut8VpvGvXY8rxy0Qp5YxX1ziNbbAHbS9Sv1kBj/FPcmxYI+YBSOs+7DuLdvNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jUvZXlNm; arc=fail smtp.client-ip=40.92.44.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tOzxQLXzq+FrcBafQboAvsdivBR0rWTTjPlgfquIvoUGMFBlRmGIWMuH7GwJA/yCkTvt0xqRZ+t4R8EujJT/RcLLvDfLVswWTLNCw2MNx9Dji+lYNddmgmqzIPdeDNhsx1fTmy+zQ7acBm8BIOm1qK4e3fIxcNkrETnEPyPWw/hjIpGnuQ4Y6g5AvCs9L1s6CHO4YyRNphb8s2wTyXkEo1wqZmQzFXo1EnLPTIsy5IOJT3DxyA98UCtEgs1IVpwto08hNY4wyh3BTUW24MEaIvQVdQrN+63fYPl9tIe0WTreQUpPUJ0EBTkF0Zn2FNa0juc4jl4l1pvTEQIJGZuMPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1ZbovlpBkTnfYaA21FZnWFRuZoPIe0PLea+FzTcapQ=;
 b=nv7671W2tcxWQ6Y6afqzfoUb60F0gVBGYP+s3SpTjAfEr2qTgOnzFYM8tOl/p5tdYCZPYj60XN8eUNifTfS9Ti6DRLj4RkCL48SZp+Lkm52z06DXZxB4Y62J23ghAAjV73p2mM3JDo7J0bNM6qn4fj8tuofo4a4ShpyHfzzX6O785v0DLfBF9pMMQsURLQ3Xm3O9GlqUjdc7L9qkPDjZqj8Mcbq8sy6ypyCNpMnaxbTToevcNFbGL7wo9U41xS8zLV9HhimGOGjDXR+41IgPxaR396vngJnkSRJDFqajf7jBw4mIJyLTMk1xQ3oIlQ/+eMLsKHnCzfaNr1mlVdVHtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1ZbovlpBkTnfYaA21FZnWFRuZoPIe0PLea+FzTcapQ=;
 b=jUvZXlNmprKChuvA7faQ33VWTHljcU/AqPs8vcYy61aFTEKVjQVB5PElQSaHke+wsnGoaxleY/1jiS93/hic/JPi8ujaMJ2qx9fBZNhwaQAzoVNOphZOtIo9P5fBko3ovRH4fDJ8rZ5Ys5BOHqqAR586fr4Q9Hhkxr+E0EMfgMrC7qZ3zYCVFoFDCEUXWQbl/aw3pI3CgotTw2lUefVkuzVHR3NjG9HOzlawsKp7nmTlCfjN++AMS8uupGr2onJNE03HyJifoMiOVr5+ELb7S8SlUL3CWbr8sySgnJNJWuOqPxl0uqNBfMNmCMKDbBlGQDh5hPVeLSgjeOAaANm5Zg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM4PR02MB9189.namprd02.prod.outlook.com (2603:10b6:8:10b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.16; Sun, 18 May
 2025 21:16:00 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8722.027; Sun, 18 May 2025
 21:16:00 +0000
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
Subject: RE: [PATCH hyperv-next v2 3/4] arch: hyperv: Get/set SynIC
 synth.registers via paravisor
Thread-Topic: [PATCH hyperv-next v2 3/4] arch: hyperv: Get/set SynIC
 synth.registers via paravisor
Thread-Index: AQHbwsmqHR23X+o+HkG18qmMm49NW7PTymLg
Date: Sun, 18 May 2025 21:15:59 +0000
Message-ID:
 <SN6PR02MB4157093D1661A64B9677AB6FD49DA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250511230758.160674-1-romank@linux.microsoft.com>
 <20250511230758.160674-4-romank@linux.microsoft.com>
In-Reply-To: <20250511230758.160674-4-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM4PR02MB9189:EE_
x-ms-office365-filtering-correlation-id: 91cc22cf-3ab8-45b6-b7c2-08dd9651300b
x-ms-exchange-slblob-mailprops:
 AZnQBsB9XmoaApi1aWVt9ILKZbGoHsd6Hxl+ERr0zIPTE+6ihabWxfrZeKS0wQhO3+NYi1ktj5U2/a8tmTqMTQ5KpIecump43gG8MO9+b0veet3KzwAPf9GGgmEbfY3Wa5KXtaCX5YgL6yekifs1u5Z7s5NEs0LBQay0nIeZKym2M4SP0V3GbxYWam9+ydcCJxMaQP5LfIqZ4FGghK9QyHOF6mWGQTBiN6dNRkarikI2h6KmfkdBQ3LI/BLtSDRf9HMxe9WnEFviKajQXXFDp10cuU4U4fbbv/y3YeU1ljVeKeYs91qREZz6Rk9tBGGlLddnIIzif5oLOz7266Cm1iHV11r3W3h8rnLk9ZxJfQMeYI7dxKlxIJJQjrp2VT158vuiYHMTUXjSitXOkj/1kM79PcCzyYZ0695EAP8ZxaSboYGaN3zyAwy9kjYJqgSZg/a655YxBsf2xmj/sZOuTpd3GYQksrLdHu6srXv+IQ7LCkvpxMk4N7WQufdwhfpnPkbw8yNM/OFmwYtqK2yPDhXDIiIQ6b7ZwOZkZ2ibws7b5G1Nr6RZZEgnA8ZDT2AEFWlRMOp1OUlbZ019muMO8AQvCXVzWh+Dd7MGApSssY57xNJgtTTzpi4DqqjvQ4y7+WJSB0ms4yZ1S8R/Aw5FI8Q5H8X4367DxXtlZSLXmhb998OXD9AaNf7rdAS9K2supY+lmPU5ET55+zAaubg+xMW/3dY/UCWVovvNXk27qDisHHy5nkDsPA9OEAEWshKnBkxU29bgwU4=
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|461199028|19110799006|12121999007|8062599006|8060799009|15080799009|3412199025|440099028|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YAPMT6FJChBgHxUHHXkE2MU/sdtEI8fBIM0ku0oEmrrthrUzm2vhRNmyhObc?=
 =?us-ascii?Q?NZ4R3zBIc8dOJUDTrgPdanBCh9key6RuJL41h+UJvzOFf32Z/EtxX0Q/mb8L?=
 =?us-ascii?Q?xB/7QUWhEhOhvnaeDruTFNw2b5xB6S3+CUMyzc8lYpaqABFTP2u3Ef+CocjB?=
 =?us-ascii?Q?fH1k4H/xIzPry7cwbyHxolZpT4Ua+RUar9q3iLMG/Rwid0b2tDN86H6x/X47?=
 =?us-ascii?Q?C8g4hkzzAtbF5af+h5BwwWHtn14/joyIrwTZTchuRsg6GCtuD7g3L73W0BCr?=
 =?us-ascii?Q?Yob8nnsw6YjAZ3LenZUpO0Xelc3Q/4RBVdeoCLRGPKx+xh/f+NMwAtpz4VEC?=
 =?us-ascii?Q?GG76gR4h1ZwHkIGLrA3ImFtbIIZFR89TfU8KHFdr9+DFFpw4RzSHvXM6C7yL?=
 =?us-ascii?Q?J0WvD2WgKxRHKjGLBGD3OP4aKg+j9RsbiGxdPuArRXUjm/Q2TuhKuBhNZJPo?=
 =?us-ascii?Q?miuR5NoKWYK6D3LYdsaCVYErJCnSyixb0luJ2uPVr4uT/oKZfQtMwjKwct9i?=
 =?us-ascii?Q?Fkzs041yyCTLfVr1gxkxiECzypLlHed4w2p4sVBMTgR5ubZT8oev7hXKCgrI?=
 =?us-ascii?Q?YiqR4CYFfW8zJKEGO5TrqsrbaTdCoRGBG6PId/dHlU9xGib4Wpl2YMxt1/MC?=
 =?us-ascii?Q?6GqLLYDddR5gnGXbToEzhJYRPJqh9O3rSYohST7lfNCYu7dY1GbLZtqr2Ho4?=
 =?us-ascii?Q?HNDpKRY+22utV6PO3qX0EB9kYRk/I6HjtP44vUfLHUErDJUF+2jME3UKZbOk?=
 =?us-ascii?Q?FuHqSk0zxh+fcEfOXnuJrECPTc4eV7fWGDBqJfJ55N0AwdhT6GBrOY+15kuR?=
 =?us-ascii?Q?rrXpKFuOULLdUaYCTPoxiYkOXC3XkUHAJ10Wtbg4cUkJ+/miwnlaDc4cr6r4?=
 =?us-ascii?Q?pfB+dRwI4LS2k1/XLrO9ZQQHqDMi7Xgzu7/R4f8kFEuR/ED7NhunXzav9avI?=
 =?us-ascii?Q?TQ58QzNG1y4MyuHomFEWTXPl9pPwPXYZXWKUieFI1oMJXxzJUrNkz302Sd4y?=
 =?us-ascii?Q?s/L7qBsUHydtCX7QMqqhuJMX6upqFmGENGDqYeZIvsb3TEa8EHcs4ItyDql2?=
 =?us-ascii?Q?uzVYk1SaoCYgQWtGSomMl7hU4q4P+0+bq/QjAttbajIXPHZjFrNPT0cAq5jt?=
 =?us-ascii?Q?+1TcAygxI6YnZPirnxYuCXPRaCDZSmQgywxJMrEwx2fnM70Av4uewv8=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0IHho5Ng1zzynIgkFCSYBYjibPlEUznruK3fjHRt9XdhFaPXoMyXbHf7Y4yw?=
 =?us-ascii?Q?ZJ10IL7g2chfbz0h1T/wSkIimsMBMBbNyY/s9qKAgT0nUU7zc2LUO+puxyHE?=
 =?us-ascii?Q?JCXHwsOhyixTvLftvxisceBOfh1fpkeR+9NkP/CbCRDKswUGQNPCwqWghXR+?=
 =?us-ascii?Q?RjFHYKTsTbdeAZeCzdWQK6XlFIi7S50mHBGt6yuR7sGt6OPv1w7I2Xg6SPsH?=
 =?us-ascii?Q?HxA7F60WHcJ4G9+9OyNxqyQjwdTXVRtq+yCiYZkv6VoxZqRYgDVvxpyr+1tM?=
 =?us-ascii?Q?Bt8c7+iJVwJJw5mcnf202O99Z2pvCl9Gb3pZNM/gvUlwjfGr5rsOru92RnOC?=
 =?us-ascii?Q?U6bZhbnCQnM8LbQ3esb2bxG3AMCtiNmXFayfmfdDFi1wq+JOlMNRGTpm8udY?=
 =?us-ascii?Q?16D5KerzQJIYibdkFn6H0nc520ptIr1BHGrZHmAQRxqNE9dcqpR7WyOk42qF?=
 =?us-ascii?Q?8s7P9P8la3zUOqXaATnS9SJaDWjXqTlFiVQYUC/vXLysRV1xGXzttltN9Srw?=
 =?us-ascii?Q?vAFRXD9G+wL9lX7J9Ju01Nym7AU6FNjQbvhgo0JUa8UjT1HNKTzrFtEvoWjP?=
 =?us-ascii?Q?8DjaVQCOLGOGs4LhClPN8AvT09IUElhpIqy65y8uzEhhHITDPIggOhN09nn3?=
 =?us-ascii?Q?n7I0ARGH78Y/rp556y2J7BoYJb+aEQ1GSs9w9Fncst3jhqkyZVK9IKJpeVJZ?=
 =?us-ascii?Q?xTAsyd4t83fLiXrX0DhyVM389NvrM+C8FT1IjWzCoKs18Mm3zEgScdsPOabk?=
 =?us-ascii?Q?1cmuNQs68xyLcYRtZs3/jPrsvVOArfF01Wr1N6xzYeqCMozuudvWIzf7biD/?=
 =?us-ascii?Q?qWCWQZgxxSlRXmnvUIQ+yNioWKQGbrWhtUsCCEoECP1C3HVBcQBMuoVNk3ab?=
 =?us-ascii?Q?bzBwcGsUrmD5heR+rBx9FSRCcfYhQymV7rwu5UbGqxVdXzA6KdAF2Udz/JzL?=
 =?us-ascii?Q?xGujz7uMymtFT1oYVUWicojqVFJXTxwf2emNMwA73Fzga7GrVvkvh8qc9zjr?=
 =?us-ascii?Q?zNF1xQLSIrSoU2z6k/R7bB+7wrbO3cRfPQKpaKfdcX1rifehsCndCL+lWvYt?=
 =?us-ascii?Q?UyQio6GPnyLf0wobbvw0nS3ssfy4K24dv9o+eF+8Fl4sMS6TtuPk2wieP6Yd?=
 =?us-ascii?Q?2lwWsrVc73EAz98eqPEb/vtAkCYwrD4jo510mXmSwql+RuuagJR2Jmyx1PEQ?=
 =?us-ascii?Q?91PzQiDdyD3TGP+UNOkjJNi2AvhJ0BIqSy+PLNqKBZTE2Hr/GVuoIl/Z2E8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 91cc22cf-3ab8-45b6-b7c2-08dd9651300b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2025 21:15:59.8893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB9189

From: Roman Kisel <romank@linux.microsoft.com> Sent: Sunday, May 11, 2025 4=
:08 PM
>=20
> The confidential VMBus is built on the guest talking to the
> paravisor only.
>=20
> Provide functions that allow manipulating the SynIC registers
> via paravisor.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  arch/arm64/hyperv/mshyperv.c      | 19 +++++++++++++++++++
>  arch/arm64/include/asm/mshyperv.h |  3 +++
>  arch/x86/include/asm/mshyperv.h   |  3 +++
>  arch/x86/kernel/cpu/mshyperv.c    | 28 ++++++++++++++++++++++++++++
>  4 files changed, 53 insertions(+)
>=20
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index 4fdc26ade1d7..8778b6831062 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -134,3 +134,22 @@ bool hv_is_hyperv_initialized(void)
>  	return hyperv_initialized;
>  }
>  EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
> +
> +/*
> + * Not supported yet.
> + */
> +u64 hv_pv_get_synic_register(unsigned int reg, int *err)
> +{
> +	*err =3D -ENODEV;
> +	return !0ULL;
> +}
> +EXPORT_SYMBOL_GPL(hv_pv_get_synic_register);
> +
> +/*
> + * Not supported yet.
> + */
> +int hv_pv_set_synic_register(unsigned int reg, u64 val)
> +{
> +	return -ENODEV;
> +}
> +EXPORT_SYMBOL_GPL(hv_pv_set_synic_register);

Since we introduced support for arm64 a few years back, we've generally
been putting arch-neutral stubs as __weak functions in hv_common.c.
The x86 implementation overrides the weak functions, and for arm64
the __weak functions *are* the stubs. As the comment says in
hv_common.c, this approach avoids cluttering arm64 with a bunch of stub
functions. Of course, when/if the arm64 side is implemented, the __weak
stub may be considered superfluous, depending on what kind of bet
you want to make on a 3rd architecture showing up in the future. :-)
But regardless, keeping the stubs in hv_common.c simplifies the process
by avoiding the need for arm64 maintainer involvement in approving
content-free stubs.

Separately, the use of "pv" in the naming may be problematic.  I
associate "pv" with para-virtualization, and the pv_ops mechanism,
which is decidedly different from the paravisor concept.  What about
using "para" instead of "pv" in these names, and other places in this
patch set? I see that KVM has some use of "para" and I'm not sure
what that is in the KVM context. But it's not nearly as pervasive as
"pv" is. Or maybe "pvr" is a better choice here.

> diff --git a/arch/arm64/include/asm/mshyperv.h
> b/arch/arm64/include/asm/mshyperv.h
> index b721d3134ab6..bce37a58dff0 100644
> --- a/arch/arm64/include/asm/mshyperv.h
> +++ b/arch/arm64/include/asm/mshyperv.h
> @@ -53,6 +53,9 @@ static inline u64 hv_get_non_nested_msr(unsigned int re=
g)
>  	return hv_get_msr(reg);
>  }
>=20
> +u64 hv_pv_get_synic_register(unsigned int reg, int *err);
> +int hv_pv_set_synic_register(unsigned int reg, u64 val);
> +
>  /* SMCCC hypercall parameters */
>  #define HV_SMCCC_FUNC_NUMBER	1
>  #define HV_FUNC_ID	ARM_SMCCC_CALL_VAL(			\
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index bab5ccfc60a7..0a4b01c1f094 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -307,6 +307,9 @@ static __always_inline u64 hv_raw_get_msr(unsigned in=
t reg)
>  	return __rdmsr(reg);
>  }
>=20
> +u64 hv_pv_get_synic_register(unsigned int reg, int *err);
> +int hv_pv_set_synic_register(unsigned int reg, u64 val);
> +
>  #else /* CONFIG_HYPERV */
>  static inline void hyperv_init(void) {}
>  static inline void hyperv_setup_mmu_ops(void) {}
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 3e2533954675..4f6e3d02f730 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -89,6 +89,34 @@ void hv_set_non_nested_msr(unsigned int reg, u64 value=
)
>  }
>  EXPORT_SYMBOL_GPL(hv_set_non_nested_msr);
>=20
> +/*
> + * Not every paravisor supports getting SynIC registers, and
> + * this function may fail. The caller has to make sure that this functio=
n
> + * runs on the CPU of interest.

This last sentence confused me a bit, as I wasn't sure what "CPU of
interest" meant. Alok Tiwari's comments suggest "target CPU",
which to me is still imprecise. The point is that a SynIC is a
per-CPU resource, and it can only be accessed from the CPU to
which it belongs. Maybe restate as, "The register for the SynIC
of the running CPU is accessed."

> + */
> +u64 hv_pv_get_synic_register(unsigned int reg, int *err)

The function signature here seems a bit non-standard. I would
have expected the return value to indicate success or an error
code, with the location of the return register value being an
argument. Then it is more parallel to the corresponding
"set" function below.

> +{
> +	if (!hv_is_synic_msr(reg)) {
> +		*err =3D -ENODEV;
> +		return !0ULL;
> +	}
> +	return native_read_msr_safe(reg, err);
> +}
> +EXPORT_SYMBOL_GPL(hv_pv_get_synic_register);
> +
> +/*
> + * Not every paravisor supports setting SynIC registers, and
> + * this function may fail. The caller has to make sure that this functio=
n
> + * runs on the CPU of interest.

Same confusion here with the last sentence.

> + */
> +int hv_pv_set_synic_register(unsigned int reg, u64 val)
> +{
> +	if (!hv_is_synic_msr(reg))
> +		return -ENODEV;
> +	return wrmsrl_safe(reg, val);
> +}
> +EXPORT_SYMBOL_GPL(hv_pv_set_synic_register);
> +
>  u64 hv_get_msr(unsigned int reg)
>  {
>  	if (hv_nested)
> --
> 2.43.0
>=20


