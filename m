Return-Path: <linux-arch+bounces-9951-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E90BDA21614
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jan 2025 02:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F024B3A8B20
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jan 2025 01:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66044188907;
	Wed, 29 Jan 2025 01:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ao58C8ig"
X-Original-To: linux-arch@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013084.outbound.protection.outlook.com [52.103.7.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A34B11712;
	Wed, 29 Jan 2025 01:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738114229; cv=fail; b=o4gPfFWFnyLW2eEZgB863E2uWCRqcRstMjj1ZblFwIIcdaAq4DiX3jYDD62/rjTPgoRTIZettrpiDraGU0enyYRSy5NeWBgRht2W/XMPZQNlnumoifStQzgf2CevmEd3DIr+wqlF0TW09T3ZQfmcb76hQmg5r/hO75T/VeX96wM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738114229; c=relaxed/simple;
	bh=XZtAeCHULrTFMiq11hYYSl2COAA7LvSenlT585oiTIY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fXA4jOiR+6vuchrvx5oc6Scll2b/RKX4WeVTFGFdSiX5dScM0s/iPBpFMSZVyuEdOuAlV97zOXvA21ksAYz1J7RQefFhvm9Xwzdyk5cbUOVItgDWMxyJpAGWDZxP8csPQ2vODEYQySvzy01QLUvtA2Feauc52U0ABvWlzlewLtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ao58C8ig; arc=fail smtp.client-ip=52.103.7.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQfcqQwuBbKneAZSLPwBYD70W1tHGdVxRnCE/ufopgYSgExQ7hwgRcgh5FlkH2VDxU5Pe0VoVzjj6HOuXT8QMkGLdTHoHE99ncWgVGo3EqgmLhuI+5rZJ/o1lTYK0uPpWFRYWtPjwKezZ1pahUh/z3L9KCi4mip9IfKr9K8jsgRzY+E4iE0d6GHrqGzhpP3haoUUdwdDjwAhrS+xlb8v4A71bHI6f58a+Q42KtRfvv70rG/UnQY66AwqjC9qfCytyDPz6HfjsvlKwAFQGAnwUR+7Ie+TdYVN/sW9AqOXYh2BzWUq3DZ7SphohkaPh6QMAVqxZjpYySLcYLyNg7WdAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5R0LiB75pLAornVwN8Llu596XUIcxkWVtA8zusbXdag=;
 b=AKcpJkVTIw4oFNkV0vdTrrlyc2tAvth1RClQdQW+zEE5Q45IOxscXk2e0y7089CM2dJpGs/3NLY8zgUkiZhRn3HWomfVcNk7cTarTN4XqwFRxebNRl1Fa3hLN3twfL6f7lTgYRH4H0CxLuEyPt3cDM46Ei662LLXXRdK/eTt3xfmXSj+ztTewwdv1i5BsaAjWmi/S5+KNIs5HQx5o7v4a3X4hdnPqPEpwJA0d+a40REPTsn2i/D7Ir7u7T6gZDSdLz9smCyEntDRr/OiKO2PU7uQsTS51d1NWZ71Ybl8bcgfx2D4uJoXpJSuAo9w0HSfSySRygMFWNEzUW/c4G9Hkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5R0LiB75pLAornVwN8Llu596XUIcxkWVtA8zusbXdag=;
 b=ao58C8iggOUgCY2T2d+2u8i7DGue8DJfIuabOrjJ8JpW7xWxPogYTMzkN0pvK+vYcMfP04iMEnmpFRNouNN+ryT3VzzWdptAiOdjdedNbchnniYrx7vxnzc6jdleh01O/Y8NcHN7v3hToYtgtlleI9MWzQh2cvn4S9xo2vee0yajYqdfop6NSRthKBqNEmZgyDsqEWrA/p3WplrPHAE2tu2x3lspirREBRVgVRrXDIl3ApFKbNqImk92gd6pnbs6t4jdj4KXg4iT8UXgxiNf9tLARcCYWzwwBSNqso8vTnua/KyAUrthDgDnR+IYKedCw1PrVeAiQ5yFss/vX17IUg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV3PR02MB10738.namprd02.prod.outlook.com (2603:10b6:408:28b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Wed, 29 Jan
 2025 01:30:24 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8377.009; Wed, 29 Jan 2025
 01:30:24 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "wei.liu@kernel.org" <wei.liu@kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "arnd@arndb.de"
	<arnd@arndb.de>, "jinankjain@linux.microsoft.com"
	<jinankjain@linux.microsoft.com>, "muminulrussell@gmail.com"
	<muminulrussell@gmail.com>, "skinsburskii@linux.microsoft.com"
	<skinsburskii@linux.microsoft.com>, "mukeshrathor@microsoft.com"
	<mukeshrathor@microsoft.com>
Subject: RE: [PATCH v2 1/2] hyperv: Move hv_current_partition_id to
 arch-generic code
Thread-Topic: [PATCH v2 1/2] hyperv: Move hv_current_partition_id to
 arch-generic code
Thread-Index: AQHbbTjJcgmEzzZeVk2NkuIdCcR+SrMsgY8AgAByPgCAAAq1oA==
Date: Wed, 29 Jan 2025 01:30:24 +0000
Message-ID:
 <SN6PR02MB41571826E243F10A2624FD81D4EE2@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1737596851-29555-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1737596851-29555-2-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157042605A22E40767DDC94D4EF2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <c52ca7db-36a4-471c-8fb6-37a94d637741@linux.microsoft.com>
In-Reply-To: <c52ca7db-36a4-471c-8fb6-37a94d637741@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV3PR02MB10738:EE_
x-ms-office365-filtering-correlation-id: 2eb38dbc-3326-4a56-6d23-08dd400480f2
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|8060799006|19110799003|15080799006|461199028|440099028|3412199025|10035399004|41001999003|12091999003|4302099013|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sBPLC1vbi9YGCLcUOf/2VvmsKpVlBgHxdVZi0ZdUf9/MrMJYbWVv1Y1uoT7w?=
 =?us-ascii?Q?wJFCzFtK0Cg5HDZXaU6WYppAcGaoNL9ed3PAwGToniwC7S4zXX9ThINpwZxD?=
 =?us-ascii?Q?IFKc+TZaJN1mblIuCBIiZxN6b85j9m4vC/NOrhM8NfaG/bDel/RRDJHGpjqq?=
 =?us-ascii?Q?ZYw2Ycpab5IX9rWcodHVubDFkYR7IyJPTgBG8J7Dz8/6qLq1FRCvdx7l6ElK?=
 =?us-ascii?Q?X0/WV5knsYI+M1FDuUVcsi5cD1F9eK5VXDxZXIOcsZc7WAhTORvRw9rxhprG?=
 =?us-ascii?Q?f73XnAm7O8+nSUeM4dMMEikjJEjU5dxQct8Ux2qhzj1sDjbQF6d4fJs6wlH8?=
 =?us-ascii?Q?jPuIe7+rXeg5KzICwcorx4rxIA/MiOAzUOKyXq0gXVaV1tw2pkikRdT+grLL?=
 =?us-ascii?Q?iAI7koTTZF82N/lIxVhe32Otyf7icfU20ebgQC4UI5YSksEAa6UpH58VvjVP?=
 =?us-ascii?Q?oYtdOyFQnUeQx55KolLuj81j4YpVWBDOTkOiuy3D0JlvawwIGxmit+KdKsRr?=
 =?us-ascii?Q?tLW6v0YOSQu51iwpuIiFzpPwESN5WaVKtcbtduUeWI25kF5oG9G71/m/PKSi?=
 =?us-ascii?Q?Yt94f1EVlPKKsihTK0QfQ+UKugUOpTkqclaQbt4WSY89teAEsDjYTF/ppJ1M?=
 =?us-ascii?Q?OPXvkZkyzUGZw/qVNsTbIZjs4V3wLPqLnqvHUVfygeIJhcjQ8BX3KMXciqQK?=
 =?us-ascii?Q?bMo82G9GaZth1sXostpVUkq7V8hlDXkT5VGBLqrLfZLVmhTV+GF9YTrsY4ET?=
 =?us-ascii?Q?GsWVZDl5robmXZ3ZZtsEs7ZBXnudfn0kXlU4yPdivpQN9xwxjLu4q9uR1ijz?=
 =?us-ascii?Q?aVuIQduR1u0XDmupE7its+50mfBgHeGPnUaUmklPPZG/bnG6fKqqME7VOfsc?=
 =?us-ascii?Q?7DphcSjZVgnJIYSrlqdQ+AuF50OijPkYuCcGoaWAIW73YyIuaavbt0nmxsYB?=
 =?us-ascii?Q?j6MyzA0/utAgAqJinhOnMuQUOxWCTzOeHQcj7w9bwMoMD9j4ezwQCaSl4ltc?=
 =?us-ascii?Q?ZdtsUcgDb9rQ/OomcWRm4ma196rx/wbzVSeYQ1zlJw3Q4eRtb4FMr64A9vbZ?=
 =?us-ascii?Q?gOPZO1PSwnpVp90rKoE+N5VvKkF2/suEBKWu4EeWvcHxD2AJW2W1j1jO1KNk?=
 =?us-ascii?Q?sn2u6xIUQ9R1sV9ApACFp20etNkSBVi8E1tILGMpT0r3apW2UnoEeQQ1GhoK?=
 =?us-ascii?Q?q828TpoNGnodJZZ1FppIfXcj9wpeBJU6MH7ewV+0klyF6jcESydYKvB4CehH?=
 =?us-ascii?Q?XBvDf5sZuSnQRfg7l8qdTu3Z9/kZZwLoXzRwaOF08g=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IskUqV3BMcUjnIdMSM1XNFKsZzd7/rxWNpsdpDs1/8tVIyxxOESgm0RWc3cN?=
 =?us-ascii?Q?zGJgvgltB7GsHlar6bYoOEeIzGimJtkM3wu22TCxksZDMsuE1Uq0K9LKIoGx?=
 =?us-ascii?Q?wx8f2iPeTEozAZarCJnP/2LYRvnGwA5j23bTfCpirjB2ccF8wCr5lRRjAx4e?=
 =?us-ascii?Q?SaN7juEok5AQKcg1UJ+RXOQgIP7dhjPw4TozYmZs2ICxPSI5W54sqLd4/Ss2?=
 =?us-ascii?Q?dFAYIMswq2nqEa0WvF1hjmQ7O8hMArmctIwGXsjfzByK/Yh9d0Hce320D3ij?=
 =?us-ascii?Q?jt+xh1k+mIiIh6qFH52Vn/Yj88/wiJjCqMq3EOowIApIV9zmKTmh/r+/VK3Z?=
 =?us-ascii?Q?IppNMLjsP2wxKDkuXlmOgtKI3Vb1O1Z2kSCS1tQcF6NNRaQaC8W3C6BvUXOd?=
 =?us-ascii?Q?OQhofT5atk/RMDhdk0HltRnjE7nHEmaJXiPHe49H2tp0T3mTVjIYz3E87dYp?=
 =?us-ascii?Q?rtCTyhhRUoElgXTc2FyNvo4dGZm3HQqrUssIb10evcOBzTTGX5TWyjMbHgjZ?=
 =?us-ascii?Q?VBwT0amViNLu/7+I89U2FGaR4u31LoqRb7t8JD3AO1W/5jygFqFO+BoHVaai?=
 =?us-ascii?Q?EHmc4FydC+L+wkAMnJC6jwxjgf7df8S7DyK1+qBUD+dWMgMp3BAcAq4ZjeEW?=
 =?us-ascii?Q?r9YYpxZAKyft1fSq+CB6aLFt0OJ8VJLvtRmiUGmUKsxKZouJtnJ6T72MyED1?=
 =?us-ascii?Q?ngnbSobCDeMUlJA2G3kYomLmHrAE2TI2welkouL7uuVrvz0n2d2xRcQ/ldBy?=
 =?us-ascii?Q?3DsI/WpSAhS1+lc+flWyOdowQ1joFHpXKIlDPTuiIA8suat6wHuokztN2Aad?=
 =?us-ascii?Q?QbjLLCkmTPFwb1eap6yvQGkHpuM6A8qbEGN/BDW7hhp3MGOIPzDObMFK3Vku?=
 =?us-ascii?Q?CiENF6/zDS85G6iQ02xv+hzcfZMPn+O4x511Rm6yq91oRR2U+7g/iYrb1Gxb?=
 =?us-ascii?Q?AlQVdvupyUgPqFTy3mzVeyA7zK5dAde9t+bNFVYWzLz+C7AkB8n03xKVWOf+?=
 =?us-ascii?Q?VCKUqgbcwYAFc29YGaFgvFJ7/lZhCZKPMF424mrdqyHS90/YUtw++gTwUYwb?=
 =?us-ascii?Q?AwzeZixdV6AvePXjR4GjReirh8fPh0IqpBJIdZMGAUoxtCRpv7n/HEdUv8l8?=
 =?us-ascii?Q?KE6bXiY8T9/ydmNLyhMbAv+CPtwJH6YMd9Tb9xa75TPKA5I8r4dUj9x11Jgz?=
 =?us-ascii?Q?2oSMLcDcXd2MH6r3jlfKTJiRlmFXjMUgZzZXcjLprBJAjTPyxwLlWKphcA4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb38dbc-3326-4a56-6d23-08dd400480f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2025 01:30:24.3792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10738

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Tuesday, Janu=
ary 28, 2025 4:46 PM
>=20
> On 1/28/2025 10:45 AM, Michael Kelley wrote:
> > From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday=
, January 22, 2025 5:48 PM
> >>
> >> Move hv_current_partition_id and hv_get_partition_id() to hv_common.c.
> >> These aren't specific to x86_64 and will be needed by common code.
> >>
> >> Set hv_current_partition_id to HV_PARTITION_ID_SELF by default.
> >>
> >> Use a stack variable for the output of the hypercall. This allows movi=
ng
> >> the call of hv_get_partition_id() to hv_common_init() before the percp=
u
> >> pages are initialized.
> >>
> >> Remove the BUG()s. Failing to get the id need not crash the machine.
> >>
> >> Signed-off-by: Nuno Das Neves <nudasnev@microsoft.com>
> >> ---
> >>  arch/x86/hyperv/hv_init.c       | 26 --------------------------
> >>  arch/x86/include/asm/mshyperv.h |  2 --
> >>  drivers/hv/hv_common.c          | 23 +++++++++++++++++++++++
> >>  include/asm-generic/mshyperv.h  |  1 +
> >>  4 files changed, 24 insertions(+), 28 deletions(-)

[snip]

> >> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> >> index af5d1dc451f6..1da19b64ef16 100644
> >> --- a/drivers/hv/hv_common.c
> >> +++ b/drivers/hv/hv_common.c
> >> @@ -31,6 +31,9 @@
> >>  #include <hyperv/hvhdk.h>
> >>  #include <asm/mshyperv.h>
> >>
> >> +u64 hv_current_partition_id =3D HV_PARTITION_ID_SELF;
> >> +EXPORT_SYMBOL_GPL(hv_current_partition_id);
> >> +
> >>  /*
> >>   * hv_root_partition, ms_hyperv and hv_nested are defined here with o=
ther
> >>   * Hyper-V specific globals so they are shared across all architectur=
es and are
> >> @@ -283,6 +286,23 @@ static inline bool hv_output_page_exists(void)
> >>  	return hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE);
> >>  }
> >>
> >> +static void __init hv_get_partition_id(void)
> >> +{
> >> +	/*
> >> +	 * Note in this case the output can be on the stack because it is ju=
st
> >> +	 * a single u64 and hence won't cross a page boundary.
> >> +	 */
> >> +	struct hv_get_partition_id output;
> >
> > It's unfortunate that the structure name "hv_get_partition_id" is also
> > the name of this function. Could the structure name be changed to
> > follow the pattern of having "output" in the name, like other hypercall
> > parameters? It's not a blocker if it can't be changed. I was just surpr=
ised
> > to search for "hv_get_partition_id" and find both uses.
> >
>=20
> hv_output_get_partition_id is really the "correct" name from the Hyper-V =
code,
> so it makes sense to just change it to that in this patch.
>=20
> > Also, see the comment at the beginning of hv_query_ext_cap() regarding
> > using a local stack variable as hypercall input or output. The comment
> > originated here [1]. At that time, I didn't investigate Sunil's asserti=
on any
> > further, and I'm still unsure whether it is really true. But perhaps fo=
r
> > consistency and safety we should follow what it says.
> >
> > [1] https://lore.kernel.org/linux-hyperv/SN4PR2101MB0880DB0606A5A0B72AD=
244B4C06A9@SN4PR2101MB0880.namprd21.prod.outlook.com/
> >
> Hmm, from some cursory research it does look like stack variables can't b=
e
> used with virt_to_phys().
>=20
> I thought about just using &hv_current_partition directly - I *think* tha=
t
> will work - but in the end I think it's just simpler to just move calls s=
o the
> percpu output page can be used as normal. That may save some additional
> back-and-forth as well as explanatory comments in the code.
>=20
> I will also add a check for hv_output_page_exists() here, as a precaution=
 in
> case the HV_ACCESS_PARTITION_ID privilege ever becomes decoupled from
> that (as it stands, I believe that permission is only for the root
> partition, but you never know).

Or just use the hyperv_pcpu_input_page, even though the use here is
for output. Then you don't have to worry about whether the output
page exists.  FWIW, I'm working on a set of changes that encapsulates
the assignment of the per-cpu hypercall argument pages, and it does
away with the distinction between the input and output pages. But
that will come sometime after this patch.

Michael

>=20
> >> +	u64 status;
> >> +
> >> +	status =3D hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, &output);
> >> +	if (!hv_result_success(status)) {
> >> +		pr_err("Hyper-V: failed to get partition ID: %#lx\n", status);
> >> +		return;
> >> +	}
> >> +	hv_current_partition_id =3D output.partition_id;
> >> +}
> >> +
> >>  int __init hv_common_init(void)
> >>  {
> >>  	int i;
> >> @@ -298,6 +318,9 @@ int __init hv_common_init(void)
> >>  	if (hv_is_isolation_supported())
> >>  		sysctl_record_panic_msg =3D 0;
> >>
> >> +	if (ms_hyperv.priv_high & HV_ACCESS_PARTITION_ID)
> >> +		hv_get_partition_id();
> >
> > I don't see how this works. On the x86 side, hv_common_init()
> > is called before the guest ID is set and the hypercall page is setup.
> > So the hypercall in hv_get_partition_id() should fail.
> >
>=20
> Oh, I tried to get too clever. I will put it back where it was and
> add it on the arm64 side to hyperv_init() after the per-cpu init as
> I mentioned above.
>=20
> Thanks for the comments,
> Nuno

