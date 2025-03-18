Return-Path: <linux-arch+bounces-10931-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8742FA67B80
	for <lists+linux-arch@lfdr.de>; Tue, 18 Mar 2025 19:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFDDA17FE14
	for <lists+linux-arch@lfdr.de>; Tue, 18 Mar 2025 18:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08451A9B52;
	Tue, 18 Mar 2025 18:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="maIyz2F5"
X-Original-To: linux-arch@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010003.outbound.protection.outlook.com [52.103.10.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED99EACD;
	Tue, 18 Mar 2025 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742320901; cv=fail; b=IHfhLEKmWr6hhqL0K7BmxIYLRYQH6cE2dwV0XMN83C1B5b1yWMw++npbUCxXZnw+MWEeU77QKviEscKt1maWZ/i46nULcyA/ohLE3Nd4UvpU+GQv1TBcrYnq7YPdsWNyJTM898WkQPGojbX1C9I65AaO4+MTTWVIC0JRVU2ReuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742320901; c=relaxed/simple;
	bh=3BMWm4YU13UlRrhl/laTyw4qNuXWO8EeSs7bqNCihU4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BDjvdU/jXpqLI6WY45Q9X5Bw3rmSVJ92Fiph8IzjBsxJqoYYFqywIKbAxBcqAKC95ew8j1nEY2oiQGPbL3SzTYAcsTHrdrahCUA1VSRYMcdth2EuArl6dlJNVnOa5i/XqX6CsN/rJKvehYdQqTkze3nV0Pxr5aGiWyqhZ4xMo2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=maIyz2F5; arc=fail smtp.client-ip=52.103.10.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vt71IrzkcWiPR1/Sj//kun2pyIONY4Y5PTyWVC8WOmIV3nAFMWMWMpD03zEUF6z/5p26DEnnVk7eczH3Umeh15/aTU+ZgwHA5DxBt0/BwQG5cyL/qc7+uIAVpUn9SpKnNC0GU5DOmi6JBTs1QppHP2KQsRNk86lq6H5Ep0JN3ani3uYi/eMjr+O7V2xfwTerwM4sVivvNdKrtqsq2F0mayrXYe2TIKv/Xjjs7HKhFZPfIMIUMfO9NZWhDFbtINfjCP9lkJMU/c+8xZrmD1klsxhdIA9SM3ShdxjgMVdZa5YWQl7LWpIdKQYnx+tV2o2ysGjS0bPlL4IsKaiIKhp/NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zs6BuVbvU5lrjLsBCqVc2BxjV8i/J1qbRdWpTdLuSl4=;
 b=r2yYTDw8C1Jnnxwob7mxn7+EUi5zyCPftwkEz5swH4W/AwJCnGs4qQF6Z2ooUhptevcW42nMARt2ghOQVS9QOTSxQr0Kz5H1RxQ8KD1ORMumGZ9sM9HJRLvf5WE3rSv7RR2DxyGWTOi1Ceopx9dguLpJljbEYgDYOECmY8QFcTwKjByH+vkxmCa9FvT/fzmte1tbRucGIyodTVOSoelTu6hBRmJo+G/ccmJKNaE19k/++0tolLQ3ouj9+cOacIQBO+MH7ToOde+SbrCZFKMpwcoyqdLDWTJMbr/Z5eSyymGfG4AuQRwwH5/pg/6bQKWp3BdX0EtjMsNzHoUmG5ybOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zs6BuVbvU5lrjLsBCqVc2BxjV8i/J1qbRdWpTdLuSl4=;
 b=maIyz2F5OGwDj6qDfy7vY9igfzzg97VeZn1R3t8VoKY/Ym2D3+gn4y4g+aJ2QGJHAmW4ntEl/RjNWbUYWGdaVq0+eRvQ1HjZWUQxIxom6WJTZfL66uqrEousoIzk8UuST7g+degGSA+fbbP9phLgJ8JmaYdck58I8qVKC0oStmoRaIym+ter8cqnn27jJ7W7IBadKI11UFs5WVOmCaytMTMACQwQl1QSwkiscNApsV9KBBIyVjTjpUfmme+2g6wF+PbwjCyzs3Z3b2PT1ufAyNjROX79Nrl4qt8zVfZpK5PtJZnS/E5HXfKTa7dXt29nYAR1p/NxdHdQD+S/d1+cqw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA3PR02MB9311.namprd02.prod.outlook.com (2603:10b6:806:312::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 18:01:36 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 18:01:36 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "ltykernel@gmail.com" <ltykernel@gmail.com>,
	"stanislav.kinsburskiy@gmail.com" <stanislav.kinsburskiy@gmail.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"eahariha@linux.microsoft.com" <eahariha@linux.microsoft.com>,
	"jeff.johnson@oss.qualcomm.com" <jeff.johnson@oss.qualcomm.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
	"muminulrussell@gmail.com" <muminulrussell@gmail.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
	"mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"apais@linux.microsoft.com" <apais@linux.microsoft.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "prapal@linux.microsoft.com"
	<prapal@linux.microsoft.com>, "anrayabh@linux.microsoft.com"
	<anrayabh@linux.microsoft.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH v6 01/10] hyperv: Log hypercall status codes as strings
Thread-Topic: [PATCH v6 01/10] hyperv: Log hypercall status codes as strings
Thread-Index: AQHblRdnD16Gq+LbxUi4ncmhWYIbZrN5MUUw
Date: Tue, 18 Mar 2025 18:01:36 +0000
Message-ID:
 <SN6PR02MB4157E630EC520DC487139372D4DE2@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1741980536-3865-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1741980536-3865-2-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1741980536-3865-2-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA3PR02MB9311:EE_
x-ms-office365-filtering-correlation-id: 6ff95d3d-d0e5-4367-adf1-08dd6646ecf1
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|15080799006|8060799006|461199028|8062599003|102099032|440099028|3412199025|13041999003|41001999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7mitemPgKrLecN2p0Lb41E69f0S4uYU+jbML0aus2w2SC3LsyqGmQ7fXFFOx?=
 =?us-ascii?Q?lZeL40nmgRevSvyisgfBhysg75+29JiLnvF+REpDabVGajFU4gVAGetYLz/9?=
 =?us-ascii?Q?5Q0fhS3+z74eIpemkX/44+AtCcUTY2RICbcCfp+awD93ZvRqQ1pT4Viuj84M?=
 =?us-ascii?Q?He87P3LB8t7RwztdIzFw62nLY+R4Gw3dcICHuDRpXlbVovw7l7VklQNmPSeF?=
 =?us-ascii?Q?HYWLsRRJC02UMckPI0Dnkp9lyZoT0P6FAJ5rk852ysx/qEm//KpQuGcoFQLe?=
 =?us-ascii?Q?pJlXFj5GDfS24Ap6Wjg3F3lrpcQ/wYifGfo0cn8e33PYvZhd6czDTW5I8H/n?=
 =?us-ascii?Q?opPdrWSwEivkEs+Hp4nO8Upaag3gtTSuHQvJsgH8w9VchIZdpy9eu2ncy7oZ?=
 =?us-ascii?Q?RioeEtLRrQkov96mz8MYpEHv6ATi4Iv7v3Adp2NkJz7chUABOqPcStwRcZeD?=
 =?us-ascii?Q?3BB6oDbRIbWnJlgm+LImJuiVQNHEgMv+HD3Y2WPfj4PljXSq4iGCRAg68Zpa?=
 =?us-ascii?Q?ZBypT/6GHTpbOeHLVmB7Ax1GiLcNUKnwF1frjBaTMJExUSvF+JY9RhUrMQOe?=
 =?us-ascii?Q?s78FpFhdTEe5sqYMyDIvP7RzaMtMgBvaQqvizNnBlykCxE2gGYGS7VCO7l+P?=
 =?us-ascii?Q?FrRUdtxqhWK5kui0qKlCWZRjEzZfMLlTcT8R7xILphUcDFkjpgwWK6vf5sp9?=
 =?us-ascii?Q?EGGK9O3QBWJ7TjPpH2XjWnqimSQAQvJWM0ny4J3I+mlhdYVj2gX6LR72KVRU?=
 =?us-ascii?Q?ixg2CAXK8hTKnA2ICTm5gh3QBGNSmzAfBlFWZF2a1jhFeDSbBMYZu8RmgH3h?=
 =?us-ascii?Q?ggfblJXIk9M06F1/ebxQwuzBbTRIAWdA0NsfPazjurJcSR07Q/CEASPnQ7Cf?=
 =?us-ascii?Q?5n1CLONyHZpM3+us82a+yooh9V2MiWn5v60RStaxtJicBwNYSxZhdNmB6RbR?=
 =?us-ascii?Q?1qH1+7tYHUiAdXQhnEonM9g8+yU0eLxowGsj1hNJBD4WbWToc4Pp651XvpRT?=
 =?us-ascii?Q?5mYy79OgqvLsXdO+Gqbo5x2KwZ7CDkjF6cYRcPm97F/xt7eAnvl2Y5GoFgT9?=
 =?us-ascii?Q?FNYYh8MNh8RoYXXlDr5GrrS92gnh3dINEKC3gWwxutFmDQZYULTSgjn99mlv?=
 =?us-ascii?Q?g/1juZGoqG5tO2ysh9bHOPSh6INYe9tR6g=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/iZDq1o+O9PoPRa8uQJTjXFXOAOZQcDYIolEpm4K5PA9/tDfiaMBYPVj44/2?=
 =?us-ascii?Q?FSnpBL0VaB+v7mWEXUkQ7qgNxozhVwXN9gT8QY8uD05o6VN12f6cdD31pUpX?=
 =?us-ascii?Q?wdSKcmS8osT5BvxCXTVVzn0BLBq6X4RbXxgZI33wiG2dfGVaerkxbgFJ0M8B?=
 =?us-ascii?Q?8EGe/+i5LUMcuMaxVCPgMNKDRCWM1n0RW5eQ0YQZNdNkVot+kVYLV9M1dHuB?=
 =?us-ascii?Q?d6WmXK+UtDvSONWTEBUHwPnQaaqpcNjOWN47PC6kwQqEV71Sr5OsytHOsLaH?=
 =?us-ascii?Q?cs7K7b1nLPACVrsa+tKD5d5DjR0N26TeIuX42rzbuhC5UnQPfdJ2EKnbaYNF?=
 =?us-ascii?Q?7fHwiJvaD3MEXC1Zbou6gU2hAfs+XDj42b4L6PKlE3BcJ6hiPFeNN7kdzke3?=
 =?us-ascii?Q?y/JeF78U43tGuklr/eGtYEnUGwf+ERDfpdbeGuY39QiM/TmPzzc/JZghRNkw?=
 =?us-ascii?Q?6j84ZDXdP5GdWzerVmTzuvJbP97iJ8R1PugliiaGftMf/SW9pLU3hs3zyjMT?=
 =?us-ascii?Q?00n4M2ghkwJavOK4K8Tfzpeh4HK4/xULDrIohcyfgXNdpR5N7Rt742yMZY9U?=
 =?us-ascii?Q?Lxul2OGjDQfv2wcU9Z1PYrMTx9yqao76vfTw4+oihrQKYIiUl5HgqlzJopPF?=
 =?us-ascii?Q?v4Fi3lRtefugsL4QGdoWISqMwmJ2sbID99pCZZ7oswV9B9QDtrKwYo3wNoMt?=
 =?us-ascii?Q?lDYLnf41m3/h8dUCKaonH0poCMzgW9Pj4WqrAATbH8KqI1oygqPDp8VSiD8y?=
 =?us-ascii?Q?NAEfmsI5chgu/A2dLEd4pMEcbdjEIO0qjhTWRq4WLgayxMU8yaBjbuBnRBFL?=
 =?us-ascii?Q?HignraN6t83myIDxSL+9Uiq1rKsJfGA642heVDz8+NrSb0ZshX510buGZ3qc?=
 =?us-ascii?Q?y94yjPIYu/zIH6i5thYwQj8jgtROQpPGvbGS9DUhnvcEYLqDeWKBvLv3saMl?=
 =?us-ascii?Q?B6qY2X1N1NitCNFg4c2jhLTLLLx52JiQ1BF/zpAjLnzmDT5Z2VmyqyGY6Cw7?=
 =?us-ascii?Q?2BoAFkXilxqxeng21RqLeIHNRPSm7mYqylo2f/76O7pSYGutzDoV6fsFRc3K?=
 =?us-ascii?Q?A6k24Tj8crLxgTNPyVLDadUPHrn06/txQonDmrtvx1+w68kRATI4jebOjmZ9?=
 =?us-ascii?Q?i54i8RNYxpJ4zmswD/rBVctElyrA+eLfAx/PkaSiVsXRZadwvwyfDgkxGq8A?=
 =?us-ascii?Q?10pDIItjbaLqQg8uZn5leP6rNtlk/bDvFvKfoOgTbL+SczQvQZmG+NT9D5s?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff95d3d-d0e5-4367-adf1-08dd6646ecf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 18:01:36.4878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB9311

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, March=
 14, 2025 12:29 PM
>=20
> Introduce hv_status_printk() macros as a convenience to log hypercall
> errors, formatting them with the status code (HV_STATUS_*) as a raw hex
> value and also as a string, which saves some time while debugging.
>=20
> Create a table of HV_STATUS_ codes with strings and mapped errnos, and
> use it for hv_result_to_string() and hv_result_to_errno().
>=20
> Use the new hv_status_printk()s in hv_proc.c, hyperv-iommu.c, and
> irqdomain.c hypercalls to aid debugging in the root partition.
>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  arch/x86/hyperv/irqdomain.c    |   6 +-
>  drivers/hv/hv_common.c         | 129 ++++++++++++++++++++++++---------
>  drivers/hv/hv_proc.c           |  10 +--
>  drivers/iommu/hyperv-iommu.c   |   4 +-
>  include/asm-generic/mshyperv.h |  13 ++++
>  5 files changed, 118 insertions(+), 44 deletions(-)
>

[snip]
=20
> +
> +struct hv_status_info {
> +	char *string;
> +	int errno;
> +	u16 code;
> +};
> +
> +/*
> + * Note on the errno mappings:
> + * A failed hypercall is usually only recoverable (or loggable) near
> + * the call site where the HV_STATUS_* code is known. So the errno
> + * it gets converted to is not too useful further up the stack.
> + * Provide a few mappings that could be useful, and revert to -EIO
> + * as a fallback.
> + */
> +static const struct hv_status_info hv_status_infos[] =3D {
> +#define _STATUS_INFO(status, errno) { #status, (errno), (status) }
> +	_STATUS_INFO(HV_STATUS_SUCCESS,				0),
> +	_STATUS_INFO(HV_STATUS_INVALID_HYPERCALL_CODE,		-EINVAL),
> +	_STATUS_INFO(HV_STATUS_INVALID_HYPERCALL_INPUT,		-EINVAL),
> +	_STATUS_INFO(HV_STATUS_INVALID_ALIGNMENT,		-EIO),
> +	_STATUS_INFO(HV_STATUS_INVALID_PARAMETER,		-EINVAL),
> +	_STATUS_INFO(HV_STATUS_ACCESS_DENIED,			-EIO),
> +	_STATUS_INFO(HV_STATUS_INVALID_PARTITION_STATE,		-EIO),
> +	_STATUS_INFO(HV_STATUS_OPERATION_DENIED,		-EIO),
> +	_STATUS_INFO(HV_STATUS_UNKNOWN_PROPERTY,		-EIO),
> +	_STATUS_INFO(HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE,	-EIO),
> +	_STATUS_INFO(HV_STATUS_INSUFFICIENT_MEMORY,		-ENOMEM),
> +	_STATUS_INFO(HV_STATUS_INVALID_PARTITION_ID,		-EINVAL),
> +	_STATUS_INFO(HV_STATUS_INVALID_VP_INDEX,		-EINVAL),
> +	_STATUS_INFO(HV_STATUS_NOT_FOUND,			-EIO),
> +	_STATUS_INFO(HV_STATUS_INVALID_PORT_ID,			-EINVAL),
> +	_STATUS_INFO(HV_STATUS_INVALID_CONNECTION_ID,		-EINVAL),
> +	_STATUS_INFO(HV_STATUS_INSUFFICIENT_BUFFERS,		-EIO),
> +	_STATUS_INFO(HV_STATUS_NOT_ACKNOWLEDGED,		-EIO),
> +	_STATUS_INFO(HV_STATUS_INVALID_VP_STATE,		-EIO),
> +	_STATUS_INFO(HV_STATUS_NO_RESOURCES,			-EIO),
> +	_STATUS_INFO(HV_STATUS_PROCESSOR_FEATURE_NOT_SUPPORTED,	-EIO),
> +	_STATUS_INFO(HV_STATUS_INVALID_LP_INDEX,		-EINVAL),
> +	_STATUS_INFO(HV_STATUS_INVALID_REGISTER_VALUE,		-EINVAL),
> +	_STATUS_INFO(HV_STATUS_INVALID_LP_INDEX,		-EIO),
> +	_STATUS_INFO(HV_STATUS_INVALID_REGISTER_VALUE,		-EIO),
> +	_STATUS_INFO(HV_STATUS_OPERATION_FAILED,		-EIO),
> +	_STATUS_INFO(HV_STATUS_TIME_OUT,			-EIO),
> +	_STATUS_INFO(HV_STATUS_CALL_PENDING,			-EIO),
> +	_STATUS_INFO(HV_STATUS_VTL_ALREADY_ENABLED,		-EIO),
> +#undef _STATUS_INFO
> +};
> +
> +static inline const struct hv_status_info *find_hv_status_info(u64 hv_st=
atus)
> +{
> +	int i;
> +	u16 code =3D hv_result(hv_status);
> +
> +	for (i =3D 0; i < ARRAY_SIZE(hv_status_infos); ++i) {
> +		const struct hv_status_info *info =3D &hv_status_infos[i];
> +
> +		if (info->code =3D=3D code)
> +			return info;
> +	}
> +
> +	return NULL;
> +}
> +
> +/* Convert a hypercall result into a linux-friendly error code. */
> +int hv_result_to_errno(u64 status)
> +{
> +	const struct hv_status_info *info;
> +
> +	/* hv_do_hypercall() may return U64_MAX, hypercalls aren't possible */
> +	if (unlikely(status =3D=3D U64_MAX))
> +		return -EOPNOTSUPP;
> +
> +	info =3D find_hv_status_info(status);
> +	if (info)
> +		return info->errno;
> +
> +	return -EIO;
> +}
> +EXPORT_SYMBOL_GPL(hv_result_to_errno);
> +
> +const char *hv_result_to_string(u64 status)
> +{
> +	const struct hv_status_info *info;
> +
> +	if (unlikely(status =3D=3D U64_MAX))
> +		return "Hypercall page missing!";
> +
> +	info =3D find_hv_status_info(status);
> +	if (info)
> +		return info->string;
> +
> +	return "Unknown";
> +}
> +EXPORT_SYMBOL_GPL(hv_result_to_string);

I think the table-driven approach worked out pretty well. But here's a vers=
ion that
is even more compact, and avoids the duplicate testing for U64_MAX and havi=
ng
to special case both U64_MAX and not finding a match:

+
+struct hv_status_info {
+	char *string;
+	int errno;
+	int code;
+};
+
+/*
+ * Note on the errno mappings:
+ * A failed hypercall is usually only recoverable (or loggable) near
+ * the call site where the HV_STATUS_* code is known. So the errno
+ * it gets converted to is not too useful further up the stack.
+ * Provide a few mappings that could be useful, and revert to -EIO
+ * as a fallback.
+ */
+static const struct hv_status_info hv_status_infos[] =3D {
+#define _STATUS_INFO(status, errno) { #status, (errno), (status) }
+	_STATUS_INFO(HV_STATUS_SUCCESS,				0),
+	_STATUS_INFO(HV_STATUS_INVALID_HYPERCALL_CODE,		-EINVAL),
+	_STATUS_INFO(HV_STATUS_INVALID_HYPERCALL_INPUT,		-EINVAL),
+	_STATUS_INFO(HV_STATUS_INVALID_ALIGNMENT,		-EIO),
+	_STATUS_INFO(HV_STATUS_INVALID_PARAMETER,		-EINVAL),
+	_STATUS_INFO(HV_STATUS_ACCESS_DENIED,			-EIO),
+	_STATUS_INFO(HV_STATUS_INVALID_PARTITION_STATE,		-EIO),
+	_STATUS_INFO(HV_STATUS_OPERATION_DENIED,		-EIO),
+	_STATUS_INFO(HV_STATUS_UNKNOWN_PROPERTY,		-EIO),
+	_STATUS_INFO(HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE,	-EIO),
+	_STATUS_INFO(HV_STATUS_INSUFFICIENT_MEMORY,		-ENOMEM),
+	_STATUS_INFO(HV_STATUS_INVALID_PARTITION_ID,		-EINVAL),
+	_STATUS_INFO(HV_STATUS_INVALID_VP_INDEX,		-EINVAL),
+	_STATUS_INFO(HV_STATUS_NOT_FOUND,			-EIO),
+	_STATUS_INFO(HV_STATUS_INVALID_PORT_ID,			-EINVAL),
+	_STATUS_INFO(HV_STATUS_INVALID_CONNECTION_ID,		-EINVAL),
+	_STATUS_INFO(HV_STATUS_INSUFFICIENT_BUFFERS,		-EIO),
+	_STATUS_INFO(HV_STATUS_NOT_ACKNOWLEDGED,		-EIO),
+	_STATUS_INFO(HV_STATUS_INVALID_VP_STATE,		-EIO),
+	_STATUS_INFO(HV_STATUS_NO_RESOURCES,			-EIO),
+	_STATUS_INFO(HV_STATUS_PROCESSOR_FEATURE_NOT_SUPPORTED,	-EIO),
+	_STATUS_INFO(HV_STATUS_INVALID_LP_INDEX,		-EINVAL),
+	_STATUS_INFO(HV_STATUS_INVALID_REGISTER_VALUE,		-EINVAL),
+	_STATUS_INFO(HV_STATUS_INVALID_LP_INDEX,		-EIO),
+	_STATUS_INFO(HV_STATUS_INVALID_REGISTER_VALUE,		-EIO),
+	_STATUS_INFO(HV_STATUS_OPERATION_FAILED,		-EIO),
+	_STATUS_INFO(HV_STATUS_TIME_OUT,			-EIO),
+	_STATUS_INFO(HV_STATUS_CALL_PENDING,			-EIO),
+	_STATUS_INFO(HV_STATUS_VTL_ALREADY_ENABLED,		-EIO),
+	{"Hypercall page missing!", -EOPNOTSUPP, -1}, /* code -1 is "no hypercall=
 page" */
+	{"Unknown", -EIO, -2},  /* code -2 is "Not found" entry; must be last */
+#undef _STATUS_INFO
+};
+
+static inline const struct hv_status_info *find_hv_status_info(u64 hv_stat=
us)
+{
+	int i, code;
+	const struct hv_status_info *info;
+
+	/* hv_do_hypercall() may return U64_MAX, hypercalls aren't possible */
+	if (unlikely(hv_status =3D=3D U64_MAX))
+		code =3D -1;
+	else
+		code =3D hv_result(hv_status);
+
+	for (i =3D 0; i < ARRAY_SIZE(hv_status_infos); ++i) {
+		info =3D &hv_status_infos[i];
+		if (info->code =3D=3D code || info->code =3D=3D -2)
+			break;
+	}
+
+	return info;
+}
+
+/* Convert a hypercall result into a linux-friendly error code. */
+int hv_result_to_errno(u64 status)
+{
+	return find_hv_status_info(status)->errno;
+}
+EXPORT_SYMBOL_GPL(hv_result_to_errno);
+
+const char *hv_result_to_string(u64 status)
+{
+	return find_hv_status_info(status)->string;
+}
+EXPORT_SYMBOL_GPL(hv_result_to_string);

It could be even more compact by exporting find_hv_status_info() and
letting  hv_result_to_errno() and hv_result_to_string() be #defines to
find_hv_status_info()->errno and find_hv_status_info()->string,
respectively.

Note that in struct hv_status_info, the "code" field is defined as "int"
instead of "u16" so that it can contain sentinel values -1 and -2 that
won't overlap with HV_STATUS_* values.

Anyway, just a suggestion. The current code works from what I can
see.

Michael

