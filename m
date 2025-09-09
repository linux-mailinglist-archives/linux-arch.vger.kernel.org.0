Return-Path: <linux-arch+bounces-13438-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C28DB49FB2
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 05:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190614E6861
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 03:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF58B25A2DE;
	Tue,  9 Sep 2025 03:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FFdBpnc5"
X-Original-To: linux-arch@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012018.outbound.protection.outlook.com [52.103.11.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6C51531F9;
	Tue,  9 Sep 2025 03:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757387415; cv=fail; b=UBwC//rgxyk6vZVUTuU8g1wowJaJ3JwKOfT4SF1fedSRZtL605zBuD5nvGL1WPrR2XTiuANk27EWOHwg3iR6HVLJmRbeOpnd1buYmtpaTrr9MrgyZ8pIOLW2MmSxz6UWHWFU8vjUYHlLCOh6MRxOoQ5KL4GWILEi0Y4ydi3Nv48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757387415; c=relaxed/simple;
	bh=iEQ1nYLKMHrKFVWmUFkfoETM8Evj4/SGYffbs05kUDM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MoE3cDrcbrMSlwPrLMcswXNNAmtGMLLy2AA+y0+8dKY/1vl3nIHwhE2uChTZqnnTATH1fXFiJGyUMyxKTB56NijZKIIIFvfKkrJFqKM95c1rk8PrUBf/F31vP2hd24QT9vWTCF1h+wfxkvDC66XdYJ72MGbslZEcgLY2SYkbgNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FFdBpnc5; arc=fail smtp.client-ip=52.103.11.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQeywQCDQK1iwsLWlODl9dovA3OcQ5YslkB51v7awdnIKaU1VEPVtqy1sVPN2BBSKIj0vD3gcLE33s4cEU9rMsrMN1jaSSfXnP3qs/rSMsPhSEJ/Z+tquXGzOA72PV4EakHxz2d+p3g8Obx8ZlAtyrY16Rn/VNvDO+LlXsR2l1NXmIE6sZqIJ80pwWaG8pql04XwPUiva2ynhenCufTEKzZoBzLy6GFsNqS3LgvsvkBSKXuuJYWAzGcISTVTfqe/gdVWgk9hI5e1m6V/h1jKlxRDiADuFrY8gBSHLsjOd9WN74/2j09fptt4K5Vsr/Qbi5YLDPlHz6ynSYo/9Yt9qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnGGM5g79Ll4WlnOyUzIZCi/AjXrF5LrRiCFyXhSRMk=;
 b=ilddl1m1+cg4wBPNrSAqPhmcwYHE2MeqomndljFrRNzgQeBH3JX1ADh1WklX+ZbrcZGySLO1WZWjWIbXUXYHa+jSm4YFkchmD/KIPQVz4Js7X9ikyv6cP6z5/xC6/f3rn3v+4V7cGKiegJ6auW5hI5hNz6AfJPze6OXGaiQPxrmVH0lZFRmA0IF99UfSZXown11DAD3x9X9uM5lAXr2NNHZEeMdLSfuwm+av6jNNIxVPiA9QFlvm/YMqFiS3s74V1WTDhwwsHMWxPAdZSS2QzyiGlYj4PsDKGRq49xaMUPCFYTni60rMAJjheKpvbM59xeQlPokm6LBnlkklkKpLxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnGGM5g79Ll4WlnOyUzIZCi/AjXrF5LrRiCFyXhSRMk=;
 b=FFdBpnc5L1xf7mKNy14qSmcmKDjKbDfWRiWVjcp+hIr1xrksANcBDb58JFCU8GTG04tdyD27mkyUoTKs3Bp6P4SeB4UjhMU3Lbt2u2RZVGRunVGIdgQMSS9/iqqO4Cv2fsBoULZAu/Kwjcx+2CCPuKLn1nuPjLYSZJ8cSnLnoWTmDzURqZvih6uqESxFenUsgXgnHIepEXGbCDq1gs8YK2HTke+3kI3Xk64mb4qynV14GT4VDR/ab4Y1uv+wzx/tt1kwhoQOmnVxEXHTMfT2E69OT88DyM8fiV9FpV+5NcgtJp6DXpAb9+CzUxM1ZjaVN4mbquXL9w07H5w1kdw3gw==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by DM8PR02MB8055.namprd02.prod.outlook.com (2603:10b6:8:18::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Tue, 9 Sep
 2025 03:10:08 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef%4]) with mapi id 15.20.9094.018; Tue, 9 Sep 2025
 03:10:08 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "mikelley@microsoft.com"
	<mikelley@microsoft.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "Tianyu.Lan@microsoft.com"
	<Tianyu.Lan@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
CC: "benhill@microsoft.com" <benhill@microsoft.com>, "bperkins@microsoft.com"
	<bperkins@microsoft.com>, "sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v5 02/16] drivers: hv: VMBus protocol version
 6.0
Thread-Topic: [PATCH hyperv-next v5 02/16] drivers: hv: VMBus protocol version
 6.0
Thread-Index: AQHcF7gHl/PHUZ2kukqTmJlNxnzcIbSKGeww
Date: Tue, 9 Sep 2025 03:10:08 +0000
Message-ID:
 <BN7PR02MB414893B0F1E600B08B182BA4D40FA@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20250828010557.123869-1-romank@linux.microsoft.com>
 <20250828010557.123869-3-romank@linux.microsoft.com>
In-Reply-To: <20250828010557.123869-3-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|DM8PR02MB8055:EE_
x-ms-office365-filtering-correlation-id: ba32db16-fbbb-400f-80f1-08ddef4e61cd
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|41001999006|19110799012|8062599012|13091999003|461199028|31061999003|15080799012|3412199025|440099028|40105399003|12091999003|102099032|56899033;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1hdRYvING+5spYV0o3yWOoGCbl/aBWwmZbWshLbT48KQ/5BBJRKYZFohRfv3?=
 =?us-ascii?Q?AZyI99+pId67w2ZK61CEF5y/JnwzgbLD/aink7pZHafFLpUbJV+AESp8bktu?=
 =?us-ascii?Q?bXtRF5AKzxbNRDCdGAgOsVMZu+lj4rC5j4BUFP8dGgIpLyJO4/eEKpvRrUW6?=
 =?us-ascii?Q?s/+LIKRFWMKqGBTtrvFP8vwf/NltIcmIBFRfR7bmHJTxwDCwuiEx/wBET8AF?=
 =?us-ascii?Q?H6VfgfVTIoB1YZJtUFDrqcdIZfcQAtroc2TaC3VfX9dNYzLN32XO6Lcs+F8c?=
 =?us-ascii?Q?JUYuJWj9ZUu4zswt0uziJA4ali2wjsGWZ0rFaSBWhFh1nFGeIphrHcvpW12d?=
 =?us-ascii?Q?vHu0Sjcqgg2tgWO5bKsZsjCSPv18V8an4zj95EoMFQyjSYc1fzv7tFhYd+bf?=
 =?us-ascii?Q?pEHPTv1yajfbTXiWndbcr3GCIC7krOhqeRYIVOSn6OisKGczF5gIsGKiaqpX?=
 =?us-ascii?Q?uARZzV1FnEUKWmoCBGJtkMChKZGD0ueGNOXvJd9dLvL1PsycDmTTWjPxxkCF?=
 =?us-ascii?Q?g652JG5SI5s0DgRCZWC03qvjb5GGUkfdwZJ1Qg2+ENsKSRjZNhWbDLfDtEAb?=
 =?us-ascii?Q?dSzvsvCH1Od6IbHGkJ9HxdSNQh2MhixP/KRXKOFYfxr/aWE4kIX8/khdxOON?=
 =?us-ascii?Q?uLsDvwNgean8IBBOSCXXwoNHTerohSH6pEWRMLMhwsYt7VICK+3D+5QmjdQc?=
 =?us-ascii?Q?7xU560Xy+liR4viSF7P52FScfM549A1WeZxTmPK0TfX35nw8AFjhBlVb5UQD?=
 =?us-ascii?Q?+TWu4+PrEM5w3T/BdOFMBFON0jFJ/7j6+3DjtGWZf83FL58hTzUCVJ2w/T49?=
 =?us-ascii?Q?xNtJF9lzl2+t9QTZLNdl7XuTfmN1tw6Xb+8yjeuiTKcuAIcE9Po88tIgfz4z?=
 =?us-ascii?Q?ZPBHKF78D8Xf157073AT0xk+VTfYqSdy2Nh72MirLrc+90Z7mdtbtPs5Wzq+?=
 =?us-ascii?Q?WA9RQr9MvwJEvDYvdJRHsIO+G5Sqg99geNruBSN74iscSOCR+CEqKWgW10sQ?=
 =?us-ascii?Q?XtXmz0MSfNIIb90TrFjPrx3r29ppJR9FwNA+dnOj5sW3IWIUrIr2iR0YIqsU?=
 =?us-ascii?Q?vTKOJ7h2NsGMR9nxaDztWck1XrNeo0U+qbBMgJjz0mwZfE6TO9bTTgYNPyd8?=
 =?us-ascii?Q?fm+n3hLcXHSpilO+C/IASoL5b0OxjZdeu5YBx2sS2nEFJBq9YS2duumMiDED?=
 =?us-ascii?Q?hR2ywXGl8MlXgdFmp7OWb+wNs/52OfM7d6+mKnz/LhVUIpZ+hLa2Y1xvoD4?=
 =?us-ascii?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MBBgZPlKWRawcmxsjcX/1i1SvAOUJM2iFwlbuIcgWoPEqRMmDQLn4T1eK7Qt?=
 =?us-ascii?Q?aWlgniRkmMGhdEhk1OAWCRRuZ1UuGBbuNbzXxFdCgOxq4gflUAxJ/HV4vw2T?=
 =?us-ascii?Q?jV/Qiep+13nCc+Xjy907RAO1b9keHf1XXhBx7ROQSfRsBQStOl8rznRxyjIH?=
 =?us-ascii?Q?HEUMsLn+X6f3PmbOtaDlihjjgqx1ad8qCaaVhClWHF0rqQkza9kvE6MBb6xF?=
 =?us-ascii?Q?ONaNaMCaz3lHswEdiyMOTmt2LWHVENIJCn09gWqvd+wmjtCGkudfeC+YcWuB?=
 =?us-ascii?Q?0WmaVKvmTRS5Kg35/R++mnt49MsQORj21xugVqq7E2tSCPU1FNddZsuxpxhN?=
 =?us-ascii?Q?onEh9+WxaBSud9KZiH2fXpBdrhxsvsA1om/KCpN0i7jNOPhjnptpGQf2jyjv?=
 =?us-ascii?Q?Zu4TpOxfI5JDQpM27iNzmCpuf/pw0LQDJW11XrON5X0UNF0bN28rX5UP2hjq?=
 =?us-ascii?Q?6NNlL/lugePXzr3N6zg2zY8E8x+x7LIWhIBwPPgVmJTPSs03i7XQ56rxvytc?=
 =?us-ascii?Q?NFdKB0GmsbCwGY+6LAeCRl5of9KaMaNKvbqVW2j5KbtcuWUGltPXqkyUTQ2g?=
 =?us-ascii?Q?I9duQx/u6l8QP2EGeULoLbEyLmg+HR/6v/WX9yvF7W5lb+PYGYEz5nxrNdrE?=
 =?us-ascii?Q?u08VgW6tJSyFUl7zSnIUUulJdKPO204kI6hMznZnBNpDRd40bS5eCewNJYHq?=
 =?us-ascii?Q?WPvE7IPj8I9+NQRWliKi/ZxzVkVDXXfJhodHhPTck1n2WhCcbjXD0gutHrAV?=
 =?us-ascii?Q?wXGy642fSi3rpmXWPhrjQ1aWXGR08OnfPEX1piv63H4ELfu0G3Dnnwn2Hn8b?=
 =?us-ascii?Q?hdyPYGi3LGcpNAoROwugoVSpcUYnmFM11QLugwvKXtgyPqTUaisIytQMVFiu?=
 =?us-ascii?Q?flfpnv2Pc3t+lhSzF4ilN7dYJUffBUIGh/SothDa+ch5rBtcN77RCcjX5DiN?=
 =?us-ascii?Q?fu+jOBKRghYK3VPtNJw4xYKy+xbRo6TRvA4jzAxjOC/wy2hKbfEbuLu4qNsN?=
 =?us-ascii?Q?ipXAT9TwdrNFhUDUS5dgGhNgVIbgxB37S5KOLB0bpyHUv/nLppUG/k8ivlCN?=
 =?us-ascii?Q?5HY+f8C+jyNGBgtpg6JI4Z5qAFS3PR9I0xYSrcvRxz92nZLJa6wWYVvjzkob?=
 =?us-ascii?Q?LD0j54Uzn7Sw3f3SDGnK4kopA2J3scxpTc4tEFyXs88kGPvcw90+k8Nmo0JP?=
 =?us-ascii?Q?NNFVTQ3tmvtzLlgEmwAHfi+5LGUiCnVmo1PWcKlHkI8gY0mlId+nBLSCzbw?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ba32db16-fbbb-400f-80f1-08ddef4e61cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 03:10:08.3707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8055

From: Roman Kisel <romank@linux.microsoft.com> Sent: Wednesday, August 27, =
2025 6:06 PM
>=20
> The confidential VMBus is supported starting from the protocol
> version 6.0 onwards.
>=20
> Update the relevant definitions, provide the x86-specific way to
> detect availability of the Confidential VMBus and provide a
> function that returns whether VMBus is confidential or not.
> No functional changes.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 19 ++++++++++
>  drivers/hv/hv_common.c         |  6 +++
>  drivers/hv/hyperv_vmbus.h      |  2 +
>  drivers/hv/vmbus_drv.c         | 12 ++++++
>  include/asm-generic/mshyperv.h |  1 +
>  include/hyperv/hvgdk_mini.h    |  1 +
>  include/linux/hyperv.h         | 69 ++++++++++++++++++++++++----------
>  7 files changed, 91 insertions(+), 19 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 25773af116bc..95cd78004b11 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -90,6 +90,25 @@ void hv_set_non_nested_msr(unsigned int reg, u64 value=
)
>  }
>  EXPORT_SYMBOL_GPL(hv_set_non_nested_msr);
>=20
> +/*
> + * Detect if the confidential VMBus is available.
> + */
> +bool hv_confidential_vmbus_available(void)
> +{
> +	u32 eax;
> +
> +	eax =3D cpuid_eax(HYPERV_CPUID_VIRT_STACK_INTERFACE);
> +	if (eax !=3D HYPERV_VS_INTERFACE_EAX_SIGNATURE)
> +		return false;
> +
> +	eax =3D cpuid_eax(HYPERV_CPUID_VIRT_STACK_PROPERTIES);
> +
> +	/*
> +	 * The paravisor may set the bit in the hardware confidential VMs.
> +	 */
> +	return eax & HYPERV_VS_PROPERTIES_EAX_CONFIDENTIAL_VMBUS_AVAILABLE;
> +}

This same code to read the VIRT_STACK_PROPERTIES CPUID is in
ms_hyperv_msi_ext_dest_id(). Now that we have two things based
off that CPUID value, I'd suggest the following:

1) Add a virt_stack field to struct ms_hyperv_info. That struct already
stores all the little flags fields that Hyper-V provides.
2) Populate this field in ms_hyperv_init_platform() along with all the
existing code that reads CPUID values and populates the other fields
in ms_hyperv.
3) Update ms_hyperv_msi_ext_dest_id() to check against the
virt_stack field instead of reading the CPUID.
4) Have hv_confidential_vmbus_available() also check against the
virt_stack field.

Arguably, you could drop hv_confidential_vmbus_available() entirely
(along with the stub in hv_common.c) and just have vmbus_bus_init()
directly test the flag in ms_hyperv.virt_stack. We decided long ago not
to add a plethora of accessor functions for flags in ms_hyperv, so
accessing ms_hyperv.virt_stack directly would be consistent with current
practice.

The virt_stack field would not be populated on ARM64, so it will be 0,
which produces the desired behavior.

> +
>  u64 hv_get_msr(unsigned int reg)
>  {
>  	if (hv_nested)
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 8836cf9fad40..fae63c54e531 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -716,6 +716,12 @@ u64 __weak hv_tdx_hypercall(u64 control, u64 param1,=
 u64
> param2)
>  }
>  EXPORT_SYMBOL_GPL(hv_tdx_hypercall);
>=20
> +bool __weak hv_confidential_vmbus_available(void)
> +{
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(hv_confidential_vmbus_available);
> +
>  void hv_identify_partition_type(void)
>  {
>  	/* Assume guest role */
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index b61f01fc1960..6e4c3acc1169 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -334,6 +334,8 @@ extern const struct vmbus_channel_message_table_entry
>=20
>  /* General vmbus interface */
>=20
> +bool vmbus_is_confidential(void);
> +
>  struct hv_device *vmbus_device_create(const guid_t *type,
>  				      const guid_t *instance,
>  				      struct vmbus_channel *channel);
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index a366365f2c49..8d9488c3174d 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -57,6 +57,18 @@ static long __percpu *vmbus_evt;
>  int vmbus_irq;
>  int vmbus_interrupt;
>=20
> +/*
> + * If the Confidential VMBus is used, the data on the "wire" is not
> + * visible to either the host or the hypervisor.
> + */
> +static bool is_confidential;
> +
> +bool vmbus_is_confidential(void)
> +{
> +	return is_confidential;
> +}
> +EXPORT_SYMBOL_GPL(vmbus_is_confidential);
> +
>  /*
>   * The panic notifier below is responsible solely for unloading the
>   * vmbus connection, which is necessary in a panic event.
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index dbd4c2f3aee3..acb017f6c423 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -332,6 +332,7 @@ bool hv_is_hibernation_supported(void);
>  enum hv_isolation_type hv_get_isolation_type(void);
>  bool hv_is_isolation_supported(void);
>  bool hv_isolation_type_snp(void);
> +bool hv_confidential_vmbus_available(void);
>  u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_=
size);
>  u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
>  void hyperv_cleanup(void);
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 79b7324e4ef5..4b189f9d39cb 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -260,6 +260,7 @@ union hv_hypervisor_version_info {
>  #define HYPERV_CPUID_VIRT_STACK_PROPERTIES	 0x40000082
>  /* Support for the extended IOAPIC RTE format */
>  #define HYPERV_VS_PROPERTIES_EAX_EXTENDED_IOAPIC_RTE	 BIT(2)
> +#define HYPERV_VS_PROPERTIES_EAX_CONFIDENTIAL_VMBUS_AVAILABLE	 BIT(3)
>=20
>  #define HYPERV_HYPERVISOR_PRESENT_BIT		 0x80000000
>  #define HYPERV_CPUID_MIN			 0x40000005
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index a59c5c3e95fb..a1820fabbfc0 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -265,16 +265,18 @@ static inline u32 hv_get_avail_to_write_percent(
>   * Linux kernel.
>   */
>=20
> -#define VERSION_WS2008  ((0 << 16) | (13))
> -#define VERSION_WIN7    ((1 << 16) | (1))
> -#define VERSION_WIN8    ((2 << 16) | (4))
> -#define VERSION_WIN8_1    ((3 << 16) | (0))
> -#define VERSION_WIN10 ((4 << 16) | (0))
> -#define VERSION_WIN10_V4_1 ((4 << 16) | (1))
> -#define VERSION_WIN10_V5 ((5 << 16) | (0))
> -#define VERSION_WIN10_V5_1 ((5 << 16) | (1))
> -#define VERSION_WIN10_V5_2 ((5 << 16) | (2))
> -#define VERSION_WIN10_V5_3 ((5 << 16) | (3))
> +#define VMBUS_MAKE_VERSION(MAJ, MIN)	((((u32)MAJ) << 16) | (MIN))
> +#define VERSION_WS2008 	VMBUS_MAKE_VERSION(0, 13)
> +#define VERSION_WIN7 	VMBUS_MAKE_VERSION(1, 1)
> +#define VERSION_WIN8 	VMBUS_MAKE_VERSION(2, 4)
> +#define VERSION_WIN8_1 	VMBUS_MAKE_VERSION(3, 0)
> +#define VERSION_WIN10 	VMBUS_MAKE_VERSION(4, 0)
> +#define VERSION_WIN10_V4_1 	VMBUS_MAKE_VERSION(4, 1)
> +#define VERSION_WIN10_V5				VMBUS_MAKE_VERSION(5, 0)
> +#define VERSION_WIN10_V5_1 	VMBUS_MAKE_VERSION(5, 1)
> +#define VERSION_WIN10_V5_2 	VMBUS_MAKE_VERSION(5, 2)
> +#define VERSION_WIN10_V5_3 	VMBUS_MAKE_VERSION(5, 3)
> +#define VERSION_WIN10_V6_0 	VMBUS_MAKE_VERSION(6, 0)
>=20
>  /* Make maximum size of pipe payload of 16K */
>  #define MAX_PIPE_DATA_PAYLOAD		(sizeof(u8) * 16384)
> @@ -335,14 +337,22 @@ struct vmbus_channel_offer {
>  } __packed;
>=20
>  /* Server Flags */
> -#define VMBUS_CHANNEL_ENUMERATE_DEVICE_INTERFACE	1
> -#define VMBUS_CHANNEL_SERVER_SUPPORTS_TRANSFER_PAGES	2
> -#define VMBUS_CHANNEL_SERVER_SUPPORTS_GPADLS		4
> -#define VMBUS_CHANNEL_NAMED_PIPE_MODE			0x10
> -#define VMBUS_CHANNEL_LOOPBACK_OFFER			0x100
> -#define VMBUS_CHANNEL_PARENT_OFFER			0x200
> -#define VMBUS_CHANNEL_REQUEST_MONITORED_NOTIFICATION	0x400
> -#define VMBUS_CHANNEL_TLNPI_PROVIDER_OFFER		0x2000
> +#define VMBUS_CHANNEL_ENUMERATE_DEVICE_INTERFACE		0x0001
> +/*
> + * This flag indicates that the channel is offered by the paravisor, and=
 must
> + * use encrypted memory for the channel ring buffer.
> + */
> +#define VMBUS_CHANNEL_CONFIDENTIAL_RING_BUFFER			0x0002
> +/*
> + * This flag indicates that the channel is offered by the paravisor, and=
 must
> + * use encrypted memory for GPA direct packets and additional GPADLs.
> + */
> +#define VMBUS_CHANNEL_CONFIDENTIAL_EXTERNAL_MEMORY		0x0004
> +#define VMBUS_CHANNEL_NAMED_PIPE_MODE 	0x0010
> +#define VMBUS_CHANNEL_LOOPBACK_OFFER 	0x0100
> +#define VMBUS_CHANNEL_PARENT_OFFER 	0x0200
> +#define VMBUS_CHANNEL_REQUEST_MONITORED_NOTIFICATION	0x0400
> +#define VMBUS_CHANNEL_TLNPI_PROVIDER_OFFER				0x2000
>=20
>  struct vmpacket_descriptor {
>  	u16 type;
> @@ -621,6 +631,12 @@ struct vmbus_channel_relid_released {
>  	u32 child_relid;
>  } __packed;
>=20
> +/*
> + * Used by the paravisor only, means that the encrypted ring buffers and
> + * the encrypted external memory are supported
> + */
> +#define VMBUS_FEATURE_FLAG_CONFIDENTIAL_CHANNELS	0x10
> +
>  struct vmbus_channel_initiate_contact {
>  	struct vmbus_channel_message_header header;
>  	u32 vmbus_version_requested;
> @@ -630,7 +646,8 @@ struct vmbus_channel_initiate_contact {
>  		struct {
>  			u8	msg_sint;
>  			u8	msg_vtl;
> -			u8	reserved[6];
> +			u8	reserved[2];
> +			u32 feature_flags; /* VMBus version 6.0 */
>  		};
>  	};
>  	u64 monitor_page1;
> @@ -1008,6 +1025,10 @@ struct vmbus_channel {
>=20
>  	/* boolean to control visibility of sysfs for ring buffer */
>  	bool ring_sysfs_visible;
> +	/* The ring buffer is encrypted */
> +	bool co_ring_buffer;
> +	/* The external memory is encrypted */
> +	bool co_external_memory;
>  };
>=20
>  #define lock_requestor(channel, flags)					\
> @@ -1032,6 +1053,16 @@ u64 vmbus_request_addr_match(struct vmbus_channel =
*channel, u64 trans_id,
>  			     u64 rqst_addr);
>  u64 vmbus_request_addr(struct vmbus_channel *channel, u64 trans_id);
>=20
> +static inline bool is_co_ring_buffer(const struct vmbus_channel_offer_ch=
annel *o)
> +{
> +	return !!(o->offer.chn_flags & VMBUS_CHANNEL_CONFIDENTIAL_RING_BUFFER);
> +}
> +
> +static inline bool is_co_external_memory(const struct vmbus_channel_offe=
r_channel *o)
> +{
> +	return !!(o->offer.chn_flags & VMBUS_CHANNEL_CONFIDENTIAL_EXTERNAL_MEMO=
RY);
> +}
> +
>  static inline bool is_hvsock_offer(const struct vmbus_channel_offer_chan=
nel *o)
>  {
>  	return !!(o->offer.chn_flags & VMBUS_CHANNEL_TLNPI_PROVIDER_OFFER);
> --
> 2.43.0
>=20


