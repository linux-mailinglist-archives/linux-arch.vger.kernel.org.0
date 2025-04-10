Return-Path: <linux-arch+bounces-11368-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 752F0A83588
	for <lists+linux-arch@lfdr.de>; Thu, 10 Apr 2025 03:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DF433BA6E5
	for <lists+linux-arch@lfdr.de>; Thu, 10 Apr 2025 01:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCB415E5D4;
	Thu, 10 Apr 2025 01:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LdfDVBIo"
X-Original-To: linux-arch@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013087.outbound.protection.outlook.com [52.103.7.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A7F18B48B;
	Thu, 10 Apr 2025 01:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744247780; cv=fail; b=UaML0bFZLE909BFg7ovzhRRAZN3gMEl8I5FpfNenU/p8TpHmLVp9g6wXk26rGDKkuQuAhr30ZkDtId4K2gf6tXUaQQtw0qIPSF/NtznLkDULOCfzVj/ASmji5mRZbEyrkzXD7GLtNK0Ed5AWMnaimS9hByA+XKzuutZRstHMnpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744247780; c=relaxed/simple;
	bh=fMGZMkZqAbTj2f77VjkweA0Ni3qZz9aOtsXiich+/5g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oRThYfy35tYMf/teypWf3FjGEV4Ia8TRWyvQd5n+WvF/lFGTokWh/+Lw5adWSMfMoJd9gSJtvU+hbxc7DF+CSKIudqo5L8lgj9zs7TrOs3eXC2qteg79/u9ZRnBD7aZzm0/ZhE9nVljIix7N1cqprUTcLtYjEyi4aKjSITHnIWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LdfDVBIo; arc=fail smtp.client-ip=52.103.7.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gy0GA0FKChiJme8FjuQvLBCN4qGZHFW6BUeSpsAv/ciCLIxvr5mPUDXjEboOktM8H3z42UMSQj8UOQ6R+eDiKFxFxXtAeD6cqBEB7kIale7SdHN0Alc4xr+je2UdkBTULdVCquRJkFI2ZmXv9jpf4VzCpW68Yo1gxLpZhdKrKmw0y7iBTwsbR0DL+TmxIr/SZUgns780vXamtcW8vDfaErALzXsoL8bd0os2TNAah+Yg8nESFeIkjE3rTabig4LthSRNHb5GG/Pdl2V0apvkj7BGhChHStOnTbiB/3sAkGhPbMhT9xspyEpV2LHwBHAXwyD289jujG7whmCjDpbj5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMGZMkZqAbTj2f77VjkweA0Ni3qZz9aOtsXiich+/5g=;
 b=HQcmQM95rQ8rrqgCOnWyoRscOYcHkYsImI4WWOH0Nhj8raOnHs/QQn4zmHBAmz14tP2e/QNgb9ykJCtoLml7/yqzZnJzR3oSkwUK67nVtS4QNqbYnJSM6QCU9DBWX+jgwN3OjHm2kldjUtpizYQ+xI9v9D7CVghApEMx2HHNyvYo2qApHvdpybxz7I5Jz4hus27+lOZeRk3r+WTBfdWAoOBL9Av7GPP4H3qRVF7M0NlpBYBbbUmSpVvkoctbhNA4T3pqCzOwJyaw82pm4NGduUMQ9WdQQDgtKsac1YzQkfw07XPqmLijYSmS/EGXs/sjaQa99kPK0xTYyxfUrPUAtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMGZMkZqAbTj2f77VjkweA0Ni3qZz9aOtsXiich+/5g=;
 b=LdfDVBIoB8lH3oPtSNhP/ER1xhJFD6ouukywVzG7gNZ2ARIlm+Upl8ieTEdAf13TuugYn4JMCo2VXzPaGB+VIGAdqEdrAfrJ+lRwhSDLirMnVSw0rBsCduF464m1Gj1QEHzpdqU5baDcWmOSRB1cRFODmShMja0MrtKemAzRuM3BiQejB4sOo7A0ZF519pO6ms5vJM37qntLOL9d+TVkFCeOg5bApUzsab7E0gLu4JALWVDyDhp8xZkonPjK3EEIrFGuiV9SwPRGszsbTFI0fWu9S6eXvfFGA42C70AKjGqUkRpooqO1hhJpkBXZhsu/KWAU3Gc9IFOnNFfykBUIwg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY8PR02MB10188.namprd02.prod.outlook.com (2603:10b6:930:55::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Thu, 10 Apr
 2025 01:16:15 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%5]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 01:16:15 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Dan Williams <dan.j.williams@intel.com>, Roman Kisel
	<romank@linux.microsoft.com>, Robin Murphy <robin.murphy@arm.com>,
	"aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "dakr@kernel.org" <dakr@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hch@lst.de" <hch@lst.de>, "hpa@zytor.com"
	<hpa@zytor.com>, "James.Bottomley@hansenpartnership.com"
	<James.Bottomley@hansenpartnership.com>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"leon@kernel.org" <leon@kernel.org>, "lukas@wunner.de" <lukas@wunner.de>,
	"luto@kernel.org" <luto@kernel.org>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "quic_zijuhu@quicinc.com"
	<quic_zijuhu@quicinc.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "will@kernel.org"
	<will@kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>, Suzuki K Poulose
	<suzuki.poulose@arm.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
Subject: RE: [PATCH hyperv-next 5/6] arch, drivers: Add device struct bitfield
 to not bounce-buffer
Thread-Topic: [PATCH hyperv-next 5/6] arch, drivers: Add device struct
 bitfield to not bounce-buffer
Thread-Index: AQHbqOPfbMEO/VxdVECSYxt0gRTVfbObf/mAgAALcoCAAHGBgIAAGRsQ
Date: Thu, 10 Apr 2025 01:16:14 +0000
Message-ID:
 <SN6PR02MB4157328CAB1EBD021093DD3FD4B72@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250409000835.285105-1-romank@linux.microsoft.com>
 <20250409000835.285105-6-romank@linux.microsoft.com>
 <0eb87302-fae8-4708-aaf8-d16e836e727f@arm.com>
 <0ab2849a-5c03-4a8c-891e-3cb89b20b0e4@linux.microsoft.com>
 <67f703099f124_71fe2949e@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <67f703099f124_71fe2949e@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY8PR02MB10188:EE_
x-ms-office365-filtering-correlation-id: b87c3ce7-142a-4f6e-7470-08dd77cd4a0d
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999004|19110799003|8060799006|15080799006|8062599003|461199028|3412199025|440099028|102099032|12091999003|41001999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?PwhT/Fia8E1U9ChqRNjhYc0D4Kdv/TKebzYsECN/XuX3OQ90MjMj0s8mQFl0?=
 =?us-ascii?Q?G2NL4BqhvVf2o9MYBaKXOAwAIo7oZXbvPkifDlBYI4h9wMulaCIy3z++nYzx?=
 =?us-ascii?Q?W8X+Lk9rFz5mdVw1ipUdQ+Jjp7/I6d32wMo+xGc0Dxmyr5/qLoC1ma3HV7nz?=
 =?us-ascii?Q?tIZsb+L9e/HW15k2llnGIAcRjpKbzngfG5fGQlQcKB6un15fsiKpfvkidVxy?=
 =?us-ascii?Q?8fi+Hzxr2efe68oy6199EfPuGnCL63GtYZaFkxfwiVf7kQaQaLBf+ncSVidq?=
 =?us-ascii?Q?P8DLtHw+Zn4TvuxEdqZ+Kw75JUO8Wu59GlEPXv5Ecv0rktbAPbK7rRXvELZw?=
 =?us-ascii?Q?BE6pHl7kpIvJj5ADijwvtFmc0gI7bX6G/ltxixINPgxgvtObNAH2FkLZZydD?=
 =?us-ascii?Q?QGgHPZBA6eatx9UrQIa3B+RcHXKu4toYdE6+TnDOuiEbCfRFSadNyKv85ggx?=
 =?us-ascii?Q?+WB44LLXB9CwDdiOi3tEdEnvGPtx1HI6jtZZb7cTIQT2cRSqm65OTA8PcjME?=
 =?us-ascii?Q?gVfOWsJYwW+yuvgoyLccXuuur/+mYQC2QHa1IUeOAxMcIjLwTLxVdAXpDXrX?=
 =?us-ascii?Q?2zNTCRA+kR4Nizi2kgOp3svmKd6WmtQzvYM9J4XQMiGzQ5x6BOD7a54ym+i3?=
 =?us-ascii?Q?ZxP/UTAGmCfZjKLOYv5DsUuBXTAMH04iaDQ5hWM7T/Ec/ZIa89BmlyTq0NbL?=
 =?us-ascii?Q?P2Gf+mZWrumVQeYUl85jKyWLLlfMv/VcOg5LLINoyU71QcHsBaP7o/og/pYr?=
 =?us-ascii?Q?EZo8SJR1/xbtWJ/YExiQgpwLcP2RhgwpYOk0Ov/lvBiz4G7QJtucOGxygka3?=
 =?us-ascii?Q?CommPqHfFDic1n/AKACGP7+ryxaOiA0Dvxr4Qo5m3L4nSpUGgBxRTVKvZS+5?=
 =?us-ascii?Q?9cS4uuAQT8rvncWIvHX+PZxEltWdPtbbPJ07gd/R0qn+3DxUv6GYfPEF+tpH?=
 =?us-ascii?Q?lJUafXsb7Jhs8i+pCcLgcQfJNq1PyVhkizd9/AHPa7iMSXEq7Wb8p8wwoCOy?=
 =?us-ascii?Q?WyAuGHZ9+D7S9Lc2krzp9ZNP55+AxtcpJnXYdGb/Y1RCeMxBPw3tlDM9Gi8w?=
 =?us-ascii?Q?EKwD2ksl2iypypFj3HiTVu9MLg2Et0uXxDWHnawNbELogU0yaMtj7e+4rs02?=
 =?us-ascii?Q?WTa9AXFCqltytWUhMXj/L8LhP1sSJ6nuzevhBnfA/iFZr5gCVBECpYE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?A6+vKqkKYS6vsuywgRRj1BjJwmC1LUQzu38UEzsPfdKavvuqBwUIWPHbid3x?=
 =?us-ascii?Q?Olfk7HGKKzHFmcOBNqgIo9FM52tlMJ6CiNtAt8oVhm/mBvywPAa8aJe4gxvR?=
 =?us-ascii?Q?/NuAoY6ylNNc75kOcFwDsBuAPdO7k2d/MxTLq7xkL52sDMiykkYcsgWRP86m?=
 =?us-ascii?Q?a9mRW27nAd6YjyOBhdvdgl4tIIR3KkTnvqSfngG6gtsUzBnfkjXUjU5iYL0j?=
 =?us-ascii?Q?9ouVI0w6nYl4sdy3tVQ2hLJMMZjT3S034oHkFj6jd7aHsQNeKG40FNU7YGl6?=
 =?us-ascii?Q?yiocbnqXJTbJx+EV+IqKdPjBuYj5+hh2zx6+3T3hbdTSCTiuiwPhFT5KaLjh?=
 =?us-ascii?Q?tsltZLHCgF6k1BBS/uHz8Nalp2nJgDTjaZp3m5tP5eQ6nezLilAkd6gk53iV?=
 =?us-ascii?Q?5NMhJ3YRdzAOmkbLQuXwRsj/nlqMpSKfmNyQDNfQNCh6+z63pYk587/7ppod?=
 =?us-ascii?Q?1wgdIvZ+snQocc4+qGUy1CdlNCk9SYQLiJ1B+AhHO25Z4BZthUHUv4VwADDC?=
 =?us-ascii?Q?Zi4AjRVlSLBMqiw32G+0fiFIY0nth1xhx0PFkc3SITWvv8k8v1KlVf7ZtwVh?=
 =?us-ascii?Q?PZnRoVoOC8qiHAXraBw0Ck1pfBALuBNlr6gNuzYmV7dFbxK1i2KgjxlS52vf?=
 =?us-ascii?Q?LK+8wOD9T7STg5MgJE9pUGMAuO/OSl2+C76+jIggf88gO2wMjKZlXj3ncj0G?=
 =?us-ascii?Q?8NDrB7Y5E1hqRdbZfKJYybJXP45qF0lsvAe4fG8g1nOLjSyc+XtA1SD5i89t?=
 =?us-ascii?Q?Aq418ijrIGGzlHfboQbxUCZxqup3yh+m4qj9d5f9HbDslzVFk7lBvhkc96vj?=
 =?us-ascii?Q?1XJTmQ9e7acJAoB1ZScQ/IbmfDk6xsKcF3Xn6uiJmsvXpWmstv8X5ny2BXcV?=
 =?us-ascii?Q?mnPbAlHV69SgcIC8gJrl2pSbMkyt/OQRtTuYGcKahg5gKkTsGkhj/WnMSoPd?=
 =?us-ascii?Q?nMoNTV36RaTK1CjVe/4lltYWQSebRg171MXm/ucUajIogwk4jwiOBDlkkVvZ?=
 =?us-ascii?Q?YiswCCbILpkLZD30txSmah9E9aE+esEtnY1JrYxXhvyGAlMeRUi+Cho+RRIT?=
 =?us-ascii?Q?pWjt+RGl+xPBQSD2d+mTl58Iq42MFU0iYIX2lQDUFMWb+hJrhleU2i4pqqBa?=
 =?us-ascii?Q?8fXCs5iN2YWw1c48NenljDC67CrPKEkoT1nO51bmLr5w9xI/ZQqpdoggM5NB?=
 =?us-ascii?Q?22ZWla+xh95VGVweGDZbhKCqQGprMRpVdFLMZG9skIg8Y/OFFka4KQMbKgY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b87c3ce7-142a-4f6e-7470-08dd77cd4a0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 01:16:15.0620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB10188

From: Dan Williams <dan.j.williams@intel.com> Sent: Wednesday, April 9, 202=
5 4:30 PM
>=20
> [ add linux-coco ]
>=20
> Roman Kisel wrote:
> >
> >
> > On 4/9/2025 9:03 AM, Robin Murphy wrote:
> > > On 2025-04-09 1:08 am, Roman Kisel wrote:
> > >> Bounce-buffering makes the system spend more time copying
> > >> I/O data. When the I/O transaction take place between
> > >> a confidential and a non-confidential endpoints, there is
> > >> no other way around.
> > >>
> > >> Introduce a device bitfield to indicate that the device
> > >> doesn't need to perform bounce buffering. The capable
> > >> device may employ it to save on copying data around.
> > >
> > > It's not so much about bounce buffering, it's more fundamentally abou=
t
> > > whether the device is trusted and able to access private memory at al=
l
> > > or not. And performance is hardly the biggest concern either - if you=
 do
> > > trust a device to operate on confidential data in private memory, the=
n
> > > surely it is crucial to actively *prevent* that data ever getting int=
o
> > > shared SWIOTLB pages where anyone else could also get at it. At worst
> > > that means CoCo VMs might need an *additional* non-shared SWIOTLB to
> > > support trusted devices with addressing limitations (and/or
> > > "swiotlb=3Dforce" debugging, potentially).
> >
> > Thanks, I should've highlighted that facet most certainly!
>=20
> One would hope that no one is building a modern device with trusted I/O
> capability, *and* with a swiotlb addressing dependency. However, I agree
> that a non-shared swiotlb would be needed in such a scenario.
>=20
> Otherwise the policy around "a device should not even be allowed to
> bounce buffer any private page" is a userspace responsibility to either
> not load the driver, not release secrets to this CVM, or otherwise make
> sure the device is only ever bounce buffering private memory that does
> not contain secrets.
>=20
> > > Also whatever we do for this really wants to tie in with the nascent
> > > TDISP stuff as well, since we definitely don't want to end up with mo=
re
> > > than one notion of whether a device is in a trusted/locked/private/et=
c.
> > > vs. unlocked/shared/etc. state with respect to DMA (or indeed anythin=
g
> > > else if we can avoid it).
> >
> > Wouldn't TDISP be per-device as well? In which case, a flag would be
> > needed just as being added in this patch.
> >
> > Although, there must be a difference between a device with TDISP where
> > the flag would be the indication of the feature, and this code where th=
e
> > driver may flip that back and forth...
> >
> > Do you feel this is shoehorned in `struct device`? I couldn't find an
> > appropriate private (=3D=3D opaque pointer) part in the structure to st=
ore
> > that bit (`struct device_private` wouldn't fit the bill) and looked lik=
e
> > adding it to the struct itself would do no harm. However, my read of th=
e
> > room is that folks see that as dubious :)
> >
> > What would be your opinion on where to store that flag to tie together
> > its usage in the Hyper-V SCSI and not bounce-buffering?
>=20
> The name and location of a flag bit is not the issue, it is the common
> expectation of how and when that flag is set.
>=20
> tl;dr Linux likely needs a "private_accepted" flag for devices
>=20
> Like Christoph said, a driver really has no business opting itself into
> different DMA addressing domains. For TDISP we are also being careful to
> make sure that flipping a device from shared to private is a suitably
> violent event. This is because the Linux DMA layer does not have a
> concept of allowing a device to have mappings from two different
> addressing domains simultaneously.
>=20
> In the current TDISP proposal, a device starts in shared mode and only
> after validating all of the launch state of the CVM, device
> measurements, and a device interface report is it granted access to
> private memory. Without dumping a bunch of golden measurement data into
> the kernel that validation can really only be performed by userspace.
>=20
> Enter this vmbus proposal that wants to emulate devices with a paravisor
> that is presumably within the TCB at launch, but the kernel can not
> really trust that until a "launch state of the CVM + paravisor"
> attestation event.
>=20
> Like PCIe TDISP the capability of this device to access private memory
> is a property of the bus and the iommu. However, acceptance of the
> device into private operation is a willful policy action. It needs to
> validate not only the device provenance and state, but also the Linux
> DMA layer requirements of not holding shared or swiotlb mappings over
> the "entry into private mode operation" event.

To flesh this out the swiotlb aspect a bit, once a TDISP device has
gone private, how does it prevent the DMA layer from ever doing
bounce buffering through the swiotlb? My understanding is that
the DMA layer doesn't make any promises to not do bounce buffering.
Given the vagaries of memory alignment, perhaps add in a virtual
IOMMU, etc., it seems like a device driver can't necessarily predict
what DMA operations might result in bounce buffering. Does TDISP
anticipate needing a formal way to tell the DMA layer "don't bounce
buffer"? (and return an error instead?) Or would there be a separate
swiotlb memory pool that is private memory so that bounce buffer
could be done when necessary and still maintain confidentiality?

Just wondering if there's any thinking on this topic ...

Thanks,

Michael

