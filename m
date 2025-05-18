Return-Path: <linux-arch+bounces-11988-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF74ABB1B1
	for <lists+linux-arch@lfdr.de>; Sun, 18 May 2025 23:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68E347A84DE
	for <lists+linux-arch@lfdr.de>; Sun, 18 May 2025 21:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45F81AAA1E;
	Sun, 18 May 2025 21:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="B992YE16"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2107.outbound.protection.outlook.com [40.92.43.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6C882866;
	Sun, 18 May 2025 21:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.43.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747603030; cv=fail; b=KzCCUopvUQ/8cU0JzFuCU8U3bIJEdyABVYX6IfZ+/IzOccGZe19SrjiTMs+b/hcDK09jC5yY8393aGBLaPB0FSlZX3l6suX+HMoU5X9F+1jGt+lbyGGLnbXMSKRhDBM7iRlwE558ZqSdICa9Z+TH9FCBmK85IWuJusu3M6K37Fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747603030; c=relaxed/simple;
	bh=q/+fjiMmFSy+F+GTH1ZqBpQbDRj4/eWRcJeEJ4gs2pU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mt9zjIlMlxRe2ONw7tMlPrWwOpNHlp+SnT/WlBp6Lqcx5GEzdW3YDZbUPhpDP38uGiR9Haoz+J0W91kjjd2/1i2u1xuWKx0YtbhF2ZF5+ed6/p3pOmSqq2s1Wlpup1tTXLYUB948tSmecTkaRChcUwqo3oBxVw3hA+xr7kXfqTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=B992YE16; arc=fail smtp.client-ip=40.92.43.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lN/y4UHrnKroPOHkPqXfmN5zjInGypTFv0OOPSe2aOklm7msbVpp/ugVjZNCqMI1Vm8EikEhPgriylVR3rNXJo8S04mlYTFP+ydyU50xLMLV3zM4jmPaOAbaokwYJdQ2Dw6bk+VNb25dvoptD73FR/dFCXp8P7bXHdcy2PzZH5l37oY7dk2ZP837OOuHoZNK4XvETO3NaNZc4mg5floZK4zHsmozra8d0M9kcqiwU68fQIGHxsgkAf9t52CpOdwSNQomf4z2DEQkBlqkGL3827FQE3Nh4S170p1aKH45Xo/iudM42Fu4jeulU8uW3kv3tk6NxYHBHGSgu9h7vExx9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=if0UlqAnFwoGFMFhHICfR+BoPKRxA6TAjUEj4V5NVUM=;
 b=fJnEvH5+qV5ryq4lOMXYP4asSMmu3dU4RpKvN5RM+jyhEWg9sQgLPOuM0WAF5ex+/kR5ihjtsqL5dCkeyFmjd1GtuofBdTPSc/hfNC7ZZbPd8TMGlZa/HYg0uXZQpaGSU9XYqzH5ECWcKqaxPfbjliE9mlmzErS6F9S5jjnGtoczcjdXPKEAXtZA+oTsfDYo+6nhpS3+wvJ5VFEmwuiuHqL9DcLfznwzkdTMiosS5nAw8JYi+JgPe0hHUoxLbPumE9TV0KgYjItdV/t7EbdiQdMdtErZi9csjFMwGCG2t3DC8rOAWZ3FeDFm7gI8l1UwX+C79LIOmWAF/e3f89gS4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=if0UlqAnFwoGFMFhHICfR+BoPKRxA6TAjUEj4V5NVUM=;
 b=B992YE16arOfCZkH+3+vH2suHj9wjSdEq1eu8E1fw4Tc7RKCHxMU1Ixyt+vgPfjy6zXqFAssi32thw9zmvRnGMWIGMkIzWLT/N0hzTSx1a59OGS62V3fTuP8juPry6WTGb+8bUaea34AYZ900aoKTH3M0nIg+T51QIlAFsQ6MeLAWY4uVsQMcdn40UuUjU/cHvT0lpnsNKdGZu0bx140ofXF6MZ+8d/FtrjU9y6UxMcvOJNQEBTPNIYQwUdiH9dDiiJqpECV3WMlLQ7tlrqn9MzJm7vY3+o9IiAA7e85L6Yebbc0o/bJSDDQyHeyJyk/cwyFsK7OQHjT4qTfygzyWg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM4PR02MB9189.namprd02.prod.outlook.com (2603:10b6:8:10b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.16; Sun, 18 May
 2025 21:17:01 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8722.027; Sun, 18 May 2025
 21:17:01 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"bp@alien8.de" <bp@alien8.de>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "will@kernel.org"
	<will@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v2 4/4] arch: x86, drivers: hyperv: Enable
 confidential VMBus
Thread-Topic: [PATCH hyperv-next v2 4/4] arch: x86, drivers: hyperv: Enable
 confidential VMBus
Thread-Index: AQHbwsm7rbUfKGBw/E2uD9uPeipeO7PVarkw
Date: Sun, 18 May 2025 21:17:01 +0000
Message-ID:
 <SN6PR02MB415728BC5E630CD478D074E2D49DA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250511230758.160674-1-romank@linux.microsoft.com>
 <20250511230758.160674-5-romank@linux.microsoft.com>
In-Reply-To: <20250511230758.160674-5-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM4PR02MB9189:EE_
x-ms-office365-filtering-correlation-id: f7bed2b5-794e-4ce7-f527-08dd96515494
x-ms-exchange-slblob-mailprops:
 AZnQBsB9XmoaApi1aWVt9ILKZbGoHsd6Kq4w3MxY6Sl6XBQazKUHBy0lL9EfUYKfMZs3VxLlvihAz6uESEHrl0K6YNyRwuCnlPPDmMP+hRgcy1lC3UsYuZrcgX2uALZumMqOyQ4OJ05BbUI2YF7TmRAMwU4IHfxqN2tsgjYVFglUao1AZ3ijAjFI7XDQewMoP7rfLCrIhG0FbrE0OYqmrzp0oSFiE/QInaYGzRz/oTd7WwkL30VT+M0xC8v2THw+TyhOYEQmDAnvxmj99cpDSFuamhk7NIhDgErLQ7Cq6kYlgP388iVUosnC96D/Q/35PUsu78Lj1p01zcsAAAt4JsXeDrI97s84p9cmg1OKFBMsM7HFTqg0SuHD2cQqFLjJ1kSx22SUrD0lw5uztoFhCECuHAQBVz8kZxyWB6FT+YZT388pT6cCKkvIjciugW8+J5pbB7qZeRHpdoMNtXfpwuJk7R24X/Sdv9csfeqidFPG6Ztb/A8vQJC+WC5+I5SQIxtCapRfVy/eHHmzt3XGx9uL4Hqd0kzjcgtWe33NmRR3Nu1j7NtHad3nZ/lR7RKKQQzCcPLK51ZfotsOfYDP5PrO1V99hd90DIEaA1YDt8yroFgI4Hnr41HD9bZrJZKtot5tBttscPglK4OOoAG6eL6pTvgeYjqLvOmRux/pnbWC1aCkCyCjSScmYc2LPHrZCpC2v37lm+VT9wehKBLUDi47SsycIfEkXVNiL9HWTeI6V2vy2IiGFB/E2MUmz5N3zxbtqCizvek=
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|461199028|19110799006|12121999007|8062599006|8060799009|15080799009|3412199025|440099028|12091999003|56899033|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0s128G+iR+FijLRKXb+2+gVP6wjMl/Lr9X293lIUdxIj/x6iOXR8DRuglnAo?=
 =?us-ascii?Q?nsf4dG9faLSF6INDxghY1qfHwdYBONGvXnF5U4/4AU23ouM7qWAvRAoTDFNl?=
 =?us-ascii?Q?VWPAJfoMADbFjqSRgCSyPemF5uBdIGrkHJMoBTSsJwkk9Z8kriUzK07/0H87?=
 =?us-ascii?Q?fVzMw5Ozk4C+iv1007zZ6S6WQMBkw7mrXbF6h7NTmRAQs/drRbosAYoCkD/3?=
 =?us-ascii?Q?zX0B0Ly/e0D1aEXU3jDKQMHH4fY+Jt1k3YpWX9PPvuWiYb8AW27mEJh+2Bur?=
 =?us-ascii?Q?CjD5pjojU5oDAAf3Mv+cbEXrVd/NvCS7bsnpazrXopFhANbb7BzZ99QBi7J+?=
 =?us-ascii?Q?XanHJr31qchkdf61I2TC4xQMvLPdxm7dUetNuFY4wKv66C6bwoPhT1f4M0/p?=
 =?us-ascii?Q?GZa3Mp0TnJqOD08eAZZ4l4iI+Cdmm1fEQnSj8P4dE1w4uCCYUTVyK34Tfs41?=
 =?us-ascii?Q?AokYrgv2Cot61iXR4QG5ldAvZ5Gc0E2AhrOdzXHS5evO1a1kUM1eA21CsXCw?=
 =?us-ascii?Q?bdcoQvcXyrGEog/iRIERLnruFfM60L+VjW+VGMVBAkMSHUG/s+LtWFbAOS2/?=
 =?us-ascii?Q?CWral9ybm9pTR/fEqOEZnQKoXcU/Mvr6Ij59GS9He0yMEj7R+AHXg9bgqksv?=
 =?us-ascii?Q?fk0VcY2S0Rdd4qyypffKuRTs4vVORUIGUAQecNFcCIvepvBxtwsp2ZFZVZ3d?=
 =?us-ascii?Q?9Tn2Xmq8nuiQqyDAcIgtfOtQde8J/xpccZCenQMVMj1CS6srPsiyfbk1W6fc?=
 =?us-ascii?Q?9tPt7fwjKPsLcNhosU7RSCb3s5SN1B5QegKJr5r96Z1P2UZAgDpAwynQcFQ5?=
 =?us-ascii?Q?da/xorqqWqNfjXlMRGMeO/IfFvjTNZwYPARxOrf81LLd5Ta3FZjaI9kvjQS9?=
 =?us-ascii?Q?K+h23HZFaR4hzQqnjsmTr/B1Qo2S+uNN+2s3zC//CtL9T/YI2W3oybJ7JTrT?=
 =?us-ascii?Q?ylP8d3Ql5oBtDvlcl31SqytFoEJ+yrUXP4Qs7N2JfsEaXp0+neFH2hdLqPK1?=
 =?us-ascii?Q?5zXG4k+ZB/Oq0oECEaUxu1xN2sScRgGdBbsFSe0cfukjBdvpTVItX1yPQHj+?=
 =?us-ascii?Q?651UQs2kSEN25CZ+WeAsBJXIj0dg5I2Y7Mk8yxGhTOR9sWTbIVQkmZQIvQ1t?=
 =?us-ascii?Q?AImKBiBYq98P3ALIE6oSo8iG7Om9J2/QXtgDBHNFkRZ5yuUlbupFwOo=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AftLbC+2mg8hfMnmbUHfbufZhgZg7/QksDMYMhzpA6kmvDbURCl5faYYqify?=
 =?us-ascii?Q?zKeEQdS4PT+r0yEC2/S+6VEBYrUgviPgiqpAvMw2Bx7Hnf85n5jKDIoGlInd?=
 =?us-ascii?Q?rKTF8Y571EypqUa2giX2AxTTZ6tLsNC1JXsH/jOVxrZI9R/0IOYP9Ux4K8rL?=
 =?us-ascii?Q?BRM0IXvP9Bh4GyOjuAzGiVBAZIjmvvONxp92YysD3Szw9PYakEin2E8aBi6O?=
 =?us-ascii?Q?NpwAUJfSUxj1XvNCSm5Jf5BHS+u/4XQOxcEbWL5VYOLF8NPY7MB8u9jXMM30?=
 =?us-ascii?Q?OSdD7dI2uPpeqhNMfMB+ALYW0b5O2KknPd9viMpsX6VfDHsDt8EJz7XB65c0?=
 =?us-ascii?Q?WrJMKtxbEp468sGy38r1RXcqlikG6RbLv4VJpZ7iPrwL4mT8poxtBebv15jm?=
 =?us-ascii?Q?rAVraUn2VAR8F0tZvqD9VenAm/hAimScb1QuSfDrLr4pVISuMAKJmwAv+CKV?=
 =?us-ascii?Q?ZqzI7UAEKu2ePjtCulsIufP0s6aq7rwfRJRclOqAARnuPAB+505wm+SGBQj+?=
 =?us-ascii?Q?MI1oZrjhz2hOUpVT+YNNMv+Jcl04K812NKvTBo/i4/c9F36WhrH0rYn5sX99?=
 =?us-ascii?Q?kvXRAmF+v06hWMjn66B2TZ6JNUdNws4AB9Bb8inSUrTFJPXhX+zKDi/B/vdx?=
 =?us-ascii?Q?50PEbLBWMbbFW1P/o/MOlRfI3Mf7VUW3Q0Nhg4mJ34Joy+XplN9RrZALHT2p?=
 =?us-ascii?Q?R2oAJ22mhThfOAy/LT6pZrNjNYWi1UTnZBoqSNEm0URZsHqgYlKZG2r7/Bqk?=
 =?us-ascii?Q?2awu0CC78OGEZHA0WKmws3QCW9Mzbrphrxk62RQlK3f0dtaOXp6MCuhSEoO8?=
 =?us-ascii?Q?ybmiD3miomdGmEamIIF1/CZW2h+lVcKN4aD8ddhvwddichTlpP9x81opanTd?=
 =?us-ascii?Q?Czi1Q8KKzDnoyaR38OkfUXMvMyHHsJlcghQLf/6bpYVulJf6Pq1I/WAZbUWO?=
 =?us-ascii?Q?s7cdaOuORNAzxjRL2jgNXSdAOqUlMpSLVubaOClF1BZAl50rMsfDwKBNlzL8?=
 =?us-ascii?Q?7DTqc7zo2SQZ6qBRbzGLPy0EkFXJ4wq1uhb8fO1uUXj1nJfTtHlNapSyeblr?=
 =?us-ascii?Q?cq+R19zCCwHD12Z60ha1MOCZKAlXOizJj/Ohhw4a0PL5mkvrFmfZVOgZK96H?=
 =?us-ascii?Q?Pg4U4B6A/NT/FA/6HDKfMq8/o6wGTP12xzZ4RbwscjPlcb/UDaFrpaeCNDoM?=
 =?us-ascii?Q?AIRdybMxul1fkutNiBNcjxqsVgGPYG7pweM7nAdCTCJq7y8OuMTegTz1oTg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f7bed2b5-794e-4ce7-f527-08dd96515494
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2025 21:17:01.1863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB9189

From: Roman Kisel <romank@linux.microsoft.com> Sent: Sunday, May 11, 2025 4=
:08 PM
>=20

For the Subject: line use prefix "Drivers: hv:" as that's where the changes
predominate.

> Confidential VMBus employs the paravisor SynIC pages to implement
> the control plane of the protocol, and the data plane may use
> encrypted pages.
>=20
> Implement scanning the additional pages in the control plane,
> and update the logic not to decrypt ring buffer and GPADLs (GPA
> descr. lists) unconditionally.

This patch is really big. The handling of the GPADL and ring buffer
decryption, and the associated booleans that are returned in the
VMBus offer, could be in a separate preparatory patch that comes
before the synic changes. As long as the booleans are always false,
such a preparatory patch would leave everything still functional
for normal VMs and CoCo VMs that don't have Confidential VMBus.

>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c |  23 +-
>  drivers/hv/channel.c           |  36 +--
>  drivers/hv/channel_mgmt.c      |  29 +-
>  drivers/hv/connection.c        |  10 +-
>  drivers/hv/hv.c                | 485 ++++++++++++++++++++++++---------
>  drivers/hv/hyperv_vmbus.h      |   9 +-
>  drivers/hv/ring_buffer.c       |   5 +-
>  drivers/hv/vmbus_drv.c         | 140 +++++-----
>  8 files changed, 518 insertions(+), 219 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 4f6e3d02f730..4163bc24269e 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -28,6 +28,7 @@
>  #include <asm/apic.h>
>  #include <asm/timer.h>
>  #include <asm/reboot.h>
> +#include <asm/msr.h>
>  #include <asm/nmi.h>
>  #include <clocksource/hyperv_timer.h>
>  #include <asm/numa.h>
> @@ -77,14 +78,28 @@ EXPORT_SYMBOL_GPL(hv_get_non_nested_msr);
>=20
>  void hv_set_non_nested_msr(unsigned int reg, u64 value)
>  {
> +	if (reg =3D=3D HV_X64_MSR_EOM && vmbus_is_confidential()) {
> +		/* Reach out to the paravisor. */
> +		native_wrmsrl(reg, value);
> +		return;
> +	}
> +
>  	if (hv_is_synic_msr(reg) && ms_hyperv.paravisor_present) {
> +		/* The hypervisor will get the intercept. */
>  		hv_ivm_msr_write(reg, value);
>=20
> -		/* Write proxy bit via wrmsl instruction */
> -		if (hv_is_sint_msr(reg))
> -			wrmsrl(reg, value | 1 << 20);
> +		if (hv_is_sint_msr(reg)) {
> +			/*
> +			 * Write proxy bit in the case of non-confidential VMBus control plan=
e.

See some later comments, but I'd suggest dropping the "control plane" conce=
pt and
just say "non-confidential VMBus".

> +			 * Using wrmsl instruction so the following goes to the paravisor.
> +			 */
> +			u32 proxy =3D 1 & !vmbus_is_confidential();
> +
> +			value |=3D (proxy << 20);
> +			native_wrmsrl(reg, value);
> +		}
>  	} else {
> -		wrmsrl(reg, value);
> +		native_wrmsrl(reg, value);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(hv_set_non_nested_msr);
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index fb8cd8469328..ef540b72f6ea 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -443,20 +443,23 @@ static int __vmbus_establish_gpadl(struct vmbus_cha=
nnel *channel,
>  		return ret;
>  	}
>=20
> -	/*
> -	 * Set the "decrypted" flag to true for the set_memory_decrypted()
> -	 * success case. In the failure case, the encryption state of the
> -	 * memory is unknown. Leave "decrypted" as true to ensure the
> -	 * memory will be leaked instead of going back on the free list.
> -	 */
> -	gpadl->decrypted =3D true;
> -	ret =3D set_memory_decrypted((unsigned long)kbuffer,
> -				   PFN_UP(size));
> -	if (ret) {
> -		dev_warn(&channel->device_obj->device,
> -			 "Failed to set host visibility for new GPADL %d.\n",
> -			 ret);
> -		return ret;
> +	if ((!channel->confidential_external_memory && type =3D=3D HV_GPADL_BUF=
FER) ||
> +		(!channel->confidential_ring_buffer && type =3D=3D HV_GPADL_RING)) {
> +		/*
> +		 * Set the "decrypted" flag to true for the set_memory_decrypted()
> +		 * success case. In the failure case, the encryption state of the
> +		 * memory is unknown. Leave "decrypted" as true to ensure the
> +		 * memory will be leaked instead of going back on the free list.
> +		 */
> +		gpadl->decrypted =3D true;
> +		ret =3D set_memory_decrypted((unsigned long)kbuffer,
> +					PFN_UP(size));
> +		if (ret) {
> +			dev_warn(&channel->device_obj->device,
> +				"Failed to set host visibility for new GPADL %d.\n",
> +				ret);
> +			return ret;
> +		}

Some problems here. First, gpadl->decrypted is left uninitialized if
set_memory_decrypted() is skipped because we have confidential external
memory or ring buffer.  Second, at the end of this function, if there's an
error (i.e., ret !=3D 0), set_memory_encrypted() is called even if the memo=
ry
was never decrypted. In a CoCo VM, we must not call set_memory_encrypted()
on memory that is already encrypted. Third, vmbus_teardown_gpadl() has
the same problem -- it assumes that __vmbus_establish_gpadl() always
decrypts the memory, so it always calls set_memory_encrypted().

>  	}
>=20
>  	init_completion(&msginfo->waitevent);
> @@ -676,12 +679,13 @@ static int __vmbus_open(struct vmbus_channel *newch=
annel,
>  		goto error_clean_ring;
>=20
>  	err =3D hv_ringbuffer_init(&newchannel->outbound,
> -				 page, send_pages, 0);
> +				 page, send_pages, 0, newchannel->confidential_ring_buffer);
>  	if (err)
>  		goto error_free_gpadl;
>=20
>  	err =3D hv_ringbuffer_init(&newchannel->inbound, &page[send_pages],
> -				 recv_pages, newchannel->max_pkt_size);
> +				 recv_pages, newchannel->max_pkt_size,
> +				 newchannel->confidential_ring_buffer);
>  	if (err)
>  		goto error_free_gpadl;
>=20
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 6e084c207414..39c8b80d967f 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -843,14 +843,14 @@ static void vmbus_wait_for_unload(void)
>  				=3D per_cpu_ptr(hv_context.cpu_context, cpu);
>=20
>  			/*
> -			 * In a CoCo VM the synic_message_page is not allocated
> +			 * In a CoCo VM the hv_synic_message_page is not allocated
>  			 * in hv_synic_alloc(). Instead it is set/cleared in
>  			 * hv_synic_enable_regs() and hv_synic_disable_regs()
>  			 * such that it is set only when the CPU is online. If
>  			 * not all present CPUs are online, the message page
>  			 * might be NULL, so skip such CPUs.
>  			 */
> -			page_addr =3D hv_cpu->synic_message_page;
> +			page_addr =3D hv_cpu->hv_synic_message_page;
>  			if (!page_addr)
>  				continue;
>=20
> @@ -891,7 +891,7 @@ static void vmbus_wait_for_unload(void)
>  		struct hv_per_cpu_context *hv_cpu
>  			=3D per_cpu_ptr(hv_context.cpu_context, cpu);
>=20
> -		page_addr =3D hv_cpu->synic_message_page;
> +		page_addr =3D hv_cpu->hv_synic_message_page;
>  		if (!page_addr)
>  			continue;
>=20
> @@ -1021,6 +1021,7 @@ static void vmbus_onoffer(struct vmbus_channel_mess=
age_header *hdr)
>  	struct vmbus_channel_offer_channel *offer;
>  	struct vmbus_channel *oldchannel, *newchannel;
>  	size_t offer_sz;
> +	bool confidential_ring_buffer, confidential_external_memory;
>=20
>  	offer =3D (struct vmbus_channel_offer_channel *)hdr;
>=20
> @@ -1033,6 +1034,18 @@ static void vmbus_onoffer(struct vmbus_channel_mes=
sage_header *hdr)
>  		return;
>  	}
>=20
> +	confidential_ring_buffer =3D is_confidential_ring_buffer(offer);
> +	if (confidential_ring_buffer) {
> +		if (vmbus_proto_version < VERSION_WIN_COPPER || !vmbus_is_confidential=
())
> +			return;

Like the earlier code in this function that tests vmbus_is_valid_offer(), y=
ou must
decrement vmbus_connection.offer_in_progress before the failure case return=
s.
Otherwise, a rescind operation could hang forever waiting for all offers to=
 complete.

> +	}
> +
> +	confidential_external_memory =3D is_confidential_external_memory(offer)=
;
> +	if (is_confidential_external_memory(offer)) {
> +		if (vmbus_proto_version < VERSION_WIN_COPPER || !vmbus_is_confidential=
())
> +			return;

Same here.

> +	}
> +
>  	oldchannel =3D find_primary_channel_by_offer(offer);
>=20
>  	if (oldchannel !=3D NULL) {
> @@ -1069,6 +1082,14 @@ static void vmbus_onoffer(struct vmbus_channel_mes=
sage_header *hdr)
>=20
>  		atomic_dec(&vmbus_connection.offer_in_progress);
>=20
> +		if ((oldchannel->confidential_ring_buffer && !confidential_ring_buffer=
) ||
> +				(oldchannel->confidential_external_memory &&
> +				!confidential_external_memory)) {
> +			pr_err_ratelimited("Offer %d changes the confidential state\n",
> +				offer->child_relid);

Not sure why this needs to be ratelimited.  Typically there are only a coup=
le dozen offers
at most.  Also, I don't think hibernation in a CoCo VM is supported in the =
first place, so
maybe we should never be here if vmbus_is_confidential().

> +			return;

Must release the channel mutex before returning in this error case.

> +		}
> +
>  		WARN_ON(oldchannel->offermsg.child_relid !=3D INVALID_RELID);
>  		/* Fix up the relid. */
>  		oldchannel->offermsg.child_relid =3D offer->child_relid;
> @@ -1111,6 +1132,8 @@ static void vmbus_onoffer(struct vmbus_channel_mess=
age_header *hdr)
>  		pr_err("Unable to allocate channel object\n");
>  		return;
>  	}
> +	newchannel->confidential_ring_buffer =3D confidential_ring_buffer;
> +	newchannel->confidential_external_memory =3D confidential_external_memo=
ry;
>=20
>  	vmbus_setup_channel_state(newchannel, offer);
>=20
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 8351360bba16..268b7d58b45b 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -51,7 +51,8 @@ EXPORT_SYMBOL_GPL(vmbus_proto_version);
>   * Linux guests and are not listed.
>   */
>  static __u32 vmbus_versions[] =3D {
> -	VERSION_WIN10_V5_3,
> +	VERSION_WIN_COPPER,
> +	VERSION_WIN_IRON,
>  	VERSION_WIN10_V5_2,
>  	VERSION_WIN10_V5_1,
>  	VERSION_WIN10_V5,
> @@ -65,7 +66,7 @@ static __u32 vmbus_versions[] =3D {
>   * Maximal VMBus protocol version guests can negotiate.  Useful to cap t=
he
>   * VMBus version for testing and debugging purpose.
>   */
> -static uint max_version =3D VERSION_WIN10_V5_3;
> +static uint max_version =3D VERSION_WIN_COPPER;
>=20
>  module_param(max_version, uint, S_IRUGO);
>  MODULE_PARM_DESC(max_version,
> @@ -105,6 +106,11 @@ int vmbus_negotiate_version(struct vmbus_channel_msg=
info *msginfo, u32 version)
>  		vmbus_connection.msg_conn_id =3D VMBUS_MESSAGE_CONNECTION_ID;
>  	}
>=20
> +	if (vmbus_is_confidential() && version >=3D VERSION_WIN_COPPER)
> +		msg->feature_flags =3D VMBUS_FEATURE_FLAG_CONFIDENTIAL_CHANNELS;
> +	else
> +		msg->feature_flags =3D 0;
> +

msg has already been zero'ed, so the above "else" clause isn't needed.

>  	/*
>  	 * shared_gpa_boundary is zero in non-SNP VMs, so it's safe to always
>  	 * bitwise OR it
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 308c8f279df8..94be5b3f9e70 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -74,7 +74,7 @@ int hv_post_message(union hv_connection_id connection_i=
d,
>  	aligned_msg->payload_size =3D payload_size;
>  	memcpy((void *)aligned_msg->payload, payload, payload_size);
>=20
> -	if (ms_hyperv.paravisor_present) {
> +	if (ms_hyperv.paravisor_present && !vmbus_is_confidential()) {
>  		if (hv_isolation_type_tdx())
>  			status =3D hv_tdx_hypercall(HVCALL_POST_MESSAGE,
>  						  virt_to_phys(aligned_msg), 0);
> @@ -94,11 +94,135 @@ int hv_post_message(union hv_connection_id connectio=
n_id,
>  	return hv_result(status);
>  }
>=20
> +enum hv_page_encryption_action {
> +	HV_PAGE_ENC_DEAFULT,
> +	HV_PAGE_ENC_ENCRYPT,
> +	HV_PAGE_ENC_DECRYPT
> +};
> +
> +static int hv_alloc_page(unsigned int cpu, void **page, enum hv_page_enc=
ryption_action enc_action,
> +	const char *note)
> +{
> +	int ret =3D 0;
> +
> +	pr_debug("allocating %s\n", note);
> +
> +	/*
> +	 * After the page changes its encryption status, its contents will
> +	 * appear scrambled. Thus `get_zeroed_page` would zero the page out
> +	 * in vain, we do that ourselves exactly one time.

FWIW, the statement about "scrambled" is true for SEV-SNP, but it's
not true for TDX.  TDX leaves the page all zero'ed. And it seems like I
remember something about perhaps a future version of SEV-SNP
would similarly do the zero'ing, but I don't know any details. But in
any case, doing the zero'ing explicitly is the correct approach, at
least for the moment. It's just the comment that isn't precisely
correct.

> +	 *
> +	 * The function might be called from contexts where sleeping is very
> +	 * bad (like hotplug callbacks) or not possible (interrupt handling),
> +	 * Thus requesting `GFP_ATOMIC`.

It looks to me like the existing code's use of GFP_ATOMIC is bogus.
hv_synic_alloc() is only called from vmbus_bus_init(), and there are
no restrictions there on sleeping.  set_memory_decrypted() could
sleep because it gets a mutex lock in the mm code. I'd delete this
comment and use GFP_KERNEL. There's already an allocation
a few lines up in hv_synic_alloc() that uses GFP_KERNEL.

> +	 *
> +	 * The page order is 0 as we need 1 page and log_2 (1) =3D 0.
> +	 */
> +	*page =3D (void *)__get_free_pages(GFP_ATOMIC, 0);

Just use __get_free_page() [singular] and you can avoid the discussion
of where the "0" second argument comes from.

> +	if (!*page)
> +		return -ENOMEM;
> +
> +	pr_debug("allocated %s\n", note);
> +
> +	switch (enc_action) {
> +	case HV_PAGE_ENC_ENCRYPT:
> +		ret =3D set_memory_encrypted((unsigned long)*page, 1);
> +		break;
> +	case HV_PAGE_ENC_DECRYPT:
> +		ret =3D set_memory_decrypted((unsigned long)*page, 1);
> +		break;
> +	case HV_PAGE_ENC_DEAFULT:
> +		break;
> +	default:
> +		pr_warn("unknown page encryption action %d for %s\n", enc_action, note=
);
> +		break;
> +	}

This seems a bit over-engineered to me. There are no cases where this
function is called with HV_PAGE_ENC_ENCRYPT, and I can't see that ever
being useful in the future. Conceptually, it's wrong to be encrypting a
newly allocated page. That leaves HV_PAGE_ENC_DECRYPT and
HV_PAGE_ENC_DEFAULT, which can more straightforwardly be handled
as a boolean parameter specifying whether to decrypt the page. The 13
lines of switch statement then become just:

	if (decrypt)
		ret =3D set_memory_decrypted((unsigned long)*page, 1);

And enum hv_page_encryption_action is no longer needed.

> +
> +	if (ret)
> +		goto failed;
> +
> +	memset(*page, 0, PAGE_SIZE);
> +	return 0;
> +
> +failed:
> +
> +	pr_err("page encryption action %d failed for %s, error %d when allocati=
ng the page\n",
> +		enc_action, note, ret);
> +	free_page((unsigned long)*page);
> +	*page =3D NULL;
> +	return ret;
> +}
> +
> +static int hv_free_page(void **page, enum hv_page_encryption_action enc_=
action,
> +	const char *note)
> +{
> +	int ret =3D 0;
> +
> +	pr_debug("freeing %s\n", note);
> +
> +	if (!page)
> +		return 0;

This test seems unnecessary for a static function that can only be
called within this module, where it's easy to ensure that a valid
pointer is always passed.

> +	if (!*page)
> +		return 0;
> +
> +	switch (enc_action) {
> +	case HV_PAGE_ENC_ENCRYPT:
> +		ret =3D set_memory_encrypted((unsigned long)*page, 1);
> +		break;
> +	case HV_PAGE_ENC_DECRYPT:
> +		ret =3D set_memory_decrypted((unsigned long)*page, 1);
> +		break;
> +	case HV_PAGE_ENC_DEAFULT:
> +		break;
> +	default:
> +		pr_warn("unknown page encryption action %d for %s page\n",
> +			enc_action, note);
> +		break;
> +	}

Same here about using a boolean parameter to specify whether to encrypt.
There will never be a case where you want to decrypt before free'ing.

> +
> +	/*
> +	 * In the case of the action failure, the page is leaked.
> +	 * Something is wrong, prefer to lose the page and stay afloat.
> +	 */
> +	if (ret) {
> +		pr_err("page encryption action %d failed for %s, error %d when freeing=
\n",
> +			enc_action, note, ret);
> +	} else {
> +		pr_debug("freed %s\n", note);
> +		free_page((unsigned long)*page);
> +	}
> +
> +	*page =3D NULL;
> +
> +	return ret;
> +}
> +
> +static bool hv_should_allocate_post_msg_page(void)
> +{
> +	return ms_hyperv.paravisor_present && hv_isolation_type_tdx();
> +}
> +
> +static bool hv_should_allocate_synic_pages(void)
> +{
> +	return !ms_hyperv.paravisor_present && !hv_root_partition();
> +}

For the above two, rather than creating these helper functions, what
about creating a boolean in struct hv_context for each of these? Then
hv_synic_alloc() and hv_synic_free() can directly reference the boolean
instead of having to declare local variables that are initialized from the
above functions. The new booleans in hv_context would be set in
ms_hyperv_init_platform(), and they don't change during the life
of the VM. To me, this approach would eliminate some code overhead
that doesn't really add any value.

> +
> +static bool hv_should_allocate_pv_synic_pages(void)
> +{
> +	return vmbus_is_confidential();
> +}

This one *might* have some value if the criteria for creating
the paravisor synic pages could change in the future. But I'd
recommend taking the simpler way for now, and just directly
call vmbus_is_confidential() in hv_synic_alloc() and hv_synic_free().
Don't even bother with creating a local variable to contain the
result since it is only used once in each function.

> +
>  int hv_synic_alloc(void)
>  {
>  	int cpu, ret =3D -ENOMEM;
>  	struct hv_per_cpu_context *hv_cpu;
>=20
> +	const bool allocate_post_msg_page =3D hv_should_allocate_post_msg_page(=
);
> +	const bool allocate_synic_pages =3D hv_should_allocate_synic_pages();
> +	const bool allocate_pv_synic_pages =3D hv_should_allocate_pv_synic_page=
s();
> +	const enum hv_page_encryption_action enc_action =3D
> +		(!vmbus_is_confidential()) ? HV_PAGE_ENC_DECRYPT : HV_PAGE_ENC_DEAFULT=
;
> +
>  	/*
>  	 * First, zero all per-cpu memory areas so hv_synic_free() can
>  	 * detect what memory has been allocated and cleanup properly
> @@ -122,74 +246,38 @@ int hv_synic_alloc(void)
>  		tasklet_init(&hv_cpu->msg_dpc,
>  			     vmbus_on_msg_dpc, (unsigned long)hv_cpu);
>=20
> -		if (ms_hyperv.paravisor_present && hv_isolation_type_tdx()) {
> -			hv_cpu->post_msg_page =3D (void *)get_zeroed_page(GFP_ATOMIC);
> -			if (!hv_cpu->post_msg_page) {
> -				pr_err("Unable to allocate post msg page\n");
> +		if (allocate_post_msg_page) {
> +			ret =3D hv_alloc_page(cpu, &hv_cpu->post_msg_page,
> +				enc_action, "post msg page");
> +			if (ret)
>  				goto err;
> -			}
> -
> -			ret =3D set_memory_decrypted((unsigned long)hv_cpu->post_msg_page, 1)=
;
> -			if (ret) {
> -				pr_err("Failed to decrypt post msg page: %d\n", ret);
> -				/* Just leak the page, as it's unsafe to free the page. */
> -				hv_cpu->post_msg_page =3D NULL;
> -				goto err;
> -			}
> -
> -			memset(hv_cpu->post_msg_page, 0, PAGE_SIZE);
>  		}
>=20
>  		/*
> -		 * Synic message and event pages are allocated by paravisor.
> -		 * Skip these pages allocation here.
> +		 * If these SynIC pages are not allocated, SIEF and SIM pages
> +		 * are configured using what the root partition or the paravisor
> +		 * provides upon reading the SIEFP and SIMP registers.
>  		 */
> -		if (!ms_hyperv.paravisor_present && !hv_root_partition()) {
> -			hv_cpu->synic_message_page =3D
> -				(void *)get_zeroed_page(GFP_ATOMIC);
> -			if (!hv_cpu->synic_message_page) {
> -				pr_err("Unable to allocate SYNIC message page\n");
> +		if (allocate_synic_pages) {
> +			ret =3D hv_alloc_page(cpu, &hv_cpu->hv_synic_message_page,
> +				enc_action, "SynIC msg page");
> +			if (ret)
>  				goto err;
> -			}
> -
> -			hv_cpu->synic_event_page =3D
> -				(void *)get_zeroed_page(GFP_ATOMIC);
> -			if (!hv_cpu->synic_event_page) {
> -				pr_err("Unable to allocate SYNIC event page\n");
> -
> -				free_page((unsigned long)hv_cpu->synic_message_page);
> -				hv_cpu->synic_message_page =3D NULL;
> +			ret =3D hv_alloc_page(cpu, &hv_cpu->hv_synic_event_page,
> +				enc_action, "SynIC event page");
> +			if (ret)
>  				goto err;
> -			}
>  		}
>=20
> -		if (!ms_hyperv.paravisor_present &&
> -		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
> -			ret =3D set_memory_decrypted((unsigned long)
> -				hv_cpu->synic_message_page, 1);
> -			if (ret) {
> -				pr_err("Failed to decrypt SYNIC msg page: %d\n", ret);
> -				hv_cpu->synic_message_page =3D NULL;
> -
> -				/*
> -				 * Free the event page here so that hv_synic_free()
> -				 * won't later try to re-encrypt it.
> -				 */
> -				free_page((unsigned long)hv_cpu->synic_event_page);
> -				hv_cpu->synic_event_page =3D NULL;
> +		if (allocate_pv_synic_pages) {
> +			ret =3D hv_alloc_page(cpu, &hv_cpu->pv_synic_message_page,
> +				HV_PAGE_ENC_DEAFULT, "pv SynIC msg page");
> +			if (ret)
>  				goto err;
> -			}
> -
> -			ret =3D set_memory_decrypted((unsigned long)
> -				hv_cpu->synic_event_page, 1);
> -			if (ret) {
> -				pr_err("Failed to decrypt SYNIC event page: %d\n", ret);
> -				hv_cpu->synic_event_page =3D NULL;
> +			ret =3D hv_alloc_page(cpu, &hv_cpu->pv_synic_event_page,
> +				HV_PAGE_ENC_DEAFULT, "pv SynIC event page");
> +			if (ret)
>  				goto err;
> -			}
> -
> -			memset(hv_cpu->synic_message_page, 0, PAGE_SIZE);
> -			memset(hv_cpu->synic_event_page, 0, PAGE_SIZE);
>  		}
>  	}
>=20
> @@ -205,55 +293,38 @@ int hv_synic_alloc(void)
>=20
>  void hv_synic_free(void)
>  {
> -	int cpu, ret;
> +	int cpu;
> +
> +	const bool free_post_msg_page =3D hv_should_allocate_post_msg_page();
> +	const bool free_synic_pages =3D hv_should_allocate_synic_pages();
> +	const bool free_pv_synic_pages =3D hv_should_allocate_pv_synic_pages();
>=20
>  	for_each_present_cpu(cpu) {
>  		struct hv_per_cpu_context *hv_cpu =3D
>  			per_cpu_ptr(hv_context.cpu_context, cpu);
>=20
> -		/* It's better to leak the page if the encryption fails. */
> -		if (ms_hyperv.paravisor_present && hv_isolation_type_tdx()) {
> -			if (hv_cpu->post_msg_page) {
> -				ret =3D set_memory_encrypted((unsigned long)
> -					hv_cpu->post_msg_page, 1);
> -				if (ret) {
> -					pr_err("Failed to encrypt post msg page: %d\n", ret);
> -					hv_cpu->post_msg_page =3D NULL;
> -				}
> -			}
> +		if (free_post_msg_page)
> +			hv_free_page(&hv_cpu->post_msg_page,
> +				HV_PAGE_ENC_ENCRYPT, "post msg page");
> +		if (free_synic_pages) {
> +			hv_free_page(&hv_cpu->hv_synic_event_page,
> +				HV_PAGE_ENC_ENCRYPT, "SynIC event page");
> +			hv_free_page(&hv_cpu->hv_synic_message_page,
> +				HV_PAGE_ENC_ENCRYPT, "SynIC msg page");

Always re-encrypting the page is wrong. If VMBus is confidential, the pages
will have remained encrypted in hv_synic_alloc().  Trying to encrypt them
again will produce errors.

>  		}
> -
> -		if (!ms_hyperv.paravisor_present &&
> -		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
> -			if (hv_cpu->synic_message_page) {
> -				ret =3D set_memory_encrypted((unsigned long)
> -					hv_cpu->synic_message_page, 1);
> -				if (ret) {
> -					pr_err("Failed to encrypt SYNIC msg page: %d\n", ret);
> -					hv_cpu->synic_message_page =3D NULL;
> -				}
> -			}
> -
> -			if (hv_cpu->synic_event_page) {
> -				ret =3D set_memory_encrypted((unsigned long)
> -					hv_cpu->synic_event_page, 1);
> -				if (ret) {
> -					pr_err("Failed to encrypt SYNIC event page: %d\n", ret);
> -					hv_cpu->synic_event_page =3D NULL;
> -				}
> -			}
> +		if (free_pv_synic_pages) {
> +			hv_free_page(&hv_cpu->pv_synic_event_page,
> +				HV_PAGE_ENC_DEAFULT, "pv SynIC event page");
> +			hv_free_page(&hv_cpu->pv_synic_message_page,
> +				HV_PAGE_ENC_DEAFULT, "pv SynIC msg page");
>  		}
> -
> -		free_page((unsigned long)hv_cpu->post_msg_page);
> -		free_page((unsigned long)hv_cpu->synic_event_page);
> -		free_page((unsigned long)hv_cpu->synic_message_page);
>  	}
>=20
>  	kfree(hv_context.hv_numa_map);
>  }
>=20
>  /*
> - * hv_synic_init - Initialize the Synthetic Interrupt Controller.
> + * hv_synic_enable_regs - Initialize the Synthetic Interrupt Controller.
>   *
>   * If it is already initialized by another entity (ie x2v shim), we need=
 to
>   * retrieve the initialized message and event pages.  Otherwise, we crea=
te and

This comment about the x2v shim is ancient and long since incorrect. It's
in the existing code, but should be removed.

> @@ -266,7 +337,6 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	union hv_synic_simp simp;
>  	union hv_synic_siefp siefp;
>  	union hv_synic_sint shared_sint;
> -	union hv_synic_scontrol sctrl;
>=20
>  	/* Setup the Synic's message page */
>  	simp.as_uint64 =3D hv_get_msr(HV_MSR_SIMP);
> @@ -276,18 +346,18 @@ void hv_synic_enable_regs(unsigned int cpu)
>  		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
>  		u64 base =3D (simp.base_simp_gpa << HV_HYP_PAGE_SHIFT) &
>  				~ms_hyperv.shared_gpa_boundary;
> -		hv_cpu->synic_message_page =3D
> -			(void *)ioremap_cache(base, HV_HYP_PAGE_SIZE);
> -		if (!hv_cpu->synic_message_page)
> +		hv_cpu->hv_synic_message_page

Renaming "synic_message_page" to "hv_synic_message_page" (along with
the renaming of synic_event_page) could be a separate preparatory patch.
Together I see about 40 references that need to be changed. Doing them
in a separate patch is less clutter in the patch with the main synic change=
s.

I also have a quibble with naming it hv_synic_message_page. The "hv"
prefix means "Hyper-V", and think what you are mean here is the
hypervisor as opposed to the paravisor. What about naming it with
prefix "hyp", and use "pvr" for the paravisor version as I suggested
in a comment on an earlier patch in this series?

> +			=3D (void *)ioremap_cache(base, HV_HYP_PAGE_SIZE);

Why move the equals sign to the next line?

> +		if (!hv_cpu->hv_synic_message_page)
>  			pr_err("Fail to map synic message page.\n");
>  	} else {
> -		simp.base_simp_gpa =3D virt_to_phys(hv_cpu->synic_message_page)
> +		simp.base_simp_gpa =3D virt_to_phys(hv_cpu->hv_synic_message_page)
>  			>> HV_HYP_PAGE_SHIFT;
>  	}
>=20
>  	hv_set_msr(HV_MSR_SIMP, simp.as_uint64);
>=20
> -	/* Setup the Synic's event page */
> +	/* Setup the Synic's event page with the hypervisor. */
>  	siefp.as_uint64 =3D hv_get_msr(HV_MSR_SIEFP);
>  	siefp.siefp_enabled =3D 1;
>=20
> @@ -295,12 +365,12 @@ void hv_synic_enable_regs(unsigned int cpu)
>  		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
>  		u64 base =3D (siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT) &
>  				~ms_hyperv.shared_gpa_boundary;
> -		hv_cpu->synic_event_page =3D
> -			(void *)ioremap_cache(base, HV_HYP_PAGE_SIZE);
> -		if (!hv_cpu->synic_event_page)
> +		hv_cpu->hv_synic_event_page
> +			=3D (void *)ioremap_cache(base, HV_HYP_PAGE_SIZE);

Why move the equals sign to the next line?

> +		if (!hv_cpu->hv_synic_event_page)
>  			pr_err("Fail to map synic event page.\n");
>  	} else {
> -		siefp.base_siefp_gpa =3D virt_to_phys(hv_cpu->synic_event_page)
> +		siefp.base_siefp_gpa =3D virt_to_phys(hv_cpu->hv_synic_event_page)
>  			>> HV_HYP_PAGE_SHIFT;
>  	}
>=20
> @@ -313,8 +383,24 @@ void hv_synic_enable_regs(unsigned int cpu)
>=20
>  	shared_sint.vector =3D vmbus_interrupt;
>  	shared_sint.masked =3D false;
> -	shared_sint.auto_eoi =3D hv_recommend_using_aeoi();
> -	hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
> +
> +	/*
> +	 * On architectures where Hyper-V doesn't support AEOI (e.g., ARM64),
> +	 * it doesn't provide a recommendation flag and AEOI must be disabled.
> +	 */
> +#ifdef HV_DEPRECATING_AEOI_RECOMMENDED
> +	shared_sint.auto_eoi =3D
> +			!(ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED);
> +#else
> +	shared_sint.auto_eoi =3D 0;
> +#endif

Why not use the helper function hv_recommend_using_aeoi()? I think it
was added relatively recently, so maybe your code started out before it exi=
sted.

> +	hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT,
> +				shared_sint.as_uint64);

Why is the above statement now on two lines?  In fact, it looks like this e=
ntire
little section of changes is spurious.

> +}
> +
> +static void hv_synic_enable_interrupts(void)
> +{
> +	union hv_synic_scontrol sctrl;
>=20
>  	/* Enable the global synic bit */
>  	sctrl.as_uint64 =3D hv_get_msr(HV_MSR_SCONTROL);
> @@ -323,13 +409,78 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	hv_set_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
>  }
>=20
> +/*
> + * The paravisor might not support proxying SynIC, and this
> + * function may fail.
> + */
> +static int hv_pv_synic_enable_regs(unsigned int cpu)
> +{
> +	union hv_synic_simp simp;
> +	union hv_synic_siefp siefp;
> +

This blank line seems spurious. Don't usually see blank lines
in local variable declaration lists.

> +	int err;
> +	struct hv_per_cpu_context *hv_cpu
> +		=3D per_cpu_ptr(hv_context.cpu_context, cpu);
> +
> +	/* Setup the Synic's message page with the paravisor. */
> +	simp.as_uint64 =3D hv_pv_get_synic_register(HV_MSR_SIMP, &err);
> +	if (err)
> +		return err;
> +	simp.simp_enabled =3D 1;
> +	simp.base_simp_gpa =3D virt_to_phys(hv_cpu->pv_synic_message_page)
> +			>> HV_HYP_PAGE_SHIFT;
> +	err =3D hv_pv_set_synic_register(HV_MSR_SIMP, simp.as_uint64);
> +	if (err)
> +		return err;
> +
> +	/* Setup the Synic's event page with the paravisor. */
> +	siefp.as_uint64 =3D hv_pv_get_synic_register(HV_MSR_SIEFP, &err);
> +	if (err)

If setting up the simp succeeds, but then accessing the siefp fails,
does the simp need to be cleared? I don't know the implications
of abandoning a partial setup.

> +		return err;
> +	siefp.siefp_enabled =3D 1;
> +	siefp.base_siefp_gpa =3D virt_to_phys(hv_cpu->pv_synic_event_page)
> +			>> HV_HYP_PAGE_SHIFT;
> +	return hv_pv_set_synic_register(HV_MSR_SIEFP, siefp.as_uint64);

Same question here about a failure, and abandoning a partial setup.

> +}
> +
> +static int hv_pv_synic_enable_interrupts(void)
> +{
> +	union hv_synic_scontrol sctrl;
> +	int err;
> +
> +	/* Enable the global synic bit */
> +	sctrl.as_uint64 =3D hv_pv_get_synic_register(HV_MSR_SCONTROL, &err);
> +	if (err)
> +		return err;
> +	sctrl.enable =3D 1;
> +
> +	return hv_pv_set_synic_register(HV_MSR_SCONTROL, sctrl.as_uint64);
> +}
> +
>  int hv_synic_init(unsigned int cpu)
>  {
> +	int err =3D 0;
> +
> +	/*
> +	 * The paravisor may not support the confidential VMBus,
> +	 * check on that first.
> +	 */
> +	if (vmbus_is_confidential())
> +		err =3D hv_pv_synic_enable_regs(cpu);
> +	if (err)
> +		return err;

I would expect to see the test for "err" to be under the test
for vmbus_is_confidential().

> +
>  	hv_synic_enable_regs(cpu);
> +	if (!vmbus_is_confidential())
> +		hv_synic_enable_interrupts();
> +	else
> +		err =3D hv_pv_synic_enable_interrupts();

Flip the order of the "if" and "else" clauses so the negation on
vmbus_is_confidential() can be removed?  It's one less piece
of logic to cognitively process when reading the code ....

I'm still trying to figure out how things work with confidential
VMBus since there are two synics to deal with. When there
are two, it appears from this code that the guest takes interrupts
only from the paravisor synic?

> +	if (err)
> +		return err;

Again, group the test for "err" with the call to
hv_pv_synic_enable_interrupts().=20

>=20
>  	hv_stimer_legacy_init(cpu, VMBUS_MESSAGE_SINT);
>=20
> -	return 0;
> +	return err;

In existing code, hv_synic_init() doesn't fail. Given the new failure
modes, should an error message be output so that a failure is
noted? And does anything need to be undone if enable_regs()
succeeds but enable_interrupts() fails?

>  }
>=20
>  void hv_synic_disable_regs(unsigned int cpu)
> @@ -339,7 +490,6 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	union hv_synic_sint shared_sint;
>  	union hv_synic_simp simp;
>  	union hv_synic_siefp siefp;
> -	union hv_synic_scontrol sctrl;
>=20
>  	shared_sint.as_uint64 =3D hv_get_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT)=
;
>=20
> @@ -358,8 +508,8 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	 */
>  	simp.simp_enabled =3D 0;
>  	if (ms_hyperv.paravisor_present || hv_root_partition()) {
> -		iounmap(hv_cpu->synic_message_page);
> -		hv_cpu->synic_message_page =3D NULL;
> +		memunmap(hv_cpu->hv_synic_message_page);
> +		hv_cpu->hv_synic_message_page =3D NULL;
>  	} else {
>  		simp.base_simp_gpa =3D 0;
>  	}
> @@ -370,43 +520,97 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	siefp.siefp_enabled =3D 0;
>=20
>  	if (ms_hyperv.paravisor_present || hv_root_partition()) {
> -		iounmap(hv_cpu->synic_event_page);
> -		hv_cpu->synic_event_page =3D NULL;
> +		memunmap(hv_cpu->hv_synic_event_page);
> +		hv_cpu->hv_synic_event_page =3D NULL;
>  	} else {
>  		siefp.base_siefp_gpa =3D 0;
>  	}
>=20
>  	hv_set_msr(HV_MSR_SIEFP, siefp.as_uint64);
> +}
> +
> +static void hv_synic_disable_interrupts(void)
> +{
> +	union hv_synic_scontrol sctrl;
>=20
>  	/* Disable the global synic bit */
>  	sctrl.as_uint64 =3D hv_get_msr(HV_MSR_SCONTROL);
>  	sctrl.enable =3D 0;
>  	hv_set_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
> +}
>=20
> +static void hv_vmbus_disable_percpu_interrupts(void)
> +{
>  	if (vmbus_irq !=3D -1)
>  		disable_percpu_irq(vmbus_irq);
>  }

Is this separate function needed?  It's two lines of code
that are only called in one place.

>=20
> +static void hv_pv_synic_disable_regs(unsigned int cpu)
> +{
> +	/*
> +	 * The get/set register errors are deliberatley ignored in
> +	 * the cleanup path as they are non-consequential here.
> +	 */

I don't understand this comment. Errors are checked for, and
the function exits, just like in hv_pv_synic_enable_regs(). Of
course, the caller never finds out about the errors.

> +	int err;
> +	union hv_synic_simp simp;
> +	union hv_synic_siefp siefp;
> +
> +	struct hv_per_cpu_context *hv_cpu
> +		=3D per_cpu_ptr(hv_context.cpu_context, cpu);

For the hypervisor synic, hv_synic_disable_regs() masks the
VMBUS_MESSAGE_SINT before changing the simp and siefp.
Doesn't the same need to be done for the paravisor synic?

> +
> +	/* Disable SynIC's message page in the paravisor. */
> +	simp.as_uint64 =3D hv_pv_get_synic_register(HV_MSR_SIMP, &err);
> +	if (err)
> +		return;
> +	simp.simp_enabled =3D 0;
> +
> +	memunmap(hv_cpu->pv_synic_message_page);
> +	hv_cpu->pv_synic_message_page =3D NULL;

This code seems bogus. The pv_synic_mesage_page was allocated, not
memmap()'ed. And setting it to NULL here prevents deallocation in
hv_synic_free().

> +
> +	err =3D hv_pv_set_synic_register(HV_MSR_SIMP, simp.as_uint64);
> +	if (err)
> +		return;
> +
> +	/* Disable SynIC's event page in the paravisor. */
> +	siefp.as_uint64 =3D hv_pv_get_synic_register(HV_MSR_SIEFP, &err);
> +	if (err)
> +		return;
> +	siefp.siefp_enabled =3D 0;
> +
> +	memunmap(hv_cpu->pv_synic_event_page);
> +	hv_cpu->pv_synic_event_page =3D NULL;

Same bogus code for the pv_synic_event_page?

> +
> +	hv_pv_set_synic_register(HV_MSR_SIEFP, siefp.as_uint64);
> +}
> +
> +static void hv_pv_synic_disable_interrupts(void)
> +{
> +	union hv_synic_scontrol sctrl;
> +	int err;
> +
> +	/* Disable the global synic bit */
> +	sctrl.as_uint64 =3D hv_pv_get_synic_register(HV_MSR_SCONTROL, &err);
> +	if (err)
> +		return;
> +	sctrl.enable =3D 0;
> +	hv_pv_set_synic_register(HV_MSR_SCONTROL, sctrl.as_uint64);
> +}
> +
>  #define HV_MAX_TRIES 3
> -/*
> - * Scan the event flags page of 'this' CPU looking for any bit that is s=
et.  If we find one
> - * bit set, then wait for a few milliseconds.  Repeat these steps for a =
maximum of 3 times.
> - * Return 'true', if there is still any set bit after this operation; 'f=
alse', otherwise.
> - *
> - * If a bit is set, that means there is a pending channel interrupt.  Th=
e expectation is
> - * that the normal interrupt handling mechanism will find and process th=
e channel interrupt
> - * "very soon", and in the process clear the bit.
> - */
> -static bool hv_synic_event_pending(void)
> +
> +static bool hv_synic_event_pending_for(union hv_synic_event_flags *event=
, int sint)

The usual naming pattern for an internal implementation version of a functi=
on
is to prepend a double-underscore; i.e., __hv_synic_event_pending().

>  {
> -	struct hv_per_cpu_context *hv_cpu =3D this_cpu_ptr(hv_context.cpu_conte=
xt);
> -	union hv_synic_event_flags *event =3D
> -		(union hv_synic_event_flags *)hv_cpu->synic_event_page + VMBUS_MESSAGE=
_SINT;
> -	unsigned long *recv_int_page =3D event->flags; /* assumes VMBus version=
 >=3D VERSION_WIN8 */
> +	unsigned long *recv_int_page;
>  	bool pending;
>  	u32 relid;
> -	int tries =3D 0;
> +	int tries;
> +
> +	if (!event)
> +		return false;
>=20
> +	tries =3D 0;

Any reason this can't be done when "tries" is declared, like the existing c=
ode?
Seems like an unnecessary change.

> +	event +=3D sint;
> +	recv_int_page =3D event->flags; /* assumes VMBus version >=3D VERSION_W=
IN8 */
>  retry:
>  	pending =3D false;
>  	for_each_set_bit(relid, recv_int_page, HV_EVENT_FLAGS_COUNT) {
> @@ -460,6 +664,26 @@ static int hv_pick_new_cpu(struct vmbus_channel *cha=
nnel)
>  /*
>   * hv_synic_cleanup - Cleanup routine for hv_synic_init().
>   */

Any reason to place this function *after* hv_pick_new_cpu()? Seems like an
unnecessarily change in the order of the two functions. And anyway, this on=
e
would be better directly following __hv_synic_event_pending().

> +/*
> + * Scan the event flags page of 'this' CPU looking for any bit that is s=
et.  If we find one
> + * bit set, then wait for a few milliseconds.  Repeat these steps for a =
maximum of 3 times.
> + * Return 'true', if there is still any set bit after this operation; 'f=
alse', otherwise.
> + *
> + * If a bit is set, that means there is a pending channel interrupt.  Th=
e expectation is
> + * that the normal interrupt handling mechanism will find and process th=
e channel interrupt
> + * "very soon", and in the process clear the bit.
> + */
> +static bool hv_synic_event_pending(void)
> +{
> +	struct hv_per_cpu_context *hv_cpu =3D this_cpu_ptr(hv_context.cpu_conte=
xt);
> +	union hv_synic_event_flags *hv_synic_event_page =3D hv_cpu->hv_synic_ev=
ent_page;
> +	union hv_synic_event_flags *pv_synic_event_page =3D hv_cpu->pv_synic_ev=
ent_page;
> +
> +	return
> +		hv_synic_event_pending_for(hv_synic_event_page, VMBUS_MESSAGE_SINT) ||
> +		hv_synic_event_pending_for(pv_synic_event_page, VMBUS_MESSAGE_SINT);
> +}
> +
>  int hv_synic_cleanup(unsigned int cpu)
>  {
>  	struct vmbus_channel *channel, *sc;
> @@ -516,6 +740,13 @@ int hv_synic_cleanup(unsigned int cpu)
>  	hv_stimer_legacy_cleanup(cpu);
>=20
>  	hv_synic_disable_regs(cpu);
> +	if (vmbus_is_confidential())
> +		hv_pv_synic_disable_regs(cpu);
> +	if (!vmbus_is_confidential())
> +		hv_synic_disable_interrupts();
> +	else
> +		hv_pv_synic_disable_interrupts();

How about this so there's only one test of
vmbus_is_confidential():

	If (vmbus_is_confidential()) {
		hv_pv_synic_disable_regs(cpu);
		hv_pv_synic_disable_interrupts();
	} else {
		hv_synic_disable_interrupts();
	}

> +	hv_vmbus_disable_percpu_interrupts();
>=20
>  	return ret;
>  }
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 29780f3a7478..9337e0afa3ce 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -120,8 +120,10 @@ enum {
>   * Per cpu state for channel handling
>   */
>  struct hv_per_cpu_context {
> -	void *synic_message_page;
> -	void *synic_event_page;
> +	void *hv_synic_message_page;
> +	void *hv_synic_event_page;

See comment above about doing this renaming in a separate patch.
Also, I don't think you tried compiling with CONFIG_MSHV_ROOT, as
the old names are referenced in the mshv root code and they haven't
been fixed up in this patch.

> +	void *pv_synic_message_page;
> +	void *pv_synic_event_page;
>=20
>  	/*
>  	 * The page is only used in hv_post_message() for a TDX VM (with the
> @@ -182,7 +184,8 @@ extern int hv_synic_cleanup(unsigned int cpu);
>  void hv_ringbuffer_pre_init(struct vmbus_channel *channel);
>=20
>  int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
> -		       struct page *pages, u32 pagecnt, u32 max_pkt_size);
> +		       struct page *pages, u32 pagecnt, u32 max_pkt_size,
> +			   bool confidential);
>=20
>  void hv_ringbuffer_cleanup(struct hv_ring_buffer_info *ring_info);
>=20
> diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
> index 3c9b02471760..05c2cd42fc75 100644
> --- a/drivers/hv/ring_buffer.c
> +++ b/drivers/hv/ring_buffer.c
> @@ -183,7 +183,8 @@ void hv_ringbuffer_pre_init(struct vmbus_channel *cha=
nnel)
>=20
>  /* Initialize the ring buffer. */
>  int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
> -		       struct page *pages, u32 page_cnt, u32 max_pkt_size)
> +		       struct page *pages, u32 page_cnt, u32 max_pkt_size,
> +			   bool confidential)
>  {
>  	struct page **pages_wraparound;
>  	int i;
> @@ -207,7 +208,7 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ri=
ng_info,
>=20
>  	ring_info->ring_buffer =3D (struct hv_ring_buffer *)
>  		vmap(pages_wraparound, page_cnt * 2 - 1, VM_MAP,
> -			pgprot_decrypted(PAGE_KERNEL));
> +			confidential ? PAGE_KERNEL : pgprot_decrypted(PAGE_KERNEL));
>=20
>  	kfree(pages_wraparound);
>  	if (!ring_info->ring_buffer)
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index e431978fa408..375b4e45c762 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1034,12 +1034,9 @@ static void vmbus_onmessage_work(struct work_struc=
t
> *work)
>  	kfree(ctx);
>  }
>=20
> -void vmbus_on_msg_dpc(unsigned long data)
> +static void vmbus_on_msg_dpc_for(void *message_page_addr)

Per earlier comment, name this __vmbus_on_msg_dpc().

>  {
> -	struct hv_per_cpu_context *hv_cpu =3D (void *)data;
> -	void *page_addr =3D hv_cpu->synic_message_page;
> -	struct hv_message msg_copy, *msg =3D (struct hv_message *)page_addr +
> -				  VMBUS_MESSAGE_SINT;
> +	struct hv_message msg_copy, *msg;
>  	struct vmbus_channel_message_header *hdr;
>  	enum vmbus_channel_message_type msgtype;
>  	const struct vmbus_channel_message_table_entry *entry;
> @@ -1047,6 +1044,10 @@ void vmbus_on_msg_dpc(unsigned long data)
>  	__u8 payload_size;
>  	u32 message_type;
>=20
> +	if (!message_page_addr)
> +		return;
> +	msg =3D (struct hv_message *)message_page_addr + VMBUS_MESSAGE_SINT;
> +
>  	/*
>  	 * 'enum vmbus_channel_message_type' is supposed to always be 'u32' as
>  	 * it is being used in 'struct vmbus_channel_message_header' definition
> @@ -1172,6 +1173,14 @@ void vmbus_on_msg_dpc(unsigned long data)
>  	vmbus_signal_eom(msg, message_type);
>  }
>=20
> +void vmbus_on_msg_dpc(unsigned long data)
> +{
> +	struct hv_per_cpu_context *hv_cpu =3D (void *)data;
> +
> +	vmbus_on_msg_dpc_for(hv_cpu->hv_synic_message_page);
> +	vmbus_on_msg_dpc_for(hv_cpu->pv_synic_message_page);
> +}
> +
>  #ifdef CONFIG_PM_SLEEP
>  /*
>   * Fake RESCIND_CHANNEL messages to clean up hv_sock channels by force f=
or
> @@ -1210,21 +1219,19 @@ static void vmbus_force_channel_rescinded(struct =
vmbus_channel *channel)
>  #endif /* CONFIG_PM_SLEEP */
>=20
>  /*
> - * Schedule all channels with events pending
> + * Schedule all channels with events pending.
> + * The event page can be directly checked to get the id of
> + * the channel that has the interrupt pending.
>   */
> -static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
> +static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu, void *ev=
ent_page_addr)
>  {
>  	unsigned long *recv_int_page;
>  	u32 maxbits, relid;
> +	union hv_synic_event_flags *event;
>=20
> -	/*
> -	 * The event page can be directly checked to get the id of
> -	 * the channel that has the interrupt pending.
> -	 */
> -	void *page_addr =3D hv_cpu->synic_event_page;
> -	union hv_synic_event_flags *event
> -		=3D (union hv_synic_event_flags *)page_addr +
> -					 VMBUS_MESSAGE_SINT;
> +	if (!event_page_addr)
> +		return;
> +	event =3D (union hv_synic_event_flags *)event_page_addr + VMBUS_MESSAGE=
_SINT;
>=20
>  	maxbits =3D HV_EVENT_FLAGS_COUNT;
>  	recv_int_page =3D event->flags;
> @@ -1295,26 +1302,35 @@ static void vmbus_chan_sched(struct hv_per_cpu_co=
ntext *hv_cpu)
>  	}
>  }
>=20
> -static void vmbus_isr(void)
> +static void vmbus_message_sched(struct hv_per_cpu_context *hv_cpu, void =
*message_page_addr)
>  {
> -	struct hv_per_cpu_context *hv_cpu
> -		=3D this_cpu_ptr(hv_context.cpu_context);
> -	void *page_addr;
>  	struct hv_message *msg;
>=20
> -	vmbus_chan_sched(hv_cpu);
> -
> -	page_addr =3D hv_cpu->synic_message_page;
> -	msg =3D (struct hv_message *)page_addr + VMBUS_MESSAGE_SINT;
> +	if (!message_page_addr)
> +		return;
> +	msg =3D (struct hv_message *)message_page_addr + VMBUS_MESSAGE_SINT;
>=20
>  	/* Check if there are actual msgs to be processed */
>  	if (msg->header.message_type !=3D HVMSG_NONE) {
>  		if (msg->header.message_type =3D=3D HVMSG_TIMER_EXPIRED) {
>  			hv_stimer0_isr();
>  			vmbus_signal_eom(msg, HVMSG_TIMER_EXPIRED);
> -		} else
> +		} else {
>  			tasklet_schedule(&hv_cpu->msg_dpc);
> +		}
>  	}
> +}
> +
> +static void vmbus_isr(void)
> +{
> +	struct hv_per_cpu_context *hv_cpu
> +		=3D this_cpu_ptr(hv_context.cpu_context);
> +
> +	vmbus_chan_sched(hv_cpu, hv_cpu->hv_synic_event_page);
> +	vmbus_chan_sched(hv_cpu, hv_cpu->pv_synic_event_page);

vmbus_chan_sched() scans the full hv_synic_event_flags bit array
looking for bits that are set. That's 2048 bits, or 256 bytes, to scan. If
Confidential VMBus is active, that scan must be done twice, touching
different 256 byte memory ranges that will be ping'ing around in
different CPU's caches. That could be a noticeable perf hit to interrupt
handling.

One possible optimization would be to keep track of the largest
relID that's in use, and only scan up to that relID. In most VMs, this
would significantly cut down the range of the scan, and would be
beneficial even in VMs where Confidential VMBus isn't active. At this
point I'm just noting the issue -- doing the optimization could be a
separate follow-on patch.

> +
> +	vmbus_message_sched(hv_cpu, hv_cpu->hv_synic_message_page);
> +	vmbus_message_sched(hv_cpu, hv_cpu->pv_synic_message_page);
>=20
>  	add_interrupt_randomness(vmbus_interrupt);
>  }
> @@ -1325,11 +1341,35 @@ static irqreturn_t vmbus_percpu_isr(int irq, void=
 *dev_id)
>  	return IRQ_HANDLED;
>  }
>=20
> -static void vmbus_percpu_work(struct work_struct *work)
> +static int vmbus_setup_control_plane(void)

The concept of "control plane" doesn't appear anywhere in the existing
VMBus code. Perhaps rename to use existing concepts:

vmbus_alloc_synic_and_connect()

>  {
> -	unsigned int cpu =3D smp_processor_id();
> +	int ret;
> +	int hyperv_cpuhp_online;
> +
> +	ret =3D hv_synic_alloc();
> +	if (ret < 0)
> +		goto err_alloc;
>=20
> -	hv_synic_init(cpu);
> +	/*
> +	 * Initialize the per-cpu interrupt state and stimer state.
> +	 * Then connect to the host.
> +	 */
> +	ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hyperv/vmbus:online",
> +				hv_synic_init, hv_synic_cleanup);
> +	if (ret < 0)
> +		goto err_alloc;
> +	hyperv_cpuhp_online =3D ret;
> +	ret =3D vmbus_connect();
> +	if (ret)
> +		goto err_connect;
> +	return 0;
> +
> +err_connect:
> +	cpuhp_remove_state(hyperv_cpuhp_online);
> +	return -ENODEV;
> +err_alloc:
> +	hv_synic_free();
> +	return -ENOMEM;
>  }
>=20
>  /*
> @@ -1342,8 +1382,7 @@ static void vmbus_percpu_work(struct work_struct *w=
ork)
>   */
>  static int vmbus_bus_init(void)
>  {
> -	int ret, cpu;
> -	struct work_struct __percpu *works;
> +	int ret;
>=20
>  	ret =3D hv_init();
>  	if (ret !=3D 0) {
> @@ -1378,41 +1417,21 @@ static int vmbus_bus_init(void)
>  		}
>  	}
>=20
> -	ret =3D hv_synic_alloc();
> -	if (ret)
> -		goto err_alloc;
> -
> -	works =3D alloc_percpu(struct work_struct);
> -	if (!works) {
> -		ret =3D -ENOMEM;
> -		goto err_alloc;
> -	}
> -
>  	/*
> -	 * Initialize the per-cpu interrupt state and stimer state.
> -	 * Then connect to the host.
> +	 * Attempt to establish the confidential control plane first if this VM=
 is
> +	.* a hardware confidential VM, and the paravisor is present.

Spurious "." before the "*"

>  	 */
> -	cpus_read_lock();
> -	for_each_online_cpu(cpu) {
> -		struct work_struct *work =3D per_cpu_ptr(works, cpu);
> +	ret =3D -ENODEV;
> +	if (ms_hyperv.paravisor_present && (hv_isolation_type_tdx() || hv_isola=
tion_type_snp())) {
> +		is_confidential =3D true;
> +		ret =3D vmbus_setup_control_plane();
> +		is_confidential =3D ret =3D=3D 0;

Or perhaps better,
		is_confidential =3D !ret;

>=20
> -		INIT_WORK(work, vmbus_percpu_work);
> -		schedule_work_on(cpu, work);

This recently added code to do hv_synic_init() in parallel on
all CPUs has been lost. See commit 87c9741a38c4.

> +		pr_info("VMBus control plane is confidential: %d\n", is_confidential);

Just say "VMBus is confidential" and omit the concept of control plane.

>  	}
>=20
> -	for_each_online_cpu(cpu)
> -		flush_work(per_cpu_ptr(works, cpu));
> -
> -	/* Register the callbacks for possible CPU online/offline'ing */
> -	ret =3D cpuhp_setup_state_nocalls_cpuslocked(CPUHP_AP_ONLINE_DYN, "hype=
rv/vmbus:online",
> -						   hv_synic_init, hv_synic_cleanup);
> -	cpus_read_unlock();
> -	free_percpu(works);
> -	if (ret < 0)
> -		goto err_alloc;
> -	hyperv_cpuhp_online =3D ret;
> -
> -	ret =3D vmbus_connect();
> +	if (!is_confidential)
> +		ret =3D vmbus_setup_control_plane();
>  	if (ret)
>  		goto err_connect;
>=20
> @@ -1428,9 +1447,6 @@ static int vmbus_bus_init(void)
>  	return 0;
>=20
>  err_connect:
> -	cpuhp_remove_state(hyperv_cpuhp_online);
> -err_alloc:
> -	hv_synic_free();
>  	if (vmbus_irq =3D=3D -1) {
>  		hv_remove_vmbus_handler();
>  	} else {
> --
> 2.43.0
>=20


