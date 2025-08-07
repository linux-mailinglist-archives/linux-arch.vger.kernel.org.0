Return-Path: <linux-arch+bounces-13087-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 456A8B1D16B
	for <lists+linux-arch@lfdr.de>; Thu,  7 Aug 2025 06:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E35A818C7645
	for <lists+linux-arch@lfdr.de>; Thu,  7 Aug 2025 04:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2731D7995;
	Thu,  7 Aug 2025 04:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hyb0hgpU"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2021.outbound.protection.outlook.com [40.92.42.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1578F1CAA65;
	Thu,  7 Aug 2025 04:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754540043; cv=fail; b=S6r3WqGyzyfpBBGxLOmLn1RwcG9gT8AfuhZ00eOP9OqYPbvjnjFxPP3gKx4ygm1Rdpp5xU9o1UcWNwGatcL8ejMX2xrMmlWyBLuIJB8F7fsV42iyMOtUithS80VA+RvZbzfqKCI/KL9w0kOv+MYSKRgoYIcm1DOI+5DeHNO2p4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754540043; c=relaxed/simple;
	bh=cEncL1OR7D2LZfB2mob1ZpyNSVsoohRnLnKYdOdVFfE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eLHwCnXFysLs1ahMN0spK1jYxkEGQokIz32xrCGT+3cYkLj5x6cAE4Xs9YTx625MlOdC9HOCVAQdvdZiwZyp6o8XQeK3sZx3Yio4H5YbxmBo5z2qMRMzrv8OJkW/EIi9n4RfmZNiy/fab9XLwuNNamKYFPN3vGnx+I7+lzhtr4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hyb0hgpU; arc=fail smtp.client-ip=40.92.42.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUc5/dX/IyAAMCPRusyFk8P4Na65iexcxfMtQ6Srw4bwAusRfUJiMzIZ/in/pA2syFfzppIn03gOg32XpkgRfeL9rnfg8bIdxW2B0HoA4/F4OqlDC+iS0chwZ0QiWTwEKPg4Vp65I+Ciz06T6uJDXxt8tJXRR1EqveyWyx40Cs5I1su87JmNt9YMKFjFpL+mQlXHA9g5WhnhKiGHO49pM3jVAjRNOJR2mjRTup6vRBdyYNExmq+nPU64kIDr6RHUqdCpMW9Q2BMtk2TsZOQn4F5S4BCwVQWeO6yzsd4JfAk2Y1oL00TfITuVpAGN28f141OtsUikX+cK9BBb0EAw4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qkxf/ni73XVI5Y5tySjOA0AuHJDpKymUDq673ptPYfA=;
 b=hM8s4to7OsIUv5JW6uvyvlZxVwGncvcWr8/zAnFk4OSV1uvcXJqf3nFdMiPR9xtK2RzYXsAOCM3bcJ7EJzWfcWVCg76yH0s4IBJDtSRicWlXxifjO16VdsizIjYdPAr/K7dOq9t57JqDSPDn5tVikikqirA3Shjv6FWm4iHbFDTVUTD/5PPIJmPH1Y+6J+ytXJSvdkDaRBfFQoAm5RD5FE50uLR3XoZPNo74pHeETo3AK3YyB69+uJasNc19WnnP3weUGaLInI5NZZr4cQ2sGx7XEbLt9yhfu5eXSq8uWavRFzg1a15aFuOgrsFVvTX20qPisaAxrayv2cp4hctGRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qkxf/ni73XVI5Y5tySjOA0AuHJDpKymUDq673ptPYfA=;
 b=hyb0hgpUYv+H7Fnbm1H4VvA1jBzYTobJdcxx3cpNy3PDzYm3OX2I5gsfps6IiK9XAoylyagARQ3gNWwuCkqcHaMDcPe9/YfOXuwyfaEffIFoM8CTmOXqJVPJOL/ZAQCdU5p4A7X6gC2H/Y8QzgnDIxGIMro6yIAHj1KCF/Mi+Pgxg7kr7bI5IWCjT644DiXQneqUQjYCUUnEWF+ctt+pbnFPNraEfFofu6GUXciWB7ps0yKjNxZwedJx43/ACM+MtEi81OTDidlvNwWRRaN4UY3hIHOVAIdV/5+fVD0SQ9xHF0a+IwxunHG/2oC7FR4Ly3m/0QLpLXieKHuwEefmaA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH2PR02MB6521.namprd02.prod.outlook.com (2603:10b6:610:63::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Thu, 7 Aug
 2025 04:14:00 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 04:14:00 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Tianyu Lan <ltykernel@gmail.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "arnd@arndb.de"
	<arnd@arndb.de>, "Neeraj.Upadhyay@amd.com" <Neeraj.Upadhyay@amd.com>,
	"kvijayab@amd.com" <kvijayab@amd.com>
CC: Tianyu Lan <tiala@microsoft.com>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [Update RFC PATCH V6 2/4] Drivers: hv: Allow vmbus message synic
 interrupt injected from Hyper-V
Thread-Topic: [Update RFC PATCH V6 2/4] Drivers: hv: Allow vmbus message synic
 interrupt injected from Hyper-V
Thread-Index: AQHcButZj8f2DvV74k6ye1PHVMuFErRWlUXw
Date: Thu, 7 Aug 2025 04:13:59 +0000
Message-ID:
 <SN6PR02MB415752821BCEAFDCC0722CE4D42CA@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <SN6PR02MB41577D7BFC7FA078880979A5D42DA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20250806160059.6244-1-ltykernel@gmail.com>
In-Reply-To: <20250806160059.6244-1-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH2PR02MB6521:EE_
x-ms-office365-filtering-correlation-id: 343b4cb3-e45e-4ac4-5b5a-08ddd568d5f9
x-ms-exchange-slblob-mailprops:
 qdrM8TqeFBtg1x3yx1r6QKZAk6LGeuzaqwLw3C0egdbhkmYMtwInnCQBEzz6BUVPUz2slPUy2or9I7ysi/SOklxwEj3wzPLxsk4wGGTbX24sjeqQgJp2dGwImc58s/Tn4MKhjrzearFPwSsNiBMQ2bfq2TReG3K3E7ijkdROHt52tF7QpdEy5EmTZPGfW3Z4hsMxCviwE161tO25LHdKdanYcWI7uZvA7N7yETlyf+hPN8wkeKbTGc85CRXB+QGoqKApX7HfvxYPyIMd/WC8naEFd60Gq3Y7rexYUqLFLADf/IjXQ4dkxVyvNR0vde5tPUVTDDgmHqKTwnkFm3Ys86V/qNmgbsILxURYHP3iPVYkyN/1xaJlP8bjccWIVDK2adCPbYpweSNMvdxH8NRbADFqEdNMwR1bd/LzLsaJDz8w+o/CK4iQ3h1j/3QHdAonOrf21KzolVtIVv5CyXkC57UjUx7vulX2MFOmiNbQk4iMORzQs5OjTFENvclHclYyyp+wt8LBq7Xzy1ERxuCqJDvpQi6s0d+Jd33A48H/NZCKJPdRAPMqYsp9tklMOe4nuMaNQVdkd1kpocqcB0nxR48dJKJA8G+cTygho2bTy9gD1BArXPdUl2ol+4K+ybYqBN+1VUWJSnX7XZInzrKmd0cKT+thQhYVYLKosDjSETl5OgeYmHR5UkRWA+rgAiaC0i84KNGwV9Irmlq17G4Dxb+MRK/tfr2+3zXNPxKQA94hHwQC1T9DcHCD09tpEqA5vngwMqcSL3pd/F2j6LIwy/QuwuADKlKX
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|8060799015|21061999006|19110799012|8062599012|461199028|15080799012|440099028|3412199025|40105399003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GqFS8C6Z4sAoHd7LQNT2gsVAsVVY9kexV9yRi3DzvQbyCLiUnXHXdwxosmnC?=
 =?us-ascii?Q?284gtJpPhLdoNE2hIpjmXB3YaXugr7/H55qq2H5fQLQ4CM4NLAc+a7TFIaR5?=
 =?us-ascii?Q?lzggfapgmW5gE5N5+XJZvP6ZydbXux16s0GliDSZqUgzi0UAj9kJ3u4DP+Bq?=
 =?us-ascii?Q?u082ee0Oarri3f6/7Zq+7sBoRFAkFoE9+hL9RHXXkrQ654cefRPYzCdda/yF?=
 =?us-ascii?Q?1josrFRi4PEBj3KDtQJtwq/bJ07RUpUf2cHiRQLWsoe7+vLq4WEWQwDmd8/p?=
 =?us-ascii?Q?mAzbOyqNyPh+vLLtxZGqWNWm8ZN+IoZlgKMVIUkjFgxhAEZK8Kq2qXVqK94Y?=
 =?us-ascii?Q?vhKTpmDqXmUu0n6vRfsjwMTWqweuQR0bluEzRhhGuOYb/lORJgE7JMn/u3vP?=
 =?us-ascii?Q?BufYhozNw2IPxKcOJVz6hWLI2VMmt9dK2KftUhdgjigMElTWBPUN6dyTSjwU?=
 =?us-ascii?Q?NMH6pyifYYH+dhrfMUBOIJdoz2pZCEyv7eglB0FmFVxs52800QT47lcIYylQ?=
 =?us-ascii?Q?AC/41ei7cTC+c+2VJ41G69cv5gA6lhop1heFNAKwTvsq/MJynttW7ASkegE8?=
 =?us-ascii?Q?SK6jcMgaMt4rw9+GTaX3AEzXS0GWvhrK8X0ZzE1z1zUNgbj7G14eUdYoeUw2?=
 =?us-ascii?Q?xbD6w92q3zaO5KQDDtBS4MJI+HpoXC35fKmz6FsJPmtku90fupo4Uwv/iuX9?=
 =?us-ascii?Q?AHDQ5egsuDmfRRE0qfqbXT5JP69VSrXcTeFYGmIuGwgRapU+S3BALROelJFs?=
 =?us-ascii?Q?cBQAvaNynO0gJJO+M40jqD4Hu+9MVmVDa4vEZ9AO4HC0AWiDbsxvT/QQqbdu?=
 =?us-ascii?Q?VsLsfia0iVE6z83HMzGggB/5W6NuUYUwCLjwlklJRdIYls9rKyJSC2Bnd7Jg?=
 =?us-ascii?Q?u4sjQAwLx/u8uBwy1EvbWK6S8d1FlBHZ64iuZ1af3cd05IbFOUTtt03DVoER?=
 =?us-ascii?Q?/+cHvX2EhRtMLdSbfUTjrmxxOYYs4hw2TscpgRPtjstxDVeqUkJdXPU2ndgK?=
 =?us-ascii?Q?AedDYnmJJMCOAOZB+Gb79tswDfDSMqIhExCiFZQPiwxmlomYHDQeNz+mVIFk?=
 =?us-ascii?Q?5/MukGPWKrioPIn9bLBBRsPLxlfiI4wAYu1z25LT0rx9gJppkz2NeFMYzJdz?=
 =?us-ascii?Q?Iv5E0+vgSd0nZ2QTOiqCEF4TF+e1U1ZvTbjQnjDgRyqXn62swTkIGZI=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7i0Cdz6cy2Q0uge+JhopBs3JrDEHCfkdJ91j0qJGRcnRELAZJu2P75zHHNZ3?=
 =?us-ascii?Q?cB9wqFPHv7+IIJQD/Ye7VTM2rBjIm+gzf6gHjddzguQTFAHd5Gxv9wvujy7Z?=
 =?us-ascii?Q?KQriyVhlnCBHM+GvS4s8YLrFtkLTSJk5sFPFEDRaaLR+SK+sriACDn91jSLB?=
 =?us-ascii?Q?9bBxSUA/TYHWVOGyy1rnemLu/d8LYUWobwb1F+VW3ernkggaiOokRYsRla8P?=
 =?us-ascii?Q?H+EYYgTj/athB6oQ6cq0Pdmiy50P7KgO8xUyKYCZB28WKPuhfRdzzlo8kFvB?=
 =?us-ascii?Q?FboPPKp+WdcEe8bhNzTO0s026J1802+2utUvMVVXqkEZa2JQRVrmLGLKrVAp?=
 =?us-ascii?Q?K1FFe9PAHHvTw11/t/b4J3Kr5iaGzVbqjZ7oADQsgWZYLOwm64i3AdqRuCBH?=
 =?us-ascii?Q?XCW+drTrc2f0f7fBJZQvz27FU+kjg1zRyympnMlg45aAT3jUtmqrQOlCuv1s?=
 =?us-ascii?Q?GGNzzg2WRQGMP6WiZ7HnqLIBo8abtI7uUrcpSDGg8BSlmqWscctIYM16BL0f?=
 =?us-ascii?Q?bXF50f+n5H1iYmv2q14lkoj3pZsE0MIQCbURLbBGb/ySkUyZIjJ/eZ0ZUj3L?=
 =?us-ascii?Q?NQSWVJ8p6lKfb9LMpjooCGr4jmeqEhRzWoZN0P4Q8uaWM/NU7vcBEWfr9JoK?=
 =?us-ascii?Q?2+CLDE7htLCf5ZEPfja9Wm5rOuTwi7NN0niovdkyyfLlQLPm3pyq1T+o7dCI?=
 =?us-ascii?Q?y5R9MpZaQiihmcA3r0wg7U8YYhX7BoxdLWa8jeFCUG3vvSIyVYeplOrfPrgJ?=
 =?us-ascii?Q?aD2CCW+YDWt6Ljo5MyijEEVZ4aWPPj7utgJjQ8Fe3IIXlLO9ZKHyaLdZS6J8?=
 =?us-ascii?Q?/rV4EkV/KCBe6oVTtrgvZPps1c8/9DYUdL2oBOYsXq14KFRmK6/GGaFRQB6l?=
 =?us-ascii?Q?9uk5p5rmdY9/YknfnUz+DyDC9+iACz17P7luNHkX3WaAfpfemq0CsXhqZsqx?=
 =?us-ascii?Q?nxDm6yjuNF3+ybOaBbqBKd81Yh6jEMFPfAQARdFRCCInX+V5BNDa+g3V6FwF?=
 =?us-ascii?Q?7QjeaG6+UhuEhBXkXEwMUFEWuxa74tb7MbhpuhJfee89Z3Pr0q2wwijVBTdp?=
 =?us-ascii?Q?hIcyaxJiolGaEpThyRtu8Gb+i2MkKFz8E8QT3l0cNGFvVnp55HTwVegweEjF?=
 =?us-ascii?Q?27yjmECDV1Eq05sd7hi+9vNf/YdAWXquogUakPpoX9GcvxNTvpji84/m2X1e?=
 =?us-ascii?Q?SOPjzE4KSrbYN6A67wO1UffNCo4Cz03Lb21k3HeBD2TEkAiD5mkTvo0Yels?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 343b4cb3-e45e-4ac4-5b5a-08ddd568d5f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2025 04:13:59.9228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6521

From: Tianyu Lan <ltykernel@gmail.com> Sent: Wednesday, August 6, 2025 9:01=
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
>  drivers/hv/hv.c                | 4 ++++
>  drivers/hv/hv_common.c         | 5 +++++
>  include/asm-generic/mshyperv.h | 1 +
>  4 files changed, 15 insertions(+)
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
> index 308c8f279df8..355663a6e3b8 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -316,6 +316,8 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	shared_sint.auto_eoi =3D hv_recommend_using_aeoi();
>  	hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
>=20
> +	hv_enable_coco_interrupt(cpu, vmbus_interrupt, true);
> +
>  	/* Enable the global synic bit */
>  	sctrl.as_uint64 =3D hv_get_msr(HV_MSR_SCONTROL);
>  	sctrl.enable =3D 1;
> @@ -349,6 +351,8 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	/* Disable the interrupt */
>  	hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
>=20
> +	hv_enable_coco_interrupt(cpu, vmbus_interrupt, false);
> +
>  	simp.as_uint64 =3D hv_get_msr(HV_MSR_SIMP);
>  	/*
>  	 * In Isolation VM, sim and sief pages are allocated by
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

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

