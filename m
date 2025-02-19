Return-Path: <linux-arch+bounces-10234-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584A1A3CD43
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 00:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2DD3ABEC2
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 23:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B191C7019;
	Wed, 19 Feb 2025 23:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mUs3XIes"
X-Original-To: linux-arch@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19011028.outbound.protection.outlook.com [52.103.14.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA202862A5;
	Wed, 19 Feb 2025 23:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740007052; cv=fail; b=mcmM2egujixqwQADVzj0HaDzOHPIrFBw4tbb6PTCd26VxaHWC5JvuV8pSzlxUOzSs/HfLKPkhtVsTFSMuJFNl0qiYgEs28ib+kB4WY5iJJXQIXnPzmYttb6Au2bUCiIBDT3nio9a7KOLsbwLOdi2NOINyFfl2kUFJG1ZfB+iV6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740007052; c=relaxed/simple;
	bh=b8rI24b89dEGeyxNiYmx7uFtBFB+lxCvdilpp51FY34=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hlrpu/hJA5oIM2VGBejA6RYDx21RLEcIFOfIuj7vYiBgN61SaW/cHwImFeGBRXkvg+ffnimPJgL23anjKMGsBiL1GSNBe/960TK0NDaueCzKWMu1qsl5MAN8aX02ClI4C2Zn4Gc5QW2V6Cu2ewuQkozl2dTpg+dFKTG7ZCx4AI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mUs3XIes; arc=fail smtp.client-ip=52.103.14.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNQVGvOskhCJ6mOg3wr8lQ4tEK4t5uXqA5gqPdkmrD0pFbsCsf1HGsQZGoc6FsUSzrO2iuy69ePCUnjauVviDo2Io5nCz+I7sjfuRZ0yelUNkj/YEMPQ63nv/17Fs3+8upOgE+Nz7vUrMTM4fJndQAykoXr215Xp5Vz2bhMEEMkxxQ6wwI0vS5AazPKSZJogYGAZJHxW+1YQBlSpUlpxSRj1B3t3AMwxwdNbU19cRx7pa3QkXEcruiNQLn56WCP/+87FVwDDWcD1PIpg/PZW15tVsphI4t3v46WFlqvP9YKtznVkHOaRx4zxF3Whbl4yZvdI/aiNlrzS6OhB/Lo84w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1Ty9bO4kNZqQoF45hc3T5YXnh5usLNhP9qMKfVRUYs=;
 b=HS3nSSIk9FVPr1+lZmDQlp08nKxIjYOXPkxK/dt72qxfEqKksS0lsms99FFzq1y5FGY7FEUtgLjITSn0Og138KDiqN/onr9QWinE0d2RDJ5phY/gRa0ZGcRbNDOY6ijNuzuaKCd4Fuhx6HFQAOrZHIwSenDC5zl34oF0MJd4BkiU3tYuv9juYAx1SNnNqmdyZOgdBV/UG+BEf+0PIDLPv6fOGA0Foq7k/KbtBdyplIRyITdrL20LRx6Me51fKXrMfIc+UXH7ZS6v00f7njwwsYHvEN1orPdoZ+5oqBgn9dQLpc1SO3Ipp3jSAj2LdhvIIyU75WdT893uoSHpbUZ3uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1Ty9bO4kNZqQoF45hc3T5YXnh5usLNhP9qMKfVRUYs=;
 b=mUs3XIesnyShDYIDgOEnLiCbIt7R9NZLp0X1Q+mVNy7Vc3PgfzijS2b0JC1eF3h6AlovBTGcoquv7AERKjag5yvrm7AkHwDmHZ28E6lPO6x8F7ThDjwbjXDBxl8kTaK3YUW59vrMfeJIf8bDb0UQo/xSvt9aknRR8T0atw5fUFfJTeP/sOHlge6xYpEJLCcTSNWMKZA4QBLJUGheRU9YtIWPEgjubVPZCpwNRhfQFjaxYuyxqGvSeCGiDtEljmXgN/F1xp6/YxdRVhafdAiWw64pwTfyHi1aK+D6MT8abMizfK8sDyrf2hRTZRl7QFvA52r/e1FGu4+x03r4SblKow==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM4PR02MB9192.namprd02.prod.outlook.com (2603:10b6:8:108::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Wed, 19 Feb
 2025 23:17:28 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 23:17:28 +0000
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
Subject: RE: [PATCH hyperv-next v4 3/6] Drivers: hv: Provide arch-neutral
 implementation of get_vtl()
Thread-Topic: [PATCH hyperv-next v4 3/6] Drivers: hv: Provide arch-neutral
 implementation of get_vtl()
Thread-Index: AQHbfO+sIeS3ah0DEkWXeltDBl+Ad7NPTrrA
Date: Wed, 19 Feb 2025 23:17:28 +0000
Message-ID:
 <SN6PR02MB4157164CE9A332EF62C6C037D4C52@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250212014321.1108840-1-romank@linux.microsoft.com>
 <20250212014321.1108840-4-romank@linux.microsoft.com>
In-Reply-To: <20250212014321.1108840-4-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM4PR02MB9192:EE_
x-ms-office365-filtering-correlation-id: 6235255e-c217-4304-52f5-08dd513b93c9
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|19110799003|461199028|8060799006|15080799006|3412199025|440099028|12091999003|41001999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UdKbV8bZEt0nYSS1mlHl35Ary+jWje9hhQ3Ru7m6nrUMuhOX1Ti6tTomi9G8?=
 =?us-ascii?Q?r1oYwlqDcqHeY8oFqjcAA+2ZwBHfMuiWnaG+yPfZ5ZPzCfQBN5259uSbLQhb?=
 =?us-ascii?Q?gEqJLy6Ghv2PdgP2FD2EAxeD/yHuKhP2lWTar7zVo93k9/knebO47uYETthr?=
 =?us-ascii?Q?miBp7nzSYgQCyTcEYCTtHZl2Y8QbycQvvaA5TJ8mARrEbCMUdp66zov9XUB+?=
 =?us-ascii?Q?7z5B6M6GzM37FpS+Po7Nd5Fw5Af1QasT5HXfc9JdEcqDUxO69W685IwA11Pz?=
 =?us-ascii?Q?ngaHfto0WWY7zFRN1C9jw0KM9ynorYuQQpTnydKXVA7sRVMwE0ote6Z0g5Fj?=
 =?us-ascii?Q?uGkN+NcE8AbRiepRPVqizlfjFgX7kHSCFOiXc074fCYipqEF4jliKOPs0hme?=
 =?us-ascii?Q?2Q76pY+hruVOTq8In2Lnh2joTjeDezsPDBF/BUVt132+yeA3+juSsYLlEZD9?=
 =?us-ascii?Q?sTT7R7QsR04o33ogX/joo69uah3Oa534NRtsWP6tZse8Lq16zfgd/nD6Ydto?=
 =?us-ascii?Q?1m9GV0jLRyQ3A+MdktVsBJ2gJ0Qt5hr8Ong+MATeDw6sGCo5D6exdJCuA/xJ?=
 =?us-ascii?Q?MtyQOvxM4LIMu3AkC3Ma97R3d7kSBKwwErEXAFW7zgr0Cl7BKDhmT7/ptHdJ?=
 =?us-ascii?Q?CsO3iNi4TTieaCe6Fe3Or9+6dcekF2I2f1Zru2k+zSXF1/9MKTBWuDCtMm5j?=
 =?us-ascii?Q?XSEcJfal+R6TKSmSXptAPNvFcG6KlDlCXj102B/7yxRjxPnQ4nV5Qy1WPy9n?=
 =?us-ascii?Q?mIVYj+WcOT+FblOVJgS3kmdv1b+t7eIAJiRA7fe9dUZ1Y9PfNQxqmeMKGb8i?=
 =?us-ascii?Q?RfgsNAmEyDcwg66aMd59n/rbVmj8combkhTS4RtahLBRJl0AOybXB1IcLpfT?=
 =?us-ascii?Q?l82mHLZBYkZ38PpuooAM9KGSLz68xmpQ7nvtzttPpOpMlrmm+2xYe9TbcrAV?=
 =?us-ascii?Q?HOV9ndGX1DngRqT5zzGCm9Q2vKKWg+6DbfKZLYW/B74XksOCK9V7H0zx5pkL?=
 =?us-ascii?Q?2RkzRkyj+6ZNJEuQb+6X+3nGre6t9z83s7aPQKkcxvfuUxIwhwKKm8kuk3rG?=
 =?us-ascii?Q?9Q/yfdRmqC27UKhsrm+2yWltniVNoUyOgDOhBfIqkhzsWJi5erU=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3R0DfessYq5QArI41JXwnGahd0FuxJn1AKKlYMUl/OQn6lcu9N/y1SkcPoJZ?=
 =?us-ascii?Q?JgbBfPJEbQNFDYieauYxNdoVREcxraiuUsPw9e4Q8zYTXRPhx2vfsOX1IlUJ?=
 =?us-ascii?Q?sWt3/RwHdl67yiWfb3zrYdThYC0icZOYJYqgDTMo1KDX+GuxB0FrW2s2bacj?=
 =?us-ascii?Q?IyfCYGDVWQRWycfI6WK/sWwKFMm+KqPSKhkpFK+N3tPO9cp0NSLqqbwaEUgK?=
 =?us-ascii?Q?ytMdqHoL0RxnytAsrEsug2Ay4H9T2vdwWlMfBrV3Yy0gTq+iPG4mv393qCgv?=
 =?us-ascii?Q?XIJYxlHvONbh6oPtJrufzwhVKNtcALwWyuJFAsacb4vOA84Y+5OlDeX3a1Qa?=
 =?us-ascii?Q?y/vHfmdaShj0Ysvgd1HQ+HAI/rnZlzXaX/RqC7yfKQp/rkkcQR8I6pl3EDbf?=
 =?us-ascii?Q?A9z8tDQ0ngIoO0H+vQ2F1v3/vRm1KL8jg2BTXDBQV07a6mLZy/7RKG6qSXdS?=
 =?us-ascii?Q?YcKXVE/Wn4XMO/ycRqxQv4I15KVHBxal5D9vUX5G/zwEUDpyg72hKnlRvTv2?=
 =?us-ascii?Q?Sc+OvYRSgaYFG9u3hxJBgvUv/XLO9gvQwvHSiBtoy1QJZPhYj03hyrdqoYwx?=
 =?us-ascii?Q?3rEPRr0k1XQt4LEwhnGFszDm75oksHBcfa9ydbXc37zqQhgjabQexhtil8S5?=
 =?us-ascii?Q?3n89VdWZj4p/Mrb20khdDEWMPEViODoxUDvSVZ39+LS4uPl9U3/pz5KRuEI7?=
 =?us-ascii?Q?cBp1t5eRhyaDHCSPkkhVAN6gqAdcogBk8RBNOa3kDCkTwmRN3IdVnOoF3jc5?=
 =?us-ascii?Q?rNO3tFDhQLOV98tpbducAn++pTIyLSTNCHzyZprQLsp/wJJV0IsSRdc5hcKN?=
 =?us-ascii?Q?XMCmyqQAAQTdanKKv3ZJSmOtJOHt335UDt1W6LudYT1gtu4bXEJDnu2KGPOQ?=
 =?us-ascii?Q?BKD9wViS1y+GRR8UuHJ2e8mfSgN3Ux3aKrLWdeTWZ5pKmiMTn+o0rFNCeNcO?=
 =?us-ascii?Q?FiTVxQLdrDiQz69Oor21SSCikG0CiyvAwGeIzjFl5QXwjC7Xfpz//es6vT0R?=
 =?us-ascii?Q?DTdvaR9X+SNeX0Ymr6OXlrtmZuUrjJVmpytvBSHuSe2P9kbWmi9joWcHtPA3?=
 =?us-ascii?Q?5h57lySDsFf/PI63olETtrFUhGsqyJll6w+FKR+r2zp+xve00QbaSBeJEI8d?=
 =?us-ascii?Q?zBkrJZWh4ZGJ/j0Bp+VuamVF3UWN1fJfP5+eJUgiK7FXhjnvgr4/VKdnqIh1?=
 =?us-ascii?Q?feL8ZqCCVkDo5HPJhRHNBHSpnpLj/XmP3xG66yVX9f2pUAuAXN/jHJATiM4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6235255e-c217-4304-52f5-08dd513b93c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 23:17:28.0626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB9192

From: Roman Kisel <romank@linux.microsoft.com> Sent: Tuesday, February 11, =
2025 5:43 PM
>=20
> To run in the VTL mode, Hyper-V drivers have to know what
> VTL the system boots in, and the arm64/hyperv code does not
> have the means to compute that.
>=20
> Refactor the code to hoist the function that detects VTL,
> make it arch-neutral to be able to employ it to get the VTL
> on arm64.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c      | 34 ----------------------------------
>  drivers/hv/hv_common.c         | 32 ++++++++++++++++++++++++++++++++
>  include/asm-generic/mshyperv.h |  6 ++++++
>  include/hyperv/hvgdk_mini.h    |  2 +-
>  4 files changed, 39 insertions(+), 35 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 173005e6a95d..383bca1a3ae2 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -411,40 +411,6 @@ static void __init hv_get_partition_id(void)
>  	local_irq_restore(flags);
>  }
>=20
> -#if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
> -static u8 __init get_vtl(void)
> -{
> -	u64 control =3D HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
> -	struct hv_input_get_vp_registers *input;
> -	struct hv_output_get_vp_registers *output;
> -	unsigned long flags;
> -	u64 ret;
> -
> -	local_irq_save(flags);
> -	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> -	output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> -
> -	memset(input, 0, struct_size(input, names, 1));
> -	input->partition_id =3D HV_PARTITION_ID_SELF;
> -	input->vp_index =3D HV_VP_INDEX_SELF;
> -	input->input_vtl.as_uint8 =3D 0;
> -	input->names[0] =3D HV_REGISTER_VSM_VP_STATUS;
> -
> -	ret =3D hv_do_hypercall(control, input, output);
> -	if (hv_result_success(ret)) {
> -		ret =3D output->values[0].reg8 & HV_X64_VTL_MASK;
> -	} else {
> -		pr_err("Failed to get VTL(error: %lld) exiting...\n", ret);
> -		BUG();
> -	}
> -
> -	local_irq_restore(flags);
> -	return ret;
> -}
> -#else
> -static inline u8 get_vtl(void) { return 0; }
> -#endif
> -
>  /*
>   * This function is to be invoked early in the boot sequence after the
>   * hypervisor has been detected.
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index af5d1dc451f6..70f754710170 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -283,6 +283,38 @@ static inline bool hv_output_page_exists(void)
>  	return hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE);
>  }
>=20
> +#if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
> +u8 __init get_vtl(void)
> +{
> +	u64 control =3D HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
> +	struct hv_input_get_vp_registers *input;
> +	struct hv_output_get_vp_registers *output;
> +	unsigned long flags;
> +	u64 ret;
> +
> +	local_irq_save(flags);
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> +
> +	memset(input, 0, struct_size(input, names, 1));
> +	input->partition_id =3D HV_PARTITION_ID_SELF;
> +	input->vp_index =3D HV_VP_INDEX_SELF;
> +	input->input_vtl.as_uint8 =3D 0;
> +	input->names[0] =3D HV_REGISTER_VSM_VP_STATUS;
> +
> +	ret =3D hv_do_hypercall(control, input, output);
> +	if (hv_result_success(ret)) {
> +		ret =3D output->values[0].reg8 & HV_VTL_MASK;
> +	} else {
> +		pr_err("Failed to get VTL(error: %lld) exiting...\n", ret);
> +		BUG();
> +	}
> +
> +	local_irq_restore(flags);
> +	return ret;
> +}
> +#endif
> +
>  int __init hv_common_init(void)
>  {
>  	int i;
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index a7bbe504e4f3..bb36856c3467 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -314,4 +314,10 @@ static inline enum hv_isolation_type
> hv_get_isolation_type(void)
>  }
>  #endif /* CONFIG_HYPERV */
>=20
> +#if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
> +u8 __init get_vtl(void);
> +#else
> +static inline u8 get_vtl(void) { return 0; }
> +#endif
> +
>  #endif
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 155615175965..0f8443595732 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -1202,7 +1202,7 @@ struct hv_send_ipi {	 /*
> HV_INPUT_SEND_SYNTHETIC_CLUSTER_IPI */
>  	u64 cpu_mask;
>  } __packed;
>=20
> -#define	HV_X64_VTL_MASK			GENMASK(3, 0)
> +#define	HV_VTL_MASK			GENMASK(3, 0)
>=20
>  /* Hyper-V memory host visibility */
>  enum hv_mem_host_visibility {
> --
> 2.43.0
>=20

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


