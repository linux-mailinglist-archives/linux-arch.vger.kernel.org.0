Return-Path: <linux-arch+bounces-10664-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FADA5AD05
	for <lists+linux-arch@lfdr.de>; Tue, 11 Mar 2025 00:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 513923AF489
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 23:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464FB221542;
	Mon, 10 Mar 2025 23:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="I72JgchD"
X-Original-To: linux-arch@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011038.outbound.protection.outlook.com [52.103.13.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6491117332C;
	Mon, 10 Mar 2025 23:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741649193; cv=fail; b=OxYjltu2YGfdMbSsyVJ8ICg9m8KFOALsggZg204kPlio8xGmby7y606a9RywjxBajIhQAtRXDWwA2WFjGtjDVOJfItbxKOSLzCbhb4Jn3m22/2c8Y+fOqaYnYIhix9QUmoIg/UVBbBJW2wQRY49kQhFE2ZA3W9W0ddVlUT1uOAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741649193; c=relaxed/simple;
	bh=JIjLv+oIuvnlCP7A9MLzbHvj94KLPsPZdIG68kDH8Gs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Csscc17I0cTYPofTbZ3ToYaJOYq/iP6awcZbUDVcQfLbICQxrHBXabOdXmircpwQI+S0aR4DRJ2d9JptNzdRt6806/7HRDNzDnaDsKfaHR+sv4HyOpcInTirT0+iz/iyCBEkMzMMzF/bLOKF1qVm9QnLT61pVPCWtD1U+YaWRWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=I72JgchD; arc=fail smtp.client-ip=52.103.13.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ajp0NmcH6HTv0sNx5NUq1d7d2dBVqKCHcwa7BTMvWgJhO4I5ejrTvN06LmS7m6Z9mEb+BWJpQA5z9h6++1OtwNZPxw+sRt6YvQoneUMQUqKlBzpUx1u24RTDpR0dMf7k4an3Mns+w9DlgpOj8dFXr2sMJHR6fk70y9BKAX0TAu/2SWX7fbUO2Kppj0w+/PBJPfPf9UVOarSycj16Riapm6zhuW9hviQBL+KjI97GxRA2Vui//0EZvMepoZmzwXMmc4KRizujxAMLYK18GlkMk1VJSYxqMIeq+pQKFLnaR9JzNLFHsVaV1RplZEJKWjVO1RaqFilg82Rihch8T4TdIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHsgBKeyYWsVs5LSLW1A7nMSqh8ic8Pi4x56UBXMzuM=;
 b=d1nKWVXEcFiZS9BWJ9v7WGI5/i1uDwY+du0AE1i1RxbmqPr3x71li7X3RA5Aei8yohGQnOMjBGCL43bA4e5KjLCVRcK4nmvUr9JoSYKd67/DWnLFMgE4LjBu8GMV6HQ4pj91e8tav4kpeh59OPVmaHkj3Qxnr4/LAx0kTTLupy2Lf4qgvmYss2kY7JAqV1STDChUedxyeys1eU3z6RORxQu3DZsXglXLQnb6lH55OdmVfm3lGdGvuIsoZNtZnx/W2bw3qwsCfjMlnyb2X2ZWe2+Rk4jfnm1KqzEEYH86lppYBwc9nBjJXHQpQ4AmQjY3EWP7VTV5eRW62b8pMDc4oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHsgBKeyYWsVs5LSLW1A7nMSqh8ic8Pi4x56UBXMzuM=;
 b=I72JgchDeg8SSZlRGtkisNj2ZUbTNQxW1AiBnZPLECEUcUeswLFWg2HnIyiSfiMeW+DWH0etYwMexec6bNLa8vylIU7o1IZnFrI4R3diq6ZLdnm/ji8ZLFPt7mnvDQvCsGd/a9OzWiQSIsIYqnLFSVgRLvK0WUaEOBwlmqcICvRqX9kretMprK0aEE2QBbdQh+T56MbeAvQsaqknS/WbaF8zfmvczIRhOpNhwLik2c+UMXHf5EbmKBFZGSu/WGGcr64KZkI8f85RWA7kxnh9C/LoKV5i0C4H+2/g00IE5YiZg1r4ZxUh3R5FcMgKU6G2RWnJO15cRDzRRXGb92bTTg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CYXPR02MB10265.namprd02.prod.outlook.com (2603:10b6:930:de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 23:26:28 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 23:26:28 +0000
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
Subject: RE: [PATCH hyperv-next v5 10/11] ACPI: irq: Introduce
 acpi_get_gsi_dispatcher()
Thread-Topic: [PATCH hyperv-next v5 10/11] ACPI: irq: Introduce
 acpi_get_gsi_dispatcher()
Thread-Index: AQHbj60q0kiMzHfDAEOpT69BLMQC1rNtBngA
Date: Mon, 10 Mar 2025 23:26:28 +0000
Message-ID:
 <SN6PR02MB41570D82338A45E13B7A3689D4D62@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250307220304.247725-1-romank@linux.microsoft.com>
 <20250307220304.247725-11-romank@linux.microsoft.com>
In-Reply-To: <20250307220304.247725-11-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CYXPR02MB10265:EE_
x-ms-office365-filtering-correlation-id: f8635f16-a65a-4595-5923-08dd602afbdf
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|8062599003|8060799006|15080799006|461199028|12121999004|41001999003|440099028|102099032|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3p6405cN5MITk/ynfMygVxTnsnfgKkw5IXW4gcyF/VRE/TeReQATiXzR+rLK?=
 =?us-ascii?Q?zbIVLZ801qQXHZZVRAgrKUaNvEPqKnYISP5rvicLNhmVft3nmoBJyPEziB2f?=
 =?us-ascii?Q?D37yRVaUHb3euwvL/5XkAUXKlZLNolpdlUouew9LjpxIMBIOraWUdJks7JPf?=
 =?us-ascii?Q?Kpm7xz9exeT2sVdRfUDE7ot/UaWtKmA5VwoYaSL6lnmAAAERnUhvKs2hjCPI?=
 =?us-ascii?Q?7RbflrvZyusS8gU7ch1NyfOWOhBlEa0ZIcqi4T1zncY2o4RzcbgUxDMz3BHK?=
 =?us-ascii?Q?WpHRUZMxKFoAh/WFCe3wBjc8QPFtpGgzI9Fs8g7fXNna+5+CaTIbLvYCTJcb?=
 =?us-ascii?Q?5eN3CCf0q71JeYAoWYsCAgUDPVqbJG6cmR4cTeDocUIn0SA4pRk7SyE4t/s9?=
 =?us-ascii?Q?PYR9dV30oftBq4qt230jHLnf+xoFvb8X2AEZAvglWqiTyBOKjbzLpF0yyj7M?=
 =?us-ascii?Q?1Jgf9Rmyb42y/6lnoe8tiUmUn+PdDY5z/hEQJNGelv0bkY1uh8XVMpSznefY?=
 =?us-ascii?Q?DAEz1COFdLrrLji9eeafDm4Kz5GlNePhdPt/hBeAnMDMVdETBiy16RdP67lh?=
 =?us-ascii?Q?qS8kPieWhuvB/WZKnMTqaIUbGHUi4ycZ4XOB6HmZCZV61PHji1xBBM0RcoKZ?=
 =?us-ascii?Q?eEyj3PmL26vd+/vo9ShnHsMXgpwbErdrjuwCCscjNwqBT3se7wEKjJUerB0n?=
 =?us-ascii?Q?MwzcRkKW44FMfAntTkJfM4HkN7FSQ+1m468sQroOJpYL0lCcJ0RlayBYeZfA?=
 =?us-ascii?Q?tfkG/sjNtYadKXUWiOkAdJpi0wBdy8KmhOGNpr6vdG134bI1VemXjg/BOQtD?=
 =?us-ascii?Q?dW1StfBe4lKUHD2TJyFMegeqOf5I0JYsUrviy24Xs+I8L2hObZnkrf79hDru?=
 =?us-ascii?Q?g/zUZhVy3zGGPNTFiDa730V/Cw7VJOfXML72JlW8VzrFDm6pyOO90yI6vbLI?=
 =?us-ascii?Q?y6SATG19M6ZHdVSaW8/dbEU+tcGaFiuFjbll7FLCJNV5RiKD82bLo5dXhTMS?=
 =?us-ascii?Q?9oTAvYZyqhhVpFzGlY5kDxT5skN1PQeuKOLww6xH/zPnTH7+qM+3JwUQvQ2u?=
 =?us-ascii?Q?eKPu9kUqSkWmVSfqxhNA+8D02+42eTqivg0rv6Clc/qeCz9cu24=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2bovsa1yPwRRDgxmRPy6+wIION6eCcG0f27BLYl01S9+OId0hxRkWN7vbUOJ?=
 =?us-ascii?Q?7/x4QPSHTWXA9a6dc8/oTzMyf7E1DRs7vLsyGzQdWUZSDccX3gtC5uxWjR3g?=
 =?us-ascii?Q?Gj5YcicDYac2gDE73hlwDhdFsmq+Bu3LNCFuRbeNMiNgEc2vY4YoG/gHkPHd?=
 =?us-ascii?Q?JD3S48daTzllfnHqmkvA6Bv1ILumjMpKitXN8KP6QPu5cpasMq7erBztFwgf?=
 =?us-ascii?Q?OzdW+8qj9Xpscu92qMz160RmsUPaP3SVXuwq8fmu3OgM/m0n5nIpnjphXUrq?=
 =?us-ascii?Q?e+mRwPRCF46MVrKmnOvSz+Njgm2tS0N/pYtRKSz6kZk44hN5PGgfoUik0+HQ?=
 =?us-ascii?Q?B2JV5LNYzYyJZl+Bkc+trV+13H5/RCZ81G/8tFJUpNBMRi/2AMjn3YAwZtTW?=
 =?us-ascii?Q?Naz7p5V8DM8mfj0hb1aF4uJfMbKjr0cmbJqvDhS1zqOWyK2LXUwTBkBYbH+h?=
 =?us-ascii?Q?aTitFN7/I2dSFBJ+jEZSVcGDt3TVea+Cf56g7XCuZFpyjEANRTK93ce4l6MA?=
 =?us-ascii?Q?gzjaYHkvBRSlzaZItoUYJErbINd8KKubDWIxGgVAlLI0W5IEkS6zzNYxS50y?=
 =?us-ascii?Q?hgt67JTnoaECn6Kn8kw8Qja2dK+cYXeZqmbp1ZSizUkgWzWj1nHXu0K3X46s?=
 =?us-ascii?Q?NZlGJ3/emZ3b5BbPCdp99MmawgkagScQv2AMn2b65P9ZJRbycA5VPNWB9e6s?=
 =?us-ascii?Q?fGZwWzxDtm7JSY95yG8rmr0XELd66NO8DyFAQbL8Beapn/LPP/YJaBFREbKc?=
 =?us-ascii?Q?40ZShH/x3n66iH7v0Tnl2UE9RzHoY99aMLX78rSJlNfOmd/JmpIveD67z9v8?=
 =?us-ascii?Q?xC7bsvkeX0x58UTEMxdZa33qpJ1JYHUeyqlBxSxsvRawxfFbgAP2f2SilxQ4?=
 =?us-ascii?Q?II9wBKQ0mdc7ZrwIVFG180Jd/DU4GRTpCiJ9Ka+f3ECuLWSrl2GG3TF8W8Yi?=
 =?us-ascii?Q?INP1NxB/XGLLSPvRYZcfrh3pJ0oUHAVQlL74ekZFAZTioAeCIKQsFWOS6veK?=
 =?us-ascii?Q?CoLdRm2JsfdtwYJCtq00vKlWpVXYlGnY/laVyB4zmtb1juA4iBize2izNT5+?=
 =?us-ascii?Q?OpYj8W3oKGqpqu2eYTphS6plu9vT6cdijP7FMHI6bOrdtBD07SUpdifekP1j?=
 =?us-ascii?Q?xUboAF+nEhNIA3uUGXLrxyxnEd7HDwAWJkxoI47yUTyWvT857ziVfgFCLXSq?=
 =?us-ascii?Q?SBmI+qar8XIbD1rSrnwwMqHbVnJGqfLuZeff+1W5Vmc98cdkJZmasmuMcjA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f8635f16-a65a-4595-5923-08dd602afbdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 23:26:28.6571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR02MB10265

From: Roman Kisel <romank@linux.microsoft.com> Sent: Friday, March 7, 2025 =
2:03 PM
>=20
> Using acpi_irq_create_hierarchy() in the cases where the code
> also handles OF leads to code duplication as the ACPI subsystem
> doesn't provide means to compute the IRQ domain parent whereas
> the OF does.
>=20
> Introduce acpi_get_gsi_dispatcher() so that the drivers relying
> on both ACPI and OF may use irq_domain_create_hierarchy() in the
> common code paths.
>=20
> No functional changes.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/acpi/irq.c   | 14 ++++++++++++--
>  include/linux/acpi.h |  5 ++++-
>  2 files changed, 16 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
> index 1687483ff319..6243db610137 100644
> --- a/drivers/acpi/irq.c
> +++ b/drivers/acpi/irq.c
> @@ -12,7 +12,7 @@
>=20
>  enum acpi_irq_model_id acpi_irq_model;
>=20
> -static struct fwnode_handle *(*acpi_get_gsi_domain_id)(u32 gsi);
> +static acpi_gsi_domain_disp_fn acpi_get_gsi_domain_id;
>  static u32 (*acpi_gsi_to_irq_fallback)(u32 gsi);
>=20
>  /**
> @@ -307,12 +307,22 @@ EXPORT_SYMBOL_GPL(acpi_irq_get);
>   *	for a given GSI
>   */
>  void __init acpi_set_irq_model(enum acpi_irq_model_id model,
> -			       struct fwnode_handle *(*fn)(u32))
> +	acpi_gsi_domain_disp_fn fn)
>  {
>  	acpi_irq_model =3D model;
>  	acpi_get_gsi_domain_id =3D fn;
>  }
>=20
> +/**
> + * acpi_get_gsi_dispatcher - Returns dispatcher function that
> + *                           computes the domain fwnode for a
> + *                           given GSI.
> + */
> +acpi_gsi_domain_disp_fn acpi_get_gsi_dispatcher(void)
> +{
> +	return acpi_get_gsi_domain_id;
> +}

This new function is needed by pci-hyperv.c. It will
need to be marked as EXPORT_SYMBOL_GPL since
pci-hyperv.c can be built as a module.

> +
>  /**
>   * acpi_set_gsi_to_irq_fallback - Register a GSI transfer
>   * callback to fallback to arch specified implementation.
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 4e495b29c640..abc51288e867 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -336,8 +336,11 @@ int acpi_register_gsi (struct device *dev, u32 gsi, =
int triggering, int
> polarity
>  int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
>  int acpi_isa_irq_to_gsi (unsigned isa_irq, u32 *gsi);
>=20
> +typedef struct fwnode_handle *(*acpi_gsi_domain_disp_fn)(u32);
> +
>  void acpi_set_irq_model(enum acpi_irq_model_id model,
> -			struct fwnode_handle *(*)(u32));
> +	acpi_gsi_domain_disp_fn fn);
> +acpi_gsi_domain_disp_fn acpi_get_gsi_dispatcher(void);
>  void acpi_set_gsi_to_irq_fallback(u32 (*)(u32));
>=20
>  struct irq_domain *acpi_irq_create_hierarchy(unsigned int flags,
> --
> 2.43.0
>=20

I'm not at all expert in ACPI code and IRQ domains, but the changes
here look reasonable to me. Modulo adding the EXPORT_SYMBOL_GPL,

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

