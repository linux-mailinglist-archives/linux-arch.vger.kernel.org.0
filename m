Return-Path: <linux-arch+bounces-12971-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C535B13D8F
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jul 2025 16:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE42E3A4B27
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jul 2025 14:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7DC26E71A;
	Mon, 28 Jul 2025 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GWqra4aJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012063.outbound.protection.outlook.com [52.103.20.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFFB2222A1;
	Mon, 28 Jul 2025 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753713902; cv=fail; b=LlVG1jSOJoBfEw80H270i0r9hEBHO9+bu4Wml2bp+zi74tHcToVmLJ0zBiXR/h8bFiPFD7Iu+FLxKuKLq0TpM/gtZeA1zOxLZT2rH22+Rtl+k3Vfu2FDyAapbLBwCPX3ZcPR67FSpPlQkXENH0sFuFb+sN3BSm3gDvO0lcDboyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753713902; c=relaxed/simple;
	bh=xt9jXrOZJNY5/e7g7ugfixZrt8z4aFnrW279CUMpy10=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NLkbuCWXZkA9wfKPTjeVaqPy6Oc7JLriZ23eLu0gpb/66FMahA49L9eUbm+mDb/JqUecIrVo+Ha4qmzj2y3bWhUhFdSOOu881UxXTGuig4GD9qI882j/JSfNU5z0+LVEhuUA4y/Sc7YVOz/EP3FeM4FU3om4gnpI0key63x81xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GWqra4aJ; arc=fail smtp.client-ip=52.103.20.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DAeT9b8wKV0aoP6NlvvgpI6Q1iZDivJY4giH7S10oAzSw2DEtH06eD/gjv6ySPq+HFw34JvgNwPhMfEKz1s3M3rGMkv8EAXQ8NBbr7PdB3n267jJa3id7vLCApI8jZNUmYGYdoA3PQeWZsw7bsCRbwZyPNFZAHmlvQgb20/jgp3C5e0ZLNE1vnBa3K4fyRh4Bb3jlCHNG75xbOpi2WbgBIeTHqzvQqrzdIP5FOjSxSQt5jsT+PwppmHTmcfLev76SKAMJTSbaEgfgztv9vY9+uJbDAZ6AhrozQQexUpnGcNJO0A5fJ39MVugdiQJvgzzaOtSBv2kQd+oROyZwXXXXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdNYGjfOYCofdK/uvrSWIpDpKkEDHSmBjQA1gOJ5pH8=;
 b=ZYNgv3dBVWJxqPl3L48DGefsC+MQBIr/NQPf17/Oj26mtczh823zwAsgW8DuRSvDhBGKANHuO44kXA2Ah/JichsWZXRmBJDZc1pD3Xc8iej0Exq0E6OYLNf2ZfEuaHLO1LF4b63HfL1B3aM78KUK5G6RER0/vOsjcwWa+pY4yvFD0tnvBZku8kug5hKCy+KMcgjCfXI/rux7mc1bV+ZcSVu3mkL/7ckAOKKgHvZUg1b13Uv9fxRX2VJulgo7ax/+LKRYv1eGb74+upcuYg2C31prh7nHWauDUvPdF4Px3lpKYsyakp8Ss4bTPT1zwUWNmbg0yL1zO6rkl+lWHw5+Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdNYGjfOYCofdK/uvrSWIpDpKkEDHSmBjQA1gOJ5pH8=;
 b=GWqra4aJ34iiX4jSrBLQ0qTDTv3OWYTP8GhWIf1L7jD3woJyBFBWEdDsy/bPz7LUsG6iu1Oln1WqspLpccwhOkpvMUM7zeO5fgK8uLAxMrgYY4oxu07LTWGqUpb90DTzc1psFLoYmcymkVTgYUlqSSv0uHFca51O4U1Xklq9BFpHP36WNNa1P8RPyKF0yD1M1SFJE2L5DnJH1fPA6U37lHilr28eH5it4Jt88oNI2V1B5DVDOSjG6wnde1jC1mP0HjCBsA+r7mQ5XR5N7W1oQq5q/4hwgRfKud15SnfI93vHHaOcEz9Tfz742+dMkNm25IdEk+sB6ekiA1UPO7pWJg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7783.namprd02.prod.outlook.com (2603:10b6:510:59::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Mon, 28 Jul
 2025 14:44:58 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8964.023; Mon, 28 Jul 2025
 14:44:58 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Tianyu Lan <ltykernel@gmail.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "arnd@arndb.de"
	<arnd@arndb.de>, "Neeraj.Upadhyay@amd.com" <Neeraj.Upadhyay@amd.com>
CC: Tianyu Lan <tiala@microsoft.com>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH V4 2/4] drivers/hv: Allow vmbus message synic
 interrupt injected from Hyper-V
Thread-Topic: [RFC PATCH V4 2/4] drivers/hv: Allow vmbus message synic
 interrupt injected from Hyper-V
Thread-Index: AQHb/jNTZTuE56x7XE6DszFF6e/jZrRHmfcg
Date: Mon, 28 Jul 2025 14:44:58 +0000
Message-ID:
 <SN6PR02MB41575303B0EA2150B8089F35D45AA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250726134250.4414-1-ltykernel@gmail.com>
 <20250726134250.4414-3-ltykernel@gmail.com>
In-Reply-To: <20250726134250.4414-3-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7783:EE_
x-ms-office365-filtering-correlation-id: 5dfc28c5-22a2-4cc5-773b-08ddcde55349
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|8062599012|19110799012|8060799015|461199028|440099028|40105399003|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2UInnJURLDU//eRv5/E+d1Wum59VQ7BWuSmzAKOq04sqwZmZA4fstuX3dS9H?=
 =?us-ascii?Q?Pzk6y2XLtr1K8DYd44x8Krwsoa0EZGAZ6H8652Uds5fSWa3YQIGEUHaBw5U4?=
 =?us-ascii?Q?bwS+IfQ5TSJ5cfQx2wAGBJt2Lu9xgQRTIPYZLWHJ0iysHdyFJTbEeDc7nbh/?=
 =?us-ascii?Q?7B2NmL2m82hQSP1prhkrM5aizGemB5g8TN26cUuBVI7CPFQkkagacuNq9xiY?=
 =?us-ascii?Q?IeNMm4Aswitjx9NzUAxZ4SrR5DBaOxQq+HQNJEnp2/6OOOBusziAgAdwPDbf?=
 =?us-ascii?Q?+9TRKzMZGa+XRnzMRWHYCsiCH3F1BDZZUTe5EVNq3DILJPshPy5TvseeZ7rX?=
 =?us-ascii?Q?l3GhXLxkCMxXv00Rb8Zua25POug5dnQYfsmC1Zywm4sneIpwA4HytI9oHcZH?=
 =?us-ascii?Q?EDMXV1cIjTFJ4y5cKOIiboqWuFFqOGvX5kfTPNJcZ12SWRcAXj3vD9+CjS9L?=
 =?us-ascii?Q?EPJ/3t++P++nTyvtP0F0CvCsr8pPaRBDbbyftkHPO7WQD8XjT0J8BW/NJhKX?=
 =?us-ascii?Q?5t5ysFUfqSQS2KQbaCWlk8SuAN0LVfTei1M/OS+Qy2LMcWuMKQKm/tKctQPO?=
 =?us-ascii?Q?H9KQuWLd4lLZKllmDL2W6UQJcT5pkqaw5JpGMoUF7uc9y247B+5QOzU1LOKF?=
 =?us-ascii?Q?NuwawI4zECdchA13BHxzZ8S10c+ProGjDZvdDNIqCSxuFY6ELyZ+FFViXTm7?=
 =?us-ascii?Q?7iROgtnJ6h1Q5Gg9NG8Vn+jX/fgWvfnDVQdfasZV17lCPHvHpjvJt5EXcSOL?=
 =?us-ascii?Q?5ZXI/YFxEXg50ZhYwigzM67IuB9aCHXvWUNFqKl2/hViH0cIgKdD63XAvI1v?=
 =?us-ascii?Q?oU0U4nVP0QY3q4+Ac8GcR4ba5IAuQAjLPC3gFWxXpFznv0Q6IlqIEBcxcKQ1?=
 =?us-ascii?Q?Y0a+zIv8WOU4z+vfkbIWhx8ZPqdWb8dhaf6HZ8JCfWGjTTa91gLwXiF90dby?=
 =?us-ascii?Q?/8tkwXPaM5YuKosJzzm+e0LUbQc8XOM+/hECrRbsasWmP2L//dm0GXunMF4k?=
 =?us-ascii?Q?w3aCcnIaj3P8i0vaFsFksOxLE7wDhcJGtYf3E21V6kWYoYFf7t85FsRM0sJi?=
 =?us-ascii?Q?BhT/xwd3/Glv+vvVOcC80ZBEoXlAIwHnjiVxifEmivjZx/VvlOs=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Bv5rkgwFnsnosdnsbUIyy71ytKPTX4/flTk7GLFpfBbBXmL/PM/OKVfQrKRi?=
 =?us-ascii?Q?32jyNAQV5UtXUVWp0H6stiKrjU6q9CWezbbQtV4vu5mFcsNVQ195fgZesrUh?=
 =?us-ascii?Q?hfmC0uCpidTRHQER6jH20OfcbaRxuwhFxU62N1mJsFfiT1iYP38WWqPbDc/3?=
 =?us-ascii?Q?OjiUy5Zu9TNNKtgW1Usau0HjgUVmuvWBQ4oAjVPkpiv+14M34iYPAe7l6+B4?=
 =?us-ascii?Q?JFmTNR6id8nSilOAIr9uAGNXiNXpZe5duxBzAMqjKLq9uBQzLIdjYpcxwYYJ?=
 =?us-ascii?Q?2ZNSFF3rgd2F4a1NIUbmXmlDqfQWQwshynd46bGyo53lVZ0PPGaRTN1MIzTA?=
 =?us-ascii?Q?sD+0NFqzFFDhUoTmJxgTXDXT5XtZe528a6hKUHjsTCKCl35ywqSpxTncBYrQ?=
 =?us-ascii?Q?2cLTaGXmKqka9AvcBIYB61iz+3fJfOPPwmOl8jok2PguZcs/0zTBBh0NkqYf?=
 =?us-ascii?Q?TmYISBcFNEpX7wIVpgKX044m++BDvfTlZT3I5dnpuHjhnrad/ac4YowVgJRR?=
 =?us-ascii?Q?e3Zlg+5dL2eptxxjdrjLteCCkGFVB/LkUYYgvfjJtDJ+KVShIuivUvIHSSVz?=
 =?us-ascii?Q?f8RIDirB4RZkOMP4bkfZV1Rnpko1EeH2ef1XuGMck0k6wMD4Dr33MCB1+rFV?=
 =?us-ascii?Q?hdT7MfQj9NASwJBZn1UZ7SaPUoEmcD7B9Kgi1V+bhyqK6O7Q5/jeGFXaV1v7?=
 =?us-ascii?Q?h9XyN1lBHNqV9z3mC9dHSRTqYr6GUqNWE3Weru6Td4EL9o3Mg5W98g1CCzJW?=
 =?us-ascii?Q?V3/5gy2CIPQDYJKU2Emb8CYQrFsimvTSZriQ8Kay8CpRUuAHd4HlWujLMeEZ?=
 =?us-ascii?Q?3hPBW7YYzUInE0oAqC2VfXZWXrLJ8FgJryynrIsbs4/hH8XSd0fxASdY6O/6?=
 =?us-ascii?Q?B9WPKiNJZLGbgFYWkZTO7vH3qRhLqnWdeR9FpwXW97XVGhLIJtOVR5u66/c2?=
 =?us-ascii?Q?EidyhunVKcsXegvpiGyYog9AKtHnY3gEg87FcLApLtfRpniDyqw3y0fCjrhE?=
 =?us-ascii?Q?M++uJV78WlZBHk+MTYGD2rCQmF2M10v+NeW+4VNItDlbCjYxkMVYx+nkSb5W?=
 =?us-ascii?Q?nATN/RQEi7wxZVXJP6M4SRaG+oy/z6bwjj0BFEQSXCFEZyAINYwOBSb/cWTJ?=
 =?us-ascii?Q?DNSpSdJdaEWuox+oey4tcbMBFXaLYPju/Bwb6/pPY2d3fGniTpaWtkgNArXo?=
 =?us-ascii?Q?anmNXy7AUswj2pso0gonhJK4Oy0Ac1qEGHOSJ1dKLEWDVYMNTZ3JGly53do?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dfc28c5-22a2-4cc5-773b-08ddcde55349
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 14:44:58.4581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7783

From: Tianyu Lan <ltykernel@gmail.com> Sent: Saturday, July 26, 2025 6:43 A=
M
>=20

Nit: The patch "Subject:" prefix here should be "Drivers: hv:" with no slas=
h, as
it was in v3 of the patch. That's admittedly not consistent with "x86/hyper=
v:"
that is used for the other patches in this series, but it is consistent wit=
h historical
practice for the files in the drivers/hv folder. You have to look at past c=
ommits
for a particular file to see what the typical prefix is.

Michael

> When Secure AVIC is enabled, VMBus driver should
> call x2apic Secure AVIC interface to allow Hyper-V
> to inject VMBus message interrupt.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
> Change since RFC V3:
>        - Disable VMBus Message interrupt via hv_enable_
>        	 coco_interrupt() in the hv_synic_disable_regs().
> ---
>  arch/x86/hyperv/hv_apic.c      | 5 +++++
>  drivers/hv/hv.c                | 2 ++
>  drivers/hv/hv_common.c         | 5 +++++
>  include/asm-generic/mshyperv.h | 1 +
>  4 files changed, 13 insertions(+)
>=20
> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> index e669053b637d..a8de503def37 100644
> --- a/arch/x86/hyperv/hv_apic.c
> +++ b/arch/x86/hyperv/hv_apic.c
> @@ -53,6 +53,11 @@ static void hv_apic_icr_write(u32 low, u32 id)
>  	wrmsrq(HV_X64_MSR_ICR, reg_val);
>  }
>=20
> +void hv_enable_coco_interrupt(unsigned int cpu, unsigned int vector, boo=
l set)
> +{
> +	apic_update_vector(cpu, vector, set);
> +}
> +
>  static u32 hv_apic_read(u32 reg)
>  {
>  	u32 reg_val, hi;
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 308c8f279df8..aa384dbf38ac 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -310,6 +310,7 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	if (vmbus_irq !=3D -1)
>  		enable_percpu_irq(vmbus_irq, 0);
>  	shared_sint.as_uint64 =3D hv_get_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT)=
;
> +	hv_enable_coco_interrupt(cpu, vmbus_interrupt, true);
>=20
>  	shared_sint.vector =3D vmbus_interrupt;
>  	shared_sint.masked =3D false;

Something I just noticed. The existing code in hv_synic_enable_regs()
is reading the SINT MSR, updating some values, and then writing back
the SINT MSR. Those steps act as a unit to update the MSR. You've added
the call to hv_enable_coco_interrupts() in the middle of that unit, which
implies there might be a reason for it. If there's not a reason, I would
expect the call to hv_enable_coco_interrupt() to be before the unit,
not in the middle of it.

> @@ -342,6 +343,7 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	union hv_synic_scontrol sctrl;
>=20
>  	shared_sint.as_uint64 =3D hv_get_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT)=
;
> +	hv_enable_coco_interrupt(cpu, vmbus_interrupt, false);

Same here with the hv_enable_coco_interrupt() call in the middle
of the unit that is updating the SINT MSR. In the disable path, I would
have expected hv_enable_coco_interrupt() to be *after* the unit so
that disable operations are in reverse order of the corresponding enable
operation.

>=20
>  	shared_sint.masked =3D 1;
>=20
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 49898d10faff..0f024ab3d360 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -716,6 +716,11 @@ u64 __weak hv_tdx_hypercall(u64 control, u64 param1,=
 u64 param2)
>  }
>  EXPORT_SYMBOL_GPL(hv_tdx_hypercall);
>=20
> +void __weak hv_enable_coco_interrupt(unsigned int cpu, unsigned int vect=
or, bool set)
> +{
> +}
> +EXPORT_SYMBOL_GPL(hv_enable_coco_interrupt);
> +
>  void hv_identify_partition_type(void)
>  {
>  	/* Assume guest role */
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index a729b77983fa..7907c9878369 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -333,6 +333,7 @@ bool hv_is_isolation_supported(void);
>  bool hv_isolation_type_snp(void);
>  u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_=
size);
>  u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
> +void hv_enable_coco_interrupt(unsigned int cpu, unsigned int vector, boo=
l set);
>  void hyperv_cleanup(void);
>  bool hv_query_ext_cap(u64 cap_query);
>  void hv_setup_dma_ops(struct device *dev, bool coherent);
> --
> 2.25.1
>=20


