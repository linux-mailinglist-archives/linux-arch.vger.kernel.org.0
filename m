Return-Path: <linux-arch+bounces-10557-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9F6A5564A
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 20:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B307174C1F
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 19:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E400626D5C3;
	Thu,  6 Mar 2025 19:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dJ+4cZJY"
X-Original-To: linux-arch@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012063.outbound.protection.outlook.com [52.103.20.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAC825A652;
	Thu,  6 Mar 2025 19:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741288369; cv=fail; b=NjIOj/8EbgmzeZj6lEvE6oFKY1sO1EfMUvwhERmwjXI9SG1b/hlkIZDpQndYgEavn3SH5gb8GfgC0wqVYErbvICW8UbkRqZYnkfanbzIUQLUh1Z+V3TdWLExtJbLOO1nmiEEmt0Sc74GfqqhdlrPPVtv9fcA4nPo1Vh1Y/xdTe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741288369; c=relaxed/simple;
	bh=DQbT35RUmELQXKW48FhrHXMvR9HAX/U4Of7Dx556kUo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pwwdP7Iyv5qNQSHhJBpQMm2Prab+70NtIOBVFygW/Iw96rZ7QpY380cq00hc1n2t6SRHQpfCigGcIyVD/Q69p4aj9W8SfTN7ES+sMBbQ2ZAp6KacnHN6BG5Eim7vy1oTyTHI35Y7IbJ2xqgQdSfKaN7Vs+gO7edfH7ZIfZ8caV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dJ+4cZJY; arc=fail smtp.client-ip=52.103.20.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A7Hq5sbwCmjSb+Hi5J2DoNb+35Ln7GUx0bvs0DP7ULDuNlYiypRjv6QwDI029YdPJETk7uhZax/JjRqraG7YzOJmjOV/yg+A83cg5P41ZL6cRdUbn2TR8ly9JIC3L6Ttfjdd3cxE90O04dOEBLqleFzDg1jgeLSwcq651ZgiD4lWkaT5CSuAgwqgN23pQRkjjybAa+cclclE4t+ltBBIboZ/GGO6oB+lXLOzW8KJbFhZox1k/qmDZRY2fJ0qHsK2vuMhJaEjI5dJ60ncPHHhdqq6mcifacuZQMZF7jLi0jCdMG6mTnABnMt/GHObAEDjyEHDZVtRcHP7aNFZzs67xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9BdsOznYQJJw8ylIjIMJ29PBGqcltE3Hr9Jwn8aENk=;
 b=GM4gXCZIL3bV5I4tJgBzGudMeLFm6ca1ECAZK8wZg6+X4iT2fi8iSDf1DBYZgi0ZWD+4FbhZ3RJoDb+nDlrR26AuJ/F0WpOoQdJa5yobIkdCuPuiMTAxuQMO1qYWf45wgN5i19EZdA9lOBWGWlpCHCQGwoaFyFPuD6DVrsAAkqqSQfsqfVeZWmiU0kVb7KYzX82P7rfQcyKRbitKYkaLZZzlm1GZD4bxuMXKvUS1DI6S2dCinZdm8NCU9KhVAXT3JuJkp/gAzlGYfBw0S16DKGkfcl0GplaEDzU/jWwBgnPRcftVYS9BiRc1wWKSbvhCYxsqKJFjqIVmkfHrc6YygQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9BdsOznYQJJw8ylIjIMJ29PBGqcltE3Hr9Jwn8aENk=;
 b=dJ+4cZJYubQQOFkTGUcB05QNt6Zy7R9hZg6wh57DexpwkpBxBvEgkyczdECA3Cq4pgihrFxtyvCT2zjukDUQcC5JZwHTnSGqNjudi9znzUfUZgo3+4mU/pxZXF/Bnp/E9BHjwtIdaImpp2H8pYaKLq0ncjqC3sSX2Tlid/AQ4rozWimtA/3sUSlcc9SMnAKEj7V0P7eb66IxSHjdkOnJdA7U1B0q6tAukhIDL4jhk/GTzZwTo8KAUOMTKnTEJ04lZjlO9svi2i70RBUwS6/rtKRcj+t4AwwuZlJTuZpiufCoy8M1eoNX3eeEc56ObkGD5SgrI4FJgaTEkVcJVTHfiw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB6770.namprd02.prod.outlook.com (2603:10b6:a03:20c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 19:12:44 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 19:12:44 +0000
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
Subject: RE: [PATCH v5 04/10] hyperv: Introduce hv_recommend_using_aeoi()
Thread-Topic: [PATCH v5 04/10] hyperv: Introduce hv_recommend_using_aeoi()
Thread-Index: AQHbiKNsTgi31KDW2kWTBMZWQdlZtrNmhezQ
Date: Thu, 6 Mar 2025 19:12:43 +0000
Message-ID:
 <SN6PR02MB4157A8F9C0DAB7AF7D50EDBBD4CA2@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-5-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1740611284-27506-5-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB6770:EE_
x-ms-office365-filtering-correlation-id: 927dfa73-a482-43d4-8e19-08dd5ce2df95
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799006|8062599003|19110799003|15080799006|440099028|3412199025|41001999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CNNejpw5jFYyZgYi9dpgSES2mEMtW6yUZrAN3rW+GzCN1u9e3J3xmZ7HJwrr?=
 =?us-ascii?Q?KZwFmGDPgkQovTEn2FqGGzLM0YIf7FDe9KaOoKO/AW/eoXPaOPlKEkTU704e?=
 =?us-ascii?Q?xVf7V8Wv5/UaC+eFTi06s0SiwczQGD0O5fMR17y9/DZDKg7BuPe6PR3e2jJ1?=
 =?us-ascii?Q?6jT+OcSIhgab2EjQhjq+vOLGJfYQWlMYVutM4a8OQPyU9j4MsnxyC5L/4hWY?=
 =?us-ascii?Q?hmwTOcPRipcmMH0YGMzpTMQIk7Zs0E2DjmK2Eg0BO1pptpt8UG964RA/dlAk?=
 =?us-ascii?Q?7SsDeQpxlRejVNBSaSb4pfs9JKdkXqVu6DneFlbVYqTKP4umzoiBITzFTME+?=
 =?us-ascii?Q?AqR22FqDA5duye0Nn/NBSUbAmbqSGC03mx/uyOJ8xMS79q3AIW8Qf8vLYNQl?=
 =?us-ascii?Q?+68xBFDi8w7Xk4dH3mefiizl7uize3+fM59JHSG/A2KXNvmYPHpcdmunW1px?=
 =?us-ascii?Q?ShhKPnDGREqQuLiYxcnN8Xk3xS5CprgXIjFSq8OrDUTrNWUxVtKuu6HOu16t?=
 =?us-ascii?Q?nIfwuuje/yqF7pXmT2Kb3BQbXnXZo8vybupZUOMdN51QXnnmDtjTfBPNoDhN?=
 =?us-ascii?Q?ry2g4ZP9pHCy8Bd2vlyySFhPo3vOXbIsDEwZE30lnXc5H2VITtInCchzOzeY?=
 =?us-ascii?Q?NMsN0KXWca4jbhWHeTc1HT2AFSD122xN3G8Fszh2sab5vWtr7RMWKvKx2bfy?=
 =?us-ascii?Q?zz27C+pPeeUCUYnFKDDJQJd9I1RN0kO5xOOKQqXuKuQTNRpSrH34MFRoZG94?=
 =?us-ascii?Q?XBZGFMrE73WC57rEOVBis0rMN4X6POfF9FSIBs5zSMBNGZoBIOaW2W+ItLJM?=
 =?us-ascii?Q?IcNuMuSdiEC+ftRRcKDO8KG2I4NPi6m7MtmUgZsU2tEB9TZFO4tAyJEsQstm?=
 =?us-ascii?Q?9WoEHChm9FY7Eb3vUoRnswIW+eRSRuKT8FlJiZdoOJsbOUWhbA4zD7tKPvnR?=
 =?us-ascii?Q?+ABBf7BdCQCLmKwd1Oj7RFMJRMCI7KNaIQWvJEObyfSOKrkMifNhFgtqlcc8?=
 =?us-ascii?Q?IyCJcdwYNcvA6U1FVBPIGCzqu4ig25hVChRj9BtFzNHPke0kQwzYRPO1XcET?=
 =?us-ascii?Q?orDvbh6b+htidwjVuwAAoKqvT7Golw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cNFAx+Kbnau2Uz8+WKaAnC8CHTkLpebw+mVk4GhqQZ7rPfGM6icIXf/hv/cQ?=
 =?us-ascii?Q?OpE5nZY82KWkhnUQqSjmogG7cb9Q+LGVZxu/4kRkbeewxjufzRB6HpIuIyv1?=
 =?us-ascii?Q?aJ4trpyhHYyAcaIg5a2FpYjh4HZQQ21TFqugNURy7LxZhnf84Ak/2BFLu0ym?=
 =?us-ascii?Q?dX2rOLAvaF4xR9eVahua/tBfGrD/DYRa5xEsXdVSBlxmTeAOCj2ZswlwahJr?=
 =?us-ascii?Q?RZOWUqAR4lvbCg4Fmc5C6Z89HZ1WO9QAKCYMDInkzcwgXK2IKuO7D34KVRrv?=
 =?us-ascii?Q?7ZvI0BvPnM4RjMy3xqxQqUrMpnYMJ5ligTFLufc46hodc7/OYvGqd43rZJ2d?=
 =?us-ascii?Q?4Ld4JmJ4yJjb3YGnCa8DAeJpxqtlhnQj+ap7QM3jxUysX/Qhb2CJxDVrgIdv?=
 =?us-ascii?Q?PkyCWnYi7E8VRRflNyZrEoLGtwf3KeNCPdcy0fdNGn4L/5Vc91134Z5yA8zp?=
 =?us-ascii?Q?iZmg5JbaFtrfnpMxI/lYJsOjKMF/msiWh9QfRDr9ZuZLZRsHpusgw97+WvmU?=
 =?us-ascii?Q?7hI268PW3iZLHH1ig7QKuYto00VkQOMTrZ4/Xt9oODWkl7B0fd72vWVAOknZ?=
 =?us-ascii?Q?QA1848idLR+SZvvj0+AqIqXnPY8VYcS3uxOPYUAIm37TxCtFNfdp6xH/x4MH?=
 =?us-ascii?Q?jnvcNRPB/VnDrdB0KO5UBust2uyRBdzQnq84JXdzG6Ak9o3MZmu6AHHQVLxq?=
 =?us-ascii?Q?QB/w1SDWX5kSf26Y1jz2YSadQK5YyDWvuQSEyGGrfpsXN6NbvOjNKzMi2N2K?=
 =?us-ascii?Q?1T8NVyRU6qMvaIz37aBPVBdVbEL9zh9SiU7F7mtbNBim7bk4Df5X3rALovS0?=
 =?us-ascii?Q?zueD64AdHEa/ibynLezjuhY4OBy/K+fWBT52pdqe42DI0A124m8De6BRpmE3?=
 =?us-ascii?Q?59MrLAWrtaoThWtPEHRdmUCIK0P4Q+RbhqaU1au2LCTk4PAZyEZuQwqmCus0?=
 =?us-ascii?Q?CgwKKcGjjz4tff4Df9wf1TvCnH5VdVO/CWKlozN0HaDRdZNEzDK3hWWb+qeJ?=
 =?us-ascii?Q?JT0naVO6geq3mXdrR8BDtiyeCpKjEPv/GRzhCxbASBCZAYX8ni57tSGSLLxg?=
 =?us-ascii?Q?LuqyegWwT6hCtaCNvUTuFTRQ+9FXk0dC6WwC9xd6/FMdYDXjGmQL75h3KJ6O?=
 =?us-ascii?Q?n0sPEpMe5o6tA3Zn2ovjZjXjYFJsUDcpkTtgQvQRJLZ9SVvll+h0QJrTIomb?=
 =?us-ascii?Q?1tXtBcbc6uSCHMeXH0mzWBF0n3j9zAoWPuJXJ42v9kf1gmg0Cgj/JWGDtCw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 927dfa73-a482-43d4-8e19-08dd5ce2df95
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 19:12:43.9396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6770

From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>=20
> Factor out the check for enabling auto eoi, to be reused in root
> partition code.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/hv.c                | 12 +-----------
>  include/asm-generic/mshyperv.h | 13 +++++++++++++
>  2 files changed, 14 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index a38f84548bc2..308c8f279df8 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -313,17 +313,7 @@ void hv_synic_enable_regs(unsigned int cpu)
>=20
>  	shared_sint.vector =3D vmbus_interrupt;
>  	shared_sint.masked =3D false;
> -
> -	/*
> -	 * On architectures where Hyper-V doesn't support AEOI (e.g., ARM64),
> -	 * it doesn't provide a recommendation flag and AEOI must be disabled.
> -	 */
> -#ifdef HV_DEPRECATING_AEOI_RECOMMENDED
> -	shared_sint.auto_eoi =3D
> -			!(ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED);
> -#else
> -	shared_sint.auto_eoi =3D 0;
> -#endif
> +	shared_sint.auto_eoi =3D hv_recommend_using_aeoi();
>  	hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
>=20
>  	/* Enable the global synic bit */
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index 258034dfd829..1f46d19a16aa 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -77,6 +77,19 @@ extern u64 hv_do_fast_hypercall16(u16 control, u64 inp=
ut1, u64
> input2);
>  bool hv_isolation_type_snp(void);
>  bool hv_isolation_type_tdx(void);
>=20
> +/*
> + * On architectures where Hyper-V doesn't support AEOI (e.g., ARM64),
> + * it doesn't provide a recommendation flag and AEOI must be disabled.
> + */
> +static inline bool hv_recommend_using_aeoi(void)
> +{
> +#ifdef HV_DEPRECATING_AEOI_RECOMMENDED
> +	return !(ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED);
> +#else
> +	return false;
> +#endif
> +}
> +
>  static inline struct hv_proximity_domain_info hv_numa_node_to_pxm_info(i=
nt node)
>  {
>  	struct hv_proximity_domain_info pxm_info =3D {};
> --
> 2.34.1


