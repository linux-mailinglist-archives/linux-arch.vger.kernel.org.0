Return-Path: <linux-arch+bounces-12371-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C236ADF250
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 18:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7DD3B285E
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 16:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9D52ED857;
	Wed, 18 Jun 2025 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="vNVG44wR"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2042.outbound.protection.outlook.com [40.92.42.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E742EF2B0;
	Wed, 18 Jun 2025 16:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263487; cv=fail; b=RLzoC+n1EQMBv7FQIMw6YYj83Iq46NQOSfQPUfHx21ioi95b43sFjUZAyjwqmydkFZYRAFBzrs9X5EwxnaURsbndE/Rj6qyHFFbY9rPMJNYZcwEW29HKGD+0QqRG6A96tU5wQKP1qZtQdko81nk6vMU6kOM7wmOdA4hgHPB8auI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263487; c=relaxed/simple;
	bh=Fzp36CxZMLM9PmyyS8ojnojWEJE4WE5wIXj5+hspIKE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xlqms/4pf2d+HpN1kCDRDNWWhaQQssF1L4DS5IimERs9vrmJf108egjF2WFAfYmltJxiem0fTlnLeOsCyqfLPEYUQCD7c1fU6TlSqW3GXQLF7OAKcMBdxRbabMMMqnLM98tx02Mn7K4BbM0N2ttMfwQeBFkkzDV5386uB3KKo2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=vNVG44wR; arc=fail smtp.client-ip=40.92.42.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zAqlRUbExcLHy0ccm9MXqmWfIpHWHUxdB7/nDm93vLsATxWMgvIMDVqhC5TQGe7OmQU4fuWh3Qiini1YIJgR8IYNrTQwPSTvHbT8jo4R56c+SmaVOMynn+zJ0FQxVJOqoX3qbCKVLlrCCCO9D7Y7y9VZCezoKNKLlzgFUs9xlkpGAJ9GcpXYK69+4+vnnP/a8soh4lBMAACU8Fms6NMd76bGkWebMsLjRZYDv9TWwYOhAXY2WmMrcqbtEABrNcC7nbxpWiXVMh3k6AxtD3uyeEvVgQ/NEoSNeldt+gnbu2ZWypesP3ZYAnQqSZnvoT8hlxLa4PB4CMp32jH75dYLlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woUz9TKvNopaK8q5DuSR2HUMF+e+lY45lKOIF5rBtms=;
 b=Iji6DgGECuOZtGtyaJWvE++0QNGzjCnlDCIXfQJ/GZmUBUTnVUK2vilDLnymPnTFqbzgNcRQ15A+beEegoYMmwgOyh59Rs/DHiCscTG9em7brs51D3XREy6vPVGoGXG6xmNwcOn4/K9X6guujeXe2/4B4kPdwKhCtsezOhxXwyZmTRlDWZHvRist5algphxSzMX4ZCQRg3zCvjGZHl8xxztNgqa0ZJQj5ezUcKJR4LPaW1kRS5zrmGFnX4m2sqS5tHYQnERDom5OL0pYe2nfjmV2aC59igvMjAzDO0TrMfWxcs6qpDt+joH2aRrB1KRcXer9nkfm4GdDFAikUmh7kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woUz9TKvNopaK8q5DuSR2HUMF+e+lY45lKOIF5rBtms=;
 b=vNVG44wRUV3kQNQgy5/Xhn75nSD23JVNheXoVnVRWH4qBcMz+Y1S3lpCeAh9AOtUHj+V04FuoHUWCFgccecVclXrQXKCoGAJ1dBBsAhAMaLmlE/ALf/Oxjo7oSaTePYTB3gTL1d3bNo4HbKf7WNnjXX6vgPQNkEY3GmdCxXPRlMBbnY54+9GU+CxDDW+M8eFVF6zLujnCRUYHWMPIBpIAGROMUxQJRbcJcVGRkzeUJLUiZqiTo71Lievw3rAfy4XvH7DRsIsPYwkurCNfV1Y0OrTUN3N7odlPaJC5nGN4bGKy2BmwqYvHG2F3oW+0MEPE/QaD57C3KNEEzEubgMvkQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA1PR02MB8462.namprd02.prod.outlook.com (2603:10b6:806:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 16:18:02 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 16:18:02 +0000
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
Subject: RE: [PATCH hyperv-next v3 04/15] arch/x86: mshyperv: Trap on access
 for some synthetic MSRs
Thread-Topic: [PATCH hyperv-next v3 04/15] arch/x86: mshyperv: Trap on access
 for some synthetic MSRs
Thread-Index: AQHb1Om7GVWwzL5ZZk2pLL6a7dL0pbQB8vXA
Date: Wed, 18 Jun 2025 16:18:01 +0000
Message-ID:
 <SN6PR02MB4157E84CE73DF70697A09DFCD472A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250604004341.7194-1-romank@linux.microsoft.com>
 <20250604004341.7194-5-romank@linux.microsoft.com>
In-Reply-To: <20250604004341.7194-5-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA1PR02MB8462:EE_
x-ms-office365-filtering-correlation-id: 21438aa5-a564-49cf-87a7-08ddae83b2c9
x-ms-exchange-slblob-mailprops:
 AZnQBsB9XmrJ3OdcGJgulPpe6kFhF3ON6KoEx8NzruAw9rkjsWRiZtuyDcWutYxIp112/aqCOy1LeFRUi5Wj1tpHztEMjbxX5wPna7RmBk3N0ASqK8QMoiWS934soAIbKCzGDOvxjIGLf0V83P+IY4rDAbzAXEE2pg3HwdQ03biCIzvxKoRrSTlAkTtySfonkv0NJQnBOg5dI8s4frTac+PKUa9EgQp75by2Xg1bP3AzCHYKUg8K/9otFlY4hOuiyN3zkwcdBAuoXM+SLrzxOxbxE7/QRolWRHKPaf2NokSXUYoGPnhJyDZ9nl8C6RO0oWn2Q7rZizL5LTo8kMDOOPiFhl5soz9i6w33NY8+YnrHAsuKXmR5SLGGZS8vbcpm+mgwvdYPn0dBxMzlrntZ5a/A0lHPu/NJXWHyy1/iFU0ihxVdmINq4Rvc5uasEu3rRwaAjtZyz9DFYBZwfsMyMuWXfbCW0JmaErvbCwNdzdlPlpTCnopx4hxbW7ZD8wKPn3wddaZcCcuZmbUbQ4l/NUpEvDcbHYcbaJVoEwMKqnuJ8EMcIu435CA6ARxkwIp64AwG06ZB69GkVukwqCodAqXgVfDEtRH2keg0USRM3XJjMRTuowYKFEQWYJsTbrGKg5F068EO3CuQiyqNe3KImWwpO7LvN7LUbuQyJ8ne6ifud+E+zSXerXotczQBjLzVFcviJV76xAjEz1kWcswP/iIVCG7RJclQfnB7SEkblXAMEGUs1CaP4fMmIllWBgMnUjWDw+U/8xo=
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799006|8062599006|15080799009|8060799009|41001999006|3412199025|440099028|40105399003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?gASzQggTiQRw0Cl3A/OPiJLP4S2ijlBaNmNlbl7y8fNN2qDGF/oxoMH6Nu+K?=
 =?us-ascii?Q?hTtphvMZRLITglHpl8JVKOkxeXkwW/bvLjMKkDG6bAWRZPWPhApYrY6k6JZc?=
 =?us-ascii?Q?lB23ekPGztko/RBbP0BnUKyWcEyaBGx999Mi1PgfjgsVFIevuQkJO6aFkv7a?=
 =?us-ascii?Q?V9PT4aX5tgwyYBVDvYs2hSqNDAI+NcFWREokAuhi1QiaM4748TK8PemgSoN0?=
 =?us-ascii?Q?mGNB3bDE3Yy2QCcFWopZgFXwXW8NWNtap2jjC2n+d4HuIIhseiX5F5pgy2l2?=
 =?us-ascii?Q?4wr+iD0jUJcoozvRT7URSTjxOgjCx9pq99lweIdzz52ZW0Fm4NdPO0fZ9o94?=
 =?us-ascii?Q?98FYuYBnCbn8ntW1jeA8l01XPNJeL/AD0W/ygengYgdnXGy/SoHm95zGKfvC?=
 =?us-ascii?Q?rTgR/estNQxmvMQZG70IAOlXcz7PXjzIStwzJnPoqUHfFn//Iou+otsbGoK6?=
 =?us-ascii?Q?6a2V/FsQ1gv9EIZYnGgjwyOA20fEAg+lzVtc/JOKf8iZzlSWly1LeQ4sjGBT?=
 =?us-ascii?Q?S/4yNSMCNsWg4lvxSsArV8EfU/bdw1Xivxrc+gFKFBRqWQ8zJvLiIat6DkDG?=
 =?us-ascii?Q?+1Fe2tjUmFS8dUHKBG0v2b9g/GnoGCTHWCkB484S/9jM3PxaYZ5eJxly/m4h?=
 =?us-ascii?Q?DTdCogJQiCPZjQ1FvXT2450NzUll9VuX//TgvjFlaG+2yyaGiGKPfGp9i5ze?=
 =?us-ascii?Q?v6lrp7n/HcfQHZ/fdAV8YvPweSB+g5jEQnlp6009LWyLB2v2EX+tNfofEO8A?=
 =?us-ascii?Q?53edfsiJMhs9TAjWldM8rMXvLfLyRv7RDM6C2AgVaxmKmtoZhJ4D77aAsHRn?=
 =?us-ascii?Q?Fw2fD/OSjJQE8912te491xNJGQR+xMS+mwj68Rzs1UMxywz+4qG78QymESS3?=
 =?us-ascii?Q?JZ9mSSsk2u5yKpXy12HNuTZ1tgmCNPZDeQ0uWNP2tPVV8PiXRhIAwprPztj8?=
 =?us-ascii?Q?sRbUYstAkmsRKmxAT6MQAUPUbRVBe3CcTGDHMwSyEvttWzHEKkdiMKnfP01B?=
 =?us-ascii?Q?swzjYevc/2JZDneHjPfZUhC8Ksf4hPaz1JKap9SpfJhdGGX3Opw/OMqeoXQJ?=
 =?us-ascii?Q?LS6I3lTMETprykFMZm/SWWPhOF3hWgwzGoAAgZn4rE3uKNrp9CaxH7hbMwmO?=
 =?us-ascii?Q?BDu/YvIyI153I1TRNSSlEAR/pIUcsxK5zg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dremuE0n8ntIJfZsL1eFTxPcSQiIaaQooJVHLtiI1jqzn5NCT7av68Vg1Z7A?=
 =?us-ascii?Q?Ua8+pWsTATTjTRbUCjUibS52S8Qn+VsSSnmNnej5CHA3Yl8dMgxjZ1UjAosh?=
 =?us-ascii?Q?SflhvL7ZUR+AUY/QYzWe7R6Z/gNSkBwwpszxL4fdj1FpkubsqTNQycx8vDM6?=
 =?us-ascii?Q?DRiJvTHQX9kU22AaGlzNXjdebpOD4drFRx1m5DbWLU+FOoxZlz7J3F4T4sh/?=
 =?us-ascii?Q?H5YA4A5xWYXNT6CjoZadZCgjQyqqRBoJ/nH3+cJKAYvAXvvlj8ISDgq9+Rh3?=
 =?us-ascii?Q?TsAwXAkxKSlVMLPhD++GxXpm9WcE1LCV1NyzGYyzm/xfSA/Yc+TwphO6ROFb?=
 =?us-ascii?Q?F/4jFxjjncRnkXuB7cBJcLicpcpDhXls5sa/bJPSqwndbtsrMMwAPX7KS2Z+?=
 =?us-ascii?Q?GgJYsrLfOVhFyVw+iC0CdL+SBQ+kVg+ZgdBCzQLRZ8vNObBObgjFmzmotQox?=
 =?us-ascii?Q?aelSPu2bIZLAC6slhseRlW7O6I38xhcD7v2H9O1JPPx6NyynMQOFNigr5v41?=
 =?us-ascii?Q?ZsUyu1cJ13qILJlepN3T1ScVidC+VOLyncoB31stWT+idJf3uaL7pZ35i7yD?=
 =?us-ascii?Q?RjQbyXGFk/qSw9xQ2XfrStVNEyh2MeTWoUMzPghGEAW0xJldKCL2qsMkK/Ek?=
 =?us-ascii?Q?dKbA2xiXSndaqt6kxvVRXG60TLnYsKFmuXpAJo8aMV4WGnCE7+VMKVFjU3Zl?=
 =?us-ascii?Q?h1lpaZskqx99o58LetfFWd5dy9FD6QCkN7lgks1BRs1dCoSu0t7aohyug1UG?=
 =?us-ascii?Q?a6E1VFZD2zgUy7UroPwUO2ZzZmRDK3IWi6EBcSt7r+GrWmrE94/HcKFxmmM5?=
 =?us-ascii?Q?LZlqSJcFL4faIimZN+tfagi165jQy5VG5AVammRjw6BA/czuUVrD2W93TFtL?=
 =?us-ascii?Q?c3d5/Pft5RDJjDGXkoSTlkyt8ByaQRyC+cjS9fpDLvP2CRTDleGQvsLuCny7?=
 =?us-ascii?Q?nRs0CjklUBH7nuaHx9D3OhwRiPR2Xy2WPpR0YAB6RY4mN+6upCDuk181ryMO?=
 =?us-ascii?Q?+H3hS5mVKkn/hlH78+lEJ1X3BIOuhWlbc5RqL7mip3qFZ/PF86QGuFbAQV+d?=
 =?us-ascii?Q?e7DKNiIieatMqPHz+Ri8PjUaWS2jXqUkOOTI84u+EhxEwhFHBb0o7H5XR6LG?=
 =?us-ascii?Q?jOjSJptVVf3K8j0CQ0/h8UcgiY+JLnRoftCHMkmE/uIVShB0FqvhGOoy/Z+w?=
 =?us-ascii?Q?PMuiplJdDe40sqwUQxg5lw/Phxv6gHiYpAWJncMGnLv1J/G4XNErd/ucu4k?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 21438aa5-a564-49cf-87a7-08ddae83b2c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 16:18:01.9599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8462

From: Roman Kisel <romank@linux.microsoft.com> Sent: Tuesday, June 3, 2025 =
5:44 PM
>=20
> To set up and run the confidential VMBus, the guest needs the paravisor
> to intercept access to some synthetic MSRs. In the non-confidential case,
> the guest continues using the vendor-specific guest-host communication
> protocol.
>=20
> Update the hv_set_non_nested_msr() function to trap access to some
> synthetic MSRs.

"trap access" is somewhat generic, and it's not clear what the intent is.
I'd suggest something like:

hv_set_non_nested_msr() has special handling for SINT MSRs
when a paravisor is present. In addition to updating the MSR on the
host, the mirror MSR in the paravisor is updated, including with the
proxy bit. But with Confidential VMBus, the proxy bit must not be
used, so add a special case to skip it.

>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 83a85d94bcb3..db6f3e3db012 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -28,6 +28,7 @@
>  #include <asm/apic.h>
>  #include <asm/timer.h>
>  #include <asm/reboot.h>
> +#include <asm/msr.h>
>  #include <asm/nmi.h>
>  #include <clocksource/hyperv_timer.h>
>  #include <asm/numa.h>
> @@ -77,14 +78,28 @@ EXPORT_SYMBOL_GPL(hv_get_non_nested_msr);
>=20
>  void hv_set_non_nested_msr(unsigned int reg, u64 value)
>  {
> +	if (reg =3D=3D HV_X64_MSR_EOM && vmbus_is_confidential()) {
> +		/* Reach out to the paravisor. */
> +		native_wrmsrl(reg, value);
> +		return;
> +	}
> +

It seems a bit inconsistent to have this particular MSR treated as
a special case in the generic code path, when the new functions
hv_para_get/set_synic_register() have been introduced to handle
the unique requirements of Confidential VMBus. This MSR is set
only in vmbus_signal_eom(), so maybe vmbus_signal_eom()
should test for confidential VM, and call hv_para_set_synic_register()
instead?

>  	if (hv_is_synic_msr(reg) && ms_hyperv.paravisor_present) {
> +		/* The hypervisor will get the intercept. */
>  		hv_ivm_msr_write(reg, value);
>=20
> -		/* Write proxy bit via wrmsl instruction */
> -		if (hv_is_sint_msr(reg))
> -			wrmsrl(reg, value | 1 << 20);
> +		if (hv_is_sint_msr(reg)) {
> +			/*
> +			 * Write proxy bit in the case of non-confidential VMBus.
> +			 * Using wrmsl instruction so the following goes to the paravisor.
> +			 */
> +			u32 proxy =3D vmbus_is_confidential() ? 0 : 1;
> +
> +			value |=3D (proxy << 20);
> +			native_wrmsrl(reg, value);
> +		}
>  	} else {
> -		wrmsrl(reg, value);
> +		native_wrmsrl(reg, value);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(hv_set_non_nested_msr);
> --
> 2.43.0


