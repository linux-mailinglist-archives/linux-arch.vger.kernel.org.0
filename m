Return-Path: <linux-arch+bounces-11491-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC80BA957EF
	for <lists+linux-arch@lfdr.de>; Mon, 21 Apr 2025 23:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BED5A3B40A6
	for <lists+linux-arch@lfdr.de>; Mon, 21 Apr 2025 21:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8731E9915;
	Mon, 21 Apr 2025 21:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AcsZ+Y8o"
X-Original-To: linux-arch@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010007.outbound.protection.outlook.com [52.103.12.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522A01DF72E;
	Mon, 21 Apr 2025 21:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745270704; cv=fail; b=A53DtSnSK+qk8LQGTUz+CcykLf0UZMqoqBpJAGiBunjI7jeTnfzmW/3NUv7UsJdykTe8pidut+Y5WrE5zVq1LMEQKQPPHOLg7NmXqZ2lPYwU/Tkh5Rd4FWPDKfRhJEBwyBgJ0dXWSEAIUvAa9dNBpAZDVZZLd3qn2Sn0QAP11bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745270704; c=relaxed/simple;
	bh=AD4XQs0/3rc+ijhdkzIxOJWAu9s4rFvHAUaWqZjfSR0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xjso0hCPfgRwOd+hi++LclpVpva1EX/PM4D40o4CoDd6OsOkTC6Qe3IiV6W0Frbd9MKwFMsiTjkewYtIyHeiTaz0+rwD961gBTQmXX/evtbQ2TWo2RfbZwCzPzoFzVr/B56ZnrT9RhrI3COAoRk9tfikVyhIDKhERkckOr08wWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AcsZ+Y8o; arc=fail smtp.client-ip=52.103.12.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fIBE7D2aTyiAwQq9gBwEiLr6/enSgmRY8vPqVojjEfXzYJ6mrWQnHGSwZkkp+iHdBvI430p4APg016I3DxgtW5sqQ7JW4WAcdZUMXbPerU8v2oRPoBNT1jWwDIyNT/W5tr0xCdoFe0Kj1osGiu67QB5J8+5/nGLBRS2rrboi2rvO6O43TGr3v3LFmRMM1vrS8UAjF9+rH+55IL6SULEj/51In9hoyPg72Qd9U6/M0ZvqrtEnRPjq+z+TbWXTSeijreTKAjN4OiB2CHtCnORFZ5Zs6E5v1z34y6qM6NA7bntACPvOMD/M/m0T1bv99uGZV1rCopciYWHKraAkfUBXqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7p3OVLg/dzXY30yhNQr6JvrkpOLkRqd2mrQHQImCngg=;
 b=v9otex0nDoOxP4fvXgu/QGfKTAt5rXOqs0ZLTfSATjyKOgg/yOfCbR2ktrgYvcBa5kvTqgqjqD4do5JipaVZt4cq1wXROSLSRKnyR/SzzKfi8gjMq14/RzpDK7/gHcdawpwiv+I3K9PGklsTXspPlBGm8tbfXm1ssCJjYfHnpUBg+G5v5wRe50IlebHvTjjy81icUG0ePKsSRIn5jJgJVQZyv+qakE6srfxQzZWEZ2NEkxvyC31WDyN1EZ4dUdOgZbyvWbS0w4iOARTSc1WgNCwjsZoqUtO5mbM5l1lFp3q4D/RG1gT59Ldq2EuqZaKgKLnXTOklQ0OXeB2VG102JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7p3OVLg/dzXY30yhNQr6JvrkpOLkRqd2mrQHQImCngg=;
 b=AcsZ+Y8oHl6wFezOBJ9FR+2J1s3sHw6LNlxScs9yuNXmbRmbwn7zQR3ohwCk0uHxP0KWvXDTEZAxf1c5HDbDct4D+eyUICdJQIgLMwPYOPpc63iYmOpmsqH3dkf8zMh5EBiB/sdOw8S+4CmeOwAz+sQmW5L2p4Nd1azeGAhT7+A7tCGW+YE4CrIT5lLjkAj/ZZwa8dFhfjRDrW6xI9kRBVZoK4GgwKFqwKUTlkT/5Sa8wwQNOznzVIaQpo/TsqRzMz/sfsXdq40gpwK3MukILgxO+hJZX8L0AyscEX3u7TUe2kzcdffezVwcvOWVfqIMa6GkyCz09H8cxhVJvPcCxQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB8357.namprd02.prod.outlook.com (2603:10b6:510:100::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.21; Mon, 21 Apr
 2025 21:24:58 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%5]) with mapi id 15.20.8678.015; Mon, 21 Apr 2025
 21:24:58 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "arnd@arndb.de" <arnd@arndb.de>, "x86@kernel.org"
	<x86@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
Subject: RE: [PATCH v3 1/7] Drivers: hv: Introduce hv_hvcall_*() functions for
 hypercall arguments
Thread-Topic: [PATCH v3 1/7] Drivers: hv: Introduce hv_hvcall_*() functions
 for hypercall arguments
Thread-Index: AQHbrjFiyn0GJkB9FUywLGBELxbpZ7OunwuAgAAH2aA=
Date: Mon, 21 Apr 2025 21:24:58 +0000
Message-ID:
 <SN6PR02MB4157FEE08571B84B6CEBFC92D4B82@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250415180728.1789-1-mhklinux@outlook.com>
 <20250415180728.1789-2-mhklinux@outlook.com>
 <f2ccf839-1ce3-4827-997e-809ec9d3b021@linux.microsoft.com>
In-Reply-To: <f2ccf839-1ce3-4827-997e-809ec9d3b021@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB8357:EE_
x-ms-office365-filtering-correlation-id: 45931f01-f417-404b-16a0-08dd811af7f7
x-ms-exchange-slblob-mailprops:
 ymJijV9pwJk27+axzTH4qfXnaf5wM6uS3dnN6CW9su8qyF8HRJ/i6LlHhD5A62iMFhmAhrnalsr2lHR/b0HzzOFQo+bbn3iK/mCVR7xUr/bvVliL0TQeeBSE7esdlliDa65/KB3Jd+ogYd+QqO+ZZDT4tTvKMo/mfxC/y8/1tLMVHTwz6NABN1t7MyopT6wFQuPXxqHS9o/mJJoermsxVPbk+Dh1wU1TbcKAMwIKPLiyGwAnwA5beDTl5P2I+iX3WwGMX/FvV1Ea/mm6g/MRaiNpHhDpQqszUi9rgnMWWuGEU0xyw2n4/KO5sxwFJSk5zI0Pym4CU57rqy/M5I5koaeClrlSLwzZW3UgdiUmt5QXbuLvaqOSP9weA6hwGNoRLNvMvfvkfFwLtll5b30Y4/y0BVjkqUjjFBF88CJfrCObS1Scsq08FWx79exA+OqjPYR7FDJK15R7tgB7RALcuam93y7ogER4Ab/1Z5hLMmVTDjDGk0+uAeKOXJviTf5RUmGbzrSzMKfEXmQL3iQvbtcO+vPKvK9pH9XnfiGx2rhywcHaqeGmOWtcCVmJrfoCwIvkmcE8b/dLgXWEbhzxChdpXXn+hzqAc0OZTf1W157iPgn51QCrI5clO1z5Y5gmRnkYjVNHEIDl1HqDhR3DCiUQx7Khlh1rK5ws5+unmwAv+6DbEK7FyDsSeEvf4VFK2ZSYD9UZEfD47h5Ee0W7kM8E9UjBbdQ3y9naJQa4/wQ89zKR9lXLW2Fs8o324454Kk6wYYK0xrF16OJMSvuQbTD0+hzSdYsZuQu9AJhYo8mLYejmRMeivnQ0f4U+k3sN
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|15080799006|461199028|8062599003|8060799006|102099032|10035399004|3412199025|440099028|41001999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UFpHQxz8nevLI0+FhHgh5EFpsCK/1zg+RfJM6UAC/gkVLE/Zi8ueriI1jj/f?=
 =?us-ascii?Q?MDcuYErzlmCErtefRMZRgfqBKevllL2VpGpP90ex2pzZTTQk/BPzkhJYLAVR?=
 =?us-ascii?Q?zSB0YCEN5tmq2lc3ZKXoy+9WRjU3JNqqCm8wlJaIasiKyxH29gZUXo+YU/ah?=
 =?us-ascii?Q?PWnMD/F2JeSWdvoP1WskpzHX6AMLtic/tsJNnmGy88LcJ3Wb8gzr85rZxbxO?=
 =?us-ascii?Q?nkrJ266J0+DJGOyDUcYaHfUGA7aGSSgL8ogP82v578vi6+bOZbDqin76h3lt?=
 =?us-ascii?Q?W4nMpCWfqXtmkuAKoL+DD6crUpsdnpUhHXuPQO2MAfvO/DACJDHqcI2NdSBY?=
 =?us-ascii?Q?Q0LdXe2JhlofWQAHSEB1x2vpZZ+BvJuL2PHzgxaza+QgZxBNvy4f3xdAiQZ6?=
 =?us-ascii?Q?zMCJL5mWeUV+rLMQh9Ayh/Y9TOsgWR5CJ8a96NMIBbKflYdq/D1Zv+MFHvjc?=
 =?us-ascii?Q?b/Zs63D+bQmF4Rl8gDqDcftYTYC7V3f97YCakP0nTBc8DgCQxk4C9lee1C+e?=
 =?us-ascii?Q?ksOX9G9C5F9efnF2ufil5sp9bpqpYhAPkal9+H+Wfl/3oxbDSkQQJFCGgLaP?=
 =?us-ascii?Q?PGCFolx9BuN/XziiTFLfoqOH9WI0HWHVaqbBPtLyonSPl5YFwooKIzTyv+2F?=
 =?us-ascii?Q?xC3H9Y1pgWJ46t/rVtQV341j5PxDF+WFAmJcligl9hcojXpurJ5mGcb6qTWa?=
 =?us-ascii?Q?AKgBGSlif9ANRRKNI9dJRp5F03cQ++mQkLvQKihnjQ7BYKtPzPN9+mGfI9Os?=
 =?us-ascii?Q?7+v3fzPy6KejAqZl5xzZXQ4nvxhATm/egqy74jnT3RnAYum3Ix/j3zJik+9C?=
 =?us-ascii?Q?Knb68zPCHgCMwWLiXV91ipYgs4DMYI9qVX79gC0Y4kAEuUEv8mDhBBx4Yk9i?=
 =?us-ascii?Q?tcV9c9A2TQnKzhx0dCv4oDbUpb/gD1Ts3vL+mwD4ncwnGBjQhNgS9TvifMxy?=
 =?us-ascii?Q?ht+ASX4MSJkMc0uoxnsS0BDcoZegv+lK2aX1h8zqOl+1AYIBOWt+XDwpV9OA?=
 =?us-ascii?Q?ZM2RzuZPkPDDvsBP6f0nb/N/lJ+ceoHYAG6fuDjg2ks8wvkJDxp4GwrPkXte?=
 =?us-ascii?Q?uWNHy8LbrneDBaVTlgckxqnn5ytXMpFB+bxeEMqM4KjRCzLF2vqvg3tB2/Lb?=
 =?us-ascii?Q?ZxN+YYVPCa5trb7dxwOiHi+Wdext/DoUGeGMOmeNPBqOG7uFbdCDJkQ=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nu2J+F8hl3I7+M/pZKMBjclMCkNJZhRPJ3lhO7Bkw5MBCBIOIWngn3qswvAF?=
 =?us-ascii?Q?Q3qY+PT973hXycOjxjGDWS9vPmq251cL2kknkJCO9gdSLw2nm/uCT0ZOIyTH?=
 =?us-ascii?Q?e8LLAKGi6RtFHyT9epJJbVPsJV8bP6uUb3qbbBgaxOef2SL+Dt4TmgiiEQTJ?=
 =?us-ascii?Q?3LK9l/SKwUR/bNwBZ27tPIw3z65AFGq61wXHEuUJBsZA5c9NDdI6FGOH3Kyy?=
 =?us-ascii?Q?kcVp2NfOiWXSzV79mQvg+jUBRvOzzE1Eq5FCvEZnAdiuMAJKccIGwJ75prHS?=
 =?us-ascii?Q?il/WM4uzcE8SpAp+fxreEdNCT83O68XZYDPIu+mj/3Sg1aqp6QPjv+XwzNwz?=
 =?us-ascii?Q?avadiGSz4Jte0pb9PE+Ghq+ER3Ip0QHYk3Bb2tjxpEsojHoRZ7daNyMiizKY?=
 =?us-ascii?Q?x4jkxfcGTxFdHJwTNGVoPjCifsxPAmVGGRZJBvgPTok2sUaB721HC+fdI+UE?=
 =?us-ascii?Q?/GMxyfqqTrA9VXiX9hlO3l+cUu9wpBI+cZXsHDxurPBJHKimjAO4bs5DVXWJ?=
 =?us-ascii?Q?gdZ/wjSivO9XF0cVqpt+GoxO3SX4yWYZBQqQ3ZoDJh2O6LLcUwh3DC8PY5pI?=
 =?us-ascii?Q?D5XroGF8d8EUTq/JexsTv2o17x8nus2O8akdNLckfnSQsXZmJdyvh4T6FBOt?=
 =?us-ascii?Q?yD5EEnmBYW3kSongBdrHdScg9KvNAlmD9YmkOX9zy4mUhxBteRlWDLOCe6S8?=
 =?us-ascii?Q?PV6ILtLmxNROlp9juA/rcupWwBi3nast+lGnLjAdFYr2TTdyWJeqh4TsGqwH?=
 =?us-ascii?Q?Ui5418uyv7evfujiMXtfEqiwiBWZJ2Lf/pgZ91Y4Mdt6ScjSJRMBpSf4RX8f?=
 =?us-ascii?Q?niUzCkMvv7QYIfHBAcVlFVRlyA8BAA1I2RyGAh0aiqvFEHXgY1U3k78Ay9cj?=
 =?us-ascii?Q?4jCr/tpib+l92N4oKrWEpz++LN1/+weSrU3qQMjHCJI5God6+mwqlLZM73iG?=
 =?us-ascii?Q?PjqfSFh1ZTCntjazGiFv0wyjFlEInoIsLtuRVU9XLcG0NqKf37mIxNLHWILV?=
 =?us-ascii?Q?aMTOK4yxbvaBdO2MaAH/NqiGW6tZOkqikQRgOx8ntXkm1bW6dwd/kvoXYYFQ?=
 =?us-ascii?Q?nWGMv3n4VRiwNu2FrcK8aGZ+LaGRcp3IB7FJU8dVVGJOc938gqLYg3pdy3bT?=
 =?us-ascii?Q?xVFEZVJMyzoAjaqdeoVwDTgt8SsGIxR0h2bUKNSK/wJuLofdnrMBN/Hct7OQ?=
 =?us-ascii?Q?Hjn2pcspHwBaZVldYLd4kYQwXqRO6F34n8xiOUcISv07ReFm59bxzC1R/tE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 45931f01-f417-404b-16a0-08dd811af7f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2025 21:24:58.5414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8357

From: Easwar Hariharan <eahariha@linux.microsoft.com> Sent: Monday, April 2=
1, 2025 1:41 PM
> >
> > Current code allocates the "hyperv_pcpu_input_arg", and in
> > some configurations, the "hyperv_pcpu_output_arg". Each is a 4 KiB
> > page of memory allocated per-vCPU. A hypercall call site disables
> > interrupts, then uses this memory to set up the input parameters for
> > the hypercall, read the output results after hypercall execution, and
> > re-enable interrupts. The open coding of these steps leads to
> > inconsistencies, and in some cases, violation of the generic
> > requirements for the hypercall input and output as described in the
> > Hyper-V Top Level Functional Spec (TLFS)[1].
> >
> > To reduce these kinds of problems, introduce a family of inline
> > functions to replace the open coding. The functions provide a new way
> > to manage the use of this per-vCPU memory that is usually the input and
> > output arguments to Hyper-V hypercalls. The functions encapsulate
> > key aspects of the usage and ensure that the TLFS requirements are
> > met (max size of 1 page each for input and output, no overlap of
> > input and output, aligned to 8 bytes, etc.). Conceptually, there
> > is no longer a difference between the "per-vCPU input page" and
> > "per-vCPU output page". Only a single per-vCPU page is allocated, and
> > it provides both hypercall input and output memory. All current
> > hypercalls can fit their input and output within that single page,
> > though the new code allows easy changing to two pages should a future
> > hypercall require a full page for each of the input and output.
> >
> > The new functions always zero the fixed-size portion of the hypercall
> > input area so that uninitialized memory is not inadvertently passed
> > to the hypercall. Current open-coded hypercall call sites are
> > inconsistent on this point, and use of the new functions addresses
> > that inconsistency. The output area is not zero'ed by the new code
> > as it is Hyper-V's responsibility to provide legal output.
> >
> > When the input or output (or both) contain an array, the new functions
> > calculate and return how many array entries fit within the per-vCPU
> > memory page, which is effectively the "batch size" for the hypercall
> > processing multiple entries. This batch size can then be used in the
> > hypercall control word to specify the repetition count. This
> > calculation of the batch size replaces current open coding of the
> > batch size, which is prone to errors. Note that the array portion of
> > the input area is *not* zero'ed. The arrays are almost always 64-bit
> > GPAs or something similar, and zero'ing that much memory seems
> > wasteful at runtime when it will all be overwritten. The hypercall
> > call site is responsible for ensuring that no part of the array is
> > left uninitialized (just as with current code).
> >
> > The new functions are realized as a single inline function that
> > handles the most complex case, which is a hypercall with input
> > and output, both of which contain arrays. Simpler cases are mapped to
> > this most complex case with #define wrappers that provide zero or NULL
> > for some arguments. Several of the arguments to this new function
> > must be compile-time constants generated by "sizeof()"
> > expressions. As such, most of the code in the new function can be
> > evaluated by the compiler, with the result that the code paths are
> > no longer than with the current open coding. The one exception is
> > new code generated to zero the fixed-size portion of the input area
> > in cases where it is not currently done.
> >
> > [1]
> https://learn.microsoft/.
> com%2Fen-us%2Fvirtualization%2Fhyper-v-on-
> windows%2Ftlfs%2Ftlfs&data=3D05%7C02%7C%7Ceefaa97bb91c4d5c9dfb08dd8114da
> b3%7C84df9e7fe9f640afb435aaaaaaaaaaaa%7C1%7C0%7C638808648755643707%
> 7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCI
> sIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D1S=
2
> 9jKMjSZgciblHrJzH1rVbPuIORh%2FrU1vFcviBBHE%3D&reserved=3D0
> >
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> > ---
> >
> > Notes:
> >     Changes in v3:
> >     * Added wrapper #define hv_hvcall_in_batch_size() to get the batch =
size
> >       without setting up hypercall input/output parameters. This call c=
an be
> >       used when the batch size is needed for validation checks or memor=
y
> >       allocations prior to disabling interrupts.
> >
> >     Changes in v2:
> >     * Added comment that hv_hvcall_inout_array() should always be calle=
d with
> >       interrupts disabled because it is returning pointers to per-cpu m=
emory
> >       [Nuno Das Neves]
> >
> >  include/asm-generic/mshyperv.h | 106 +++++++++++++++++++++++++++++++++
> >  1 file changed, 106 insertions(+)
> >
>
> This is very cool, thanks for taking the time! I think the function namin=
g
> could be more intuitive, e.g. hv_setup_*_args(). I'd not block it for tha=
t reason,
> but would be super happy if you would update it. What do you think?
>

I'm not particularly enamored with my naming scheme, but it was the
best I could come up with. My criteria were:

* Keep the length reasonably short to not make line length problems
   any worse
* Distinguish the input args only, input & output args, and array versions
* Use the standard "hv_" prefix for Hyper-V related code

Using "setup" instead of "hvcall" seems like an improvement to me, and
it is 1 character shorter.  The "hv" prefix would be there, but they wouldn=
't
refer specifically to hypercalls. I would not add "_args" on the end becaus=
e
that's another 5 characters in length. So we would have:

* hv_setup_in()
* hv_setup_inout()
* hv_setup_in_array()
* hv_setup_inout_array()
* hv_setup_in_batch_size() [??]

Or maybe, something like this, or similar, which picks up the "args" string=
,
but not "setup":

* hv_hcargs_in()
* hv_hcargs_inout()
* hv_hcargs_in_array()
* hv_hcargs_inout_array()
* hv_hcargs_in_batch_size() [??]

I'm very open to any other ideas because I'm not particularly
happy with the hv_hvcall_* approach.

Michael

