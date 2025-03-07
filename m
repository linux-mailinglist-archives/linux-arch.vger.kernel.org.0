Return-Path: <linux-arch+bounces-10566-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9901DA56E87
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 18:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7B9E189A623
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 17:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9869423C8A4;
	Fri,  7 Mar 2025 17:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="B3TAehZu"
X-Original-To: linux-arch@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012067.outbound.protection.outlook.com [52.103.14.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C26621A44A;
	Fri,  7 Mar 2025 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741366962; cv=fail; b=ny1Y0SYosZjUBy8gFFP2eB5ZjsVGF3HLZqB6HLC5o7fk/jpjJAjnVO3p5U6iaasd1DB3fFto3EtQRhBVA9cBqI8zf0sE+RU2R8wmL/X7mVOjX+KBik8wXsGUBE7RqJYH1VevPt3Xqmvanhw6HhZh93FGs6iDASq/w/9eN2/0zOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741366962; c=relaxed/simple;
	bh=XecRZFk69u8blN9U3PJFts550K4wxhXp6mgeeNAKszI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xnm6BZs6aD+rO1oMFRhuPxS2T8y2S7CoVPo8vL+pFD/SyirgN3lnqjpKDlALBXfVpu6TXVVswYYC9fl4Ojgs5Qft/JhcVX43fXYcxKf62wjkwIa0pxZH0yIcOXtzx53fa/XT7Nhg2kF/WIZHI//LjBMOjgQPmD0C+YtIB1apWyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=B3TAehZu; arc=fail smtp.client-ip=52.103.14.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YG6Qc8/CdwJq1W7jS9+siH+MuLKbQXP02+2+TJ5qcJ6k043O/f40aHPTeDlh6Swlcf3cpdsUY1t65/dtWOwSb7tq4kSUysiqfCqW9LY6aeuFAuPTIuEPJ9k8rOyuhPLIiiqpI+NaS++bTnbcyem0rADOT2Z8AK0vfFMhRkS8FRntS1tIhInh+i0J5HmCsY5mJ2+FggT04WSjX5tz4MTL+Bn7WPT0ji+BbI87WuTTlZutZjuTOFO/0pkFJa2E6Tf7eJDWT6rAxW5FsUkvdQ8VYWVsc97Neomv3W+RnDGH1uOW6AqcyBCkX/DpING1rB6doRyHNTc5yHhEGYQdoGbmug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rahVUTEYeBGGKp+mxWbsSBQt3YtxaSk36JFl9AHq91M=;
 b=tngp60+7NPwPIWyTZWkE1yzAmFdBYPljf4alYydKewGEiwOTlapx2wqdAC7Ejj0oNhdA43raF7UMLXkg2OE2yCqxOcSSJNutcZK/0G6V9krUbYjNllH1K8t0q+2xu6U8SYK0H8yrRDw36ip3qdRS0uUFzSR8tslsqYTJpsDqthX67IzTmhcTUklBBpj9pBcdMUPW9Qx74TnJiv9O0JF17i4oBasQ2xc2CQMRUMlZc+wk5FjcpdgOlImKbvB9O/pNjyidXN1Jcnjn2skgolejhjVtDgzzMawWnGoYh64KsXkQ9kkQ1/0/EqQxWrv3vk63puTHZfVZj7X4NhmQlPR+4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rahVUTEYeBGGKp+mxWbsSBQt3YtxaSk36JFl9AHq91M=;
 b=B3TAehZuVQkNwyWTG8soWMWZWGm2mormQkmPNNYBbYqe1DNBDDnDgEPFUAntMFcRzVj/ls9r3fW2jV1v3b5EdZXXnqP/stl5pAFt8lETOkAXB0kBVAhvZvIZcrIZ0UkPsYKMXyYiVcFy2aBUDrgpFTQHD/077ICiSxISGLhYLL/xX6p+vpdXQjAFmly4Pp4+/9NYBVImLX9hdjjqZYcAEcya2u3EFH4eKG/RXi2UjvbcymGSYEzoR9QvM4CpkSbQd6H2ejpDzyY/hiGo7ZLKQ35yBcWB/ECjy8wVAffg2mO2xzYXBE06ERr+CIgkTBnSGjanKHTo2obN1aRMd5Ehyg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW4PR02MB7441.namprd02.prod.outlook.com (2603:10b6:303:74::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Fri, 7 Mar
 2025 17:02:36 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 17:02:36 +0000
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
Subject: RE: [PATCH v5 07/10] Drivers: hv: Introduce per-cpu event ring tail
Thread-Topic: [PATCH v5 07/10] Drivers: hv: Introduce per-cpu event ring tail
Thread-Index: AQHbiKNvTQlMQtRMy0ySwjthERjeILNn7PMQ
Date: Fri, 7 Mar 2025 17:02:35 +0000
Message-ID:
 <SN6PR02MB4157107676CF415A464C2C25D4D52@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-8-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1740611284-27506-8-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW4PR02MB7441:EE_
x-ms-office365-filtering-correlation-id: 43f3bb7a-b48e-4c2c-e48e-08dd5d99dbf9
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|15080799006|19110799003|461199028|8062599003|440099028|3412199025|102099032|12091999003|41001999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JMDqqU4XLNdsz14BkjMzMbJplbkvKvqW00VvjzM4xhdX13ZJ+gpGMFLnXxgy?=
 =?us-ascii?Q?PPqB35ROj1/voFP7hKTjP+j/rnTCVDTLOPrFqvhvldJoNcQmLVMOxfBr473z?=
 =?us-ascii?Q?7j5zfQgDTLoVKBxFrzlRq0SI4Tbafvu3je2MJ790IYor9h6SvVJp8HLTNFwy?=
 =?us-ascii?Q?z4cyYcGDtgEfgHmECagmHZCR9BIhJlAas1TlBW1U2Vo1cvAApJUyrJ9ge/CO?=
 =?us-ascii?Q?/IogUOkxqPaPtbTDds/9757nW9m5UxREvM2jO1DvyRkjtCorcVNafBd3eZ7n?=
 =?us-ascii?Q?A4+m82wBOOoTS1nDjl/OZtSNwU5lfwnPX6CFsrKa9D5RRoi8HJ2c/hFy0eAI?=
 =?us-ascii?Q?ecOz/gjBdwQOrCxeulvTuDSfRss2E7f4scj56ShAzhft4d7brFTFa/nJBIfn?=
 =?us-ascii?Q?IV8b5xYCCFVQwWjqA/3gXmzrKE07OlFcl0XDbXNxOmz0LMfFYR5ec3pf1MVZ?=
 =?us-ascii?Q?YcscDeRqTAtxDCga6enwLt/6LfkNNKTuQhNAYIP1d7WGR5uXiXo78FSfJoUP?=
 =?us-ascii?Q?YlCvg4+KTB074wOMSk/lk6sirXUyA03vXW+aOPCk8BxNT6zNofmv6Zf9A+xB?=
 =?us-ascii?Q?RtnmdN1oS9udPIrBrPyuWhctSukwELRhbrTndUY8WX/Sg4CjcbOzHB3AhyCx?=
 =?us-ascii?Q?bTYozBLF4QNoWZU4lp7FG2By+i4yI/uN5KuUic99aEotlEOkxgIIPm5oCD4R?=
 =?us-ascii?Q?HP3xcmkiB3zvr+Hef+55ibBSX3EfGv7yJO/DiuNhDIcj2CZgiuXeQA8OnD7D?=
 =?us-ascii?Q?rtrsHR+QnhZlVNJDGMTEWNqWukNu4VaanPG7pfl7BZPgfv8rE4jK8bE9qLaC?=
 =?us-ascii?Q?t6DduT72Kixw4K1CR9qJp1onlDjX7WabPwb5Flli5TWLXxmEoMskDtrp8ggS?=
 =?us-ascii?Q?EP9FvZnCh62HDuqH2HdUI3GFdVa5AUvu5jB8GNdoUD0wfPgRgrrLadpy8emm?=
 =?us-ascii?Q?cEKm/lt6x/trZgIftSOoODwCbcUAShjZMb1sKAK2uAMcqw8CVuGshAVOrqEA?=
 =?us-ascii?Q?JE8/7xObq/XacNwdOKo/jVwyoNzWVAEWonck8y7D8AgerW0r57zx4BYnhtAA?=
 =?us-ascii?Q?BCT9giSHrk5agFMMVo2hVSMmYdrBe7OaiKGCgZwH7UcSS/bM8kc=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?a0a+FKaddx8RGjtei8gf5u6W2dt0PSMZUWr122Dmc8RM09nc1gB7UXM9BaxV?=
 =?us-ascii?Q?+P9oemKgRL8PsREHrCddZVyQ9seMOMGHE0AzuevcLVYL35PkblmFxWyScxFl?=
 =?us-ascii?Q?TdC/UY6u5uBjP9il5xuE2907HO0ysrMPeZrNSQMw3mcYaPF8PykN/FKluCoG?=
 =?us-ascii?Q?94aPEMVRvmDnHW4TARR4CFey7L/iMvdnU5MAi9nacVpUM57UsTJzx8Zu+Fgb?=
 =?us-ascii?Q?Fg0biUZGfVx4AL1w2C8uIo9kkYgp1SmmX+m5fymFe5nxrAQJlBM86nS22WeJ?=
 =?us-ascii?Q?FhSdTxf7RDjoRUjkRTK5xOD9hfUraR8ezuJC4rmV7wkPYync9QxkN0oQUlMQ?=
 =?us-ascii?Q?HD5CY43hl2s7jitYGTsWV/BvdBwBl8QL6USAuXr87H6xAh+9FvOUmgCE7prQ?=
 =?us-ascii?Q?3DP7481KuxVcmHUvFUI5mDbOD1xJPUEhQY27B9OtvxhgcjWXqi+8cluQizyI?=
 =?us-ascii?Q?QBnr5TsfsXUcXUZ9yojDY3yL36TEZL9A6+Fya1/6ObI8Q5tlfKyxBb41EiOR?=
 =?us-ascii?Q?4K1oZiwSSDiiVCxpsAKg5A0ukts4xa0gPqP6FB8AgMakLtS49bYbFa5usX3B?=
 =?us-ascii?Q?30qgvNz8nJBa+ym9rdFbXLZqGYIxqWcbUZLK1QLbhmouf1QpRZ0VnZYYJNFJ?=
 =?us-ascii?Q?RTzakGGHADiMi/+4FVOGbJ3E9F2YoYJsOcZTrrrODdD+X3Bb2QHRrB7KM/1/?=
 =?us-ascii?Q?pME/Hr+sY4ERYN8cC0V/22LUuTa+AlmIu8Ki+IJd7gRSMQf5pjD3GIESLcEB?=
 =?us-ascii?Q?96+KTqv/waSrvGbccJnhNyQ/9RzQlE/mdfAoUjZcx7qfXWdU2LycWwk0hMet?=
 =?us-ascii?Q?CtuLvBakY1dsfzsMIhEscEzw8rfi45ix50oZASlWa7JPVDA7gCT1bwrDk2ma?=
 =?us-ascii?Q?dMMpggnzgcwCTFLLItvtD3LNuNfjb7F/SYyH4O+euP93BNAahJf73fUczH8g?=
 =?us-ascii?Q?iESu8FX/przaY0leVb26DKEw1d08BZ91CQnu+Z9ZW5aCt8eTn2FJakjNF1S/?=
 =?us-ascii?Q?MTlltzH7eLQdw0S94r97zGp5P7lSDbWMpHN5yCnWqySTBpPHm04TWbSbNVzG?=
 =?us-ascii?Q?T6WI2dHh6JxmLp+65hG8OwuvBFu48jjWJDz7B8U5xPH0jZoYxhE7npZC8mmE?=
 =?us-ascii?Q?8rDp1y6c+HR3lWMVzRiL2JqO0hCnUEuE5KecOraDk+rLdlSeJ/0qQ9Rxe/CN?=
 =?us-ascii?Q?cBRWjBS/eoPE/Dtac6/4rSuxLfviw+Dwei1cpz4MCRb66dj+WHmvt6cpzkc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f3bb7a-b48e-4c2c-e48e-08dd5d99dbf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 17:02:35.8398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7441

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, Fe=
bruary 26, 2025 3:08 PM
>=20
> Add a pointer hv_synic_eventring_tail to track the tail pointer for the
> SynIC event ring buffer for each SINT.
>=20
> This will be used by the mshv driver, but must be tracked independently
> since the driver module could be removed and re-inserted.
>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Wei Liu <wei.liu@kernel.org>
> ---
>  drivers/hv/hv_common.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 252fd66ad4db..2763cb6d3678 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -68,6 +68,16 @@ static void hv_kmsg_dump_unregister(void);
>=20
>  static struct ctl_table_header *hv_ctl_table_hdr;
>=20
> +/*
> + * Per-cpu array holding the tail pointer for the SynIC event ring buffe=
r
> + * for each SINT.
> + *
> + * We cannot maintain this in mshv driver because the tail pointer shoul=
d
> + * persist even if the mshv driver is unloaded.
> + */
> +u8 __percpu **hv_synic_eventring_tail;

I think the "__percpu" is in the wrong place here. This placement
is likely to cause errors from the "sparse" tool.  It should be

u8 * __percpu *hv_synic_eventring_tail;

See the way hyperv_pcpu_input_arg, for example, is defined.  And
see commit db3c65bc3a13 where I fixed hyperv_pcpu_input_arg.

> +EXPORT_SYMBOL_GPL(hv_synic_eventring_tail);

The "extern" declaration for this variable is in Patch 10 of the series
in drivers/hv/mshv_root.h. I guess that's OK, but I would normally
expect to find such a declaration in the header file associated with
where the variable is defined, which in this case is mshyperv.h.
Perhaps you are trying to restrict its usage to just mshv?

> +
>  /*
>   * Hyper-V specific initialization and shutdown code that is
>   * common across all architectures.  Called from architecture
> @@ -90,6 +100,9 @@ void __init hv_common_free(void)
>=20
>  	free_percpu(hyperv_pcpu_input_arg);
>  	hyperv_pcpu_input_arg =3D NULL;
> +
> +	free_percpu(hv_synic_eventring_tail);
> +	hv_synic_eventring_tail =3D NULL;
>  }
>=20
>  /*
> @@ -372,6 +385,11 @@ int __init hv_common_init(void)
>  		BUG_ON(!hyperv_pcpu_output_arg);
>  	}
>=20
> +	if (hv_root_partition()) {
> +		hv_synic_eventring_tail =3D alloc_percpu(u8 *);
> +		BUG_ON(hv_synic_eventring_tail =3D=3D NULL);
> +	}
> +
>  	hv_vp_index =3D kmalloc_array(nr_cpu_ids, sizeof(*hv_vp_index),
>  				    GFP_KERNEL);
>  	if (!hv_vp_index) {
> @@ -460,6 +478,7 @@ void __init ms_hyperv_late_init(void)
>  int hv_common_cpu_init(unsigned int cpu)
>  {
>  	void **inputarg, **outputarg;
> +	u8 **synic_eventring_tail;
>  	u64 msr_vp_index;
>  	gfp_t flags;
>  	const int pgcount =3D hv_output_page_exists() ? 2 : 1;
> @@ -472,8 +491,8 @@ int hv_common_cpu_init(unsigned int cpu)
>  	inputarg =3D (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
>=20
>  	/*
> -	 * hyperv_pcpu_input_arg and hyperv_pcpu_output_arg memory is already
> -	 * allocated if this CPU was previously online and then taken offline
> +	 * The per-cpu memory is already allocated if this CPU was previously
> +	 * online and then taken offline
>  	 */
>  	if (!*inputarg) {
>  		mem =3D kmalloc(pgcount * HV_HYP_PAGE_SIZE, flags);
> @@ -485,6 +504,17 @@ int hv_common_cpu_init(unsigned int cpu)
>  			*outputarg =3D (char *)mem + HV_HYP_PAGE_SIZE;
>  		}
>=20
> +		if (hv_root_partition()) {
> +			synic_eventring_tail =3D (u8 **)this_cpu_ptr(hv_synic_eventring_tail)=
;
> +			*synic_eventring_tail =3D kcalloc(HV_SYNIC_SINT_COUNT,
> +							sizeof(u8), flags);
> +
> +			if (unlikely(!*synic_eventring_tail)) {
> +				kfree(mem);
> +				return -ENOMEM;
> +			}
> +		}
> +

Adding this code under the "if(!*inputarg)" implicitly ties the lifecycle o=
f
synic_eventring_tail to the lifecycle of hyperv_pcpu_input_arg and
hyperv_pcpu_output_arg. Is there some logical relationship between the
two that warrants tying the lifecycles together (other than just both being
per-cpu)?  hyperv_pcpu_input_arg and hyperv_pcpu_output_arg have an
unusual lifecycle management in that they aren't freed when a CPU goes
offline, as described in the comment in hv_common_cpu_die(). Does
synic_eventring_tail also need that same unusual lifecycle?

Assuming there's no logical relationship, I'm thinking synic_eventring_tail
should be managed independent of the other two. If it does need the
unusual lifecycle, make sure to add a comment in hv_common_cpu_die()
explaining why. If it doesn't need the unusual lifecycle, maybe just do
the normal thing of allocating it in hv_common_cpu_init() and freeing
it in hv_common_cpu_die().

The code as written in your patch isn't wrong and would work OK. But
the structure implies a relationship with hyperv_pcpu_*_arg that I
suspect doesn't exist.

Michael

>  		if (!ms_hyperv.paravisor_present &&
>  		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
>  			ret =3D set_memory_decrypted((unsigned long)mem, pgcount);
> --
> 2.34.1


