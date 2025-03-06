Return-Path: <linux-arch+bounces-10539-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8EDA55503
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 19:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 120DC7A7A32
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 18:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9121826BD80;
	Thu,  6 Mar 2025 18:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="uufxKclH"
X-Original-To: linux-arch@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013077.outbound.protection.outlook.com [52.103.20.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C627C25A625;
	Thu,  6 Mar 2025 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285826; cv=fail; b=C2/gPU7VEDUvCvHGcxH6ZQ1KCVAKyTwEOYbxkwJkyZxO02Bm5qJlzcyBZG24P66qQzNhkNbD2PP9O87jClb3YbNcQRdQxjitk23c19ju5CU6zvBjju6roHIYJC/MlQN/0J+Jzi4PiVVHTO80DemoS54gvyIRFPsqVAVCvOa1CfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285826; c=relaxed/simple;
	bh=NqFfNx9XSc5EtVev+VsorndNTZ143KzEkMTNdGPqAj4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lg5QEhv9iYTwwt+zXBx8MppPFK6kFZJ+uP0k29jigKNF0ewvzvdq7c4W9wLGLi5rSWs+LL8rKU/0ghm9wsgexFZyT1rONhaFxZnBiyRygckrIL2sNSNR8EiTMCSS1SeQVAD9eBvorehugtnhdHeU9AWyVJnysdxtyYZfePHSR5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=uufxKclH; arc=fail smtp.client-ip=52.103.20.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ne0c2W6axgwuEOFdOfGjAjlYuWstPcsPzWwHs/Magz+zrsmmzNoDPAvcKZzvqBj3rfVqsOSToAUAbj4ErlZl6mOFORYdumzLY5azA5pKkpzw+6JwcW4Yq2NNwDs3Yxzyleg0CS7i0vJY0+qEfVP8mDGkXENp4vIKZG61bUcbhpg4sX4Bes3nW6JxMdv9+nJX1Es9ugBU9fNCXJplaGvkuSznTjWQI9+TWxkU2jhLCdp+bkI5gAKeM3i6F2B4/PFXWEvlYn/ZHXVqGZCKZ/ONNvF6QrIo2q6Aq4/Xpp4dR1k8kOEg4Vd9RRt35NPIAX8i020YR2M7ZsTdB24GjRNEZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sT25yCgOyMkXEFigAmVoCDlKaoYjtM5GchMERP6bPx4=;
 b=Wrsc2bD4wqLEgb+fz3F8dcslbmsyPkBLQINF8oBi8zBBwqqbCVQykf+c7IeUs2TS8jCbCaaWaOOZ9NKM6Se1M4JrNtc1kRlbnJdl9Gfnh6MbK8Ah/DyuDM5Hxmkfa9josfGIo7xGf65OuPVbrAMIuDwRySQyywSrgl4e2NAaINhcJOGLl7F1FPQ1a2MBZE/MqY8+Pk6IovUOQ2EhlQlIXfKHH13xRuRbXMF4PiUcnN12d8vk3xZrG24RMWENyukK0cR3lWkRcx3xqrYp+33vFiDo+o0q1o3o5DmZ2JtZMBgANwxaF1LeX5OqDitwwoCa0NrZiqmYQ0eZg3UAg8ULxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sT25yCgOyMkXEFigAmVoCDlKaoYjtM5GchMERP6bPx4=;
 b=uufxKclH8PzQ9HWZ0v+wADWqXntkbFbB+qPAugauDMcv9ik8Ty3IltUzlVFx4qZGhIEgehw1hU8wT3hfav4VLv87Zte9uRnnG/dS1vRyOJ9eEmzH3ZfZ7TdQrg47WSmsxJsf00V1Ig8k+FznLxLYpiWTvFvQohK1jK+tndnedolO1RApislk2iBPqIW2YH/XqsV0qPZ2b56O0wPe3IXOFs/XrWDUXnzoo11RX3ntSJpP9uevXjMLi3+5WIcm2WBofAewTXw0SJ+dphP+Ubtg8VUaRvGWozFp25yPEhtIf9xyxczvgJhBUiLoT1t0XmuOyOZ9pT0k2KrFW9fthAf4bQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV3PR02MB10332.namprd02.prod.outlook.com (2603:10b6:408:1ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Thu, 6 Mar
 2025 18:30:21 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 18:30:21 +0000
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
Subject: RE: [PATCH v5 02/10] x86/mshyperv: Add support for extended Hyper-V
 features
Thread-Topic: [PATCH v5 02/10] x86/mshyperv: Add support for extended Hyper-V
 features
Thread-Index: AQHbiKNsELlhg/nkb06Cn8BpRqwg0bNmdgqQ
Date: Thu, 6 Mar 2025 18:30:21 +0000
Message-ID:
 <SN6PR02MB4157CBBC2D186E1944E6773AD4CA2@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-3-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1740611284-27506-3-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV3PR02MB10332:EE_
x-ms-office365-filtering-correlation-id: cf623953-caed-4f16-f8ca-08dd5cdcf3e7
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|8062599003|461199028|15080799006|8060799006|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?qeKOayBOAVN6qWUjDLWfh8zV5UDLuA3GPJTkwRKtllgWxIKXLKNFU3WJv3Ai?=
 =?us-ascii?Q?zxc7lfna09h4tAJwIMc5lH9Qe0aPcrvTpcmqSt2FLq22Ay6tNv0ZtAnLdy3G?=
 =?us-ascii?Q?L3s7wttMwWvPYjM8kiXNMLHtAxBvttnExn/evx/sfJv36eirHuOZKQOHq8Ii?=
 =?us-ascii?Q?eAhJi2TfiZHDjquaG6lcV5I+0jFc4vu+qWKHUQV6jpd8rI1rLd6yWqhGRmAs?=
 =?us-ascii?Q?svjmrb8OKMwnQYqas60WoW77Mma7is8Kc8dVYcNwYmZRiT4pwbRV5vXFTr1v?=
 =?us-ascii?Q?nB181/5MRCN14NUcA5UOLCfdW7hfkuGLIKa8mF4c/NbuYK+OE3TTl/FoEy0k?=
 =?us-ascii?Q?qUvfC++cROdov42zPoanOczwGpYAHcXRJ/TY2ADJzganWDg9lHYgxDvB3iFa?=
 =?us-ascii?Q?3zG/0fMdMkO9uSQKqX9KhJtBOtjYlWnN/aVB40iD1GHY9kdPYvEvwD6hR7rj?=
 =?us-ascii?Q?HWhGb1yJYuiYugOoDpe+YK/A83zMU4n9FcPTVjfsqorbdMfzTi3RBexc73sL?=
 =?us-ascii?Q?KsEz9dccwu7A1NfgNq0IGZyc5swMhfNnQVn+SGc8f+YB0bVrbNPHbtkC4vSn?=
 =?us-ascii?Q?PuJ+KQ4LvGKutdKXe8+tZyB2sDz6+zDFVcCnqEKrOGewjzD/oSlbrPIxIYhn?=
 =?us-ascii?Q?pE5EpCot8LKGdS1Dy6sxVPjALnBzCKH5+DFMs6phr9UMZuKYleY7yCW4FxvK?=
 =?us-ascii?Q?yTpBczXA4bjvPVWFJwwcS/rKV45WWNkIEaFy4jSFHNJuuxWJ3sOy1mmGbcfl?=
 =?us-ascii?Q?Fay61VgylfJNxt/LMdj5pu/BkONvyGaVQU0N/8a4oSWVg1arMcPDHTyOdeFD?=
 =?us-ascii?Q?X0cyCXAbCdkx+QCGxxQ73air5Ox31EP0EaxXIGBtSxDL3kAjh+UZWUGXPAAi?=
 =?us-ascii?Q?eXAnFQ3rp9L7wIkecXxpZrmh3b64DV9Y/pqOUgXCcaU+KKpqQ9RgYePgNpqx?=
 =?us-ascii?Q?vvw303q3ND+Pzxg4y9yqwlD+9g0wsR2Rq5rvyKBVR8HpIZuUGTHFv4g5Lf+Z?=
 =?us-ascii?Q?cn10gqtdPRkf6maPdeVaIE7ZZQsxtqv0VdggX3zCJibgUr0=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oGAkwqQ5d/FsB30KVkcwf4ORTSQYU8/meFtXilj0MRbsHr7WWn6ZMwtE1cew?=
 =?us-ascii?Q?r+vqh/auuw2VmtLtQeX5iYAbmIOh+M+WcRz1em6oNkg/Y7TXztIfqiQbOKxp?=
 =?us-ascii?Q?BkgvnDsP1lmlx+VJtzVkYcVS0FW5RXwk7I0BDGTHzLKmybpEZk8LedXAY/GB?=
 =?us-ascii?Q?ATOiPRj/CiBsILR1cmLH9aO3FkRGVspJx2fP2uizzPFSgrJwDdOSUeCiWtn2?=
 =?us-ascii?Q?89vNBYv44b91XqOMkRz+xiI9BeWZB7wdda0MoTnmIpgVLGwb8ol4FlOOnXgh?=
 =?us-ascii?Q?t5k6gJMySTIwp0YyQg2r9Fzo8kShzSO82o11pZVjDj1svvGbc+jiZWKWL9Zd?=
 =?us-ascii?Q?/yDkvxCTNhtt9lZN7k9ZW1hyMezkBD48Jh2fHdo1oJHx/UWp3GlynangiCvp?=
 =?us-ascii?Q?PoAxdpsNCPuhDz3ZES34v6yv6hJeOOYHRLxlWZzQPgi9mlyR0+Ae++Z2qhrS?=
 =?us-ascii?Q?OJnNXb+5j6HHUfWw6DLSh7bYPBeqmr8nYWsZnbgVqWk/lxXch9sbh8VHgEQx?=
 =?us-ascii?Q?C/a7vfPcbma6jReVw/fHhA6xz3gHBmAhqhy3kGIAn+9mQh0uShzKPQdamnt0?=
 =?us-ascii?Q?IJaEKDR4l3Oit5Lg56RMqLhbY5u1qV10WUM/gqy8iK+s5Ruzl1y5L5qCBfpo?=
 =?us-ascii?Q?CpUQ7S/2rMrjMNA9Rq4j9zt0xO2Pd25WrB2Bjv4mpuY14reHIAvcseuEhX1w?=
 =?us-ascii?Q?V/Im0h0y4aayDsCCfGhXO/W2iDKJKGyQTTEqqw4X/2255H+Qqxs3raQQNZbL?=
 =?us-ascii?Q?rET5/S/JFW39DxDCluPOGZtfoYeolt+gO+z796MPQA52PT3gmrAG29NDDZ2q?=
 =?us-ascii?Q?/bODToLiFsQ8T8Y70B8klRn6vv5HU1BsYvuOAIRqiISKVyrNc2XHuC51Tm5/?=
 =?us-ascii?Q?W6z70JbUBfE2MT1jei7234T65OmnkUlIW8JXVGP5qRvuNaTNxnE8z4xtJxfH?=
 =?us-ascii?Q?HjBQRXFGfPWj9q9d+vDR7iWavPdHf4fHJubWpMbt5xz9HalJidUMvXifSGGy?=
 =?us-ascii?Q?gqkIKNlZMptipawRcxu+Cy46c3UN/DftR8I99PInP6I/bAT4jEW9eqc4YYZo?=
 =?us-ascii?Q?ae6vkrB2F2fod4LPpYwE209a1R7uhjRXhv2e1+jlcZcD4TLjfX3JhBWRuLEj?=
 =?us-ascii?Q?7hI8X2fruy4DYECv2QOtdI5KxLvMsnaBto83GnwKObMJJbjypzxE6/jJSxzh?=
 =?us-ascii?Q?o2fmkf5b6DD7aGw8Rh6NZKeQ8Gz4VaqiXGPDMdUvTXoFHW0BgrMRSXtskog?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cf623953-caed-4f16-f8ca-08dd5cdcf3e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 18:30:21.0691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10332

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, Fe=
bruary 26, 2025 3:08 PM
>=20
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
>=20
> Extend the "ms_hyperv_info" structure to include a new field,
> "ext_features", for capturing extended Hyper-V features.
> Update the "ms_hyperv_init_platform" function to retrieve these features
> using the cpuid instruction and include them in the informational output.
>=20
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 6 ++++--
>  include/asm-generic/mshyperv.h | 1 +
>  2 files changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 4f01f424ea5b..2c29dfd6de19 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -434,13 +434,15 @@ static void __init ms_hyperv_init_platform(void)
>  	 */
>  	ms_hyperv.features =3D cpuid_eax(HYPERV_CPUID_FEATURES);
>  	ms_hyperv.priv_high =3D cpuid_ebx(HYPERV_CPUID_FEATURES);
> +	ms_hyperv.ext_features =3D cpuid_ecx(HYPERV_CPUID_FEATURES);
>  	ms_hyperv.misc_features =3D cpuid_edx(HYPERV_CPUID_FEATURES);
>  	ms_hyperv.hints    =3D cpuid_eax(HYPERV_CPUID_ENLIGHTMENT_INFO);
>=20
>  	hv_max_functions_eax =3D cpuid_eax(HYPERV_CPUID_VENDOR_AND_MAX_FUNCTION=
S);
>=20
> -	pr_info("Hyper-V: privilege flags low 0x%x, high 0x%x, hints 0x%x, misc=
 0x%x\n",
> -		ms_hyperv.features, ms_hyperv.priv_high, ms_hyperv.hints,
> +	pr_info("Hyper-V: privilege flags low 0x%x, high 0x%x, ext 0x%x, hints =
0x%x, misc 0x%x\n",
> +		ms_hyperv.features, ms_hyperv.priv_high,
> +		ms_hyperv.ext_features, ms_hyperv.hints,
>  		ms_hyperv.misc_features);
>=20
>  	ms_hyperv.max_vp_index =3D cpuid_eax(HYPERV_CPUID_IMPLEMENT_LIMITS);
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index dc4729dba9ef..c020d5d0ec2a 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -36,6 +36,7 @@ enum hv_partition_type {
>  struct ms_hyperv_info {
>  	u32 features;
>  	u32 priv_high;
> +	u32 ext_features;
>  	u32 misc_features;
>  	u32 hints;
>  	u32 nested_features;
> --
> 2.34.1

Are any of the extended features available on arm64? This code is obviously=
 x86 specific,
so ms_hyperv.ext_features will be zero on arm64. From what I can see, ext_f=
eatures is
referenced only in Patch 10 of this series, and in code that is under #ifde=
f CONFIG_X86_64,
so that should be OK.

The pr_info() line will now be slightly different on x86 and arm64 since ar=
m64 won't have
the "ext" field, but I think that's OK too.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

