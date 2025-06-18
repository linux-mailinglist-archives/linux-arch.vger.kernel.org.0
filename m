Return-Path: <linux-arch+bounces-12369-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C83ADF242
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 18:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 495D9189E08F
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 16:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9682EBBA6;
	Wed, 18 Jun 2025 16:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="W+U9E+cJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2052.outbound.protection.outlook.com [40.92.40.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93808261584;
	Wed, 18 Jun 2025 16:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263442; cv=fail; b=h3U3Dp1AWHxeTjGO45GMhGV9Lpe8SLvS5TKjHJ4Q61xghyC3zlBCL4d57/4N/xLUmPJkyZorByJDC4FfIVroq5CYEC13BAZMdKSi1arMMinTOOaMZvxFhDrYMH9AN6c3Z9XHevKAUwvf4VrvwRYt6APB1+fAQ1oP4LpJmWdXu84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263442; c=relaxed/simple;
	bh=iDihDCCiPKnzrl5H7Qa+uc8McXJUHlJtaUacNVdTnco=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X8DbydNwxyizt7/ujOTi6ZWk7d+3Rq0plEkH+XhXVSX3a/2+p4Fm2Hxm4YJtQA33+Y+2wTokPBbSbs4c4R4hLci4TWTDo8ZUZlCdXHyeD8bas+5YRsSmlS7g6GICG63z2jQImq3hweIE+78ndoi2ET6JKBlJd5F/tpY6qmC8xH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=W+U9E+cJ; arc=fail smtp.client-ip=40.92.40.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCItztMDoyeR6zgHJ4cMVsaAL9XjSYcZNhl9k+sp1Ryj55uvDGBhi6XLc6DV7hemS1X+9qb44SjV+ayzueaCW8g2I4dixn4DlELc1GM68e51Rpc/rdxbw1GXioVw6tZbhkd15xiJ8M5kdJw1T7jJ2h7H/JnAk0WZDa+b+STBMkXA+Kpf/3fqg78xo3PsEwUzjXGhhjVcnMuOLB9BWd5TziwZCrr0hBDH+yNCjK8Ex9OIz9j/xHYqyvkJojTeDRPTrGAW+kQt/VB8srkxaCr3udTWpr810kMY0tqeLLZ8wE4kAHlRLp1fU1K18dlD6GAttYwV/B3xheW8px1CnFoNmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cjIleXG4Q7HdRagOrJoC/WeS4RGW4yTAB0jIgATd+0=;
 b=DZuE2ecUIeKUUUirNK2c3I96tN3tfuKLLTZRfHIJ8/ieN0N3tV/ONU6E7joc02BPIeQv31oG3dOsSFKL6K/UMMxuogl1Ef4k72oTRT3YQvyJE/KUsdKia1K8QKgOWSsLst6oyKUSN2x9teIuBHTm2CPAfW+myxJFc7rvT9XeAxkGvLMq16zBElNS/LCRIIRlZOBzabYN6uQk/EbcrItheQOIK6e456ZkeLR8t4wQsmOHmpCOrkwxtjP7O7wmxZuG1mv/TGO1pEA9Dhk5QpEFgHA9VaoCBkKswS0QPEhiiQ5QqMJHx9x/Fj4VbHbEFOYO9e4cHersVwZ5QmxXZNn6uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cjIleXG4Q7HdRagOrJoC/WeS4RGW4yTAB0jIgATd+0=;
 b=W+U9E+cJuwLJXA2TKfevXRN7Yx79ylT3cnDZpfBOGDknTuiMjzLH8ppUlaszNIS6lD2GY6XrOQVVOM+5iclZ9kXU6bEXdw0gkBbRQq4nax505keEbhMmXlp9FvGDEPfk9lPxZQjZooVrtzAdq4EIbYahcGluyMNMvFFdtLQlInUEQegGvxSfJFQolbYlM6+jiyck31HxmpTRdg7II+7MFgfk/86sEdykke3UkB0PolDGMpT+129vEbUIjwUL+NOEhQeBEEY6blV95DBnEcUYpiJvofo8scsvfC9uNRA6z7xqWrvptZTA80lBiGU18ko+BswLo0FV+YTsnjGEaUTN1g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA1PR02MB8462.namprd02.prod.outlook.com (2603:10b6:806:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 16:17:14 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 16:17:14 +0000
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
Subject: RE: [PATCH hyperv-next v3 01/15] Documentation: hyperv: Confidential
 VMBus
Thread-Topic: [PATCH hyperv-next v3 01/15] Documentation: hyperv: Confidential
 VMBus
Thread-Index: AQHb1Om8kxZiEqbHQkyJmXiTdU7CVrQJGpfg
Date: Wed, 18 Jun 2025 16:17:14 +0000
Message-ID:
 <SN6PR02MB41579F133A5B33420C21B348D472A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250604004341.7194-1-romank@linux.microsoft.com>
 <20250604004341.7194-2-romank@linux.microsoft.com>
In-Reply-To: <20250604004341.7194-2-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA1PR02MB8462:EE_
x-ms-office365-filtering-correlation-id: 0b28f2a5-4eb3-4f37-8692-08ddae83969f
x-ms-exchange-slblob-mailprops:
 AZnQBsB9XmrJ3OdcGJgulPpe6kFhF3ONEEaRWwuhQQ2+vLifJ73KSBLhr7mYR6ttRQRqP+VRWZUNtw81zTCIkCGYaqkBrYuefIvpzn0Y7u7RVEUcgzDrUxSqfa8/T8+FpeEtaBOWY6K4vQfKbVi0efiYDeyO338bmmgOlpa4Umau5qGPih0t6zrF60tUwzccyI5onDf7y7YT3KPtIbFHl9Njn+ieQbkyNRteqeJgt/jw/LwchdxW5CwjupHmzOeXpJqcxqEPHe+fwBnSiYORc3SS++FoLn8iQRGFBb4+dETZ6Xkyir2OF1EUzV6UI+QqRhermQkMsliQj2Y4ukYncHJSQO/r32ErYw1C9f8SEF76V/JlzsmO5vkeN3VSLo+mJBjxEbGm5s4g7w8cUSy06ezl+i3L4SgBZth5ISM9A6QynMF/L1H8/0Ycckf/W3NvzHHFtzJD34vcsjJYqS3hpzuOd6UuciIOK0whqmsRBLdc7bFdRzrrVqwDX9yV5My0iLKbIGQnVBcBGfDHa8/uvSvB2p6LPLwDwdBBDuSt5WZzh88b2imSpevNsOFRuXn/SoLmfVRRtyQsXAKYVqkYVbzQoX4y6H1MMkpLi/OUCoZmC6Vc+U3f5We8y/Xvwjvlv+OqxZamd7YluHPVzkAA4D1MuPe6URYZkdiAb2vqM+OeTAEChsBQRHkkXj12bI/hPJBEBL5S95yCJiPNTItB7G/bRWzeBmCZAKe9qufHOzPf01nAQ6eBFOUEIqcvUubaxBHf46JkosA=
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799006|8062599006|15080799009|8060799009|12121999007|3412199025|440099028|40105399003|19111999003|10035399007|12091999003|102099032|56899033;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?SwmzAqjDKdunEb12wC7nJqQa4hMQkei3dIyNhgM/q3IzDWd92hWUxqBl8zIh?=
 =?us-ascii?Q?6dwc/+muSW3/oAbQgOIHeMkf86wOuyyKBrqCXKRKw0T28rgOrHBZAJiI39Mj?=
 =?us-ascii?Q?f9GYp1LgX4MoiJx2s3dezb/ahDA0h46PMGPP6T3yMcwWRrhTmzQrKqwRQzPL?=
 =?us-ascii?Q?eNaOSp9X71xkv0plnofmNkAjCvhRKH5BJcXLdZ7bdjIG/wESXWp9JHNT6DBl?=
 =?us-ascii?Q?CbVcF7HudKf4yq2gE3KnVk2jtvJRY46N9YM/m8u5uJ34y9CxigpjyEPX0urQ?=
 =?us-ascii?Q?cpyLArLQqxU2j44/Dx9u7LNiEeokWzhdJDIY6Eb08WFbgHjHi2iSlIVy24rR?=
 =?us-ascii?Q?UbsyM/J1lMLEjzGtk64gewUtf2+KO49pn69LsLdArbjGNO3TSdZM7iuHjrsh?=
 =?us-ascii?Q?6yssHwStSLMJcuImFbHPGxcNYzhWBOhnWmwNtuQToOxEnwiiVNKmBPBj59O3?=
 =?us-ascii?Q?m3pwQK83afoDP7lyv9Wft822ERvqfYI+NQI5l+7yEu9/FUngHzY/tsX2YFPp?=
 =?us-ascii?Q?gOCJdEv02yIrebg3XsQm9l/1sfJVRxs4Jf1Q1qR29SZo55InjDf1vcIX1O/3?=
 =?us-ascii?Q?E+Lnk/sm3hSGDLqH5mhKc80roiCujH02ctzMj+ZWcBgQTbEFpxbPI7sLAWv0?=
 =?us-ascii?Q?C3D3uR0fWspF9udW1nDRHpq1PzZJZsuwxozYBMGSW0aKl8tZl4j7EbXtoqyl?=
 =?us-ascii?Q?xlQLM0XTOtKGWxMCIRbWI2OaF3TiX6ZReF/FXvaRkYGB2PWznpS5hNERqGOV?=
 =?us-ascii?Q?sMRk8zBPy9+bwgZEuBn/vvPEoFslGgSx0zwFOW3aYkwlW/ONNRK/BYHfvBlH?=
 =?us-ascii?Q?PPzr8NoOyZSoeczCpURWrUl81GyjcDaXqCzCZQ0TscVb2QaruuJ30LOCWFIM?=
 =?us-ascii?Q?zpxcswJqo7tj5d3Kr1Edatf2yNjF0FYksJopIaBzTu18qhlWqu0rVzuyp8Ve?=
 =?us-ascii?Q?GW3dg7hBo9D7OxdQyRo0yB7JH51LkEoWueUUAaxack0AIFgZnYoQI43aAZVE?=
 =?us-ascii?Q?S0HgPMrvD+KWILxN6L1SDxnS/mpKnjrwd5n8tM65vymhd0LB/jQFFGeAWk7M?=
 =?us-ascii?Q?oV+cxx4CHCJVjpA2BkENTLAjoBiyrQbivMMTeuFF6sVRVs8nsIOUfEThUHZM?=
 =?us-ascii?Q?iYP7WO+M7AILqTXZayJQM4fEayWYAAVQsPNMulCleL74hSZ3s9Tr17pW3VPo?=
 =?us-ascii?Q?3Wo9zuDv+HxbQtw/E5zSnSBh7G+kJd3HBgJSO/3IcyZSQF9+I2CXa1po9pe+?=
 =?us-ascii?Q?7E2wJ18bLw8SK4UL5BT+?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3eZYFKleMeY9YMtHZ6tjPwio0f2QE2oiVeNjsEC+DYmQ1oNg0Be4oAm/T7E2?=
 =?us-ascii?Q?sIzfdtiVJTvtfsszFFGamRBVZCFzUj1CBY+ouWLfwHrB/fi7IAztmnauKTsX?=
 =?us-ascii?Q?42VkIlsVhkEhA+boKubDtz+VdWiGble5tMMp+ha+sdGM7T1qIzVYsR92kWzP?=
 =?us-ascii?Q?+ZydAvQT9JlmG/SSwudSByoC3HCQDm6z9sNuA2hfrcK87BVUdxcA0Y+gp2uW?=
 =?us-ascii?Q?flvnRSTKEzwT5ZAOjnmyJgXox0fXL+gyuEI1PIzdNlCx3HAgFr5XlnUnlFts?=
 =?us-ascii?Q?m1uUzx0JfDKL8/vkaNxNxo48gCFClvfaN8UQnTABu7X3E7WjvW+Y3PrW5Zen?=
 =?us-ascii?Q?WGjpFLXpTzWNNC4QVQ2z8gR/SUCvywZyctQKD45v/sqvcvueAztciTMdk436?=
 =?us-ascii?Q?GoPg7kI7LkHTDHzUnNOyUDShS8MNFCsIB9bfDeQ6IruO/IUntm9t7kNDeZvf?=
 =?us-ascii?Q?XA/ugPSgGg8axnfbv8PSgOC5YUSiROj9v+Lv9vRCF0MJWhroFTy++PI/15BU?=
 =?us-ascii?Q?cJw7PSVkE+Tjvo+aSLl1oyvywrkiYnKEiRccJLtC6o6WQ5E0Qsd7vAKslIwv?=
 =?us-ascii?Q?sBdNno4ZMN4AMdjMS1AUPldOUXvaIaQGbsonvT0aZ6XEY9EivYcIoCz4GY2L?=
 =?us-ascii?Q?I0aEjvIx9iU6EvYhzT8jfw6o3si3eMhZdI4e4++pXaV1d7LWNTzsBdDwz2Ci?=
 =?us-ascii?Q?OXmNlUPytsSBk+wUbHPwJS2wwzjYJifq9r2EPMTU+ENR5t3xZ61agFzZBd4U?=
 =?us-ascii?Q?9rZkfGbu7TMFGoBVw97dOfTRQh1IQUlz56EY7BSuHIKmXU35fIqVpNeousLn?=
 =?us-ascii?Q?DmdwBHrUbpFWc9gyPcmhiN77FqU8xczzaihHxOq0arhTmziNnZllgeFqP0+k?=
 =?us-ascii?Q?iIfy7EnQEk2WM7p5qbisN8srNHC2JFVklC1dy52eep92amcnl7ySfRQjqIrM?=
 =?us-ascii?Q?wsiSfZ5x4Q6qpnb8dCT/EnqJ5ciE+WsmWVkIVt8KNcNxvCXIYN/oZdleha5Z?=
 =?us-ascii?Q?HbXouj7NUQMLcfV9m/DIz++RN73I1hmNP17f2xo/0Wr0AJdJXuVUPhvihuEC?=
 =?us-ascii?Q?CYyo1fgjNOIfAxYsce7HkVtx5pGtiPMInR+dqKy7uymIGVZkc2CGvQgiEwOq?=
 =?us-ascii?Q?bwiGAmBEPeAUOyKq5gND5ecT+jDwqS1VIi0VuyvTJg+mlh4o46/hZNo6PcVA?=
 =?us-ascii?Q?2TEPR5rdYsWxIfrIpD5krjOgV9AYBzQ72rm+6pPqvTAIkT8JyKEGcw78p1Q?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b28f2a5-4eb3-4f37-8692-08ddae83969f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 16:17:14.7075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8462

From: Roman Kisel <romank@linux.microsoft.com> Sent: Tuesday, June 3, 2025 =
5:43 PM
>=20
> Define what the confidential VMBus is and describe what advantages
> it offers on the capable hardware.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  Documentation/virt/hyperv/coco.rst | 125 ++++++++++++++++++++++++++++-
>  1 file changed, 124 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/virt/hyperv/coco.rst b/Documentation/virt/hype=
rv/coco.rst
> index c15d6fe34b4e..b4904b64219d 100644
> --- a/Documentation/virt/hyperv/coco.rst
> +++ b/Documentation/virt/hyperv/coco.rst
> @@ -178,7 +178,7 @@ These Hyper-V and VMBus memory pages are marked as
> decrypted:
>=20
>  * VMBus monitor pages
>=20
> -* Synthetic interrupt controller (synic) related pages (unless supplied =
by
> +* Synthetic interrupt controller (SynIC) related pages (unless supplied =
by
>    the paravisor)
>=20
>  * Per-cpu hypercall input and output pages (unless running with a paravi=
sor)
> @@ -258,3 +258,126 @@ normal page fault is generated instead of #VC or #V=
E, and the page-fault-
>  based handlers for load_unaligned_zeropad() fixup the reference. When th=
e
>  encrypted/decrypted transition is complete, the pages are marked as "pre=
sent"
>  again. See hv_vtom_clear_present() and hv_vtom_set_host_visibility().
> +
> +Confidential VMBus
> +------------------

Maybe put this section immediately after the "Guest communication with
Hyper-V" section, since it is an extension of that topic. Then leave the
load_unaligned_zeropad() section as last.

> +
> +The confidential VMBus enables the confidential guest not to interact wi=
th the
> +untrusted host partition and the untrusted hypervisor. Instead, the gues=
t relies
> +on the trusted paravisor to communicate with the devices processing sens=
itive
> +data. The hardware (SNP or TDX) encrypts the guest memory and the regist=
er state
> +while measuring the paravisor image using the platform security processo=
r to
> +ensure trusted and confidential computing.
> +
> +Confidential VMBus provides a secure communication channel between the g=
uest and
> +the paravisor, ensuring that sensitive data is protected from  hyperviso=
r-level
> +access through memory encryption and register state isolation.
> +
> +The unencrypted data never leaves the VM=20

Is this statement really true? The VM contains both the guest and the parav=
isor,
so it's also a statement about the paravisor. I don't know what the paravis=
or
does for channels it is just proxying. Presumably it must communicate the
unencrypted data to the host.

> +so neither the host partition nor the
> +hypervisor can access it at all. In addition to that, the guest only nee=
ds to
> +establish a VMBus connection with the paravisor for the channels that pr=
ocess
> +sensitive data, and the paravisor abstracts the details of communicating=
 with
> +the specific devices away.
> +
> +Confidential VMBus is an extension of Confidential Computing (CoCo) VMs
> +(a.k.a. "Isolated" VMs in Hyper-V terminology). Without Confidential VMB=
us,
> +guest VMBus device drivers (the "VSC"s in VMBus terminology) communicate
> +with VMBus servers (the VSPs) running on the Hyper-V host. The
> +communication must be through memory that has been decrypted so the
> +host can access it. With Confidential VMBus, one or more of the VSPs res=
ide
> +in the trusted paravisor layer in the guest VM. Since the paravisor laye=
r also
> +operates in encrypted memory, the memory used for communication with
> +such VSPs does not need to be decrypted and thereby exposed to the
> +Hyper-V host. The paravisor is responsible for communicating securely
> +with the Hyper-V host as necessary. In some cases (e.g. time synchonizat=
ion,
> +key-value pairs exchange

I'm not sure about key-value pairs exchange. I thought the whole point of
KVP is to communicate information between the guest and the host.

> +) the unencrypted data doesn't need to be communicated
> +with the host at all, and a conventional VMBus connection suffices.
> +
> +Here is the data flow for a conventional VMBus connection and the Confid=
ential
> +VMBus connection (C stands for the client or VSC, S for the server or VS=
P):
> +
> ++---- GUEST ----+       +----- DEVICE ----+        +----- HOST -----+
> +|               |       |                 |        |                |
> +|               |       |                 |        |                |
> +|               |       |                 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
                |
> +|               |       |                 |        |                |
> +|               |       |                 |        |                |
> +|               |       |                 |        |                |
> ++----- C -------+       +-----------------+        +------- S ------+
> +       ||                                                   ||
> +       ||                                                   ||
> ++------||------------------ VMBus --------------------------||------+
> +|                     Interrupts, MMIO                              |
> ++-------------------------------------------------------------------+
> +
> ++---- GUEST --------------- VTL0 ------+               +-- DEVICE --+
> +|                                      |               |            |
> +| +- PARAVISOR --------- VTL2 -----+   |               |            |
> +| |     +-- VMBus Relay ------+    =3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D            |
> +| |     |   Interrupts, MMIO  |    |   |               |            |
> +| |     +-------- S ----------+    |   |               +------------+
> +| |               ||               |   |
> +| +---------+     ||               |   |
> +| |  Linux  |     ||    OpenHCL    |   |
> +| |  kernel |     ||               |   |
> +| +---- C --+-----||---------------+   |
> +|       ||        ||                   |
> ++-------++------- C -------------------+               +------------+
> +        ||                                             |    HOST    |
> +        ||                                             +---- S -----+
> ++-------||----------------- VMBus ---------------------------||-----+
> +|                     Interrupts, MMIO                              |
> ++-------------------------------------------------------------------+
> +
> +An implementation of the VMBus relay that offers the Confidential VMBus =
channels
> +is available in the OpenVMM project as a part of the OpenHCL paravisor. =
Please
> +refer to https://openvmm.dev/guide/ for more
> +information about the OpenHCL paravisor.
> +
> +A guest that is running with a paravisor must determine at runtime if
> +Confidential VMBus is supported by the current paravisor. It does so by =
first
> +trying to establish a Confidential VMBus connection with the paravisor u=
sing
> +standard mechanisms where the memory remains encrypted. If this succeeds=
,
> +then the guest can proceed to use Confidential VMBus. If it fails, then =
the
> +guest must fallback to establishing a non-Confidential VMBus connection =
with
> +the Hyper-V host.
> +
> +Confidential VMBus is a characteristic of the VMBus connection as a whol=
e,
> +and of each VMBus channel that is created. When a Confidential VMBus
> +connection is established, the paravisor provides the guest the message-=
passing
> +path that is used for VMBus device creation and deletion, and it provide=
s a
> +per-CPU synthetic interrupt controller (SynIC) just like the SynIC that =
is
> +offered by the Hyper-V host. Each VMBus device that is offered to the gu=
est
> +indicates the degree to which it participates in Confidential VMBus. The=
 offer
> +indicates if the device uses encrypted ring buffers, and if the device u=
ses
> +encrypted memory for DMA that is done outside the ring buffer. These set=
tings
> +may be different for different devices using the same Confidential VMBus
> +connection.
> +
> +Although these settings are separate, in practice it'll always be encryp=
ted
> +ring buffer only or both encrypted ring buffer and external data. If a c=
hannel

s/ring buffer only or both/ring buffer only, or both/

> +is offered by the paravisor with confidential VMBus, the ring buffer can=
 always
> +be encrypted since it's strictly for communication between the VTL2 para=
visor
> +and the VTL0 guest. However, other memory regions are often used for e.g=
. DMA,
> +so they need to be accessible by the underlying hardware, and must be un=
encrypted
> +(unless the device supports encrypted memory). Currently, there are no a=
ny VSPs

s/no any/not any/

> +in OpenHCL that support encrypted external memory, but we will use it in=
 the

Avoid personal pronouns like "we".  Suggest this, or something similar:

"but future versions are expected to enable this capability."

> +future.
> +
> +Because some devices on a Confidential VMBus may require decrypted ring =
buffers
> +and DMA transfers, the guest must interact with two SynICs -- the one pr=
ovided
> +by the paravisor and the one provided by the Hyper-V host when Confident=
ial
> +VMBus is not offered. Interrupts are always signaled by the paravisor Sy=
nIC, but
> +the guest must check for messages and for channel interrupts on both Syn=
ICs.
> +
> +In the case of a confidential VM,

I think you mean "In the case of confidential VMBus,"

> +regular SynIC access by the guest is
> +intercepted by the paravisor (this includes various MSRs such as the SIM=
P and
> +SIEFP, as well as hypercalls like HvPostMessage and HvSignalEvent). If t=
he guest
> +actually wants to communicate with the hypervisor, it has to use special=
 mechanisms
> +(GHCB page on SNP, or tdcall on TDX). Messages will always be one or the=
 other:
> +with confidential VMBus, all messages use the paravisor SynIC,

This statement seems to contradict the statement in the previous paragraph,=
 and
the code. If all messages use the paravisor SynIC when Confidential VMBus i=
s used,
why must the guest check for messages on both SynICs?

> +otherwise they all
> +use the hypervisor SynIC. For interrupt signaling, though, some channels=
 may be
> +running on the host (non-confidential, using the VMBus relay) and use th=
e hypervisor
> +SynIC, and some on the paravisor and use its SynIC. The RelIDs are coord=
inated by
> +the OpenHCL VMBus server and are guaranteed to be unique regardless of w=
hether
> +the channel originated on the host or the paravisor.
> --
> 2.43.0


