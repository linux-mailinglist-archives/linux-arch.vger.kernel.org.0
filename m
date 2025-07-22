Return-Path: <linux-arch+bounces-12884-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 323B5B0E2BF
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jul 2025 19:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E3ECAA0721
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jul 2025 17:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C3427E7DF;
	Tue, 22 Jul 2025 17:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gZaQ0SM5"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2109.outbound.protection.outlook.com [40.92.22.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F201422DD;
	Tue, 22 Jul 2025 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206213; cv=fail; b=LSYFcZnOOMkTjo5Zki6EV6hA0/JLtk2Bs0Ywq+cNUxGUcyfnIh24mY6C3bgA5bipnx5fuws1g/ZeK+yqaDkxkV0ii2c/4KfM/a0Or4QoB5r2B3oRyELEeDiMhTHvYnfNEfTnhlbfv3mmvcdjr1G1HDwXR/srrAuwlEd8d2IBvcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206213; c=relaxed/simple;
	bh=TYY+nhE373DCPxPex4+4tw9dpNp99JI0Or2pt27/Gxc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kR/EcQDPjS/MjF5I/aCWdPDp0ut/NTx+8UhnSLZBGzPgkw4PGDlfX+U4/nu6b40MpygRpub+0a1oZrcYiftboG+iu5igd0bfdIFnIoA+FLssUvDlHAovLPlWaZk1qIEuxrN56OLTiYzu5znnooXVEGikFsagxBWU3FWzJe65QnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gZaQ0SM5; arc=fail smtp.client-ip=40.92.22.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d0txruP0/eToj5Sy2hkl3ILKsus2p6oVLtCggmRqc8V/lrYgLfqz1TQipSx5fv5IRuciGKWjHhbzhagr31lmrLeq5id4mvztb5hZBg8YKnvBvjK0Yn7AMWv8rrjFPRxpoajyCbvUg9V75/0gsVJlfRQQOOSizPoPIyTp2OMFMl8iQU9Ig6eXeZTeqehyLZc3V7f1cy9TLvtln/V00YbLFqITlAkvEAJ0F2h5HlnsB6QHDwKSO3fLHZTa3QfxvZid1AXpeLhJvffcNblL0sI3hBqkH3F4weMJtSo18/XYfirZQJOLdB+naF+0Ur0135/uWX80Ys8ROS1gFq37vvNICQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvcTcaLeAswSeE2LWXptrUZTz7V6xUX5AXPUy1u61AA=;
 b=caHV4V9YVXHZnXqGarQ+SnQ6P0qHHD4vNnFWUbixoY0Zos5HIHqxdisBfRn6Yrnvk9sD35PGSMq/Zn7DwEGdRuo/nklJdYfWtp6EDLMoyX3r1akTA4ZyVG841S6ctNNQ3IwPBjhvCa5F0KRvWZoxtovZwRpwGeqaIClVMshl6Pfmbmaaagj1QzOhPJgR8D75/o6JcLbxd0azN1Zbc6R//B14IsqaCC/RBCdP8OmT4Z2mmBgwPuLS8nCKjTgG3/jD6uXebG5Px2HXK1bEIsiYW4qEWVdOg/qjpo0HSFhOrKWI00h5xLY7WMVszYRnINbkb+Ygyir6V2/XNbfKDlHnvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvcTcaLeAswSeE2LWXptrUZTz7V6xUX5AXPUy1u61AA=;
 b=gZaQ0SM5ttbNqDEcF8HazlR6FYuHB1JTTuub+9587hkODF4a/rvRuwt97Zv26XX3otER1/MSK6vJQeOowjSX8jjfJBvslX6dav9FY+rKoPKvMENsHrORV7Ie/1l/Xyi36edwbaLPPV+WArn9GAY8Y23HzM9+dZVO5QJ6cjQeeL8GZywQTuMUS0J8MLgKwVB4jMW7z5AZtkUldMNZydtDsVDxjd8IHotGPU92lcrnL098funbVv/jrn2irajJsvi8g1cQ61bhNCyRgcu//pL0kjUyNNEXX5znd0yyI0DUDEjtfJAUTa8PfVVBgHueP1ABFWadD01zyTfT6q1ueOCHMw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW6PR02MB9816.namprd02.prod.outlook.com (2603:10b6:303:23a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Tue, 22 Jul
 2025 17:43:26 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 17:43:26 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "alok.a.tiwari@oracle.com"
	<alok.a.tiwari@oracle.com>, "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de"
	<bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "Tianyu.Lan@microsoft.com"
	<Tianyu.Lan@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v4 01/16] Documentation: hyperv: Confidential
 VMBus
Thread-Topic: [PATCH hyperv-next v4 01/16] Documentation: hyperv: Confidential
 VMBus
Thread-Index: AQHb9QzbCImg4EnLlEehEtqbQEpYTLQ4Rc+w
Date: Tue, 22 Jul 2025 17:43:26 +0000
Message-ID:
 <SN6PR02MB41576579D0A53239690DA57ED45CA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250714221545.5615-1-romank@linux.microsoft.com>
 <20250714221545.5615-2-romank@linux.microsoft.com>
In-Reply-To: <20250714221545.5615-2-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW6PR02MB9816:EE_
x-ms-office365-filtering-correlation-id: 57351865-19c8-468f-cafa-08ddc9474318
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799012|440099028|3412199025|52005399003|40105399003|102099032|56899033;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fL12CW2JNli/CDdIMfUzD597tA+RNgxBloF9mEu37wL2b+TaxzD4og5FG+Xe?=
 =?us-ascii?Q?GqHodN6ZgbgnbUc1QCqtRGzAziGWrK5gHzRWcHEHvweuAk6D8wtAkup0GJzO?=
 =?us-ascii?Q?2z6g6Ra54O6aTqyMwpx05eKam9hYsqiXc2uzGRxCaBjcVch8YNM8TUrvvW6P?=
 =?us-ascii?Q?8dF2tjtaTgEcoMViZtb0ctjSF3cPN0zBwSAzc/iwuEPefdL5mdXHKxx+lY++?=
 =?us-ascii?Q?eEur1t++BrPJwJVYLCtdEBPTNz/kB+/gXGV16v27x4xe+DrIxm1B1RifjDUW?=
 =?us-ascii?Q?0Zui9gza3CNEfLb09LZNiKVLGvAS3oWBTEoYHu6IBp+w3g/8mdQKHBf4FWo4?=
 =?us-ascii?Q?/SOOOhykMC5yt/aTZWCDkFk4Cx26TK8eKe02tjUAUN6baQmkFMbY+8+lxFbf?=
 =?us-ascii?Q?iU8lofb8cRBZDJy5Kapp8h758NoDS/f79lEyHH0teFm0ZDdP7rjuY3ZreeaG?=
 =?us-ascii?Q?ncY503cyjuCymXnAdr6BwADUCvYx1OKndToNh7HqcQgegD8+TUlsjmWUCvaZ?=
 =?us-ascii?Q?pdu2E+0K+3GaeY8Xv4mXElYSkyr3B4EhbeysCM2VpyJiF9s1lZngGFZyhcar?=
 =?us-ascii?Q?Fpsc6kpPhYATy9vZu97eVcfdyXSQQTkwharvkGF9i0Pzzki3VJ9ttBmiLMBF?=
 =?us-ascii?Q?gwVuiCYlmQV9UYc/n019zssRvvM7e3+CtHonDILSa1h7YViC4fHgsIfb6wSz?=
 =?us-ascii?Q?nKKpZpZ5VNhYjBPVo2pI6ec8Dck+bel3yU9VF3bYE6iOqU6j9qrSJEOkQBfc?=
 =?us-ascii?Q?VPClnEFE6A9BLstVUivB0jiy6BHKn8bDltbytIXiXTBWCYnD6ZX+OPizEjaW?=
 =?us-ascii?Q?LCCITVI9wN62X8/sCvVzZAs8aKeVK4N8VB8+WVMkXAN4HzR+ZpjcGG41Nwnd?=
 =?us-ascii?Q?lXKJ/nocA4ufHuL7bprya6TAodN/sAHipTT1a/evoJy001V688sOYZF1t3wH?=
 =?us-ascii?Q?GZZ0hr3fJ9dJi3Dk5JdN7sRKVcj43Octx0Mksempdy8Uq3dI0Jk3UIOJfhFu?=
 =?us-ascii?Q?+xRIU514lIbAVT849+CSahlem5Vxg3A/S7jBa+d8hQVHFHX4Wg62tHqQV8Xw?=
 =?us-ascii?Q?WWa3FFCM?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uQgbfuNzBTChm+AMXumUY8AlXoy2qkpKSrGbFsl2bYMe7BS2iCC903NnBGg6?=
 =?us-ascii?Q?xnuyO6TB4atngpY9WbqOz9DWfoGe1vJhyXan8+eOugs3+daMPCEYop1zKYuL?=
 =?us-ascii?Q?3WDVQzwrLPPHvV+n4WqX+WtzX0dkPTf+lFy5HT2nDx0SmmA2a8v+ly153/IU?=
 =?us-ascii?Q?zF6XK9jpGW0YJCbJXWZQ9+qRpyRyNLrRRZoHLEhvRcJBvsgZTS9y6b4csiT/?=
 =?us-ascii?Q?mBJKWUL7JZqixCjKo2k1oJcp5jX9a7tBlOekPN0Y4N8FMjyR4rxGz1ZAaUVU?=
 =?us-ascii?Q?vYjYoqNM9Q4UDEkvS98hu1segtmhnrvebck3HHotJKeEFVs9MyhrOFlLf3Cf?=
 =?us-ascii?Q?DAIIgP/7uZEuHHCkyYNaKQROSY8AhvCWOTzlZfv035bfk2S1Jt6Kc8CIOD8O?=
 =?us-ascii?Q?fvnY5CRRtwf0DHEJ4deE7Eb3aaRnnPH1iLMtN4CiN3SKbzbEAf03nlLgGHmH?=
 =?us-ascii?Q?5f4k23U/5OMYPcBLtJvvs+MTpus9EJdKItNkrAY6xnUvmRalTduX5HNq1dFe?=
 =?us-ascii?Q?PwyiGMyqf81HcdXgvkfaHXtI0OFmBpWk0b1EOBMbHt7nZw3zjy96vhZlE2gy?=
 =?us-ascii?Q?PK+Z3oAPV17bEjvJjn3uW8l+mhspIpSzQOMM3//1K5W7rMBAsgc8pfuKcNJp?=
 =?us-ascii?Q?6zgsy1IIRBUVlSEgF1ge9NYeGccynsmrk4Hp4UMiN2uR35sLJNtWqd3WQf8m?=
 =?us-ascii?Q?vlmog2dlnzojL4Lj59ZQrvaz9WFVXMW3rBsIRQOKfxZV5MmSzJ5dKImDDP1p?=
 =?us-ascii?Q?ZEQuLeDgwj7vDDF511DSBPWiqIN0/fPI5sLIUZ7zvJYrk3EiUnK+VjPAW8Uc?=
 =?us-ascii?Q?uCnO8JUeSl2utXwIl3uBw6jGDOp/NePpcsR367GCdaw6N3v1PXHZA+W4aENF?=
 =?us-ascii?Q?oEtW0umcKXtQNfLqb2yEZ06OHmhF4nwyJJ5NJ4R/9FMtTo+ogjm3pEy9rM7I?=
 =?us-ascii?Q?caZt6kgfuPP+JwjjfZKZ16vVNwkpIK+giXbFCIkhkydvJGMQG9Fkesuwe8/G?=
 =?us-ascii?Q?PdbRb6AL5VrlHTyy0KfKVd14bNPHkeXRsVtCBdsJGpwG0aHVXTT+TsPX+A1G?=
 =?us-ascii?Q?SM7cx6hrd7Q8veOhxj5JCjexyCsbgOcL7lKKtjF96w0hc4n/GAhCBZh80MWu?=
 =?us-ascii?Q?z8jqD7tPr+sLBR73sDh5unOrVI3hCmcYBghpp9RvkhK0+JPLG3C0Z2HYKkCj?=
 =?us-ascii?Q?uncVtSGvGfx5NuC3Prtin40IL3wz0yjOw8WCIG3GWQHWfF7XLDKLY7CE+1w?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 57351865-19c8-468f-cafa-08ddc9474318
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 17:43:26.1501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9816

From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, July 14, 2025 =
3:16 PM
>=20
> Define what the confidential VMBus is and describe what advantages
> it offers on the capable hardware.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Overall, this version looks good. I'm good with the overall
characterization of the scenarios where Confidential VMBus is
beneficial, and with the overview of how it works.

I've noted one nit below. But otherwise,
Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  Documentation/virt/hyperv/coco.rst | 140 ++++++++++++++++++++++++++++-
>  1 file changed, 139 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/virt/hyperv/coco.rst b/Documentation/virt/hype=
rv/coco.rst
> index c15d6fe34b4e..e8515acfe306 100644
> --- a/Documentation/virt/hyperv/coco.rst
> +++ b/Documentation/virt/hyperv/coco.rst

[snip]

> +
> +The data won't ever leave the VM when a device is attached to VTL2, and =
the

Two things:

1) At face value, saying "the data won't ever leave the VM" is counter to w=
hat I/O
is supposed to be doing -- the data leaves the VM to go to the device! I gu=
ess the
wording here struck me as funny. :-)

2) Being more precise about "attached to VTL2" would be helpful. This speci=
fically
means a vPCI device assigned to VTL2.

I'd suggest something like:

The data is transferred directly between the VM and a vPCI device (a.k.a. a=
 PCI
pass-thru device) that is directly assigned to VTL2 and that supports encry=
pted
memory. In such a case, neither the host partition nor the hypervisor has a=
ny
access to the data.

You could even include a link to the documentation topic on Hyper-V vPCI de=
vices.

> +device supports encrypted memory. Therefore, neither the host partition =
nor the
> +hypervisor can access the data being processed at all. The guest needs t=
o
> +establish a VMBus connection only with the paravisor for the channels th=
at
> +process sensitive data, and the paravisor abstracts the details of
> +communicating with the specific devices away providing the guest with th=
e
> +well-established VSP (Virtual Service Provider) interface that has had s=
upport
> +in the Hyper-V drivers for a decade.
> +

