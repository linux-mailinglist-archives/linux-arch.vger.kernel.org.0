Return-Path: <linux-arch+bounces-10320-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FADA4017C
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 21:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 052AE19C7E1B
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 20:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291A8253B5C;
	Fri, 21 Feb 2025 20:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fnitICET"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2063.outbound.protection.outlook.com [40.92.23.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A641F3BA9;
	Fri, 21 Feb 2025 20:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740171504; cv=fail; b=lcXZB85Ohd9UQdmLPflntFIDtXLP2+vNELDL0c3IxdpdWyQncf0xaQoaYPGOErrR/L7W8ptjb1FaE15H9D/aSHU/L8goT/hwiCNqfhOLnH1trntxxyt7j9yTy3vHJ6S4LJ1VqC3/UsiugERPFdb5t9XdlkGoJTuVza9VjMyu8BM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740171504; c=relaxed/simple;
	bh=k9w5ycCR79wUFslSLDCGhQrJoj4DIZs66ddfRrsa1/4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XP5FJ3stExiTKoIgMRqPy5bzSrRzoTm0vGPu7GfjMEWVQUR1PuVsN/zrkS+JZQheecEBCGvKTEaKP0Q7zhaaA0BGwM1UiR4E68yhyIdN3Iwwl7r4btXb+gy3D3ymGf0KY/7sO/6w9OYBZKzR/AapfKktw1kuQ3wDXq8O2lnkUx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fnitICET; arc=fail smtp.client-ip=40.92.23.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sEzjymSYfcEuEuwf+QgNV+KUabjMCmgdgL74eqiEeInVhCpaQV+KBM+tXvV/UZL/RkJAKe408ESFmDTmISlHMKqGMXhE0Pd8oV3yNFQz4dL6muq/dPDxHj2BzIZg6i2Up4rXpPAKBjIzWDEEJWNkMdKH8jRyUYLW1piZgXTosZHRmIg/fB4V/XB0QtRPYc2MdMQQuL29HRPdiEwjBw/h+8hdO2bre3MB5vhBAAAu2jB9bl4Eytu/wQd+D5PUzgnLZMSQt5JpfRG/cFJeIfwT2B+lcQW3t4iw0F4TT95Nqy6UCTchSLfFbOabo9uvFqKsTTWgeAJ+zp0DnNFdgAq+oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvPnShx9TQLMUSU/IIOv7SlyC6b87zvGCB60EKSJAFs=;
 b=ukM/Co//YCPKuNAGMiGLkxmi6zSkEhcOrIuCMsDcP+EHNtjkG12iLVPx56dCyhV/LB7HUYWK2l6dsbCZ+M5BGi8UzjoQkBlZZ7MpG2T4Xo0SUUCRuELyJegebGY+9NNbUN4ex/RlSW1Kxv6Ul+f8LBeVYp/QXWaFhqaA+0zJvrT+kU1HIFmb5se85OlqNhKsYqyVOXHVLpqW5vO0LS2pxjTcKZokRoBuNoGa5mnz8n8adlBbgc2P7Kk/icGwGvzXkU+sy48V8LFlCSKWIpOcxCImXZivYHgOjX48C2JaYhqp9bI5jcTxJ/l7CSjJzH17g41duJRlWX17hX9+M/tjeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvPnShx9TQLMUSU/IIOv7SlyC6b87zvGCB60EKSJAFs=;
 b=fnitICETwJLX8HrW22Y7mblvNDtkS+bfG/U6C/V7pnlknUcGwliLWBck8HJOQZP3i509Yf5SDVjNEnRbcS9gE5Q0l1tSU+fCrutIWl97Dwy1aPc0qhMJZiBW+Pw1OF/sjTD58KlDtlCelLEueYVNjYWh7OLAflfjf3ZKv5xQct8lKrGpZ90Iw1RcUO84zvHmOsmg095DeXPHv7OACa7rM9htG99sOslQdprl8pF8TBuHTSkD22ib3mzxfwH00UCpswALUThZ4d9N5xwsu5ZemFUr8su9VVHGYPVuM/n0B5x1oMscYkFjeePtYmTRiCsX3quKxr5Lp0Ualt7VuksK9w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH0PR02MB8195.namprd02.prod.outlook.com (2603:10b6:610:f1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 20:58:06 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8466.013; Fri, 21 Feb 2025
 20:58:06 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "eahariha@linux.microsoft.com"
	<eahariha@linux.microsoft.com>, "mukeshrathor@microsoft.com"
	<mukeshrathor@microsoft.com>
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
	<skinsburskii@linux.microsoft.com>
Subject: RE: [PATCH v3 2/3] hyperv: Change hv_root_partition into a function
Thread-Topic: [PATCH v3 2/3] hyperv: Change hv_root_partition into a function
Thread-Index: AQHbhJq8IkkEsoVtfEyua25mZ1zmjLNSPSLw
Date: Fri, 21 Feb 2025 20:58:06 +0000
Message-ID:
 <SN6PR02MB41571DC572600680E3527DA0D4C72@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1740167795-13296-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740167795-13296-3-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1740167795-13296-3-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH0PR02MB8195:EE_
x-ms-office365-filtering-correlation-id: c368d70b-3837-4a3d-0df1-08dd52ba70ac
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|461199028|8060799006|15080799006|19110799003|102099032|3412199025|440099028|41001999003|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?opmuswMOBMQY+qv2L3Tu4ElACMMrw66ggFI48xv9ORJ1aQhnkAZX2ixq1jH/?=
 =?us-ascii?Q?XIucvnFYrmg/pd7DG+PN59pMwZLDzXG0L52chb+tC0znzWyfaTllDWhV7tIc?=
 =?us-ascii?Q?2mvnte0PBFhHwRIpy5r409ebmttQSse7KCIYRnAQe8/geGGgpLYoQtlOgfUD?=
 =?us-ascii?Q?sbWgz6/9xRVslEhfCRL97vMCSJupVMAwb1pJf4/5FBDocEm4uDUffs1jFRsC?=
 =?us-ascii?Q?eWFPj6x1OljPo5GyP3XMYAITqfGWjqHyWmV6kGe2lym1kL5cYub9JlF7AU/Z?=
 =?us-ascii?Q?vJ1Aeauftz+cm5j2ZkHr/Wr8Zs5e6LBczYdmOFa21zrszp58Bzi+LqaZKawI?=
 =?us-ascii?Q?XLkyYMjsWmaolNnpzBGeCJtkWbeG1CAblz2tIT97qVN1UGOI5gja90uNqT+w?=
 =?us-ascii?Q?d3aMgSJRwlcgqFWK8uq3c8QEIrkoyV6J46kLY1wrJmRQ/0wQa/zOu98feEii?=
 =?us-ascii?Q?MBmkZOPcn3oAvjbb2oKTPT1l2zMVEl8SOOaPuJAB3LCcNZjO4mum/S59PC9o?=
 =?us-ascii?Q?3AcmQK4z+G6zfIQeKCtaFxsq78YR75qlaualOpxG7JZx9Y3W4o4BRmdCuKuC?=
 =?us-ascii?Q?rk/P1ikn8cpGu2biohISRRMjfF1xijz6I4GlQ2j471mUToP1vwS42CqVK8xt?=
 =?us-ascii?Q?o03UimZUuCUctHt1mrwQpxQveVggJ5c0teYsFc5wSJcEruPrkidkneuWjWGW?=
 =?us-ascii?Q?p+c8YbWnp4C9qyBSmAMh8TAAjLjNAqy601xpwVpIDrdrElRQPRLwGCCw13w8?=
 =?us-ascii?Q?4BaJD9gdzWV+96obwiV0wAxkyvCeofywIgI/SoT8VoWfR+Ib3umLCSa4Zmv/?=
 =?us-ascii?Q?Q5OlZMyr9dJ/n4uXz+Mz/Q8RIdRYYcmYyV7AJsOBqmOTmoz7Xvqnp4NYA7GZ?=
 =?us-ascii?Q?s5r5Y1zb6ykZOegWvCZDPOCOi8HnEvz9vK6UxxxlQQhEzPNni2GoPOajt+a1?=
 =?us-ascii?Q?KsgBTDwmBX36kqWUjRakbdtkofoIXz/F9qZmkbp9QfJI22fsDRjo/4cAqxRQ?=
 =?us-ascii?Q?/7rhXPpdqgqQXpR0QgwFAKIwItDEqNzfezig8kHNlHMuZmJlLhxRjdW0e/5s?=
 =?us-ascii?Q?M6Y7dF9OzQsY7ekbXjuetkWDYdHirYESUk/mrB1TdRI49lCVdok=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/2nnor5PYjOCl9vzC+NvX5TdAtk2xTvKJzed8g0WsTuI/PUyyz1d7/b4QQpt?=
 =?us-ascii?Q?/yRAgWQjzuECmz5QlpDj4U0JHfcBBxzwHcgh4v4LgulMJ4DE70iHXElcpz3C?=
 =?us-ascii?Q?E+Vdwc9uI/i8ALIgD8mGQTbC0ZmbOaW+y4H+jSQab+v/va8l9HhZ71r2XLkL?=
 =?us-ascii?Q?H0dAniJoHWvou9q+ADDRPRcMn55BiwBEmPbtvCRbaDuHTkgUzd2wfdrMsYqS?=
 =?us-ascii?Q?Lg43VevfbmAb8LRdK6Lsn7oMqsrq/5vVC0lDwJ6uUWPOqsQHs6nD0HugHQO2?=
 =?us-ascii?Q?ZjwKqDKJvebOBtDemEyyJByC33I18REr0uyCplpEjEc+Ut/KD/B3oh3NUlZJ?=
 =?us-ascii?Q?b/SHG7Q2sfveSLJhUn6t8oJIb8r5ZHj/2275YbWoEwqVGw1pIHoIrAB/sJB0?=
 =?us-ascii?Q?E6Oh3GC7zcRM3CVatznYdXCyZcNWA48N/pF+MmJHYF3Hiqhh/tnVNIkd8jvO?=
 =?us-ascii?Q?YnG9VrkuTKgLM6092l8G3+TwxvKgVFdnbUI5YY6QIlSc8xlH+0YnY2l9QnaZ?=
 =?us-ascii?Q?eXCVeU3VZOvARVxw4EV0C59B9vZbASkaYxGFw1O9UUz1iVRxe5103/fGPbp/?=
 =?us-ascii?Q?OJY7LZsd+DMADS++NoS14XubMT1FGzTdmx84gSPCFhxc0/YN/39hDcpSjwzd?=
 =?us-ascii?Q?IzBDm+EmDJ7KC2cbnMGUzSJuGkSg2xYVDjL2XKIQIj02GqrpWSYcxeqNq6P/?=
 =?us-ascii?Q?dhStjEdpz6rc4X1DTrVNxe6OLn2Skz6yAn0ERKDwXyocroA5OCgJwkM7eVBA?=
 =?us-ascii?Q?ZkpLtvLZH/+QwQdoiUVjORoaTpY2xLAoXKvOXfbH4lhpiuZlNUmhcJKrJkjd?=
 =?us-ascii?Q?zJ0gtNJy2UDx8FKKLTXo3jYYWAKraio2dp5vL6yjkfuFa4NNrLEPPw/1Yl78?=
 =?us-ascii?Q?RQab9c3fuJw+i7HSg/xfh2CZk3eaq+DiJrm/DPKlBlVcpakccByqV6QHwgDb?=
 =?us-ascii?Q?9u44DpmzTHpwtuV8prEXfNlEtzo6j6nLW9mdQTrCY2E355VtT1Cw0r9QoiQV?=
 =?us-ascii?Q?9GvfpQQSo32Z0ZIuFN1fn6d85NwLv8nkcMAs26XtKrKASOeC3FNNQqkEwTgQ?=
 =?us-ascii?Q?6rbhRqqv0Reyvs2I33yJG6eQTsKHVgCcE+rVBq2LMKFK6TdlhUQcjJnFoAfI?=
 =?us-ascii?Q?+eLZVqHmG1v8UAGbKVvB43Lza8Hzm+VZRluYbfRE1ELYrrssAAhm0O7P7VGl?=
 =?us-ascii?Q?WkxIFGyc0yO73+LumfFP+LjeMFLMF2vV7LVHj0CrSZMnxl8zSe88l+/NuTI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c368d70b-3837-4a3d-0df1-08dd52ba70ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 20:58:06.4084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8195

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, Febru=
ary 21, 2025 11:57 AM
>=20
> Introduce hv_curr_partition_type to store the partition type
> as an enum.
>=20
> Right now this is limited to guest or root partition, but there will
> be other kinds in future and the enum is easily extensible.
>=20
> Set up hv_curr_partition_type early in Hyper-V initialization with
> hv_identify_partition_type(). hv_root_partition() just queries this
> value, and shouldn't be called before that.
>=20
> Making this check into a function sets the stage for adding a config
> option to gate the compilation of root partition code. In particular,
> hv_root_partition() can be stubbed out always be false if root
> partition support isn't desired.
>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>  arch/arm64/hyperv/mshyperv.c       |  2 ++
>  arch/x86/hyperv/hv_init.c          | 10 +++++-----
>  arch/x86/kernel/cpu/mshyperv.c     | 24 ++--------------------
>  drivers/clocksource/hyperv_timer.c |  4 ++--
>  drivers/hv/hv.c                    | 10 +++++-----
>  drivers/hv/hv_common.c             | 32 ++++++++++++++++++++++++------
>  drivers/hv/vmbus_drv.c             |  2 +-
>  drivers/iommu/hyperv-iommu.c       |  4 ++--
>  include/asm-generic/mshyperv.h     | 15 ++++++++++++--
>  9 files changed, 58 insertions(+), 45 deletions(-)

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

>=20
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index 29fcfd595f48..2265ea5ce5ad 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -61,6 +61,8 @@ static int __init hyperv_init(void)
>  		ms_hyperv.features, ms_hyperv.priv_high, ms_hyperv.hints,
>  		ms_hyperv.misc_features);
>=20
> +	hv_identify_partition_type();
> +
>  	ret =3D hv_common_init();
>  	if (ret)
>  		return ret;
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 9be1446f5bd3..ddeb40930bc8 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -90,7 +90,7 @@ static int hv_cpu_init(unsigned int cpu)
>  		return 0;
>=20
>  	hvp =3D &hv_vp_assist_page[cpu];
> -	if (hv_root_partition) {
> +	if (hv_root_partition()) {
>  		/*
>  		 * For root partition we get the hypervisor provided VP assist
>  		 * page, instead of allocating a new page.
> @@ -242,7 +242,7 @@ static int hv_cpu_die(unsigned int cpu)
>=20
>  	if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
>  		union hv_vp_assist_msr_contents msr =3D { 0 };
> -		if (hv_root_partition) {
> +		if (hv_root_partition()) {
>  			/*
>  			 * For root partition the VP assist page is mapped to
>  			 * hypervisor provided page, and thus we unmap the
> @@ -317,7 +317,7 @@ static int hv_suspend(void)
>  	union hv_x64_msr_hypercall_contents hypercall_msr;
>  	int ret;
>=20
> -	if (hv_root_partition)
> +	if (hv_root_partition())
>  		return -EPERM;
>=20
>  	/*
> @@ -518,7 +518,7 @@ void __init hyperv_init(void)
>  	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>  	hypercall_msr.enable =3D 1;
>=20
> -	if (hv_root_partition) {
> +	if (hv_root_partition()) {
>  		struct page *pg;
>  		void *src;
>=20
> @@ -592,7 +592,7 @@ void __init hyperv_init(void)
>  	 * If we're running as root, we want to create our own PCI MSI domain.
>  	 * We can't set this in hv_pci_init because that would be too late.
>  	 */
> -	if (hv_root_partition)
> +	if (hv_root_partition())
>  		x86_init.irqs.create_pci_msi_domain =3D hv_create_pci_msi_domain;
>  #endif
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index f285757618fc..4f01f424ea5b 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -33,8 +33,6 @@
>  #include <asm/numa.h>
>  #include <asm/svm.h>
>=20
> -/* Is Linux running as the root partition? */
> -bool hv_root_partition;
>  /* Is Linux running on nested Microsoft Hypervisor */
>  bool hv_nested;
>  struct ms_hyperv_info ms_hyperv;
> @@ -451,25 +449,7 @@ static void __init ms_hyperv_init_platform(void)
>  	pr_debug("Hyper-V: max %u virtual processors, %u logical processors\n",
>  		 ms_hyperv.max_vp_index, ms_hyperv.max_lp_index);
>=20
> -	/*
> -	 * Check CPU management privilege.
> -	 *
> -	 * To mirror what Windows does we should extract CPU management
> -	 * features and use the ReservedIdentityBit to detect if Linux is the
> -	 * root partition. But that requires negotiating CPU management
> -	 * interface (a process to be finalized). For now, use the privilege
> -	 * flag as the indicator for running as root.
> -	 *
> -	 * Hyper-V should never specify running as root and as a Confidential
> -	 * VM. But to protect against a compromised/malicious Hyper-V trying
> -	 * to exploit root behavior to expose Confidential VM memory, ignore
> -	 * the root partition setting if also a Confidential VM.
> -	 */
> -	if ((ms_hyperv.priv_high & HV_CPU_MANAGEMENT) &&
> -	    !(ms_hyperv.priv_high & HV_ISOLATION)) {
> -		hv_root_partition =3D true;
> -		pr_info("Hyper-V: running as root partition\n");
> -	}
> +	hv_identify_partition_type();
>=20
>  	if (ms_hyperv.hints & HV_X64_HYPERV_NESTED) {
>  		hv_nested =3D true;
> @@ -618,7 +598,7 @@ static void __init ms_hyperv_init_platform(void)
>=20
>  # ifdef CONFIG_SMP
>  	smp_ops.smp_prepare_boot_cpu =3D hv_smp_prepare_boot_cpu;
> -	if (hv_root_partition ||
> +	if (hv_root_partition() ||
>  	    (!ms_hyperv.paravisor_present && hv_isolation_type_snp()))
>  		smp_ops.smp_prepare_cpus =3D hv_smp_prepare_cpus;
>  # endif
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyp=
erv_timer.c
> index f00019b078a7..09549451dd51 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -582,7 +582,7 @@ static void __init hv_init_tsc_clocksource(void)
>  	 * mapped.
>  	 */
>  	tsc_msr.as_uint64 =3D hv_get_msr(HV_MSR_REFERENCE_TSC);
> -	if (hv_root_partition)
> +	if (hv_root_partition())
>  		tsc_pfn =3D tsc_msr.pfn;
>  	else
>  		tsc_pfn =3D HVPFN_DOWN(virt_to_phys(tsc_page));
> @@ -627,7 +627,7 @@ void __init hv_remap_tsc_clocksource(void)
>  	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
>  		return;
>=20
> -	if (!hv_root_partition) {
> +	if (!hv_root_partition()) {
>  		WARN(1, "%s: attempt to remap TSC page in guest partition\n",
>  		     __func__);
>  		return;
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index fab0690b5c41..a38f84548bc2 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -144,7 +144,7 @@ int hv_synic_alloc(void)
>  		 * Synic message and event pages are allocated by paravisor.
>  		 * Skip these pages allocation here.
>  		 */
> -		if (!ms_hyperv.paravisor_present && !hv_root_partition) {
> +		if (!ms_hyperv.paravisor_present && !hv_root_partition()) {
>  			hv_cpu->synic_message_page =3D
>  				(void *)get_zeroed_page(GFP_ATOMIC);
>  			if (!hv_cpu->synic_message_page) {
> @@ -272,7 +272,7 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	simp.as_uint64 =3D hv_get_msr(HV_MSR_SIMP);
>  	simp.simp_enabled =3D 1;
>=20
> -	if (ms_hyperv.paravisor_present || hv_root_partition) {
> +	if (ms_hyperv.paravisor_present || hv_root_partition()) {
>  		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
>  		u64 base =3D (simp.base_simp_gpa << HV_HYP_PAGE_SHIFT) &
>  				~ms_hyperv.shared_gpa_boundary;
> @@ -291,7 +291,7 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	siefp.as_uint64 =3D hv_get_msr(HV_MSR_SIEFP);
>  	siefp.siefp_enabled =3D 1;
>=20
> -	if (ms_hyperv.paravisor_present || hv_root_partition) {
> +	if (ms_hyperv.paravisor_present || hv_root_partition()) {
>  		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
>  		u64 base =3D (siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT) &
>  				~ms_hyperv.shared_gpa_boundary;
> @@ -367,7 +367,7 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	 * addresses.
>  	 */
>  	simp.simp_enabled =3D 0;
> -	if (ms_hyperv.paravisor_present || hv_root_partition) {
> +	if (ms_hyperv.paravisor_present || hv_root_partition()) {
>  		iounmap(hv_cpu->synic_message_page);
>  		hv_cpu->synic_message_page =3D NULL;
>  	} else {
> @@ -379,7 +379,7 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	siefp.as_uint64 =3D hv_get_msr(HV_MSR_SIEFP);
>  	siefp.siefp_enabled =3D 0;
>=20
> -	if (ms_hyperv.paravisor_present || hv_root_partition) {
> +	if (ms_hyperv.paravisor_present || hv_root_partition()) {
>  		iounmap(hv_cpu->synic_event_page);
>  		hv_cpu->synic_event_page =3D NULL;
>  	} else {
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 5cf9894b9e79..3d9cfcfbc854 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -34,8 +34,11 @@
>  u64 hv_current_partition_id =3D HV_PARTITION_ID_SELF;
>  EXPORT_SYMBOL_GPL(hv_current_partition_id);
>=20
> +enum hv_partition_type hv_curr_partition_type;
> +EXPORT_SYMBOL_GPL(hv_curr_partition_type);
> +
>  /*
> - * hv_root_partition, ms_hyperv and hv_nested are defined here with othe=
r
> + * ms_hyperv and hv_nested are defined here with other
>   * Hyper-V specific globals so they are shared across all architectures =
and are
>   * built only when CONFIG_HYPERV is defined.  But on x86,
>   * ms_hyperv_init_platform() is built even when CONFIG_HYPERV is not
> @@ -43,9 +46,6 @@ EXPORT_SYMBOL_GPL(hv_current_partition_id);
>   * here, allowing for an overriding definition in the module containing
>   * ms_hyperv_init_platform().
>   */
> -bool __weak hv_root_partition;
> -EXPORT_SYMBOL_GPL(hv_root_partition);
> -
>  bool __weak hv_nested;
>  EXPORT_SYMBOL_GPL(hv_nested);
>=20
> @@ -283,7 +283,7 @@ static void hv_kmsg_dump_register(void)
>=20
>  static inline bool hv_output_page_exists(void)
>  {
> -	return hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE);
> +	return hv_root_partition() || IS_ENABLED(CONFIG_HYPERV_VTL_MODE);
>  }
>=20
>  void __init hv_get_partition_id(void)
> @@ -594,7 +594,7 @@ EXPORT_SYMBOL_GPL(hv_setup_dma_ops);
>=20
>  bool hv_is_hibernation_supported(void)
>  {
> -	return !hv_root_partition && acpi_sleep_state_supported(ACPI_STATE_S4);
> +	return !hv_root_partition() && acpi_sleep_state_supported(ACPI_STATE_S4=
);
>  }
>  EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
>=20
> @@ -717,3 +717,23 @@ int hv_result_to_errno(u64 status)
>  	}
>  	return -EIO;
>  }
> +
> +void hv_identify_partition_type(void)
> +{
> +	/* Assume guest role */
> +	hv_curr_partition_type =3D HV_PARTITION_TYPE_GUEST;
> +	/*
> +	 * Check partition creation and cpu management privileges
> +	 *
> +	 * Hyper-V should never specify running as root and as a Confidential
> +	 * VM. But to protect against a compromised/malicious Hyper-V trying
> +	 * to exploit root behavior to expose Confidential VM memory, ignore
> +	 * the root partition setting if also a Confidential VM.
> +	 */
> +	if ((ms_hyperv.priv_high & HV_CREATE_PARTITIONS) &&
> +	    (ms_hyperv.priv_high & HV_CPU_MANAGEMENT) &&
> +	    !(ms_hyperv.priv_high & HV_ISOLATION)) {
> +		pr_info("Hyper-V: running as root partition\n");
> +		hv_curr_partition_type =3D HV_PARTITION_TYPE_ROOT;
> +	}
> +}
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 75eb1390b45c..22afebfc28ff 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2656,7 +2656,7 @@ static int __init hv_acpi_init(void)
>  	if (!hv_is_hyperv_initialized())
>  		return -ENODEV;
>=20
> -	if (hv_root_partition && !hv_nested)
> +	if (hv_root_partition() && !hv_nested)
>  		return 0;
>=20
>  	/*
> diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> index 2a86aa5d54c6..53e4b37716af 100644
> --- a/drivers/iommu/hyperv-iommu.c
> +++ b/drivers/iommu/hyperv-iommu.c
> @@ -130,7 +130,7 @@ static int __init hyperv_prepare_irq_remapping(void)
>  	    x86_init.hyper.msi_ext_dest_id())
>  		return -ENODEV;
>=20
> -	if (hv_root_partition) {
> +	if (hv_root_partition()) {
>  		name =3D "HYPERV-ROOT-IR";
>  		ops =3D &hyperv_root_ir_domain_ops;
>  	} else {
> @@ -151,7 +151,7 @@ static int __init hyperv_prepare_irq_remapping(void)
>  		return -ENOMEM;
>  	}
>=20
> -	if (hv_root_partition)
> +	if (hv_root_partition())
>  		return 0; /* The rest is only relevant to guests */
>=20
>  	/*
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index 3f115e2bcdaa..54ebd630e72c 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -28,6 +28,11 @@
>=20
>  #define VTPM_BASE_ADDRESS 0xfed40000
>=20
> +enum hv_partition_type {
> +	HV_PARTITION_TYPE_GUEST,
> +	HV_PARTITION_TYPE_ROOT,
> +};
> +
>  struct ms_hyperv_info {
>  	u32 features;
>  	u32 priv_high;
> @@ -59,6 +64,7 @@ struct ms_hyperv_info {
>  extern struct ms_hyperv_info ms_hyperv;
>  extern bool hv_nested;
>  extern u64 hv_current_partition_id;
> +extern enum hv_partition_type hv_curr_partition_type;
>=20
>  extern void * __percpu *hyperv_pcpu_input_arg;
>  extern void * __percpu *hyperv_pcpu_output_arg;
> @@ -190,8 +196,6 @@ void hv_remove_crash_handler(void);
>  extern int vmbus_interrupt;
>  extern int vmbus_irq;
>=20
> -extern bool hv_root_partition;
> -
>  #if IS_ENABLED(CONFIG_HYPERV)
>  /*
>   * Hypervisor's notion of virtual processor ID is different from
> @@ -213,6 +217,7 @@ void __init hv_common_free(void);
>  void __init ms_hyperv_late_init(void);
>  int hv_common_cpu_init(unsigned int cpu);
>  int hv_common_cpu_die(unsigned int cpu);
> +void hv_identify_partition_type(void);
>=20
>  void *hv_alloc_hyperv_page(void);
>  void *hv_alloc_hyperv_zeroed_page(void);
> @@ -310,6 +315,7 @@ void hyperv_cleanup(void);
>  bool hv_query_ext_cap(u64 cap_query);
>  void hv_setup_dma_ops(struct device *dev, bool coherent);
>  #else /* CONFIG_HYPERV */
> +static inline void hv_identify_partition_type(void) {}
>  static inline bool hv_is_hyperv_initialized(void) { return false; }
>  static inline bool hv_is_hibernation_supported(void) { return false; }
>  static inline void hyperv_cleanup(void) {}
> @@ -321,4 +327,9 @@ static inline enum hv_isolation_type
> hv_get_isolation_type(void)
>  }
>  #endif /* CONFIG_HYPERV */
>=20
> +static inline bool hv_root_partition(void)
> +{
> +	return hv_curr_partition_type =3D=3D HV_PARTITION_TYPE_ROOT;
> +}
> +
>  #endif
> --
> 2.34.1


