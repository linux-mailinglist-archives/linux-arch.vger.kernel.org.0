Return-Path: <linux-arch+bounces-13686-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D77B876AC
	for <lists+linux-arch@lfdr.de>; Fri, 19 Sep 2025 01:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DB02621006
	for <lists+linux-arch@lfdr.de>; Thu, 18 Sep 2025 23:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ECB22FE02;
	Thu, 18 Sep 2025 23:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="F3J1k6HC"
X-Original-To: linux-arch@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010022.outbound.protection.outlook.com [52.103.20.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F65E34BA5A;
	Thu, 18 Sep 2025 23:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239542; cv=fail; b=GCpChgFdj1CQqlalFEFRHfCwQb6czVqNlGPZBIBbt+HH8MRLUno6Sg5qJrt3ErrKv5zRsM7nWfVXlnqgs1+AKRBzSJHVFg1RX6t341PV3EyqtVGGfMpu0B/1VJCrBVUjaQhHzVvY/IJfcuxpNgHpJ8RoQ2e0GhQ3dvNWF1i0TeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239542; c=relaxed/simple;
	bh=CIbU3kVA6YaWsZg9923XtuXGDkUDhVySR9MK6tEIfgk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XpugbBXGcZ13a9l+9ZU9b+ckaa586xE15bTcXCjgQ4/l6ymXE1sWql0NMru6k5MClK+A9a2//hJH/VE7SzVeIKeyvjgA3CYIa+Pu8/78GaO7KJzZJVGkA5cr8sDr5/XgaSzWV7y0oekwr+/9A7q4AZ29pTSrgY8f0z2hyVDkwDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=F3J1k6HC; arc=fail smtp.client-ip=52.103.20.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zD1uE8LEU8Yxkbt59YZSZV2ZyQCtVLZLxn1sCFmFtkw4+GVJ4DSMN4bx3oCWLtPU4Y2RJF3Garfs4Z9sFhVex+RcveXqDBjHb2KN/kPh7Y1C5XlyypK79n2KVM7H3AgxBDKsD7gHVnsKPzwHo97gBc65nh2A21fP05vDvYa13DAzA+6alkLcO4m6SPQ0fK8ljkEm472gDsFz6bVRXyzHv8843Gu5DnyTyJQWtZ+L6dzugVr5dw1sG4D3PicS+AnB/vqxoaNnHix9usROPM1lLf1foZz6kHlVfWBgZS4Wrv2/sYqb7OTDyS+/hEO3EtYEnV78+xW0RLoayRP+mIL5LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WU+Kn4Hz1o9kDCC2O268oyFQFxn5WCz0+Wesex1lLuY=;
 b=l0PZ+aKpxGzczmSweSXZhcmMW0lzj4u6N4cj6oWPFn19OmGGOWLgXMqZD82bnONoVcHmBmEdVqsVvU8oS+Jlh+WJr1X2SQDqlWVC7Z8DYbHa4UqMTZ6u101apU8jVzK0K11O3e/Gl/+iPOyjoyfi/L01yIEYUOizqbpDNH1pQz7LgBOUdy+6wXExnUyDuB4C5gNnXX+KfGxpiz8UJXc4do/l2s1HqMw6coNc2F1VeoCXuj124pQt345TvA+Fizr+283PTrUQHEcUj0IlIlAcnpNhzdHitQe0Ja3XBuK1RVJBwV58JNflt79h+nUs2UbiVX5+fpWIHfv9njII5gilnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WU+Kn4Hz1o9kDCC2O268oyFQFxn5WCz0+Wesex1lLuY=;
 b=F3J1k6HC2owReL7nYpyFrpQn6KyeHo9ROuah23Q40XBoMiJwqiePGVxym/3aDuZt6QGiV1IH/8lp2nxchZPJk/hDKWS8ZjIg6N00RHFZkFL+KMD5uqoA4FaxoMdt7IilNSJqwNDUHVMqxaVgPQMnBs4NHMuzEDyd0Nt9n4uXNm6n0q06Wo2eTvpR1CFO1KqrkFxxYVZrIbJmKaozxO9So11gZWj+cX5o5jfWYNWtfg7TJSoBDWuQjRz03rCokUdKOJZgelmMq9EtTE2vL51PFFcQuXcNkU4UKWSzplngmB3a1I/hQXRb6ldwIlqIh1QV6zAPWKWjpiThKGWqeIF4Pg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MN2PR02MB6733.namprd02.prod.outlook.com (2603:10b6:208:1de::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 23:52:11 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 23:52:10 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Mukesh R <mrathor@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"arnd@arndb.de" <arnd@arndb.de>
Subject: RE: [PATCH v1 3/6] hyperv: Add definitions for hypervisor crash dump
 support
Thread-Topic: [PATCH v1 3/6] hyperv: Add definitions for hypervisor crash dump
 support
Thread-Index: AQHcIed8M0Zuk7Pq9UqlkAFRSftZ8LSSw9+wgAJHEICABAiccA==
Date: Thu, 18 Sep 2025 23:52:10 +0000
Message-ID:
 <SN6PR02MB4157A17B9CC74CD69E191949D416A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250910001009.2651481-1-mrathor@linux.microsoft.com>
 <20250910001009.2651481-4-mrathor@linux.microsoft.com>
 <SN6PR02MB41577F7E862976DE192DB9C0D415A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <cfcbdf49-33e6-685c-daed-4dd8f1523c49@linux.microsoft.com>
In-Reply-To: <cfcbdf49-33e6-685c-daed-4dd8f1523c49@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MN2PR02MB6733:EE_
x-ms-office365-filtering-correlation-id: f8a09bb6-6b50-4797-33f5-08ddf70e625b
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|461199028|31061999003|8060799015|8062599012|19110799012|13091999003|440099028|3412199025|40105399003|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?jk1XUf+XtM0lKL+WAGCwv6xjUsJ8ZPr2nqCyIOecN7jodUsQo+6+J7uzifIA?=
 =?us-ascii?Q?CGZin2nEsvJaOKdOnyqTx+xD6XiZRBLmlwNVvRFjzHwFiawI7CA4h0LyMt6X?=
 =?us-ascii?Q?3SlVrx8CiuipZ+6IR2Z+N2OXXH36j9lmfWt7IFUVb+DYzm/rldrAoo8HS/LT?=
 =?us-ascii?Q?TVoY5tzNB8H+ReDA2xU/a4RfsWafcBO1CmW0G/Adl/S672wwdE1ATw6TdddY?=
 =?us-ascii?Q?wx3uRknZH/sdUq4yK/2ldCr1NUvD9UbRf2C5kYJZXv4f4pFQfBLvgguPSnCB?=
 =?us-ascii?Q?+UswrlxO+OqKKItolXO27SKyy2ANq1NHDP1Y4MpiRenhBo3OoNJgP3ZdwxZH?=
 =?us-ascii?Q?H5hDF/WYzGNzWxyGRKi+74pJQNzLw3gSLYP61VL71DvPgqi6cuynPAiQF8Bq?=
 =?us-ascii?Q?oLyoeHMo8pY5yJivMsdZsn18mSEZYtjmdD/M+XR+OjrYtFPQBb1sWCvsbDBI?=
 =?us-ascii?Q?C2uGMNYzID0M/7piPGGbY3tBUnsMx0QywjWI8CPZd8vj/J62OTWNEDIcvQb6?=
 =?us-ascii?Q?WR/Gd+szMp5KxE8lL44g5fyomPAr1NarxOCb3T/jl5bD0maI2m35dad+AoSy?=
 =?us-ascii?Q?+JrtH39M9QOkgby3kKypNnhi7zKHnsq+PCX7aYbn7zVzjnpJW6HYMtq9OEEk?=
 =?us-ascii?Q?fsqfhebeqrJuTSlSVwydOsPaiZMYrC2UEF0KRLfJigDTjqivNuOR9vJmfgbn?=
 =?us-ascii?Q?JuIZDX/k8TgnKSZqsFx1QMVPXfUqHg2r3g+ZrkXvHNMvv2SIDjtwbzqxrB/w?=
 =?us-ascii?Q?JQTeQMVXyEzebQ75Cw/h5b5LK97yTu02zsE3Ft+qXcEBD+wyEAyNPRPRoXyg?=
 =?us-ascii?Q?MQ4RMXQtCNC34gtN7BKRPFL+Bg7GRkPB94XuNViRnkkE99FYr+K9rjw5l17D?=
 =?us-ascii?Q?YL1IbWzkSUz9XQ5+Uwbc6EPd7nFyjRZ1UuMGzs65NkBPOWW6K7fcrE4LRdsR?=
 =?us-ascii?Q?dm6czBarskH8ygcvWQ4z0I6MeaTfiRtu7T1jLlZ1Wc8yKNbpouPoRq/+JhBu?=
 =?us-ascii?Q?+4iEhuoKXrOJsSTf4SvZtciF7lW3nLga9sxZAKNumYkxLZfFCAN7UAMGf1h6?=
 =?us-ascii?Q?u3zGZuvrquZ5ojTtAWyPQ+Cqo6uT1dCiXZS5vuexIOx0+nCkODe8qmKoC06u?=
 =?us-ascii?Q?kM8OVku4XBqnYSihnJN53xfHgxxMjkrnfFew0XriRIuhu10VHus56GgFBEfB?=
 =?us-ascii?Q?FkuBLg4N3Oft8g76/Gi8Gd9W4rUwRLDP9/kWEg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MpSVocRe03hyvUskgzuAeN/InUqQK4/NgKBiHdF/Or+Flpna3iIl3xbqQZMp?=
 =?us-ascii?Q?JW2hRuGXl+JOPgOMoDCB58j7Gy0yrDtasqpA+5BM6vuKe+h2dC2jrGbIPSg3?=
 =?us-ascii?Q?bgag+CEUyilbBC2lE1GylebFS50ispPBS8wrE9q5gakbuvnEeQLVZU6rDJ0+?=
 =?us-ascii?Q?R+dSLZTix/db2i07p/mXpo33FQGIJZaF2ptWBEx5Mu1gQHXGCt8MDpnC6gvr?=
 =?us-ascii?Q?Jh5i8V5iGjBsWV2Q/yJkL9OpyS/qbSNdh6sv1NyRBUhrHq0o2M84Bx/Ju8ki?=
 =?us-ascii?Q?tVfoDEJv44fWH908AMf+NAQZtCQrxKl4c+dH0U7UYcNTHq9f5ERLKIyHS7v1?=
 =?us-ascii?Q?qUDMk/wTzsb3grlNxTiMxZOyrRbDiQ5OZffpIYMjp4CYGLrrVr6HG7l6K0Xj?=
 =?us-ascii?Q?TSNGwr9VXvUZ68a8gGNk1Xzq7CQwEXWgPxEMl9PEXlZXnOEIZNQuJSjWqQop?=
 =?us-ascii?Q?SoiLI/9VsJgWRsxK3O7WNl0GqQLRF84EctnIGolGcXncpDcQ4DnioPiozlIM?=
 =?us-ascii?Q?0jyO7gLBcWZqpdJnP0ByW5Y2l1ivu/7aFMXbxOxI65rO6vUwSHU642VXhW/e?=
 =?us-ascii?Q?FKA9dIaF5cidqmvOvgsDBwm8UFN7J+IKdrMvKzczXUVjq8Uk+to5b+C2/uJZ?=
 =?us-ascii?Q?j+8KVsM10iZ0rq7uuj8emmg0JmOfp3+6KnD/ZdGOyHc2zceP3uUR3sVhAKY6?=
 =?us-ascii?Q?jZywYwB9of2Ha5Qv8q0v1zz48G6aMANoTJHckr+THs4+h/nR+21jPTzqGf0y?=
 =?us-ascii?Q?ERI5P8OEUICExd07gPqaoxYY0bU4FscF+5ETytoYrAgmTEpBsAOGqvTmFl96?=
 =?us-ascii?Q?SR04D4jw9rzO8oFfUTL+5R8MM1nVmcYFCR6vTdA7/VG8Zz8h91CvapEIl8RI?=
 =?us-ascii?Q?Zq1zMFIDiEK6rz2ZGwKewrTSD1uEFPSdkMaLjG2uu4iZd5dE3Q/YljGlgwHH?=
 =?us-ascii?Q?ssG4shdzhEuyucmbNtyPLrdkRDjHe3IYPoqYnT38/+Ek0DUTG57yLCJYdhu/?=
 =?us-ascii?Q?hBSsbJP76LQH8lUwAlXNj846JeqEVY98F0w5ZXlByHqhz01PUG78OC+3gILR?=
 =?us-ascii?Q?shemflQZmg4T9PO3/nx94teJ8+LLMHF8RCD5EiYkAqVV4l6TqfsbfpZi948Z?=
 =?us-ascii?Q?TeIi8K3U7arngcky0q31GnO0DPMMF1kq7mtvpLe1OFbd/Vc366SDJ4Lp/1M/?=
 =?us-ascii?Q?23ZMJe/KqIGVL4NDVUoFC4AMAOi369ZF1vQW/5TvveSofmMFjGek/NXfJ/g?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a09bb6-6b50-4797-33f5-08ddf70e625b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 23:52:10.8017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6733

From: Mukesh R <mrathor@linux.microsoft.com> Sent: Monday, September 15, 20=
25 6:15 PM
>=20
> On 9/15/25 10:54, Michael Kelley wrote:
> > From: Mukesh Rathor <mrathor@linux.microsoft.com> Sent: Tuesday, Septem=
ber 9, 2025 5:10 PM
> >>
> >> Add data structures for hypervisor crash dump support to the hyperviso=
r
> >> host ABI header file. Details of their usages are in subsequent commit=
s.
> >>
> >> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> >> ---
> >>  include/hyperv/hvhdk_mini.h | 55 ++++++++++++++++++++++++++++++++++++=
+
> >>  1 file changed, 55 insertions(+)
> >>
> >> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> >> index 858f6a3925b3..ad9a8048fb4e 100644
> >> --- a/include/hyperv/hvhdk_mini.h
> >> +++ b/include/hyperv/hvhdk_mini.h
> >>

[snip]

> >> +enum hv_crashdump_action {
> >> +	HV_CRASHDUMP_NONE =3D 0,
> >> +	HV_CRASHDUMP_SUSPEND_ALL_VPS,
> >> +	HV_CRASHDUMP_PREPARE_FOR_STATE_SAVE,
> >> +	HV_CRASHDUMP_STATE_SAVED,
> >> +	HV_CRASHDUMP_ENTRY,
> >> +};
> >
> > Nit: Since these values are part of the ABI, it's probably better
> > to assign explicit values to each enum member in order to
> > ward off any mistaken reordering or additions in the middle
> > of the list.
>=20
> No, like I have mentioned in the past, we are mirroring hyp headers
> with the eventual goal of just consuming from there directly.
> Each change in ABI header is very carefully examined, we now have
> a process for it.
>=20

Acknowledged. I keep wanting to tighten up the ABI specification,
and sometimes forget that there are constraints on doing so.

Michael

