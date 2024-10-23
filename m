Return-Path: <linux-arch+bounces-8496-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6229AD404
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 20:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F187DB21C71
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 18:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FE01CEAA2;
	Wed, 23 Oct 2024 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="X52IXmuc"
X-Original-To: linux-arch@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012051.outbound.protection.outlook.com [52.103.20.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708101474D9;
	Wed, 23 Oct 2024 18:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729708381; cv=fail; b=BennqmzSjn+JjAiTIHN9L7wLj1zco7k3bK5Vyb+jjt3ExFkmFn7GZjREzz500FrOCmwNoLHkqg8FrZEpTggUNmwjH+o1+OA8t3P89fdRm+banc/JaUhr/Z2L3TIxl/UI8Z7girTgIsG+Mo0q9ezytu9W0yn1IM5oEDjje1JtumA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729708381; c=relaxed/simple;
	bh=whA2JyicEbUahsVBR6dZfHqBhbXai16Lju8waqdEdKw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GGmjnLQ4oQgh+YG/9M+9zKaea/5gfkll+iMrXCIBm3oaJnw8BG1O282xEORwUxzTZPP+UDigU4FRNUSC2Myy5JVx84QKzs14PySDBl0ykaS4Zp2mQU3oa4jygxA83czWUNBko8BUmhNuw3ux5Vyhh4h2JUKMqqOQRS84nApxYk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=X52IXmuc; arc=fail smtp.client-ip=52.103.20.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o52zE4TwkHqKhbdtYSOJ/bh6XHJkfD4t3MfY04K2LLwKDgHOv9A93OFlimRr9Ezus5Q3mlDvrSxcpbqPMQ/X1sT1sEi5nqlb3V6nGuHr5bGBSsoM1ZVG8t6v5HIY/qE3FgLfiQ0M5Sbm2P+/o0yRadPPg8S5iSMQuvknS4S1PvKFtjp7v2zNDjmfwa3OaM0bQpGnD9Lyj8b5bvqXSTkyMASTeDdon5fcmpPMAc33yvD9SqnnlQBIkLWJ/BrAV8/Y+CkhY9gHAo8XbaTYhNImMJDhHNhBAHQpbKYkotUpFMWqNoBXgE5ZrAx98LaZmsDcsKStOiX6c6zhT+J3WqbwBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJIGQUcepuYiINMQxiEXnCpZPvyrJxDKc4luqEkf6Q0=;
 b=oJTburLRFp4HwGQbvNzyOjztYMW9kv1VnsuLtrt4ZgLsSOLyRWIEx5vtcJ7JmOkYzKib4/Fvy3PIhdgehF4i54zl3yFZYneRu5pYmIMp8YL/iS5gaiDVhbnNfcNFkD/QqFR/h7RiYGe4JkIDUbXMA736zVt7GAlstLSSzEIEtL+me28Le1Uz8b5h+N/qnnWFZDSW4Dg0M1s1Vz8NKjGIrHCZ4yDj7FYG3XbXeCOBA9+tAnzy8/CUbhmsfX4SO/Ga7CDVRK10a9E+/GpWXQDK/CfVT696lzWjs5bDU8Heu+mCdZmYm373b3Sy3CxH/1cI3RPQC2zxnMLnn5DY5Ca2iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJIGQUcepuYiINMQxiEXnCpZPvyrJxDKc4luqEkf6Q0=;
 b=X52IXmucWAtdWBNhrzoCbzpZeJWYPCQdTNHxjboZQqYcCMpm7haW+D3Qye351Spbsd1sRzLfP++fxHanoMCEALaYKSmwWBqanuOetcypHy7XfJxZU+5EAjlnJ8y26uopG23Zv/7i3GPCveohbDlmyw4xp6JHAkDRUZYbOPE6e0wLddXDonsb3onC6INcqbV7yhnqUqYTgIdQgqtqDdiGDCJfNs981zglw2CM9mnghyILc4KCEMv3Ffx4mXT+sN9l4WxlzYWedLOa8PkdujGq8Rq3imZ1KATG5I2N3K9OuKMxF0BEwweNfSz5ObQ2IrVscWys3hw0y7vXQKe7gSSNHw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA2PR02MB7818.namprd02.prod.outlook.com (2603:10b6:806:135::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 18:32:55 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8069.016; Wed, 23 Oct 2024
 18:32:55 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"luto@kernel.org" <luto@kernel.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"seanjc@google.com" <seanjc@google.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "joro@8bytes.org"
	<joro@8bytes.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "robh@kernel.org"
	<robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
	"muminulrussell@gmail.com" <muminulrussell@gmail.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
	"mukeshrathor@microsoft.com" <mukeshrathor@microsoft.com>
Subject: RE: [PATCH 0/5] Add new headers for Hyper-V Dom0
Thread-Topic: [PATCH 0/5] Add new headers for Hyper-V Dom0
Thread-Index: AQHbFc3gheIHrTrmm0yVUene//yVY7J/bLBwgBQy+4CAASapQA==
Date: Wed, 23 Oct 2024 18:32:55 +0000
Message-ID:
 <SN6PR02MB4157A9D52A882A2109590708D44D2@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1727985064-18362-1-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157F6EA7B2454D2F6CBF2ECD4782@SN6PR02MB4157.namprd02.prod.outlook.com>
 <725bac7d-5758-44fd-82cc-29fb85d8c53f@linux.microsoft.com>
In-Reply-To: <725bac7d-5758-44fd-82cc-29fb85d8c53f@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA2PR02MB7818:EE_
x-ms-office365-filtering-correlation-id: d106ae6f-fe77-45b0-80a1-08dcf3911cad
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799003|8062599003|8060799006|15080799006|440099028|3412199025|102099032|56899033;
x-microsoft-antispam-message-info:
 VKljilNyhGh7Xncxzl/8iHWUY6fEqaKXLxD4wZfPoMKmG5ya9/Jm9w7Lspvjvd/OA+Zr349iNZ/bSy9xlR65RsfY7gvfdb4KaPWknZ7+96EUyMCJeFHvCK8khlPWzBx5jNluQ2/BWZtjhQHaT/FBMSE4SUXCNhuwEmBks3FBDbfuDoW0PhVydV3W3nySZOqI3CrQC3GaiiMIaDWoAPysHihcDPvkJx8kgyTNVqB5koAmkNrGkisa2HzdJD6h2rJUklCT7DsDtVR/DQVOuMFNlnC4M2mnfX1+msUVU9VmnNq7ih4jMOUdYMmJnadlbK426jwv2xY9Ov03i1cFEWQQjSAX5X4Bc4/pKkyFl9spoQBlGCTA+/N3677rw21LJXhuV7x1h1mxf2X9IYOSJ2Vcn/qgLJdKl6VPebruooYFWCtbWu+YqzBNgtaac6RFLI+XPe15Xxn9PZEGO0kd+F9fvmoe3Q+x0+mqtUSupR0k46W9UPqBo7kl8zWcBejYVVL3ZIQqK0ZQZOKoAgDAe42w87KEf31iURz19yOCPS/xUz8OqcOQbETQ1Wn5HKBGz2isQlmAcPx8OOG4TrP+5wiLX3hYyz6IRLMTgN+lEZkAtWGhQ+0YV2ZIOVef8oUkV8gxx23H+fcldkWkkzJtGNVhTl7py42f9ihN3FjsBRqzWdLzRdOO430iBQLR97xt/W1CX3teV9zUfNgdodwobnFOPQ==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AHQFqsehxhiVeP76Z+uAOVsL2Hilkjih1uCzMZ0NbkXN5or8SJ1PedLEyYPN?=
 =?us-ascii?Q?W/ch4t6JHdqabBk/+awlnSdkPeYx+sE2dPlI/jY/NBwovs01IoJy+idxAjS0?=
 =?us-ascii?Q?Msly8r/tfIh8zkFSvOIhQcvfzpm+LJABdHK4+pq2gIBV/DTMkiBFpViowM1L?=
 =?us-ascii?Q?RCPu/m3gLMN9WKjY1NoYwtVSu17IV5Kek/ef4HLn9CRMsOdc/rONLUIETqw2?=
 =?us-ascii?Q?Cv60Uo72l6YDXUVBXXX4z7Qt57b/m0PpCU9rmULVi1IHdz1dRLXJr5Vj/P24?=
 =?us-ascii?Q?gW/m15bruXuEK6C7J9c/KTAv6eEjlajWytmgT4g4jyD53fhVpF4RYaIjqG/p?=
 =?us-ascii?Q?EOF5xM3C5LEfp1m95bjJsGay75C9Zl6+OSOjrHJYcflEWlTO6nTR+6eJs9l8?=
 =?us-ascii?Q?Y5fmNwlgPTirZNTwOt7fY/+WI8UOGZcLnBxStz/t+lmOQlcMB21lmQ0JteIZ?=
 =?us-ascii?Q?c51omprzRl1DRLvWS3vsZu0WRBR3Wc9jfnTiXYtTIuMI/FCcMcrjVT18vnqn?=
 =?us-ascii?Q?nBYsmBlh85c11Rgo6r45acyPpW6EQnSCN3HWaz1kVvXK4fDEbA7Rs0pF7NN2?=
 =?us-ascii?Q?9jaNWXf9AY1gnLl6vvJSvL2BCQN9aW/OBTg4gpoCqdK+hDj6En4bIXH3I9uU?=
 =?us-ascii?Q?jkrStxuDINCOfa1Cr6DYDg64tu4pW6saWAphO5LUMioaoa2d3NXX/m9CQZRN?=
 =?us-ascii?Q?T6qRM1Kd260u6/XMokcnuyV9rPb5w9y0pSJyhFOzluc7InheXiRcTw6GIQy2?=
 =?us-ascii?Q?xpNA176qa7+7gjM7xpz4wdISxJ+izL0arosO7FC58WNWZJD0rrLKu98SqYnk?=
 =?us-ascii?Q?Zrzr6lGMU12ic5fIfCWnH01pRq13gyJETFJCDrL9QjcY4raG1AAcGJecCW/l?=
 =?us-ascii?Q?p5ScZygeajenK+j8J2FFcNO75060qdh2EQKqPFg98IWTCs1c6O7uz+tbEXyj?=
 =?us-ascii?Q?aD7UIgnA5UR2iUkIKxCCmG7Y+SmrxSww2k3mdwaXfW/VRiAg3y4y1usqQ9lc?=
 =?us-ascii?Q?saFosb2Spk6OJiU/1sGC5Uj5X5Yb2PR9DlRBxHAkZFYIZiihXbGrbKU7S0cN?=
 =?us-ascii?Q?1b97FZ8X2i5AKzliTjpyfha/RaHpc2pzCZT+rpRu4kH/l5NSkVqEpFibBaSc?=
 =?us-ascii?Q?oADidR7G1obKD0hc3gEocLAJneRHdrGflVQDDwvIW6/4p74sHL9Yyhg6m7m6?=
 =?us-ascii?Q?znekee52zubbjRGfs5p8lPJNiDz0mWR+838XrQnbG6UKBJ6C95dJcmr9P1c?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d106ae6f-fe77-45b0-80a1-08dcf3911cad
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 18:32:55.6164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7818

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Tuesday, Octo=
ber 22, 2024 5:51 PM
>=20
> On 10/10/2024 11:21 AM, Michael Kelley wrote:
> >

[snip]

> > Have you considered user space code that uses
> > include/linux/hyperv.h? Which of the two schemes will it use? That code
> > needs to compile correctly on x86 and ARM64 after your changes.
> > User space code includes the separate DPDK project, and some of the
> > tools in the kernel tree under tools/hv. Anything that uses the
> > uio_hv_generic.c driver falls into this category.
> >
> Unless I misunderstand something, the uapi code isn't affected at all
> by this patch set. e.g. the code in tools/hv uses include/uapi/linux/hype=
rv.h,
> which doesn't include any other Hyper-V headers.
>=20
> I'm not aware of how the DPDK project uses the Hyper-V definitions, but i=
f it
> is getting headers from uapi it should also be unaffected.

You are right.  My mistake. User space code based on uio_hv_generic.c
maps the VMBus ring buffers into user space, and I thought that code
was pulling "struct hv_ring_buffer" from include/linux/hyperv.h file. But
DPDK and the tools/hv code each have their own completely separate
header file with the equivalent of "struct hv_ring_buffer". Duplicating
the ring buffer structure in multiple places probably isn't ideal, but the
decoupling helps in this case. ;-)

>=20
> > I think there's also user space code that is built for vDSO that might =
pull
> > in the .h files you are modifying. There are in-progress patches dealin=
g
> > with vDSO include files, such as [1]. My general comment on vDSO
> > is to be careful in making #include file changes that it uses, but I'm
> > not knowledgeable enough on how vDSO is built to give specific
> > guidance. :-(
> >
> Hmm, interesting, looks like it does get used by userspace. The tsc page
> is mapped into userspace in vdso.vma.c, and read in vdso/gettimeofday.h.
>=20
> That is unexpected for me, since these things aren't in uapi. However I d=
on't
> anticipate a problem. The definitions used haven't changed, just the head=
ers
> they are included from.
>=20

Fair enough. I don't know enough about vDSO user space to add anything
helpful.

Michael

