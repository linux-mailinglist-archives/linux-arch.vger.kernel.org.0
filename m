Return-Path: <linux-arch+bounces-10063-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA65A2D6F4
	for <lists+linux-arch@lfdr.de>; Sat,  8 Feb 2025 16:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5627B16720B
	for <lists+linux-arch@lfdr.de>; Sat,  8 Feb 2025 15:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE7E2500A0;
	Sat,  8 Feb 2025 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="l+GoF4xk"
X-Original-To: linux-arch@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazolkn19013083.outbound.protection.outlook.com [52.103.2.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9242F13EFE3;
	Sat,  8 Feb 2025 15:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739029452; cv=fail; b=h6pHAN4WQo7Lix59vUZg5KqxOF2zzHmc6gS1nh3x1SIJ5g5IHHkAItS4j0noAhhi1G4eg8BSAg8XD9Dl+5IKc7KFmeK60DSMn1b9zuZ+U06nM8OrgATp4gx8aRDT2C05FyFDzY8A+CAP2qQXAUuFhWsspguagRnsXnZF/AIolo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739029452; c=relaxed/simple;
	bh=CI7vBzwPyF4qmipX1+1V1lz5t3q7sF8QveI/M/33c4Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZElMEf0ZWwx9N+03S2SLeX28PaYA/V1Yjg9iqrdOCoFA2Pf7ctiq0p3fnVcBUr/hgGrSoXh75m+CAm6idp9+xhtSd/ie9h4K6AHE10D9Ex53S67UiHZUuswXiZiMRBEVNRcXH8cAl6XVHrrcemlNLzwiuulb8o0DhilNnI/NyqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=l+GoF4xk; arc=fail smtp.client-ip=52.103.2.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8lfOCaK+b5Hl9iEz6NN0V9OS6HEThQXFGq/BzgDwr35Vvg/QDBYNu+P3aO3iQW34IWVnQlCAQH7vqiDT1/lqRbpspDo5f4kdQTASBMT5TFM365+mi/6wqCOorYMFkV5usFpsW+AX8/DokZfwjMr0AMr70ciyGGxiejR+69DQxktQT/SfyJ76QnpqzMSUXEXyrf47FJvBb772+e1y48IH1uTIGNNNE+E8Ic8CP5X0uPITrFZJsy0hv57LLVdmss3dkIML02dllsRCo2SAWG0jYkv483rNeHj9/2mwUpqbty8G23fZsJ9mWL72joGWCgNr+3tNDc2LWbHkAG1W7COpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwVZyHatEsLmPr4QjKG7ebKu8AQF71dPVeCPANRolvs=;
 b=aL67tGti1CblJfyQ8fSi/q1NyLbm+C1j/t1Td/jHm7sk+bWG2hZe1SmC82E1d3T1whEH/ds/lShvTZu5U1nFVYgHzXxu9KdnfFZiPNJr2cs1n4Dr4MLxGnTlcHs+zdYjGVri1w5I3LLYLy/kz/BPl0OvifJU4UIIMAb8p4sWgWbgTUU8mizxlbE3l8VPpjYYRIGot35PHWNpJTlrgj/N7qhMBgfK2j4H/8oSpqU7KffDVFYDY2a7S8eYY6slwAxiNjT8vQhiXl0pM+Som8iGae4F9rswOabQHZ2+vaJV0i1+wH46YuWXYUMA+/mAbaoCtjEXQveBK8FaVRXsiDnzNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwVZyHatEsLmPr4QjKG7ebKu8AQF71dPVeCPANRolvs=;
 b=l+GoF4xk0VKx0frD0qA1Mnp8fdim1YO4bfTb1yU03xeiRwC5GYVY5SexagC0JErCaSvgsvxi0A5yHmmIS+qo+Qxl7cEMJztElhwFtQnfUSVvmgC3juKlooH8pKTcEPAKgv8c5k6Yu/yg3PoSK4dhuoXO59egh0XvfM//lVthn98FjA4aTbS05ah2w7o35l8OSqnpxTW5XmoslBnqJJt0iZV5WcCREZdNexPiqnjR65ZJfhzdYnuAN7nxd8IFDi3lFVXjn5c/nlmBfouluOcJKkwHeEC0UzVEy8igfToQ1qgL2/xS5JrxxbecHqV/Dis5+8FCplqQmYQc7WZBNHP6Ww==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB7216.namprd02.prod.outlook.com (2603:10b6:a03:297::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Sat, 8 Feb
 2025 15:44:07 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8422.010; Sat, 8 Feb 2025
 15:44:07 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "wei.liu@kernel.org" <wei.liu@kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "arnd@arndb.de"
	<arnd@arndb.de>, "jinankjain@linux.microsoft.com"
	<jinankjain@linux.microsoft.com>, "muminulrussell@gmail.com"
	<muminulrussell@gmail.com>, "skinsburskii@linux.microsoft.com"
	<skinsburskii@linux.microsoft.com>, "mukeshrathor@microsoft.com"
	<mukeshrathor@microsoft.com>
Subject: RE: [PATCH v3 1/2] hyperv: Move hv_current_partition_id to
 arch-generic code
Thread-Topic: [PATCH v3 1/2] hyperv: Move hv_current_partition_id to
 arch-generic code
Thread-Index: AQHbeZMAVbKnSfBiVUyEqrUSMm19SbM9jOJQ
Date: Sat, 8 Feb 2025 15:44:07 +0000
Message-ID:
 <SN6PR02MB41576EB0B48712754B38AEAFD4F02@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1738955002-20821-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1738955002-20821-2-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1738955002-20821-2-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB7216:EE_
x-ms-office365-filtering-correlation-id: c89e1f7d-c393-4a40-2c90-08dd48576c7c
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|15080799006|8060799006|461199028|8062599003|440099028|3412199025|12091999003|41001999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?MGXSlAh5Jtm47ZN+rxUjy9MegvyJovemItrInOAuNeNUZ8zWwpycVCEujGdh?=
 =?us-ascii?Q?TweEPUA7FKPyaRbNypUWoRntiVtFuUKwVFlWgLxSVPBXllvX6DFK51QBoDV+?=
 =?us-ascii?Q?R5UmcZ3NRIZ1lwMb70iKguhS6lEnLKFHMIUmi3+2yrVqT/KTahDA19FNa88k?=
 =?us-ascii?Q?vtSN16e8kVpYHEEywy25W1Vmf3a5o60uowV8CgA4jQhTiqLaN+SZCsR6tWcZ?=
 =?us-ascii?Q?1vwK+jIHSy5ZJFDIFWsv5l7ZtMC9k+6W0X7Z/hwbGncBO2N8e42RLjsgIfWT?=
 =?us-ascii?Q?fU+U9IfV6OFIFam2V/NYqkX0BKX42AvXKzTOw6jVcIdqN5LdwmHTXQYq9F5M?=
 =?us-ascii?Q?CNgDZeOsgLXBBiu5QYC92rxsQMa8qvMGufsf4qRm9dqOpxqhb233z0hRrw0+?=
 =?us-ascii?Q?oeP+Wp+En6cRyD5T21HZOxN8ZOO5HvdHlLZEcjDwOZ2n8QupBIs+SI9iRi60?=
 =?us-ascii?Q?iEpYLuGr3g9xmoWl6Z0B/WAG+868RFE/Di0WLtXl3NlILWCUjbGTh+J6O9NB?=
 =?us-ascii?Q?g6x7pPBvDWSAVnEfvsD/w5UdaEiMDDOUwhHBLiw5t16vQnYV4hGQ/obDhaRc?=
 =?us-ascii?Q?SU1ME2n3vc61x0I2qDO7I+US2Xr665arbNuSy2RaL7J36AlLMDO9Y7AdcQzs?=
 =?us-ascii?Q?AEEUzwg54+kqDIiwv7swdk132xop/29T6dpkaVHN3hS9ZPgcO3T0TkDuCtcV?=
 =?us-ascii?Q?fLZz1atgLVG4/QoEd+BgnH2+tBDAmXvkHklajn5DFrizFPZoET+W6bujJrpS?=
 =?us-ascii?Q?40QinTRgCOIUcz+D54KgyNj4/y8raxcPw18OA0Uo5lPKz4HRryquwlcSYgpK?=
 =?us-ascii?Q?fn2o7H8fvZZoYEKxN4gqRnZfHzJmzNLoBiqfgUrz9Vpi2ysVw1f+RGxdjmaN?=
 =?us-ascii?Q?w09pKRW2+W+/L56mYpxZYWMuvY5ZzU7kW64HKGmk0MymxPyr+6/42XQdRLj7?=
 =?us-ascii?Q?Z58iYFh0Ov2vHwIreB5pAOoSZN/QZxMlJ4tl1yAQLBSEtoXXN3D3Idv0j0UG?=
 =?us-ascii?Q?Vns5Rxotf8Z0ONIHFLsjHI0IWd3rj7x91YEoY4AoVUkz2oGMxq5le0KU4i15?=
 =?us-ascii?Q?sVrW8+VeHkM7Yx9QHG513KO5tnFBSyr6q9o+lENdbfd+fskrqX8=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xBUsfV6+yV31p0CImQvxc1NZwC5e1D2CtJTcvBVFZhz3xXuyebbRC3XGYXUs?=
 =?us-ascii?Q?W1Otf2WqoB92TnFg+Vzs1VPxZToaamjQKbwIErUGiWvAi6YPksf2rrsp4c8L?=
 =?us-ascii?Q?hZeMiZMdrF44egmGWjrKA0QlzcRjOxZrN1M6BeKUU+CT9V0bwer38SjMeVFr?=
 =?us-ascii?Q?vzC7b0H4c3f4ub6PusYMG5rnUJAbU4MAAbS2HYphYE5Gv7M1QuhW75dtHea7?=
 =?us-ascii?Q?mOkjer/AjU2guHfv+OmB/9h+2iEO2qAtFn8xcqcDc6LtbexVQKFWuA82iDvF?=
 =?us-ascii?Q?s9NQ7ioqt5PKBI3cMu/k7CA/Sf2M8Bo/2DKVNPXsl3thcUG+C9m0kTeceOoE?=
 =?us-ascii?Q?+q0/N4ANGPtZZQFx55VyuNmrYZyAGgtQCB7cGmL6/70hGjfA+elCrMta9HjI?=
 =?us-ascii?Q?UJQKVHKMUaMaO+oFXrQnedwVrD52lV/y9nWNL5uf4CovmDX4yWDi3vzyuF4D?=
 =?us-ascii?Q?SkonEHt2GBrLtAJbRwHCn+MFDhjVoNiUhr0hAZil7zznB/3JJ0jwshAnJLgf?=
 =?us-ascii?Q?JUcCca0IlXYtHgT8MnszhfwF9JAOuGl+p4mvtH518BOFmoU6wA8TmqzA81HI?=
 =?us-ascii?Q?m/Q32qqfmuW90edbvLkPwhjDO08Co+vrKr9FindukLByV6835Ou8k67wOoMn?=
 =?us-ascii?Q?/smxCd5cAbM6MpnqjOWZQY6tmvy5XC3jEYsZKauSvGUGSez7vZAx1yZnkRKd?=
 =?us-ascii?Q?KzDcgJgBgLo93iM1RHlVCq/g2ISrRxdMmVemfEauIVQizbzCUXVMbxKqXscK?=
 =?us-ascii?Q?FgftqW0l5PPu88wtwq4gjqSHoQ8BakMd6NnEscr99OX1oRw6o+oEESQDW6dN?=
 =?us-ascii?Q?m3fXegFaBdVSpPBkZdXERjPyEXM9zrIksaWTpCtoTMyvzfMOLLgr5NvXHRhS?=
 =?us-ascii?Q?MJ8hOJD0JPbyU3sXTfWnedlixSPSvQ9Yyuoj3DZ0nYWW6SMb6kEgUdAcLDub?=
 =?us-ascii?Q?2841L6IlWYYzzgFjpZ+KrFLWT8X1FiXF5rU0uxCV59/Boc/RLhShGbo7TOdb?=
 =?us-ascii?Q?2MAR1X+Bw68ozindjxV3nn471NgStHQj29rEQ9sdEMY1o3mwxUAdmnhbjvmT?=
 =?us-ascii?Q?sbodGsJ3UXsCgRsEvwt04KPmEiejGz+2AWNNY3eSwhrM7vZ13mzfHMFkFzzD?=
 =?us-ascii?Q?Qgk9WfcJO2riMfstAIQcfG2nOLCVa6gaBFO1uSnmppNhob5uJSvOgcZ6OWnz?=
 =?us-ascii?Q?aq3QrIOPiYrN+4nmsXmwbKNG9wvs7KP5RhB9UGr+a6fZXyD2LzEKWXj+xuw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c89e1f7d-c393-4a40-2c90-08dd48576c7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2025 15:44:07.5570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7216

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, Febru=
ary 7, 2025 11:03 AM
>=20
> Move hv_current_partition_id and hv_get_partition_id() to hv_common.c,
> and call hv_get_partition_id() on arm64 in hyperv_init(). These aren't
> specific to x86_64 and will be needed by common code.
>=20
> Set hv_current_partition_id to HV_PARTITION_ID_SELF by default.
>=20
> Rename struct hv_get_partition_id to hv_output_get_partition_id, to
> make it distinct from the function hv_get_partition_id(), and match
> the original Hyper-V struct name.
>=20
> Remove the BUG()s. Failing to get the id need not crash the machine.
>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

Looks good now.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  arch/arm64/hyperv/mshyperv.c    |  3 +++
>  arch/x86/hyperv/hv_init.c       | 25 +------------------------
>  arch/x86/include/asm/mshyperv.h |  2 --
>  drivers/hv/hv_common.c          | 22 ++++++++++++++++++++++
>  include/asm-generic/mshyperv.h  |  2 ++
>  include/hyperv/hvgdk_mini.h     |  2 +-
>  6 files changed, 29 insertions(+), 27 deletions(-)
>=20
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index fc49949b7df6..29fcfd595f48 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -72,6 +72,9 @@ static int __init hyperv_init(void)
>  		return ret;
>  	}
>=20
> +	if (ms_hyperv.priv_high & HV_ACCESS_PARTITION_ID)
> +		hv_get_partition_id();
> +
>  	ms_hyperv_late_init();
>=20
>  	hyperv_initialized =3D true;
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 173005e6a95d..9be1446f5bd3 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -34,9 +34,6 @@
>  #include <clocksource/hyperv_timer.h>
>  #include <linux/highmem.h>
>=20
> -u64 hv_current_partition_id =3D ~0ull;
> -EXPORT_SYMBOL_GPL(hv_current_partition_id);
> -
>  void *hv_hypercall_pg;
>  EXPORT_SYMBOL_GPL(hv_hypercall_pg);
>=20
> @@ -393,24 +390,6 @@ static void __init hv_stimer_setup_percpu_clockev(vo=
id)
>  		old_setup_percpu_clockev();
>  }
>=20
> -static void __init hv_get_partition_id(void)
> -{
> -	struct hv_get_partition_id *output_page;
> -	u64 status;
> -	unsigned long flags;
> -
> -	local_irq_save(flags);
> -	output_page =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> -	status =3D hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output_page);
> -	if (!hv_result_success(status)) {
> -		/* No point in proceeding if this failed */
> -		pr_err("Failed to get partition ID: %lld\n", status);
> -		BUG();
> -	}
> -	hv_current_partition_id =3D output_page->partition_id;
> -	local_irq_restore(flags);
> -}
> -
>  #if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
>  static u8 __init get_vtl(void)
>  {
> @@ -605,11 +584,9 @@ void __init hyperv_init(void)
>=20
>  	register_syscore_ops(&hv_syscore_ops);
>=20
> -	if (cpuid_ebx(HYPERV_CPUID_FEATURES) & HV_ACCESS_PARTITION_ID)
> +	if (ms_hyperv.priv_high & HV_ACCESS_PARTITION_ID)
>  		hv_get_partition_id();
>=20
> -	BUG_ON(hv_root_partition && hv_current_partition_id =3D=3D ~0ull);
> -
>  #ifdef CONFIG_PCI_MSI
>  	/*
>  	 * If we're running as root, we want to create our own PCI MSI domain.
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index f91ab1e75f9f..8d3ada3e8d0d 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -43,8 +43,6 @@ extern bool hyperv_paravisor_present;
>=20
>  extern void *hv_hypercall_pg;
>=20
> -extern u64 hv_current_partition_id;
> -
>  extern union hv_ghcb * __percpu *hv_ghcb_pg;
>=20
>  bool hv_isolation_type_snp(void);
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index af5d1dc451f6..cb3ea49020ef 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -31,6 +31,9 @@
>  #include <hyperv/hvhdk.h>
>  #include <asm/mshyperv.h>
>=20
> +u64 hv_current_partition_id =3D HV_PARTITION_ID_SELF;
> +EXPORT_SYMBOL_GPL(hv_current_partition_id);
> +
>  /*
>   * hv_root_partition, ms_hyperv and hv_nested are defined here with othe=
r
>   * Hyper-V specific globals so they are shared across all architectures =
and are
> @@ -283,6 +286,25 @@ static inline bool hv_output_page_exists(void)
>  	return hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE);
>  }
>=20
> +void __init hv_get_partition_id(void)
> +{
> +	struct hv_output_get_partition_id *output;
> +	unsigned long flags;
> +	u64 status, pt_id;
> +
> +	local_irq_save(flags);
> +	output =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	status =3D hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, &output);
> +	pt_id =3D output->partition_id;
> +	local_irq_restore(flags);
> +
> +	if (hv_result_success(status))
> +		hv_current_partition_id =3D pt_id;
> +	else
> +		pr_err("Hyper-V: failed to get partition ID: %#lx\n",
> +		       hv_result(status));
> +}
> +
>  int __init hv_common_init(void)
>  {
>  	int i;
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index a7bbe504e4f3..febeddf6cd8a 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -58,6 +58,7 @@ struct ms_hyperv_info {
>  };
>  extern struct ms_hyperv_info ms_hyperv;
>  extern bool hv_nested;
> +extern u64 hv_current_partition_id;
>=20
>  extern void * __percpu *hyperv_pcpu_input_arg;
>  extern void * __percpu *hyperv_pcpu_output_arg;
> @@ -207,6 +208,7 @@ extern u64 (*hv_read_reference_counter)(void);
>  #define VP_INVAL	U32_MAX
>=20
>  int __init hv_common_init(void);
> +void __init hv_get_partition_id(void);
>  void __init hv_common_free(void);
>  void __init ms_hyperv_late_init(void);
>  int hv_common_cpu_init(unsigned int cpu);
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 155615175965..58895883f636 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -182,7 +182,7 @@ struct hv_tsc_emulation_control {	 /*
> HV_TSC_INVARIANT_CONTROL */
>=20
>  #endif /* CONFIG_X86 */
>=20
> -struct hv_get_partition_id {	 /* HV_OUTPUT_GET_PARTITION_ID */
> +struct hv_output_get_partition_id {
>  	u64 partition_id;
>  } __packed;
>=20
> --
> 2.34.1


