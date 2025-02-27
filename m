Return-Path: <linux-arch+bounces-10416-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D81CA471DF
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 02:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2775A1886F64
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 01:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E326C73477;
	Thu, 27 Feb 2025 01:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NxkerBvB"
X-Original-To: linux-arch@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012061.outbound.protection.outlook.com [52.103.2.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF500433C8;
	Thu, 27 Feb 2025 01:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740621051; cv=fail; b=q3LYoivCA8EbFm85df0UwAsl3zVBWnSsqZm9mo9xO9G42I22Cfitjp6uFgdgKWDeX4V+kYTH+JXX440JkI5DKGatZdqoRhkcvJN0nDsL/TN3K8sqgtroOdsV81gtBNEzw/O6RB825qqKMo8byP6ZU+szrvvhpQU7QX+Rk/VgfE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740621051; c=relaxed/simple;
	bh=GKb971rP5+mWir8DnUUcRVyMufyenD9Wyorb/FYELAY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i0bV/Fx3nw+umdDpP8KhEFHGlLekpOFO/x8Wd6AcySeaCwMA6zNvlOCWggNIRE9iz+go8vHsotSrj+AQiaZd1jZxiiBOnFXZbr8DPSfUB6LEHLG2mhPmR6HR/TWw4h63qb1t4Wwn4L/AybTXCIUj+sJ0sHiotSOPqk+qiCzkNKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NxkerBvB; arc=fail smtp.client-ip=52.103.2.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AsXvg4/lhGt6/f/2EwJv1VfOl3X/bjsXZmfMMZ0/wgJGE65klWOc1OVp1jJESyqdO0R1tXjDkmUPqIgna353jkaLGw7TRts/CeHabJ4HwS9jCehRYfD30OX/coZOkrdINdX8odMA7YaYoVoHJ2GHUUwCpZJJWb/BCJapuCPmIDwTYsO1B0yA0dti0PZeEmW4znbb0SjWBmxsgjtpvEDSktg3G3E2yq420D/JWV8IxJF1bfeh+O7HkRvhMduSEP28+lxyY9isJgaQUQCHnPqI1XMitLIn1GrcCLGt5IwkMHU61G7IQu45gLG96JKmJp6a7oWS5+Y4rVOTMAkkiFg2rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjXL8ar/6VhGRlbKl5oXL5BvM9u+o7LUZ7nIS0i/j8M=;
 b=UIOUIUzDN1rTRObx1Gwrd1PVz9JxOWd1R4LEQPJySm+9MjJ64eiFEm+xglloBJjwvVPtiEmgPMq6c6CIYRWaJuGB4Be3p6enO+5eUsELW4slXFm62x4GOz49EPoT8J8DEL58LquN6qOThT2ahywi8W4Wum4Cbm9HGPTvkeD16LxvqNuXl/8IsY7o8ku3zfnglLmCXCo/2lH6c/+myqNaBxQ5bmdMvCWzNyuPDahh3UEbsjJ0mMMbKlM8Y8w9TdPQTg8CqSKgKbs+y7HTtpkxE762WsusXRVDvdkBU01PAowWJpfSEdqP/zbDf5OWtkmqZXA7nGV+EyxpNCs+qGFUow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjXL8ar/6VhGRlbKl5oXL5BvM9u+o7LUZ7nIS0i/j8M=;
 b=NxkerBvBCHNLxnVucjslA78k/bUVgUNndWeQW7inFUSPzHSYJczAmhait1GhxNtogXRwC4jFcCT50v8a1mN7jP1op9UWSVh5H5VCVDOfICNfwsfw8YhTwdquY6cFx8fa3O9K252aiy6KRNCgtqM0QbFEUrXWskXWAp8vc7KC5Y/0pBdukFd17KpbTZxVP9PSOUYQiCzxfOOCI/WpD0nrDTqhmRvJHl6/b3DUu7Mn8cOCCzUFDioLFKWqehmrgmsJeu9GV4t+1DAZpFgh+x413KWCPFtId7kEqREI0Dm5yM9x8p5HI32gpkzTOSRwzEWwtr/P+/fVWilLXn91ycPI2Q==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO1PR02MB8443.namprd02.prod.outlook.com (2603:10b6:303:156::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 01:50:46 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8466.020; Thu, 27 Feb 2025
 01:50:46 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "arnd@arndb.de" <arnd@arndb.de>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
Subject: RE: [PATCH 2/7] Drivers: hv: Introduce hv_hvcall_*() functions for
 hypercall arguments
Thread-Topic: [PATCH 2/7] Drivers: hv: Introduce hv_hvcall_*() functions for
 hypercall arguments
Thread-Index: AQHbiIo0xSzZdo16g0qSKE4efT1BOrNaSC+AgAAVQnA=
Date: Thu, 27 Feb 2025 01:50:43 +0000
Message-ID:
 <SN6PR02MB4157FF9AF372F252C6D8B0A1D4CD2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250226200612.2062-1-mhklinux@outlook.com>
 <20250226200612.2062-3-mhklinux@outlook.com>
 <45a1b6b5-407c-4518-9ea2-05341e93a67e@linux.microsoft.com>
In-Reply-To: <45a1b6b5-407c-4518-9ea2-05341e93a67e@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO1PR02MB8443:EE_
x-ms-office365-filtering-correlation-id: d838b958-ad03-4aaf-0f38-08dd56d125de
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|8062599003|19110799003|15080799006|461199028|3412199025|440099028|10035399004|41001999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?MUCE1Ku2VJ4xM8CgdxhjOL6PIBHupK7rdmlA7JMaqFH1vzHFI2Ff5Pxh5TkW?=
 =?us-ascii?Q?9dGenLFPok4W97sM8wrcPm0qTa55JddqCclTIAtPPxuWWZi1Zg9rWf7SRxmp?=
 =?us-ascii?Q?PaM+Nl9MDEdDN2oZMR1n/1Ft4+VwRjffVUBIFMeeSzqxag6m/quPSsE55gGH?=
 =?us-ascii?Q?nfhBJp8b+fJfxmVUCtAUQDbi0onjMow2SAISmWR5fq51nZ0LOSMkXHhx89w6?=
 =?us-ascii?Q?EgcqfgZ+h7PLCwah30pGq9D7c4khjR+goFO4T9WKU1amvCEpRsh8wx9cMo/h?=
 =?us-ascii?Q?Tki9gn8+k3SJGRtOI4u2sXFFABJw7IdlDH8tISxhX3hNRu8nbzkY2wtxOI/M?=
 =?us-ascii?Q?zAyq2kSJkiU1j83KtAY8FXSCsMekbpVHwIFG6pib8L3c0wiSHOFf+X1mlT3Z?=
 =?us-ascii?Q?CiV4SetNyyPb9bZbdFaNx2+F5hJWSBExUBWsVFbxBa5DgsPH0QrMjYuRm9Mw?=
 =?us-ascii?Q?ILFnWmGu4MJGvVer+Saovu3G893CIxUf7SeTe5smMqt6YCvCtpOvVNzBJp6n?=
 =?us-ascii?Q?XNes+B4JjzUofhHn6v+K1p6F4fcF/uwnwo9cpoIFhzUFn2zmc1QCkuJdOmCl?=
 =?us-ascii?Q?NfBj3IvXK60Wex2+mpmaXebP7sN4UYSTkNY7cSjOvaV/Zv9YNVhZ+owJGthz?=
 =?us-ascii?Q?4UAFJ+ymduSW62rk0naiDqCEqvsdcObwE50fuEs3lSMb3Sn+WUtBcCBeVxP6?=
 =?us-ascii?Q?/+BapCCYVfWTDGKvPaE8OTuNAEA0DUrlWx7lfurrneaUNsQ/HMhz8hhPV1qG?=
 =?us-ascii?Q?UyfPscqRIQ7TX/xFWle859Qvw3aE3s9cq/2MeWunnT5Ms6jEf501eUmpy6dG?=
 =?us-ascii?Q?kmijalP6Wd5em+8//sMsRoqO22zxD6VLyPEyxJH2BzrFJtgRpsd10gjCHVyT?=
 =?us-ascii?Q?y3x7uhg0idy+4UElkXDqzzM6NfL1J1d2Htxh7VOTb5rGLzxjSD1/BdlE49SW?=
 =?us-ascii?Q?zK/5uwcJ07hvfj++VA/fWfzB1yqkmifZfgXNpLrK4F86YTkEamS49UxnZKki?=
 =?us-ascii?Q?e9T493XBcl5yud3Hx43n97e5jY3Y/u4xtghugtmO1vcVeLxSJdZVIN1ATkhy?=
 =?us-ascii?Q?w9c8xUA4MNcXWdyc4zT1fS/7LfCFHHb9YYZMkMOq74mbohLeLMjMxHYrILKX?=
 =?us-ascii?Q?unDhiOPq1zx/w6KMW8movwp7ChPSq5tK1oA4TDzmqU6nZKJs7BqOJBO7cJ0/?=
 =?us-ascii?Q?adA2ww+dSEk697gc?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Zo7Y7eYWSZp4w16i1eYAQLOy2BgP3F2JC9E2OhFEJVvnrQAvDb93OVE58b52?=
 =?us-ascii?Q?ZpNFK+q+2jdSwHo9RcvCBAFhoWLc9d8RiyLfk2Wc9I+VBQO26YTG6j/90n4D?=
 =?us-ascii?Q?T10w6oS+h0wi8lsk1w12HsWbJKBLzeKp132RmYPV16CYJamsu7Yfy87aIPfT?=
 =?us-ascii?Q?Moan1W9lTF6u4YFVeNbSaoYmIuPaFMmnpNOk7zjCzj5npFaO/qjUxv+vYZcP?=
 =?us-ascii?Q?zHR2JzZ/Ru0W4yDtkWAModXmWat7pf6eHbEAjt3so8WhgwNqfSn1W8Q9khzO?=
 =?us-ascii?Q?CwuTM2JCu0Xkks6Na61AWhnNho6cVU2hZtneFTgZn8F9ZbaHBOtibI3jdYZK?=
 =?us-ascii?Q?y3ffRrpmEm1lxwZNWKFJU1HLKhnbYiAXDvYxRK3s6cP999WvZhkoApqztMbf?=
 =?us-ascii?Q?BteHc01wBtJo6yHOYHuetkBPTIPreliPpi6wOuTo3Vd38ghZByn9WBJohzwF?=
 =?us-ascii?Q?6e9wz3D4ugMuLREpcjthSm/KnWRD4LliqKYKsDeLy7q+n7xNEwHUbID+oRz1?=
 =?us-ascii?Q?TakQsVqNIBi7jP4luLNrrWHShrH1M4YSjDbl3gSiELClbIB6oG2QDFSw2bJ3?=
 =?us-ascii?Q?/zyNJvOy6EUylY3mddNtSdL/RCKv3Hh+HwUG/Idvr+KPaghnwA1mHdNESGe2?=
 =?us-ascii?Q?Mf1N9O1HM0EY6lkYzCME+Ia/fjV4xLonWD1OrYmp7Pya1ChBMaMalKgglzXx?=
 =?us-ascii?Q?Jp8arWU9ZM7br7retuM+bOzd7pUc8GYAt0l8ksliDa8SbbXTGdfQc1ZJjPCQ?=
 =?us-ascii?Q?VIiH3L6swdSongLdUHhOtLuWqA2hAFQrLX+Nv7kVUZ3Dcna6TAUX51gN7xg9?=
 =?us-ascii?Q?opgmzy41viPx6DtUNT7JDgPLaYwOFmaa1c6mAGxMUzpDlaX5V2x83jCq3tHp?=
 =?us-ascii?Q?vbizopymUypKjWYlyUbRX8p5THmR09MDLQPbn+Bop0q8Z8qW1ErpKwdb/vJI?=
 =?us-ascii?Q?hDm7ysl6KVFT/1qjSt+IYRBmhzp35Uw2pOP6w6q4E9AI5cpbdObyjFqtjY2Q?=
 =?us-ascii?Q?n8xb7qRFssF24c80ARiYpZa50hk9+pY6GIzaQaai/1A6sgRk1+iMg2Ka7IuC?=
 =?us-ascii?Q?2F3r5CnBxyaK2lRekZZjdXekqy0KjZB4xkdZ/fJ2F5Dqj3VPes8D5OJ8U3xm?=
 =?us-ascii?Q?WQoSDxqTLiiZLJnrVNjfNodOk6dNSA4HDtD9zBoq0rpeC00OUSE8sGoXYNbY?=
 =?us-ascii?Q?OGySKsW+ivHD/Mv58eCBF9xTTeU2Cv+YWjz2sGFMJNICWMKcxf+yv3/dVxA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d838b958-ad03-4aaf-0f38-08dd56d125de
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 01:50:43.9897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8443

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, Fe=
bruary 26, 2025 4:15 PM
>=20
> On 2/26/2025 12:06 PM, mhkelley58@gmail.com wrote:
> > From: Michael Kelley <mhklinux@outlook.com>
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
> > calculate and return how many array entries fit within the per-cpu
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
> > for some arguments. Several of the arguments to this new function are
> > expected to be compile-time constants generated by "sizeof()"
> > expressions. As such, most of the code in the new function can be
> > evaluated by the compiler, with the result that the code paths are
> > no longer than with the current open coding. The one exception is
> > new code generated to zero the fixed-size portion of the input area
> > in cases where it is not currently done.
> >
> > [1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows=
/tlfs/tlfs
> >
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > ---
> >  include/asm-generic/mshyperv.h | 102 +++++++++++++++++++++++++++++++++
> >  1 file changed, 102 insertions(+)
> >
> > diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyp=
erv.h
> > index b13b0cda4ac8..0c8a9133cf1a 100644
> > --- a/include/asm-generic/mshyperv.h
> > +++ b/include/asm-generic/mshyperv.h
> > @@ -135,6 +135,108 @@ static inline u64 hv_do_rep_hypercall(u16 code, u=
16 rep_count, u16 varhead_size,
> >  	return status;
> >  }
> >
> > +/*
> > + * Hypercall input and output argument setup
> > + */
> > +
> > +/* Temporary mapping to be removed at the end of the patch series */
> > +#define hyperv_pcpu_arg hyperv_pcpu_input_arg
> > +
> > +/*
> > + * Allocate one page that is shared between input and output args, whi=
ch is
> > + * sufficient for all current hypercalls. If a future hypercall requir=
es
> > + * more space, change this value to "2" and everything will work.
> > + */
> > +#define HV_HVCALL_ARG_PAGES 1
> > +
> > +/*
> > + * Allocate space for hypercall input and output arguments from the
> > + * pre-allocated per-cpu hyperv_pcpu_args page(s). A NULL value for th=
e input
> > + * or output indicates to allocate no space for that argument. For inp=
ut and
> > + * for output, specify the size of the fixed portion, and the size of =
an
> > + * element in a variable size array. A zero value for entry_size indic=
ates
> > + * there is no array. The fixed size space for the input is zero'ed.
> > + *
> It might be worth explicitly mentioning that interrupts should be disable=
d when
> calling this function.

Agreed.

>=20
> > + * When variable size arrays are present, the function returns the num=
ber of
> > + * elements (i.e, the batch size) that fit in the available space.
> > + *
> > + * The four "size" arguments are expected to be constants, in which ca=
se the
> > + * compiler does most of the calculations. Then the generated inline c=
ode is no
> > + * larger than if open coding the access to the hyperv_pcpu_arg and do=
ing
> > + * memset() on the input.
> > + */
> > +static inline int hv_hvcall_inout_array(
> > +			void *input, u32 in_size, u32 in_entry_size,
> > +			void *output, u32 out_size, u32 out_entry_size)
> Is there a reason input and output are void * instead of void ** here?

Yes -- it must be void *, and not void **.  Consider a function like get_vt=
l()
in Patch 3 of this series where local variable "input" is declared as:

struct hv_input_get_vp_registers *input;

Then the first argument to hv_hvcall_inout() will be of type
struct hv_input_get_vp_registers **. The compiler does not consider
this to match void ** and would generate an error. But
struct hv_input_get_vp_registers ** _does_ match void * and compiles
with no error. It makes sense when you think about it, though it
isn't obvious. I tried to use void ** initially and had to figure out
why the code wouldn't compile. :-)

>=20
> > +{
> > +	u32 in_batch_count =3D 0, out_batch_count =3D 0, batch_count;
> > +	u32 in_total_size, out_total_size, offset;
> > +	u32 batch_space =3D HV_HYP_PAGE_SIZE * HV_HVCALL_ARG_PAGES;
> > +	void *space;
> > +
> > +	/*
> > +	 * If input and output have arrays, allocate half the space to input
> > +	 * and half to output. If only input has an array, the array can use
> > +	 * all the space except for the fixed size output (but not to exceed
> > +	 * one page), and vice versa.
> > +	 */
> > +	if (in_entry_size && out_entry_size)
> > +		batch_space =3D batch_space / 2;
> > +	else if (in_entry_size)
> > +		batch_space =3D min(HV_HYP_PAGE_SIZE, batch_space - out_size);
> > +	else if (out_entry_size)
> > +		batch_space =3D min(HV_HYP_PAGE_SIZE, batch_space - in_size);
> > +
> > +	if (in_entry_size)
> > +		in_batch_count =3D (batch_space - in_size) / in_entry_size;
> > +	if (out_entry_size)
> > +		out_batch_count =3D (batch_space - out_size) / out_entry_size;
> > +
> > +	/*
> > +	 * If input and output have arrays, use the smaller of the two batch
> > +	 * counts, in case they are different. If only one has an array, use
> > +	 * that batch count. batch_count will be zero if neither has an array=
.
> > +	 */
> > +	if (in_batch_count && out_batch_count)
> > +		batch_count =3D min(in_batch_count, out_batch_count);
> > +	else
> > +		batch_count =3D in_batch_count | out_batch_count;
> > +
> > +	in_total_size =3D ALIGN(in_size + (in_entry_size * batch_count), 8);
> > +	out_total_size =3D ALIGN(out_size + (out_entry_size * batch_count), 8=
);
> > +
> > +	space =3D *this_cpu_ptr(hyperv_pcpu_arg);
> > +	if (input) {
> > +		*(void **)input =3D space;
> > +		if (space)
> > +			/* Zero the fixed size portion, not any array portion */
> > +			memset(space, 0, ALIGN(in_size, 8));
> > +	}
> > +
> > +	if (output) {
> > +		if (in_total_size + out_total_size <=3D HV_HYP_PAGE_SIZE) {
> > +			offset =3D in_total_size;
> > +		} else {
> > +			offset =3D HV_HYP_PAGE_SIZE;
> > +			/* Need more than 1 page, but only 1 was allocated */
> > +			BUILD_BUG_ON(HV_HVCALL_ARG_PAGES =3D=3D 1);
> Interesting... so the compiler is not compiling this BUILD_BUG_ON in your=
 patchset
> because in_total_size + out_total_size <=3D HV_HYP_PAGE_SIZE is always kn=
own at
> compile-time?

Correct. And if for some future hypercall in_total_size + out_total_size is
*not* <=3D HV_HYP_PAGE_SIZE, the BUILD_BUG_ON() will alert the developer
to the problem. Depending on the argument requirements of this future
hypercall, the solution might require changing HV_HVCALL_ARG_PAGES to 2.

> So will this also fail if any of the args in_size, in_entry_size, out_siz=
e,
> out_entry_size are runtime-known?

Correct.  I should change my wording about "The four 'size' arguments are
expected to be constants" to ". . . must be constants". OTOH, if there's a =
need
to support non-constants for any of these arguments, some additional code
could handle that case. But the overall hv_hvcall_inout_array() function wi=
ll
end up generating a lot of code to execute at runtime. I looked at the hype=
rcall
call sites in the OHCL kernel tree, and didn't see any need for non-constan=
ts,
but I haven't looked yet at the v4 patch series you just posted.  Let me kn=
ow
if you have a case requiring non-constants.

Michael

