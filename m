Return-Path: <linux-arch+bounces-13634-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9057CB58412
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 19:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AC032A1699
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 17:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FB42BD016;
	Mon, 15 Sep 2025 17:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ccwrt/Q6"
X-Original-To: linux-arch@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012053.outbound.protection.outlook.com [52.103.2.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7D719ABD8;
	Mon, 15 Sep 2025 17:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757958922; cv=fail; b=nI0CJR/FDfngSZFT+O5KtxA68lxf8+YVa62C7M3CGF9pc9mDrTccDrFpZ7K1pJXGglCjJLTg4026UDR6EfnyBDn3cWsDVUYiB0WFYeRh+7v/b2eTvu91CrQqZZIcI7KCThuNJlkRhZuiRQrFOK/LiwGLyE6L5zMesnuvpX6safs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757958922; c=relaxed/simple;
	bh=qdeGbb9F9o4p3/mUuUQ6Xp1ttYFePubrvIRVmN/whhc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hmvXgKktr+M94EMLNFYft3rOkPNA1yclkIjnLr6ADIqATcGuEUBX2fqe8Kb0b3g0an6YdzrnMt7VY3m7COccQfILpJhRGqETLDUbUcUBRt7fo/olkQvpAPGWQLwtp2T1LRxW7egaIRlBxcSsP5Igg+m/F8ozUdT1bjbLxjrT8qY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ccwrt/Q6; arc=fail smtp.client-ip=52.103.2.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFyb87xmQPhIsKVFHU47RD3Sw0gckyMRl7UCYoqR4eocemyzAjpTAx5aUoQwly9NXsLVFXGdHr+ZHjKC1s8PPcqT9XbhSSupqMcJNbF4Kh3oKADOobF/5EXC3TvERkbcp3bDEUygWxHft2bDg+dPxrGjCwMYkRZ68ewGCkgr8lEh4cl42zxjdb28bexelIvaXCcl4Lknl5/VR6m0oh9LWdctZo77nck2ADLURlsAztql9v8LYAIP4RFNKrfGMK2X8ztPIp9ChClClAKvTZjzxgYVGWREJiWlid645t8AUvd9TZSQayQuXWNqtozrGdPa3kimFDXzlREEabDQo8wEQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFeLlBPRBUWr1RhG2TsXaWJzdSzcdzkCimUjgup9zWk=;
 b=hvdTF567OMiine8bs2phmMgwLdvWjXSIWoeoYPv1jRt7xW5f081T+Ut8fYZoZ8n8IX4ZaBSFy6cJQhc4dkDt32822ZbfwwlqbIJLpWWmNZ9nFgmT7bAL/nrS/cCF7a1uUUyXGYych2/KrgmWFXSrtJqjCG4+/LeBzG8AXMw8fkzRvJYP+QkNXqrqhBY0VvywNYgvXD7OkOaiAAGK/l5teyWz0LM3JqJ2GOG3QM/5FJKh515C9ULH9MLCjT2bhzI19Ds5rMojrTlN3REG49qWkgiEy0JWpKoBfxS6G3WshNWTqVOJaszac6ppO+Vi1cyfNnVDxjpTBVygJuD7zmhE8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFeLlBPRBUWr1RhG2TsXaWJzdSzcdzkCimUjgup9zWk=;
 b=ccwrt/Q6E286TOeOTrbB38ma8ieBZVkOjFrhhQXZ2YalZ2OAi//y3HNXdn1HQiAH86VpMC9k61/UlgVFBM2pQLCeChP0oD9XU5coyiPDoMgDqqHSt/QE/xpX1vQVRCUE8q4AYMWtSiM0c9O9579aaGbuQlfu48y+06S7z4tPrtEJj0tYR1CBm5YoXnru79xIFiV+2xsxknAujIRKtvZxzMqZn9xNBsiN5y7tjCPbhe8vcva6y0xBxujp4sCvEpfTrwQ3l2YZYQbOMu0mYE8f/7posxWVswzBXqA8zhhCr0nh7CDgHagjcv6w7zFhFsSypJsD9xgQ1slBZcZG0edN7g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV3PR02MB10056.namprd02.prod.outlook.com (2603:10b6:408:19a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 17:55:16 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 17:55:16 +0000
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
Subject: RE: [PATCH v1 4/6] x86/hyperv: Add trampoline asm code to transition
 from hypervisor
Thread-Topic: [PATCH v1 4/6] x86/hyperv: Add trampoline asm code to transition
 from hypervisor
Thread-Index: AQHcIed7U5ohN25fCEyUdB67GAYSdLSSxdog
Date: Mon, 15 Sep 2025 17:55:16 +0000
Message-ID:
 <SN6PR02MB41570D14679ED23C930878CCD415A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250910001009.2651481-1-mrathor@linux.microsoft.com>
 <20250910001009.2651481-5-mrathor@linux.microsoft.com>
In-Reply-To: <20250910001009.2651481-5-mrathor@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV3PR02MB10056:EE_
x-ms-office365-filtering-correlation-id: 7435b001-4672-45ae-6daa-08ddf4810737
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|41001999006|8062599012|8060799015|461199028|19110799012|13091999003|31061999003|3412199025|440099028|40105399003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?uyfRs/6kkcSH6WmTBtkAFb8mTdR5NP0FSyDckkVLk0q/AkzNpQx/Z98CYfbx?=
 =?us-ascii?Q?OV5YxCEIfMwl2AzoUpsd2gMQNWQAkVaye8ED7P6MhumIbvUGIlYdmZTwjngL?=
 =?us-ascii?Q?RSEH5/ZiUCswfbSglqvzsms39mDXsX9JUBBMctyfF3GHVYJ6BM2vpwQGpApq?=
 =?us-ascii?Q?l5yhKtExgY+6hu4X80HInGdfnpoNTT9alxqv2/vSmmc6xWMpIw5IRxahcBs2?=
 =?us-ascii?Q?p1ZbbGy/K4q8Z4WX7OJFhZ5LCVqQd3YJHF7lP+TRidEDVYlC+C6x0oRzHxjR?=
 =?us-ascii?Q?1JBn70J53bHWMidfVK+4t3X4pZ8/bBO6HddXLf60QHHIOm9ufL50FgIKElr2?=
 =?us-ascii?Q?syHLlf618LA/XLgUZO5t//Dlz5TRQwGNEzpP0ziNKI4vtbOVyOCNlWtSzzOb?=
 =?us-ascii?Q?i6ieI++CEXEZ0LOZ/R7fcZUWMKQqByhcC5+bR+0YWdVdnTa2Pqu/eGReqHqT?=
 =?us-ascii?Q?DtrUgbVNKxn1bXXOjvcnl5vBVvWN0xCp73EvvTA0Qm/xjYMiTF62RujgGIWE?=
 =?us-ascii?Q?/NhCBbblMM+c1TKznZzIu+8pPo6yNQ5SHIBRzSTtBFMmNZGav62lmOcLtLK6?=
 =?us-ascii?Q?KuvN8pO2sZFiaMUrwSh/RXjCPhgAoJOb4wmiC+MSL34RT6h24iYsJGERSAtJ?=
 =?us-ascii?Q?LZwKh6drmyUhekxuLq54UvzCnWp6hIzPiRs+Y0LWNJ1asXf1fdAZlXGmM91L?=
 =?us-ascii?Q?AX64hXImuaRttYvhQvnQbCCqcupq2mJFha1yQYZAPNSCA/mmpx/Jgr3VEL7n?=
 =?us-ascii?Q?qxuBA6l82AW2wLFngr7gWmQ09IehImBeaR8Bpm1R95mJPShjeiY+k8UYoehZ?=
 =?us-ascii?Q?FixH5VGvBbc/cPv2CCfmBCf+b6oq4yifLvtZKfP1Al36Ch16IVkkLjUIJ6bT?=
 =?us-ascii?Q?zuOKxpsgFilS962rZf9TdpJl+XKQqR5J6cw8p8mcwVlaJfaRYW08c8E3WJjK?=
 =?us-ascii?Q?MLNVbZS2kLRNTDihwfx9EoCAn4VD+wJWAUQfSFtXkg/i8B5bJ5aJ3BpL/gA3?=
 =?us-ascii?Q?uSg9qprbdT0DubhAwYhEvBPfiQ3ukZGYFKHcTq46KF5x0Tw9ZDCt8LwtuLq2?=
 =?us-ascii?Q?hLbQgEUU65FP7JeGfjupzPeS2agkT9VzmNGyhdfxXWdqVkiSsinoUTthKoVJ?=
 =?us-ascii?Q?XPyYZeLOldOn7i+F0uqbmHQAFIEOqPxN0LIvyq/+2A1Zt78VFwsJFgyahekP?=
 =?us-ascii?Q?qaI6M39M00cTbrxiP5I0mCUE2n6ZglS7OehA0A=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KqJSD8hNvAPs6BjRg11YB6Kgxfw/f20OgGKgX4SKFLkaOrwr2lfhrOpM47Z5?=
 =?us-ascii?Q?XBGuoPe+0qDoUGOy9yDX+jjeGWn83kFls6Qi46tLOulbOHGnvrKSkXHZwFPi?=
 =?us-ascii?Q?L8avj5QroiJ3wRMqysSD0cXCtvy8SDk5a0E5lwVceLztfArM0NTpGj9t/rf5?=
 =?us-ascii?Q?7JI3Xc7o0arhnhRjTD3GFpS1tjKgLBkrFsGwS/En7A1vZx8P64cVMvnL29LK?=
 =?us-ascii?Q?dQfVlMC6ih46I0Y7u0xZ1JTDbuq2wjwfYxrAg1P7i4BOERUoLPFcMsp/erg0?=
 =?us-ascii?Q?zowFn2BGqPU2jDUSa5+rdBejD1/naV4ikSeC6CE4NmdlLFX0Xc6Z6k2eOm91?=
 =?us-ascii?Q?u1sbeh5Y5igpkjUgwVihrTRmqY1lXAuFH3NhuOLPE9OjinpiyxoOHzHnvnxJ?=
 =?us-ascii?Q?fclF3r41GMWDi19UVBGvSQj7VqZ1RHnPiw86aLh+mB+MitA48bEw4P4KyrJv?=
 =?us-ascii?Q?1EXlNkVeq+KCv+x5rdRyYrxllPiwPoxq8lULxV5zvD8/Bo9Xgwc3mue6MJ+3?=
 =?us-ascii?Q?kJTotIOHCKGbKAlHUmDAEd7n1K5GmKsSH9SHyOPVmiMIK6/+k/hGDrQwvLuc?=
 =?us-ascii?Q?g139vqGB5G9UGq8SIZb5yk7BRsCqcaU95awv0jUl+cbAu9UVBl9aKyggOOJw?=
 =?us-ascii?Q?DAdjSlj8ZtRWFVLFotCPUPu3GYQgiI18kYn3YE8OdXsYsoxiedI/IU6jFAQU?=
 =?us-ascii?Q?k4hG9ig0zD9oXD7/XvrSr8PE6E3LtCHELaoU9uKUHu60/wstlHI9O/0BIyr7?=
 =?us-ascii?Q?CMpSCMnk6plyw2OiH7FxJHo6zO8Xg0sggIMbToxwMe/F73oKEBhkDglfYTJ9?=
 =?us-ascii?Q?ssrhIT2YpJk7ouM6P9wFwx4n9eFss6743CYnNrKMyAK8i9/kOkyDtT8ndMw0?=
 =?us-ascii?Q?yObXHGhxu7NJxjcrnL71knF3c7th5TLSJoedaf0+jaaoSjPv7Pu8x+XCvZpt?=
 =?us-ascii?Q?tFSWIhcDY0ufWyipA9tsubN503J9QO62/YHrmwmPrSsd3FDkMhjDsdRyN6UD?=
 =?us-ascii?Q?rOY7NnS8kVLaJbbn/p8pVDIdBGt86LXyXtxuv2nUniE44Yj2al+Yka4AZ5/N?=
 =?us-ascii?Q?vErbze9XoeA4fTBCTnZPgx6KcRbLXxZVLb3NwVeT9JhlREWojaPhU2qzhMr6?=
 =?us-ascii?Q?FWRAirRPLmF9dbq+iMEJj/yWbsfYKe03IKje01iBm8kNTz9Al0f+gjoY4Wab?=
 =?us-ascii?Q?Dnd1vqya/tIyf3ewMbEllPRszAPhkoWXtS5RByU3O4bTpYBxNTPP2zpgTfo?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7435b001-4672-45ae-6daa-08ddf4810737
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2025 17:55:16.5422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10056

From: Mukesh Rathor <mrathor@linux.microsoft.com> Sent: Tuesday, September =
9, 2025 5:10 PM
>=20
> Introduce a small asm stub to transition from the hypervisor to linux

I'd argue for capitalizing "Linux" here and in other places in commit
text and code comments throughout this patch set.

> upon devirtualization.

In this patch and subsequent patches, you've used the phrase "upon
devirtualization", which seems a little vague to me. Does this mean
"when devirtualization is complete" or perhaps "when the hypervisor
completes devirtualization"? Since there's no spec on any of this,
being as precise as possible will help future readers.

>=20
> At a high level, during panic of either the hypervisor or the dom0 (aka
> root), the nmi handler asks hypervisor to devirtualize.

Suggest:

At a high level, during panic of either the hypervisor or Linux running
in dom0 (a.k.a. the root partition), the Linux NMI handler asks the
hypervisor to devirtualize.

> As part of that,
> the arguments include an entry point to return back to linux. This asm
> stub implements that entry point.
>=20
> The stub is entered in protected mode, uses temporary gdt and page table
> to enable long mode and get to kernel entry point which then restores ful=
l
> kernel context to resume execution to kexec.
>=20
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_trampoline.S | 105 ++++++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 arch/x86/hyperv/hv_trampoline.S
>=20
> diff --git a/arch/x86/hyperv/hv_trampoline.S b/arch/x86/hyperv/hv_trampol=
ine.S
> new file mode 100644
> index 000000000000..27a755401a42
> --- /dev/null
> +++ b/arch/x86/hyperv/hv_trampoline.S
> @@ -0,0 +1,105 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * X86 specific Hyper-V kdump/crash related code.

Add a qualification that this is for root partition only, and not for
general guests?

> + *
> + * Copyright (C) 2025, Microsoft, Inc.
> + *
> + */
> +#include <linux/linkage.h>
> +#include <asm/alternative.h>
> +#include <asm/msr.h>
> +#include <asm/processor-flags.h>
> +#include <asm/nospec-branch.h>
> +
> +/*
> + * void noreturn hv_crash_asm32(arg1)
> + *    arg1 =3D=3D edi =3D=3D 32bit PA of struct hv_crash_trdata

I think this is "struct hv_crash_tramp_data".

> + *
> + * The hypervisor jumps here upon devirtualization in protected mode. Th=
is
> + * code gets copied to a page in the low 4G ie, 32bit space so it can ru=
n
> + * in the protected mode. Hence we cannot use any compile/link time offs=
ets or
> + * addresses. It restores long mode via temporary gdt and page tables an=
d
> + * eventually jumps to kernel code entry at HV_CRASHDATA_OFFS_C_entry.
> + *
> + * PreCondition (ie, Hypervisor call back ABI):
> + *  o CR0 is set to 0x0021: PE(prot mode) and NE are set, paging is disa=
bled
> + *  o CR4 is set to 0x0
> + *  o IA32_EFER is set to 0x901 (SCE and NXE are set)
> + *  o EDI is set to the Arg passed to HVCALL_DISABLE_HYP_EX.
> + *  o CS, DS, ES, FS, GS are all initialized with a base of 0 and limit =
0xFFFF
> + *  o IDTR, TR and GDTR are initialized with a base of 0 and limit of 0x=
FFFF
> + *  o LDTR is initialized as invalid (limit of 0)
> + *  o MSR PAT is power on default.
> + *  o Other state/registers are cleared. All TLBs flushed.

Clarification about "Other state/registers are cleared":  What about
processor features that Linux may have enabled or disabled during its
initial boot? Are those still in the states Linux set? Or are they reset to
power-on defaults? For example, if Linux enabled x2apic, is x2apic
still enabled when the stub is entered?

> + *
> + * See Intel SDM 10.8.5

Hmmm. I downloaded the latest combined SDM, and section 10.8.5
in Volume 3A is about Microcode Update Resources, which doesn't
seem applicable here. Other volumes don't have a section 10.8.5.

> + */
> +
> +#define HV_CRASHDATA_OFFS_TRAMPCR3    0x0    /*	 0 */
> +#define HV_CRASHDATA_OFFS_KERNCR3     0x8    /*	 8 */
> +#define HV_CRASHDATA_OFFS_GDTRLIMIT  0x12    /* 18 */
> +#define HV_CRASHDATA_OFFS_CS_JMPTGT  0x28    /* 40 */
> +#define HV_CRASHDATA_OFFS_C_entry    0x30    /* 48 */

It seems like these offsets should go in a #include file along
with the definition of struct hv_crash_tramp_data. Then the
BUILD_BUG_ON() calls in hv_crash_setup_trampdata() could
check against these symbolic names instead of hardcoding
numbers that must match these.

> +#define HV_CRASHDATA_TRAMPOLINE_CS    0x8

This #define isn't used anywhere.

> +
> +	.text
> +	.code32
> +
> +SYM_CODE_START(hv_crash_asm32)
> +	UNWIND_HINT_UNDEFINED
> +	ANNOTATE_NOENDBR

No ENDBR here, presumably because this function is entered via other
than an indirect CALL or JMP instruction. Right?

> +	movl	$X86_CR4_PAE, %ecx
> +	movl	%ecx, %cr4
> +
> +	movl %edi, %ebx
> +	add $HV_CRASHDATA_OFFS_TRAMPCR3, %ebx
> +	movl %cs:(%ebx), %eax
> +	movl %eax, %cr3
> +
> +	# Setup EFER for long mode now.
> +	movl	$MSR_EFER, %ecx
> +	rdmsr
> +	btsl	$_EFER_LME, %eax
> +	wrmsr
> +
> +	# Turn paging on using the temp 32bit trampoline page table.
> +	movl %cr0, %eax
> +	orl $(X86_CR0_PG), %eax
> +	movl %eax, %cr0
> +
> +	/* since kernel cr3 could be above 4G, we need to be in the long mode
> +	 * before we can load 64bits of the kernel cr3. We use a temp gdt for
> +	 * that with CS.L=3D1 and CS.D=3D0 */
> +	mov %edi, %eax
> +	add $HV_CRASHDATA_OFFS_GDTRLIMIT, %eax
> +	lgdtl %cs:(%eax)
> +
> +	/* not done yet, restore CS now to switch to CS.L=3D1 */
> +	mov %edi, %eax
> +	add $HV_CRASHDATA_OFFS_CS_JMPTGT, %eax
> +	ljmp %cs:*(%eax)
> +SYM_CODE_END(hv_crash_asm32)
> +
> +	/* we now run in full 64bit IA32-e long mode, CS.L=3D1 and CS.D=3D0 */
> +	.code64
> +	.balign 8
> +SYM_CODE_START(hv_crash_asm64)
> +	UNWIND_HINT_UNDEFINED
> +	ANNOTATE_NOENDBR

But this *is* entered via an indirect JMP, right? So back to my
earlier question about the state of processor feature enablement.
If Linux enabled IBT, is it still enabled after devirtualization and
the hypervisor invokes this entry point? Linux guests on Hyper-V
have historically not enabled IBT, but patches that enable it are
now in linux-next, and will go into the 6.18 kernel. So maybe
this needs an ENDBR64.

> +SYM_INNER_LABEL(hv_crash_asm64_lbl, SYM_L_GLOBAL)
> +	/* restore kernel page tables so we can jump to kernel code */
> +	mov %edi, %eax
> +	add $HV_CRASHDATA_OFFS_KERNCR3, %eax
> +	movq %cs:(%eax), %rbx
> +	movq %rbx, %cr3
> +
> +	mov %edi, %eax
> +	add $HV_CRASHDATA_OFFS_C_entry, %eax
> +	movq %cs:(%eax), %rbx
> +	ANNOTATE_RETPOLINE_SAFE
> +	jmp *%rbx
> +
> +	int $3
> +
> +SYM_INNER_LABEL(hv_crash_asm_end, SYM_L_GLOBAL)
> +SYM_CODE_END(hv_crash_asm64)
> --
> 2.36.1.vfs.0.0
>=20


