Return-Path: <linux-arch+bounces-9302-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA1A9E8342
	for <lists+linux-arch@lfdr.de>; Sun,  8 Dec 2024 04:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE427165882
	for <lists+linux-arch@lfdr.de>; Sun,  8 Dec 2024 03:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43ECB1DA53;
	Sun,  8 Dec 2024 03:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="H2Bep+HJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2050.outbound.protection.outlook.com [40.92.19.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F511B95B;
	Sun,  8 Dec 2024 02:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733626800; cv=fail; b=hE+2RkPxxpfgykR+KBnxKStVgdKZD/b5WPPuY79O3CXq6/W1qxj7mAxU0P418WPuTP2/XviEYKNQTWq0R9BfYopFBvhkt8j5Q7UZMnJTd1DSf/ltY/oK9g2IgKvzPjYIhHrcF1DW7fRZWpEx69x+RaqRGmN/POYsBW+h4Se5G6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733626800; c=relaxed/simple;
	bh=fX9TarfOJQ8AS89qCzXAHRYJg6gdhPD6GAw92RPkrP4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p7eWC8gt/5Ukbyj6MROshznhB/adnuTH2JYR5EEVKCm5Gy6kI9E/Lb12wpy8dyPG2u4Y5inwBcWwilZQP/wOd+f1zv+x53V1z4bPHh3nhRi8qzSCHkoQ1PRJ67ri0aeW8hXngSG8G2bv96mMinMbdRT+/r/sc5kUIu0Hwcq6ATg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=H2Bep+HJ; arc=fail smtp.client-ip=40.92.19.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMtX9Knjiy1ZrTenr+arZAdqmNWLBhub4pudy3Ma+dOst4IiM7/cichlK/2v5l8zy1QEIs8BOOrqWOuGt9nITWuiKOJqjxoBsfdArugdI9iSTlnm14h6te9WPXAhp7j8fG8C9c5LaWvx9nQrq6VwrB75Ywwz5NBXOTdRY67jlM5FxQSavAYMmvDFXy2TeKf98G4qMTKpYrGJdnvw1UC6cniqUZKjSLVSelKu1pLyYkjB5IZg6NRMmNoc9DHex2EdbZPC875m0i5d9EQvmADqYJsXhRm0RHFsL7B4++d46gp64gJo1vZAcutRciwoyttkPzfC5IGBA5h8H2U6vDGZOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdu5uC0lzc8wPQk+gshdsrZMO90UwHOvaN8hs4yv7oo=;
 b=cHxXfWdqPRvx0KE4XM4taHC39F6jnjgY4zJliZFxiYJP+458PjiIA5e1dbHb2BCp5v8vU0NjEojRSZ1jc8d+Bl52ApJORFvWIeSu8RdRGZhzL1HQWEy2saccO9QgCNQcU8mXRws2tIIvNvrHKcxcoePZv8TkO1epC2rJSHcb709i558px/NveyVnuRH1AwKmWJ9bk2+S0NDHAMi0lAMSoPaG6bY+uPTMq58CAzLxmmxqlQ5rZ69vng/+3inZ4T9Tm65tsr1K2KId8g/L4CcamPpIq9wnjeJ25mqDaJTAWMAl2q73YSQiT4Q2A1U9iiR1B6TbQqzpI544gdOAB4Np6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdu5uC0lzc8wPQk+gshdsrZMO90UwHOvaN8hs4yv7oo=;
 b=H2Bep+HJYfoodXx39bmc/I183HkbI61h5Qxe3WUeIArRvC7zXus2s+wXsuPrHh6FbQZs3nu7WJDspfxONON3E9e7Ll0H05Bm0ym/XjqGRzQsZtipMzDOblP6DyfBQJ9206HDew7CJEZnKZPyB4cGS9BSuDVgaMk1psEOUH6pDsF/YzHhdW2bMMAHHFZNxr4vigELmWYK+xNBEMU/6napv0fCs33ogX8wxJ6sXTx1HcY/5fp9WHnLFGsLi2sMNv856mH5Jcxwjt077wJs6pNAxWv3aCVxTtFZexOo2eiG24Lp9dIXb3ItWNYXcAMIaqXSqpPW6wOk3xaAnYPoFILwYw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB8485.namprd02.prod.outlook.com (2603:10b6:510:10e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Sun, 8 Dec
 2024 02:59:54 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8207.020; Sun, 8 Dec 2024
 02:59:54 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "arnd@arndb.de"
	<arnd@arndb.de>, "jinankjain@linux.microsoft.com"
	<jinankjain@linux.microsoft.com>, "muminulrussell@gmail.com"
	<muminulrussell@gmail.com>, "skinsburskii@linux.microsoft.com"
	<skinsburskii@linux.microsoft.com>, "mukeshrathor@microsoft.com"
	<mukeshrathor@microsoft.com>
Subject: RE: [PATCH 0/2] hyperv: Move some features to common code
Thread-Topic: [PATCH 0/2] hyperv: Move some features to common code
Thread-Index: AQHbSC1So8GCRq0rV0qQjqDih6Q3h7La8lVA
Date: Sun, 8 Dec 2024 02:59:54 +0000
Message-ID:
 <SN6PR02MB41573F55DBAAF124CFD92840D4332@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1733523707-15954-1-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1733523707-15954-1-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB8485:EE_
x-ms-office365-filtering-correlation-id: e24deea0-5df7-4aad-5b08-08dd17346454
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|8060799006|19110799003|8062599003|461199028|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?HIfiFz+aNfgBKLN3SGo93LL8ll+oReKMj3vMe85tvDbJ/h2r6aB4BJOp0y+i?=
 =?us-ascii?Q?uK2Ty/2oXR8PKvbAuIZv/OlnoyK/a2GbBYxiwKGGHm5kV5L1nYii4oOBXZ5D?=
 =?us-ascii?Q?bXahJZjf4WN/PgkR82pSl/a4C1OAOXEVHs46R8qIhF3Kr5KhAT5XZ758EctU?=
 =?us-ascii?Q?t04q1JW47bTsxJVWr1PvP8pEUacAYftgALxUl4k5scHdQynEeXOkArzyoBow?=
 =?us-ascii?Q?rboFSWfiGd2vOWQAMosHmI1ELCcqFd/1/xHIAw0BjPloMzv/0XBkFDKuVnCB?=
 =?us-ascii?Q?Cv3tl9j13+SU/knqvinpLWdTSx4BkFBGO07mkIwbSulbVOZLTPqdDZdI21dN?=
 =?us-ascii?Q?SctiysWekHm9SCkUK2MrgORxV9S8SDhmYKFmJMLp3OK/h2on9VvInahcP7tw?=
 =?us-ascii?Q?0OR8HTnsib1wh/lEp4jMBxAUaZ4nSsUuFzlqTOmRe9EiJZHdiVpQsjR97Rql?=
 =?us-ascii?Q?LpNO56ZcjpexKfeG59DBbF/pFN2t9fT9XD/ZFmV45qrh/LxW+Zzs1uLyMSuH?=
 =?us-ascii?Q?/J3cfDAclz3hGYEQgW2t/Qh0PhqKUatrfVe/VOkSZBMtWc9PdrYAiEyuEjZP?=
 =?us-ascii?Q?UlSAoXCfr/jSCRrnmuxVTSHZJ1Euszuz1lDzZuyIDt+dVrsFZ8h/i4N0JGxM?=
 =?us-ascii?Q?PJ0ng8wN3yXAFOTSJTFlV6boa3WSbDjt3Qv3jeGa9xPNxD2vwsVNkbX/6AYl?=
 =?us-ascii?Q?IgCr4o7qnWE7BImkz+77xHLcpENNfPzuPVipC225HCcMKLQTq7Jptalero8X?=
 =?us-ascii?Q?qShYuR0x4dpoh6o2m0OhMJPWr9RbCgNdhnJykXNqF5dGnn+Irlj/BMe57GZM?=
 =?us-ascii?Q?ex4mKZxxcUpr8d7scbqDdwVh1UuPAXBAijniKoacqMIYhFGRIZeA/EeZGPpc?=
 =?us-ascii?Q?vmodtH4vfY5aiUii7W/EtQ8h8/W+hwjpURspxvRHTExRyGfqUuhmSrZLazjL?=
 =?us-ascii?Q?aYxMLJc4inAaMiWoJMVHZDKfFPCBTcldUl8bnOM9aDcu4weRWhbZhL9JEKt1?=
 =?us-ascii?Q?hzzKBD442Adag2bHDY3qHe+tkw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Sf3+6hnCo0pS0TgIrMpf9qTGCF8Oq8NGSrRE13hfsdCm7ZyNw3Jjz8w5+i57?=
 =?us-ascii?Q?9mPMHDbx85uHZXT7E8FVSAAXsKCZmsXW3nJMLxIZHKFKnTZKZHVAiGiD+F1h?=
 =?us-ascii?Q?x92ChHxYQAbZkVy/NGwxjTGmuH8aNbAtrzQ3wJv30YD/J4QpsVEPmoyOi3EK?=
 =?us-ascii?Q?go7N3t/ac1Og5EQ3HAfxCXduyodvpaftiv6uLKQGxotlbe4oqhFqe4flIAZ/?=
 =?us-ascii?Q?0XuLgAp366+2wI0N/6k4qsmQMYRgbIViycUnMCiaHLTCaCEKPMHihhZNszPf?=
 =?us-ascii?Q?ReozLmpo2FHADx63ZAWwmKc6N2POBECdl7/Wo04raaDPLVKPY+pd9gUPTPIG?=
 =?us-ascii?Q?3aTtiXRNzbtxcbVufi0IOcchpUJJnWfzxe/AmgBvSYY76jq1pYI/dY2LRasR?=
 =?us-ascii?Q?tFpJMtE4bVgk1jCtRnu8BtbCYlyFwV/Cc8Nawiqyly+yHm2Y6a3+cu7OAxWR?=
 =?us-ascii?Q?Oz8LzGDi0fjEvlO5fon5WO5Q3cBwLs9sOQBUcpUGSFbDsqSACWn6F6CBNkea?=
 =?us-ascii?Q?EH7Bh3SIFnVWvwWSdbjEz6jo3W9oxkfEwv4170hs4Oy9411n3tH2gPGoMph3?=
 =?us-ascii?Q?OoiZizUGRtf7avKjOqlwP824wss8UqxtU7xPPpxHjrAjLnJKq+oyluVs8AUG?=
 =?us-ascii?Q?or5SlAzVjg1H6MCn3tXQMk+yYJNJx+0g1DvAW7g0w5JfRzHg0iNQDQhtAOgh?=
 =?us-ascii?Q?TWlN2tKyfAd7oWFjw8wMPKC4LQbxesiLibCnKd1/P1CToJTAJV+jD4jmtxtO?=
 =?us-ascii?Q?qbRsS5AaR2E33RVpgDcgFsmhztnBfJ7t6g5jGSwaKycuQDIOvGlWUWfELGkM?=
 =?us-ascii?Q?WfWO6dFt+Tc6W9FY/kerdGPhEZoHhfJb40Uv7A17urOFv3Tu2pTi3HUh7LKq?=
 =?us-ascii?Q?n148t5Yibwt4qCDntMtbfusb5sR7zuFMWnS9dMa2UA0Q1/dUSGUo9MSSGDeG?=
 =?us-ascii?Q?PiiBM0HIjIuYUu6KCZp2Yx+eHxP/suCdzQ9FH3c5E87t6GWrS6QkovtRWv0L?=
 =?us-ascii?Q?+8+WMktEhBLWu1RkM7mFRhC16HPGd3SuAr6PmicRdmBu0HXZF0p1bmNmYQhf?=
 =?us-ascii?Q?df8ZTVwdBxFNsQz60p6wcJspSm5+Ld44pat0DUmaKkN7GsXX+IbnZY6LNGGR?=
 =?us-ascii?Q?RV8FUWjf+LFnlnt56dwnRKZIIGm/xssbmFGoFh5F5VCrdmbQYjYMXFp2Qz62?=
 =?us-ascii?Q?h89WD3bKhOwUkq4Bzq4qoE2llIq6XcUVl0u5o3YiELnwixoWdJ21W/B/MzM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e24deea0-5df7-4aad-5b08-08dd17346454
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2024 02:59:54.5327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8485

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, Decem=
ber 6, 2024 2:22 PM
>=20
> There are several bits of Hyper-V-related code that today live in
> arch/x86 but are not really specific to x86_64 and will work on arm64
> too.
>=20
> Some of these will be needed in the upcoming mshv driver code (for
> Linux as root partition on Hyper-V).

Previously, Linux as the root partition on Hyper-V was x86 only, which is
why the code is currently under arch/x86. So evidently the mshv driver
is being expanded to support both x86 and arm64, correct? Assuming
that's the case, I have some thoughts about how the source code should
be organized and built. It's probably best to get this right to start with =
so
it doesn't need to be changed again.

* Patch 2 of this series moves hv_call_deposit_pages() and
   hv_call_create_vp() to common code, but does not move
   hv_call_add_logical_proc(). All three are used together, so
   I'm wondering why hv_call_add_logical_proc() isn't moved.

* These three functions were originally put in a separate source
   code file because of being specific to running in the root partition,
   and not needed for generic Linux guest support. I think there's
   value in keeping them in a separate file, rather than merging them
   into hv_common.c. Maybe just move the entire hv_proc.c file?
   And then later, perhaps move the entire irqdomain.c file as well?
   There's also an interesting question of whether to move them into
   drivers/hv, or create a new directory virt/hyperv. Hyper-V support
   started out 15 years ago structured as a driver, hence "drivers/hv".
   But over the time, the support has become significantly more than
   just a driver, so "virt/hyperv" might be a better location for
   non-driver code that had previously been under arch/x86 but is
   now common to all architectures.

* Today, the code for running in the root partition is built along
   with the rest of the Hyper-V support, and so is present in kernels
   built for normal Linux guests on Hyper-V. I haven't thought about
   all the implications, but perhaps there's value in having a CONFIG
   option to build for the root partition, so that code can be dropped
   from normal kernels. There's a significant amount of new code still
   to come for mshv that could be excluded from normal guests in this
   way. Also, the tests of the hv_root_partition variable could be
   changed to a function the compiler detects is always "false" in a
   kernel built without the CONFIG option, in which case it can drop
   the code for where hv_root_partition is "true".

* The code currently in hv_proc.c is built for x86 only, and validly
   assumes the page size is 4K. But when the code moves to be
   common across architectures, that assumption is no longer
   valid in the general case. Perhaps the intent is that kernels for
   the root partition should always be built with page size 4K on
   arm64, but nothing enforces that intent. Personally, I think the code
   should be made to work with page sizes other than 4K so as to not
   leave technical debt. But I realize you may have other priorities. If
   there were a CONFIG option for building for the root partition,
   that option could be setup to enforce the 4K page size on arm64.

Anyway, thinking through these decisions up front could avoid
the need for additional moves later on.

Michael

> So this is a good time to move
> them to hv_common.c.
>=20
> Signed-off-by: Nuno Das Neves <nudasnev@microsoft.com>
>=20
> Nuno Das Neves (2):
>   hyperv: Move hv_current_partition_id to arch-generic code
>   hyperv: Move create_vp and deposit_pages hvcalls to hv_common.c
>=20
>  arch/arm64/hyperv/mshyperv.c    |   3 +
>  arch/x86/hyperv/hv_init.c       |  25 +----
>  arch/x86/hyperv/hv_proc.c       | 144 ---------------------------
>  arch/x86/include/asm/mshyperv.h |   4 -
>  drivers/hv/hv_common.c          | 168 ++++++++++++++++++++++++++++++++
>  include/asm-generic/mshyperv.h  |   4 +
>  6 files changed, 176 insertions(+), 172 deletions(-)
>=20
> --
> 2.34.1


