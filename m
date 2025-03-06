Return-Path: <linux-arch+bounces-10536-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EC7A553BC
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 18:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3C7179351
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 17:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A1E25D53F;
	Thu,  6 Mar 2025 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SgIWpIeD"
X-Original-To: linux-arch@vger.kernel.org
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazolkn19011035.outbound.protection.outlook.com [52.103.7.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C0625D52E;
	Thu,  6 Mar 2025 17:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283871; cv=fail; b=CGPq0t0RyHIB5P24EKJUt1oWGZg60ZlISCQM27K8zFqMwE/jcKPFgSQ77cMUVAw3bTcJUdXBnbDWAoaWpZ/P8n7a1sNQuBZ0GmfvpoakhnYQT/DytxzJrpnu1+WkpNllSqKLZCebQbg792h1ZKpjhL+tKojxSxORtTpvf5MxB9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283871; c=relaxed/simple;
	bh=U+N1ZE/ugkoSnYupmmzt5mtTJ38sCREUBNFYEo7OlNs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AiKm/34UStwuX4qNP0REu+6XnRkit5pbeYl5tvwUjsnk+6GLCVUjBdXNXugzEX4TlKy7fS+H5Zy6bN+r1+Lpc/HNTHQnP7WOIZdHkp5XFy1ThIwud9zeqKVd93aPIoQ0h25tOW+vZADepQlBK6l3NPEG54AmJw6k14VnBT7m1X8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SgIWpIeD; arc=fail smtp.client-ip=52.103.7.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXo2uVHTOn86yTEowS3SYfnh2m0RZ27YpzW5E4GVHrKvwzzuYCZzJAERi1jqY6mr+LWn3Bf15MfZkORUpqskzcluoWulhyhH2nYci1/ZUAC8tH/bNa/N2p9blGnwHkohFyMpWwXn8LsRwsLDbST9/NhSVnYUqYTtQbuZXehi56/6mGjxH9rKhhsdkptbkiOnlSBck7ZmtIC905hcMNKS596zviOF/9HcLc8ousDCxSZf9vaoPN3SDVEnPfdqvyu4YIOgPnI8Z11I7MzWsr8lUQYwXxrNslYZ5Ie191pziSQebGKdMsXInPy+ON5Rm6Ra8D2rYqfjU3XbFeXdnFByvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+dxMXgDLbrG32/f38i9JjHZIUrjfzGchsc4HHXcuLRk=;
 b=dBer98fmClbIxHFnj/3WpFD5upK7ilSE6mHrICRSwjdjvLIuo0zDIiyig9/Atq3/DYfk2yfDItQGtkt6MPxxRg6v+i6q5+lvw7MgeXtnqhKCYxC/tcTKNs7V2RCwmUb1jEp6JCGpguFHlw6Qg0dD6cIwEgn3OQ1RBVKmOXy7RyOzo2VJq1CaoWwMPWO2lTcV2UprKMMO3BltLq10ktQzc7SG8rRcuAYnS3PDdqBArWBXpm5jYPFF1c5KIADkfx7thyOAbIqStg6ZZra1O2gKu3VtlzpdkLFSxbYKPfS5cDGVSKl0qEjpMjBXSlBCauNIbAAhVg792KUlPv3pu0UdpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dxMXgDLbrG32/f38i9JjHZIUrjfzGchsc4HHXcuLRk=;
 b=SgIWpIeDCe03d7bYR9Xj0g12bELvYQpubTs1ZDvmMo5ToMCGeDqqg8XRZIswWrP+HLJBK2cIGsicgOTNsxHsbMSNx85bDg25LhgRQkP4hM8rWwiT/GN5nP3rSiOxsq7r796NBauVJzkJQ+jTmn6Lp6xBldXoQwScSQ7MiaoGE4djDOcjrkR15w8/ZbIrqeqxGCKF7cJiIfOu/xswhJM1SdOOLnDl6KLP03UKsV8uOUyMeGfFYfwnB+YeKaJ4caxjbq3QcOY2G6Y3zE2lfb04j6Ve0Bh71CyzCQ2K1M03NKOj/u6/hxM80vEw11VUf45fc3GaqEhvjRkMgD1brnsXZg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW4PR02MB7476.namprd02.prod.outlook.com (2603:10b6:303:67::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Thu, 6 Mar
 2025 17:57:45 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 17:57:45 +0000
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
Subject: RE: [PATCH v5 01/10] hyperv: Convert Hyper-V status codes to strings
Thread-Topic: [PATCH v5 01/10] hyperv: Convert Hyper-V status codes to strings
Thread-Index: AQHbiKNs/uCEZOh33UCUZSZ5oZ+szbNma5PQ
Date: Thu, 6 Mar 2025 17:57:44 +0000
Message-ID:
 <SN6PR02MB41577560030C55503D1BAFDCD4CA2@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-2-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1740611284-27506-2-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW4PR02MB7476:EE_
x-ms-office365-filtering-correlation-id: f39e481c-b6cf-469d-7ccf-08dd5cd865e7
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799003|8060799006|8062599003|15080799006|12121999004|102099032|13041999003|440099028|3412199025|12091999003|41001999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hZzawpkJrxmSN/MDMpqJGDgz26ApBWsnXLI5x0U4/XkTjI1q9IVpRRQvkMWL?=
 =?us-ascii?Q?vrWVv8g2o8Lw9aTzkq9AWmL6+cwNm93Gc4tF3yZY9UBiAQx4j0BiZ/FnCxW0?=
 =?us-ascii?Q?tMUflixfjkNyx2gWXYjvW5gOOl5YwZlio9ul9Cx0NdNclh6grJPau2O2tZaX?=
 =?us-ascii?Q?SVhFtvEp9IMCqB9F1K6zCLefjQ9FNZF5y5yWDwOXFJBAKHKud9Mqkbjda4HA?=
 =?us-ascii?Q?SEbk00BpWX4MHGpEHPZCusRRkSNfdO/VTXpmAbyR9oomkFwN3iuxm77ul7xd?=
 =?us-ascii?Q?SfOnoJ3FKiJ04vvt16QAFZkMeALRVi2WE1paXpBeehucYh5LwHyBSexxlf4y?=
 =?us-ascii?Q?Dxwqb+ng/bq1TNBzkA4WKbBqEb97J7TRGrImPPmkJi4Ht7n4K2TsD8z9RUhT?=
 =?us-ascii?Q?riXBIbsA9X65pzFpSCduwUBjG2kletHbOKn/ju8SxwY8mxFx/BtfkLWf8MUf?=
 =?us-ascii?Q?RL/LRr6od4HXnU+HcQeUTbrdrE6KoDjanHww3KULdydT/j4mtT1ICKIDBLH3?=
 =?us-ascii?Q?29cm8L/vlG0FeHDsQ60u3e3sf5lg2Cj7hSqF9C7RBZdgu234OZCkA4IrGh4A?=
 =?us-ascii?Q?0tYHkBomS/Xf1mWHgRBT6O1snwDcxTZftwl+w4XQHPqIKqIWRnn0ocVdLv3c?=
 =?us-ascii?Q?7c3lXquV02UJRtoOgHl/qs6WMb3rCZjGnLHi63b5ub5v9LLt7BEwQlS8ToHR?=
 =?us-ascii?Q?heMwuH50i0lj/F8WlKX7lb1tRUeGdNzRPbXsNDlQBJILKNxrD1IO7uB5frP0?=
 =?us-ascii?Q?+hZ/tNa51CvWIzae+HLjiVZcJpsGIdLMr3arcFSKBMcxTWYrSBGnygYdDhZN?=
 =?us-ascii?Q?Ei4Urd9OK5GWppmvL4er1GV8S0awQdJnLnxefezCY+vByxEvHjk786Y9t/2f?=
 =?us-ascii?Q?D3VefSrhkDXpK/BCorfgIE3TpCjqnTLXmeJcI4c5sgUA3v9mTkSWunuJqSUs?=
 =?us-ascii?Q?i+1+Htdmr/ULiIvaXrMaY0s6ZxRdgkuYIWzBjL7dbUS9VeQycN7zxvaQ+QZR?=
 =?us-ascii?Q?UW70FBiDi5ylJBs7mAI1ZaVOC1BOLfsY5LRvP4jfL7k//1fDat7xJuJs0fYK?=
 =?us-ascii?Q?TjNGr9cLfvz7PdFUfIl3vXvAnjYk69SRvhXtLQyym3lGjv4VUFtymZ25JokA?=
 =?us-ascii?Q?jCpDw9pfpCf4wr0f9t0zODiRX1xwefxlQnI5qlsrMaiDjUidVUt9sJg=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?u8uFEyIWHgowUZWtSLKihC7OUItTGqk5jLQrSN4Yzgei/QZYkkolKC+mLlQl?=
 =?us-ascii?Q?C6VDRknmVuwqyGOKnQuzFfMtNWm+0Zjh1T9cYD4z7KnTies/6UKOxJcfK1eY?=
 =?us-ascii?Q?mX4PaCpE/dcSx6lL6MP9OkURUlNFoxIfxCLXcKWDt9yfDHHLHOkYKp1tkKtL?=
 =?us-ascii?Q?YagMyKg0Jw8pmESgmmXnDkeCxupTB7Pl26yovhUAfFWm9hIFJ6Qjyo+ywz7T?=
 =?us-ascii?Q?k4914ThSBjujDdfIoq/lu2U98jT9xdc3fN9LAW5KJ3929P61MxIDccVF24yN?=
 =?us-ascii?Q?7ro5i5uoWPrZ7GGIvK8ovITMKnULeN3XtmBsO7dOsod1MSBayYstl/zSu1Sb?=
 =?us-ascii?Q?PVZXLSULsSdV6TCipyfRN8z+uZ/w+fY5IOdmqwMMV7nXX/rjD0WgUOX8m9+D?=
 =?us-ascii?Q?p6/qIITJCMPKEO4AQ8KZtp4c+5fI3lZzQgEMVeRXBbS+U57oBlsraazGbQZC?=
 =?us-ascii?Q?Y399uqJ4oQuZoX1OaVs67GktJa992PzHEY0yqXKWk2uOQdCOpK6b+eXdPm1n?=
 =?us-ascii?Q?pDB9VB8KDaXh7qMU6jIUXsXR6jC8Um5Bq6yemC7jHiFGaFqcSTekOzKWzDiv?=
 =?us-ascii?Q?7RGgtkh52L8v2ORN9AP7BHFr6HRgGPQ6r6eBjrwRklvz+N5++CTF4g1Yt1To?=
 =?us-ascii?Q?97KXY3yTtsHcY2gq5IKBbTAWoiCry5rlHzXku6ePxOgEIR0rzH580S1guBDs?=
 =?us-ascii?Q?LEJfrD5yTYV+HsoVW+dV1H2TVnjbkMndBm2gYKelrojAfijjyFxhyecN47lL?=
 =?us-ascii?Q?Qojy0HJSjAxzMdbyKT9VkSge0tSGuZl1dTS+vn0OH5q9QfWPCPjPZ4795Fr4?=
 =?us-ascii?Q?95tLyZXx1wroLqsrUoBZiYEoGfw9ki53R2mk0yPvVuXBJeZj2wF1btZ36icd?=
 =?us-ascii?Q?MFAbJqm1uBRFLJ5eW0snTOk/Pp8Xh7CFj9jVK8ZzR7BPBJ9i2J3G3KjzvdeZ?=
 =?us-ascii?Q?LzwNCLt3scQLwbgkkVrAqLEPj2pg4IV9Poeqfp0BhMD7FwdiwthCSiEEHUUs?=
 =?us-ascii?Q?8GfzzU420jCciRRuY4UsjXrSs3l8oLLKedkDmTmhI/S6Ws/PFwpiFUyoLFbM?=
 =?us-ascii?Q?t8Q4BBXeJEzgv0MNQ/i6V4ANH/gwssAzOvg4/OT8a9bUiNzNAdo9tLyev2yh?=
 =?us-ascii?Q?BMeiFf1I7qcP9NYwX3sbU4uxC3MGNOZfEwa0tzUTYiN20yOeUL/FBLgM9+Z5?=
 =?us-ascii?Q?vAmsgeQc5ErDkzd7Z+1GDvJxSpTqrlwTb5ERbDv8KCO4X0e1ZCW/6+IOLBE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f39e481c-b6cf-469d-7ccf-08dd5cd865e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 17:57:44.8379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7476

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, Fe=
bruary 26, 2025 3:08 PM
>=20
> Introduce hv_result_to_string() for this purpose. This allows
> hypercall failures to be debugged more easily with dmesg.
>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/hv_common.c         | 65 ++++++++++++++++++++++++++++++++++
>  drivers/hv/hv_proc.c           | 13 ++++---
>  include/asm-generic/mshyperv.h |  1 +
>  3 files changed, 74 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 9804adb4cc56..ce20818688fe 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -740,3 +740,68 @@ void hv_identify_partition_type(void)
>  			pr_crit("Hyper-V: CONFIG_MSHV_ROOT not enabled!\n");
>  	}
>  }
> +
> +const char *hv_result_to_string(u64 hv_status)
> +{
> +	switch (hv_result(hv_status)) {
> +	case HV_STATUS_SUCCESS:
> +		return "HV_STATUS_SUCCESS";
> +	case HV_STATUS_INVALID_HYPERCALL_CODE:
> +		return "HV_STATUS_INVALID_HYPERCALL_CODE";
> +	case HV_STATUS_INVALID_HYPERCALL_INPUT:
> +		return "HV_STATUS_INVALID_HYPERCALL_INPUT";
> +	case HV_STATUS_INVALID_ALIGNMENT:
> +		return "HV_STATUS_INVALID_ALIGNMENT";
> +	case HV_STATUS_INVALID_PARAMETER:
> +		return "HV_STATUS_INVALID_PARAMETER";
> +	case HV_STATUS_ACCESS_DENIED:
> +		return "HV_STATUS_ACCESS_DENIED";
> +	case HV_STATUS_INVALID_PARTITION_STATE:
> +		return "HV_STATUS_INVALID_PARTITION_STATE";
> +	case HV_STATUS_OPERATION_DENIED:
> +		return "HV_STATUS_OPERATION_DENIED";
> +	case HV_STATUS_UNKNOWN_PROPERTY:
> +		return "HV_STATUS_UNKNOWN_PROPERTY";
> +	case HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE:
> +		return "HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE";
> +	case HV_STATUS_INSUFFICIENT_MEMORY:
> +		return "HV_STATUS_INSUFFICIENT_MEMORY";
> +	case HV_STATUS_INVALID_PARTITION_ID:
> +		return "HV_STATUS_INVALID_PARTITION_ID";
> +	case HV_STATUS_INVALID_VP_INDEX:
> +		return "HV_STATUS_INVALID_VP_INDEX";
> +	case HV_STATUS_NOT_FOUND:
> +		return "HV_STATUS_NOT_FOUND";
> +	case HV_STATUS_INVALID_PORT_ID:
> +		return "HV_STATUS_INVALID_PORT_ID";
> +	case HV_STATUS_INVALID_CONNECTION_ID:
> +		return "HV_STATUS_INVALID_CONNECTION_ID";
> +	case HV_STATUS_INSUFFICIENT_BUFFERS:
> +		return "HV_STATUS_INSUFFICIENT_BUFFERS";
> +	case HV_STATUS_NOT_ACKNOWLEDGED:
> +		return "HV_STATUS_NOT_ACKNOWLEDGED";
> +	case HV_STATUS_INVALID_VP_STATE:
> +		return "HV_STATUS_INVALID_VP_STATE";
> +	case HV_STATUS_NO_RESOURCES:
> +		return "HV_STATUS_NO_RESOURCES";
> +	case HV_STATUS_PROCESSOR_FEATURE_NOT_SUPPORTED:
> +		return "HV_STATUS_PROCESSOR_FEATURE_NOT_SUPPORTED";
> +	case HV_STATUS_INVALID_LP_INDEX:
> +		return "HV_STATUS_INVALID_LP_INDEX";
> +	case HV_STATUS_INVALID_REGISTER_VALUE:
> +		return "HV_STATUS_INVALID_REGISTER_VALUE";
> +	case HV_STATUS_OPERATION_FAILED:
> +		return "HV_STATUS_OPERATION_FAILED";
> +	case HV_STATUS_TIME_OUT:
> +		return "HV_STATUS_TIME_OUT";
> +	case HV_STATUS_CALL_PENDING:
> +		return "HV_STATUS_CALL_PENDING";
> +	case HV_STATUS_VTL_ALREADY_ENABLED:
> +		return "HV_STATUS_VTL_ALREADY_ENABLED";
> +	default:
> +		return "Unknown";
> +	};
> +	return "Unknown";
> +}
> +EXPORT_SYMBOL_GPL(hv_result_to_string);
> +
> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> index 2fae18e4f7d2..8fc30f509fa7 100644
> --- a/drivers/hv/hv_proc.c
> +++ b/drivers/hv/hv_proc.c
> @@ -87,7 +87,8 @@ int hv_call_deposit_pages(int node, u64 partition_id, u=
32
> num_pages)
>  				     page_count, 0, input_page, NULL);
>  	local_irq_restore(flags);
>  	if (!hv_result_success(status)) {
> -		pr_err("Failed to deposit pages: %lld\n", status);
> +		pr_err("%s: Failed to deposit pages: %s\n", __func__,
> +		       hv_result_to_string(status));
>  		ret =3D hv_result_to_errno(status);
>  		goto err_free_allocations;
>  	}
> @@ -137,8 +138,9 @@ int hv_call_add_logical_proc(int node, u32 lp_index, =
u32 apic_id)
>=20
>  		if (hv_result(status) !=3D HV_STATUS_INSUFFICIENT_MEMORY) {
>  			if (!hv_result_success(status)) {
> -				pr_err("%s: cpu %u apic ID %u, %lld\n", __func__,
> -				       lp_index, apic_id, status);
> +				pr_err("%s: cpu %u apic ID %u, %s\n",
> +				       __func__, lp_index, apic_id,
> +				       hv_result_to_string(status));
>  				ret =3D hv_result_to_errno(status);
>  			}
>  			break;
> @@ -179,8 +181,9 @@ int hv_call_create_vp(int node, u64 partition_id, u32=
 vp_index,
> u32 flags)
>=20
>  		if (hv_result(status) !=3D HV_STATUS_INSUFFICIENT_MEMORY) {
>  			if (!hv_result_success(status)) {
> -				pr_err("%s: vcpu %u, lp %u, %lld\n", __func__,
> -				       vp_index, flags, status);
> +				pr_err("%s: vcpu %u, lp %u, %s\n",
> +				       __func__, vp_index, flags,
> +				       hv_result_to_string(status));
>  				ret =3D hv_result_to_errno(status);
>  			}
>  			break;
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index b13b0cda4ac8..dc4729dba9ef 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -298,6 +298,7 @@ static inline int cpumask_to_vpset_skip(struct hv_vps=
et *vpset,
>  	return __cpumask_to_vpset(vpset, cpus, func);
>  }
>=20
> +const char *hv_result_to_string(u64 hv_status);
>  int hv_result_to_errno(u64 status);
>  void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die);
>  bool hv_is_hyperv_initialized(void);
> --
> 2.34.1

I've read through the other comments on this patch. I definitely vote
for outputting both the hex code along with a string translation, which
could be empty if the hex code is unrecognized by the translation code.

I can see providing something like hv_hvcall_err() as Nuno proposed, since
that standardizes the text output. But I wonder if it would be too limiting=
.
For example, in the changes above, both hv_call_add_logical_proc() and
hv_call_create_vp() output additional debugging values, which we probably
don't want to give up.

Lastly, from an implementation standpoint, rather than using a big
switch statement, build a static array of entries that each have the
hex code and string equivalent. Then hv_result_to_string() loops through
the array looking for a match. This won't be any slower than the big switch
statement. I've seen other places in the kernel where string names are
output, and looking up the strings in a static array is the typical approac=
h.
You'll have to work through the details and see if avoids being too clumsy,
but I think it will be OK.

Michael

