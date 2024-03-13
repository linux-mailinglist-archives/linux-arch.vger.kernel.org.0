Return-Path: <linux-arch+bounces-2976-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BBD87ABB9
	for <lists+linux-arch@lfdr.de>; Wed, 13 Mar 2024 17:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28261F2115D
	for <lists+linux-arch@lfdr.de>; Wed, 13 Mar 2024 16:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F99756777;
	Wed, 13 Mar 2024 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CJwaUoDO"
X-Original-To: linux-arch@vger.kernel.org
Received: from BL0PR05CU006.outbound.protection.outlook.com (mail-eastusazon11023014.outbound.protection.outlook.com [52.101.51.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2095674E;
	Wed, 13 Mar 2024 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347772; cv=fail; b=lXfmFSQWrSB6cgG0aUkLmFCuXuwGr1N2mzU7iMcJpJyxwYheP9RDtmc3g8Q09D0ETfG2vq5htVYCkS62icn6MrU/U44nqjn7l/Nt62/goYhBRFfzA3WG37bSIYffHFxqyl1xjRdKTYiDIdPO5MmPwph7BHi7q9tUyLEOVjjkFFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347772; c=relaxed/simple;
	bh=WMKvJJkcEBkZWRy2Gr/J4ye6pSsvNsKgrpwYOc+rKcc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IrPcqeASXO491oO8TxPZD0UCtv13qYUN2KG2RpA5GWlxwPBZ/1viNpjPmc0LWPjTK5wZI6ZVT8pEy8kpyry1jYauyCPeX1pufPnopgdBN9DyX1c2MFy4CL1Rb3WiobSHgF7jNYfYEy8AKxc4uXNhXkOjbtQAhOMtbZ/wruMsbSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=CJwaUoDO; arc=fail smtp.client-ip=52.101.51.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcxxMSXJSj/pWkHeZUCU4VWPuS6RCWWY5t6GdDyYY7cA4otCg9wJOFvpMVcBYplEnMCmWnZtX1olKTaB6DAu3jYQEi5y4Lt56+IDHQq4h8MjovO2G1WZs7ckWEiPVonFDzv2s33NNAjk19dYYEGQ2Bo4qmmzIVidOAS5gfzKnBvKVmlDYNeQygPEA/mBabRUjf/6EKGRLtocnhZTpYSNIP4ARfMr0+OpL62baHRAQj4YgOIZb1F8MkdTXYQiDB7bLXi84IfVu4b/Xb8Yvu6CYQFdkuFl00mn5wACX+BubrbHxA/CvHRwcRELb71VTNjksBocLlQ9M3HX3NEyLY1dtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQoYKs615+Av+PiWcd0oKTxGZtAbTdQIXhAI9lU8JGM=;
 b=J/WceY463hxfryRhUKfc+g3fr5FrxDIYSz9KYPzh/1viJBb9bdZ3mJmhuEtUWNApAj6Z80YCmDyFJR4payyWhR2+oeqTSdcMn9qri/w2PcZOh0Fz8CfJROdtm0wBtA8hC66BLYEcb8fMh8yEV+VuDaEAjw0X09fx4q9rHQwUKsggXhon+5pbO06IBwxPVmSxi8vigxyNzfHG9rcZQ2kuyIo4ZD59Yb4kZZ+eGP8oa0HIZ2ydQHsSeSwqudxoTPh9mcEE/x/u6L4wfpD9vrdqPZyjJQ5vjD9F+hdq0dTU79RlEQdT2j+6dMllMmIQykT02siVQyZWlJDZF5uNZfejJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQoYKs615+Av+PiWcd0oKTxGZtAbTdQIXhAI9lU8JGM=;
 b=CJwaUoDOLSfnwYa7W4V7Xpju2Sa8Nqa5MnEG9SwwgMbgSMXSmdQtPCS33EFSJyS8c8+EPcmJzngYDJX7PGAwO7HPl/XEGp4jUSfZ1+M2hLEDixGYtRyqQlYne7mHTkPhnCvyV9TWQ9Wgh95B5V1VwKcSsof/P1lCMtOOniN+6Og=
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5)
 by MW4PR21MB4054.namprd21.prod.outlook.com (2603:10b6:303:21b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.7; Wed, 13 Mar
 2024 16:36:04 +0000
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7]) by SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7%4]) with mapi id 15.20.7409.004; Wed, 13 Mar 2024
 16:36:03 +0000
From: Long Li <longli@microsoft.com>
To: "mhklinux@outlook.com" <mhklinux@outlook.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "arnd@arndb.de" <arnd@arndb.de>, "tytso@mit.edu"
	<tytso@mit.edu>, jason <jason@zx2c4.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] x86/hyperv: Use Hyper-V entropy to seed guest
 random number generator
Thread-Topic: [PATCH v2 1/1] x86/hyperv: Use Hyper-V entropy to seed guest
 random number generator
Thread-Index: AQHacMAmGe+doP7+JUap2rkXt0C9bbE15x5w
Date: Wed, 13 Mar 2024 16:36:03 +0000
Message-ID:
 <SJ1PR21MB3457F1556D72C5C1620D82F8CE2A2@SJ1PR21MB3457.namprd21.prod.outlook.com>
References: <20240307184820.70589-1-mhklinux@outlook.com>
In-Reply-To: <20240307184820.70589-1-mhklinux@outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3457:EE_|MW4PR21MB4054:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 J2IUgyyUscNNpgPpRkO8kzljFUtUZV/aM2ax72CMAZplKxWt+J7yg4qqHg8RRhdFR0AGCmp/TOqAu+FvMPhuznbVnppq1BNxoFButY41ZpSiS4dKEFr12IYA8AQ/gjpT5Vu0tRdrQoYVZxbZKDQ6yUlM9gzuh+S4BpxvlAr96pI1lCc9h53dthGYYzQ14zPe3O5+uBltW2uS+S+3Ub3tOp/1ValEL7Wql3BmbLpsJ5HxBNkzpPjdpsCjIsILOdUrd5Vu3Ncj2LGWgTxFLJ49bve3coJx/zvZqqNXCZl3l2HlzyaedRLvfXCG4zFOqPcrRj1bjfnDiX0Uoo8OKZsunSBXgsqZeC+QT3AnU1/vA2SkiNSJiYE5lC1bRHW9/FfzBiGJcS7pjTKOhQZWUkLYFmnAlU/Ym2ps1abCd8EAKNJoIP92P/KJ0ZcO8YYpaU63GRJ9G+ZpRSdDNzBv1JbdkIUnVD/ExYmbUDR4h+y+DheRSKgf6RJgYbJrP2eYYXY01EVGKSsBnksZ8QG6Ysdo7pW2D7QTvQILH0U/Yih2o0b6SmOAGcyKH7vkXPak9n163o9a0/kHo2XdpG4ajlIVNBtV8EHs5RqFKlWsDsAMu+KC9O3/vEkCF9m6RVNuxrpvuHCS4ZoRbkf4cmSSEqSZ5GG8aEj663p4QUumAVtPn2i1dtyH11/MHLIOP0rTHz8Ti9/sEb1sqSj+G6mjHUj+Dw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3457.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Rq4ITfqU3cu36ft8jtQWckKEt9cJxAC4Gfg4j+76K5p2vFT9lX5ngqyj7yFF?=
 =?us-ascii?Q?yUL1y9hmoiQT7AfYGLz+SNNGSOjOQ2XkWemxPZbYYQxOincy+BMnYKMwBbpu?=
 =?us-ascii?Q?y+qOcJU2Lz2cSHb7YluI/JN1DOhrWB8IUpfhRX5pnuPHuWWGPzZBZNlffFyI?=
 =?us-ascii?Q?ow4N17VOCKzIpEaOZ6Voiapz3jE2QcQUmdPdc9QIPaPgvF188mDfEZ5uvV7H?=
 =?us-ascii?Q?w5hGPpImii957yp9+uCnZ9jb7tlUHYgu9vx5pFwgF4PMVk+5MBpe8dmQiyKu?=
 =?us-ascii?Q?kijOEvD0apVKdisiwWGm4P9vpSRpCXEvdnRVQmB3UaOWcgNNr+hRHVBxuII+?=
 =?us-ascii?Q?ABtRRuFuIel5cvlQDkBXiMF839MrNrwRHarrpUkOX1oPYP6+9/hzRNMeJiy1?=
 =?us-ascii?Q?+HwjuLlvZRi+X9MhA3lj2meK0AxMMgs0F1F0doYSseJtDiEX9Oej4ZgJnhYV?=
 =?us-ascii?Q?20aYzBckjRkmL1GLqlCoXHO4/j+vBHFZ26ujco77N5jYmC8H55TJIJ4o/cxw?=
 =?us-ascii?Q?9zvqmt4+qFYRq9f00UZ84KuV1Dddzkap6gycPZfL8sWYxDSnrRU1aP6LXtfl?=
 =?us-ascii?Q?wwx/i+p0bhoRtY+ym1kONlhmOA2KlOL05Gptang7ABdC0P0Sx8zjJQR1RKLV?=
 =?us-ascii?Q?Giw2vItgDz8slB/S9PeG5UhhoIuTuVryzoWUbFxbUJwPP40l3965tSJRYb0j?=
 =?us-ascii?Q?hpI1Hubt4a1qRr0dsiNXHYRJoiVHK8cLOIctJujpkVPaIAUFC6fk14rNeLeB?=
 =?us-ascii?Q?Z+c+dl8nWWk3OkZpqN8PDqRALSiSJu6Ndg3ntJLL5TvVug55SFUeb53N9thk?=
 =?us-ascii?Q?sFKgHJWAxiWjVDEf43cU63ArY/tCM6qjX/T86sJO+FuOkLW+iQpkvZMs9S6z?=
 =?us-ascii?Q?wN4NvkV1Bf36b4M/gPHUkPtsuMWXpDVasWFequgWkx4pxyJjHL5JT8Iedw1v?=
 =?us-ascii?Q?yJtD7znjR3bqKxLz2rqz+prQD4DCkrCmwWJqf58oyDSgvG6jZgtvosvw0Qi1?=
 =?us-ascii?Q?6he4Gq4tfjFjblV0Kb5jfPJnY+5bI1mbVlUgMvRuRGZljfgdBV5j4vobg0bP?=
 =?us-ascii?Q?JFv+0zruyedwR7Fa9Z2R5x4sRsYx5rAhw5uASP4FohansCOfJk7CDy3u7/6u?=
 =?us-ascii?Q?QkZF/g+egOMKIXJGViwl+RB4n1aFI+4B8Gpikq6HkWVO2MSwTUvnV4UFVW6W?=
 =?us-ascii?Q?4/RHyW3YkXDv7DsoFAjn326OMSUYoQEW1G1rQLbMVIxljlRAp7QCHAYoR2Zs?=
 =?us-ascii?Q?55ADbF8j1QayRgPiwwBN4L7qzQSTzIwCR+ojOXXdE51f12RX60jsgC2aF/52?=
 =?us-ascii?Q?4fhxnpobAh6U2oS99cQOp5RR/Sk6vtMzJo7APTfeJpfueVlCE8BXhz5XWEsb?=
 =?us-ascii?Q?9b1Y3BqHavFeMTy69HhE4DW1H0Rh79O/e4bGGJFtIb+0tXnQ8Myx1n3tA1Kn?=
 =?us-ascii?Q?PAq2kfS9mpBXwDGa3f88Mgqp57PbKi9XGwhLN5KP/Rce0KSfkCewJEYSWX2Z?=
 =?us-ascii?Q?Ou/t7xxxzeXpD0m/4GPOr/N82pgtJYrei2kxmBy1qAivYuDZKU1MMr4UV4Eb?=
 =?us-ascii?Q?7w9EawMfpUcI+9WgJ9pcVEOQlWSCICOrcuQ4yPjw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR21MB3457.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b23a22ea-efe2-4c66-346b-08dc437baccd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 16:36:03.8535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hBwh2bV25dfSxNEk1n9rdcSPfVwfjSi/XjYTSKDELmGosa0FbH8orOCeqteKbmBiak5H2hqQyyUC5vN+qt85TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB4054

> Subject: [PATCH v2 1/1] x86/hyperv: Use Hyper-V entropy to seed guest ran=
dom
> number generator
>=20
> [You don't often get email from mhkelley58@gmail.com. Learn why this is
> important at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> From: Michael Kelley <mhklinux@outlook.com>
>=20
> A Hyper-V host provides its guest VMs with entropy in a custom ACPI table
> named "OEM0".  The entropy bits are updated each time Hyper-V boots the V=
M,
> and are suitable for seeding the Linux guest random number generator (rng=
). See
> a brief description of OEM0 in [1].
>=20
> Generation 2 VMs on Hyper-V use UEFI to boot. Existing EFI code in Linux =
seeds
> the rng with entropy bits from the EFI_RNG_PROTOCOL.
> Via this path, the rng is seeded very early during boot with good entropy=
. The ACPI
> OEM0 table is still provided in such VMs, though it isn't needed.
>=20
> But Generation 1 VMs on Hyper-V boot from BIOS. For these VMs, Linux does=
n't
> currently get any entropy from the Hyper-V host. While this is not fundam=
entally
> broken because Linux can generate its own entropy, using the Hyper-V host
> provided entropy would get the rng off to a better start and would do so =
earlier in
> the boot process.
>=20
> Improve the rng seeding for Generation 1 VMs by having Hyper-V specific c=
ode in
> Linux take advantage of the OEM0 table to seed the rng. Because the OEM0
> table is custom to Hyper-V, parse it directly in the Hyper-V code in the =
Linux
> kernel and use add_bootloader_randomness() to seed the rng.  Once the ent=
ropy
> bits are read from OEM0, zero them out in the table so they don't appear =
in
> /sys/firmware/acpi/tables/OEM0 in the running VM.
>=20
> An equivalent change is *not* made for Linux VMs on Hyper-V for ARM64. Su=
ch
> VMs are always Generation 2 and the rng is seeded with entropy obtained v=
ia the
> EFI_RNG_PROTOCOL as described above.
>=20
> [1]
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdownl=
oad
> .microsoft.com%2Fdownload%2F1%2Fc%2F9%2F1c9813b8-089c-4fef-b2ad-
> ad80e79403ba%2FWhitepaper%2520-
> %2520The%2520Windows%252010%2520random%2520number%2520generatio
> n%2520infrastructure.pdf&data=3D05%7C02%7Clongli%40microsoft.com%7C9ecf1
> 997333f4461292108dc3ed7371b%7C72f988bf86f141af91ab2d7cd011db47%7C1
> %7C0%7C638454341537898325%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C
> %7C&sdata=3DjluLa8BFJ0wxQ1m0jcuKQO9t%2FdFVFSsfHiiSLoJviAo%3D&reserved=3D
> 0
>=20
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
> Changes in v2:
> * Tweaked commit message [Wei Liu]
> * Removed message when OEM0 table isn't found. Added debug-level
>   message when OEM0 is successfully used to add randomness. [Wei Liu]
>=20
>  arch/x86/kernel/cpu/mshyperv.c |  1 +
>  drivers/hv/hv_common.c         | 64 ++++++++++++++++++++++++++++++++++
>  include/asm-generic/mshyperv.h |  2 ++
>  3 files changed, 67 insertions(+)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 303fef824167..65c9cbdd2282 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -648,6 +648,7 @@ const __initconst struct hypervisor_x86
> x86_hyper_ms_hyperv =3D {
>         .init.x2apic_available  =3D ms_hyperv_x2apic_available,
>         .init.msi_ext_dest_id   =3D ms_hyperv_msi_ext_dest_id,
>         .init.init_platform     =3D ms_hyperv_init_platform,
> +       .init.guest_late_init   =3D ms_hyperv_late_init,
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>         .runtime.sev_es_hcall_prepare =3D hv_sev_es_hcall_prepare,
>         .runtime.sev_es_hcall_finish =3D hv_sev_es_hcall_finish, diff --g=
it
> a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c index
> 0285a74363b3..219c4371314d 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -20,6 +20,8 @@
>  #include <linux/sched/task_stack.h>
>  #include <linux/panic_notifier.h>
>  #include <linux/ptrace.h>
> +#include <linux/random.h>
> +#include <linux/efi.h>
>  #include <linux/kdebug.h>
>  #include <linux/kmsg_dump.h>
>  #include <linux/slab.h>
> @@ -347,6 +349,68 @@ int __init hv_common_init(void)
>         return 0;
>  }
>=20
> +void __init ms_hyperv_late_init(void)
> +{
> +       struct acpi_table_header *header;
> +       acpi_status status;
> +       u8 *randomdata;
> +       u32 length, i;
> +
> +       /*
> +        * Seed the Linux random number generator with entropy provided b=
y
> +        * the Hyper-V host in ACPI table OEM0.  It would be nice to do t=
his
> +        * even earlier in ms_hyperv_init_platform(), but the ACPI subsys=
tem
> +        * isn't set up at that point. Skip if booted via EFI as generic =
EFI
> +        * code has already done some seeding using the EFI RNG protocol.
> +        */
> +       if (!IS_ENABLED(CONFIG_ACPI) || efi_enabled(EFI_BOOT))
> +               return;
> +
> +       status =3D acpi_get_table("OEM0", 0, &header);
> +       if (ACPI_FAILURE(status) || !header)
> +               return;
> +
> +       /*
> +        * Since the "OEM0" table name is for OEM specific usage, verify
> +        * that what we're seeing purports to be from Microsoft.
> +        */
> +       if (strncmp(header->oem_table_id, "MICROSFT", 8))
> +               goto error;
> +
> +       /*
> +        * Ensure the length is reasonable.  Requiring at least 32 bytes =
and
> +        * no more than 256 bytes is somewhat arbitrary.  Hyper-V current=
ly
> +        * provides 64 bytes, but allow for a change in a later version.
> +        */
> +       if (header->length < sizeof(*header) + 32 ||
> +           header->length > sizeof(*header) + 256)
> +               goto error;
> +
> +       length =3D header->length - sizeof(*header);
> +       randomdata =3D (u8 *)(header + 1);
> +
> +       pr_debug("Hyper-V: Seeding rng with %d random bytes from ACPI tab=
le
> OEM0\n",
> +                       length);
> +
> +       add_bootloader_randomness(randomdata, length);
> +
> +       /*
> +        * To prevent the seed data from being visible in /sys/firmware/a=
cpi,
> +        * zero out the random data in the ACPI table and fixup the check=
sum.
> +        */
> +       for (i =3D 0; i < length; i++) {
> +               header->checksum +=3D randomdata[i];
> +               randomdata[i] =3D 0;
> +       }
> +
> +       acpi_put_table(header);
> +       return;
> +
> +error:
> +       pr_info("Hyper-V: Ignoring malformed ACPI table OEM0\n");
> +       acpi_put_table(header);
> +}
> +
>  /*
>   * Hyper-V specific initialization and die code for
>   * individual CPUs that is common across all architectures.
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index 430f0ae0dde2..e861223093df 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -193,6 +193,7 @@ extern u64 (*hv_read_reference_counter)(void);
>=20
>  int __init hv_common_init(void);
>  void __init hv_common_free(void);
> +void __init ms_hyperv_late_init(void);
>  int hv_common_cpu_init(unsigned int cpu);  int hv_common_cpu_die(unsigne=
d
> int cpu);
>=20
> @@ -290,6 +291,7 @@ void hv_setup_dma_ops(struct device *dev, bool
> coherent);  static inline bool hv_is_hyperv_initialized(void) { return fa=
lse; }  static
> inline bool hv_is_hibernation_supported(void) { return false; }  static i=
nline void
> hyperv_cleanup(void) {}
> +static inline void ms_hyperv_late_init(void) {}
>  static inline bool hv_is_isolation_supported(void) { return false; }  st=
atic inline
> enum hv_isolation_type hv_get_isolation_type(void)  {
> --
> 2.25.1
>=20


