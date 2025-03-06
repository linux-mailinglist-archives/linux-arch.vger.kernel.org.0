Return-Path: <linux-arch+bounces-10559-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F30C7A55678
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 20:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0D3176027
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 19:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6953A26B957;
	Thu,  6 Mar 2025 19:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="aseoHKPT"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2032.outbound.protection.outlook.com [40.92.41.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90DC1A262D;
	Thu,  6 Mar 2025 19:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289001; cv=fail; b=Drslww7YNAE115WCvhYkxNA2PgsOzrr2pq/co4zEXmxoKrz0sxg8vUY4T2kYhlfCOw/a075kBU7RtQVoM8541Zzt8Ys89Bfrq5EqV0rzOeK9rvFXax8YN5yRUEHyxZHNUgaoNTlkEsmRHMZ6tLECbA1pQK4w3S1khD4F2J676KM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289001; c=relaxed/simple;
	bh=qvPPMZtXg5ylVpacP/ix6rYL20GUoz3BjcDVqnbUbpQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ETSjspDllfiMgShyrBGrcmc30c0GLIAwhgOMmR1sl35yMUkYOX9yQHBpfiQz50A7w7NFUEya+U8A420jIFEmb8qdCwGgCsDe/5+7PFA0WeM34C61zyen5BXZC1MrtinBPpALxkyDZ17lq7HpE8fomRnGu2M015Aac52DUay4PZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=aseoHKPT; arc=fail smtp.client-ip=40.92.41.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkIGAD5xaV3jupcIzHGWHezLoDzM8tXkF75dqF04RAoCwSpa6fO3SJVbSR472FCFghHf5eCaUipT1e2Jd9lu+VGfCrgWqp4xEAcjmbifnXZuct5nvbQbpCQeqOgL4rp5VHdCAL5J8FYCEcntOZKN4eA6Fe+uwiYjXM5Q5yGG78moQrHtTIPYrnn4/B3wPNn4m0t+0bzD5uU2ZWoSZEMMHgVczTUTzwNCDQCy+zWw7avn8WI7+QNl0629BGntzrZKdT/iLVGCZzWMkC9jJEO4oqOIy1gtEzrdRuHURuwy+iJ4l0kJYXc1iGXmVcjmLj6q6Up1XwroFEAL8hP/bzxf5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vx4J6Q6VAVkg2JVsE8EDpiA9BoJyxAL58fb2isy9EhI=;
 b=n7MJoaEsx4WWKi2Hd6PV6LPf47Qv3XSrGOo3zOfS3hG5UzyP9zcZTI+KbQ0WfPRHnYlMUjEL4Xl05v3XOkbBPW2lYxKrKtf/Dv0MEs8V0QBI4ToV9VhXONIHXlfrAszGmK7uDYokt3uQEHBGSGvCjkEaCP4QpmuUbObC0QaeXJXQ6aCcCOYxAXoEjUlE4R/wOdh9385H8y6h7x8lZFmpYkiVmhkO++oCMZ/sqip/ShUISUNnCGDC4qVb15pICsTpLsrFf4eMi9X/3ziu0MYQMfkDn3e0EnGVGWr4HnRPeY0zBmOyvXbTKww1JXWlYIXGh+vwiGyCVXGTVAZyH/owRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vx4J6Q6VAVkg2JVsE8EDpiA9BoJyxAL58fb2isy9EhI=;
 b=aseoHKPTxiBeTkrzFEF0Z/+ids5hjB9O+lu5FrD8D4n9av088zdZKnp5QJvI9aI3bO6xmobY+mzdoqJSCDTok2mffqy6PnIzZDoixdrulOhZvlzOI4mnLBpY7kDYNB+kRa0p6ld8l2eC1JOSOxQlG+qi8Hq9n2sZskteZ2qSkUWH9EbUatiPFRl8V2oOK21dKQ8kEgzmIp+dzZ83xHf+QF903lcAHIWNU2N1g0X/UdukoJdFfoXaS9YLWxObo4S/lE5aKTG3jp8253isKjs6WddleYOw351bwF+qzqhe+XJDm61/7oPAOumcy2sTp6jgGynDqzvWk50p1792sZnb3w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA2PR02MB7803.namprd02.prod.outlook.com (2603:10b6:806:142::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Thu, 6 Mar
 2025 19:23:16 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 19:23:16 +0000
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
Subject: RE: [PATCH v5 06/10] Drivers/hv: Export some functions for use by
 root partition module
Thread-Topic: [PATCH v5 06/10] Drivers/hv: Export some functions for use by
 root partition module
Thread-Index: AQHbiKNtW0Y30QgwXES/BYcc94DkpLNmiCvw
Date: Thu, 6 Mar 2025 19:23:15 +0000
Message-ID:
 <SN6PR02MB415706E75693B821FAF0A231D4CA2@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-7-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1740611284-27506-7-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA2PR02MB7803:EE_
x-ms-office365-filtering-correlation-id: 732999b8-5d17-403b-48e4-08dd5ce4584e
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|461199028|19110799003|12121999004|8062599003|8060799006|41001999003|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yuWVpOOn6fmiPxyGpO5RV2yOLcLHNR7e4rcZGULGvxdaoq61tjxm1hdu5Epp?=
 =?us-ascii?Q?0sxO7WT/mn9O9y4UaEhPnJmhs6yoiQpcpLyaFfs3Q9QWAAvEDdXU4Ruhzv+5?=
 =?us-ascii?Q?mosRxYYnuZ44CsyETuvApiV8gAsRzIAjrRsPJhqI5RpvV1+QxRfV63juYg5o?=
 =?us-ascii?Q?FxP1huhds6jPPSndGJvJvcCCQeDvRQSrBokSS8paw3eHNp7A4oRP4hCZvM4M?=
 =?us-ascii?Q?VqsH+PYPU++j6hQYwn2aczS9M/cr+LzTBl7EPc3EF0ZfTEwNrTzraxJdEvPh?=
 =?us-ascii?Q?W4zkgkXhWBw3qlXQhuhC/xd57dTtqZvZowQ+fKIwtS8ATt+2VJmIN+rZOMXF?=
 =?us-ascii?Q?m++ORacEyZtcCJisGkOykmF5mfSjblN//wKXqcMfSRuR/v008ZP1QgvB3rCx?=
 =?us-ascii?Q?YgVj6TT6MDxPO18obe7Xhe/OxxDq/xqZbsYxJPmFUOiKxbtMfNhU3HgwhoAN?=
 =?us-ascii?Q?EmfV5vcwn5tuZD8FRa4xeprhdyzZuzRvduDvRjprncN+jy/lQOqkt1ahCt4E?=
 =?us-ascii?Q?eQF/Xeq6uanP5DluPFrACm13kL6eYaRCElUYWKs8FnPJIfFtLo+3pj2T5TQl?=
 =?us-ascii?Q?qonEQ8psR3LnA7kQP8n7Nvq3eAfBOHKsKc6fSHmwugA1kDy8WImBfBn5nfXL?=
 =?us-ascii?Q?eawAUdwn1rFSdsM1kt95DM3uCIs7JQJgODNPKjjRY8K3y2C8juu8TtOekA1m?=
 =?us-ascii?Q?YHd532sSUhnEaGngWA/njXxLc6WOT/yRWWXPqUtjJi2zEqMztwY2oyrK1rYp?=
 =?us-ascii?Q?oZuvFemr3sVh+YnOX9VkJIv6oVDmohrCeHfG3oBCS+7x2lRoRzC+Moy7dkqp?=
 =?us-ascii?Q?ao+4fceFECQiefpItzDM/oqe3S56s4/GKh0pEbBvHu7c/64mzJpBgl7AdhVv?=
 =?us-ascii?Q?qR2zrr+Yj+BN5DHAnXh15Czs6FpWe9L44+1ApjVrmiVWn4ib21a94lROY/YO?=
 =?us-ascii?Q?6yGzyUruzL2dF/A9Z14aOnPQHjY2cQPtWDOb27tdhHXhFATbR6OZ2TcYnMbW?=
 =?us-ascii?Q?E96t19JaaN9TaL5hWqSch6Q7xaAjPuA92BMioVOMnfPsFF125h4F+kSrD+hB?=
 =?us-ascii?Q?NCPh6NOHpvd6GO+jb80K8uNBXjNjEnivUatFwlJGU0LTWp9HeFE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+aKu4c2eqA3ZJyxmQ1YYVpp4P/XzwG/j7kqLopfcka7ZcOtWICGS4HqF6Bn/?=
 =?us-ascii?Q?tBf8JL+PzczCJkP0P5TmmZNOqKzn6HhP1Cm4usRf9XlXKyysXyAcsuF46r/u?=
 =?us-ascii?Q?yD0/DaWYWQtV87txgoirvnBjXMscgPqiKZogAm3dG7w95LGjDZhOBhpEb/o5?=
 =?us-ascii?Q?1rlGVGAqGaGoJWIInVJAFblPACXcEoAwaXk1fzPaG60mDdYodqwVQXdl7QVt?=
 =?us-ascii?Q?85onpP+gfI7pPhvXqbt138QTmm0xKxuOV+x9BancKmWHb7x7iCzJ7mITINGu?=
 =?us-ascii?Q?xl4FfFFxwDZAYKp8cVBN/cp+PMNa2LPSKcGfdi06WSauXBqrpt6CHqVDAVOv?=
 =?us-ascii?Q?gS/oQ/YekozLeUBU79FGoSuImThjn8BksjrG5iJUDB2121ADf2UHPUVYFr7U?=
 =?us-ascii?Q?0uZqHjF9ZGneOQPv33AJtIbhkfonAupgPRLfnLnSBkuK2ESMW/i2bE5QCzqr?=
 =?us-ascii?Q?ZcSn2zi4BlWYndE8VEqSiqDtjQSHN344Zg7+OE5EShHGD122dZ6FfwvjiHpN?=
 =?us-ascii?Q?8oFtIAAC3q52h9qQwSdKRrIBUfyxq7G3cX4Y2/mlyfUajDqSWAqU5Rr4l9Q6?=
 =?us-ascii?Q?nve68qnAFpH4ArSkgXDDGVeZj/XxUIoTaPd6AQ+HdD2e+MDW6oKi7i4SQTZS?=
 =?us-ascii?Q?A+d/EG3vzm/yPrGvAxCNfUppuk9noSC6T6UCXuyxELB7VhUzyEQWihg7/2AN?=
 =?us-ascii?Q?RoC3+ylUMtxgcgEMcJi29etSCXAUHiMLAKUAyuubN2HCnDezTEiZolp/cxRp?=
 =?us-ascii?Q?08BFKFIAy8Yda7NmMpi4FCopZ3t6vdHLgwTqc3bFgLDf0/53VUOQQfXyb8wt?=
 =?us-ascii?Q?TkCQ/xLWobR2XK1CbacTlNqDrskCjnvK20C7rYkWKGoW7PiYGZC4740AKBML?=
 =?us-ascii?Q?vAL2bFI/g2H+Y6up/2JhToivRpanzAIm79dLfabFoI5U/5g6Itk9f5gK6Tfz?=
 =?us-ascii?Q?9S+nA9bgr+Sr+dcg4FDm2tUTyJtWdiy3P9fPsqtOT4h8HOHPowqkH/854OuA?=
 =?us-ascii?Q?M8APVOsXZ4W9c6OTmT2dzZPARpdHaCKZ8d5/Mo2Vb1SZCE44Yxi4UWd4wVEv?=
 =?us-ascii?Q?+f8DgvK77gr/ISZhTOfYd16twNCKfSsG74r5ChmllhyDDSIDojdONN80s8rt?=
 =?us-ascii?Q?dVb2NJvL0HnzoTCsT6+Kk8509lJt4AkAPDxuNHfTFC5AHqDs2nWZRXY1epH4?=
 =?us-ascii?Q?/ozdGR3v8P8X3XMNkMc2/HIAwccJY7vFI0gGn8Mv2v8fCNLdPG9j4mH1jCU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 732999b8-5d17-403b-48e4-08dd5ce4584e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 19:23:15.9832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7803

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, Fe=
bruary 26, 2025 3:08 PM
>=20

Nit: For the patch Subject line, use prefix "Drivers: hv:" instead of with =
a slash.
That's what we usually use and what you have used for other patches in this
series.

> get_hypervisor_version, hv_call_deposit_pages, hv_call_create_vp,
> hv_call_deposit_pages, and hv_call_create_vp are all needed in module
> with CONFIG_MSHV_ROOT=3Dm.
>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

Modulo the nit:

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  arch/arm64/hyperv/mshyperv.c   | 1 +
>  arch/x86/kernel/cpu/mshyperv.c | 1 +
>  drivers/hv/hv_common.c         | 1 +
>  drivers/hv/hv_proc.c           | 3 ++-
>  4 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index 2265ea5ce5ad..4e27cc29c79e 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -26,6 +26,7 @@ int hv_get_hypervisor_version(union hv_hypervisor_versi=
on_info
> *info)
>=20
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);
>=20
>  static int __init hyperv_init(void)
>  {
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 2c29dfd6de19..0116d0e96ef9 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -420,6 +420,7 @@ int hv_get_hypervisor_version(union hv_hypervisor_ver=
sion_info
> *info)
>=20
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);
>=20
>  static void __init ms_hyperv_init_platform(void)
>  {
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index ce20818688fe..252fd66ad4db 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -717,6 +717,7 @@ int hv_result_to_errno(u64 status)
>  	}
>  	return -EIO;
>  }
> +EXPORT_SYMBOL_GPL(hv_result_to_errno);
>=20
>  void hv_identify_partition_type(void)
>  {
> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> index 8fc30f509fa7..20c8cee81e2b 100644
> --- a/drivers/hv/hv_proc.c
> +++ b/drivers/hv/hv_proc.c
> @@ -108,6 +108,7 @@ int hv_call_deposit_pages(int node, u64 partition_id,=
 u32 num_pages)
>  	kfree(counts);
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
>=20
>  int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
>  {
> @@ -194,4 +195,4 @@ int hv_call_create_vp(int node, u64 partition_id, u32=
 vp_index, u32 flags)
>=20
>  	return ret;
>  }
> -
> +EXPORT_SYMBOL_GPL(hv_call_create_vp);
> --
> 2.34.1


