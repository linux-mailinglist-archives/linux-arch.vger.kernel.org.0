Return-Path: <linux-arch+bounces-10232-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03316A3CD28
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 00:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644D218844AB
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 23:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45F325E476;
	Wed, 19 Feb 2025 23:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bEj06RRH"
X-Original-To: linux-arch@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010007.outbound.protection.outlook.com [52.103.7.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E6125D52A;
	Wed, 19 Feb 2025 23:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740006812; cv=fail; b=GlUibMAZwYQLbpV7eD6er8kFn/AqarqInzXbX+o1F7IVHUHNP4W1ztpGk/AMmLF9xcXVZKJbQe4sKaexQ5Uj4ECjNj1F85nlR6ErVZVr32+8cVzlkW6u18nJ3DiRk22/Yv7Sc6gof0alvNITNdCiJ9ypb+c/+6f765GUzv33uMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740006812; c=relaxed/simple;
	bh=HUFyyxD1IWd+B7BSeW4TrbdoaJn6iKiV5NIz0qNXRc4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NzX5TwaTr5TVK4xySaAEyc6QT3C/xsWijIglAqFvJ7kAgKVK2f4ThGOAAeLEWj47ur/sK0RHPB+Swv9+3eJyS/nDqnK5VTemVtybIre+M8TamTZzKMyH4bC7WsySsfScQl+Np/KDibMgXwM+//DMA9LdMLPRGx4O6uOe0VAkTxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=bEj06RRH; arc=fail smtp.client-ip=52.103.7.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMMfPEauNtIOvT11QP0FfJLq44dOv2m7b0uznSbcSovBH9IccuqzWaLpWsIxG28UvDHmFV+J1jxHh8l6Lu6YcrsTiMQ0qMEu9gjSSefFyop1TOezZCg0+Iz+XfF/4aTBmWnqAU4a0DyYs5MuPOfDfqri8RgQN2KDKNLMkUhXXM94XzhNhgrymxrA/N+zADDz4vtn+YaUJBtyYDT5QvOS3rTn7Xkl5Q9AIh1ykpc0KaI/bQvBJVZm7HKTqgKOQpue+kwNVtM9FwIsMsUxPtz+bnCdCFElnBbd04SNjmL6lQfviNArgHFNTnfcXhuGnojTJCBso+PnnbUkxPwp483/jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwctZs3DT27tQZmgHdO5PT0gQumApz19iC+i5uhmAO8=;
 b=Qs/e8YBhP5DR9tw+YIB9smJSnEbNYfHDc6k8W4HjH3565Cxb/HDy/MM+suMzKO+qCHsEgp+/Fa/RXrhD1aAl4fd+Yb4TPeQWEtFEjMc2MtCbFl43H5WZoLPB6Yk7gecHYcGv8TS8PqzdsY5BMxlAaRpz1PnMaTwNlnJwxOgstX1UEFvxkHxCE8YncgX0OO2RloYrZb5iTulTM5K55ybOpsqSf8KE3LrdOSBLdLjZYC3p6hoEZOmlTnRatg+X9MOApEwz/ykYSneYJtv2uXpAo6vIy78vlnObC49LoG7vnUcyJdKo/26OViF9KpM9bWBfjYFWTUxtQSm3nCZHRNn2IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwctZs3DT27tQZmgHdO5PT0gQumApz19iC+i5uhmAO8=;
 b=bEj06RRHU2TKsORMgl7exL4+RdZPgh5nb19xOWPDqrj92Su2fPkstFG3SmE/XtQwKTxpkwQJyN8iVUGbLI9a5MVXQlBgiG4lR/YDCR/T+ysX8ksKT+vLQIekiKwNwRtNIVc0+dqaMdnO0pYpQq7LPA1w6lMTHWPJn2PqCjbY7DCAiXtykQ3+b2FddZdRDLCWX81Tvsd9nCwy2ni18+oGfybqKw622whjsY4vtcHYfwpIjT9uyHcnmnEfXr98Iw1ei/V6JeXI3fNbg2cx2bE9Koh3LDCvQD2iBMqBNKvgM/iYPvFK5OXlipVWdSsVyXn1nhxYJ1rUqwHNYFH+dwiksA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM4PR02MB9192.namprd02.prod.outlook.com (2603:10b6:8:108::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Wed, 19 Feb
 2025 23:13:28 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 23:13:28 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "will@kernel.org" <will@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "benhill@microsoft.com" <benhill@microsoft.com>, "bperkins@microsoft.com"
	<bperkins@microsoft.com>, "sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v4 1/6] arm64: hyperv: Use SMCCC to detect
 hypervisor presence
Thread-Topic: [PATCH hyperv-next v4 1/6] arm64: hyperv: Use SMCCC to detect
 hypervisor presence
Thread-Index: AQHbfO+k/PLWqmtG+UieQZ3kZhsVyrNPIuQA
Date: Wed, 19 Feb 2025 23:13:28 +0000
Message-ID:
 <SN6PR02MB4157DB2F52501309D52D0870D4C52@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250212014321.1108840-1-romank@linux.microsoft.com>
 <20250212014321.1108840-2-romank@linux.microsoft.com>
In-Reply-To: <20250212014321.1108840-2-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM4PR02MB9192:EE_
x-ms-office365-filtering-correlation-id: 5b2c91f0-686f-4b99-02bb-08dd513b04ee
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|19110799003|461199028|8060799006|12121999004|15080799006|3412199025|440099028|41001999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?X111zJCaJB8EktlEfT7lHiYPjoC/G4hAvx49DqZbi5Srlq/XmtPe+M69C2k+?=
 =?us-ascii?Q?3NliNcY8Bfj5ayBix7hOVQGzRy8Be7qKXNETAo1YPa9MEEKB5SyQJ7+QJkEs?=
 =?us-ascii?Q?813lCh8eMjuPGr8fQtUdku3+bzYRKDPeEX79XZGA3PCEpS5LFlYBdPXYfX7e?=
 =?us-ascii?Q?qKpJKM05XUsycGvMBQYolPeOsNt70/DSW4nKIBB8Exm0/vJ/lXKsRAT+QfwG?=
 =?us-ascii?Q?xeRArcr3xT8BCFxeD3AE+dMDM6gq6ZUkRtOOo7l5ViSi1RPqAu5h+MBtleu9?=
 =?us-ascii?Q?UISnZvWJdNtmZTf2aWH1N3yYLXtMXijJo3rr55vtT7vY+rz/OIIejQBhWdms?=
 =?us-ascii?Q?YKtHovgSXzQLq/ycp891S70sajvM5s1/QYxbvJ7KTINZmLFwh/PDhukYlzxw?=
 =?us-ascii?Q?MJzjydgEl7Ke5rLOxjoRuWNSekSjf7aUSR7nO/fp2AvfIq+jixkbIAJ2OThI?=
 =?us-ascii?Q?a4UQTdwoLSqLb7/BkarsQj1/w44GrzeR6NUrDU8zPzy6z6mGQU9K2g175LTA?=
 =?us-ascii?Q?I+482j43rWO4/V2QXdj9sxCTwsj66LfWIcbIZVswnVSc4F2pz/4CZ99Z+bbp?=
 =?us-ascii?Q?3Vu+WgysLNUg8BqilmcMO9gU+0OwZgPzn8NxvKB/w/xA1lXPBCip7YXzrLWs?=
 =?us-ascii?Q?nR61A2vgKl8cDvzdXxR8mXuN5lj1Z1FmTl3QzBS7nAQCov3tFLjcTfNUH3q+?=
 =?us-ascii?Q?rNTRy2Hw2o0sDApXt8z59m2ShiIW9mPxFFbbLBzVsIphejUQQfp0d/x4tq2z?=
 =?us-ascii?Q?UFmYQE/0BqoETQI55dTLswopvXi1DQoOs6dPgZPnS382y9cvqdMlPVdgtBJ4?=
 =?us-ascii?Q?svkMDnHYIP1byMzQb2XT52b7smCwRKqh5n9ZxJpvkH/CoxbgTDh/g5yjUwfI?=
 =?us-ascii?Q?IOJi3YX5TDbCwLiaFwn0s4cj2b1qj4b9qqRdnvjLKNF34iaO18wG6gth+DEI?=
 =?us-ascii?Q?fNOfElQ8itDmrXxjrUFqN368SClsSnpsGTFjxfAXMrWcnexl7xsmMZb8vvka?=
 =?us-ascii?Q?Sj3yoVwu8hUGt22O1cTMEqiqqYoIuwhIRrmeuw6v7MIOYJr4NMFMbZO5Gc0Z?=
 =?us-ascii?Q?ze/KboIQL/G10qH+Sekpa5U9N2cKExN06mRVMCSS49qufXFIsfU=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4pT30ozoDsjhb+NZvEztcEZKb/HxYMoCNzmW6c/HnXHh7OTpL6NacRcIA71e?=
 =?us-ascii?Q?x0dm8NWZ2auNrt77J+rYP7MpGGtE3YubcfimcWCyfdeNVL7neu72R9ypUuCj?=
 =?us-ascii?Q?aaDgEZ6P3Z3UsGcNg25CLmChdtRqCzVwRtLs5aUyEJQiDut1K9W4NQNJCeso?=
 =?us-ascii?Q?/OL0S0oAGy0O+MWm6CMzrGd5Yd1eAPliSG1pkie8Mux9X6YM6Ie1U0bXglB5?=
 =?us-ascii?Q?mI28NgThoaCzQtTJuiHSG4Cacl3cAntI6Lil6tzUavHg8etZw1FtvNnOpPNp?=
 =?us-ascii?Q?16/fTR0r/mXKhU8p8tp8b5v5adMzhIGXQ64KCiRMz4G3dzMCDHbvCGoTCDdY?=
 =?us-ascii?Q?ny+27vP3wBwra/gCn5b50R+heMTm4mRfo8oJFJBfvpbMSH0twiyW6EZuYfxm?=
 =?us-ascii?Q?sX8wLEZG2cvvb3lQvl791WqD5mnDa416She8nRuUnxCMejfWsaTRql/P13/p?=
 =?us-ascii?Q?m62Ov2ReIiHFLcoHSpoX57SwEbzNHVdp3p0D9O32LXG7URH4BVCCZ8s8Khzj?=
 =?us-ascii?Q?c2Sjpi+XAzTUOvMA9Pokro4Ttl8hE3pENGOiST1MLqKxOZeYNLaC9ii/Jygs?=
 =?us-ascii?Q?v/FT8envmP2A0lWGkKz1cvZCZvwd6s9GnB64ZC8mqtu8iEhLx2sIhmDkjKYn?=
 =?us-ascii?Q?bwvbrvPG+I30kbOLG95fFug8A6ocuNDYDRJmh9z1or2LPYICDeysCfrH24vu?=
 =?us-ascii?Q?VG3W3Q4zx8DoMQGjyyo3NcXC29kASWmreh2xdxH9HisG+LrCiQvv6xWD9sAK?=
 =?us-ascii?Q?Crd8cHKM8HcbVY41Yq4EugwUNejMN3yp1QTo7t0dP5SKOLJTxOdHfIWOaTns?=
 =?us-ascii?Q?CwMleZlYsE/wEyy8DmRXIoYLdejUZByTUyceOp4Y6IdHugB3ZJ0vn7lmdMLB?=
 =?us-ascii?Q?fdRFwSj4rg+XZwfmOA5vZ8MheNy7gtvk2djS3z9Z7yTZ1mKWPExyPAXS06cV?=
 =?us-ascii?Q?AmWM+FGHz/DBLhJ3TlfT7WwCbpqqmBl4YzruXpmo2P7fhi7bQ0TthDpaKtqp?=
 =?us-ascii?Q?VePgBfo/5uaIizBCgC1Y7TsURM458/+Cs9B5MYUBfaNxXC7YoRoePrCCVQ3c?=
 =?us-ascii?Q?p4/aMe48yAV66rNcsLnByrO7UnzucaRa8sInMe1OlNOgPX1920z1Wc98VRIs?=
 =?us-ascii?Q?vDJoYphAQX88wGYeyqYtWn6pPQ01FvHkUZgNToZc9LNTxj8b4c0HZ61TdU/Y?=
 =?us-ascii?Q?/RUlEIWl7S2dLIyV4d6jqiilVZA+NxuAhdSEUv4rP+eJ4WAc2iTyR9b5cno?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b2c91f0-686f-4b99-02bb-08dd513b04ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 23:13:28.3839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB9192

From: Roman Kisel <romank@linux.microsoft.com> Sent: Tuesday, February 11, =
2025 5:43 PM
>=20
> The arm64 Hyper-V startup path relies on ACPI to detect
> running under a Hyper-V compatible hypervisor. That
> doesn't work on non-ACPI systems.
>=20
> Hoist the ACPI detection logic into a separate function. Then
> use the vendor-specific hypervisor service call (implemented
> recently in Hyper-V) via SMCCC in the non-ACPI case.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  arch/arm64/hyperv/mshyperv.c      | 43 +++++++++++++++++++++++++++----
>  arch/arm64/include/asm/mshyperv.h |  5 ++++
>  2 files changed, 43 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index fc49949b7df6..fe6185bf3bf2 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -27,6 +27,36 @@ int hv_get_hypervisor_version(union
> hv_hypervisor_version_info *info)
>  	return 0;
>  }
>=20
> +static bool hyperv_detect_via_acpi(void)
> +{
> +	if (acpi_disabled)
> +		return false;
> +#if IS_ENABLED(CONFIG_ACPI)
> +	/* Hypervisor ID is only available in ACPI v6+. */

The comment is correct, but to me doesn't tell the full story.
I initially wondered why the revision test < 6 was being done,
since Hyper-V for ARM64 always provides ACPI 6.x or greater.
But the test is needed to catch running in some unknown
non-Hyper-V environment that has ACPI 5.x or less. In such a
case, it can't be Hyper-V, so just return false instead of testing
a bogus hypervisor_id field. Maybe a comment would help
explain it to someone like me who was confused. :-)

> +	if (acpi_gbl_FADT.header.revision < 6)
> +		return false;
> +	return strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8) =3D=
=3D 0;
> +#else
> +	return false;
> +#endif
> +}
> +
> +static bool hyperv_detect_via_smccc(void)
> +{
> +	struct arm_smccc_res res =3D {};
> +
> +	if (arm_smccc_1_1_get_conduit() !=3D SMCCC_CONDUIT_HVC)
> +		return false;
> +	arm_smccc_1_1_hvc(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID, &res);
> +	if (res.a0 =3D=3D SMCCC_RET_NOT_SUPPORTED)
> +		return false;
> +
> +	return res.a0 =3D=3D ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_0 &&
> +		res.a1 =3D=3D ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_1 &&
> +		res.a2 =3D=3D ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_2 &&
> +		res.a3 =3D=3D ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_3;
> +}
> +
>  static int __init hyperv_init(void)
>  {
>  	struct hv_get_vp_registers_output	result;
> @@ -35,13 +65,11 @@ static int __init hyperv_init(void)
>=20
>  	/*
>  	 * Allow for a kernel built with CONFIG_HYPERV to be running in
> -	 * a non-Hyper-V environment, including on DT instead of ACPI.
> +	 * a non-Hyper-V environment.
> +	 *
>  	 * In such cases, do nothing and return success.
>  	 */
> -	if (acpi_disabled)
> -		return 0;
> -
> -	if (strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8))
> +	if (!hyperv_detect_via_acpi() && !hyperv_detect_via_smccc())
>  		return 0;
>=20
>  	/* Setup the guest ID */
> @@ -72,6 +100,11 @@ static int __init hyperv_init(void)
>  		return ret;
>  	}
>=20
> +	ms_hyperv.vtl =3D get_vtl();

The above statement looks like it will fail to compile on
arm64 since the get_vtl() function is entirely on the x86
side until Patch 3 of this series. As of this Patch 1, there's
no declaration of get_vtl() available to arm64.

> +	/* Report if non-default VTL */
> +	if (ms_hyperv.vtl > 0)
> +		pr_info("Linux runs in Hyper-V Virtual Trust Level\n");

Could this message include the VTL number as well? In the long
run, I think there will be code at non-zero VTLs other than VTL 2.

> +
>  	ms_hyperv_late_init();
>=20
>  	hyperv_initialized =3D true;
> diff --git a/arch/arm64/include/asm/mshyperv.h
> b/arch/arm64/include/asm/mshyperv.h
> index 2e2f83bafcfb..a6d7eb9e167b 100644
> --- a/arch/arm64/include/asm/mshyperv.h
> +++ b/arch/arm64/include/asm/mshyperv.h
> @@ -50,4 +50,9 @@ static inline u64 hv_get_msr(unsigned int reg)
>=20
>  #include <asm-generic/mshyperv.h>
>=20
> +#define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_0	0x4d32ba58U
> +#define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_1	0xcd244764U
> +#define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_2	0x8eef6c75U
> +#define ARM_SMCCC_VENDOR_HYP_UID_HYPERV_REG_3	0x16597024U
> +
>  #endif
> --
> 2.43.0
>=20


