Return-Path: <linux-arch+bounces-13083-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36838B1C764
	for <lists+linux-arch@lfdr.de>; Wed,  6 Aug 2025 16:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D06E73B7489
	for <lists+linux-arch@lfdr.de>; Wed,  6 Aug 2025 14:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E168F28C03B;
	Wed,  6 Aug 2025 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="KS5AhqAe"
X-Original-To: linux-arch@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010009.outbound.protection.outlook.com [52.103.13.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D80A28934D;
	Wed,  6 Aug 2025 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754489485; cv=fail; b=FO3osuEzXtpS2Q8H+Wd4o6pCHJHHbd4lopVXxtnq3KCDpl9YtuVoQd0Pn4hYFycpY+7UZVzVxA9DyG0QMpb8clJaKBE6KQ16KWudWxQFFUsIkCZqCfIovGD41QLvAReGhmFzs+1Bo1tpRg8xYIxmVhWXk66b3dkkEQvybgrwjMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754489485; c=relaxed/simple;
	bh=i0QsXT7+cSBh29bNe3XKFWcLhOnGBv9h/ANoY/dok5k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jFYT4bttvcTo76WjE+p0wPTo9CAnOEwR4oleWfRqvWJrYYNsdI47wr6lEnN7dq9pwu4ETKvtiC3Z1cXV2QlyEyJiLcd3zBAg/YKqk/zzsWEi4AHRa+Q+It6OdeC89KPvCPjLgineVOqc+j/Po6d98qUEMU1d9QKvr1gsUopWt5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=KS5AhqAe; arc=fail smtp.client-ip=52.103.13.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2XERe9sP9NrW0uY9OXIgye5JyEOiiDChe0LB0nWzWTE50GeG59we3Q1Tg4x+k55yxsjuk8taoQuKM9/OsmLAZZkr+F/xLSsG89F6R+PQu/n+RoPfml2E2hjmFKDxxL61Wkfm3p5ipyISfwxMX8jjtv48Aev5JgZLYc7mL/+wcE0Cs8ukU4kdZohSvZU0rhj9YNbZkU5kfbhheRW2fIwdXEU2d+OZdVSX/ZsuReogWXhT4wCBF8nm1YuMzO4XO7fqY8PZdeBitUKe3A+31D/RAZB2OQBR67H5KUjmXfpFBkeHis5gjjFY5NyQLeXqistEqqTgPNTLb60MH0wTITcLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kr8n9R5f0cSbx4CwdnydWLi07qJFlF0ikAakzOY2TLU=;
 b=rdl/lG4YlloaK49vx9y7bWmfT55KDGSHXxoWo5YnE/iIzXtLNZ6uaHTBFI9UioK+02f5ArAMxsPYYylm+Snqg3IEhX0pAkpPxX4KAw5CyrThekmsSk7HYqIun0vIYD0H0pb6K1/5LtsiaKPH113+FvK7fwJ0bJTrxP7vefhnMyLPAj01teLGsMi6Q8DTjBErmStYtfb1Jz7m+cdlyzzqs+WaSM5dLQ5Yh1KlvEftc2kZKdMPatkL+FziqdQuTa5clJVMHl5EkFGMlJrCisUQcDHGiZ9JUMd3/3H3nZACVHZN6TQCFBRMingKQR7W32wg+PaDrtLVVYFp5iClViQIHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kr8n9R5f0cSbx4CwdnydWLi07qJFlF0ikAakzOY2TLU=;
 b=KS5AhqAeu7z1yWpx3ZyjiUwWqEr5Z0aAMNKOTJoIM0S9p++9fQruak+XkEz5zeJJvjhBrIzPjd4002NzFrL/W0cxwXaSBlhSUbgS7ojLJbhPy2TvKuKW9eAgIY+O4MuSGag0ZFJIKzSSp9QBPo/hI5ii3+oShoJYbli3FAJWOccpuIEnj5JpPfHkoCufllp1dx+r1yB6FTuHYBaUQImtSPGA+ROa0hd6+HdFHqDvRBV5ZJ6ia9bN+l6pF1BsGB600S3zB/ZBDVvrF3BuOGJ663uCVtw1o6RUX8fx3ykyzd3f0ML4WXOaD8O0crDsGMLhHDhmH+1C0sNyXdvkcE4g3A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SN7PR02MB10179.namprd02.prod.outlook.com (2603:10b6:806:2a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 14:11:20 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 14:11:20 +0000
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
Subject: RE: [RFC PATCH V6 2/4 Resend] Drivers: hv: Allow vmbus message synic
 interrupt injected from Hyper-V
Thread-Topic: [RFC PATCH V6 2/4 Resend] Drivers: hv: Allow vmbus message synic
 interrupt injected from Hyper-V
Thread-Index: AQHcBsxgXd6tBAZ7EE+/V3BH9h35h7RVqUTA
Date: Wed, 6 Aug 2025 14:11:20 +0000
Message-ID:
 <SN6PR02MB41577D7BFC7FA078880979A5D42DA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250806121855.442103-1-ltykernel@gmail.com>
 <20250806121855.442103-3-ltykernel@gmail.com>
In-Reply-To: <20250806121855.442103-3-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SN7PR02MB10179:EE_
x-ms-office365-filtering-correlation-id: c9f2cdfa-36bd-48d4-520a-08ddd4f31e05
x-ms-exchange-slblob-mailprops:
 qdrM8TqeFBtg1x3yx1r6QKZAk6LGeuzaqwLw3C0egdbRMleiIaW7Zl7nUVC9de5NmRPvrvpOI0Vtg8Ngr4sViOP83CcsC9RMgpt/59NqTyQaQXLrP1QwyeGKFFmlAq6NwtgC30FvGSLtrQfcCKhNxIlDz2NcBIMBEiToTFuFsixbeBtlUiKh5xo85TjET2kssdhOEwAZ+NjzxgY/DvZgBwoB/H6sKgJnU1tdSpfi9F3dUUTv6B3zi9myzXU4At6HpMr8KIotEimbLUvUTw5tVdbBmLLyLtoxViQX6/gM6TLQJdasVpjFQxY15T4IpcRsDNJI2fyMEPFo9qCSnYhFvBZ7USYQ0gsTKk9XcFNDOb2zJSonqHKmM5DXtqvVB9r4E1n7NBtxnxEN3sO0ETbgTJiD3nYcoRfYy1LHgu6ywwEd5r552RwgicnEG9u/lW5wUfiTiye383Ui/x49ycj1/UZuJhYAm28xBykscm9kXD8w909AbbtNSuq2hsME3mEtYI4K12oEwAmWaGb6RfWyLaxsW136TQYvW8U6jc+qVCsn+Zc14gw2saFqLl+u1p/GGrvTGh8lQTs4ve6701XoPAHZgpGpC4yy/K5WxxNte3IX9jEExTpbRg8bpKbqbKvhNYPsIXvvlAtwvgsVw7Svseui9vVnvZOzS2AH7qI3OFjXdTq26tNVxMQZKq6w4oqn1Ada+7npDL7USzJ9CqPeNmCXS7R/KCMLSNn5pTuHj+TMn76WNeN2ZgU6WGBLxQ2Kcm7eLWY7DFYbwouYGunBypSzaRZY1JS7
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799012|31061999003|8060799015|19110799012|8062599012|440099028|40105399003|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?80a5QYCaFz4LM46Ozu+hJcLniOtWEwEEfFkyZi4oOdNPUml0Fj5D5oggZeVE?=
 =?us-ascii?Q?h2axcSx2XRmIcBe6XLwFJFauq7xLUqoyRpDiKexp7zBhiu4S/XMWnjiNjez2?=
 =?us-ascii?Q?0E+UpwRq8lsx087RxiV3mqcmrrvYkFjqMy5MqUx/ySIa5eBGt/6eN0d2Fwm1?=
 =?us-ascii?Q?btr9wEBJOevaA3VFyyUob2CgrZoXC73oG1hkeXBCEyC2AVCeCGlMmYP4UUYO?=
 =?us-ascii?Q?tK7mbvOfaD4SWR4SKWvIBQYo8oHQodc9z5584que5TS5u4sRCKeMeyBv+d1x?=
 =?us-ascii?Q?Yp07MzuWjNE1far65N2BDSLTjX4PAO1h4wAZfLc/D/IvWi3w/th6Q5nP7Sdo?=
 =?us-ascii?Q?PBUorgt6AUlUlZ1gS5ygPYMmkSextdXZDMiOeBx1Na+8zVayvQR3Eaz6Sv/p?=
 =?us-ascii?Q?Qsu0wL2G/1dJmOjI94vTQ/fI+wm/9PoUBmBPHeagwjd/2MNUi+251zOfB2C+?=
 =?us-ascii?Q?3+nUvAR8JtbEasbWUb4zI5TpKbhin6vS6gUZ2YM38RTWOp/fGPzppkU3/OiM?=
 =?us-ascii?Q?Wp6A4elZTpGflWLBT5FrqHWf2cbV+5Yy0/aseHu0qfgUcEMXZkdj0+MQXW70?=
 =?us-ascii?Q?iif/NaAZafT6MyXEDTvI7WOjVp06aMwjLDPK40ZUsuXchNrFiR0pdXUN5uAJ?=
 =?us-ascii?Q?gIFLhbIihCrb8K8dB9eCEPKGVUqlubSGNKn2/pfv4Uoiy1XjElkLbfuF0RqW?=
 =?us-ascii?Q?6ygcMHnksWwU5Y8145o5GJdtQkFkx2Q6cLrw6a4Lb+WZHXa6Uu+aIwFHQaWy?=
 =?us-ascii?Q?vnDd9xKzxJExEZtF+M4LEYi8QzLULBsknex7o7K+W//2D8CWlf04tuPoteKM?=
 =?us-ascii?Q?syGxpRTUqXuKAd5A7GJJ7z0fozbDvROWXKukmdjLVOnwRGWV8fvhMaTlszzj?=
 =?us-ascii?Q?FhUUnE+9xk5VKuV3DiJdYFjcN/a0shP01mCIbW4+55ScQWNCwDb+SgglSi51?=
 =?us-ascii?Q?haHtzHxMG+N8brJlcHfL8IyL4eU7NrK4iLK4oh0/eGAtfk7KPwzgT78bgTjp?=
 =?us-ascii?Q?vWeDIPhR4lnt643tpZNSRY/wI+evO12bieJ08POySN3WSeulm3hufYS/0y/Y?=
 =?us-ascii?Q?4dxuYavO0IJqdkKRoWIVmxPcWoqQ1PzRpcggrF+EYRB7OsCqyvqi1vbRt5Je?=
 =?us-ascii?Q?fNsZRgDFRPkZVSKx2HIl4N3sMldUaeC/hQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DjfEP0Q5FCTzuvCCk/edOSnBPiikbCU+0KzlaOKpg9OaVROSsOA06MeojciK?=
 =?us-ascii?Q?Aa6sY5tf9ZcMzBI6OIP++9MOVxgaWP8QjUO+oedTH6j+faOlbSc83u86WVZO?=
 =?us-ascii?Q?0uuNqrd6kY1Zfp4oIpZTzcINAtZXbqTuR3y91Nf7gyTgRWm/y8DFcf9/ONor?=
 =?us-ascii?Q?dJ6I1Q4U+8Yilahbvp5eLPqXBk/v63Wzxd5c7NMkdby8vJarKMHANpfj3VPU?=
 =?us-ascii?Q?IPTAkgPEmBkwGn+kOum/vm+UGbKS3vmvioq0YGDzeCBmRu92QFReAu0URyst?=
 =?us-ascii?Q?Vr5mm9kDl1ANvjOtMnJ4qP/E3yBR+k2x+B7OYAzCPvH+YlDlZqUb3CwzPFHI?=
 =?us-ascii?Q?KY6NOkpf+bA6AhmtA22P5pwwYz/gRWIuFGw6Rj1+rzswWML69h7A/EMLvoZm?=
 =?us-ascii?Q?yqR/q/HBA+X34vgXhApM6d6krBRItJ/pwW0onzxR4BxgmEQBDFKRVSBvLyIa?=
 =?us-ascii?Q?DRcdPB/CIl5IDCXRfNAmQy2B1SEW1yxkLLMpXBnv3Sl3YqE4gztnHu6EZToi?=
 =?us-ascii?Q?l8qkw7uKqam1H3xXUpUypdg5s1ahxf9ytq7/ivvhTacY1xh8Fn5lNiTFWAec?=
 =?us-ascii?Q?EKGs18CgITSRW3+tew9DMKktLs85sCDMwdRNQwd0GWKjGpZh3Hs22gPnnKWo?=
 =?us-ascii?Q?GRLWTq5q1MvSWRqtU9MLnZ3dNmcQDh9Ec/H/5EICg9HigRM2BFMM74x0lF5N?=
 =?us-ascii?Q?JrKzsgv3sYiSVqWN9LA6VtByjT+ozN2UbHc0o/tzM1MfjoV2KRP7HVXE2uOW?=
 =?us-ascii?Q?ouNLV1EkmmCol6IT7ESO0LCrgjgJmDRpG+GFThkPKf1YDJ5iK7+32UTEp0b9?=
 =?us-ascii?Q?Gonm3JPUf+jPlsOJ4TqMFC/GVpnI4uhJKFzvLRbEZ0PnGOMGd8DmNZy9WZax?=
 =?us-ascii?Q?AuE5EUu8NuI5uyR4e+6KVSWozHCSCwrm7q4CKcwUvAg2p5zOwTUOOQ76+Mjz?=
 =?us-ascii?Q?LfbLpr3giOQW9r28DylttKrxv/tmtcOjBjtHstCydAU9IWqILqngh38Qgpsh?=
 =?us-ascii?Q?45YTYJ/lxN0Ahe/S2g8kfcMerYtDqUi2C/CWqaVGvgXHz2EYFw5SW9PBkqnf?=
 =?us-ascii?Q?RWvWlUAmi2xxeDxIAAZwL/CDCLj41xrPYp3Di0cBH+g8+RbdyvmulMKgY8gp?=
 =?us-ascii?Q?tAke5vDTxz+QrKOfZE3GzicWGZ4H2suSaryv1Xcj1Mh5ExiyV9uJFCdA/tXW?=
 =?us-ascii?Q?plsuWgXwqsJi3Mj3823Fsn6xKvfUlkbXGULG/9qjZ+dztIhu+bwumyUkqcY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f2cdfa-36bd-48d4-520a-08ddd4f31e05
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 14:11:20.2122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR02MB10179

From: Tianyu Lan <ltykernel@gmail.com> Sent: Wednesday, August 6, 2025 5:19=
 AM
>=20
> When Secure AVIC is enabled, VMBus driver should
> call x2apic Secure AVIC interface to allow Hyper-V
> to inject VMBus message interrupt.
>=20
> Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
> Change since RFC V5:
>        - Rmove extra line and move hv_enable_coco_interrupt()
>          just after hv_set_msr() in the hv_synic_disable_regs().
>=20
> Change since RFC V4:
>         - Change the order to call hv_enable_coco_interrupt()
> 	  in the hv_synic_enable/disable_regs().
> 	- Update commit title "Drivers/hv:" to "Drivers: hv:"
>=20
> Change since RFC V3:
>        - Disable VMBus Message interrupt via hv_enable_
>        	 coco_interrupt() in the hv_synic_disable_regs().
> ---
>  arch/x86/hyperv/hv_apic.c      | 5 +++++
>  drivers/hv/hv.c                | 7 ++++++-
>  drivers/hv/hv_common.c         | 5 +++++
>  include/asm-generic/mshyperv.h | 1 +
>  4 files changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> index 01bc02cc0590..c9808a51fa37 100644
> --- a/arch/x86/hyperv/hv_apic.c
> +++ b/arch/x86/hyperv/hv_apic.c
> @@ -54,6 +54,11 @@ static void hv_apic_icr_write(u32 low, u32 id)
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
> index 308c8f279df8..d68a96de1626 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -312,10 +312,13 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	shared_sint.as_uint64 =3D hv_get_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT)=
;
>=20
>  	shared_sint.vector =3D vmbus_interrupt;
> +

The spurious blank line is still here.

>  	shared_sint.masked =3D false;
>  	shared_sint.auto_eoi =3D hv_recommend_using_aeoi();
>  	hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
>=20
> +	hv_enable_coco_interrupt(cpu, vmbus_interrupt, true);
> +
>  	/* Enable the global synic bit */
>  	sctrl.as_uint64 =3D hv_get_msr(HV_MSR_SCONTROL);
>  	sctrl.enable =3D 1;
> @@ -342,7 +345,6 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	union hv_synic_scontrol sctrl;
>=20
>  	shared_sint.as_uint64 =3D hv_get_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT)=
;
> -
>  	shared_sint.masked =3D 1;
>=20
>  	/* Need to correctly cleanup in the case of SMP!!! */
> @@ -350,6 +352,9 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
>=20
>  	simp.as_uint64 =3D hv_get_msr(HV_MSR_SIMP);
> +
> +	hv_enable_coco_interrupt(cpu, vmbus_interrupt, false);
> +

This line is still in the wrong place. Maybe you accidentally resent
the previous version of the patch instead of the version with your
intended changes?

Michael

>  	/*
>  	 * In Isolation VM, sim and sief pages are allocated by
>  	 * paravisor. These pages also will be used by kdump
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 49898d10faff..0f024ab3d360 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -716,6 +716,11 @@ u64 __weak hv_tdx_hypercall(u64 control, u64 param1,=
 u64
> param2)
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


