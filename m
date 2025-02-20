Return-Path: <linux-arch+bounces-10240-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2574AA3CEFD
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 03:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D66171CD9
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 02:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52A61C5D79;
	Thu, 20 Feb 2025 02:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MNmXDhFG"
X-Original-To: linux-arch@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011036.outbound.protection.outlook.com [52.103.13.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AEF1C3BF7;
	Thu, 20 Feb 2025 02:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740017239; cv=fail; b=dsD0JO3QauKH1+kqME/rCGWD2jE5VDIR4ykAtd0cKMaG33Jxod4gwGedinYlmu06z57E/szdcqlqj+lWzZcRVSlL/9s1XJCoAWMn1NFv9s9myS4FnJEjNVUC/nkEtpg8yEpcdC1PEChC9WpXsVlLuVPIKE9PCydxRMmZw65AbJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740017239; c=relaxed/simple;
	bh=ju2p/HxtmALdLUdBflu9C3HEtoV1s6G9mQhwfQUXcDI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eiL6+kq//6uh4dGmEX7qUPhkz056THQezbNA8lpEyu7xhIUBNwh5hnEKix34nCbEMniBQqKYoxdNe5ocs1CZemBv8YbChn1/5Z4x7AnT8y+jH+RNOUXv0MKnXcQz72MifsvvEzy+ipFMKhMPGWF5IeetfGX1RldUFtCdIF+yM6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MNmXDhFG; arc=fail smtp.client-ip=52.103.13.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IvU1d05ukQP/le1HMbqNGh30QYX0tC20EjYE0Gw2c+9/BV8pdu1gdtyRCae2EJ7Wql6yHneZAqcvNORR6rcVrQZoON5HlvqxQOjeRNd/e/tRs9JjmukgIw90neB2LN2OgqJPUjsXL/NA/kax9oTDxSI+vy6qiI8bNCZz9Uc4OV1J+tgU34ynbLg+Z1SaXf8PzUcG85GFZFuf137KCE4NLwX7cjZVaZ5Lq1hTbqo3Hygpqa+E99eRLid3Fak5vdO0d5fnmGw5KoWfiDd0C0aSbvXJARFDkYbHh+RLHddRqTDYe8pzBH4DIjPxMdj/1+2vLrhafGMXNUVcJ3dvUiLoxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JZHhIJyz23YcuxAc53YBsjRPj4KTX5sj/VLOlLfA54=;
 b=lj4z8CFYAWLansJiBl4rR5Tlnqcfokf+7LPNue/8BUZzHBSdx/LDrWfJqMUgVXFqlzGjvEgjHT2SsaJbd4dhB5te91Vq1NuLtCbUU8PFNd+KjYfcl34qWgGoLp4cz10gvhqHDesp81wBg/qNJri5ydSSlnUqofEo3xGYqK3avfCmoLR8LsCmOcVs9p2ttGwQXJZl2zb5m/ALx0djctLk2aAa+2256ZtidELRyhoc9ML61QP2A31WGirQBIohjysZmmJrIbtyOeHpM5PxbNU1l61rhJdjvkkvIPZpuM6sgSjF/j4MBFDmg9cXCG2NGJ9yLExM95R1Tjeev2/nEYUZug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JZHhIJyz23YcuxAc53YBsjRPj4KTX5sj/VLOlLfA54=;
 b=MNmXDhFGdHshyTFPvcWr9t160+qM8eCGrANFkvMCggx84+6/rlLXd+PH9G6aArk3TYtohmodG87UmCRkTaDs5AIW3prG+gIj1b7lv63S2zP1CA0QWPT9hY4+gWt9k1zE9mOkMPC0jkvLehuzDkdLfUzgqa2pbKo5LZEkoIq/BIIdbglsCuSDKWvXPa9jFJoVPMz9RWd5yk/QoN3yimxbdLVTBzi1t0DUjfMrC1vFWcgLVB4esImRhOo/gjpXF2TYVmrst+Y2CMN2FPFV4b8mRSHLDc8fdfEQkv+aDCk+GH3cBIZsXiDp1F0jYiW/d0cuqrMEiS1TCJ3I3WlXlvxCDw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB7026.namprd02.prod.outlook.com (2603:10b6:a03:23d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Thu, 20 Feb
 2025 02:07:14 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 02:07:13 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "joro@8bytes.org"
	<joro@8bytes.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "jinankjain@linux.microsoft.com"
	<jinankjain@linux.microsoft.com>, "muminulrussell@gmail.com"
	<muminulrussell@gmail.com>, "skinsburskii@linux.microsoft.com"
	<skinsburskii@linux.microsoft.com>, "mukeshrathor@microsoft.com"
	<mukeshrathor@microsoft.com>
Subject: RE: [PATCH] hyperv: Add CONFIG_MSHV_ROOT to gate hv_root_partition
 checks
Thread-Topic: [PATCH] hyperv: Add CONFIG_MSHV_ROOT to gate hv_root_partition
 checks
Thread-Index: AQHbfNN0LPMRAYePyESDh5/Fg8MXNbNO4d+QgAB3JgCAAB+rAA==
Date: Thu, 20 Feb 2025 02:07:13 +0000
Message-ID:
 <SN6PR02MB4157F735E4B553740CAEE369D4C42@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1739312515-18848-1-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157F396B9FECAD555520DDED4C52@SN6PR02MB4157.namprd02.prod.outlook.com>
 <1defc59b-3e6c-4023-b57b-d81a4358e69e@linux.microsoft.com>
In-Reply-To: <1defc59b-3e6c-4023-b57b-d81a4358e69e@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB7026:EE_
x-ms-office365-filtering-correlation-id: 969e5e33-c640-4417-a331-08dd51534af7
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799003|15080799006|8062599003|8060799006|12121999004|10035399004|440099028|3412199025|12091999003|41001999003|4302099013|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3oWkuPwCmYuPELg9ZOQE1af2uzdr7qidGRI50CWiSZZtwrfun1tztkCSNe9Y?=
 =?us-ascii?Q?VrabCOt1vx7GYsmFuplmbH7gqDDVk2iw/TemCZebGUxJFAE9gEeRwo5V9NkG?=
 =?us-ascii?Q?Qbt6frMN9g0zTRAzDdBQ1YKOV8hf15VHUIZ89U1yA3tj0uKO8gnNAMfI+4mN?=
 =?us-ascii?Q?aYJxs6iyuypGnHTsCGZBkXem9fuD2Os8uV6/5lWhqXBgqj8wVi4KBTf7wmnm?=
 =?us-ascii?Q?w8yWuvyl3elTN4pSqv6AUsp95jZcUVQfXr5EgZo8tPAuq8FesrQdc0M1VXpt?=
 =?us-ascii?Q?SHqtDwgj3ruVIw8t/eK5zqtLpFwsT74eHXKlTaFzc9VDWs0gcCyuOKIjDdbx?=
 =?us-ascii?Q?9JbWfsBARt24W3O9nCCQCpNLNTf1plkS0h+vW6YFjpaQAsWVnXmb5ZYqX7HI?=
 =?us-ascii?Q?G2TjC9wFM+scc6ckq56ZBAzZgWYFtZyNgK6n4lEfBFcXAVNE72kSY6TATuoy?=
 =?us-ascii?Q?lDRA66HJvjVJsNO8iahQbHaSMTwNJTxKaxJFu/5bp0ENxKrOnS02SIGGZhxM?=
 =?us-ascii?Q?aWsi+9NY1AYTKduXUXq4gH1E9hNThiIMTwv02BVHeQvZELOWqFHSluav3rwf?=
 =?us-ascii?Q?4jFMhYFYZ9GBUshvoFvUeMhJ1IWi2k93n7EIAwVz9CjccLYDHiAT367XQJg0?=
 =?us-ascii?Q?7PpCyHBJple/zrhAp0QQnMIz415g3oavWd7F6at/bjwOT7MaX9m7atx2WgAd?=
 =?us-ascii?Q?STCZbXWH1pjlzDGXzJZ0S8CvOhgXwK6x1aewJaIynZ4UrqlmSMruwoE9qzSV?=
 =?us-ascii?Q?PAG5o9hEchRtUo/E7bfKQFpApd8tRE+tNIlx9JLIJzusoD+uVT9ioEFI1X1P?=
 =?us-ascii?Q?ZFPQydE8/EcbhkdVqGhMdkw+AEZf+9kxcg8QPISZYqB0+3KzZapGtZkih0l4?=
 =?us-ascii?Q?2A9OSurkUCqCqJjAPEDh3z4AAiF3n82UH+7mkcfw4vsjSPPiz3SMMZ+pYaNu?=
 =?us-ascii?Q?kDcvj4ofNKMn0DCc07at5kUcpMrX0vyXiM0v8ml9pAXoEuEYjgfVeOVKzjWk?=
 =?us-ascii?Q?ALTbEYhpc0hJ4BuMytpdeBYh4jHuWkXxg3CqlUOPmfLb3HA63j96tFIm41lQ?=
 =?us-ascii?Q?11SgxKMzvvvyPacREnnP20sjJpmefIfHEXW09/bRJeqQSi3NS9H8f7n3J6tp?=
 =?us-ascii?Q?+3TriQ476d+HyiSqoFWPploqdL7mW5ICDC7gVl8rF3moyX2GhPevjJLrYGGe?=
 =?us-ascii?Q?RrDX0y9QVbZJjiznJY7g7j39E2KZcfhSQiPjz4J05JcqqaYx7Vz34zXH5LfV?=
 =?us-ascii?Q?WsI8QRaSXxbPqrBwQmMm9rjJHWpPyP1gChvjTTZd4Yev2QqVqTkyOvDZboGF?=
 =?us-ascii?Q?LC5cO07Hja7u4TBgUAve3b/L?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PjQwmDPscjVoZIy3IaiprVdsfXYvcBVCVBcPSDOjwOaqyk+9oy/0NMqDL3d1?=
 =?us-ascii?Q?0iCUpEf0MBkIOC8L7YmwDsMMZDXogcuVpSn05G/Owq/uKSOZtDcpuh6wvc2n?=
 =?us-ascii?Q?FBGs/idclBOQuF1FbCJRDVO6n/kcJOEdHz8ILZLSjQ0hUnXn7gpmaGEk4RHa?=
 =?us-ascii?Q?ebx/TVUnMGEi78FxWFLBsB131ad7lFwLwPAlGc9B0n6Ro1GPz9WCDszlATDy?=
 =?us-ascii?Q?yUuhDCL6nFzqYDKSUsTX71py5eS55aSgtyrjmhUUs49X51e8P0fBTb7Q5Xzw?=
 =?us-ascii?Q?iifr56T8NHi+2A/uUcUA+HG4QNhFK4wks9cM+QF9/kgCpwaPNNKebaVVLOTk?=
 =?us-ascii?Q?GH9GgDt9CmqFQAnC5UKn+yWqsdrfJtdr0MMisT5VFDGp47GQclfiHFY4PsK/?=
 =?us-ascii?Q?kVtYtIfGDBjrnBzzEKfbwkC1kNO5Zvc/yxJQ0BGwGZoWnY0CavsgTQuAF7mC?=
 =?us-ascii?Q?xXNoM1vAzcfgarq65jrHeAwi6h1jFtcF+kIN8d9mxCWC6izgDDU4tYhCnLkp?=
 =?us-ascii?Q?FRB9bdGGGCHVHvaUyNn+/Wd9CHZv16Y35zkg8ZUbz6y1bYQ128hIixl3aMVY?=
 =?us-ascii?Q?/TyW8U/iyGoMv7wC7I3K9RQSZvn4g2z6MzIKPJFuM9lLkiWte8UZonnb1j/5?=
 =?us-ascii?Q?8eEDWNZJStUTQCitFUxhEthYRLl84A6RIY0/KFQfnajkd7q2fbzREeZ6kkl6?=
 =?us-ascii?Q?MsYyp5VXa3PtwYqYtCRVSnXx6CBdXsyV/RDGr3XpGslQZ1Yx7+mjefVqV9O/?=
 =?us-ascii?Q?BjRVrc7hwr2I10J/v1BJpq/xKjXdLUFoljK2mgxL+uoyFYyM1bw0erlWj4kd?=
 =?us-ascii?Q?xqpZ5whzvoraeUU8uJmNS8lfIzy2YysNSsvnmTDj7Y4cXIpeR3DKW/iAFNp0?=
 =?us-ascii?Q?NnQ6pXGaJbnN3dHEVxrE8Uvji3sxwEmtYN64nlzVKWh3oZT9KCw1NSONIS2h?=
 =?us-ascii?Q?Lusk2UOHm9m8ZCnebneUpH6hDWYKpqkTPpWWTX1gID6Ss+aLyJgIxRjCRpYe?=
 =?us-ascii?Q?e7BWq9goWv78KhcSOcfFTMt0S5095WzgowFz2eCX8pI29SLkBRfqKw6m9TvU?=
 =?us-ascii?Q?N1Z8f4VOgWSy7pFp+G32covvsdo04ajiSQq5mbY4Yj3s8Z4dVKl8YIg3ntjc?=
 =?us-ascii?Q?0MFh1/vVmNM+hGBsYLxajvZPF9XaRHcz+l1jFLD2y6Iymzh7u7gnbr/DIu0R?=
 =?us-ascii?Q?PghA4/PxKd9p9Nq0KooQEy3SRC9tPTn3o8ST/w+ofi6JBdwRW25xf0Ku5z8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 969e5e33-c640-4417-a331-08dd51534af7
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 02:07:13.7738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7026

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, Fe=
bruary 19, 2025 3:53 PM
>=20
> On 2/19/2025 11:46 AM, Michael Kelley wrote:
> > From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Tuesday,
> February 11, 2025 2:22 PM
> >>
> >> Introduce CONFIG_MSHV_ROOT as a tristate to enable root partition
> >> booting and future mshv driver functionality.
> >
> > This statement could use a bit more explanation as to "why".  Something
> > like:
> >
> > Running in the root partition is a unique and specialized case that req=
uires
> > additional code. The config option allows kernels built to run as a nor=
mal
> > Hyper-V guest to exclude this code, which is important since significan=
t
> > additional code specific to the root partition is expected to be added =
over
> > time.
> >
>=20
> This sounds good to me
>=20
> > Related, what's the thinking behind making CONFIG_MSHV_ROOT be
> > tri-state? Obviously, it would allow most of the root partition code
> > to be loaded as a module instead of built-in to the kernel image, but i=
s that
> > a useful scenario given the unique nature of running in the root partit=
ion?
> > Since the root partition environment is very specific and constrained,
> > perhaps just always building the root partition code into the kernel
> > makes sense. I'm asking purely as a question because I'm not familiar w=
ith
> > the details of how a root partition kernel is likely to be setup & run.=
 If
> > possible, give a short explanation for the "why tri-state" question.
> > Remember, that's what commit message are for -- to answer the "why"
> > question as much as to summarize the "what" question.
> >
>=20
> In the past it enabled quicker development: I would iterate on the driver
> code and just rebuild and reinsert the module. I'll admit I haven't used =
that
> workflow in a while so I'm not sure how useful it still is.
>=20
> Is there a *downside* (from upstream perspective) to keeping it a tristat=
e
> that I'm not aware of? e.g. Would it be difficult to change it to a bool =
in
> future if we decide we really don't need it?

OK -- I had not thought about the development workflow, and that's valid.
There's no downside to keeping it tri-state that I'm aware of. And I think =
it
would be easy to change to just a Boolean in the future if tri-state
isn't really useful. It was just one of those things that surprised me
a little bit, and I was wondering "why". :-)

>=20
> While we're on this topic, do you know if CONFIG_HYPERV=3Dm is ever used,=
 and
> why?

Yes, it is definitely used by the distro vendors. They want to have a singl=
e
product release that is useable pretty much everywhere. So they don't
want to burden the main kernel binary with Hyper-V code that
wouldn't be used on bare metal, or a KVM/QEMU VM, etc. Azure images
might be a little more specific to Hyper-V, and might have the Hyper-V
code built-in -- it depends on the distro vendor. I don't remember having
taken a census to know which approach predominates, but my guess is
"=3Dm".

>=20
> >>
> >> Change hv_root_partition into a function which always returns false
> >> if CONFIG_MSHV_ROOT=3Dn.
> >
> > Again, help answer the "why" question. I think the goal is related to
> > the above by allowing the compiler to optimize away any "if (root parti=
tion)"
> > code when building for a normal Hyper-V guest.
> >
> >>
> >> Introduce hv_current_partition_type to store the type of partition
> >> (guest, root, or other kinds in future), and hv_identify_partition_typ=
e()
> >> to it up early in Hyper-V initialization.
> >>
> >> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> >> ---
> >> Depends on
> >> https://lore.kernel.org/linux-hyperv/1738955002-20821-3-git-send-email=
-nunodasneves@linux.microsoft.com/
> >>
> >>  arch/arm64/hyperv/mshyperv.c       |  2 ++
> >>  arch/x86/hyperv/hv_init.c          | 10 ++++----
> >>  arch/x86/kernel/cpu/mshyperv.c     | 24 ++----------------
> >>  drivers/clocksource/hyperv_timer.c |  4 +--
> >>  drivers/hv/Kconfig                 | 12 +++++++++
> >>  drivers/hv/Makefile                |  3 ++-
> >>  drivers/hv/hv.c                    | 10 ++++----
> >>  drivers/hv/hv_common.c             | 32 +++++++++++++++++++-----
> >>  drivers/hv/vmbus_drv.c             |  2 +-
> >>  drivers/iommu/hyperv-iommu.c       |  4 +--
> >>  include/asm-generic/mshyperv.h     | 39 +++++++++++++++++++++++++----=
-
> >>  11 files changed, 92 insertions(+), 50 deletions(-)
> >>
> >> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv=
.c
> >> index 29fcfd595f48..2265ea5ce5ad 100644
> >> --- a/arch/arm64/hyperv/mshyperv.c
> >> +++ b/arch/arm64/hyperv/mshyperv.c
> >> @@ -61,6 +61,8 @@ static int __init hyperv_init(void)
> >>  		ms_hyperv.features, ms_hyperv.priv_high, ms_hyperv.hints,
> >>  		ms_hyperv.misc_features);
> >>
> >> +	hv_identify_partition_type();
> >> +
> >>  	ret =3D hv_common_init();
> >>  	if (ret)
> >>  		return ret;
> >> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> >> index 9be1446f5bd3..ddeb40930bc8 100644
> >> --- a/arch/x86/hyperv/hv_init.c
> >> +++ b/arch/x86/hyperv/hv_init.c
> >> @@ -90,7 +90,7 @@ static int hv_cpu_init(unsigned int cpu)
> >>  		return 0;
> >>
> >>  	hvp =3D &hv_vp_assist_page[cpu];
> >> -	if (hv_root_partition) {
> >> +	if (hv_root_partition()) {
> >>  		/*
> >>  		 * For root partition we get the hypervisor provided VP assist
> >>  		 * page, instead of allocating a new page.
> >> @@ -242,7 +242,7 @@ static int hv_cpu_die(unsigned int cpu)
> >>
> >>  	if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
> >>  		union hv_vp_assist_msr_contents msr =3D { 0 };
> >> -		if (hv_root_partition) {
> >> +		if (hv_root_partition()) {
> >>  			/*
> >>  			 * For root partition the VP assist page is mapped to
> >>  			 * hypervisor provided page, and thus we unmap the
> >> @@ -317,7 +317,7 @@ static int hv_suspend(void)
> >>  	union hv_x64_msr_hypercall_contents hypercall_msr;
> >>  	int ret;
> >>
> >> -	if (hv_root_partition)
> >> +	if (hv_root_partition())
> >>  		return -EPERM;
> >>
> >>  	/*
> >> @@ -518,7 +518,7 @@ void __init hyperv_init(void)
> >>  	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> >>  	hypercall_msr.enable =3D 1;
> >>
> >> -	if (hv_root_partition) {
> >> +	if (hv_root_partition()) {
> >>  		struct page *pg;
> >>  		void *src;
> >>
> >> @@ -592,7 +592,7 @@ void __init hyperv_init(void)
> >>  	 * If we're running as root, we want to create our own PCI MSI domai=
n.
> >>  	 * We can't set this in hv_pci_init because that would be too late.
> >>  	 */
> >> -	if (hv_root_partition)
> >> +	if (hv_root_partition())
> >>  		x86_init.irqs.create_pci_msi_domain =3D hv_create_pci_msi_domain;
> >>  #endif
> >>
> >> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshy=
perv.c
> >> index f285757618fc..4f01f424ea5b 100644
> >> --- a/arch/x86/kernel/cpu/mshyperv.c
> >> +++ b/arch/x86/kernel/cpu/mshyperv.c
> >> @@ -33,8 +33,6 @@
> >>  #include <asm/numa.h>
> >>  #include <asm/svm.h>
> >>
> >> -/* Is Linux running as the root partition? */
> >> -bool hv_root_partition;
> >>  /* Is Linux running on nested Microsoft Hypervisor */
> >>  bool hv_nested;
> >>  struct ms_hyperv_info ms_hyperv;
> >> @@ -451,25 +449,7 @@ static void __init ms_hyperv_init_platform(void)
> >>  	pr_debug("Hyper-V: max %u virtual processors, %u logical processors\=
n",
> >>  		 ms_hyperv.max_vp_index, ms_hyperv.max_lp_index);
> >>
> >> -	/*
> >> -	 * Check CPU management privilege.
> >> -	 *
> >> -	 * To mirror what Windows does we should extract CPU management
> >> -	 * features and use the ReservedIdentityBit to detect if Linux is th=
e
> >> -	 * root partition. But that requires negotiating CPU management
> >> -	 * interface (a process to be finalized). For now, use the privilege
> >> -	 * flag as the indicator for running as root.
> >> -	 *
> >> -	 * Hyper-V should never specify running as root and as a Confidentia=
l
> >> -	 * VM. But to protect against a compromised/malicious Hyper-V trying
> >> -	 * to exploit root behavior to expose Confidential VM memory, ignore
> >> -	 * the root partition setting if also a Confidential VM.
> >> -	 */
> >> -	if ((ms_hyperv.priv_high & HV_CPU_MANAGEMENT) &&
> >> -	    !(ms_hyperv.priv_high & HV_ISOLATION)) {
> >> -		hv_root_partition =3D true;
> >> -		pr_info("Hyper-V: running as root partition\n");
> >> -	}
> >> +	hv_identify_partition_type();
> >>
> >>  	if (ms_hyperv.hints & HV_X64_HYPERV_NESTED) {
> >>  		hv_nested =3D true;
> >> @@ -618,7 +598,7 @@ static void __init ms_hyperv_init_platform(void)
> >>
> >>  # ifdef CONFIG_SMP
> >>  	smp_ops.smp_prepare_boot_cpu =3D hv_smp_prepare_boot_cpu;
> >> -	if (hv_root_partition ||
> >> +	if (hv_root_partition() ||
> >>  	    (!ms_hyperv.paravisor_present && hv_isolation_type_snp()))
> >>  		smp_ops.smp_prepare_cpus =3D hv_smp_prepare_cpus;
> >>  # endif
> >> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/=
hyperv_timer.c
> >> index f00019b078a7..09549451dd51 100644
> >> --- a/drivers/clocksource/hyperv_timer.c
> >> +++ b/drivers/clocksource/hyperv_timer.c
> >> @@ -582,7 +582,7 @@ static void __init hv_init_tsc_clocksource(void)
> >>  	 * mapped.
> >>  	 */
> >>  	tsc_msr.as_uint64 =3D hv_get_msr(HV_MSR_REFERENCE_TSC);
> >> -	if (hv_root_partition)
> >> +	if (hv_root_partition())
> >>  		tsc_pfn =3D tsc_msr.pfn;
> >>  	else
> >>  		tsc_pfn =3D HVPFN_DOWN(virt_to_phys(tsc_page));
> >> @@ -627,7 +627,7 @@ void __init hv_remap_tsc_clocksource(void)
> >>  	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
> >>  		return;
> >>
> >> -	if (!hv_root_partition) {
> >> +	if (!hv_root_partition()) {
> >>  		WARN(1, "%s: attempt to remap TSC page in guest partition\n",
> >>  		     __func__);
> >>  		return;
> >> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> >> index 862c47b191af..aac172942f6c 100644
> >> --- a/drivers/hv/Kconfig
> >> +++ b/drivers/hv/Kconfig
> >> @@ -55,4 +55,16 @@ config HYPERV_BALLOON
> >>  	help
> >>  	  Select this option to enable Hyper-V Balloon driver.
> >>
> >> +config MSHV_ROOT
> >> +	tristate "Microsoft Hyper-V root partition support"
> >> +	depends on HYPERV
> >> +	depends on !HYPERV_VTL_MODE
> >> +	depends on PAGE_SIZE_4KB
> >
> > Add a comment about why PAGE_SIZE_4KB is a requirement, even on
> > arm64 systems that can support guests with larger page sizes. We
> > discussed why in an earlier email thread, but somebody looking at
> > this in the future might wonder.
> >
> >> +	default n
> >> +	help
> >> +	  Select this option to enable support for booting and running as ro=
ot
> >> +	  partition on Microsoft Hyper-V.
> >> +
> >> +	  If unsure, say N.
> >> +
> >
> > One thing to keep in mind:  Sometimes people build kernels with all
> > config options set to "Y".  We want to make sure that if someone does
> > that, the kernel will still run in a non-Hyper-V environment.  We had t=
his
> > problem with CONFIG_HYPERV_VTL_MODE=3Dy, where a kernel built with
> > that wouldn't run elsewhere, and that had to be fixed.  I don't think t=
he
> > changes in this patch cause a problem in that regard, but it is somethi=
ng
> > to keep in mind for the future.
> >
> > As I see it, setting CONFIG_MSHV_ROOT=3Dy (or =3Dm) just adds code to
> > the kernel image or modules list, and enables runtime detection of
> > whether the kernel is actually in the root partition. If not actually i=
n the
> > root partition, the behavior is normal guest behavior. I think that is =
all good.
> >
> Yes, agreed. The assumption we are working under is that enabling
> CONFIG_MSHV_ROOT
> doesn't break any normal guest or non-Hyper-V scenarios.
>=20
> Of course it's hard to always be certain that our code doesn't break some=
 other
> config option at runtime, but we fix that whenever we see it (or exclude =
the
> combination via Kconfig).
>=20
> >>  endmenu
> >> diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
> >> index 9afcabb3fbd2..2b8dc954b350 100644
> >> --- a/drivers/hv/Makefile
> >> +++ b/drivers/hv/Makefile
> >> @@ -13,4 +13,5 @@ hv_vmbus-$(CONFIG_HYPERV_TESTING)	+=3D hv_debugfs.o
> >>  hv_utils-y :=3D hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
> >>
> >>  # Code that must be built-in
> >> -obj-$(subst m,y,$(CONFIG_HYPERV)) +=3D hv_common.o hv_proc.o
> >> +obj-$(subst m,y,$(CONFIG_HYPERV)) +=3D hv_common.o
> >> +obj-$(subst m,y,$(CONFIG_MSHV_ROOT)) +=3D hv_proc.o
> >
> > OK, so hv_proc.o is always built-in, regardless of whether
> > CONFIG_MSHV_ROOT=3Dy or =3Dm. I think that makes sense. The functions i=
n
> > hv_proc.c are called somewhere in the middle of the kernel boot process=
,
> > and I'm unsure if the module loading mechanism is fully set up at the p=
oint
> > the functions are needed. This approach avoids any risk of not being ab=
le
> > to load the module. Presumably still-to-be-added code for the root part=
ition
> > could be built as a module (though see my comment in the commit message=
).
> >
>=20
> Yep, that was the idea.
>=20
> >> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> >> index 36d9ba097ff5..93d82382351c 100644
> >> --- a/drivers/hv/hv.c
> >> +++ b/drivers/hv/hv.c
> >> @@ -144,7 +144,7 @@ int hv_synic_alloc(void)
> >>  		 * Synic message and event pages are allocated by paravisor.
> >>  		 * Skip these pages allocation here.
> >>  		 */
> >> -		if (!ms_hyperv.paravisor_present && !hv_root_partition) {
> >> +		if (!ms_hyperv.paravisor_present && !hv_root_partition()) {
> >>  			hv_cpu->synic_message_page =3D
> >>  				(void *)get_zeroed_page(GFP_ATOMIC);
> >>  			if (!hv_cpu->synic_message_page) {
> >> @@ -272,7 +272,7 @@ void hv_synic_enable_regs(unsigned int cpu)
> >>  	simp.as_uint64 =3D hv_get_msr(HV_MSR_SIMP);
> >>  	simp.simp_enabled =3D 1;
> >>
> >> -	if (ms_hyperv.paravisor_present || hv_root_partition) {
> >> +	if (ms_hyperv.paravisor_present || hv_root_partition()) {
> >>  		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
> >>  		u64 base =3D (simp.base_simp_gpa << HV_HYP_PAGE_SHIFT) &
> >>  				~ms_hyperv.shared_gpa_boundary;
> >> @@ -291,7 +291,7 @@ void hv_synic_enable_regs(unsigned int cpu)
> >>  	siefp.as_uint64 =3D hv_get_msr(HV_MSR_SIEFP);
> >>  	siefp.siefp_enabled =3D 1;
> >>
> >> -	if (ms_hyperv.paravisor_present || hv_root_partition) {
> >> +	if (ms_hyperv.paravisor_present || hv_root_partition()) {
> >>  		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
> >>  		u64 base =3D (siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT) &
> >>  				~ms_hyperv.shared_gpa_boundary;
> >> @@ -367,7 +367,7 @@ void hv_synic_disable_regs(unsigned int cpu)
> >>  	 * addresses.
> >>  	 */
> >>  	simp.simp_enabled =3D 0;
> >> -	if (ms_hyperv.paravisor_present || hv_root_partition) {
> >> +	if (ms_hyperv.paravisor_present || hv_root_partition()) {
> >>  		iounmap(hv_cpu->synic_message_page);
> >>  		hv_cpu->synic_message_page =3D NULL;
> >>  	} else {
> >> @@ -379,7 +379,7 @@ void hv_synic_disable_regs(unsigned int cpu)
> >>  	siefp.as_uint64 =3D hv_get_msr(HV_MSR_SIEFP);
> >>  	siefp.siefp_enabled =3D 0;
> >>
> >> -	if (ms_hyperv.paravisor_present || hv_root_partition) {
> >> +	if (ms_hyperv.paravisor_present || hv_root_partition()) {
> >>  		iounmap(hv_cpu->synic_event_page);
> >>  		hv_cpu->synic_event_page =3D NULL;
> >>  	} else {
> >> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> >> index cb3ea49020ef..d1227e85c5b7 100644
> >> --- a/drivers/hv/hv_common.c
> >> +++ b/drivers/hv/hv_common.c
> >> @@ -34,8 +34,11 @@
> >>  u64 hv_current_partition_id =3D HV_PARTITION_ID_SELF;
> >>  EXPORT_SYMBOL_GPL(hv_current_partition_id);
> >>
> >> +enum hv_partition_type hv_current_partition_type;
> >> +EXPORT_SYMBOL_GPL(hv_current_partition_type);
> >> +
> >>  /*
> >> - * hv_root_partition, ms_hyperv and hv_nested are defined here with o=
ther
> >> + * ms_hyperv and hv_nested are defined here with other
> >>   * Hyper-V specific globals so they are shared across all architectur=
es and are
> >>   * built only when CONFIG_HYPERV is defined.  But on x86,
> >>   * ms_hyperv_init_platform() is built even when CONFIG_HYPERV is not
> >> @@ -43,9 +46,6 @@ EXPORT_SYMBOL_GPL(hv_current_partition_id);
> >>   * here, allowing for an overriding definition in the module containi=
ng
> >>   * ms_hyperv_init_platform().
> >>   */
> >> -bool __weak hv_root_partition;
> >> -EXPORT_SYMBOL_GPL(hv_root_partition);
> >> -
> >>  bool __weak hv_nested;
> >>  EXPORT_SYMBOL_GPL(hv_nested);
> >>
> >> @@ -283,7 +283,7 @@ static void hv_kmsg_dump_register(void)
> >>
> >>  static inline bool hv_output_page_exists(void)
> >>  {
> >> -	return hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE);
> >> +	return hv_root_partition() || IS_ENABLED(CONFIG_HYPERV_VTL_MODE);
> >>  }
> >>
> >>  void __init hv_get_partition_id(void)
> >> @@ -594,7 +594,7 @@ EXPORT_SYMBOL_GPL(hv_setup_dma_ops);
> >>
> >>  bool hv_is_hibernation_supported(void)
> >>  {
> >> -	return !hv_root_partition && acpi_sleep_state_supported(ACPI_STATE_S=
4);
> >> +	return !hv_root_partition() && acpi_sleep_state_supported(ACPI_STATE=
_S4);
> >>  }
> >>  EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
> >>
> >> @@ -683,3 +683,23 @@ u64 __weak hv_tdx_hypercall(u64 control, u64 para=
m1, u64 param2)
> >>  	return HV_STATUS_INVALID_PARAMETER;
> >>  }
> >>  EXPORT_SYMBOL_GPL(hv_tdx_hypercall);
> >> +
> >> +void hv_identify_partition_type(void)
> >> +{
> >> +	/*
> >> +	 * Check partition creation and cpu management privileges
> >> +	 *
> >> +	 * Hyper-V should never specify running as root and as a Confidentia=
l
> >> +	 * VM. But to protect against a compromised/malicious Hyper-V trying
> >> +	 * to exploit root behavior to expose Confidential VM memory, ignore
> >> +	 * the root partition setting if also a Confidential VM.
> >> +	 */
> >> +	if ((ms_hyperv.priv_high & HV_CREATE_PARTITIONS) &&
> >> +	    (ms_hyperv.priv_high & HV_CPU_MANAGEMENT) &&
> >> +	    !(ms_hyperv.priv_high & HV_ISOLATION)) {
> >> +		hv_current_partition_type =3D HV_PARTITION_TYPE_ROOT;
> >> +		pr_info("Hyper-V: running as root partition\n");
> >> +	} else {
> >> +		hv_current_partition_type =3D HV_PARTITION_TYPE_GUEST;
> >> +	}
> >
> > If the flags indicate running in the root partition, but CONFIG_MSHV_RO=
OT=3Dn,
> > perhaps that should probably be flagged with an error message. I haven'=
t thought
> > through what to do then: Panic, keep running as a normal guest, or some=
thing else?
> >
>=20
> If the kernel is run as root partition with CONFIG_MSHV_ROOT=3Dn, I think=
 it will crash
> or hang at some point later in boot.
>=20
> How about this:
>=20
> 	if ((ms_hyperv.priv_high & HV_CREATE_PARTITIONS) &&
> 	    (ms_hyperv.priv_high & HV_CPU_MANAGEMENT) &&
> 	    !(ms_hyperv.priv_high & HV_ISOLATION)) {
> 		pr_info("Hyper-V: running as root partition\n");
> 		if (IS_ENABLED(CONFIG_MSHV_ROOT))
> 			hv_current_partition_type =3D HV_PARTITION_TYPE_ROOT;
> 		else
> 			pr_crit("Hyper-V: CONFIG_MSHV_ROOT not enabled!\n");
> 	}
>=20
> We could also BUG_ON() since it will almost certainly crash anyway, but m=
aybe just
> letting it continue is ok.

I'm OK with just continuing, as I don't have any justification for an alter=
native.
It's a strange situation that should not happen, but it's worthwhile to out=
put
some indication of why things are about to go badly.

Michael

>=20
> >> +}
> >> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> >> index 0f6cd44fff29..844eba0429fa 100644
> >> --- a/drivers/hv/vmbus_drv.c
> >> +++ b/drivers/hv/vmbus_drv.c
> >> @@ -2646,7 +2646,7 @@ static int __init hv_acpi_init(void)
> >>  	if (!hv_is_hyperv_initialized())
> >>  		return -ENODEV;
> >>
> >> -	if (hv_root_partition && !hv_nested)
> >> +	if (hv_root_partition() && !hv_nested)
> >>  		return 0;
> >>
> >>  	/*
> >> diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu=
.c
> >> index 2a86aa5d54c6..53e4b37716af 100644
> >> --- a/drivers/iommu/hyperv-iommu.c
> >> +++ b/drivers/iommu/hyperv-iommu.c
> >> @@ -130,7 +130,7 @@ static int __init hyperv_prepare_irq_remapping(voi=
d)
> >>  	    x86_init.hyper.msi_ext_dest_id())
> >>  		return -ENODEV;
> >>
> >> -	if (hv_root_partition) {
> >> +	if (hv_root_partition()) {
> >>  		name =3D "HYPERV-ROOT-IR";
> >>  		ops =3D &hyperv_root_ir_domain_ops;
> >>  	} else {
> >> @@ -151,7 +151,7 @@ static int __init hyperv_prepare_irq_remapping(voi=
d)
> >>  		return -ENOMEM;
> >>  	}
> >>
> >> -	if (hv_root_partition)
> >> +	if (hv_root_partition())
> >>  		return 0; /* The rest is only relevant to guests */
> >>
> >>  	/*
> >> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshy=
perv.h
> >> index 7adc10a4fa3e..6f898792fb51 100644
> >> --- a/include/asm-generic/mshyperv.h
> >> +++ b/include/asm-generic/mshyperv.h
> >> @@ -28,6 +28,11 @@
> >>
> >>  #define VTPM_BASE_ADDRESS 0xfed40000
> >>
> >> +enum hv_partition_type {
> >> +	HV_PARTITION_TYPE_GUEST,
> >> +	HV_PARTITION_TYPE_ROOT,
> >> +};
> >> +
> >>  struct ms_hyperv_info {
> >>  	u32 features;
> >>  	u32 priv_high;
> >> @@ -59,6 +64,7 @@ struct ms_hyperv_info {
> >>  extern struct ms_hyperv_info ms_hyperv;
> >>  extern bool hv_nested;
> >>  extern u64 hv_current_partition_id;
> >> +extern enum hv_partition_type hv_current_partition_type;
> >>
> >>  extern void * __percpu *hyperv_pcpu_input_arg;
> >>  extern void * __percpu *hyperv_pcpu_output_arg;
> >> @@ -190,8 +196,6 @@ void hv_remove_crash_handler(void);
> >>  extern int vmbus_interrupt;
> >>  extern int vmbus_irq;
> >>
> >> -extern bool hv_root_partition;
> >> -
> >>  #if IS_ENABLED(CONFIG_HYPERV)
> >>  /*
> >>   * Hypervisor's notion of virtual processor ID is different from
> >> @@ -213,15 +217,12 @@ void __init hv_common_free(void);
> >>  void __init ms_hyperv_late_init(void);
> >>  int hv_common_cpu_init(unsigned int cpu);
> >>  int hv_common_cpu_die(unsigned int cpu);
> >> +void hv_identify_partition_type(void);
> >>
> >>  void *hv_alloc_hyperv_page(void);
> >>  void *hv_alloc_hyperv_zeroed_page(void);
> >>  void hv_free_hyperv_page(void *addr);
> >>
> >> -int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
> >> -int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
> >> -int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 f=
lags);
> >> -
> >>  /**
> >>   * hv_cpu_number_to_vp_number() - Map CPU to VP.
> >>   * @cpu_number: CPU number in Linux terms
> >> @@ -309,6 +310,7 @@ void hyperv_cleanup(void);
> >>  bool hv_query_ext_cap(u64 cap_query);
> >>  void hv_setup_dma_ops(struct device *dev, bool coherent);
> >>  #else /* CONFIG_HYPERV */
> >> +static inline void hv_identify_partition_type(void) {}
> >>  static inline bool hv_is_hyperv_initialized(void) { return false; }
> >>  static inline bool hv_is_hibernation_supported(void) { return false; =
}
> >>  static inline void hyperv_cleanup(void) {}
> >> @@ -320,4 +322,29 @@ static inline enum hv_isolation_type hv_get_isola=
tion_type(void)
> >>  }
> >>  #endif /* CONFIG_HYPERV */
> >>
> >> +#if IS_ENABLED(CONFIG_MSHV_ROOT)
> >> +static inline bool hv_root_partition(void)
> >> +{
> >> +	return	hv_current_partition_type =3D=3D HV_PARTITION_TYPE_ROOT;
> >
> > Nit: There's an extra space character after "return".
> >
>=20
> Fixed for next version, thanks.
>=20
> >> +}
> >> +int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
> >> +int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
> >> +int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 f=
lags);
> >> +
> >> +#else /* CONFIG_MSHV_ROOT */
> >> +static inline bool hv_root_partition(void) { return false; }
> >> +static inline int hv_call_deposit_pages(int node, u64 partition_id, u=
32 num_pages)
> >> +{
> >> +	return hv_result(U64_MAX);
> >> +}
> >> +static inline int hv_call_add_logical_proc(int node, u32 lp_index, u3=
2 acpi_id)
> >> +{
> >> +	return hv_result(U64_MAX);
> >> +}
> >> +static inline int hv_call_create_vp(int node, u64 partition_id, u32 v=
p_index, u32 flags)
> >> +{
> >> +	return hv_result(U64_MAX);
> >> +}
> >> +#endif /* CONFIG_MSHV_ROOT */
> >> +
> >>  #endif
> >> --
> >> 2.34.1


