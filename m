Return-Path: <linux-arch+bounces-13635-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72637B5841A
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 19:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF6CC1AA7164
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 17:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1302D5C92;
	Mon, 15 Sep 2025 17:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="F/fWXC6I"
X-Original-To: linux-arch@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19011068.outbound.protection.outlook.com [52.103.23.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10592C21EB;
	Mon, 15 Sep 2025 17:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757958950; cv=fail; b=D00/C9V/2uCPMCAFPw1dEakIULXS2peZ2KYGE05Cabbikg6T1OzAEc3KNZF7R3Z26NTE9YLHJdA0MfOTnKW8iwy4wy167/6BzCXiFtwIRc8n9ceKwJ/0s10RKohGZDDkFARbReJoWVhdF5IRyOwM1p1fQs2RSRljFcmpqq+OkZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757958950; c=relaxed/simple;
	bh=p7bJOOqdpC5tSEEQ1Dl3v/f1qnWddtrkHQ4rVgim10s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LVaecK4Fv6ILJFwI6CXTno73zZJ8Q5HiTD07aFsB73lGTSveOYsHCqE8N4sXWDAv9CzcFixyqN+Xvf74QtXiXfjy9emwClh2g5CcLtaMjy5lnTC8tcR9TOC3HgxfCkgNjFUFHRoa52+FJT2le4/g/iH2nYaiZipX/LrhpaADGBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=F/fWXC6I; arc=fail smtp.client-ip=52.103.23.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emenM/3XiDuielPtd5Br3mTKOp6X/yAP/tUDKeIEPb42rzlvY5g3O0Ujjhrsm6jNWFR037+yF17QBTiXGso5xlltSO+mBjsZiPWnmunF+PK9OcrRmOTQxYywJdpuvqEefCj88sJpvnEhhPKTunVZ5VMMJRfGhEQh+yTNrJ5nv4P44u230IopbLmHCOG+aa/ysM8VX5KMfHQZBh4bsRORY84Xokbyy2EdejvgL/Qt9kOypUC9tl+Is/5fLZ5K9b5hxjHc+vTc3uxlLuQCarul3Ve11BLimvVpxI0ThKLgSTtX155GiLdMCsaR7cAtxw5hvCEhWCVJn6QWZFjUoDPoCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N++oTVwh/INeuMV8saaly1x8sIQ4WzlaZFzSOns0UJk=;
 b=Xxf6GeSwLPH8qogFWo5nXI6d601Ylh4TdLi0qGeUS8OsAzPEtjAXUjIGCwW4eKN22Vy9JR/mPL4vVRR56nyhQ9gCr1peC/hK8DBdNOL0nXs/G1Qj9nCOIr3ajpmMQrB7eopjVVdSv9KAJQSVWmXL+NdswUrjMjvHR5y8b9SHFyPzOOS8faZoNFVjcXh+QFzANO3Zj8iCBoQtCnhWYZpmDwySl1cN3RmJi06Jn4dZIruk8+FQph+ufatkAu6fHoXjnNoIbr2csrGz1lEGtnr3O61oMU9o0CDGRpDEKy8d2pyPVYaCuUgMKG1Blt2YEfry6QR9d46E+JokXp6T5G/GIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N++oTVwh/INeuMV8saaly1x8sIQ4WzlaZFzSOns0UJk=;
 b=F/fWXC6IJFoWO7RJrkCJjEe+KOjDP47NbrEK5jTnLM9Hj5iCyIVvA6XSm8jSkAvLUUp0P4PrakTJWk7/xYgg60m3cUaX9QhMul5HQ9PcAxGAHtnnjQuUUFtyEayHj7B1PwjMVaYWZ2ZwnKUCvzBaKFuQdy/xFNj13Ng17Edh++K6fTEJBD/bldRCVeZlXg1TSAyndBqDrQsreepSu6DWUPgA4O4Au1mBs0qjw7CUhrRb7j/ye+p+rTMpg4FEI0g7VbWJtVugpo2JZZtu4HASswIH9TLnDF+j0PtACaVj2gqzFC3WUxXBiDnhA3aqRxkxsalq4NgmFkbWVUi98/tDiw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV3PR02MB10056.namprd02.prod.outlook.com (2603:10b6:408:19a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 17:55:45 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 17:55:45 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Mukesh Rathor <mrathor@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"arnd@arndb.de" <arnd@arndb.de>
Subject: RE: [PATCH v1 5/6] x86/hyperv: Implement hypervisor ram collection
 into vmcore
Thread-Topic: [PATCH v1 5/6] x86/hyperv: Implement hypervisor ram collection
 into vmcore
Thread-Index: AQHcIeeHwOAc5qTPekmo9sfTvV5JMLSTKvtg
Date: Mon, 15 Sep 2025 17:55:45 +0000
Message-ID:
 <SN6PR02MB4157CD8153650CC9D379A03DD415A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250910001009.2651481-1-mrathor@linux.microsoft.com>
 <20250910001009.2651481-6-mrathor@linux.microsoft.com>
In-Reply-To: <20250910001009.2651481-6-mrathor@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV3PR02MB10056:EE_
x-ms-office365-filtering-correlation-id: bcbaef28-68cd-40c1-9872-08ddf4811849
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|41001999006|8062599012|8060799015|461199028|19110799012|13091999003|31061999003|3412199025|440099028|40105399003|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FgxASV1dcTm4XLD7tLBYOtuJV90kQ/uhEbeJZKnSV3g22yWAreT1l/wbPqMM?=
 =?us-ascii?Q?fsxGEaM1VLOQf6H987u5WKiuKqOrOpD6f19PXvu+uG0kVwlSfhgaf5/rR6B1?=
 =?us-ascii?Q?s/gNkRYG75ds1PCA6nK3JizGuRO522MFacOaStJ3v3Gjo5KuloFXVcCnNdXr?=
 =?us-ascii?Q?ip7rGDSXbDQuyDNbzzPhJ1o/c3HB6d0PQ6qIIgvG5Hm2EqTW+ZCVwm/59Zg3?=
 =?us-ascii?Q?xAc42FzfkOf5ZU7+a7dHw4XgblzAhRTKkiocPit6d3xm2fqU6o6f2TJZtehc?=
 =?us-ascii?Q?xG13nQeOggjdNMMFquvK02B8u1CkJsj4UN3BZ2KZCRSkz8VzScxpt8JJ54WE?=
 =?us-ascii?Q?F679gH+uiN2/01EfsJwfqVnaPcAzxM8uX+jX8v7lSYU0Dx0ys6i4dJCce2bA?=
 =?us-ascii?Q?ztQSycxGvGATtY6mrjwonuK7x1L59cHgvgqHGH2DqeIxAliI3UJFXHcMT6e0?=
 =?us-ascii?Q?OpKgWgYVgxylhNshi3TXzNX+wEO0HDPpM50Hv0neOGjxias3femy+CSUH37Q?=
 =?us-ascii?Q?dbKLErNOxgQa3dvpA2LUTdOQs2kaYWtibfyXefeGa2s7ffXyvZWpK40YwiOh?=
 =?us-ascii?Q?woip8t3bfYnXDZ22hEZNHSdEp7aRvecbVmey8dEWl0/6SoO4CjUZE26ic1W5?=
 =?us-ascii?Q?PguMbSbjhtxF53BH9RczsUzMsTfRXHdMEviiktSaMMooag/f7n/mMGMkKTjA?=
 =?us-ascii?Q?8jJFmSUZY5UskYfE6W197tr3c2Eukm/PvKWp5C2pDDKsFUmTYf7b0AgO3vct?=
 =?us-ascii?Q?oKEPmQF6fSOVyrEh7ARmXJwwl9QubFe45ryIEnRIf81eDaDQ9LiDxL6lr7Bk?=
 =?us-ascii?Q?6leb27lEIouoqr4JTX+GpiOuUmnlH3P6LKIEnKRsjHJgu3FMLeKqosBzIhL5?=
 =?us-ascii?Q?mV4/SgrK2xtXgceQ1R0WynkrqY12aTi5HuzLOvO9FVwpSz3d+KvMTsCa+dSE?=
 =?us-ascii?Q?YZPvvv4A/HFQyWiZTlnYpmqdHs7UWIADgRjV8hNspaD0D1gYaG4svTlkfd5y?=
 =?us-ascii?Q?zwucuf/BGHCxd6sxDLSuwaqIFQmpuyGX14LjYwfY+yhR7AelQrvHJANj2S6m?=
 =?us-ascii?Q?bnP7MCQnFxS6KLngut3bpEcNpU/KtcHWUIkQMFtfWlBUp9J7pTjntqzFiXYQ?=
 =?us-ascii?Q?lQo8p/LHmuspKsuIjAEXiLeupqwWYlNEUi5NBVMLKQRWuEks+XngP7mJ8dCN?=
 =?us-ascii?Q?cT+G/DEOIKkjMnrvUK9toEm/hlOBsulC8D2+iBb79qmFVUA0ElY+l/wwi04?=
 =?us-ascii?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?F9Jza0ab32w5cXw7jRM7YsyWg/ki0E9qkqEKfSf3rTbcW9QSPrlfGPH70C9A?=
 =?us-ascii?Q?5NA7E1Xn1P5yaJA0iRZVEzanvU8WW11/4VdnRHq/YxLsd7BQA+gTsOyytTdR?=
 =?us-ascii?Q?60vdsgh01xCezjL0pSIPVJ1UNjXh7USVapuJngNzHXHSxZKjCFOgvXqBvm+m?=
 =?us-ascii?Q?BBkOCSef0WfSNXaNbA7vMHKE+FascdCNudOm21CpOBpqtTokiGxFPP7CRRwb?=
 =?us-ascii?Q?k3znwk/daRbnQbpkTl9YWP1yed0OouUJ+0+VuhwS9XkuGGpyv5yBPtAfww+N?=
 =?us-ascii?Q?c576BpRTKjlxsVU0fyIYw0tAZaSDAzfThx/JNw3nu8yT1Gp2O9UnyQJLVAKa?=
 =?us-ascii?Q?M6FgYYoS0ijZBrqgiRryObtvoiYGqyoS+huhsDkMtHXGVWP16DmcV2VszxhY?=
 =?us-ascii?Q?KFVMjEPi3y5p26RHmwh2xl4YtcTl8dxvShplHJM9NN+ivowXNpfYEwlqiE5G?=
 =?us-ascii?Q?NLWY4NMBEPRkzJtuURbkoWOYQu8NnYA9u3o6BaXmnWWc4z5yBMCBAm6L3l8h?=
 =?us-ascii?Q?KxjUmQ6UIsFCWEiflOkLpmjfC4cSyEKr/x/C4pEWLZBkxwuTBuvUJ+iay7SJ?=
 =?us-ascii?Q?Edd8uIxbzPQ7rQEUM82XJ3Lkufb6FlHmeOUJhwORaxFK3sEVLTUg75BNhvXG?=
 =?us-ascii?Q?bPhJ9WQux3vMG0sSqCn1R3ZzeZtHO3ELrOLQZKV1jSc5UKDoksT233+UhY5A?=
 =?us-ascii?Q?eGZ2/Iap54WZJFktUiZppHcQWNh67WZIz+wwPAjAB4Pz5jCqQyinNXVzJhZY?=
 =?us-ascii?Q?QNpgcXyjN7QLDoASCKim7+wOz0foySpXXwPEvCsD4m0K2hZNV9dqgkbYxFfu?=
 =?us-ascii?Q?qYEBBeOX87PDJ2egFMl7wBtxdHxjzX3gtE0pe7MOFlyMRvrFpFRxf11Q+xDq?=
 =?us-ascii?Q?QWEDZ8Bo1YfxagPpQIM0EhOtGAZDsN0W/SrdSB7hUvoybyHctRXp54weiVLz?=
 =?us-ascii?Q?5xuPi1eBi2IKGXa1uWxJUg3g3R1c7552JnHwcYlFJhBlGPdoI+lSAeljFvXk?=
 =?us-ascii?Q?LTipV/NLVb6U2LBl3knaTrj10VSc+Bte2XgZUwi99WgsMIcrcJQw7m7M4EL5?=
 =?us-ascii?Q?e6XbHEXbxrFHn0xwG4FJEn7jNaJtDniVCc9ovLUkiPAVGWT2mkHt3JyKBfpk?=
 =?us-ascii?Q?y3IQ9VM1S4x7AjsdABQWOZsSZwtKyIBgsIrJCmoR7fTq6j2YcuAt0yCIiSkH?=
 =?us-ascii?Q?xeTKJim5guDhs0AXy0gx7KQtxJWmtPZHOqoXNxqSWpP3kgMJ+gYiRWGKYnY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bcbaef28-68cd-40c1-9872-08ddf4811849
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2025 17:55:45.1583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10056

From: Mukesh Rathor <mrathor@linux.microsoft.com> Sent: Tuesday, September =
9, 2025 5:10 PM
>=20
> Introduce a new file to implement collection of hypervisor ram into the

s/ram/RAM/ (multiple places)

> vmcore collected by linux. By default, the hypervisor ram is locked, ie,
> protected via hw page table. Hyper-V implements a disable hypercall which

The terminology here is a bit confusing since you have two names for
the same thing: "disable" hypervisor, and "devirtualize". Is it possible to
just use "devirtualize" everywhere, and drop the "disable" terminology?

> essentially devirtualizes the system on the fly. This mechanism makes the
> hypervisor ram accessible to linux. Because the hypervisor ram is already
> mapped into linux address space (as reserved ram),=20

Is the hypervisor RAM mapped into the VMM process user address space,
or somewhere in the kernel address space? If the latter, where in the kerne=
l
code, or what mechanism, does that? Just curious, as I wasn't aware that
this is happening ....

> it is automatically
> collected into the vmcore without extra work. More details of the
> implementation are available in the file prologue.
>=20
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_crash.c | 622 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 622 insertions(+)
>  create mode 100644 arch/x86/hyperv/hv_crash.c
>=20
> diff --git a/arch/x86/hyperv/hv_crash.c b/arch/x86/hyperv/hv_crash.c
> new file mode 100644
> index 000000000000..531bac79d598
> --- /dev/null
> +++ b/arch/x86/hyperv/hv_crash.c
> @@ -0,0 +1,622 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * X86 specific Hyper-V kdump/crash support module
> + *
> + * Copyright (C) 2025, Microsoft, Inc.
> + *
> + * This module implements hypervisor ram collection into vmcore for both
> + * cases of the hypervisor crash and linux dom0/root crash.=20

For a hypervisor crash, does any of this apply to general guest VMs? I'm
thinking it does not. Hypervisor RAM is collected only into the vmcore
for the root partition, right? Maybe some additional clarification could be
added so there's no confusion in this regard.

And what *does* happen to guest VMs after a hypervisor crash?

> + * Hyper-V implements
> + * a devirtualization hypercall with a 32bit protected mode ABI callback=
. This
> + * mechanism must be used to unlock hypervisor ram. Since the hypervisor=
 ram
> + * is already mapped in linux, it is automatically collected into linux =
vmcore,
> + * and can be examined by the crash command (raw ram dump) or windbg.
> + *
> + * At a high level:
> + *
> + *  Hypervisor Crash:
> + *    Upon crash, hypervisor goes into an emergency minimal dispatch loo=
p, a
> + *    restrictive mode with very limited hypercall and msr support.

s/msr/MSR/

> + *    Each cpu then injects NMIs into dom0/root vcpus.=20

The "Each cpu" part of this sentence is confusing to me -- which CPUs does
this refer to? Maybe it would be better to say "It then injects an NMI into
each dom0/root partition vCPU." without being specific as to which CPUs do
the injecting since that seems more like a hypervisor implementation detail
that's not relevant here.

> + *    A shared page is used to check
> + *    by linux in the nmi handler if the hypervisor has crashed. This sh=
ared

s/nmi/NMI/  (multiple places)

> + *    page is setup in hv_root_crash_init during boot.
> + *
> + *  Linux Crash:
> + *    In case of linux crash, the callback hv_crash_stop_other_cpus will=
 send
> + *    NMIs to all cpus, then proceed to the crash_nmi_callback where it =
waits
> + *    for all cpus to be in NMI.
> + *
> + *  NMI Handler (upon quorum):
> + *    Eventually, in both cases, all cpus wil end up in the nmi hanlder.

s/hanlder/handler/

And maybe just drop the word "wil" (which is misspelled).

> + *    Hyper-V requires the disable hypervisor must be done from the bsp.=
 So

s/bsp/BSP  (multiple places)

> + *    the bsp nmi handler saves current context, does some fixups and ma=
kes
> + *    the hypercall to disable the hypervisor, ie, devirtualize. Hypervi=
sor
> + *    at that point will suspend all vcpus (except the bsp), unlock all =
its
> + *    ram, and return to linux at the 32bit mode entry RIP.
> + *
> + *  Linux 32bit entry trampoline will then restore long mode and call C
> + *  function here to restore context and continue execution to crash kex=
ec.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/kexec.h>
> +#include <linux/crash_dump.h>
> +#include <linux/panic.h>
> +#include <asm/apic.h>
> +#include <asm/desc.h>
> +#include <asm/page.h>
> +#include <asm/pgalloc.h>
> +#include <asm/mshyperv.h>
> +#include <asm/nmi.h>
> +#include <asm/idtentry.h>
> +#include <asm/reboot.h>
> +#include <asm/intel_pt.h>
> +
> +int hv_crash_enabled;

Seems like this is conceptually a "bool", not an "int".

> +EXPORT_SYMBOL_GPL(hv_crash_enabled);
> +
> +struct hv_crash_ctxt {
> +	ulong rsp;
> +	ulong cr0;
> +	ulong cr2;
> +	ulong cr4;
> +	ulong cr8;
> +
> +	u16 cs;
> +	u16 ss;
> +	u16 ds;
> +	u16 es;
> +	u16 fs;
> +	u16 gs;
> +
> +	u16 gdt_fill;
> +	struct desc_ptr gdtr;
> +	char idt_fill[6];
> +	struct desc_ptr idtr;
> +
> +	u64 gsbase;
> +	u64 efer;
> +	u64 pat;
> +};
> +static struct hv_crash_ctxt hv_crash_ctxt;
> +
> +/* Shared hypervisor page that contains crash dump area we peek into.
> + * NB: windbg looks for "hv_cda" symbol so don't change it.
> + */
> +static struct hv_crashdump_area *hv_cda;
> +
> +static u32 trampoline_pa, devirt_cr3arg;
> +static atomic_t crash_cpus_wait;
> +static void *hv_crash_ptpgs[4];
> +static int hv_has_crashed, lx_has_crashed;

These are conceptually "bool" as well.

> +
> +/* This cannot be inlined as it needs stack */
> +static noinline __noclone void hv_crash_restore_tss(void)
> +{
> +	load_TR_desc();
> +}
> +
> +/* This cannot be inlined as it needs stack */
> +static noinline void hv_crash_clear_kernpt(void)
> +{
> +	pgd_t *pgd;
> +	p4d_t *p4d;
> +
> +	/* Clear entry so it's not confusing to someone looking at the core */
> +	pgd =3D pgd_offset_k(trampoline_pa);
> +	p4d =3D p4d_offset(pgd, trampoline_pa);
> +	native_p4d_clear(p4d);
> +}
> +
> +/*
> + * This is the C entry point from the asm glue code after the devirt hyp=
ercall.
> + * We enter here in IA32-e long mode, ie, full 64bit mode running on ker=
nel
> + * page tables with our below 4G page identity mapped, but using a tempo=
rary
> + * GDT. ds/fs/gs/es are null. ss is not usable. bp is null. stack is not
> + * available. We restore kernel GDT, and rest of the context, and contin=
ue
> + * to kexec.
> + */
> +static asmlinkage void __noreturn hv_crash_c_entry(void)
> +{
> +	struct hv_crash_ctxt *ctxt =3D &hv_crash_ctxt;
> +
> +	/* first thing, restore kernel gdt */
> +	native_load_gdt(&ctxt->gdtr);
> +
> +	asm volatile("movw %%ax, %%ss" : : "a"(ctxt->ss));
> +	asm volatile("movq %0, %%rsp" : : "m"(ctxt->rsp));
> +
> +	asm volatile("movw %%ax, %%ds" : : "a"(ctxt->ds));
> +	asm volatile("movw %%ax, %%es" : : "a"(ctxt->es));
> +	asm volatile("movw %%ax, %%fs" : : "a"(ctxt->fs));
> +	asm volatile("movw %%ax, %%gs" : : "a"(ctxt->gs));
> +
> +	native_wrmsrq(MSR_IA32_CR_PAT, ctxt->pat);
> +	asm volatile("movq %0, %%cr0" : : "r"(ctxt->cr0));
> +
> +	asm volatile("movq %0, %%cr8" : : "r"(ctxt->cr8));
> +	asm volatile("movq %0, %%cr4" : : "r"(ctxt->cr4));
> +	asm volatile("movq %0, %%cr2" : : "r"(ctxt->cr4));
> +
> +	native_load_idt(&ctxt->idtr);
> +	native_wrmsrq(MSR_GS_BASE, ctxt->gsbase);
> +	native_wrmsrq(MSR_EFER, ctxt->efer);
> +
> +	/* restore the original kernel CS now via far return */
> +	asm volatile("movzwq %0, %%rax\n\t"
> +		     "pushq %%rax\n\t"
> +		     "pushq $1f\n\t"
> +		     "lretq\n\t"
> +		     "1:nop\n\t" : : "m"(ctxt->cs) : "rax");
> +
> +	/* We are in asmlinkage without stack frame, hence make a C function
> +	 * call which will buy stack frame to restore the tss or clear PT entry=
.
> +	 */
> +	hv_crash_restore_tss();
> +	hv_crash_clear_kernpt();
> +
> +	/* we are now fully in devirtualized normal kernel mode */
> +	__crash_kexec(NULL);

The comments for __crash_kexec() say that "panic_cpu" should be set to
the current CPU. I don't see that such is the case here.

> +
> +	for (;;)
> +		cpu_relax();

Is the intent that __crash_kexec() should never return, on any of the vCPUs=
,
because devirtualization isn't done unless there's a valid kdump image load=
ed?
I wonder if

	native_wrmsrq(HV_X64_MSR_RESET, 1);

would be better than looping forever in case __crash_kexec() fails
somewhere along the way even if there's a kdump image loaded.

> +}
> +/* Tell gcc we are using lretq long jump in the above function intention=
ally */
> +STACK_FRAME_NON_STANDARD(hv_crash_c_entry);
> +
> +static void hv_mark_tss_not_busy(void)
> +{
> +	struct desc_struct *desc =3D get_current_gdt_rw();
> +	tss_desc tss;
> +
> +	memcpy(&tss, &desc[GDT_ENTRY_TSS], sizeof(tss_desc));
> +	tss.type =3D 0x9;        /* available 64-bit TSS. 0xB is busy TSS */
> +	write_gdt_entry(desc, GDT_ENTRY_TSS, &tss, DESC_TSS);
> +}
> +
> +/* Save essential context */
> +static void hv_hvcrash_ctxt_save(void)
> +{
> +	struct hv_crash_ctxt *ctxt =3D &hv_crash_ctxt;
> +
> +	asm volatile("movq %%rsp,%0" : "=3Dm"(ctxt->rsp));
> +
> +	ctxt->cr0 =3D native_read_cr0();
> +	ctxt->cr4 =3D native_read_cr4();
> +
> +	asm volatile("movq %%cr2, %0" : "=3Da"(ctxt->cr2));
> +	asm volatile("movq %%cr8, %0" : "=3Da"(ctxt->cr8));
> +
> +	asm volatile("movl %%cs, %%eax" : "=3Da"(ctxt->cs));
> +	asm volatile("movl %%ss, %%eax" : "=3Da"(ctxt->ss));
> +	asm volatile("movl %%ds, %%eax" : "=3Da"(ctxt->ds));
> +	asm volatile("movl %%es, %%eax" : "=3Da"(ctxt->es));
> +	asm volatile("movl %%fs, %%eax" : "=3Da"(ctxt->fs));
> +	asm volatile("movl %%gs, %%eax" : "=3Da"(ctxt->gs));
> +
> +	native_store_gdt(&ctxt->gdtr);
> +	store_idt(&ctxt->idtr);
> +
> +	ctxt->gsbase =3D __rdmsr(MSR_GS_BASE);
> +	ctxt->efer =3D __rdmsr(MSR_EFER);
> +	ctxt->pat =3D __rdmsr(MSR_IA32_CR_PAT);
> +}
> +
> +/* Add trampoline page to the kernel pagetable for transition to kernel =
PT */
> +static void hv_crash_fixup_kernpt(void)
> +{
> +	pgd_t *pgd;
> +	p4d_t *p4d;
> +
> +	pgd =3D pgd_offset_k(trampoline_pa);
> +	p4d =3D p4d_offset(pgd, trampoline_pa);
> +
> +	/* trampoline_pa is below 4G, so no pre-existing entry to clobber */
> +	p4d_populate(&init_mm, p4d, (pud_t *)hv_crash_ptpgs[1]);
> +	p4d->p4d =3D p4d->p4d & ~(_PAGE_NX);    /* enable execute */
> +}
> +
> +/*
> + * Now that all cpus are in nmi and spinning, we notify the hyp that lin=
ux has
> + * crashed and will collect core. This will cause the hyp to quiesce and
> + * suspend all VPs except the bsp. Called if linux crashed and not the h=
yp.
> + */
> +static void hv_notify_prepare_hyp(void)
> +{
> +	u64 status;
> +	struct hv_input_notify_partition_event *input;
> +	struct hv_partition_event_root_crashdump_input *cda;
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	cda =3D &input->input.crashdump_input;

The code ordering here is a bit weird. I'd expect this line to be grouped
with cda->crashdump_action being set.

> +	memset(input, 0, sizeof(*input));
> +	input->event =3D HV_PARTITION_EVENT_ROOT_CRASHDUMP;
> +
> +	cda->crashdump_action =3D HV_CRASHDUMP_ENTRY;
> +	status =3D hv_do_hypercall(HVCALL_NOTIFY_PARTITION_EVENT, input, NULL);
> +	if (!hv_result_success(status))
> +		return;
> +
> +	cda->crashdump_action =3D HV_CRASHDUMP_SUSPEND_ALL_VPS;
> +	hv_do_hypercall(HVCALL_NOTIFY_PARTITION_EVENT, input, NULL);
> +}
> +
> +/*
> + * Common function for all cpus before devirtualization.
> + *
> + * Hypervisor crash: all cpus get here in nmi context.
> + * Linux crash: the panicing cpu gets here at base level, all others in =
nmi
> + *		context. Note, panicing cpu may not be the bsp.
> + *
> + * The function is not inlined so it will show on the stack. It is named=
 so
> + * because the crash cmd looks for certain well known function names on =
the
> + * stack before looking into the cpu saved note in the elf section, and
> + * that work is currently incomplete.
> + *
> + * Notes:
> + *  Hypervisor crash:
> + *    - the hypervisor is in a very restrictive mode at this point and a=
ny
> + *	vmexit it cannot handle would result in reboot. For example, console
> + *	output from here would result in synic ipi hcall, which would result
> + *	in reboot. So, no mumbo jumbo, just get to kexec as quickly as possib=
le.
> + *
> + *  Devirtualization is supported from the bsp only.
> + */
> +static noinline __noclone void crash_nmi_callback(struct pt_regs *regs)
> +{
> +	struct hv_input_disable_hyp_ex *input;
> +	u64 status;
> +	int msecs =3D 1000, ccpu =3D smp_processor_id();
> +
> +	if (ccpu =3D=3D 0) {
> +		/* crash_save_cpu() will be done in the kexec path */
> +		cpu_emergency_stop_pt();	/* disable performance trace */
> +		atomic_inc(&crash_cpus_wait);
> +	} else {
> +		crash_save_cpu(regs, ccpu);
> +		cpu_emergency_stop_pt();	/* disable performance trace */
> +		atomic_inc(&crash_cpus_wait);
> +		for (;;);			/* cause no vmexits */
> +	}
> +
> +	while (atomic_read(&crash_cpus_wait) < num_online_cpus() && msecs--)
> +		mdelay(1);
> +
> +	stop_nmi();
> +	if (!hv_has_crashed)
> +		hv_notify_prepare_hyp();
> +
> +	if (crashing_cpu =3D=3D -1)
> +		crashing_cpu =3D ccpu;		/* crash cmd uses this */

Could just be "crashing_cpu =3D 0" since only the BSP gets here.

> +
> +	hv_hvcrash_ctxt_save();
> +	hv_mark_tss_not_busy();
> +	hv_crash_fixup_kernpt();
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->rip =3D trampoline_pa;	/* PA of hv_crash_asm32 */
> +	input->arg =3D devirt_cr3arg;	/* PA of trampoline page table L4 */

Is this comment correct? Isn't it the PA of struct hv_crash_tramp_data?
And just for clarification, Hyper-V treats this "arg" value as opaque and d=
oes
not access it. It only provides it in EDI when it invokes the trampoline
function, right?

> +
> +	status =3D hv_do_hypercall(HVCALL_DISABLE_HYP_EX, input, NULL);
> +
> +	/* Devirt failed, just reboot as things are in very bad state now */
> +	native_wrmsrq(HV_X64_MSR_RESET, 1);    /* get hv to reboot */
> +}
> +
> +/*
> + * Generic nmi callback handler: could be called without any crash also.
> + *   hv crash: hypervisor injects nmi's into all cpus
> + *   lx crash: panicing cpu sends nmi to all but self via crash_stop_oth=
er_cpus
> + */
> +static int hv_crash_nmi_local(unsigned int cmd, struct pt_regs *regs)
> +{
> +	int ccpu =3D smp_processor_id();
> +
> +	if (!hv_has_crashed && hv_cda && hv_cda->cda_valid)
> +		hv_has_crashed =3D 1;
> +
> +	if (!hv_has_crashed && !lx_has_crashed)
> +		return NMI_DONE;	/* ignore the nmi */
> +
> +	if (hv_has_crashed) {
> +		if (!kexec_crash_loaded() || !hv_crash_enabled) {
> +			if (ccpu =3D=3D 0) {
> +				native_wrmsrq(HV_X64_MSR_RESET, 1); /* reboot */
> +			} else
> +				for (;;);	/* cause no vmexits */
> +		}
> +	}
> +
> +	crash_nmi_callback(regs);
> +
> +	return NMI_DONE;

crash_nmi_callback() should never return, right? Normally one would
expect to return NMI_HANDLED here, but I guess it doesn't matter
if the return is never executed.

> +}
> +
> +/*
> + * hv_crash_stop_other_cpus() =3D=3D smp_ops.crash_stop_other_cpus
> + *
> + * On normal linux panic, this is called twice: first from panic and the=
n again
> + * from native_machine_crash_shutdown.
> + *
> + * In case of mshv, 3 ways to get here:
> + *  1. hv crash (only bsp will get here):
> + *	BSP : nmi callback -> DisableHv -> hv_crash_asm32 -> hv_crash_c_entry
> + *		  -> __crash_kexec -> native_machine_crash_shutdown
> + *		  -> crash_smp_send_stop -> smp_ops.crash_stop_other_cpus
> + *  linux panic:
> + *	2. panic cpu x: panic() -> crash_smp_send_stop
> + *				     -> smp_ops.crash_stop_other_cpus
> + *	3. bsp: native_machine_crash_shutdown -> crash_smp_send_stop
> + *
> + * NB: noclone and non standard stack because of call to crash_setup_reg=
s().
> + */
> +static void __noclone hv_crash_stop_other_cpus(void)
> +{
> +	static int crash_stop_done;
> +	struct pt_regs lregs;
> +	int ccpu =3D smp_processor_id();
> +
> +	if (hv_has_crashed)
> +		return;		/* all cpus already in nmi handler path */
> +
> +	if (!kexec_crash_loaded())
> +		return;

If we're in a normal panic path (your Case #2 above) with no kdump kernel
loaded, why leave the other vCPUs running? Seems like that could violate
expectations in vpanic(), where it calls panic_other_cpus_shutdown() and
thereafter assumes other vCPUs are not running.

> +
> +	if (crash_stop_done)
> +		return;
> +	crash_stop_done =3D 1;

Is crash_stop_done necessary?  hv_crash_stop_other_cpus() is called
from crash_smp_send_stop(), which has its own static variable=20
"cpus_stopped" that does the same thing.

> +
> +	/* linux has crashed: hv is healthy, we can ipi safely */
> +	lx_has_crashed =3D 1;
> +	wmb();			/* nmi handlers look at lx_has_crashed */
> +
> +	apic->send_IPI_allbutself(NMI_VECTOR);

The default .crash_stop_other_cpus function is kdump_nmi_shootdown_cpus().
In addition to sending the NMI IPI, it does disable_local_APIC(). I don't k=
now, but
should disable_local_APIC() be done somewhere here as well?

> +
> +	if (crashing_cpu =3D=3D -1)
> +		crashing_cpu =3D ccpu;		/* crash cmd uses this */
> +
> +	/* crash_setup_regs() happens in kexec also, but for the kexec cpu whic=
h
> +	 * is the bsp. We could be here on non-bsp cpu, collect regs if so.
> +	 */
> +	if (ccpu)
> +		crash_setup_regs(&lregs, NULL);
> +
> +	crash_nmi_callback(&lregs);
> +}
> +STACK_FRAME_NON_STANDARD(hv_crash_stop_other_cpus);
> +
> +/* This GDT is accessed in IA32-e compat mode which uses 32bits addresse=
s */
> +struct hv_gdtreg_32 {
> +	u16 fill;
> +	u16 limit;
> +	u32 address;
> +} __packed;
> +
> +/* We need a CS with L bit to goto IA32-e long mode from 32bit compat mo=
de */
> +struct hv_crash_tramp_gdt {
> +	u64 null;	/* index 0, selector 0, null selector */
> +	u64 cs64;	/* index 1, selector 8, cs64 selector */
> +} __packed;
> +
> +/* No stack, so jump via far ptr in memory to load the 64bit CS */
> +struct hv_cs_jmptgt {
> +	u32 address;
> +	u16 csval;
> +	u16 fill;
> +} __packed;
> +
> +/* This trampoline data is copied onto the trampoline page after the asm=
 code */
> +struct hv_crash_tramp_data {
> +	u64 tramp32_cr3;
> +	u64 kernel_cr3;
> +	struct hv_gdtreg_32 gdtr32;
> +	struct hv_crash_tramp_gdt tramp_gdt;
> +	struct hv_cs_jmptgt cs_jmptgt;
> +	u64 c_entry_addr;
> +} __packed;
> +
> +/*
> + * Setup a temporary gdt to allow the asm code to switch to the long mod=
e.
> + * Since the asm code is relocated/copied to a below 4G page, it cannot =
use rip
> + * relative addressing, hence we must use trampoline_pa here. Also, save=
 other
> + * info like jmp and C entry targets for same reasons.
> + *
> + * Returns: 0 on success, -1 on error
> + */
> +static int hv_crash_setup_trampdata(u64 trampoline_va)
> +{
> +	int size, offs;
> +	void *dest;
> +	struct hv_crash_tramp_data *tramp;
> +
> +	/* These must match exactly the ones in the corresponding asm file */
> +	BUILD_BUG_ON(offsetof(struct hv_crash_tramp_data, tramp32_cr3) !=3D 0);
> +	BUILD_BUG_ON(offsetof(struct hv_crash_tramp_data, kernel_cr3) !=3D 8);
> +	BUILD_BUG_ON(offsetof(struct hv_crash_tramp_data, gdtr32.limit) !=3D 18=
);
> +	BUILD_BUG_ON(offsetof(struct hv_crash_tramp_data,
> +						     cs_jmptgt.address) !=3D 40);

It would be nice to pick up the constants from a #include file that is
shared with the asm code in Patch 4 of the series.

> +
> +	/* hv_crash_asm_end is beyond last byte by 1 */
> +	size =3D &hv_crash_asm_end - &hv_crash_asm32;
> +	if (size + sizeof(struct hv_crash_tramp_data) > PAGE_SIZE) {
> +		pr_err("%s: trampoline page overflow\n", __func__);
> +		return -1;
> +	}
> +
> +	dest =3D (void *)trampoline_va;
> +	memcpy(dest, &hv_crash_asm32, size);
> +
> +	dest +=3D size;
> +	dest =3D (void *)round_up((ulong)dest, 16);
> +	tramp =3D (struct hv_crash_tramp_data *)dest;
> +
> +	/* see MAX_ASID_AVAILABLE in tlb.c: "PCID 0 is reserved for use by
> +	 * non-PCID-aware users". Build cr3 with pcid 0
> +	 */
> +	tramp->tramp32_cr3 =3D __sme_pa(hv_crash_ptpgs[0]);
> +
> +	/* Note, when restoring X86_CR4_PCIDE, cr3[11:0] must be zero */
> +	tramp->kernel_cr3 =3D __sme_pa(init_mm.pgd);
> +
> +	tramp->gdtr32.limit =3D sizeof(struct hv_crash_tramp_gdt);
> +	tramp->gdtr32.address =3D trampoline_pa +
> +				   (ulong)&tramp->tramp_gdt - trampoline_va;
> +
> +	 /* base:0 limit:0xfffff type:b dpl:0 P:1 L:1 D:0 avl:0 G:1 */
> +	tramp->tramp_gdt.cs64 =3D 0x00af9a000000ffff;
> +
> +	tramp->cs_jmptgt.csval =3D 0x8;
> +	offs =3D (ulong)&hv_crash_asm64_lbl - (ulong)&hv_crash_asm32;
> +	tramp->cs_jmptgt.address =3D trampoline_pa + offs;
> +
> +	tramp->c_entry_addr =3D (u64)&hv_crash_c_entry;
> +
> +	devirt_cr3arg =3D trampoline_pa + (ulong)dest - trampoline_va;
> +
> +	return 0;
> +}
> +
> +/*
> + * Build 32bit trampoline page table for transition from protected mode
> + * non-paging to long-mode paging. This transition needs pagetables belo=
w 4G.
> + */
> +static void hv_crash_build_tramp_pt(void)
> +{
> +	p4d_t *p4d;
> +	pud_t *pud;
> +	pmd_t *pmd;
> +	pte_t *pte;
> +	u64 pa, addr =3D trampoline_pa;
> +
> +	p4d =3D hv_crash_ptpgs[0] + pgd_index(addr) * sizeof(p4d);
> +	pa =3D virt_to_phys(hv_crash_ptpgs[1]);
> +	set_p4d(p4d, __p4d(_PAGE_TABLE | pa));
> +	p4d->p4d &=3D ~(_PAGE_NX);	/* disable no execute */
> +
> +	pud =3D hv_crash_ptpgs[1] + pud_index(addr) * sizeof(pud);
> +	pa =3D virt_to_phys(hv_crash_ptpgs[2]);
> +	set_pud(pud, __pud(_PAGE_TABLE | pa));
> +
> +	pmd =3D hv_crash_ptpgs[2] + pmd_index(addr) * sizeof(pmd);
> +	pa =3D virt_to_phys(hv_crash_ptpgs[3]);
> +	set_pmd(pmd, __pmd(_PAGE_TABLE | pa));
> +
> +	pte =3D hv_crash_ptpgs[3] + pte_index(addr) * sizeof(pte);
> +	set_pte(pte, pfn_pte(addr >> PAGE_SHIFT, PAGE_KERNEL_EXEC));
> +}
> +
> +/*
> + * Setup trampoline for devirtualization:
> + *  - a page below 4G, ie 32bit addr containing asm glue code that mshv =
jmps to
> + *    in protected mode.
> + *  - 4 pages for a temporary page table that asm code uses to turn pagi=
ng on
> + *  - a temporary gdt to use in the compat mode.
> + *
> + *  Returns: 0 on success
> + */
> +static int hv_crash_trampoline_setup(void)
> +{
> +	int i, rc, order;
> +	struct page *page;
> +	u64 trampoline_va;
> +	gfp_t flags32 =3D GFP_KERNEL | GFP_DMA32 | __GFP_ZERO;
> +
> +	/* page for 32bit trampoline assembly code + hv_crash_tramp_data */
> +	page =3D alloc_page(flags32);
> +	if (page =3D=3D NULL) {
> +		pr_err("%s: failed to alloc asm stub page\n", __func__);
> +		return -1;
> +	}
> +
> +	trampoline_va =3D (u64)page_to_virt(page);
> +	trampoline_pa =3D (u32)page_to_phys(page);
> +
> +	order =3D 2;	   /* alloc 2^2 pages */
> +	page =3D alloc_pages(flags32, order);
> +	if (page =3D=3D NULL) {
> +		pr_err("%s: failed to alloc pt pages\n", __func__);
> +		free_page(trampoline_va);
> +		return -1;
> +	}
> +
> +	for (i =3D 0; i < 4; i++, page++)
> +		hv_crash_ptpgs[i] =3D page_to_virt(page);
> +
> +	hv_crash_build_tramp_pt();
> +
> +	rc =3D hv_crash_setup_trampdata(trampoline_va);
> +	if (rc)
> +		goto errout;
> +
> +	return 0;
> +
> +errout:
> +	free_page(trampoline_va);
> +	free_pages((ulong)hv_crash_ptpgs[0], order);
> +
> +	return rc;
> +}
> +
> +/* Setup for kdump kexec to collect hypervisor ram when running as mshv =
root */
> +void hv_root_crash_init(void)
> +{
> +	int rc;
> +	struct hv_input_get_system_property *input;
> +	struct hv_output_get_system_property *output;
> +	unsigned long flags;
> +	u64 status;
> +	union hv_pfn_range cda_info;
> +
> +	if (pgtable_l5_enabled()) {
> +		pr_err("Hyper-V: crash dump not yet supported on 5level PTs\n");
> +		return;
> +	}
> +
> +	rc =3D register_nmi_handler(NMI_LOCAL, hv_crash_nmi_local, NMI_FLAG_FIR=
ST,
> +				  "hv_crash_nmi");
> +	if (rc) {
> +		pr_err("Hyper-V: failed to register crash nmi handler\n");
> +		return;
> +	}
> +
> +	local_irq_save(flags);
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> +
> +	memset(input, 0, sizeof(*input));
> +	memset(output, 0, sizeof(*output));

Why zero the output area? This is one of those hypercall things that we're
inconsistent about. A few hypercall call sites zero the output area, and it=
's
not clear why they do. Hyper-V should be responsible for properly filling i=
n
the output area. Linux should not need to do this zero'ing, unless there's =
some
known bug in Hyper-V for certain hypercalls, in which case there should be
a code comment stating "why".

> +	input->property_id =3D HV_SYSTEM_PROPERTY_CRASHDUMPAREA;
> +
> +	status =3D hv_do_hypercall(HVCALL_GET_SYSTEM_PROPERTY, input, output);
> +	cda_info.as_uint64 =3D output->hv_cda_info.as_uint64;
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status)) {
> +		pr_err("Hyper-V: %s: property:%d %s\n", __func__,
> +		       input->property_id, hv_result_to_string(status));
> +		goto err_out;
> +	}
> +
> +	if (cda_info.base_pfn =3D=3D 0) {
> +		pr_err("Hyper-V: hypervisor crash dump area pfn is 0\n");
> +		goto err_out;
> +	}
> +
> +	hv_cda =3D phys_to_virt(cda_info.base_pfn << PAGE_SHIFT);

Use HV_HYP_PAGE_SHIFT, since PFNs provided by Hyper-V are always in
terms of the Hyper-V page size, which isn't necessarily the guest page size=
.=20
Yes, on x86 there's no difference, but for future robustness ....

> +
> +	rc =3D hv_crash_trampoline_setup();
> +	if (rc)
> +		goto err_out;
> +
> +	smp_ops.crash_stop_other_cpus =3D hv_crash_stop_other_cpus;
> +
> +	crash_kexec_post_notifiers =3D true;
> +	hv_crash_enabled =3D 1;
> +	pr_info("Hyper-V: linux and hv kdump support enabled\n");

This message and the message below aren't consistent. One refers
to "hv kdump" and the other to "hyp kdump".

> +
> +	return;
> +
> +err_out:
> +	unregister_nmi_handler(NMI_LOCAL, "hv_crash_nmi");
> +	pr_err("Hyper-V: only linux (but not hyp) kdump support enabled\n");
> +}
> --
> 2.36.1.vfs.0.0
>=20


