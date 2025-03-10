Return-Path: <linux-arch+bounces-10661-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF70A5AB05
	for <lists+linux-arch@lfdr.de>; Tue, 11 Mar 2025 00:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44D363A1369
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 23:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08C01F874E;
	Mon, 10 Mar 2025 23:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jdRI+SnV"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2079.outbound.protection.outlook.com [40.92.42.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C811E5204;
	Mon, 10 Mar 2025 23:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741648035; cv=fail; b=dphyTuaKcfPj5EnjjU4yPs30lA3ToF2xqW+fClLHLBTFcsMYwXDDtxv3fCetinvTVo+5QooJgVZabErEMjfayBMk4Q65pINM+pYDhsbNshn72+tK20xx/Awv50j+o+WDc9777xPsdGXgQQqsv6nMVSMK+5e4cTrZgkU5df2bIIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741648035; c=relaxed/simple;
	bh=EltUzxYJdZeAS1luLMpkJHEs8ObohUZT1rbgPPCvqI0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EG/c2PEua5kKEVEuDJyg3EnwsUybL1oW0vdk5/wMbY/LdZlJR6LUW1Ud747KVZ7KiWrCGQUbQ9/OkgIqSeP5ofS78QU1I9/ciIzYZOAxNOHZM+O4HNb0VuoQ8buX7daJ35emiH848xQv76oyG2rT8TshfnOlp9pc8K6WcpEu9tM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jdRI+SnV; arc=fail smtp.client-ip=40.92.42.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uf2suMQqxffvWUekH/WpStkxnA8KVEx9T1/faIwFwH/sAfOTR5dfOQFT+rI33ZIIBQ5H4VimRvdDseoSFC64g7lOZlgx4GdLcKDy8PppeGSeTllctLvdi2MpNx5pXgb5yObDRCR40F0lyZsO/fL67rbx4DzeW1Fx90QNM8qHir0FzhxfrogaC2GvzneFBIUhsHgRlpv8HVmcXJeRRsfwW+/6wCES1e7WNetiqWHcqoOeG/TgIhuX+PF3P7Ep9ECSUc1mDGaUXZdJ0Qhnuyrytka0Z8ONkKRqqBQ1azji9fSuJV9jY1XdBFGd3yHyAgZjWslqqDHLoua1SS+R1uC91g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEGoFeJlORz7BWSNlKAGOT0i91fm3KbuA4xg0SIjOkQ=;
 b=i9hZmYMzN0GnGU76aS3QomLD8u+Bt1aHReyJgdcOMtG1JKDtc5PvbxoJxhnaWddD5chTD16t1mWA2nGXJcrqlzk2oo1jgtq4wnM0wi1cFtPZ0AA7fwqCu4m3P2rg8PXzcHMg5UI2oCAi4hjSw88jeH2MpPl05VHfKycs9TIMqqGdR6zY3qP9bQNwDkqmc0/bznwwhspWEV3kUumjWJWKkPki5eysfYVj/IXECIwbhbPDQZbrqGnKMA4v/UKo48kfXK7HXG1qayGh5ZQKgM9ZiLLJpv5Tr5o71eKIDTgzLs2yubzLxB8FUUPefPZzV+DjzXJArAdSglAf8G2y+1ivMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEGoFeJlORz7BWSNlKAGOT0i91fm3KbuA4xg0SIjOkQ=;
 b=jdRI+SnVKJT0kTrHZIsg7SHOKpI5ajqc7wV9FsxXx25pQFSs5T5wm29aiZ9YdC2fh9/9OKr+9URhY+boNps6ZvZFuaXNrm7zSJm8moqgpe0S2RdND3l98rqTzs2TGP1HU5OtoXaCRlI5qeE6hSgZj+QCl1dXj0a8YA1g+jBakIlcMqeHInHGTmqCQAiOuI2ZmLBJbSiWR0g9k8z900WdbZVnudltIu6xXBZQgE1nmtkmRbCXtEVEpR7R8A/tmgJ6UVlwYEmMFBWDACSMitP4qVZJbWH8h4fnQqht6gpDijJ4RRzNpe/E0soD/+cya5PpkSx0eVUCngiC1nOp9kOh9A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BN0PR02MB7965.namprd02.prod.outlook.com (2603:10b6:408:166::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 23:07:10 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 23:07:10 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "joey.gouly@arm.com" <joey.gouly@arm.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "lenb@kernel.org" <lenb@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "maz@kernel.org"
	<maz@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "rafael@kernel.org"
	<rafael@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>, "suzuki.poulose@arm.com"
	<suzuki.poulose@arm.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "will@kernel.org"
	<will@kernel.org>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v5 05/11] arm64: hyperv: Initialize the
 Virtual Trust Level field
Thread-Topic: [PATCH hyperv-next v5 05/11] arm64: hyperv: Initialize the
 Virtual Trust Level field
Thread-Index: AQHbj60CE5hauCaflkaSB574if5JUbNtAp6Q
Date: Mon, 10 Mar 2025 23:07:09 +0000
Message-ID:
 <SN6PR02MB4157DD69C232F25FDBA7594CD4D62@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250307220304.247725-1-romank@linux.microsoft.com>
 <20250307220304.247725-6-romank@linux.microsoft.com>
In-Reply-To: <20250307220304.247725-6-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BN0PR02MB7965:EE_
x-ms-office365-filtering-correlation-id: f932bc66-bbd0-4eca-855f-08dd60284943
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|461199028|19110799003|15080799006|8060799006|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?e7tmQryE11nlPEtc1j81nd2/B15ty9gsDDosAzafr1ApoAuVIj+iJxJqxYm1?=
 =?us-ascii?Q?J+D8oxlLFB2R400Y6ZhUVdZs6W/dKt207KiJaHTS+kBSFF42uJ5sYWj/MMZz?=
 =?us-ascii?Q?f2LBbLgfhkdFZlFnSf47KA5APNdsHPDdUZhZ63c6kRWB+1I3+oGkXsUfN3Lt?=
 =?us-ascii?Q?6oc2zweFTwYcDt9gVaF0RHaPfDQpKqnmkkJsaLhWiOx2/wcJc3mD8q7cfddJ?=
 =?us-ascii?Q?t8tfWtGCW9qoy8BTAkwmKpHn6T0FnMj6iG9eCGLJW3RtupTa9eHlwl7TliCa?=
 =?us-ascii?Q?hMI9FBIspJoIotAgMeCV+C0PsHqYsfKNwWMQ945ERLxnLdit7EILTx2DJKKV?=
 =?us-ascii?Q?M9ItejQDL7NQEF59J/Bd+ySZ0+rCHzhFG4BM5TfA9ZlmLyHV1wcZEJMWJSwI?=
 =?us-ascii?Q?pfT2ks00uI9pBcONnX0M7VGNNX1cO9r0wWpMoZ/p4HM/YgAHsj2sbmZ0I0oD?=
 =?us-ascii?Q?6j1KaXVw4+uEa4ga2c84+kJz7WyRn49gxHxBX6s9mlvxHCt5XHvXRBXIpTDn?=
 =?us-ascii?Q?FMIGmlVI/RfABsdSrnZscpd7TQnH/xyjoSWlXthjtQfN67CDLPJRJul+OitH?=
 =?us-ascii?Q?BjP19INgFFHPjB47cMhITz91PBikXSOc72WvfyH7qK6eEXyWbpiajXz5mQBa?=
 =?us-ascii?Q?K08Q1DP2Juqjapr4WZVrhG2+or4WYMHlu/sxgT2cyYSLrBrWqgwTWhxgExco?=
 =?us-ascii?Q?XU+C1j36Ww3AC3J7JuAuq0bNTxC3sYk5u8koAU/DEbDqB6ScvS1eXOzHY/pt?=
 =?us-ascii?Q?8pcYWrS1xMfbAB6Bp5lTySqsFLgxzpLQ2YUJotaQdm38itpiJnOOKKcmlV4u?=
 =?us-ascii?Q?6XFxTHCWLOEvRYA3bI3hEu+flsDVYQSujzIglCgiaw4/+Gd3HhpsR4x+dWZe?=
 =?us-ascii?Q?YetYbG2W/y4eQqnZ74vgMWV6PRIeVfDQYJ6hNa2iC1lzQsTSDLlPYGOtI83M?=
 =?us-ascii?Q?5Lx0IkUXQLMgnGDcpTt7e3hqSdTbCiRtQFZrWVRvun7Kya41Fz73jPJQQwsq?=
 =?us-ascii?Q?guIc6NwZ9JE4sOTu1I8QOy+bNhd588SOf6BAttxMfnz1KbA=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QcfUvr2MbXkwdpIM+FYRAQOkHCgqQENJi2IkrERxDqImOfkOH4uZ4rIyVjY3?=
 =?us-ascii?Q?TqnRSJblc2/jhpOGfGpmTaX+t7Nm3zMeD1tKLTA/il/tNi6yOV9M83JzURt7?=
 =?us-ascii?Q?XPlnHZNrvEW5voGUK1xVgG6oTHT5IdV9/aiws4cHH9zFKS6la/fI6fzgkGKy?=
 =?us-ascii?Q?V/v0N6htWP55/0kjuWdwCHGoo50BGOD7gj5D8Z4FpdEKt7Y7DO9nK0CByisl?=
 =?us-ascii?Q?uaYYrGq4wtFNSnKqAIPoFja0RgEOGUOiYM9OQaBDklLI9dtfbpjqk1l+dZdJ?=
 =?us-ascii?Q?xaSuuiJQOSN/+n4luO2bbq0NWszl5H/3bLSKQN6hwnGnA6ppVulUu2HYF1HH?=
 =?us-ascii?Q?nbBJEaJYaKBg3Ew4qdgrUfMmk0Lbd81aIqUocA3hlcaU+7i89Fy4nuS0/IBD?=
 =?us-ascii?Q?XUwNpyHCn1D37l+H/mj0oLimtFiu8a9gMnh7UFUBrQ3Lc/TIYlY+b/vMxrAg?=
 =?us-ascii?Q?cLbZ50epYnxxk0jtbKK+1kExSzXP8yM1Pzx5bLzkLfsKRkj45pLTNHR/VGC1?=
 =?us-ascii?Q?p8IRAKJq4CA1Tkzyo8I8jplQ9mMEfzkp7uzQ+0VN2ccJQZWj79bB4JG0MNJa?=
 =?us-ascii?Q?RozQgKjdkOstyz40s6X43Iq9LQuIK6AMZOPGeHtNRSVKD2sFNxAevOh05QXK?=
 =?us-ascii?Q?UFmBtrSufbtL6LhW7qykyL/tMl8iDgHwROOYIYGil4m0kWDh7EaW0Q2dHSSX?=
 =?us-ascii?Q?xdQ/4lQdxNLPI/5lHwm7W+E7z5MHpQFeiBvnBz7vq59spVUJqpBEvFN4vLz0?=
 =?us-ascii?Q?xaM2eyEaxFybcGWMZTmSCsa8a4JR4YSdcXdEICIy6KMArwnZmIspdaz0Bc2N?=
 =?us-ascii?Q?3BKhWSoD9HmNrQ/0cRYyO/YRli7JSaIp1FYuoCkeWuwRraPe+3Pco8QXAKrK?=
 =?us-ascii?Q?hYWdkmckXTbTdPIgCcv2y+65mpv4dah0Xlh98pocurtjl694TxAMrMI7KM73?=
 =?us-ascii?Q?/JVcqkkjNcYnRpbihK8Ao9u17kUWjXIGbaBlaLjbaF9auptjcTg2AoUngdG8?=
 =?us-ascii?Q?vgHHStMGvSeVSBomqT6m4WAL8Y4TWYOli6Ujr2tLeT0cHdWc6na8DZdIwR/L?=
 =?us-ascii?Q?/vLPfpuvD+fg7ELqlEazaeAUYOkfRy+QF+B3HTr7PPfdwttILLNOwh6ysb7e?=
 =?us-ascii?Q?j3RHHI1q6rC+faDgugEBAPEA3QPIIsoytyJ6meW+Z62O9FhmGBDgXvmby1pl?=
 =?us-ascii?Q?8a1HWWd6OhSLjJEpK+OZvvMWlWj80xnfid7WT45NHcadsfL5LFnZCWwmSbE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f932bc66-bbd0-4eca-855f-08dd60284943
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 23:07:10.0056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7965

From: Roman Kisel <romank@linux.microsoft.com> Sent: Friday, March 7, 2025 =
2:03 PM
>=20
> Various parts of the hyperv code need to know what VTL
> the kernel runs at, most notably VMBus needs that to
> establish communication with the host.
>=20
> Initialize the Virtual Trust Level field to enable
> booting in the Virtual Trust Level.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  arch/arm64/hyperv/mshyperv.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index c647db56fd6b..a7db03f5413d 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -107,6 +107,7 @@ static int __init hyperv_init(void)
>=20
>  	if (ms_hyperv.priv_high & HV_ACCESS_PARTITION_ID)
>  		hv_get_partition_id();
> +	ms_hyperv.vtl =3D get_vtl();
>=20
>  	ms_hyperv_late_init();
>=20
> --
> 2.43.0
>=20

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


