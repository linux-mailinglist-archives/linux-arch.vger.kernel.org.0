Return-Path: <linux-arch+bounces-12370-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1870ADF24A
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 18:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0B3F189C619
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 16:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546752F0047;
	Wed, 18 Jun 2025 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BcFJsFXV"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2014.outbound.protection.outlook.com [40.92.40.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8AF2EF2B0;
	Wed, 18 Jun 2025 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263473; cv=fail; b=mZilPpbslbCEHAGimrqgG4X9e55f/R6tmmFKRwHMScqdlKZdRHRFQ8tyCZFpTPf6xNRGtUfHD+TgD7v1wbL8LVrBPL4+ZnbsMcwRmcAcwcYAEdGIMKzcBkNy4S94YyNPJuSb8OuiIfVVSkzqmrGkL0H5gGbyvS0S1Pvf/qZoEfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263473; c=relaxed/simple;
	bh=KD93HYZeA4zrvtzLY5bxj3kchxBiRvfAQob/zJSo/Qw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UOmwZN4ew2wFj3Z0eHeSCwuoYlMIwxnMhE7ANQpp/1MdzfHhnswRAv4qRGE10JBHWbXGGsLKdz+dngfRQGeumBEvxti6zzuA1UD0FUbLTM36bQR132sayAFHwyu/aJsI73cowHNe4yNKMZvnlmU3NPYG2SE8pVwMSp3xTAG4bFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BcFJsFXV; arc=fail smtp.client-ip=40.92.40.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VcWfUOcNqNNDQ/8HaikKBHQ54zjRmwccAkbM6as1uCT2QFwjX1Y+zyENRc/6wP1DBRzffcBC3r/PhOVeXA9H7tnBxTDhFlFSq8UGGLauaiOhkO0AxhDO6rW0ojz7ph9esykHvk1NHv6FvWjZqyxzAIB/jJ4plZeIYBnatf+Fkku1ZJVLiw96HdRkGqx4quaBz+zxmNO+L3sYd11CVKK8AFuyPl+oEnx3zuC+b8NAkfgPCBbzDcYfTyz3YhtimzqTAFJM6fzb/giYC/lTF49UqFv18GnIEU4oD2e23M1Foq3arrQOC0oI+oVcN7ZDHpIpXdJfpJgobcXDdKt2R7XuQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+g6a7GcjUrou+Zc790pIdJVMH8Dd4XmTCVrYIAGiQY=;
 b=dK13o6CEllYS1HqK6L/t72b69y67CHDpPbDnqRp6SAybkNQHSgtUaUr/p1JWVU/7ETCxOYJpBDlSp0Hd0V3rnTDOmZDlVit4JdGPIDeDBaMzaUl5N4HT08vsiyXdSX+a02SGPwmL9Gywa3O9Wu4+fkHwO6coVf+Y4jiw/LqnGzdDiCN1BDCWW5RhSYw0BH5hpMctLgLI+EzWKVb1hEmPKkTkpSHb94KRGhddAsTfbRYSN5lUAGDuTqqGJ0qplIpEdpfSUdJvOAjwsfomAse6/8qHkl+RIRuM7J9M/H8ccSfumLVcZe1SSVzJoSoZkgNmR6Aql4JAsiY3BVayBN/vSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+g6a7GcjUrou+Zc790pIdJVMH8Dd4XmTCVrYIAGiQY=;
 b=BcFJsFXVuDO0GYbme36qkC88fU0LPWXtkpmW03DNToukfT0NLaRCsbZ470La8OLWS6YlPm8ompsY9alN6Y+Ap6TFyJaK0KbRoqFqigqZmtFcUrG0T2q/DP078F4eWenE0gvqOFpwndbxedtnK2OGaLGTqwuLTxcOgwuwqv7XTZRCFrjJhcRzWp/1ne/ckFpy25G+6fsPcfI1222PT/JNsaOk2kYZQE7VIHcKhu+o2snzVVoTWgcooO8olM4kaQfdJeEIROg8pBqfIRX2ycreH3aw0PldnprCGzOd4yQzOdUK2XEw7Z/XY3oFdekCtfciItlvdNjsv40r8AHI9/XWkQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA1PR02MB8462.namprd02.prod.outlook.com (2603:10b6:806:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 16:17:48 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 16:17:48 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "alok.a.tiwari@oracle.com"
	<alok.a.tiwari@oracle.com>, "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de"
	<bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v3 03/15] arch: hyperv: Get/set SynIC
 synth.registers via paravisor
Thread-Topic: [PATCH hyperv-next v3 03/15] arch: hyperv: Get/set SynIC
 synth.registers via paravisor
Thread-Index: AQHb1Om7xrpeH/6X4kK+U90cXiz3rLQB657g
Date: Wed, 18 Jun 2025 16:17:47 +0000
Message-ID:
 <SN6PR02MB415750DBD8B57234F840BF12D472A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250604004341.7194-1-romank@linux.microsoft.com>
 <20250604004341.7194-4-romank@linux.microsoft.com>
In-Reply-To: <20250604004341.7194-4-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA1PR02MB8462:EE_
x-ms-office365-filtering-correlation-id: 9f15c6de-4dc7-4cda-272f-08ddae83aa71
x-ms-exchange-slblob-mailprops:
 ZILSnhm0P3k1KuhwzYdE6C/ocrAmq9m0vis9VaFha6UM7PARXLFh6+NGLDzRfQ35EzkOSEDKnW0aV2ZgPz7ZIF6aJdsK4slOMchuvEfuea5RMgQQ882WOLjDdnwZvA9B5qAbN/qdgOv2DNIX/MEWqyV+mIu5i4fJPvgSr1alk0vassdEcTDLJnKfeDyG+Kpy5Ivuxm00nxSbw89DA33/i8Z70P3WIE2hZZm4dUY1L9/1eDlUbSf24uVKvjFXT5e9H+iSFkM6+WZgaQbk6C72lDytKwMxm/yt1GKqYkdWbPJLcKopTh3QKAWD6SBPuAjukFCu80/JQ4QhFntICpwbDSPAhlIbIFRQn1sGYVajmib2OnCUP2bxD/2yOtH3IP8owX5H5d6GNupM2LouWwPA3gPJ5aGwwMB1RciDSae1YIMF1HL9dOMastGiII744nf5/HCi/fCUihXB6O7v/LaTf83ym20dvmLbfELw5xpsx0kYkgmVohyxDTiCDcpoBidFx+PW91/ggLSlpeIThT+RRUAm/OU6dRwxc+nJHSurMEE/455zvDw7McqUURwc1qHvdpxDfuvNZqF+1AS/tF9RlG+wz8aK+gw+l7MdGBNZHc+5OiXhLEMro50t5QePFa2rX/YNhwx8pc4tKzIetj/g/6uAvXFH03N7tcVtTEvE9U/7mVbkwnA69X/VSadYz4/nib67rhHi3AE0eygchZU9aeU1kPb0HPzuhlwqTYhkbQwKxsCloUQ+LXqMkyXujxosz43NpbvJNTAdF0joJiIwgbQDmit58/Li
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799006|8062599006|15080799009|8060799009|41001999006|3412199025|440099028|40105399003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?MEFf0fY6W9bDbUwyHqBk4ncopqe1yKGlxGSdhsWEWgDcOXb4UVQSlBMMYBEj?=
 =?us-ascii?Q?CzbN4b8t4gpFhKpHJHYX9n1TTI861xnS/LUu2PlCEiQQkhw2LawnKkdhWPoV?=
 =?us-ascii?Q?GHFiOdFu2R87XTeFiNyhjGTRhD4jexRhJ17FGcMlR+qNIWxDz8qU7TbOl8j/?=
 =?us-ascii?Q?Lo0DUgSp63557Ak/UXnkaLOiF3b8p2ik/QzVr4tgrqqASmxv6C76t3d697YQ?=
 =?us-ascii?Q?5YDu76R4x4DwwBC5XxMP8R5lk5Slb57ob8c0e6jiTdMvhpRYJ/9Gjhw+Xfku?=
 =?us-ascii?Q?RBucT6Qv3V5nUkz/QvucjjbfndmZAhqpRSLoopyvCJQ51Ekaea6tpJDqC2iy?=
 =?us-ascii?Q?2lxK49CB/hz00snCDkuwbhHiI45+SIrzI5dMfqoIzP0S4bWLLqPil4i2KPqz?=
 =?us-ascii?Q?f+zcCBV8wv0HHD8uOZNh/l4p8i8LVAs5oiQXDVzUrF4ssdhhq6vgadPJ1/Rk?=
 =?us-ascii?Q?MYo1B67TeGaWf953IbIv+OasO6Qle7Fi0q5r12zgoIoyTZS+KPUpEigdbL2U?=
 =?us-ascii?Q?uiOHC2cPEb9t0yH+7rR/mXTSuxaX4RgxS97+pRQtv1f4pQS3pXSzPN75yVV6?=
 =?us-ascii?Q?hVo2qmifRTt0+mFWs+6mw2Ue6ninb1KjGl7OpqhHd0Ap10cKPMDNxbmHfHYy?=
 =?us-ascii?Q?dwANIKsYN6NyEla+npZl8Oom5T1zvloOr2ZggfbmxpFwPJbIy9ngIPD5U/qX?=
 =?us-ascii?Q?GDcI+XkIXBG63gOqRLRJtQvGsXunVNxUOndpGME/kjC/NmKDlHcGUfMyWMj6?=
 =?us-ascii?Q?6urjDtftapcWpBtZ9pTAkLVACQ6k6yF0JIbdHgmcpaaWvBbmd0jZnIZjcLjF?=
 =?us-ascii?Q?F/L4W091OamM7tIFnBHte2qr19o9pnd7YM84LwEK9LpDN1RyFU1PMKQRu/I4?=
 =?us-ascii?Q?SVgsJzfGrwiCvCsbnU0rysk9ruONnJjSTOPM3bTlB359rZBEVSnad3Anxew8?=
 =?us-ascii?Q?f7bgAzeqFk0XcifEZYaM0Bsfckg+4cE6TaIyUpZFew6v+jutB8g/yHliaqML?=
 =?us-ascii?Q?LBiEnY6E9qDCZj+enzwMQK/5xFW2nCKxe9OgiScCKXcVyPsALgO0+vvIM4z9?=
 =?us-ascii?Q?cWZEqdAZpzqaWbRYp35JJFxVGaTRnr2qIZHPiSNEfMuWq3gZOnxZqXE/M3Pb?=
 =?us-ascii?Q?ZYVUj4vovnt5l0QfEWPmRWyCse+qrst90A=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qpS6kF2E+SQBhfwDd/ihdV/ZZ6xIzT9ijeWeSjdso4fSJOR2nYziiAa3tKBi?=
 =?us-ascii?Q?L65xF0g/om2ukKgxrh1IAfZlkmzrhWZMcfOAOi2Rvr1c0huULwgXbEU/Hvq8?=
 =?us-ascii?Q?CDhao5VzbgJH0wx/OrgKVbSwGMT9p0Ln9CUXLTymac6bGKmcfqXgjHMvfCxp?=
 =?us-ascii?Q?N1XUQvl8k037dX/c7foKsMeQeAxSaVH0LnqgnzrfyVPz/qais3AgfpNGXVnG?=
 =?us-ascii?Q?m7mUD2CpqPI89Sovuf7ucmp0cRFwNJSYk5Ipl883zENB4cfDSkcH747yQdOS?=
 =?us-ascii?Q?WcwuCGui9dVNeGnBmaomhzGJrX9v9r+kQhv0V8oLrVcq8U5kRGS+S9QUcUCA?=
 =?us-ascii?Q?Dv50p2PgAVbhMHRoOiqvQlhHSieOJuJ+EjBW0BWeaTEu+3v3uTQFzmMA//B/?=
 =?us-ascii?Q?IedZ+GYc+7+/TqBvA/aznGcJuZc6ETpz2ro3fTu0u41v8VY+ZQf+cq0CfUKQ?=
 =?us-ascii?Q?SzQ+Ze2wjleSiikp5TQh4s2mC2/QUCJr3BQ8jjdgSYk/JR7Xj7aWn/+X8Yg3?=
 =?us-ascii?Q?aD3OkfdRPwtdSGz19uib3z8CMTT4+TDB4kv+OUz/3PiumBkA+hscqgkmX7Cl?=
 =?us-ascii?Q?b8STYiPmSzMkWejX/ezlSkYBMOuWh/7CcL/HvLxibFPRWiq4omOALLkM+UQ2?=
 =?us-ascii?Q?LUtvzUPMkBYG3DEGTd8HZHc35A9jWEFAF1ZwqNLTOljUYdKiTIRZzxBitWgz?=
 =?us-ascii?Q?HpS24G8yEmEGliAk9bUgjWrQN2M8caprLtGm9ufXQqlsetk/BOgreuzo5LED?=
 =?us-ascii?Q?FTn7FSKRJzFRDzApw9yp/JP0y8zxSNkoEEgauYdN2bVFjYTULsE64ZeR/HOA?=
 =?us-ascii?Q?jg7DypK5TCCTaIi+XoSSG1yBROaT37VrdqCyKgPQ4Ls5K7Vfud0+pnB4VYA2?=
 =?us-ascii?Q?a1U/fwQRNRRwgLLSXY3HkQxBivzuo3ei7TMHU2kxVoanez4IoY/DqzHYhs9U?=
 =?us-ascii?Q?1PN2f8oghPhiFeeCK+kRMagwY5GUuVFxnGuOPxet8jLrddGpESMzqxV2Hx9O?=
 =?us-ascii?Q?M1aOsGPLDcmDIU5WQTCgaCfTt2dl73s9HVYJrIYYpbvOr2IJQdUdf/69w9EI?=
 =?us-ascii?Q?6eDwShsJhtjy6n7A8ByP6ElTcJ3RfHZXyHBqnDFVHrBHUKbwOXfK8Jta1qhN?=
 =?us-ascii?Q?mqoyJV/7GEnY6Co6lN5dGXeBn/CwpOYmsf15Sab8RabU1OhYqx3cF8PuNFV2?=
 =?us-ascii?Q?DwgifrteEbDmoict29NWu8AKePZCRePEs23ai0VHddx1Qpp2KaUjCaM2T4k?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f15c6de-4dc7-4cda-272f-08ddae83aa71
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 16:17:47.9612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8462

From: Roman Kisel <romank@linux.microsoft.com> Sent: Tuesday, June 3, 2025 =
5:43 PM
>=20
> The confidential VMBus is built on the guest talking to the
> paravisor only.
>=20
> Provide functions that allow manipulating the SynIC registers
> via paravisor. No functional changes.

I'd like to see a little more detailed explanation for "why" the
new functions. Something like:

The existing Hyper-V wrappers for getting and setting MSRs are
hv_get/set_msr(). Via hv_get/set_non_nested_msr(), they detect
when running in a CoCo VM with a paravisor, and use the TDX or
SNP guest-host communication protocol to bypass the paravisor
and go directly to the host hypervisor for SynIC MSRs. The "set"
function also implements the required special handling for the
SINT MSRs.

But in some Confidential VMBus cases, the guest wants to talk only
with the paravisor. To accomplish this, provide new functions for
accessing SynICs that always do direct accesses (i.e., not via
TDX or SNP GHCB), which will go to the paravisor. The mirroring
of the existing "set" function is also not needed. These functions
should be used only in the specific Confidential VMBus cases that
require them.

And I'm not sure "No functional changes" is correct. This is adding
new functionality. It's not just a cosmetic change or code
refactoring.

>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 44 ++++++++++++++++++++++++++++++++++
>  drivers/hv/hv_common.c         | 13 ++++++++++
>  include/asm-generic/mshyperv.h |  2 ++
>  3 files changed, 59 insertions(+)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 3e2533954675..83a85d94bcb3 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -89,6 +89,50 @@ void hv_set_non_nested_msr(unsigned int reg, u64 value=
)
>  }
>  EXPORT_SYMBOL_GPL(hv_set_non_nested_msr);
>=20
> +/*
> + * Attempt to get the SynIC register value from the paravisor.
> + *
> + * Not all paravisors support reading SynIC registers, so this function
> + * may fail. The register for the SynIC of the running CPU is accessed.
> + *
> + * Writes the SynIC register value into the memory pointed by val,
> + * and ~0ULL is on failure.
> + *
> + * Returns -ENODEV if the MSR is not a SynIC register, or another error
> + * code if getting the MSR fails (meaning the paravisor doesn't support
> + * relaying VMBus comminucations).

s/comminucations/communications/

> + */
> +int hv_para_get_synic_register(unsigned int reg, u64 *val)
> +{
> +	u64 reg_val =3D ~0ULL;
> +	int err =3D -ENODEV;
> +
> +	if (hv_is_synic_msr(reg))
> +		reg_val =3D native_read_msr_safe(reg, &err);
> +	*val =3D reg_val;
> +
> +	return err;
> +}
> +
> +/*
> + * Attempt to set the SynIC register value with the paravisor.
> + *
> + * Not all paravisors support reading SynIC registers, so this function

s/reading/setting/

> + * may fail. The register for the SynIC of the running CPU is accessed.
> + *
> + * Sets the register to the value supplied.
> + *
> + * Returns: -ENODEV if the MSR is not a SynIC register, or another error
> + * code if writing to the MSR fails (meaning the paravisor doesn't suppo=
rt
> + * relaying VMBus comminucations).

s/comminucations/communications/

> + */
> +int hv_para_set_synic_register(unsigned int reg, u64 val)
> +{
> +	if (!hv_is_synic_msr(reg))
> +		return -ENODEV;
> +	return wrmsrl_safe(reg, val);
> +}
> +
>  u64 hv_get_msr(unsigned int reg)
>  {
>  	if (hv_nested)
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 49898d10faff..a179ea482cb1 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -716,6 +716,19 @@ u64 __weak hv_tdx_hypercall(u64 control, u64 param1,=
 u64
> param2)
>  }
>  EXPORT_SYMBOL_GPL(hv_tdx_hypercall);
>=20
> +int __weak hv_para_get_synic_register(unsigned int reg, u64 *val)
> +{
> +	*val =3D ~0ULL;
> +	return -ENODEV;
> +}
> +EXPORT_SYMBOL_GPL(hv_para_get_synic_register);
> +
> +int __weak hv_para_set_synic_register(unsigned int reg, u64 val)
> +{
> +	return -ENODEV;
> +}
> +EXPORT_SYMBOL_GPL(hv_para_set_synic_register);
> +
>  void hv_identify_partition_type(void)
>  {
>  	/* Assume guest role */
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index 9722934a8332..f239b102fc53 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -333,6 +333,8 @@ bool hv_is_isolation_supported(void);
>  bool hv_isolation_type_snp(void);
>  u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_=
size);
>  u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
> +int hv_para_get_synic_register(unsigned int reg, u64 *val);
> +int hv_para_set_synic_register(unsigned int reg, u64 val);
>  void hyperv_cleanup(void);
>  bool hv_query_ext_cap(u64 cap_query);
>  void hv_setup_dma_ops(struct device *dev, bool coherent);
> --
> 2.43.0


