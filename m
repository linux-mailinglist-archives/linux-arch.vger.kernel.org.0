Return-Path: <linux-arch+bounces-10263-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6E2A3E49F
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 20:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF853B28EC
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 19:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864722641CA;
	Thu, 20 Feb 2025 19:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dMC+QE6d"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2077.outbound.protection.outlook.com [40.92.42.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F832638B4;
	Thu, 20 Feb 2025 19:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740078244; cv=fail; b=mzvv0bS3CHXRZBPnv1aj5X4BBesvvhWZqPXYxa8D0CWibKylK9AoSrP3F78X3HAnBW9FjhCvTudT4exIt4LThQ2s1ocr7Y+841UuooQPQB7+jQ5VWAkYLHPfAAs2tYbNhpwwxWhb7BZds02qWwbg5A9qywjScBRzyhQ1B33oS9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740078244; c=relaxed/simple;
	bh=rYvB8pjfrT7gAAjBht3VyxkR2OIfW+nHVfj2S3f0HYI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iPefoOfzWCjovbwXdgAFnL/RVcnpZV+ycSgtit6slljWu9nx9FDNJATgcYfB+kvLE1qePVm7yV/jEQtTl7orgPzIbPvn15jORSpoPEbcjpd+Qrj0LeqrZCbTYWD+0fD4mS6+m/e4C2dgQjf2lVvXos9aUlBRwMvdi7cjpE30qrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dMC+QE6d; arc=fail smtp.client-ip=40.92.42.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jH9ZkWhlb9ugW7sCDIC7OetTvQqOi7qaVbE8rfLnObQ7DEQIVctjiNxC28RpXzEwQSjfrf0UFmwL1GxHrK6R/gLr3AaFEUCLqLHMF93fiSmbm9kkUPflLDfxXVZhO8TKAnpS9eWI5FP3WfpkKMQyqh3wepS0yU8/bfYXTKIb8BBuD2Rpcd6dmx0XatXDONjeyEdlRC/ggr8I3CgXjhMDc3ESxEr5U8xJy6YUVvPrVjqm5g2DRqZUD/aXwitex2I6NaGwlbeXqhXN13ByKPxfYCs7fazy/bR4H/vth1gBvSv76od1H2ZRrc0i6vIWmYMlFaKXVqSrDY2OQJi032yBYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fNJMJg4J5lkpuTo3jUM8wnT0SZMmFs7IKldfkXNjhQ=;
 b=QSbdeAe+endbfbRqyod+sR80vqew3rJRS/i2lpSVP7VWtzll/wGgSIYlLJF1yJNop0PhUTvvSoiwF1ru6M1CLKewLYZfKKQE71jDhIIgXp4E5/Ec/jcKf3OZ34CCfD4qRbdhLr4Y8pCUqepUqhPogKgoiCB5GLWgtmGTtJRUNX2JhU13yZottHL6B8ElZrrb0oLFd8ynnPShLM01kkjhKq/IW+mRFz5Lp0EEBsIDnhsN2GMlCCIoBsISQqDLTB2GHngPWoYAh1guddtZATgECDipaB5myoVCSV0e0HMNWxmDDqqBcpdL9srlYOjS4bBU+cqNs4nXcuoZOrMpEPbvEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fNJMJg4J5lkpuTo3jUM8wnT0SZMmFs7IKldfkXNjhQ=;
 b=dMC+QE6d+2qpr3bc2BMxHy5FOwvpKGpohiHt/pkiJdbDD/fSKhx1GnEa5WKf70qMltPSMsI/LZR37z5lJKJKUNp2F2IHBh85SBGboqRAjjNVq/5P1nTGJ0UtKZkgjqnzccTRYXMoP1RHVzKD+j3+QLznddbHern1wJ2nGbnZscS+pkDAo20Oc865C41PH0jLmPh8/0ecJ60HvIEmlCH0B5RbEwPj2VLggwHUj1MsYfrdYeFhtRWyQ7g+mfkESASiguIfLiamjwaSLU3D16YXJXa7Uypw4n+Vt+OYTfZPA/1zE7EC2Ep6wS+bKqiY2Arb5aMSZnDVJXoaUErnvmSPaA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY8PR02MB9156.namprd02.prod.outlook.com (2603:10b6:930:98::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 19:03:58 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 19:03:58 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "eahariha@linux.microsoft.com"
	<eahariha@linux.microsoft.com>
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
Subject: RE: [PATCH v2 1/3] hyperv: Convert hypercall statuses to linux error
 codes
Thread-Topic: [PATCH v2 1/3] hyperv: Convert hypercall statuses to linux error
 codes
Thread-Index: AQHbg8X3ZI5uncEP/Uy5N1IfDzUOmrNQigyA
Date: Thu, 20 Feb 2025 19:03:58 +0000
Message-ID:
 <SN6PR02MB41578283BE9E070349EEB1A3D4C42@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1740076396-15086-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740076396-15086-2-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1740076396-15086-2-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY8PR02MB9156:EE_
x-ms-office365-filtering-correlation-id: 07ecff83-a974-4918-e096-08dd51e154a8
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|461199028|15080799006|8062599003|12121999004|19110799003|102099032|3412199025|13041999003|440099028|41001999003|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Bk1fi6XMBNm+iyFUyHpJrwLnGCzRBN3WuKCLxbLx37qDb3/HYzsjoDzTf1yZ?=
 =?us-ascii?Q?FTVUDUdlBCnGhJ9dsG06VFAEpCDwhyAi6Q0S8fpatfG+viw4YRmcgnWosv5O?=
 =?us-ascii?Q?xz3Ce50nZKeTMVIrzpIJllt2A7mrjeeMjbr9HytBiNtn85y2JE+eDeZfa5si?=
 =?us-ascii?Q?yTeNnB3jPCOQ0VK4Y137s6Fg+AxP8Gr4bN4bJPtMQ7IAEat+8Qa/oV6drhis?=
 =?us-ascii?Q?6LTZ1aBSuXER2Ix83gjbz4u3huByT2dnYZ61pCsfcV2Pb1sc8PngdybN5Kex?=
 =?us-ascii?Q?VbHvHplNDhc9wTFAZkCSWrN2De9tyHC+32Yfg1J2CXBMBKB4xEm0l/rRcdli?=
 =?us-ascii?Q?VgoFcR20xp+IUUg0nt578btMnAst2gLfEU8yhazlhSCnpIEJyUGRYiTNSlRj?=
 =?us-ascii?Q?fQfDjHd07z7B1k9K0zCBvnhqnLH85FnsnFiM3OsGq9BKOn9mFlrVbtsx5hS7?=
 =?us-ascii?Q?sLdT9OTiH9lZZqRqWY72J/MfWC5u+YiD9PNPJjS+827xM3QarNnsvtY0bMbv?=
 =?us-ascii?Q?CBFS+TOYpFmbwoChir8HDlzKZNl6XtUtCQUhm1hgWTJeDVgPy+dBmS0CVHOe?=
 =?us-ascii?Q?gmNmyNQZ8CrzIdxlMW5qrrSkUzMS9nx94R6pkdFYhrirv0aTaILmdIZdTgLO?=
 =?us-ascii?Q?Fus5T73QAQfNeTV41E5rxZqFQCOqNjRQvJuAc+LICfTfG7GJEd+cDmSlfY+3?=
 =?us-ascii?Q?xfUFU6nEj43OGtrLZCbjzg6daIEQQYxeJfNw98n33vjErbaECUcTDt5eCSSl?=
 =?us-ascii?Q?hngclPWE36i+lUhM2501bMZUL8VXRJfYEYwvXX9ZHRsdOgrTx1eHfSvb78s4?=
 =?us-ascii?Q?Qhfqeb3/0A0hBcoboHbRs7M+9mshJohfhN5nGE/PPDhgn5PThjcWQm4Cec5R?=
 =?us-ascii?Q?sUMjCfICC7nYrsQQTj5w8a1aXNSxSc+iB3kHPeRsyX8exfohab17MMBaNX+7?=
 =?us-ascii?Q?kBNGf3TdDF2qaqfr9xLVcE6A3aOL96GeRN6toF5phdUYNxF8BjeT0QBkLOvx?=
 =?us-ascii?Q?Pyw4fmhHNRqU5GfmKJtpkrbkLif/PEb7t+DKGS+Cin/zbWd5RHGncb3hJ/Iy?=
 =?us-ascii?Q?ddm9qJc+hGhdA96ai3ljFks3TqpCA457mlvC/m8vrX3fl4hgYCK0RnUVXqZD?=
 =?us-ascii?Q?xORk0EotcQbIlTKdM3TezN1qndjoYUXsBjpxh8mWRUB4+g8YUxD4l5w=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XBV6KE5mCZ8r5/iLeYkMry+3gvdjZOMR1RYl8ZYwMj6jv6HONqYBRwv7hOko?=
 =?us-ascii?Q?OkcAnDKIkNz73dHdrQqWe8ujpaVL1H2rMZPMwqdWKn8DxuwywHCDrtbrsPpK?=
 =?us-ascii?Q?9BWc8ZJopd9Oqt39iq12PFvGuxZWTlpceU0BtBS3wx21yHq6ob6U4FmBhZUL?=
 =?us-ascii?Q?Tb8x54npAqYgD28UmlQrrGAcZ0NaugHLGFwyHVlRu1QqF796H4gQ/yGyFJas?=
 =?us-ascii?Q?qoR3sHY5i7b8EHDOQPwUQs0gSpvQPTarLPh3pdzUpT6TSrvniBeBEDJrcyoY?=
 =?us-ascii?Q?HX8rytK0edI6orKD7DfGpk49Adw3BWeAUaXiYjiGja5iXLdmQBYUUguzS9EU?=
 =?us-ascii?Q?2z2aYPIy7lHTom5/mnWUtvhWSODT448mdScAfmXbAcWpGG+GmuguodET0Cky?=
 =?us-ascii?Q?ZyI8HCQ+yNOzf7M/EhnRIDsDrXDr9eiGg2+FKvdUZ2iC4bU0vbtf9p2nkBBT?=
 =?us-ascii?Q?FK+H6ave4RuVP/z13emTxd9tY/ncmwDKo+zpkvgTHn/BF2zx9j5DjmV4CDkY?=
 =?us-ascii?Q?oH9UwyxHL1g7uokeQ3ePUEeDLNftC2nPzBs+fl5MXuFjDnr1yQsqGDWyGEwO?=
 =?us-ascii?Q?2wfQnNnuHhCS5uzuhNIOrbmpLL08zN9HUqhprEO5VevLXG0R1ScvgJfuDohz?=
 =?us-ascii?Q?8VAY+BhHo6P2WG+dWpC5Nr1QhUMcZu0EHRCgT1RAADDsJTMZdqsnw8BMbYgp?=
 =?us-ascii?Q?FMQgz/tN0NPvQpkWoqd88iWCRR8lZOa1QraetvTZcIefsoTADupl2gImNT+t?=
 =?us-ascii?Q?/e5qtYHl/SHQ3/Ht/c96Q90AVQj3uuJuf39CztuChVVtrfk1ppsfchYngcpH?=
 =?us-ascii?Q?7mEhJ0EO4dHy/iqDUa2EUB67hwQC8jRXYgcI6Ya6Ma77F79/ECrGUoHOxcaA?=
 =?us-ascii?Q?WQh/S6qk7QAeHxNYsaftPL7HkFIzTRxFpDwqB1OZ7D9N5rIrB8iiL+/94/Cz?=
 =?us-ascii?Q?roi4KLrLB7dDryvJNa7cAb2/LmX4o8qzOQpbCkn+3DkhN05EimwM6z7VOSiw?=
 =?us-ascii?Q?y5Gx9rPXZTNmR5wqJ8sY83J2V5XECH8+R/0OvnG5ih9AT99GYQkQEh960fP0?=
 =?us-ascii?Q?outpWdceO15d7WWYuRBFyTw3PQRLs1EZW9QvfaDOopyzKAeB0zgatrYK4iuz?=
 =?us-ascii?Q?hK4TOghMsix84tUL232aoy+snzndKnsZAOtx0Jts5/QdQ8hICcLhY6IwcHZN?=
 =?us-ascii?Q?/w+MFSOaqPkC3Kh+mMLpy0EWlOENaX2csZQiVPaIUpkof36dXs5lAV165jU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ecff83-a974-4918-e096-08dd51e154a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 19:03:58.6118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9156

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, Feb=
ruary 20, 2025 10:33 AM
>=20
> Return linux-friendly error codes from hypercall helper functions,
> which allows them to be used more flexibly.
>=20
> Introduce hv_result_to_errno() for this purpose, which also handles
> the special value U64_MAX returned from hv_do_hypercall().
>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/hv_common.c         | 34 ++++++++++++++++++++++++++++++++++
>  drivers/hv/hv_proc.c           |  6 +++---
>  include/asm-generic/mshyperv.h |  1 +
>  3 files changed, 38 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index ee3083937b4f..2120aead98d9 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -683,3 +683,37 @@ u64 __weak hv_tdx_hypercall(u64 control, u64 param1,=
 u64 param2)
>  	return HV_STATUS_INVALID_PARAMETER;
>  }
>  EXPORT_SYMBOL_GPL(hv_tdx_hypercall);
> +
> +/* Convert a hypercall result into a linux-friendly error code. */
> +int hv_result_to_errno(u64 status)
> +{
> +	/* hv_do_hypercall() may return U64_MAX, hypercalls aren't possible */
> +	if (unlikely(status =3D=3D U64_MAX))
> +		return -EOPNOTSUPP;
> +	/*
> +	 * A failed hypercall is usually only recoverable (or loggable) near
> +	 * the call site where the HV_STATUS_* code is known. So the errno
> +	 * it gets converted to is not too useful further up the stack.
> +	 * Provice a few mappings that could be useful, and revert to -EIO
> +	 * as a fallback.
> +	 */
> +	switch (hv_result(status)) {
> +	case HV_STATUS_SUCCESS:
> +		return 0;
> +	case HV_STATUS_INVALID_HYPERCALL_CODE:
> +	case HV_STATUS_INVALID_HYPERCALL_INPUT:
> +	case HV_STATUS_INVALID_PARAMETER:
> +	case HV_STATUS_INVALID_PARTITION_ID:
> +	case HV_STATUS_INVALID_VP_INDEX:
> +	case HV_STATUS_INVALID_PORT_ID:
> +	case HV_STATUS_INVALID_CONNECTION_ID:
> +	case HV_STATUS_INVALID_LP_INDEX:
> +	case HV_STATUS_INVALID_REGISTER_VALUE:
> +		return -EINVAL;
> +	case HV_STATUS_INSUFFICIENT_MEMORY:
> +		return -ENOMEM;
> +	default:
> +		break;
> +	}
> +	return -EIO;
> +}
> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> index 3e410489f480..72b09f1cfa3e 100644
> --- a/drivers/hv/hv_proc.c
> +++ b/drivers/hv/hv_proc.c
> @@ -88,7 +88,7 @@ int hv_call_deposit_pages(int node, u64 partition_id, u=
32 num_pages)
>  	local_irq_restore(flags);
>  	if (!hv_result_success(status)) {
>  		pr_err("Failed to deposit pages: %lld\n", status);
> -		ret =3D hv_result(status);
> +		ret =3D hv_result_to_errno(status);
>  		goto err_free_allocations;
>  	}
>=20
> @@ -139,7 +139,7 @@ int hv_call_add_logical_proc(int node, u32 lp_index, =
u32 apic_id)
>  			if (!hv_result_success(status)) {
>  				pr_err("%s: cpu %u apic ID %u, %lld\n", __func__,
>  				       lp_index, apic_id, status);
> -				ret =3D hv_result(status);
> +				ret =3D hv_result_to_errno(status);
>  			}
>  			break;
>  		}
> @@ -181,7 +181,7 @@ int hv_call_create_vp(int node, u64 partition_id, u32=
 vp_index, u32 flags)
>  			if (!hv_result_success(status)) {
>  				pr_err("%s: vcpu %u, lp %u, %lld\n", __func__,
>  				       vp_index, flags, status);
> -				ret =3D hv_result(status);
> +				ret =3D hv_result_to_errno(status);
>  			}
>  			break;
>  		}

In hv_call_add_logical_proc() and hv_call_create_vp(), local variable "ret"=
 is
defined and initialized to HV_STATUS_SUCCESS.  Since "ret" now contains an
errno value instead of a hypercall status, it should be initialized to zero=
.  (Yes,
HV_STATUS_SUCCESS is defined as 0, but it's now the wrong abstraction.)

With that fixed,

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index 7adc10a4fa3e..3f115e2bcdaa 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -297,6 +297,7 @@ static inline int cpumask_to_vpset_skip(struct hv_vps=
et *vpset,
>  	return __cpumask_to_vpset(vpset, cpus, func);
>  }
>=20
> +int hv_result_to_errno(u64 status);
>  void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die);
>  bool hv_is_hyperv_initialized(void);
>  bool hv_is_hibernation_supported(void);
> --
> 2.34.1


