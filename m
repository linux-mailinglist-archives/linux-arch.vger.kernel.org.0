Return-Path: <linux-arch+bounces-12970-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4C1B13D89
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jul 2025 16:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2DBC3BACF8
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jul 2025 14:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4666B2222A1;
	Mon, 28 Jul 2025 14:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pSOQweSI"
X-Original-To: linux-arch@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19011095.outbound.protection.outlook.com [52.103.23.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E94841C69;
	Mon, 28 Jul 2025 14:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753713844; cv=fail; b=U+wU9V6u4nKbp3lEUpM4WltEH8Zq4sE1HyKVwJNxq0w6zF/rdcoK7TM9kDMsKe4tVYS97Hzf4NfGE6kVtLe2rG0mFcJ/LKMkYQlxfufYdCvruWrmRrzYNOGR4ydyhstC80J41nQUYFveXdO8MU3YlNrQVpeya3+sE38AzouiyQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753713844; c=relaxed/simple;
	bh=J300bdOxYQVgf02LenM0Y+cfV3EONCzRIbn6gZiv03s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tfazj82KTs22AGDa0NCwxFsHyM27ha+t9j5loS8SASGgYcp7Y/mVsIYKUNNNiSLOeY+yq/cYLcfUJwYLcFvVwhjinsUfjfzrrdNvRG1SUxYBE60qBAw/uAPwF2txTtLp7fGwpySJg66fmqv4Cv2cMIJo1SJIytI3RuToVhmgEzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pSOQweSI; arc=fail smtp.client-ip=52.103.23.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XbAf5DS0CB/IUpig/C3pHUKtzRFUYhfqFHrYjldD9UJkUHGQsmaAP78ibK7z10rrg14avZg7vwiC4c+Z2fyzs6XanKFMikdpMYFGM8D3ZVGXYppRAzLIrU7DR+5lYXqdSv1U95dMDNEZ5DUqm8b6/LfXn4vYwWfGfIY5fGk387n8IGkcejrk9shKnBKITFziRiIeD+2Df52GcKgrvzUiU8Q/dO93cTdFI+vzDlqqCJGETZ1zWa1+1PpzzAe4IpIfW4EZBNXsZH4SAshT7O5bkj2WRl7Lsaei+vWWsx8ZmOd3dRgJLEPXGglD0CBH+gFeUlpcrmWdxrkzjDFCjZ/KHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y29crNM7ZP+Yj3KrWAUt6YpaZWy9tte13WcDAwe5lyE=;
 b=aWJDeLCqICtxvUXqDifXMV4HMgec8piKGB96+O6tOYYXd2PX8GKp8osdOwl/toOppe/c20cWbopLa/EuCdBBjW8BF0SJxSTCu+H3u6hWvrZooJKTHeTcxMp/8sNpHw8YL/pb97rRid5yHnHF2QjJsZykaLyjF+3xJ04AhkEP6ePT4/NW4Pi8yJqrQzlrAtUxL1SWTU/CLsgoz0rzrciNKulU9zPQExScmchFKthzsuORBRCIRsg4HqtpvCQb3sGMR0ChVHEqZ+wvrdJHmrmcMeL5EaT2yiJtgoVipB+nmWpOL17nsP+KMhjnhyg39+5M1REyjK8xnCL2Im7cfIK/1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y29crNM7ZP+Yj3KrWAUt6YpaZWy9tte13WcDAwe5lyE=;
 b=pSOQweSIcIEggZsY6r8hmPmA4klaUeGcjpGeY9signMKMPufjlrnbdWEV0dEmAL6UQ3fU+JThckkIvJeGss1FUb+mqsBTlIHKfpzpYxnQTrHQ3TY3Q5iPPWlhHDTtwg6dz+ZLkCngDZZHVcVmt35SKH4NliPqdWXJNnRYYsHszzyhfDzBCyNVtjA5K/AICtFBCutZOIC6IVUhROqkOK9sctxQnhEVHS3U/ctom6zmR5qksmvCrpeKljMtgLhkNllMKpTB/UlmrzlXUp5uGwlxAXxEjt3+UDcnIgX0+WvO/z3Pmgv0YG8rk6xNLhNQUC9/HCRWN3iqMIOMn+sP7/1wA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7783.namprd02.prod.outlook.com (2603:10b6:510:59::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Mon, 28 Jul
 2025 14:43:54 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8964.023; Mon, 28 Jul 2025
 14:43:54 +0000
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
Subject: RE: [RFC PATCH V4 1/4] x86/hyperv: Don't use hv apic driver when
 Secure AVIC is available
Thread-Topic: [RFC PATCH V4 1/4] x86/hyperv: Don't use hv apic driver when
 Secure AVIC is available
Thread-Index: AQHb/jNI52muzV4f+EC67zPjNfYTPLRHmTXQ
Date: Mon, 28 Jul 2025 14:43:54 +0000
Message-ID:
 <SN6PR02MB41576BB2286F0B05F7912868D45AA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250726134250.4414-1-ltykernel@gmail.com>
 <20250726134250.4414-2-ltykernel@gmail.com>
In-Reply-To: <20250726134250.4414-2-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7783:EE_
x-ms-office365-filtering-correlation-id: d2cd3da9-f771-422d-5422-08ddcde52d4c
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|15080799012|8062599012|19110799012|8060799015|461199028|440099028|40105399003|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?qpRZ8bokf0GhndQZptutO29P36k3ZAx6xsLxEzqOLdvEWy8+q9CKi42knrHX?=
 =?us-ascii?Q?reTmNMEoJO+7y+6MVnQOGTQC41A3LAaBDDZj+28DBkaAAUt16Q2L+p6NtCvq?=
 =?us-ascii?Q?3kkQaLz++o+tnG1koWXHMJKjNBnpF/4qa0WpAGSn1FACahc1SDUnURGok5xe?=
 =?us-ascii?Q?tvQQwbajsLt0ngIeiL3mBnHq+FSvmCzVZaSvO3QsQhE5MG1HFpKaNkpza/W1?=
 =?us-ascii?Q?IeVHJRDBnwMihifVZLKoKTvlvUz/CMs8cm3RpZjFTET+XBUCUkqbn4nYA/Bu?=
 =?us-ascii?Q?DYWDj6BPyU5husRqBuO8/5hjJZmfjqZLCpqhDvRPNMktK5z1REeGood7xhnv?=
 =?us-ascii?Q?mMcLu2pQ7nxPxzkybgn8cujIOFQk+XNtZJZZA4zqlirLmt/pMjgCHXuxJHtC?=
 =?us-ascii?Q?pUTLQOo+3YPlzAW9zaSqTfK+Hu/WdVaomA+O22JP/7m2r+K/ivezO/3LBquh?=
 =?us-ascii?Q?kyWpm5YBYVNP+09TF5pqfuwz2jVzNuecqOi92PEVCoGmG62NEvukxqhtRGks?=
 =?us-ascii?Q?bIvgXE/FdsewDQ76b3bTaSWp8G+g9EstGQ6O9i/lbTQpL871DRFXfJpcFtZ3?=
 =?us-ascii?Q?To+FNjuQMlkJQYYVpmQ3s2tM5+aApm2FcZjlog1xTI8KuOkKs5EZm3BJFt14?=
 =?us-ascii?Q?0kMjgYOYWahf6VasE5FnoLZbIP6ZsnUjwQP3vrluAGBw/DIhrzdYpB3flsm/?=
 =?us-ascii?Q?ZPy12FGnAcj0l9K2mfx8OIjJlQImP/p4WDuvQQEHpnEinxc6Q53DE/nKGFVt?=
 =?us-ascii?Q?jJBzVBr46Xx/+BDGPMD+cINYVw+d2ZLpciRfTJsn8WwaYOMxaXltf/Xi5nMV?=
 =?us-ascii?Q?IyHgcEOH/hXU0OBUgzyMH6/1eNaDXuwal+6RlSbI1ZQFBgxx2iKdkM699pYG?=
 =?us-ascii?Q?N15R0i+q4NUskmBo59ZTJb7FK19UXF7s8d7YsOetWnwLjFYYyzKlvI3tyNvT?=
 =?us-ascii?Q?ypHvbShE4hEwFXCiU2VB0zsxMVTt6cAcXjq0+mMJKpNsy9Ohof1DJCPe1XSc?=
 =?us-ascii?Q?WL1RFZFyDdpGMbBzw1HcOMJr9aTqG6VfRaNHUeJSYczSNglUiemR3tJ6QBpw?=
 =?us-ascii?Q?LGK1nSe1AUhfc4+zkT9yFAn7XVULaEnriFvO4QRVNDOcOr9jTxZWqIUQTwu3?=
 =?us-ascii?Q?dO5VcKq3VPHA7q16etGBanstvmXQFcyqrA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uW2gwbCNRrWrRrvxt7jXwrmWiSmuHXSv9tgQ8k/MtJoOcidtWOSPtu23A6Ys?=
 =?us-ascii?Q?Jfc/9Xe4RVKDOkNCGDymypQTkGify5EYuXK9k6wqfXbtlivm0ZMdBQYIV1jh?=
 =?us-ascii?Q?udFMUUzfHB66aG94G9080Fkj3LHpcHVd3p+iCoyGvbNZ9ZHPnhXM4L0Y1Cj6?=
 =?us-ascii?Q?S73m/uyQmtpxsFhaCwNxxw06bDHPWxiHkSVRZsGh0pH9FUcwOeoSI/EWalD6?=
 =?us-ascii?Q?ZEYN0ecfXnFow78/U2UCwOz3QbZ3Y1dVMRjCX6MjZIVtVdM/cldOqf5qC5ZN?=
 =?us-ascii?Q?ZfasPB9LUw/+f2O3VNem03is+55ad6HAgeTaEWLKubPjAC4KGZnc5syyI+vp?=
 =?us-ascii?Q?tiIO6WMfgeEVG0PelA9/ObB/0eIgVFHgieHZyJHjd4z9hIMq6yTuNylFbXtS?=
 =?us-ascii?Q?Vxs0rqcSfJBUbwm84YnVidh0L+rG+ws/Doyn7ddtyJNT0S+GL0KuLyoOZxF2?=
 =?us-ascii?Q?kb10nvvzVor3xix+4rK6WlFzG0Xm50GA6rFHRjXySQkFFGFEwGB5VCLAb90S?=
 =?us-ascii?Q?n7r3PhkDO9JUcVx8u4MlljO9l0BnhoC472keocWAtFW3z49l7syoA9cW+kFN?=
 =?us-ascii?Q?yO/h2Iu2EJZK8IEX6/WHCGbYEUly8Ad04uHkyyajxsG41hzzM0iL0DWU3zb1?=
 =?us-ascii?Q?iwDgPD0G4wjfcigoHuUT6CP0mEvJ1doP+GEJeh/gbvFVYHZQcMBtMpMDUx39?=
 =?us-ascii?Q?QHwJuO8tAeaQk+X6MpGjjfYBmNXCJ1Qu32sYncvUsXKuY/naNcKWS0wu7PA/?=
 =?us-ascii?Q?nlN/5Zb2Wn9EJ9isFHHJFo1IQmL54VmuNOS+M06eEW4z8ltoZ/4xLPpLTjGS?=
 =?us-ascii?Q?gc6sATfkDiuL8iCSKoZUdIH0L6ckzzE4NMNVoidYnVbY5Ia67G09Yry8cePA?=
 =?us-ascii?Q?FmHS3anz1RFGsCeRqJSQh26G9pGZyIYhl1xQK41ShqNy7x+EqkLlEtGnJC6N?=
 =?us-ascii?Q?N5+KlKFYjAcpZeikgo2uX42MPTgjPlaTkl6HQqqndgntqz63ka7jShpxdXSa?=
 =?us-ascii?Q?7PpfFbu5HvKKg2MAS3IsWdPivBRlly72oOX5nqe7EFaooLS26Knsckzref0f?=
 =?us-ascii?Q?E0oMtDBy5R5FfT0Kq4F9PqqDAQPT8yAfNq+vSJtOr/wCHYxrq5J4pPJdeKp6?=
 =?us-ascii?Q?V3PEXIlOmseczFuuadOg+IYokP2wsQZTQIYumNHXEuAy8quoqkpiWZR6r4I3?=
 =?us-ascii?Q?iFriLgIKkbxanikp+ctnjWRm/LS/t7q+3Dte2+0fegZM0wot6SqkRWKJ5Qs?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d2cd3da9-f771-422d-5422-08ddcde52d4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 14:43:54.7049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7783

From: Tianyu Lan <ltykernel@gmail.com> Sent: Saturday, July 26, 2025 6:43 A=
M
>=20
> When Secure AVIC is available, the AMD x2apic Secure
> AVIC driver will be selected. In that case, have hv_apic_init()
> return immediately without doing anything.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
> Change since RFC V3:
>        - Update Change log and fix coding style issue.
> ---
>  arch/x86/hyperv/hv_apic.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> index bfde0a3498b9..e669053b637d 100644
> --- a/arch/x86/hyperv/hv_apic.c
> +++ b/arch/x86/hyperv/hv_apic.c
> @@ -293,6 +293,9 @@ static void hv_send_ipi_self(int vector)
>=20
>  void __init hv_apic_init(void)
>  {
> +	if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
> +		return;
> +
>  	if (ms_hyperv.hints & HV_X64_CLUSTER_IPI_RECOMMENDED) {
>  		pr_info("Hyper-V: Using IPI hypercalls\n");
>  		/*
> --
> 2.25.1
>=20

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


