Return-Path: <linux-arch+bounces-10756-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0250FA607BC
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 04:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91ECE19C2DCD
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 03:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E61770FE;
	Fri, 14 Mar 2025 03:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="u3XgDTpG"
X-Original-To: linux-arch@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010015.outbound.protection.outlook.com [52.103.10.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DDD5223;
	Fri, 14 Mar 2025 03:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741922885; cv=fail; b=IK4VvlWTAIrP2V4acovzmzMm28K+gGEDlVjNsJ+fwCMO+FybzmNeJDoItkUoM8pHCkGNN3NlicbHgTOcIjF6KPPXpSYMohW+IzC/bz2Fj8kvfnrZM9gQfAweawXooMXq00yIqLN24GQbXJbU084IG0souXqJ2OtNT43yCMqtvhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741922885; c=relaxed/simple;
	bh=0PogA0qjexboIFmrYmKzTs8LfE412eeWZ0Cg845iIoo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kjQEwhwP6aev+9MjRgIPw7sABUv0sBRf/ai5swGoiUB6vuO4e8GNoF9CXVIuCtWWwzngQnDFoOyaM+y8WXbVjOU75PNE11thMbtrV0+zSdPEX8UpQaAd7zMhZCBdHd1qrASmY/smHZbk1XD48DTit89pLbQioWlrSVFapnI4AwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=u3XgDTpG; arc=fail smtp.client-ip=52.103.10.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGfLnaxz8zppsjmCyYWmFqYxbamlqm8nrBuu/+wKursbzPo8zX29yykJ1bT8JqieS+dgGQnbQndoMv3R+P/wiHC3Wofbl+Nc8AfVsQbo/ajZoUTWhMJZ6kEaRHrTaim7z0vuG3n1l0nol8aQL7nlBdFGHM7agzp9TeHFgDdk61PtbSwWc1Q9CyxmYOyFJosKX6NNjn4I3+HcCD/HVFL7e8Jksl17evY9HYzvZWq0lIpxSq0OTdPYwA4Q4Wc4eG2WzgyuMeh0yoDEaabCA1/KAs/YvkNy4Jxn0P+EJAkc/IeGofVdV9cWp2frSyDyz+Z7tZTqDIhc5GbZNURNIuoNTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqzIrktUDSceqVDWq2mFAjpGLT3xhxA7U5ytD+lLKnc=;
 b=r8ly7p4xgSwNDlzfd1/m9sbOp6yHoZmqiyAZa62wGkmC9zTbQml14z9nf1UL1NGnNMtcSw+cnKYoTuvrqgwIpSx5hhIZrV4fd7ort/Z6Xv3OESztIG7bzJVab6J6ZV9/rt95NBiLH2+8gEKiIzwulQIteQbvanvAGdptxfxuIj8OSVSVtjrIdChnyRDXHyR61/yqdHym1a4p9AljwYem6Q7y3Vhq9Bw3Z3xl3ViRQEcb7ZbqterxplwLQMnuvJkiPYTMBAxDKb5dQ3+KzhhWorYd9HalBxCtm97wrK1uniuSizvAFKFgypeQj1x6U0umz1puGg/vvtUyO8Eq3POHCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqzIrktUDSceqVDWq2mFAjpGLT3xhxA7U5ytD+lLKnc=;
 b=u3XgDTpGDEtzorFRwigQQohUgXXWsgJyFYBEhPEhWY/53oDC7Wb3yWPjRVelyOsWKiByquTjQn5jBs88lJFRMg0bRQaRpBCuWPakVSB5gBRMIKf89tI3Fi4Cc9HKzQN457d9WwIW0jmh3hPMTvfDi1BPxf1OIIGL9tNMJYYCjcYiL9pCPKJ/AhhVE+sGYdlnijw81LpX0I62oCM82VAdSFBQF58eH9SKO+/xhzYwVNsloiZm27Sy+FPZD+O5/mdH9j5X1hO+AAqEVtpMzgdxisS1fL/VOutLRE2jfLRx4pzOIkCS220pclNlnA/1AJtyj4QXY8KtcYZQRq4y6eWAWw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH4PR02MB10777.namprd02.prod.outlook.com (2603:10b6:610:246::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 03:28:00 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 03:27:59 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
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
	"Tianyu.Lan@microsoft.com" <Tianyu.Lan@microsoft.com>,
	"stanislav.kinsburskiy@gmail.com" <stanislav.kinsburskiy@gmail.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "prapal@linux.microsoft.com"
	<prapal@linux.microsoft.com>, "muislam@microsoft.com"
	<muislam@microsoft.com>, "anrayabh@linux.microsoft.com"
	<anrayabh@linux.microsoft.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH v5 10/10] Drivers: hv: Introduce mshv_root module to
 expose /dev/mshv to VMMs
Thread-Topic: [PATCH v5 10/10] Drivers: hv: Introduce mshv_root module to
 expose /dev/mshv to VMMs
Thread-Index: AQHbiKNt140GtdgK20KtRyAXlJwH1rNuG4iAgAPhJoCAAA1jIA==
Date: Fri, 14 Mar 2025 03:27:59 +0000
Message-ID:
 <SN6PR02MB41574CEB28BBC338EFBAE624D4D22@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-11-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157C3F431CD26EDA05E4AD4D4D32@SN6PR02MB4157.namprd02.prod.outlook.com>
 <adfdd111-f838-48a4-b77d-4207f3ab9976@linux.microsoft.com>
In-Reply-To: <adfdd111-f838-48a4-b77d-4207f3ab9976@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH4PR02MB10777:EE_
x-ms-office365-filtering-correlation-id: f4d9cf8d-0923-48f4-36b0-08dd62a83861
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799006|15080799006|19110799003|8062599003|102099032|10035399004|440099028|3412199025|12091999003|41001999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3GtBaFzMdk50h9pmGt0PDjTGxA7M+X73vSRFGdsSBNkFsRP4YjhEcqnx4O0L?=
 =?us-ascii?Q?JzMphRWTlgvxG92s9MI0ilzvo3ghdn13DUYJ47hc3XmJ0KqbfQvNvlI5Aj3F?=
 =?us-ascii?Q?/EJFpz4VGtYsNJBa6F93h+9Qo7Ev7Xq9z9+eDDP3px+fpPkm3qwujxNvWzym?=
 =?us-ascii?Q?y2LgcfFncefN1eXrZi4UVBt7tEmWGxLqqnSfx/MhKtKnwMOI7X5LL5XCzE3S?=
 =?us-ascii?Q?bKz+U8xA0djmlEbU3arkFqrFWYNR3OjrMf5IoRT6ZzjIvgcBJF+9Finjgvum?=
 =?us-ascii?Q?Sg8jBOd5EL/IgE4JuhxHmzMmr6/p/rqbtuXzzw//cBBN0RW/jRQzgCS3j7lr?=
 =?us-ascii?Q?mEckY3fnJncIXcqdLB8u25yO+GO54/5YJ++eHFDZLGt2dbodkxrJgCQ1ZqrZ?=
 =?us-ascii?Q?MaIvVGgd04SsRImgNwvEZcZa/iaYpSbDkUgKajtVmscG1m4Nj+DY6k8HVSfn?=
 =?us-ascii?Q?K8fV2wJLpmIdP8iIiRFsaNVb2fzPKz8yq0ILApCIuFSW7trm36tZQGrex7o9?=
 =?us-ascii?Q?nzMu98Gm3+y/e0PbfifmkMW7THLFix9P1YAWVtH1xqPHNThHF7MIuS44COwZ?=
 =?us-ascii?Q?rDIXLz7auhGWyif+aT8AeOYyjxBN1rly3NA2x7sH/52sGnYAhzzKzELs52gX?=
 =?us-ascii?Q?IIEmh+3Obn3J994uYwJOUW04QdPpxKb450JF3kiCEVVqkeQ0gtun4jGl6Fxh?=
 =?us-ascii?Q?LUsNlpW1LzbLOYC5UYGdOpJcH8Ml5pLoyPK5870YV/iTHT8VAsRgNfZ26gFK?=
 =?us-ascii?Q?oocKROxNhlEOBm5G6CkgCNYKMJIXRS9OH0MG7h3P4TDKl6vs9ZadGh9FuNAk?=
 =?us-ascii?Q?fZcdTCA0DxSM+NfXJ8CSOcBaudi0Cs8fnNlT3DysbjeWLRaHdCfR86AOeDSe?=
 =?us-ascii?Q?nRLxmxntRkAdEkcb2Uv+qndYHSSV3GG5KOYx1phFBAlEnokTsyzDOnQ+ueBu?=
 =?us-ascii?Q?POSubuMYMCcEGjJaQq7yNIUkMXr53xN4qE6T8ls1Og9L3CeSBn0XcXEXpAat?=
 =?us-ascii?Q?oH/IbahX1DDh0s3VBADYIsIxCAxgTaSk5DTdGvh6apngPp83UQ1tuuyYwPfF?=
 =?us-ascii?Q?ZP/NL9/6RngdSMTxACbhISlJvVUhwA4GajjAXWUsfn3rf9tPkrNX0DmmkOYK?=
 =?us-ascii?Q?jKypD0orXjGG+BosaG+jaU0K1aKgXDEO1neLIaP47StEuUoAlBOjVMdqVS26?=
 =?us-ascii?Q?3gMF+h0a/uisNhjMCjuMuY8yPDrQxvYsIVB9jm16wzuO7oLi7S3+p5Afeasl?=
 =?us-ascii?Q?QgDuIebrgZ9V4bpukp8y?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LHvBiSaKDTms4eDTZm8mjE0csHJn1cwqGUeqd1pH2ElCV9j+RG3idj+oNXf4?=
 =?us-ascii?Q?5V2Cwx5hR5bGzNCpYHOUX7X81pRzBKoaEP2F1osgDY6NuCStQ0W5Mg9pyDLK?=
 =?us-ascii?Q?yLp7XEFLiUy7ZOAMXx2gbS2b4y7+V7MzZe/Ctoi3PX9Lj3th8aVd9xeAvphc?=
 =?us-ascii?Q?Cz5yWqqn2w88msml6+zvB0lTpFp7IBkscDXgkNkgX1gTqRZ30uL62ewud72b?=
 =?us-ascii?Q?UDYHLe5os49kNUgGXRup1QFebF3NlKK+wcgvTURvjr+KsMxGuTAssKTB3o6V?=
 =?us-ascii?Q?zCt0aAWHrNFCoRn5ETWjug4GvWSvO7RGxUUvRz1bBSiFUukZ7k7jjD6wlZil?=
 =?us-ascii?Q?Ca6RGXN1pkubXpfz9+o5q+qQP67aMqojEAgwjW8nSXALWLLkLWfto1ubSBSj?=
 =?us-ascii?Q?8X4qnxp67mFIG0UO/xZaxl9QK+kRXeETnbhSTZ4t4mqlYDbNGlBt0ybbSMQn?=
 =?us-ascii?Q?pdY0OvAzbx/cknhHI2JF/YcwIiVYP9k1M7aVw1d4pd3Ai0DYL8WLOIaZZcXx?=
 =?us-ascii?Q?7eRrfl8GTdMLSzPWwLmKvh+8TSR6iXi1u2SDbEzR41Z9cImkwKNttUL7wmh3?=
 =?us-ascii?Q?pJmWIkPB1OmX5PZsE08TmCzVmkAMTXzHa03zcuXbr167Cgjk8OlljYeh0+jw?=
 =?us-ascii?Q?OBrjTjSKPOZS+WlJ982TPSxGM2OMPrpsrJUIYON4RaEZ31mjg5hsTPangH5O?=
 =?us-ascii?Q?AB4oGw5ed5Sil3oONOZlKQWzaGCvU833qkCtjp8fpMLRM8WC8tX4JPYv2aa3?=
 =?us-ascii?Q?g0K3Adh99UW1cRXUaV/lWyGSFfinnP/KIVSF2U8QYXqC4uiy7DkfcOrNMHp0?=
 =?us-ascii?Q?9RSd7nNg+n6e15Kcy+O18gamEmyLA+5cVzm9qwW5IGmwdIog1pjgKRbnqlUR?=
 =?us-ascii?Q?BIao9/sSe4D48+8O5QRz851KMRdXakzeoagKDBxk1uJd8O9Viy/vWeK92ynR?=
 =?us-ascii?Q?wqWFbePrCLmVL0RVJkp8mmP5louKoZLScgOHHOueV5lbraF8hsUSgRWT0uG1?=
 =?us-ascii?Q?YepWOjYLxlMLAmrDg8GYQXGORHaDKlfWF3sh34ufuY7o+5mbvg8S+C9mxxMY?=
 =?us-ascii?Q?tf+jZvpEqTe5QJuoa/P6yk50in5ClblQG7Jr0HCy/ZNHt6fK7MjfHJ0MKoAR?=
 =?us-ascii?Q?61wg8pEhL9u//wf+j2GtFaVnO3L7hF4hwpOjGKrshpn3vtqiykT/tvufV4bm?=
 =?us-ascii?Q?iKHLsvdk5je6skWdWWjYQ/4AY0WYJUXleVp9tjea6B+luVOEo5U2xq7YRQc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d9cf8d-0923-48f4-36b0-08dd62a83861
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 03:27:59.5781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR02MB10777

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, Mar=
ch 13, 2025 7:16 PM
>=20
> On 3/13/2025 9:43 AM, Michael Kelley wrote:
> > From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday=
,
> February 26, 2025 3:08 PM
> >>
> >
> > I've done a partial review of the code in this patch.  See comments inl=
ine
> > as usual.
> >
> > I'd like to still review most of the code in mshv_root_main.c, and mayb=
e
> > some of mshv_synic.c and include/uapi/linux/mshv.c. I'll send a separat=
e
> > email with those comments when I complete them. The patch is huge, so
> > I'm breaking my review comments into two parts.
> >
> > I've glanced through mshv_eventfd.c, mshv_eventfd.h, and mshv_irq.c,
> > but I don't have enough knowledge/expertise in these areas to add any
> > useful comments, so I'm not planning to review them further.
> >
> Thanks for taking a look. Just so you know, I was getting ready to post v=
6 of
> this patchset when I saw this email. So not all the comments will be addr=
essed
> in the next version, but I've noted them and I will keep an eye out for t=
he
> second part if you send it after v6 is posted.

That's fine.

>=20
> <snip>
> >> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst
> >> b/Documentation/userspace-api/ioctl/ioctl-number.rst
> >> index 6d1465315df3..66dcfaae698b 100644
> >> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> >> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> >> @@ -370,6 +370,8 @@ Code  Seq#    Include File                        =
                   Comments
> >>  0xB7  all    uapi/linux/remoteproc_cdev.h                            =
<mailto:linux-
> >> remoteproc@vger.kernel.org>
> >>  0xB7  all    uapi/linux/nsfs.h                                       =
<mailto:Andrei Vagin
> >> <avagin@openvz.org>>
> >>  0xB8  01-02  uapi/misc/mrvl_cn10k_dpi.h                              =
Marvell CN10K DPI driver
> >> +0xB8  all    uapi/linux/mshv.h                                       =
Microsoft Hyper-V /dev/mshv driver
> >
> > Hmmm. Doesn't this mean that the mshv ioctls overlap with the Marvell
> > CN10K DPI ioctls? Is that intentional? I thought the goal of the centra=
l
> > registry in ioctl-number.rst is to avoid overlap.
> >
> Yes, they overlap. In practice it really doesn't matter IMO - IOCTL numbe=
rs
> are only interpreted by the driver of the device that the ioctl() syscall
> is made on.
>=20
> I believe the whole scheme to generate unique IOCTL numbers and try not t=
o
> overlap them was is some case I'm not familiar with - something like
> multiple drivers handling IOCTLs on the same device FD? And maybe it's ha=
ndy
> in debugging if you see an IOCTL number in isolation and want to know whe=
re
> it comes from?

Yes, I think the debugging aspect is one that is mentioned in the text in
ioctl-number.rst. For example, maybe you want to filter the ioctl() system =
call
based on a particular ioctl value.

>=20
> On a practical note, we have been using this IOCTL range for some time
> in other upstream code like our userspace rust library which interfaces w=
ith
> this driver (https://github.com/rust-vmm/mshv). So it would also be nice =
to
> keep that all working as much as possible with the kernel code that is on
> this mailing list.

I can see that having to change the ioctl values could be a pain. And appar=
ently
there are already some historical overlaps. Also I saw that later in Patch =
10 where
the mshv ioctls are defined, you have some overlaps just within the mshv sp=
ace.
I don't really like the idea of having overlaps, either within the mshv spa=
ce, or
with other drivers.  Doing a transition to non-overlapping values would pro=
bably
mean the driver having to accept both the "old" and "new" values for a whil=
e
until the rust library can be updated and deployed copies using the old val=
ues
go away.  It could be done in a relatively seamless fashion, but I can't re=
ally
make a strong argument that it would be worth the hassle.

>=20
> <snip>>> +#endif /* _MSHV_H */
> >> diff --git a/drivers/hv/mshv_common.c b/drivers/hv/mshv_common.c
> >> new file mode 100644
> >> index 000000000000..d97631dcbee1
> >> --- /dev/null
> >> +++ b/drivers/hv/mshv_common.c
> >> @@ -0,0 +1,161 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * Copyright (c) 2024, Microsoft Corporation.
> >> + *
> >> + * This file contains functions that are called from one or more modu=
les: ROOT,
> >> + * DIAG, or VTL. If any of these modules are configured to build, thi=
s file is
> >
> > What are the DIAG and VTL modules?  I see only a root module in the Mak=
efile.
> >
> Ah, yep, they are not in this patchset but will follow. I can remove ther=
eferences to them
> here, and make this comment future tense: "functions that WILL
> be called from one or more modules".
>=20
> <snip>>> +
> >> +struct mshv_vp {
> >> +	u32 vp_index;
> >> +	struct mshv_partition *vp_partition;
> >> +	struct mutex vp_mutex;
> >> +	struct hv_vp_register_page *vp_register_page;
> >> +	struct hv_message *vp_intercept_msg_page;
> >> +	void *vp_ghcb_page;
> >> +	struct hv_stats_page *vp_stats_pages[2];
> >> +	struct {
> >> +		atomic64_t vp_signaled_count;
> >> +		struct {
> >> +			u64 intercept_suspend: 1;
> >> +			u64 root_sched_blocked: 1; /* root scheduler only */
> >> +			u64 root_sched_dispatched: 1; /* root scheduler only */
> >> +			u64 reserved: 62;
> >
> > Hmmm.  This looks like 65 bits allocated in a u64.
> >
> Indeed it is, good catch
>=20
> >> +
> >> +	/*
> >> +	 * Since MSHV does not support more than one async hypercall in flig=
ht
> >
> > Wording is a bit messed up.  Drop the "Since"?
> >
> Yep, thanks
>=20
> >> +	 * for a single partition. Thus, it is okay to define per partition
> >> +	 * async hypercall status.
> >> +	 */
> <snip>
> >> +
> >> +extern struct mshv_root mshv_root;
> >> +extern enum hv_scheduler_type hv_scheduler_type;
> >> +extern u8 __percpu **hv_synic_eventring_tail;
> >
> > Per comments on an earlier patch, the __percpu is in the wrong place.
> >
> Thanks, will fix here too.
> <snip>>> +int hv_call_create_partition(u64 flags,
> >> +			     struct hv_partition_creation_properties creation_properties,
> >> +			     union hv_partition_isolation_properties isolation_properties,
> >> +			     u64 *partition_id)
> >> +{
> >> +	struct hv_input_create_partition *input;
> >> +	struct hv_output_create_partition *output;
> >> +	u64 status;
> >> +	int ret;
> >> +	unsigned long irq_flags;
> >> +
> >> +	do {
> >> +		local_irq_save(irq_flags);
> >> +		input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> >> +		output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> >> +
> >> +		memset(input, 0, sizeof(*input));
> >> +		input->flags =3D flags;
> >> +		input->compatibility_version =3D HV_COMPATIBILITY_21_H2;
> >> +
> >> +		memcpy(&input->partition_creation_properties, &creation_properties,
> >> +		       sizeof(creation_properties));
> >
> > This is an example of a generic question/concern that occurs in several=
 places. By
> > doing a memcpy into the hypercall input, the assumption is that the cre=
ation
> > properties supplied by the caller have zeros in all the reserved or unu=
sed fields.
> > Is that a valid assumption?
> >
> When the entire struct is provided as a function parameter, I think it's =
a valid
> assumption that that struct is initialized correctly by the caller.
>=20
> The alternative (taking it to an extreme, in my opinion) is that we go th=
rough
> each field in the parameters and assign them all individually, which coul=
d be quite
> a lot of fields. E.g. going through all the bits in these structs with 60=
+ bitfields
> and re-setting them here to be sure the reserved bits are 0.

Agreed -- I would not advocate the extreme alternative.  But perhaps the
requirement on the caller to correctly initialize all the memory should
be made more explicit in the cases where that's true.

>=20
> >> +
> >> +		memcpy(&input->isolation_properties, &isolation_properties,
> >> +		       sizeof(isolation_properties));
> >> +
> >> +		status =3D hv_do_hypercall(HVCALL_CREATE_PARTITION,
> >> +					 input, output);

<snip>

> >> +/* Ask the hypervisor to map guest ram pages or the guest mmio space =
*/
> >> +static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_st=
ruct_count,
> >> +			       u32 flags, struct page **pages, u64 mmio_spa)
> >> +{
> >> +	struct hv_input_map_gpa_pages *input_page;
> >> +	u64 status, *pfnlist;
> >> +	unsigned long irq_flags, large_shift =3D 0;
> >> +	int ret =3D 0, done =3D 0;
> >> +	u64 page_count =3D page_struct_count;
> >> +
> >> +	if (page_count =3D=3D 0 || (pages && mmio_spa))
> >> +		return -EINVAL;
> >> +
> >> +	if (flags & HV_MAP_GPA_LARGE_PAGE) {
> >> +		if (mmio_spa)
> >> +			return -EINVAL;
> >> +
> >> +		if (!HV_PAGE_COUNT_2M_ALIGNED(page_count))
> >> +			return -EINVAL;
> >> +
> >> +		large_shift =3D HV_HYP_LARGE_PAGE_SHIFT - HV_HYP_PAGE_SHIFT;
> >> +		page_count >>=3D large_shift;
> >> +	}
> >> +
> >> +	while (done < page_count) {
> >> +		ulong i, completed, remain =3D page_count - done;
> >> +		int rep_count =3D min(remain, HV_MAP_GPA_BATCH_SIZE);
> >> +
> >> +		local_irq_save(irq_flags);
> >> +		input_page =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> >> +
> >> +		input_page->target_partition_id =3D partition_id;
> >> +		input_page->target_gpa_base =3D gfn + (done << large_shift);
> >> +		input_page->map_flags =3D flags;
> >> +		pfnlist =3D input_page->source_gpa_page_list;
> >> +
> >> +		for (i =3D 0; i < rep_count; i++)
> >> +			if (flags & HV_MAP_GPA_NO_ACCESS) {
> >> +				pfnlist[i] =3D 0;
> >> +			} else if (pages) {
> >> +				u64 index =3D (done + i) << large_shift;
> >> +
> >> +				if (index >=3D page_struct_count) {
> >
> > Can this test ever be true?  It looks like the pages array must
> > have space for each 4K page even if mapping in 2Meg granularity.> But o=
nly every 512th
> entry in the pages array is looked at
> > (which seems a little weird). But based on how rep_count is set up,
> > I don't see how the algorithm could go past the end of the pages
> > array.
> >
> I don't think the test can actually be true - IIRC I wrote it as a kind
> of "is my math correct?" sanity check, and there was a pr_err() or a
> WARN()here in a previous iteration of the code.
>=20
> The large page list is a bit weird - When we allocate the large pages in
> the kernel, we get all the (4K) page structs for that range back from the
> kernel, and we hang onto them. When mapping the large pages into the
> hypervisor we just have to map the PFN of the first page of each 2M page,
> hence the skipping.
>=20
> Now I'm thinking about it again, maybe we can discard most of the 4K page
> structs the kernel gives back and keep it as a packed array of the "head"
> pages which are all we really need (and then also simplify this mapping
> code and save some memory).
>=20
> The current code was just the simplest way to add the large page
> functionality on top of what we already had, but looks like it could
> probably be improved.
>=20
> >> +					ret =3D -EINVAL;
> >> +					break;
> >> +				}
> >> +				pfnlist[i] =3D page_to_pfn(pages[index]);
> >> +			} else {
> >> +				pfnlist[i] =3D mmio_spa + done + i;
> >> +			}
> >> +		if (ret)
> >> +			break;
> >
> > This test could also go away if the ret =3D -EINVAL error above can't
> > happen.
> >
> Ack
> <snip>
> >> +
> >> +/* Ask the hypervisor to map guest mmio space */
> >> +int hv_call_map_mmio_pages(u64 partition_id, u64 gfn, u64 mmio_spa, u=
64 numpgs)
> >> +{
> >> +	int i;
> >> +	u32 flags =3D HV_MAP_GPA_READABLE | HV_MAP_GPA_WRITABLE |
> >> +		    HV_MAP_GPA_NOT_CACHED;
> >> +
> >> +	for (i =3D 0; i < numpgs; i++)
> >> +		if (page_is_ram(mmio_spa + i))
> >
> > FWIW, doing this check one-page-at-a-time is somewhat expensive if nump=
gs
> > is large. The underlying data structures should support doing a single =
range
> > check, but I haven't looked at whether functions exist to do such a ran=
ge check.
> >
> Indeed - I'll make a note to investigate, thanks.
>=20
> >> +			return -EINVAL;
> >> +
> >> +	return hv_do_map_gpa_hcall(partition_id, gfn, numpgs, flags, NULL,
> >> +				   mmio_spa);
> >> +}
> >> +
> >> +int hv_call_unmap_gpa_pages(u64 partition_id, u64 gfn, u64 page_count=
_4k,
> >> +			    u32 flags)
> >> +{
> >> +	struct hv_input_unmap_gpa_pages *input_page;
> >> +	u64 status, page_count =3D page_count_4k;
> >> +	unsigned long irq_flags, large_shift =3D 0;
> >> +	int ret =3D 0, done =3D 0;
> >> +
> >> +	if (page_count =3D=3D 0)
> >> +		return -EINVAL;
> >> +
> >> +	if (flags & HV_UNMAP_GPA_LARGE_PAGE) {
> >> +		if (!HV_PAGE_COUNT_2M_ALIGNED(page_count))
> >> +			return -EINVAL;
> >> +
> >> +		large_shift =3D HV_HYP_LARGE_PAGE_SHIFT - HV_HYP_PAGE_SHIFT;
> >> +		page_count >>=3D large_shift;
> >> +	}
> >> +
> >> +	while (done < page_count) {
> >> +		ulong completed, remain =3D page_count - done;
> >> +		int rep_count =3D min(remain, HV_MAP_GPA_BATCH_SIZE);
> >
> > Using HV_MAP_GPA_BATCH_SIZE seems a little weird here since there's
> > no input array and hence no constraint based on keeping input args to
> > just one page. Is it being used as an arbitrary limit so the rep_count
> > passed to the hypercall isn't "too large" for some definition of "too l=
arge"?
> > If that's the case, perhaps a separate #define and a comment would
> > make sense. I kept trying to figure out how the batch size for unmap wa=
s
> > related to the map hypercall, and I don't think there is any relationsh=
ip.
> >
> I think batching this was intentional so that we can be sure to re-enable
> interrupts periodically when unmapping an entire VM's worth of memory. Th=
at
> said, as you know the hypercall will return if it takes longer than a cer=
tain
> amount of time so I guess that is "built-in" in some sense.
>=20
> I think keeping the batching, but #defining a specific value for unmap as=
 you
> suggest is a good idea.
>=20
> I'd be inclined to use a similar number (something like 512).

Yes, I agree the batching should be kept because interrupts are disabled.
If the rep hypercall is taking a "long time", it will by itself come up for
air to allow taking interrupts. If interrupts were not disabled, that would
solve the problem. But with interrupts disabled, you do need some
batching.

Using a number like 512 makes sense to me. Just add a comment that
the value is somewhat arbitrary and only to allow for interrupts. It's
not based on memory space for input/output arguments like all the
other batch sizes.

>=20
> >> +
> >> +		local_irq_save(irq_flags);
> >> +		input_page =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> >> +
> >> +		input_page->target_partition_id =3D partition_id;
> >> +		input_page->target_gpa_base =3D gfn + (done << large_shift);
> >> +		input_page->unmap_flags =3D flags;
> >> +		status =3D hv_do_rep_hypercall(HVCALL_UNMAP_GPA_PAGES, rep_count,
> >> +					     0, input_page, NULL);
> >> +		local_irq_restore(irq_flags);
> >> +
> >> +		completed =3D hv_repcomp(status);
> >> +		if (!hv_result_success(status)) {
> >> +			ret =3D hv_result_to_errno(status);
> >> +			break;
> >> +		}
> >> +
> >> +		done +=3D completed;
> >> +	}
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +int hv_call_get_gpa_access_states(u64 partition_id, u32 count, u64 gp=
a_base_pfn,
> >> +				  union hv_gpa_page_access_state_flags state_flags,
> >> +				  int *written_total,
> >> +				  union hv_gpa_page_access_state *states)
> >> +{
> >> +	struct hv_input_get_gpa_pages_access_state *input_page;
> >> +	union hv_gpa_page_access_state *output_page;
> >> +	int completed =3D 0;
> >> +	unsigned long remaining =3D count;
> >> +	int rep_count, i;
> >> +	u64 status;
> >> +	unsigned long flags;
> >> +
> >> +	*written_total =3D 0;
> >> +	while (remaining) {
> >> +		local_irq_save(flags);
> >> +		input_page =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> >> +		output_page =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> >> +
> >> +		input_page->partition_id =3D partition_id;
> >> +		input_page->hv_gpa_page_number =3D gpa_base_pfn + *written_total;
> >> +		input_page->flags =3D state_flags;
> >> +		rep_count =3D min(remaining, HV_GET_GPA_ACCESS_STATES_BATCH_SIZE);
> >> +
> >> +		status =3D hv_do_rep_hypercall(HVCALL_GET_GPA_PAGES_ACCESS_STATES,
> rep_count,
> >> +					     0, input_page, output_page);
> >> +		if (!hv_result_success(status)) {
> >> +			local_irq_restore(flags);
> >> +			break;
> >> +		}
> >> +		completed =3D hv_repcomp(status);
> >> +		for (i =3D 0; i < completed; ++i)
> >> +			states[i].as_uint8 =3D output_page[i].as_uint8;
> >> +
> >> +		states +=3D completed;
> >> +		*written_total +=3D completed;
> >> +		remaining -=3D completed;
> >> +		local_irq_restore(flags);
> >
> > FWIW, this local_irq_restore() could move up three lines to before the =
progress
> > accounting is done.
> >
> Good point, thanks.
> <snip>
> >> +		memset(input, 0, sizeof(*input));
> >> +		memset(output, 0, sizeof(*output));
> >
> > Why is the output set to zero?  I would think Hyper-V is responsible fo=
r
> > ensuring that the output is properly populated, with unused fields/area=
s
> > set to zero.
> >
> Overabundance of caution, I think! It doesn't need to be zeroed AFAIK.
>=20
> I recently did a some cleanup (in our internal tree) to make sure we are
> memset()ing the input and *not* memset()ing the output everywhere, but
> it didn't make it into this series. There are a few more places like this=
.
>=20
> <snip>
> >> +
> >> +int hv_call_set_vp_state(u32 vp_index, u64 partition_id,
> >> +			 /* Choose between pages and bytes */
> >> +			 struct hv_vp_state_data state_data, u64 page_count,
> >
> > The size of "struct hv_vp_state_data" looks to be 24 bytes (3 64-bit wo=
rds).
> > Is there a reason to pass this by value instead of as a pointer? I gues=
s it works
> > like this, but it seems atypical.
> >
> No particular reason. I'm guessing the compiler will pass this by copying=
 it to this
> function's stack frame - 24 bytes is still rather small so I don't think =
it's an issue.

Right, I think the code works as written. It's just atypical. When I see st=
uff that
doesn't fit the usual pattern, I always wonder "why?"  And if there's no go=
od
reason "why", reverting to the usual pattern avoids somebody else wondering
"why" in the future. :-)  But you can leave it as is.

>=20
> I'm also under the impression the compiler may optimize this to a pointer=
 since it is
> not modified?

It might. I'm not sure.

>=20
> I usually only pass a pointer (for read-only values) when it's something =
really
> large that I *definitely* don't want to be copied on the stack (like, 100=
 bytes?).
> In that case I probably only have a pointer to vmalloc'd/kalloc()'d memor=
y anyway.
>=20
> <snip>
> >> +	local_irq_save(flags);
> >> +	status =3D hv_do_fast_hypercall8(HVCALL_CLEAR_VIRTUAL_INTERRUPT,
> >> +				       partition_id) &
> >> +			HV_HYPERCALL_RESULT_MASK;
> >
> > This "anding" with HV_HYPERCALL_RESULT_MASK should be removed.
> >
> Yep, thanks.
>=20
> >> +	local_irq_restore(flags);
> >
> > The irq save/restore isn't needed here since this is a fast hypercall a=
nd
> > per-cpu arg memory is not used.
> >
> Agreed, will remove these for the fast hypercall sites.
>=20
> <snip>
> >> +		input->proximity_domain_info =3D hv_numa_node_to_pxm_info(node);
> >> +		status =3D hv_do_hypercall(HVCALL_CREATE_PORT, input, NULL) &
> >> +			 HV_HYPERCALL_RESULT_MASK;
> >
> > Use the hv_status checking macros instead of and'ing with
> > HV_HYPERCALL_RESULT_MASK.
> >
> Thanks, these need a bit of cleanup.
>=20
> <snip>
> >> +	status =3D hv_do_fast_hypercall16(HVCALL_DELETE_PORT,
> >> +					input.as_uint64[0],
> >> +					input.as_uint64[1]) &
> >> +			HV_HYPERCALL_RESULT_MASK;
> >> +	local_irq_restore(flags);
> >
> > Same a previous comment about and'ing.  And irq save/restore
> > isn't needed.
> >
> ack
>=20
> <snip>
> >> +		status =3D hv_do_hypercall(HVCALL_CONNECT_PORT, input, NULL) &
> >> +			 HV_HYPERCALL_RESULT_MASK;
> >
> > Same here.  Use hv_* macros.
> >
> ack
>=20
> <snip>
> >> +	status =3D hv_do_fast_hypercall16(HVCALL_DISCONNECT_PORT,
> >> +					input.as_uint64[0],
> >> +					input.as_uint64[1]) &
> >> +			HV_HYPERCALL_RESULT_MASK;
> >> +	local_irq_restore(flags);
> >
> > Same as above.
> >
> ack
>=20
> <snip>
> >> +	local_irq_save(flags);
> >> +	input.sint_index =3D sint_index;
> >> +	status =3D hv_do_fast_hypercall8(HVCALL_NOTIFY_PORT_RING_EMPTY,
> >> +				       input.as_uint64) &
> >> +		 HV_HYPERCALL_RESULT_MASK;
> >> +	local_irq_restore(flags);
> >
> > Same as above.
> >
> ack, and I'll double check we don't have other fast hypercall sites doing=
 this
>=20
> <snip>>> +		/*
> >> +		 * This is required to make sure that reserved field is set to
> >> +		 * zero, because MSHV has a check to make sure reserved bits are
> >> +		 * set to zero.
> >> +		 */
> >
> > Is this comment about checking reserved bits unique to this hypercall? =
If not, it
> > seems a little odd to see this comment here, but not other places where=
 the input
> > is zero'ed.
> >
> I agree the comment isn't necessary - memset()ing the input to zero shoul=
d be the
> default policy. I'll remove it.

This is another case where something doesn't fit the usual pattern, and I w=
onder
"why". :-)

>=20
> >> +		memset(input_page, 0, sizeof(*input_page));
> >> +		/* Only set the partition id if you are making the pages
> >> +		 * exclusive
> >> +		 */
> >> +		if (flags & HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_EXCLUSIVE)
> >> +			input_page->partition_id =3D partition_id;
> >> +		input_page->flags =3D flags;
> >> +		input_page->host_access =3D host_access;
> >> +
> >> +		for (i =3D 0; i < rep_count; i++) {
> >> +			u64 index =3D (done + i) << large_shift;
> >> +
> >> +			if (index >=3D page_struct_count)
> >> +				return -EINVAL;
> >
> > Can this test ever be true?
> >
> See above in hv_do_map_gpa_hcall(), it's more of a sanity check or assert=
.
>=20
> >> +
> >> +			input_page->spa_page_list[i] =3D
> >> +						page_to_pfn(pages[index]);
> >
> > When large_shift is non-zero, it seems weird to be skipping over most
> > of the entries in the "pages" array.  But maybe there's a reason for th=
at.
> >
> See above where we do the same thing in hv_do_map_gpa_hcall(). The hyperv=
isor
> only needs to see the "head" pages - the GPAs of the 2MB pages.
>=20
> >> +		}
> >> +
> >> +		status =3D hv_do_rep_hypercall(code, rep_count, 0, input_page,
> >> +					     NULL);
> >> +		local_irq_restore(irq_flags);
> >> +
> >> +		completed =3D hv_repcomp(status);
> >> +
> >> +		if (!hv_result_success(status))
> >> +			return hv_result_to_errno(status);
> >> +
> >> +		done +=3D completed;
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >
> > [snip the rest of the patch that I haven't reviewed yet]
> >
> > Michael


