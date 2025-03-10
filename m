Return-Path: <linux-arch+bounces-10654-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9028AA5A608
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 22:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1622E1894328
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 21:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0EF1E0DB5;
	Mon, 10 Mar 2025 21:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="j/Ad610Z"
X-Original-To: linux-arch@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19010005.outbound.protection.outlook.com [52.103.11.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA54A1BDAA0;
	Mon, 10 Mar 2025 21:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741641466; cv=fail; b=QwrGdFLwmqrdejW9UUKZBVvJrxxnDCMOwzpFoT3fsUDGVeuLn6E0xfgyefqZ+AtfzUNelOm91XvbPfMmW0G/ZfBK5ZRkP1ecJch7u7kIZBf69DMfCulvobh9I82OuxfSekpp6E9fMxwezrs0TrHIx9WF6qBTRsY2ZwsrnwOsyR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741641466; c=relaxed/simple;
	bh=0hvf1qZ1xx1Mt7/LFEn58XIVzGLCTDQlXBHtp2bPP48=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iP3HZi9eYktaHi57QjU9EvGupipPUV7LuovzzcqndywUcnlI+aWKKGKBhJAnNH8t3jFy62SLaQhQ/0AVX6EbxyeR6XXf/w8Od8gGLOZJ3F1E3YAYLSUTpaK+Cm/Ro8/M/5yeiu5zBkuIaeL4yXARO7sYKZTYbm17Z1VWZIJRi/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=j/Ad610Z; arc=fail smtp.client-ip=52.103.11.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d64hbmqaLtZP6YGeBk+giCwH9//s5vsqGMA5C5z+QXWGYsXKfq8Ieb8ClW9g7eKutHGhqpJmyvovC/iBEViFMC/StZGrf44AartEPF49JjGuThX10+aNCr4IE765ixuLj3zjt3qb3jJzD+NirUWylv/SUp0EiTYgn2vGlCT5t+yHrPR2Z8STfH8YZI5/zFYtjrLGeB6nTRDSa2CwsCSDWxXpW/Y0c3HIaWnM7ryFnKi8Y5sZnZpBEPVNV8ttoRa20pmtW7p/bSfY134oJ5QTNB4k7zPnW4fJHyoatzXapLa/rLNylQv4mwLGJBUj1ZSL16C2BClmdLLYQeqgmc0QPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXt3Z5f7/S8ccYY9MM4V/7LUgMP0xysLNyp61PkfcTQ=;
 b=OefPk7FzS1cvDAccNdv2HXNuAl4l5NNEl08KjpDFSoUy1H42gB/OxEOtXnT1kgU9/m+ekbTwqyGPAR52mjauHOh+eSPaR40WURSzCeFIzuagFDTNrXErBEI0jm1H+3LXBXaBovlyE57UIbNA+ergOPnLldVvehTj7Xy2p6rELsrRxs8C6N+GSTYzqlx07GvEq17tYqUcprI145ZBN2EZyoBJ1cZK+PdhyR0b0N9jPomu7XlzUyxZNZM5eCEIgv9lW5pUw9opNbGW/8wJZ5SNiktRUdn710eHbsWO3d9rrIipLcru37HtqLH+FFo9rUg7W0HrMMguAx2ZRNq9wdgxlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXt3Z5f7/S8ccYY9MM4V/7LUgMP0xysLNyp61PkfcTQ=;
 b=j/Ad610Z832bbcFi/9aX/3uZn+ZxVsDfQPJcFe68J7p43191Jk3xYq5iRlzpP+/gBE2px6lbgzBXGNKMoXiT2Os+6e4w3k230HGjF9fZjTWIfjrh6LorOUk5sPeny0AstKtu7ivjW3e+CpNngj7mrV9rJRNZtwynS7mpeSbmOdfvU3Qvn3twCaUJhgl1mb+V7jsshGqDcTWRxilzYHfquq2DE5XAx93rqwhMbpfGGqOHIb0x+xbI/PxzuX4iTFql59xnU9R7bWQgga1qgHdu4b2j6KgohtiHOdLPCMiHGlAgZWGAIAdaB09xvFPDaOhhuYONNOp/1Dj+8c2T/uABLw==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by CH4PR02MB10682.namprd02.prod.outlook.com (2603:10b6:610:245::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 21:17:41 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911%4]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 21:17:41 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "joey.gouly@arm.com" <joey.gouly@arm.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "lenb@kernel.org" <lenb@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "maz@kernel.org"
	<maz@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "rafael@kernel.org"
	<rafael@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>, "suzuki.poulose@arm.com"
	<suzuki.poulose@arm.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "will@kernel.org"
	<will@kernel.org>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v5 02/11] arm64: hyperv: Use SMCCC to detect
 hypervisor presence
Thread-Topic: [PATCH hyperv-next v5 02/11] arm64: hyperv: Use SMCCC to detect
 hypervisor presence
Thread-Index: AQHbj6zgflKUJy2gVEaT33EB4TlLprNs4/Ow
Date: Mon, 10 Mar 2025 21:17:41 +0000
Message-ID:
 <BN7PR02MB414898162A26B7424D92DDA7D4D62@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20250307220304.247725-1-romank@linux.microsoft.com>
 <20250307220304.247725-3-romank@linux.microsoft.com>
In-Reply-To: <20250307220304.247725-3-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|CH4PR02MB10682:EE_
x-ms-office365-filtering-correlation-id: e055dd90-2ca6-43ce-cf28-08dd6018fdf4
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|8060799006|461199028|8062599003|19110799003|41001999003|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Ygav4iM9FBOtuv+sIRQZ4Ue+rPiVuz9nzRtuLBsOdaGJeu2ZH3fFeKrOil6b?=
 =?us-ascii?Q?vc/etF0rWrKhQ3HPOsQ7bD0MUHe3Heonvvq9rGL2SNE2Z3kM4TGTEluU1Q0x?=
 =?us-ascii?Q?KPHoXttoEWqUoacJ8b30MKSWkdRpE/GHJAxIbr8E+v4C+wYzsYsShDOaDssZ?=
 =?us-ascii?Q?5ey5kNIzGfuL7EvttRVk1OnCnd/9if+p+9AWVk8Ok04Mt7RObBMbVAmCSWTa?=
 =?us-ascii?Q?u05r61IroxPWBIgvVVTdc91/ALUly6l5By4ChYchaeDjUarrxvYKNkNgNIJL?=
 =?us-ascii?Q?ICc6L1v/yPfk0O545j+iArUSFgybLK38t5SPZfyC1ySxjASyaLWztk/LyNhA?=
 =?us-ascii?Q?bmwV9sd6UIsyBIJvbLn2hYRa980WpFPCiSI1fztGfZyM2793juL0rAmUP67d?=
 =?us-ascii?Q?V0ra2HCaNk/grgbNbCBYFrONg8EuvrjA7SnjZnE9fbLhCNC2uiw3FHQY2BKp?=
 =?us-ascii?Q?dej4s2NhnY8oDFyyOTetUO3nI521m6SL9onDSp9/hWY+O9hDmkpTSnO5rdLb?=
 =?us-ascii?Q?NeZcaWxBkOFs+y7b7Q1VPF7ultxy9LXG0DALauJRBS0ViIHHCJ1XFnpXP3Ui?=
 =?us-ascii?Q?1tVz0V9PkD2UQSITQaPtnqa1/qBwBBvZwBPFRZIiqjRwZAl8Ii45FHmMMXTu?=
 =?us-ascii?Q?PX3096iIe/pKCdr9VFlUUSty3sfYpaC3mA56ltGKm8e0IComTPT33reSfT/o?=
 =?us-ascii?Q?rpwmH6w0064nx0clsNPfgpyEzFCa0td0hr56ES6LBAk3E+Hz9rT97Ui7QVlK?=
 =?us-ascii?Q?n2bB1RpuBJtwr/Y12NO5szcuvkX7uGjWXN5fPUD4AyqGnFL01oIQTDUB14oM?=
 =?us-ascii?Q?b/E1t1321dh8DTgLDA0YrOgh7skB+7A/dCcakER1dGZd63IkqzyH2/xLed94?=
 =?us-ascii?Q?ISqjbnwElRvJmG3UTUw3JQmgbnzaSVn8bJnYV8usb6WloPtEtfSGPZR6tigY?=
 =?us-ascii?Q?Hhi09i7x2xisU+8TcXymk7vSpLkKLZ/J1Tp3QzPCJfiNSX+Homp+A6kZg63h?=
 =?us-ascii?Q?s6FPcw51gIYtTp/Vad1YGTNBC/EEl+EiUfLnNmzKe7XNB9xWwLCJJDSio6d1?=
 =?us-ascii?Q?e8H7wRArkDVJ7sSN9EMxnnHX3axp8g=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?irg/E1VQP6mTKfs4eR1QH8ukm0TazXzv1meRZIBkguJvR2D5lFIeZt9ZpqwG?=
 =?us-ascii?Q?WpP6nwmVvMmerG5eeWg4pnE0B8MOpGMGDQP+uHp9nLvB2wg9hU+2oGuPee1k?=
 =?us-ascii?Q?4KRHSwAWg4Z24jbl1I4iU4wvUgU68p0MiFNxdStFNTvtDNeTmYzr/cNZD2Mj?=
 =?us-ascii?Q?rbCjyXF/Fo6LsbYsHf9akVzlnP9ZjG8s8qO9Jy0TAHmyyO/wDr9mNC9ZMrsz?=
 =?us-ascii?Q?dvmeKVQbXrSLFBMr//CHp7SfaJ79kAAyxE9af2H67zxWpRqxnpRQrDKUBjaF?=
 =?us-ascii?Q?mUATcg7u0CX5tfCWHerOn7+9c1qbx0OiV0R2XN8hSTqTnvsb7UxJFljvUxBv?=
 =?us-ascii?Q?SGotgGCiI2Lj4RxKuYkJPK7Oh3IFCx2vVrzp3gd+6c07XWumvGLlpXp2EFzh?=
 =?us-ascii?Q?wPEx1uwjSqUzj+7OBoNCuSO28t6XGCymveLnfaXbXXxL6GZm5AzIew/TzUPH?=
 =?us-ascii?Q?StUv19aoHNGc0S1+QrfvZhgp65INyuogEEDXya7XJKtjvIeX+6yxz3Oq/4ec?=
 =?us-ascii?Q?T0O4rBK6MkV2w5SpNNqY31C/klfTeEYYn12A1FN7MhRDY01DfBzOgH9Xq4ia?=
 =?us-ascii?Q?Ojn4LiRssHH6XRzWMctRvg9T1jBfeP/it+ba5G5HlNeRB5lnGmdMTJvLx2Wb?=
 =?us-ascii?Q?YFoJsdzxRBB9eg+/rnF02Z6Zlio2D4IjIkg8HxWKh2iakQcPs3UmXsdRL0hm?=
 =?us-ascii?Q?6sArcOhUpaTN37jEUWiB3tWvzg3QcdVjKePw/12ETUD+r7Odp2SmBW4VhXqM?=
 =?us-ascii?Q?+RHU/e9VMi8W0b2KRbnG+h+U3WnwrVYHGun/P1/YWKCnFU38/5R3G747gzqr?=
 =?us-ascii?Q?a9/Q7hBSgl7Soa/t2h9k+CWE8LmGCR4lzbGVYZCIOLl/EcULBq1NZ2+qL3oz?=
 =?us-ascii?Q?kgJ3dn/d3UNlcc5bZtxUdfAa01JompyE5gVQpPvMuwXWxVBt+9RYABLO4Ijj?=
 =?us-ascii?Q?IwcvL+7PvAptJPSLttge6fcdxaeLKueJgNhN8E6NO85W5gxy979fHRdCTMdj?=
 =?us-ascii?Q?bCQxPsNP/mzzqS83ucQ7WRMo8uS72hGOrXrl+RwkvK+SjD/FSHhXkT11DIGm?=
 =?us-ascii?Q?rOljD4CGvvvUwFRbLyt4cGIFHGVz3Aa6JhK6KYBC6EA4hL7z/W4kelgCHMPx?=
 =?us-ascii?Q?7ZQIdRS7cnIxRoByepMf4ly46tFm/uTuc98pZ1v1/gfOn4kuSbJafy1esXY3?=
 =?us-ascii?Q?oi+KEQPmY+hKrLwZfo+3xt+ITOzaN/TsT8MtQn3byH7gi3ZQ9anfZghpOQs?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e055dd90-2ca6-43ce-cf28-08dd6018fdf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 21:17:41.2539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR02MB10682

From: Roman Kisel <romank@linux.microsoft.com> Sent: Friday, March 7, 2025 =
2:03 PM
>=20
> The arm64 Hyper-V startup path relies on ACPI to detect
> running under a Hyper-V compatible hypervisor. That
> doesn't work on non-ACPI systems.
>=20
> Hoist the ACPI detection logic into a separate function. Then
> use the vendor-specific hypervisor service call (implemented
> recently in Hyper-V) via SMCCC in the non-ACPI case.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  arch/arm64/hyperv/mshyperv.c | 43 +++++++++++++++++++++++++++++++-----
>  1 file changed, 38 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index 29fcfd595f48..c647db56fd6b 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -27,6 +27,41 @@ int hv_get_hypervisor_version(union hv_hypervisor_vers=
ion_info
> *info)
>  	return 0;
>  }
>=20
> +static bool __init hyperv_detect_via_acpi(void)
> +{
> +	if (acpi_disabled)
> +		return false;
> +#if IS_ENABLED(CONFIG_ACPI)
> +	/*
> +	 * Hypervisor ID is only available in ACPI v6+, and the
> +	 * structure layout was extended in v6 to accommodate that
> +	 * new field.
> +	 *
> +	 * At the very minimum, this check makes sure not to read
> +	 * past the FADT structure.
> +	 *
> +	 * It is also needed to catch running in some unknown
> +	 * non-Hyper-V environment that has ACPI 5.x or less.
> +	 * In such a case, it can't be Hyper-V.
> +	 */
> +	if (acpi_gbl_FADT.header.revision < 6)
> +		return false;
> +	return strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8) =3D=
=3D 0;
> +#else
> +	return false;
> +#endif
> +}
> +
> +static bool __init hyperv_detect_via_smccc(void)
> +{
> +	uuid_t hyperv_uuid =3D UUID_INIT(
> +		0x4d32ba58, 0x4764, 0xcd24,
> +		0x75, 0x6c, 0xef, 0x8e,
> +		0x24, 0x70, 0x59, 0x16);
> +
> +	return arm_smccc_hyp_present(&hyperv_uuid);
> +}
> +
>  static int __init hyperv_init(void)
>  {
>  	struct hv_get_vp_registers_output	result;
> @@ -35,13 +70,11 @@ static int __init hyperv_init(void)
>=20
>  	/*
>  	 * Allow for a kernel built with CONFIG_HYPERV to be running in
> -	 * a non-Hyper-V environment, including on DT instead of ACPI.
> +	 * a non-Hyper-V environment.
> +	 *
>  	 * In such cases, do nothing and return success.
>  	 */
> -	if (acpi_disabled)
> -		return 0;
> -
> -	if (strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8))
> +	if (!hyperv_detect_via_acpi() && !hyperv_detect_via_smccc())
>  		return 0;
>=20
>  	/* Setup the guest ID */
> --
> 2.43.0
>=20

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


