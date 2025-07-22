Return-Path: <linux-arch+bounces-12885-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6E3B0E2C2
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jul 2025 19:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97598AA38B7
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jul 2025 17:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE2E27FD4A;
	Tue, 22 Jul 2025 17:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mrEzB7Mc"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2027.outbound.protection.outlook.com [40.92.41.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191CA28134F;
	Tue, 22 Jul 2025 17:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206222; cv=fail; b=iNGEEFC+mzI4d+AGWShPS8qmsX3IYQkD0yx37kz7n59mUVVx7jnC6ynjNEJRHBcZYfEh08Hi1ldfkDqdA7JQbH3AG+4X5U53jdpwO5OFQ4WmFkX7MqQOZp5ZI1m4UgmqG6XA8/eo0yCFOWGRLCX8oEUntiwZb0eZwDbxf7UDe2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206222; c=relaxed/simple;
	bh=8Oz2RIquHhgTYWxy204aKuTY5uH3PA5ix7dGpMuZJbU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WcbL1mrtmfMWdHj35KcXRjZPJQoB9PWJhjEoXT5wyoD78NCo7VcQfmdob/t7kRo3X0blcEyZoHiQmSpInjoNsX+ZvHk9Q07V/XTk8jHMnenRhSHxHk2rdIihUk1PYHcXAlnQDgXW0gjBI91bVWUjvOnhEMG8cI46KtPhxOeEqTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mrEzB7Mc; arc=fail smtp.client-ip=40.92.41.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3g3biHkXd6clksy/PV3pYeqdInaGK1VlgrgUScWPDfx7+Kj908PFIKGEvA1KzdYpPOWCV3vgBniSvmGykLPKNpbQvBoTBO0RBwGv0+a+A9plDOJc0PQsLu9XPsjIxohvML2TkVX9jujUtkUknBlSO6+59ZtacDi+o5P8FLyDcnWOahzUCqtjpc0NPn4/K3oLIH9x4Di+A6mbXWBulcWIVh0XaK1wUzQIEnNlFDoIelZ6COQGBjqKPbGBBxiYaSLvDQPe95u2EIzU1Nw42RUumk3wzAoZFoDGoX9HIwYM+cUWYwkh8eNd8vgytPE85ZaUUnIbsPy8Ilinx8mAm4Wbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXAroItfCjp5/DSxr2qwprBjjwY7kWkhXy2qMzVFcBA=;
 b=QcaXhbymQYm6NPL+gsoY9muOSB2+Lglan1TxAjhkrJ03njd6DYZToCQn+hEC2ZIkNLUkHL62EECI1Hw6A/B/RN27CJTF3F6QlnV7VjVABmgnNVNk1nXKJ72uIG7qKbiEFLemuCJuhuWbqYwNi9mEklF+FqA6HoZmjghQprUyfXGLOfcP+pB1FcGny/sXCvxlagLxQ9zP2PU18HGLp1+MXcgZ0/f/Z49+bWH8VrIHRYpIrCZkQRvQg6k+4TA7VJgTTv3srpwaL7qpbYNT3pV0aI1w+Ln3c20nJ3Vac5CIuMeEezwkHzxcXRShJgJc7NLYHfqlC8ZvWkHeQ9bRLtx4wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXAroItfCjp5/DSxr2qwprBjjwY7kWkhXy2qMzVFcBA=;
 b=mrEzB7McUuVKFc7ScLlYBKom25IPRAvW24I+EADP5xtogcAsnWPd/4AQjLXuhVCmQL5Dc1gjlS2OuWIrNRvtmSEzy78J1H4CD5fQL5sRxaORIE7WzV73Nr8AZ/S4Pslkorko90YWuacZMtLPtY07+FolYEQxXOKIz9x8tvXrl757BpQGel3TVyghMEYKvk+jxZOZ3LZHz7lARW0yA5+SKtuIkgW90vmmrHLcekPpM+HQThEjiKWEnQ07PfdZRrleHiQrxW0zxDVPurhhVyrUfjgH8Dz0qISvhj6p9GtzlhF9ZdAgXkAKhb99nu7th9O/ZoztnCCOHfj40uCLovbSmw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW6PR02MB9816.namprd02.prod.outlook.com (2603:10b6:303:23a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Tue, 22 Jul
 2025 17:43:35 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 17:43:35 +0000
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
Subject: RE: [PATCH hyperv-next v4 02/16] drivers: hv: VMBus protocol version
 6.0
Thread-Topic: [PATCH hyperv-next v4 02/16] drivers: hv: VMBus protocol version
 6.0
Thread-Index: AQHb9QzcrvQAsjfiQEmjDkekNdPGorQ4SszQ
Date: Tue, 22 Jul 2025 17:43:35 +0000
Message-ID:
 <SN6PR02MB41578E769FA6AE670C2C2040D45CA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250714221545.5615-1-romank@linux.microsoft.com>
 <20250714221545.5615-3-romank@linux.microsoft.com>
In-Reply-To: <20250714221545.5615-3-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW6PR02MB9816:EE_
x-ms-office365-filtering-correlation-id: 50f7eec2-f45d-495d-57d3-08ddc94748bb
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|461199028|15080799012|440099028|3412199025|40105399003|12091999003|102099032|56899033;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?d+RTQywDwsjV8YMBPGkDlCmbvsGCoonnMw9pJ7rykVRBu9IL2bPuLmdkpOIx?=
 =?us-ascii?Q?wyI0drjRFmZ56V0t8aRdjO35rCUYDGB4ln4MUijTjeS59mFopgcHsHr+BgEB?=
 =?us-ascii?Q?J2bcD6iSbH5f8rztYaM/SKjh72e3TcJrE2ZqdCMCElX6ZOyHRga1tkS1JpPW?=
 =?us-ascii?Q?TzHpZ/sz+n+As8/mIisb6Htvzr0Ilvoi7C4iPBEEHv99JFJAW5/rdI21bU8N?=
 =?us-ascii?Q?9jPMMIpgzsdHBkK9eOlPBmSz155E79xS/je+iIv9UlDFrj3oMgeNvDwLWNTt?=
 =?us-ascii?Q?EAECwaA6h8Ii8rSbFVFdeqNfQMbpKTxsnfUJP8Bz5y7/bJpytvKH7RTwd6Fc?=
 =?us-ascii?Q?wSn3pq+hVt5rTeJjSfttQzgMpyVaMNkVQ5djLeFXPL9TPBzLpPsnGb41Woc5?=
 =?us-ascii?Q?7J/vdOJzjzClM/UyDniJU645XShKVTzHQtAHxKxGjTsMZJurGDWYnjDkaYlI?=
 =?us-ascii?Q?OkeT+ZIqGvh5jL/9LpWLMMdGbcY7tljPHYHn0PWVrvuKtQ3Q/zqLAkJUos59?=
 =?us-ascii?Q?sdkA11vxVRhanaiMLGHzXPxQPhrTSTLMIO1A1rQNG215Duk8r7n8eHIcUKkY?=
 =?us-ascii?Q?5N1Oy+zESNGdoMTogJsMXrDgiviXZzQKqs1mHEN+5HfFdnEeWPPYgP0wYJG5?=
 =?us-ascii?Q?H0YHLqBQLrCC9zMuUguMKBaNDi5BA6aJBM1hKeQ+ZTfJPl5lgkp79rpariKU?=
 =?us-ascii?Q?p/9MTiEaZNtGYoEkfagF4WzbDWYeGAcicQfEd5JLg0k13Nl7Itol22fnoXwl?=
 =?us-ascii?Q?2ihswmH3gDXKM2uFIZQA/6cpEewZvQS0oM/pNZ/b/0lWrxLP9++s6DkyNvZA?=
 =?us-ascii?Q?arOZiJxVcbfY3VLjavdAL+6yX547wADWR268D0yzntOnGBCaj1XcGzqufQt2?=
 =?us-ascii?Q?iZs+tvrcCdqlzQPIow8TigWgv/a5+PKWvhQtUxb7Kl+Jrc0GqTzeGwSjGBsW?=
 =?us-ascii?Q?emNn5EWsOqjDiW2q5Tehzqt7krdZkGKFJ+FXWsKl2mrowzZ8Rs7wCflboYJL?=
 =?us-ascii?Q?aERl0YEhZoPUqZh+9SHbmsbOfp+uzVGu9utMXg3dumktIJvBcJS2jdJK3sHz?=
 =?us-ascii?Q?y8z9XF9zx8q/gnRDh9Bgvzw7NRfdUA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4C4u33NDR2aFkQmNw29IeRYXbnErHXqDxQDsCeMVBusOHih11eHDF9BGN36a?=
 =?us-ascii?Q?PyhLQXWEHEoyymepGhSbAllb6bekPSI2TrSgKbQEL3oPJfzPPwTuTVrsWS0m?=
 =?us-ascii?Q?B2ITdMUfIQPiSW8XU7AB75WmbHeMdhIytKLT5/+dbcF766JLu6/MIxhABElJ?=
 =?us-ascii?Q?7Mc30MZX+oCdziU1dpIzl+mSBBDWw7VkIyyPxWz1RCuTnhqRU89DegyNklHG?=
 =?us-ascii?Q?IK1z+BKUaJbPzqPLazoD2nfqVey6QOD2HliUNyhyN63HgY9yqLSnhKocll3f?=
 =?us-ascii?Q?lxSjcGVqBG8olMeThRJsi4eEUDUAIax1l7Ee+8743vBA5niE8c9yCw4E55mT?=
 =?us-ascii?Q?5G7ZiQSz8JC1ipiIGdmaEOlQoqI/IXqHVdqFhK5fTUX1fUBfCNjGXy46Yf1s?=
 =?us-ascii?Q?l55lzKZ8kVsYOxTxP+Ml2OSxz2mz3NEVpN6V+YaZHIGiYuOEyx35E+0qCAt3?=
 =?us-ascii?Q?pg6JzqIdsf8vV2Ji8e/poDPc2KH9OuYbbWPoFGRnnoTBiWiiypoZ/XQva7Lo?=
 =?us-ascii?Q?otM2eRSKmVd3i6ZOPR6OtCR7mQigIsYMujGeQfwL5uyTLTEDmKJfaGH2iOsH?=
 =?us-ascii?Q?9Q25BF4vUD/C3Q0KuqEQ1eHWTdFN6vQLQ3jULzm2EuWO1CILWljPuxfog1Yr?=
 =?us-ascii?Q?8V9eVsLx0KSIzuouDfD89QlT9Ic24SJgDH/wtHB+fnATjfT7zOcIDgjybfDO?=
 =?us-ascii?Q?C5JGtvc9a/SDX+xnyO2NvRR61S9CsrBja9yp4aLlnejmNjuYsr1ySD6AQRAU?=
 =?us-ascii?Q?0+X6OPUZ95MS10wuG145Yh9qI+d/xci4RWvEdQVJlkMh3gdFaXrTFq4C/Tky?=
 =?us-ascii?Q?mcSsAbFFGv+5CxvSyS4bg750KpSqSr6D7xscrJ5twTwmhrLly/Lk5DcQCI46?=
 =?us-ascii?Q?3lfTT1htr4tcrrkysssAI7EBrukg40KWATAOiBCMOSbM15C0Ue/PbrJ8GxXo?=
 =?us-ascii?Q?Q8Zg/eVmQYGiyNeDgzTjGmR/JoFL3Nt9KIFtgeJdZu8LoNkQWrxUFZ6LSyaK?=
 =?us-ascii?Q?xuJNtlzT7eMRFZHUF3JhtJSihBwKLEuQ3cNQkru+m0BeLgeLNPK1KSMozuvy?=
 =?us-ascii?Q?muuuxkMOX+DbUWmplfbFihemerjqn/qeskYH3WkPPgFOjVlwpBEOQlxShihL?=
 =?us-ascii?Q?HQ5OeFTEDaoGb8+tMVPD6HuYydhRhjMfMgewgDUBYi0K9SxQRFRVZKAtZtGD?=
 =?us-ascii?Q?GWta92/BJoiEZnhyp2zIxOaq7/gXUJgtnzOg6imkQcPJutYy/OOQzJaVE+Y?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f7eec2-f45d-495d-57d3-08ddc94748bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 17:43:35.5816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9816

From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, July 14, 2025 =
3:16 PM
>=20
> The confidential VMBus is supported starting from the protocol
> version 6.0 onwards.
>=20
> Update the relevant definitions, and provide a function that returns
> whether VMBus is confidential or not. No functional changes.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  drivers/hv/vmbus_drv.c         | 12 ++++++
>  include/asm-generic/mshyperv.h |  1 +
>  include/linux/hyperv.h         | 69 ++++++++++++++++++++++++----------
>  3 files changed, 63 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 33b524b4eb5e..698c86c4ef03 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -56,6 +56,18 @@ static long __percpu *vmbus_evt;
>  int vmbus_irq;
>  int vmbus_interrupt;
>=20
> +/*
> + * If the Confidential VMBus is used, the data on the "wire" is not
> + * visible to either the host or the hypervisor.
> + */
> +static bool is_confidential;
> +
> +bool vmbus_is_confidential(void)
> +{
> +	return is_confidential;
> +}
> +EXPORT_SYMBOL_GPL(vmbus_is_confidential);
> +
>  /*
>   * The panic notifier below is responsible solely for unloading the
>   * vmbus connection, which is necessary in a panic event.
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index a729b77983fa..9722934a8332 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -373,6 +373,7 @@ static inline int hv_call_create_vp(int node, u64 par=
tition_id, u32 vp_index, u3
>  	return -EOPNOTSUPP;
>  }
>  #endif /* CONFIG_MSHV_ROOT */
> +bool vmbus_is_confidential(void);
>=20
>  #if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
>  u8 __init get_vtl(void);
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index a59c5c3e95fb..a1820fabbfc0 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -265,16 +265,18 @@ static inline u32 hv_get_avail_to_write_percent(
>   * Linux kernel.
>   */
>=20
> -#define VERSION_WS2008  ((0 << 16) | (13))
> -#define VERSION_WIN7    ((1 << 16) | (1))
> -#define VERSION_WIN8    ((2 << 16) | (4))
> -#define VERSION_WIN8_1    ((3 << 16) | (0))
> -#define VERSION_WIN10 ((4 << 16) | (0))
> -#define VERSION_WIN10_V4_1 ((4 << 16) | (1))
> -#define VERSION_WIN10_V5 ((5 << 16) | (0))
> -#define VERSION_WIN10_V5_1 ((5 << 16) | (1))
> -#define VERSION_WIN10_V5_2 ((5 << 16) | (2))
> -#define VERSION_WIN10_V5_3 ((5 << 16) | (3))
> +#define VMBUS_MAKE_VERSION(MAJ, MIN)	((((u32)MAJ) << 16) | (MIN))
> +#define VERSION_WS2008
> 	VMBUS_MAKE_VERSION(0, 13)
> +#define VERSION_WIN7
> 	VMBUS_MAKE_VERSION(1, 1)
> +#define VERSION_WIN8
> 	VMBUS_MAKE_VERSION(2, 4)
> +#define VERSION_WIN8_1
> 	VMBUS_MAKE_VERSION(3, 0)
> +#define VERSION_WIN10
> 	VMBUS_MAKE_VERSION(4, 0)
> +#define VERSION_WIN10_V4_1
> 	VMBUS_MAKE_VERSION(4, 1)
> +#define VERSION_WIN10_V5				VMBUS_MAKE_VERSION(5, 0)
> +#define VERSION_WIN10_V5_1
> 	VMBUS_MAKE_VERSION(5, 1)
> +#define VERSION_WIN10_V5_2
> 	VMBUS_MAKE_VERSION(5, 2)
> +#define VERSION_WIN10_V5_3
> 	VMBUS_MAKE_VERSION(5, 3)
> +#define VERSION_WIN10_V6_0
> 	VMBUS_MAKE_VERSION(6, 0)
>=20
>  /* Make maximum size of pipe payload of 16K */
>  #define MAX_PIPE_DATA_PAYLOAD		(sizeof(u8) * 16384)
> @@ -335,14 +337,22 @@ struct vmbus_channel_offer {
>  } __packed;
>=20
>  /* Server Flags */
> -#define VMBUS_CHANNEL_ENUMERATE_DEVICE_INTERFACE	1
> -#define VMBUS_CHANNEL_SERVER_SUPPORTS_TRANSFER_PAGES	2
> -#define VMBUS_CHANNEL_SERVER_SUPPORTS_GPADLS		4
> -#define VMBUS_CHANNEL_NAMED_PIPE_MODE			0x10
> -#define VMBUS_CHANNEL_LOOPBACK_OFFER			0x100
> -#define VMBUS_CHANNEL_PARENT_OFFER			0x200
> -#define VMBUS_CHANNEL_REQUEST_MONITORED_NOTIFICATION	0x400
> -#define VMBUS_CHANNEL_TLNPI_PROVIDER_OFFER		0x2000
> +#define VMBUS_CHANNEL_ENUMERATE_DEVICE_INTERFACE		0x0001
> +/*
> + * This flag indicates that the channel is offered by the paravisor, and=
 must
> + * use encrypted memory for the channel ring buffer.
> + */
> +#define VMBUS_CHANNEL_CONFIDENTIAL_RING_BUFFER			0x0002
> +/*
> + * This flag indicates that the channel is offered by the paravisor, and=
 must
> + * use encrypted memory for GPA direct packets and additional GPADLs.
> + */
> +#define VMBUS_CHANNEL_CONFIDENTIAL_EXTERNAL_MEMORY		0x0004
> +#define VMBUS_CHANNEL_NAMED_PIPE_MODE
> 	0x0010
> +#define VMBUS_CHANNEL_LOOPBACK_OFFER
> 	0x0100
> +#define VMBUS_CHANNEL_PARENT_OFFER
> 	0x0200
> +#define VMBUS_CHANNEL_REQUEST_MONITORED_NOTIFICATION	0x0400
> +#define VMBUS_CHANNEL_TLNPI_PROVIDER_OFFER				0x2000
>=20
>  struct vmpacket_descriptor {
>  	u16 type;
> @@ -621,6 +631,12 @@ struct vmbus_channel_relid_released {
>  	u32 child_relid;
>  } __packed;
>=20
> +/*
> + * Used by the paravisor only, means that the encrypted ring buffers and
> + * the encrypted external memory are supported
> + */
> +#define VMBUS_FEATURE_FLAG_CONFIDENTIAL_CHANNELS	0x10
> +
>  struct vmbus_channel_initiate_contact {
>  	struct vmbus_channel_message_header header;
>  	u32 vmbus_version_requested;
> @@ -630,7 +646,8 @@ struct vmbus_channel_initiate_contact {
>  		struct {
>  			u8	msg_sint;
>  			u8	msg_vtl;
> -			u8	reserved[6];
> +			u8	reserved[2];
> +			u32 feature_flags; /* VMBus version 6.0 */
>  		};
>  	};
>  	u64 monitor_page1;
> @@ -1008,6 +1025,10 @@ struct vmbus_channel {
>=20
>  	/* boolean to control visibility of sysfs for ring buffer */
>  	bool ring_sysfs_visible;
> +	/* The ring buffer is encrypted */
> +	bool co_ring_buffer;
> +	/* The external memory is encrypted */
> +	bool co_external_memory;
>  };
>=20
>  #define lock_requestor(channel, flags)					\
> @@ -1032,6 +1053,16 @@ u64 vmbus_request_addr_match(struct vmbus_channel =
*channel, u64 trans_id,
>  			     u64 rqst_addr);
>  u64 vmbus_request_addr(struct vmbus_channel *channel, u64 trans_id);
>=20
> +static inline bool is_co_ring_buffer(const struct vmbus_channel_offer_ch=
annel *o)
> +{
> +	return !!(o->offer.chn_flags & VMBUS_CHANNEL_CONFIDENTIAL_RING_BUFFER);
> +}
> +
> +static inline bool is_co_external_memory(const struct vmbus_channel_offe=
r_channel *o)
> +{
> +	return !!(o->offer.chn_flags & VMBUS_CHANNEL_CONFIDENTIAL_EXTERNAL_MEMO=
RY);
> +}
> +
>  static inline bool is_hvsock_offer(const struct vmbus_channel_offer_chan=
nel *o)
>  {
>  	return !!(o->offer.chn_flags & VMBUS_CHANNEL_TLNPI_PROVIDER_OFFER);
> --
> 2.43.0


