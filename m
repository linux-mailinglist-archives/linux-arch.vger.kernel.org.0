Return-Path: <linux-arch+bounces-10567-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A0FA56EF6
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 18:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B1E616FEF4
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 17:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E90823FC54;
	Fri,  7 Mar 2025 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HxVVmHj2"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2012.outbound.protection.outlook.com [40.92.21.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2241C14293;
	Fri,  7 Mar 2025 17:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741368406; cv=fail; b=AMUbxdwtI4O7FuRxBFUG5/d45Jb38f3X4TUp5SEYwtbJZIJBJ6q87W51w+TpogMklJPSPW+NVl6BNwd3wdOooKn6xtNOCZZj7njA4T/ZWhCjHm1OxZ+qDXcU81TSG68aMMzHobtqz7/IPcYE6XHr8zD//4LrnnYlB8WKUeRmh9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741368406; c=relaxed/simple;
	bh=Bi1VuVo4cOF45Z3IXwWmoh5wkZbnRIEOcCQp2hr1h3o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hSixEuw/nv9J6Q2dq1EgZ40XLGpAaER6xBmEih9z1Wb4TggRA1h+oQrCgkO4xNXcTshDAeLaVQRQVYxOw9f5/WKXcSv7n1r7o7LH9XiTRTXLBQu1eKKWMiKdnRRWJoLupXmpS/7CVlelIsXXHY+rNPpMbIjVSnB49OPz78hHhts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=HxVVmHj2; arc=fail smtp.client-ip=40.92.21.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJjPYPUKoZaCiH0L4hfUt4MrvyTIh4ZMSOUffORFcFieUZ97UzotE5brCm2fYTmP1Wah2jExQqd/sYlFZNhiL4CLU9kDeBXCj/tjYavYB4AcW4gipOo7GCVTwY/Mlz7iViGy+Uzee35pPdGbR+k08kJeD/lYWDfNM/tbNozqFGvOdp8Y3Q1dvqTfIyH1D+V4P11VRGDfpLXDEI5HLuoC9em75uutBW3zddlvxss/WaQlA2CrAipkks6orwVEmaaNCOViinvJP8JlNe5RatX9nA7uAQK1Z1kKxcOUhUhOKmxiuTvZUBwr3y++65Y1D0+YL+MbHKJePQJdAmQn/3QE9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXnamhW9CMD9sYPSvP5GXAVubGI4f/f56OeRktBx+iU=;
 b=xFbwwZdEb8psvok8jQuka1IY4Tt6Yd5sT5o23ZpyzpqtOVkXWFCQLcsMS6NcYE6Pv9XLP61r6BS1t6QY3mYdoR2po6bQ6KlYvMEUeThekEss2LIdvvdpsYtM2ecgTTEOyJopGwkWikduil10KB5e09jx6GR+iqIlvFxDMbHKTz7Nx+KPcT2fw5R8kjDCtln5ik6xXWHfwN4wz6DcLTOC+a05HQ/kgB+ctjcd3ua3sn+uU6Ymk+70zE54as6oCY7ldwNvvMZWD/A72pqPLz4u/UoGKhkZetq/lW+aVwGDvPlouN/RvPe9wT1R0yX3xgIWB7TcS1aTuKJKWz8/s50mVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXnamhW9CMD9sYPSvP5GXAVubGI4f/f56OeRktBx+iU=;
 b=HxVVmHj2N/jMG3CiiFsLNxrQ9tQnXcBn6mCFDhlAjz+vcweTGLXhA7+q0txDdiLZIdGioGQT2YY40CkxEzHRL+g2JG1rzjPZGebEjMHnr8DJUiHCkAX5CggWEiBfR3Gbyaix0NDFjSSwJYqRajh8mKMYoi5TRuGSaX9pK9IF90S+3HgaW2pE0NvNfLIfZOPknWeknlMT72l4RIAHqOGzhiMGWbBqqQpDdsBEpg3pK5EeOsA2W2/VKcdp0T8ykjBwaGsjB5W8Zrz2aqKAkn8EYPRYUKynwMDnS0F4iNjCOQHAftd3R6xK0+KcJl6N4EnzZ8PMroPvt6FJ1Mso29GdHg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BL0PR02MB6546.namprd02.prod.outlook.com (2603:10b6:208:1cc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 17:26:39 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 17:26:39 +0000
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
Subject: RE: [PATCH v5 09/10] hyperv: Add definitions for root partition
 driver to hv headers
Thread-Topic: [PATCH v5 09/10] hyperv: Add definitions for root partition
 driver to hv headers
Thread-Index: AQHbiKNujfpOKLhVUE6AMyvtUkdPaLNn9IxQ
Date: Fri, 7 Mar 2025 17:26:39 +0000
Message-ID:
 <SN6PR02MB41575301E96B82BF3813828BD4D52@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-10-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1740611284-27506-10-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BL0PR02MB6546:EE_
x-ms-office365-filtering-correlation-id: a234fe86-b59a-4c68-d565-08dd5d9d3855
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|19110799003|461199028|8062599003|15080799006|440099028|3412199025|30101999003|41001999003|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nTSFvlU0ay+toDy/qrEAJ/T25expNHIvrIS1pIHxIj/Hko4tgjKrlZ3rpJ/e?=
 =?us-ascii?Q?SiOdpcInU+o8n/cwkNPRI0NjjVgvn2SnMzwtD3y0kCbtKb1rBP6m2CaPYNZz?=
 =?us-ascii?Q?x39F7K4fl8gdkC98wnqDSWRs+xPVKONJtWtTu9JCBSxI3cYuS99sZQjxWrEv?=
 =?us-ascii?Q?M7kbZN4m8h1BaIC0P2RbLvc0BEHWyxgjXGBKFcaWuf3otpZSauldABfllY9a?=
 =?us-ascii?Q?LaKYiCLHbhvBLXZeGO+BiSU9m3bBqPuN7JDAIdY8q85H2stlDnDAmWUGMUn7?=
 =?us-ascii?Q?c3a3AsGn0xUS3vpyFQyOPHeKAJ/h1DFJFr4Z9hSxwYVdTOUU5exB4/uFVf1F?=
 =?us-ascii?Q?nNLSHKHvV5iWv0GDXnyiN2mK3bvRt0A1BrGammfmxuPAn4rv4Tw5umFIii8K?=
 =?us-ascii?Q?MJ5kQDnTI0RI8NE7l6yLV6vpED7DpntkLcpJSQQ7yunf5MQS4f1pNc1r+Ai8?=
 =?us-ascii?Q?Fd5Qne2qLUk5RIl2SDPKKWiRxmYUIXUi6RZ5RcA7iE7fSTOfARn0T6KRG7mX?=
 =?us-ascii?Q?tWKB0U3JddR2O8FWx41+atxfErkOXAH7jnKPIgiqQ02V+l7J8BOmE/KDLUg0?=
 =?us-ascii?Q?7EyuNR8WjexxI+v/LGzHpvw34wUdw+6psRQ7qyFKR6JSNwS5loFK3+XPUwcM?=
 =?us-ascii?Q?AyfjoJijCKbVYPDyvfjd1YBtu0EM3X9ycl/qrXTD4UfRc7ijtUrSL4IBK9Uf?=
 =?us-ascii?Q?RMAoqRLyvTYZWZsrvSnriCqU0x0bKpuznYbSl606Zuyu9fYkq7qoX3zYTS/g?=
 =?us-ascii?Q?3tXSvwm3aH9YtSqr/VemI7dRMPmG6XZ2GbERABrXpV5CHLyeWYDvJBpwWkSn?=
 =?us-ascii?Q?AYWwJKvfQEwBoQm/ZkU0mh36BQa4ED1n17uPM2HSpGMUe3ImtigwDp9OuF2E?=
 =?us-ascii?Q?ephcyEA+WwSo+njd8GSrEXKHeeCAUy07vPZ90m0RLAxc0RKeMXDOTAtHEmPL?=
 =?us-ascii?Q?jbtJQzI7JYqD5Oywx0xe5Bd/TFAm66N0Uth3Cp/77mWWvbFT/QH+oKUkm8ja?=
 =?us-ascii?Q?TWr+josNCsOfixQWBkvE8tvsou3u1lGUO2vTiIw4o1yvzgxhlP5YJTvcVR5B?=
 =?us-ascii?Q?IvB0LGh0rWcUdN1tvNzkY2BYUImI29F4srTwRuH/zbv7e592UBN1+bV9zDpU?=
 =?us-ascii?Q?12XbC6PUrBXGezfUhbjKXbIEnfDpgtNCfg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UdMUuTNoPKQVTByYxtnlLk3GPDuE0RpqCA+mrDsvsBohm2JLS1sqe4lZPW9M?=
 =?us-ascii?Q?Su9rC5gEn4XL+f5KVFmLYFbuhA2vdbSTGHhS3KvKkynyHBb1+D2bKnMd4Adq?=
 =?us-ascii?Q?GUMZooyXdj+MLdq5jTPCip5DJtSfS4d44FDsUtWFwm77mjXcY5qcV4tePvWb?=
 =?us-ascii?Q?+FNQxIHoidw6PrSxHFboXVl7ZiDkUDPAM04o7WZrdOS5vn3WlkCyVw3M/2Cg?=
 =?us-ascii?Q?2ihyU/HWqqjCmmwmR6D+G9clqFOKrkY1llF40F8pM8VhFwnVQ5iLll0/0Cey?=
 =?us-ascii?Q?0AAQVCQCRKiSVfJ97v63fr+N9f9JMwv/+3yQfcLhox/BfJKAk6XcrArU1wfB?=
 =?us-ascii?Q?AIktmWhI3LBWyPz9QHPnMRUJLooRonXVYHW7jhZbAHCvRZ1vPBRkjMfou9D0?=
 =?us-ascii?Q?meXc1QOZuxYHIeRJzBXgaOcC56+tADTHDeWrWQ+B5DGEmplh0EsAhdo4we1O?=
 =?us-ascii?Q?vAx9DKqZ0Igtg0gz3+ghuil80RhNVcqVLgoey+IBMn4d5Vu/MH0WbBKW7eK9?=
 =?us-ascii?Q?rHbhlElhmV8o5y2ufwkrXohu4JwVW7F5IP/+MC/xgbnMpKJXlVnsNZ7wmsvr?=
 =?us-ascii?Q?B5BP8a7jI6FOVsVs2642u58nHydmH9d0yk40IPTz6sjjdsJFf9+WZ48PaZZw?=
 =?us-ascii?Q?Fef0yWao8e5KdUJWrzUOtCwa8fEB2nGq/riK82j4yfSK/+Qnt0llqJOF0fnf?=
 =?us-ascii?Q?PWU36QvgjDhs3ewMQqePaORhwnm2tM8kJ+MCRk8WhoezdJSG80A92bsWgkfG?=
 =?us-ascii?Q?zaJZwpS90nFvtfTOEByJhyh6PFkE+KTwsoYT5yTf5Zm+tqNaMXHWIDD85mNT?=
 =?us-ascii?Q?Z0FPquH2r5awwa9NEzBIIHdEa3gu6yDkNROFGZyZy2WbuWoRspWqFBB73nhP?=
 =?us-ascii?Q?rMo/ejl7sjpxOUa174fxiM3InkT6M7EDUE8b3woZVCmfl28Xmc7HNU1E3OOP?=
 =?us-ascii?Q?eJHvlcZqbipj7rTllZuSxAFNQEZ7r7VNyt+PNSke6X+ytWjfZOjE1UcY2Ob0?=
 =?us-ascii?Q?EgxgxUubrJdMD08kpV21q+M6akeEu8QAU9WtoyFUxWPa64sifORGoWnsrG2g?=
 =?us-ascii?Q?WLO1aybh+DKASLu5ojeqmHLt8sNuYYtSLWwKfgh6k26dTOt3zfbZoPq3qbf4?=
 =?us-ascii?Q?miAfNXqEPp8tWXc2gy9uZyhPaHPYYlD9OmUx6B9IrTi4hNSpn6CO/mQvZIBz?=
 =?us-ascii?Q?OOoytfEiWhJDXPGTR5Y+u6wuCW2rGTaZJXRhVyxxJuJvpehgLsk0OsmAZI0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a234fe86-b59a-4c68-d565-08dd5d9d3855
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 17:26:39.2735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB6546

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, Fe=
bruary 26, 2025 3:08 PM
>=20
> A few additional definitions are required for the mshv driver code
> (to follow). Introduce those here and clean up a little bit while
> at it.
>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  include/hyperv/hvgdk_mini.h |  64 ++++++++++++++++-
>  include/hyperv/hvhdk.h      | 132 ++++++++++++++++++++++++++++++++++--
>  include/hyperv/hvhdk_mini.h |  91 +++++++++++++++++++++++++
>  3 files changed, 280 insertions(+), 7 deletions(-)
>=20
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 58895883f636..e4a3cca0cbce 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -13,7 +13,7 @@ struct hv_u128 {
>  	u64 high_part;
>  } __packed;
>=20
> -/* NOTE: when adding below, update hv_status_to_string() */
> +/* NOTE: when adding below, update hv_result_to_string() */
>  #define HV_STATUS_SUCCESS			    0x0
>  #define HV_STATUS_INVALID_HYPERCALL_CODE	    0x2
>  #define HV_STATUS_INVALID_HYPERCALL_INPUT	    0x3
> @@ -51,6 +51,7 @@ struct hv_u128 {
>  #define HV_HYP_PAGE_SHIFT		12
>  #define HV_HYP_PAGE_SIZE		BIT(HV_HYP_PAGE_SHIFT)
>  #define HV_HYP_PAGE_MASK		(~(HV_HYP_PAGE_SIZE - 1))
> +#define HV_HYP_LARGE_PAGE_SHIFT		21
>=20
>  #define HV_PARTITION_ID_INVALID		((u64)0)
>  #define HV_PARTITION_ID_SELF		((u64)-1)
> @@ -374,6 +375,10 @@ union hv_hypervisor_version_info {
>  #define HV_SHARED_GPA_BOUNDARY_ACTIVE			BIT(5)
>  #define HV_SHARED_GPA_BOUNDARY_BITS			GENMASK(11, 6)
>=20
> +/* HYPERV_CPUID_FEATURES.ECX bits. */
> +#define HV_VP_DISPATCH_INTERRUPT_INJECTION_AVAILABLE	BIT(9)
> +#define HV_VP_GHCB_ROOT_MAPPING_AVAILABLE		BIT(10)
> +
>  enum hv_isolation_type {
>  	HV_ISOLATION_TYPE_NONE	=3D 0,	/*
> HV_PARTITION_ISOLATION_TYPE_NONE */
>  	HV_ISOLATION_TYPE_VBS	=3D 1,
> @@ -437,9 +442,12 @@ union hv_vp_assist_msr_contents {	 /*
> HV_REGISTER_VP_ASSIST_PAGE */
>  #define HVCALL_MAP_GPA_PAGES				0x004b
>  #define HVCALL_UNMAP_GPA_PAGES				0x004c
>  #define HVCALL_CREATE_VP				0x004e
> +#define HVCALL_INSTALL_INTERCEPT			0x004d

This is numerically out-of-order.  Should be before HVCALL_CREATE_VP.

>  #define HVCALL_DELETE_VP				0x004f
>  #define HVCALL_GET_VP_REGISTERS				0x0050
>  #define HVCALL_SET_VP_REGISTERS				0x0051
> +#define HVCALL_TRANSLATE_VIRTUAL_ADDRESS		0x0052
> +#define HVCALL_CLEAR_VIRTUAL_INTERRUPT			0x0056
>  #define HVCALL_DELETE_PORT				0x0058
>  #define HVCALL_DISCONNECT_PORT				0x005b
>  #define HVCALL_POST_MESSAGE				0x005c
> @@ -447,12 +455,15 @@ union hv_vp_assist_msr_contents {	 /*
> HV_REGISTER_VP_ASSIST_PAGE */
>  #define HVCALL_POST_DEBUG_DATA				0x0069
>  #define HVCALL_RETRIEVE_DEBUG_DATA			0x006a
>  #define HVCALL_RESET_DEBUG_SESSION			0x006b
> +#define HVCALL_MAP_STATS_PAGE				0x006c
> +#define HVCALL_UNMAP_STATS_PAGE				0x006d
>  #define HVCALL_ADD_LOGICAL_PROCESSOR			0x0076
>  #define HVCALL_GET_SYSTEM_PROPERTY			0x007b
>  #define HVCALL_MAP_DEVICE_INTERRUPT			0x007c
>  #define HVCALL_UNMAP_DEVICE_INTERRUPT			0x007d
>  #define HVCALL_RETARGET_INTERRUPT			0x007e
>  #define HVCALL_NOTIFY_PORT_RING_EMPTY			0x008b
> +#define HVCALL_REGISTER_INTERCEPT_RESULT		0x0091
>  #define HVCALL_ASSERT_VIRTUAL_INTERRUPT			0x0094
>  #define HVCALL_CREATE_PORT				0x0095
>  #define HVCALL_CONNECT_PORT				0x0096
> @@ -460,12 +471,18 @@ union hv_vp_assist_msr_contents {	 /*
> HV_REGISTER_VP_ASSIST_PAGE */
>  #define HVCALL_GET_VP_ID_FROM_APIC_ID			0x009a
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE	0x00af
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST	0x00b0
> +#define HVCALL_SIGNAL_EVENT_DIRECT			0x00c0
> +#define HVCALL_POST_MESSAGE_DIRECT			0x00c1
>  #define HVCALL_DISPATCH_VP				0x00c2
> +#define HVCALL_GET_GPA_PAGES_ACCESS_STATES		0x00c9
> +#define HVCALL_ACQUIRE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d7
> +#define HVCALL_RELEASE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d8
>  #define HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY	0x00db
>  #define HVCALL_MAP_VP_STATE_PAGE			0x00e1
>  #define HVCALL_UNMAP_VP_STATE_PAGE			0x00e2
>  #define HVCALL_GET_VP_STATE				0x00e3
>  #define HVCALL_SET_VP_STATE				0x00e4
> +#define HVCALL_GET_VP_CPUID_VALUES			0x00f4
>  #define HVCALL_MMIO_READ				0x0106
>  #define HVCALL_MMIO_WRITE				0x0107
>=20
> @@ -807,6 +824,8 @@ struct hv_x64_table_register {
>  	u64 base;
>  } __packed;
>=20
> +#define HV_NORMAL_VTL	0
> +
>  union hv_input_vtl {
>  	u8 as_uint8;
>  	struct {
> @@ -1325,6 +1344,49 @@ struct hv_retarget_device_interrupt {	 /*
> HV_INPUT_RETARGET_DEVICE_INTERRUPT */
>  	struct hv_device_interrupt_target int_target;
>  } __packed __aligned(8);
>=20
> +enum hv_intercept_type {
> +#if defined(CONFIG_X86_64)
> +	HV_INTERCEPT_TYPE_X64_IO_PORT			=3D 0x00000000,
> +	HV_INTERCEPT_TYPE_X64_MSR			=3D 0x00000001,
> +	HV_INTERCEPT_TYPE_X64_CPUID			=3D 0x00000002,
> +#endif
> +	HV_INTERCEPT_TYPE_EXCEPTION			=3D 0x00000003,
> +	/* Used to be HV_INTERCEPT_TYPE_REGISTER */
> +	HV_INTERCEPT_TYPE_RESERVED0			=3D 0x00000004,
> +	HV_INTERCEPT_TYPE_MMIO				=3D 0x00000005,
> +#if defined(CONFIG_X86_64)
> +	HV_INTERCEPT_TYPE_X64_GLOBAL_CPUID		=3D 0x00000006,
> +	HV_INTERCEPT_TYPE_X64_APIC_SMI			=3D 0x00000007,
> +#endif
> +	HV_INTERCEPT_TYPE_HYPERCALL			=3D 0x00000008,
> +#if defined(CONFIG_X86_64)
> +	HV_INTERCEPT_TYPE_X64_APIC_INIT_SIPI		=3D 0x00000009,
> +	HV_INTERCEPT_MC_UPDATE_PATCH_LEVEL_MSR_READ	=3D 0x0000000A,
> +	HV_INTERCEPT_TYPE_X64_APIC_WRITE		=3D 0x0000000B,
> +	HV_INTERCEPT_TYPE_X64_MSR_INDEX			=3D 0x0000000C,
> +#endif
> +	HV_INTERCEPT_TYPE_MAX,
> +	HV_INTERCEPT_TYPE_INVALID			=3D 0xFFFFFFFF,
> +};
> +
> +union hv_intercept_parameters {
> +	/*  HV_INTERCEPT_PARAMETERS is defined to be an 8-byte field. */
> +	__u64 as_uint64;
> +#if defined(CONFIG_X86_64)
> +	/* HV_INTERCEPT_TYPE_X64_IO_PORT */
> +	__u16 io_port;
> +	/* HV_INTERCEPT_TYPE_X64_CPUID */
> +	__u32 cpuid_index;
> +	/* HV_INTERCEPT_TYPE_X64_APIC_WRITE */
> +	__u32 apic_write_mask;
> +	/* HV_INTERCEPT_TYPE_EXCEPTION */
> +	__u16 exception_vector;
> +	/* HV_INTERCEPT_TYPE_X64_MSR_INDEX */
> +	__u32 msr_index;
> +#endif
> +	/* N.B. Other intercept types do not have any parameters. */
> +};
> +
>  /* Data structures for HVCALL_MMIO_READ and HVCALL_MMIO_WRITE */
>  #define HV_HYPERCALL_MMIO_MAX_DATA_LENGTH 64
>=20
> diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
> index 64407c2a3809..1b447155c338 100644
> --- a/include/hyperv/hvhdk.h
> +++ b/include/hyperv/hvhdk.h
> @@ -19,11 +19,24 @@
>=20
>  #define HV_VP_REGISTER_PAGE_VERSION_1	1u
>=20
> +#define HV_VP_REGISTER_PAGE_MAX_VECTOR_COUNT		7
> +
> +union hv_vp_register_page_interrupt_vectors {
> +	u64 as_uint64;
> +	struct {
> +		u8 vector_count;
> +		u8 vector[HV_VP_REGISTER_PAGE_MAX_VECTOR_COUNT];
> +	} __packed;
> +} __packed;
> +
>  struct hv_vp_register_page {
>  	u16 version;
>  	u8 isvalid;
>  	u8 rsvdz;
>  	u32 dirty;
> +
> +#if IS_ENABLED(CONFIG_X86)
> +
>  	union {
>  		struct {
>  			/* General purpose registers
> @@ -95,6 +108,22 @@ struct hv_vp_register_page {
>  	union hv_x64_pending_interruption_register pending_interruption;
>  	union hv_x64_interrupt_state_register interrupt_state;
>  	u64 instruction_emulation_hints;
> +	u64 xfem;
> +
> +	/*
> +	 * Fields from this point are not included in the register page save ch=
unk.
> +	 * The reserved field is intended to maintain alignment for unsaved fie=
lds.
> +	 */
> +	u8 reserved1[0x100];
> +
> +	/*
> +	 * Interrupts injected as part of HvCallDispatchVp.
> +	 */
> +	union hv_vp_register_page_interrupt_vectors interrupt_vectors;
> +
> +#elif IS_ENABLED(CONFIG_ARM64)
> +	/* Not yet supported in ARM */
> +#endif
>  } __packed;
>=20
>  #define HV_PARTITION_PROCESSOR_FEATURES_BANKS 2
> @@ -299,10 +328,11 @@ union hv_partition_isolation_properties {
>  #define HV_PARTITION_ISOLATION_HOST_TYPE_RESERVED   0x2
>=20
>  /* Note: Exo partition is enabled by default */
> -#define HV_PARTITION_CREATION_FLAG_EXO_PARTITION                    BIT(=
8)
> -#define HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED                    BIT(=
13)
> -#define HV_PARTITION_CREATION_FLAG_INTERCEPT_MESSAGE_PAGE_ENABLED   BIT(=
19)
> -#define HV_PARTITION_CREATION_FLAG_X2APIC_CAPABLE                   BIT(=
22)
> +#define HV_PARTITION_CREATION_FLAG_GPA_SUPER_PAGES_ENABLED		BIT(4)
> +#define HV_PARTITION_CREATION_FLAG_EXO_PARTITION			BIT(8)
> +#define HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED			BIT(13)
> +#define HV_PARTITION_CREATION_FLAG_INTERCEPT_MESSAGE_PAGE_ENABLED	BIT(19=
)
> +#define HV_PARTITION_CREATION_FLAG_X2APIC_CAPABLE			BIT(22)
>=20
>  struct hv_input_create_partition {
>  	u64 flags;
> @@ -349,13 +379,23 @@ struct hv_input_set_partition_property {
>  enum hv_vp_state_page_type {
>  	HV_VP_STATE_PAGE_REGISTERS =3D 0,
>  	HV_VP_STATE_PAGE_INTERCEPT_MESSAGE =3D 1,
> +	HV_VP_STATE_PAGE_GHCB,

Seems like this enum member should have an explicit value assigned
since it is part of the contract with the hypervisor.

>  	HV_VP_STATE_PAGE_COUNT
>  };
>=20
>  struct hv_input_map_vp_state_page {
>  	u64 partition_id;
>  	u32 vp_index;
> -	u32 type; /* enum hv_vp_state_page_type */
> +	u16 type; /* enum hv_vp_state_page_type */
> +	union hv_input_vtl input_vtl;
> +	union {
> +		u8 as_uint8;
> +		struct {
> +			u8 map_location_provided : 1;
> +			u8 reserved : 7;
> +		};
> +	} flags;
> +	u64 requested_map_location;
>  } __packed;
>=20
>  struct hv_output_map_vp_state_page {
> @@ -365,7 +405,14 @@ struct hv_output_map_vp_state_page {
>  struct hv_input_unmap_vp_state_page {
>  	u64 partition_id;
>  	u32 vp_index;
> -	u32 type; /* enum hv_vp_state_page_type */
> +	u16 type; /* enum hv_vp_state_page_type */
> +	union hv_input_vtl input_vtl;
> +	u8 reserved0;
> +} __packed;
> +
> +struct hv_x64_apic_eoi_message {
> +	__u32 vp_index;
> +	__u32 interrupt_vector;
>  } __packed;
>=20
>  struct hv_opaque_intercept_message {
> @@ -515,6 +562,13 @@ struct hv_synthetic_timers_state {
>  	u64 reserved[5];
>  } __packed;
>=20
> +struct hv_async_completion_message_payload {
> +	__u64 partition_id;
> +	__u32 status;
> +	__u32 completion_count;
> +	__u64 sub_status;
> +} __packed;
> +
>  union hv_input_delete_vp {
>  	u64 as_uint64[2];
>  	struct {
> @@ -649,6 +703,57 @@ struct hv_input_set_vp_state {
>  	union hv_input_set_vp_state_data data[];
>  } __packed;
>=20
> +union hv_x64_vp_execution_state {
> +	__u16 as_uint16;
> +	struct {
> +		__u16 cpl:2;
> +		__u16 cr0_pe:1;
> +		__u16 cr0_am:1;
> +		__u16 efer_lma:1;
> +		__u16 debug_active:1;
> +		__u16 interruption_pending:1;
> +		__u16 vtl:4;
> +		__u16 enclave_mode:1;
> +		__u16 interrupt_shadow:1;
> +		__u16 virtualization_fault_active:1;
> +		__u16 reserved:2;
> +	} __packed;
> +};
> +
> +struct hv_x64_intercept_message_header {
> +	__u32 vp_index;
> +	__u8 instruction_length:4;
> +	__u8 cr8:4; /* Only set for exo partitions */
> +	__u8 intercept_access_type;
> +	union hv_x64_vp_execution_state execution_state;
> +	struct hv_x64_segment_register cs_segment;
> +	__u64 rip;
> +	__u64 rflags;
> +} __packed;
> +
> +union hv_x64_memory_access_info {
> +	__u8 as_uint8;
> +	struct {
> +		__u8 gva_valid:1;
> +		__u8 gva_gpa_valid:1;
> +		__u8 hypercall_output_pending:1;
> +		__u8 tlb_locked_no_overlay:1;
> +		__u8 reserved:4;
> +	} __packed;
> +};
> +
> +struct hv_x64_memory_intercept_message {
> +	struct hv_x64_intercept_message_header header;
> +	__u32 cache_type; /* enum hv_cache_type */
> +	__u8 instruction_byte_count;
> +	union hv_x64_memory_access_info memory_access_info;
> +	__u8 tpr_priority;
> +	__u8 reserved1;
> +	__u64 guest_virtual_address;
> +	__u64 guest_physical_address;
> +	__u8 instruction_bytes[16];
> +} __packed;
> +
>  /*
>   * Dispatch state for the VP communicated by the hypervisor to the
>   * VP-dispatching thread in the root on return from HVCALL_DISPATCH_VP.
> @@ -716,6 +821,7 @@ static_assert(sizeof(struct hv_vp_signal_pair_schedul=
er_message)
> =3D=3D
>  #define HV_DISPATCH_VP_FLAG_SKIP_VP_SPEC_FLUSH		0x8
>  #define HV_DISPATCH_VP_FLAG_SKIP_CALLER_SPEC_FLUSH	0x10
>  #define HV_DISPATCH_VP_FLAG_SKIP_CALLER_USER_SPEC_FLUSH	0x20
> +#define HV_DISPATCH_VP_FLAG_SCAN_INTERRUPT_INJECTION	0x40
>=20
>  struct hv_input_dispatch_vp {
>  	u64 partition_id;
> @@ -730,4 +836,18 @@ struct hv_output_dispatch_vp {
>  	u32 dispatch_event; /* enum hv_vp_dispatch_event */
>  } __packed;
>=20
> +struct hv_input_modify_sparse_spa_page_host_access {
> +	u32 host_access : 2;
> +	u32 reserved : 30;
> +	u32 flags;
> +	u64 partition_id;
> +	u64 spa_page_list[];
> +} __packed;
> +
> +/* hv_input_modify_sparse_spa_page_host_access flags */
> +#define HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_EXCLUSIVE  0x1
> +#define HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_SHARED     0x2
> +#define HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE      0x4
> +#define HV_MODIFY_SPA_PAGE_HOST_ACCESS_HUGE_PAGE       0x8
> +
>  #endif /* _HV_HVHDK_H */
> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index f8a39d3e9ce6..42e7876455b5 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h
> @@ -36,6 +36,52 @@ enum hv_scheduler_type {
>  	HV_SCHEDULER_TYPE_MAX
>  };
>=20
> +/* HV_STATS_AREA_TYPE */
> +enum hv_stats_area_type {
> +	HV_STATS_AREA_SELF =3D 0,
> +	HV_STATS_AREA_PARENT =3D 1,
> +	HV_STATS_AREA_INTERNAL =3D 2,
> +	HV_STATS_AREA_COUNT
> +};
> +
> +enum hv_stats_object_type {
> +	HV_STATS_OBJECT_HYPERVISOR		=3D 0x00000001,
> +	HV_STATS_OBJECT_LOGICAL_PROCESSOR	=3D 0x00000002,
> +	HV_STATS_OBJECT_PARTITION		=3D 0x00010001,
> +	HV_STATS_OBJECT_VP			=3D 0x00010002
> +};
> +
> +union hv_stats_object_identity {
> +	/* hv_stats_hypervisor */
> +	struct {
> +		u8 reserved[15];
> +		u8 stats_area_type;
> +	} __packed hv;
> +
> +	/* hv_stats_logical_processor */
> +	struct {
> +		u32 lp_index;
> +		u8 reserved[11];
> +		u8 stats_area_type;
> +	} __packed lp;
> +
> +	/* hv_stats_partition */
> +	struct {
> +		u64 partition_id;
> +		u8  reserved[7];
> +		u8  stats_area_type;
> +	} __packed partition;
> +
> +	/* hv_stats_vp */
> +	struct {
> +		u64 partition_id;
> +		u32 vp_index;
> +		u16 flags;
> +		u8  reserved;
> +		u8  stats_area_type;
> +	} __packed vp;
> +};
> +
>  enum hv_partition_property_code {
>  	/* Privilege properties */
>  	HV_PARTITION_PROPERTY_PRIVILEGE_FLAGS			=3D 0x00010000,
> @@ -47,19 +93,45 @@ enum hv_partition_property_code {
>=20
>  	/* Compatibility properties */
>  	HV_PARTITION_PROPERTY_PROCESSOR_XSAVE_FEATURES		=3D
> 0x00060002,
> +	HV_PARTITION_PROPERTY_XSAVE_STATES                      =3D 0x00060007,
>  	HV_PARTITION_PROPERTY_MAX_XSAVE_DATA_SIZE		=3D 0x00060008,
>  	HV_PARTITION_PROPERTY_PROCESSOR_CLOCK_FREQUENCY		=3D
> 0x00060009,
>  };
>=20
> +enum hv_snp_status {
> +	HV_SNP_STATUS_NONE =3D 0,
> +	HV_SNP_STATUS_AVAILABLE =3D 1,
> +	HV_SNP_STATUS_INCOMPATIBLE =3D 2,
> +	HV_SNP_STATUS_PSP_UNAVAILABLE =3D 3,
> +	HV_SNP_STATUS_PSP_INIT_FAILED =3D 4,
> +	HV_SNP_STATUS_PSP_BAD_FW_VERSION =3D 5,
> +	HV_SNP_STATUS_BAD_CONFIGURATION =3D 6,
> +	HV_SNP_STATUS_PSP_FW_UPDATE_IN_PROGRESS =3D 7,
> +	HV_SNP_STATUS_PSP_RB_INIT_FAILED =3D 8,
> +	HV_SNP_STATUS_PSP_PLATFORM_STATUS_FAILED =3D 9,
> +	HV_SNP_STATUS_PSP_INIT_LATE_FAILED =3D 10,
> +};
> +
>  enum hv_system_property {
>  	/* Add more values when needed */
>  	HV_SYSTEM_PROPERTY_SCHEDULER_TYPE =3D 15,
> +	HV_DYNAMIC_PROCESSOR_FEATURE_PROPERTY =3D 21,
> +};
> +
> +enum hv_dynamic_processor_feature_property {
> +	/* Add more values when needed */
> +	HV_X64_DYNAMIC_PROCESSOR_FEATURE_MAX_ENCRYPTED_PARTITIONS =3D 13,
> +	HV_X64_DYNAMIC_PROCESSOR_FEATURE_SNP_STATUS =3D 16,
>  };
>=20
>  struct hv_input_get_system_property {
>  	u32 property_id; /* enum hv_system_property */
>  	union {
>  		u32 as_uint32;
> +#if IS_ENABLED(CONFIG_X86)
> +		/* enum hv_dynamic_processor_feature_property */
> +		u32 hv_processor_feature;
> +#endif
>  		/* More fields to be filled in when needed */
>  	};
>  } __packed;
> @@ -67,9 +139,28 @@ struct hv_input_get_system_property {
>  struct hv_output_get_system_property {
>  	union {
>  		u32 scheduler_type; /* enum hv_scheduler_type */
> +#if IS_ENABLED(CONFIG_X86)
> +		u64 hv_processor_feature_value;
> +#endif
>  	};
>  } __packed;
>=20
> +struct hv_input_map_stats_page {
> +	u32 type; /* enum hv_stats_object_type */
> +	u32 padding;
> +	union hv_stats_object_identity identity;
> +} __packed;
> +
> +struct hv_output_map_stats_page {
> +	u64 map_location;
> +} __packed;
> +
> +struct hv_input_unmap_stats_page {
> +	u32 type; /* enum hv_stats_object_type */
> +	u32 padding;
> +	union hv_stats_object_identity identity;
> +} __packed;
> +
>  struct hv_proximity_domain_flags {
>  	u32 proximity_preferred : 1;
>  	u32 reserved : 30;
> --
> 2.34.1


