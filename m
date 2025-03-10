Return-Path: <linux-arch+bounces-10652-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4AFA5A5F9
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 22:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B088F3AF15A
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 21:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D334A1DF97F;
	Mon, 10 Mar 2025 21:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="vWJCH5ER"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2083.outbound.protection.outlook.com [40.92.42.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465731DEFC5;
	Mon, 10 Mar 2025 21:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741641404; cv=fail; b=K/TZvDyy+anxS6/K+/6CNzWKHunNgX8v6XqlusyAXMpnnU7kSDQP5vJNpxuZAXYfPFeSE6dzfYuX9Zz/gJuclacczyv3f0uzYsxnj6WQe98WNiYZw/Qlt8qv6Lywxb/EfbUmv88lr2dPyUmFW9Y1/S0LzC9LUEKgkrbZiwwFICs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741641404; c=relaxed/simple;
	bh=zGqtVhZD5W3Srj5G2Kit+WEFQTopHKJxGeJEDJX63LU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b35newxq3M9AzQDeg0UbYps5S3WjUFOrQ8mHDYAMcHkHO7LqcAqZHWIQKolKDjXDXV4rC1iBY8Ku9eecvHVwU3GfrUsCNTCJzb5f8N3o4emcxcLiP45EmI2KW6JNQRkZwFvHMYaJkpnYP6gLDzDaCOb8rv9GBNR8bvB9ixTuW4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=vWJCH5ER; arc=fail smtp.client-ip=40.92.42.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILZr9jkqq3nLeQjDuvKZwN27eNppamHllGKxxwPny7L6x9X3J5+iLPee+Mh/aVae1XLNuBW3HBz+rp0T/2rD+e1FOFIIH7xdeZsF9ynkyi7Iof+N/65DYk9uhDAGJcOHnO35jXLVq8oYiX3LmmTOGyWz+F36cC7hV9cjled/Z89yfwRcrgi96dWJ8TRc/qTE5ugN5/RwHA/iCRk/VWCSjNigVTudAx2PetRaM0GiffagH8Us0F3SAR2WEedZKnqu6oYSRnaXG1jSHfc5gR7hcgTd8GDbv2nfzPs9UOuHNo11YN2j5aooCBmr9AcRMleKIzSofPht6P63fC0tgeX0Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIayewRP/RHc4Nl9OCA5mumevJMUZQk/FZSugXQbWOg=;
 b=GhDklNecNfMhacPu3jXCKHLbMe0dO5rwvuC8xIV8lqZFU3b1Tjacv2sbYgUx+EifVKBiUqXxueXFqyskIp/EBDFSPYCn1BYLBMA0PkUODInRep09H+ovT7W4RhL40b9lFa6WeXbqGxR2KvfIgFeJVTh9lfmsNb4/UQGWCIlrKGJve7u5JS2eLNAzSEaknS56Yk2O7ipwxzqIcZlL0PdXVykDPWxKZD1ltr8KKYUsk3mFFK5sTYn1iTJLsVpLVUDH+2wDrPYfRCYi7vP6nYCre7GGKHSueM/dkcqjMo6BlDMYrIp2XusPi3PJV8p39BkxfSTHim/HrBLHmnUH74INXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIayewRP/RHc4Nl9OCA5mumevJMUZQk/FZSugXQbWOg=;
 b=vWJCH5ER8NmDxNID1m92GDpQzgjFqDimPn75uJEe68gwfxWvrNJLzfEuRUIweQRIGx3ioLJZ0DYfYMTNgU1Y+QgyM0GAjPBJDZ3tEBRhs0ODcklQVmzBTtlHVUY23TpUZzp4zchLl1N78kB12nj85/TZNtZgT4PkGLc++Ely7BOX50GxT1QY6OdEA3STLirmyvcT7nRoB41txtTe29+cvuQdqEPwNtvM1nDj12V04n3d9lRw2Ap6MZw0leCh0og2NGJmk/Chbc/UNvRoLJDo+aNA+iUVSfYuFQMtc6wUy4v3sIgrApDrOtaQdkCNI1+cTJMLChICtq2/tvWXEBVRbw==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by PH7PR02MB9989.namprd02.prod.outlook.com (2603:10b6:510:2f9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 21:16:34 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911%4]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 21:16:34 +0000
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
Subject: RE: [PATCH hyperv-next v5 01/11] arm64: kvm, smccc: Introduce and use
 API for detectting hypervisor presence
Thread-Topic: [PATCH hyperv-next v5 01/11] arm64: kvm, smccc: Introduce and
 use API for detectting hypervisor presence
Thread-Index: AQHbj6zkB6eMfwVSZkebOiC+AP/WvrNs4otQ
Date: Mon, 10 Mar 2025 21:16:34 +0000
Message-ID:
 <BN7PR02MB4148539DEFFF5ABA42AB44D3D4D62@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20250307220304.247725-1-romank@linux.microsoft.com>
 <20250307220304.247725-2-romank@linux.microsoft.com>
In-Reply-To: <20250307220304.247725-2-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|PH7PR02MB9989:EE_
x-ms-office365-filtering-correlation-id: 7da56511-fab2-4c23-454f-08dd6018d635
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|19110799003|8060799006|461199028|8062599003|440099028|3412199025|102099032|41001999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2p7fxy8CurL5jM+GLw0WI3dUtDs3soOgTruwRkr9RHmezTbmV85jLHonB+Dl?=
 =?us-ascii?Q?eI1RQHq0jwWWeJ9RsJX8ycUs20vFpNpsyq1S7v7FHOKoslIIiUzr6ANLt1YR?=
 =?us-ascii?Q?7xWRW1ns1ofu6SAWNYVPuZlibJ8pjtKPU9cpiNH/qM0zXzBYPZiogP9CbtHL?=
 =?us-ascii?Q?ezvCozB4Pt7uKjtZ3FSecFg0//7t6vlOf8pEDyq+CrdwCXdbn4P1V4Qn3xtZ?=
 =?us-ascii?Q?YKwTR9/wN/C6zQf4IjTDDAkpH3qLf4h9H3duPtug919ztkwvWaMINeluOgz2?=
 =?us-ascii?Q?vhySNkoLDLiv1L+wJ8cXmdtlrUETlxYYqoy4vGzI5yoycgUSMcSBask+t8Ww?=
 =?us-ascii?Q?vOGwPmVSDAuXhWP0ccuF935BU0nzyE6X4muWe+xYfBhjqcTnvC6zSmx/rEDf?=
 =?us-ascii?Q?hc4kOlwouqyrlC/v9/H+poBHemRRpLhbYMJk5JRRem3ZHUAge04PWm9QF5It?=
 =?us-ascii?Q?R310D9wUDRDONzs9Q972+Crqe7K60Eh+7V88Nt6oueqLB7oBAyFeKJbvxdOP?=
 =?us-ascii?Q?FPzGcTQs2NsziJgRZwuvc67tAXW/wE/bNWDte9mA7Y9JjWgWefhQwV/AG0xw?=
 =?us-ascii?Q?elVMjy9Wp6wjg3E3KXMEb6YnymYOsxwqX3Wx69tLVnPlzhDjaPyk/jxuJSq7?=
 =?us-ascii?Q?95uHXUNLHLxx7PYeMNFo8op4ylGJYmNXDepivMicTbGC2gFgYYq5GiBugU+C?=
 =?us-ascii?Q?nqp79IPsFz6An9aIpYXfW8acWGhDP5lFp4mL4NwRg9roW8bfIbctOPkKoD7U?=
 =?us-ascii?Q?iwcG4L/A3Thkaf3CXH/UEJyTnsF6Rs53UNovwK9Q1EzuEerKsfjxhfSqo0US?=
 =?us-ascii?Q?un7IZJoW/GSMq9sRWwzaqsoT/i3HYgpx14yfVULxPc3zRHdAXfmUn4ytiBv9?=
 =?us-ascii?Q?11doX5UzPvORnJKhV9P8okzm8bT9csv3JSEhTRjW2CqZxUuutmb1N7t1ox48?=
 =?us-ascii?Q?INY8yb5BcGfmwY0IXATt0FDkXhaxWgAVplyGtRHcXwtgb299RpqCwg3yvthe?=
 =?us-ascii?Q?eHQC4XnQaoZmqP/dX5Z0QST/0Yim+Ic9SKTQiRsH83lOIIiKzFQWEET157Bo?=
 =?us-ascii?Q?+916hs0lcmzUP6KEi/2O+Pb6yLHoRg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?55z51amlvqAPvYug6VxnX8wgwOW2IMzOMsJhH7YGVwVCzCrnoTiZ2e57ZMmw?=
 =?us-ascii?Q?FQxTleDvE9uuFSCeukgP1wAXwimD5m2hBt3KhTXmQ1f38IZPTvxODbfiu2KH?=
 =?us-ascii?Q?3RETpIyY5zODw+2GzVde03Y3kZU2jWoJBEsUexAkUCIHnCkdRAs9LF2l5iT9?=
 =?us-ascii?Q?Bh67sq5WeVDrsXGMEYVJtmdd/sPtIQ1bYCwfW92tlWEGdeR1o9t0iEihcwGO?=
 =?us-ascii?Q?q5xcpsy+j5i+PAEDq8LAtkScN8f6xCYXIhve59igDcR3s8+qcr9ebeXyb22O?=
 =?us-ascii?Q?AcsxHrF4lqLP8h4Dsh4nsA9nOY81l3RE4w2bC+pz05QjLElPs4LFaaYvBDYv?=
 =?us-ascii?Q?6PD6xe1z5GBijppm+7Ox5WSmxvUP18VYQqWLIJW3z1o4YcdN6JxWaGq0e5os?=
 =?us-ascii?Q?valDMRHwrRI3yoC3df2SjuiYiWopld0s9iP1Hyi/HOHHAZl87LXRmh4AMnsz?=
 =?us-ascii?Q?e6mBUaa+X3obQLgXUxAEWo11ZM3fvlae+4aUophGO7vgKAHso79KdFGp5xyg?=
 =?us-ascii?Q?x7i3vKC+HtyIjTnH52+uf+tYveC/cYM8rJSnBSUE6qUeZdn0Czkld+qDHT1f?=
 =?us-ascii?Q?pJsK9UwC4kuJvhWwgNmFpJOo40UI8J6mt6ElgG7JmEEKMKLVBsZWy/lAVwTA?=
 =?us-ascii?Q?ywA6qRTqYtYNxyqXaKakJFLBo0hGMQkZ4rrAFeRNdDxEyQgsEQy5q0alYbRY?=
 =?us-ascii?Q?0qYKfclckdnEph1zosM7OHcqSGFBVEcAl003biculH/FWddP5CBMNfM9ABUK?=
 =?us-ascii?Q?fzqfTA1WRr7o1sYHpfOTeA5wLWBrdx/rNbL/ClnAmBUUi440BRfX6R2ZHYL0?=
 =?us-ascii?Q?PmPTBSWMY744XVjd3YaopE6hX7XfbTfjuIWk48yL0xsO9kxGBxlnbim6M15u?=
 =?us-ascii?Q?SoS9Q0kT3mmn5dyhKniwdoQM+AIT1iCGWx2OHH6R86fKs4W9+HoEfKKXsQui?=
 =?us-ascii?Q?sw8PU3+Aq55AQ18sP5hd33tDDdtYLMxMwiPTr+GszVFlGSYcgrzbf32UcOfH?=
 =?us-ascii?Q?1qENUZW+SBVMvnTcAP43P2J+ILMHpLsiat2lAfBrDV0elEjpV9vmQOE882e8?=
 =?us-ascii?Q?7PP8QOo4xR9HVRiMRa0IMBQvvHUw5Vxb6Vf4MJU16rImWaa6k96MLIE3Hnge?=
 =?us-ascii?Q?h78vr7RIrcjtemyhla7pH6gF5fBj2dHt0zejmuu5/u0huKj9ASo0V9zs+2sE?=
 =?us-ascii?Q?J0Qe7cPUaiu7FGbWfoMTqDW3p0Bce3K4Rvyz4kTrbDqKMaqEXh83Hgq025o?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da56511-fab2-4c23-454f-08dd6018d635
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 21:16:34.5508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB9989

From: Roman Kisel <romank@linux.microsoft.com> Sent: Friday, March 7, 2025 =
2:03 PM
>=20

In the Subject line,

s/detectting/detecting/

> The KVM/arm64 uses SMCCC to detect hypervisor presence. That code is
> private, and it follows the SMCCC specification. Other existing and
> emerging hypervisor guest implementations can and should use that
> standard approach as well.
>=20
> Factor out a common infrastructure that the guests can use, update KVM
> to employ the new API. The cenrtal notion of the SMCCC method is the

s/cenrtal/central/

> UUID of the hypervisor, and the API follows that.
>=20
> No functional changes. Validated with a KVM/arm64 guest.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  arch/arm64/kvm/hypercalls.c        |  5 +--
>  drivers/firmware/smccc/kvm_guest.c | 10 ++----
>  drivers/firmware/smccc/smccc.c     | 19 +++++++++++
>  include/linux/arm-smccc.h          | 55 +++++++++++++++++++++++++++---
>  4 files changed, 73 insertions(+), 16 deletions(-)
>=20
> diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
> index 27ce4cb44904..92b9bc1ea8e8 100644
> --- a/arch/arm64/kvm/hypercalls.c
> +++ b/arch/arm64/kvm/hypercalls.c
> @@ -353,10 +353,7 @@ int kvm_smccc_call_handler(struct kvm_vcpu *vcpu)
>  			val[0] =3D gpa;
>  		break;
>  	case ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID:
> -		val[0] =3D ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_0;
> -		val[1] =3D ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_1;
> -		val[2] =3D ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_2;
> -		val[3] =3D ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_3;
> +		UUID_TO_SMCCC_RES(ARM_SMCCC_VENDOR_HYP_UID_KVM, val);
>  		break;
>  	case ARM_SMCCC_VENDOR_HYP_KVM_FEATURES_FUNC_ID:
>  		val[0] =3D smccc_feat->vendor_hyp_bmap;
> diff --git a/drivers/firmware/smccc/kvm_guest.c b/drivers/firmware/smccc/=
kvm_guest.c
> index f3319be20b36..b5084b309ea0 100644
> --- a/drivers/firmware/smccc/kvm_guest.c
> +++ b/drivers/firmware/smccc/kvm_guest.c
> @@ -14,17 +14,11 @@ static DECLARE_BITMAP(__kvm_arm_hyp_services,
> ARM_SMCCC_KVM_NUM_FUNCS) __ro_afte
>=20
>  void __init kvm_init_hyp_services(void)
>  {
> +	uuid_t kvm_uuid =3D ARM_SMCCC_VENDOR_HYP_UID_KVM;
>  	struct arm_smccc_res res;
>  	u32 val[4];
>=20
> -	if (arm_smccc_1_1_get_conduit() !=3D SMCCC_CONDUIT_HVC)
> -		return;
> -
> -	arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID, &res);
> -	if (res.a0 !=3D ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_0 ||
> -	    res.a1 !=3D ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_1 ||
> -	    res.a2 !=3D ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_2 ||
> -	    res.a3 !=3D ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_3)
> +	if (!arm_smccc_hyp_present(&kvm_uuid))
>  		return;
>=20
>  	memset(&res, 0, sizeof(res));
> diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smcc=
c.c
> index a74600d9f2d7..7399f27d58e5 100644
> --- a/drivers/firmware/smccc/smccc.c
> +++ b/drivers/firmware/smccc/smccc.c
> @@ -67,6 +67,25 @@ s32 arm_smccc_get_soc_id_revision(void)
>  }
>  EXPORT_SYMBOL_GPL(arm_smccc_get_soc_id_revision);
>=20
> +bool arm_smccc_hyp_present(const uuid_t *hyp_uuid)
> +{
> +	struct arm_smccc_res res =3D {};
> +
> +	if (arm_smccc_1_1_get_conduit() !=3D SMCCC_CONDUIT_HVC)
> +		return false;
> +	arm_smccc_1_1_hvc(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID, &res);
> +	if (res.a0 =3D=3D SMCCC_RET_NOT_SUPPORTED)
> +		return false;
> +
> +	return ({
> +		const uuid_t uuid =3D SMCCC_RES_TO_UUID(res.a0, res.a1, res.a2, res.a3=
);
> +		const bool present =3D uuid_equal(&uuid, hyp_uuid);
> +
> +		present;
> +	});
> +}
> +EXPORT_SYMBOL_GPL(arm_smccc_hyp_present);
> +
>  static int __init smccc_devices_init(void)
>  {
>  	struct platform_device *pdev;
> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> index 67f6fdf2e7cd..726f18221f1c 100644
> --- a/include/linux/arm-smccc.h
> +++ b/include/linux/arm-smccc.h
> @@ -7,6 +7,11 @@
>=20
>  #include <linux/args.h>
>  #include <linux/init.h>
> +
> +#ifndef __ASSEMBLER__
> +#include <linux/uuid.h>
> +#endif
> +
>  #include <uapi/linux/const.h>
>=20
>  /*
> @@ -107,10 +112,10 @@
>  			   ARM_SMCCC_FUNC_QUERY_CALL_UID)
>=20
>  /* KVM UID value: 28b46fb6-2ec5-11e9-a9ca-4b564d003a74 */
> -#define ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_0	0xb66fb428U
> -#define ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_1	0xe911c52eU
> -#define ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_2	0x564bcaa9U
> -#define ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_3	0x743a004dU
> +#define ARM_SMCCC_VENDOR_HYP_UID_KVM UUID_INIT(\
> +	0xb66fb428, 0xc52e, 0xe911, \
> +	0xa9, 0xca, 0x4b, 0x56, \
> +	0x4d, 0x00, 0x3a, 0x74)
>=20
>  /* KVM "vendor specific" services */
>  #define ARM_SMCCC_KVM_FUNC_FEATURES		0
> @@ -333,6 +338,48 @@ s32 arm_smccc_get_soc_id_version(void);
>   */
>  s32 arm_smccc_get_soc_id_revision(void);
>=20
> +#ifndef __ASSEMBLER__
> +
> +/**
> + * arm_smccc_hyp_present(const uuid_t *hyp_uuid)
> + *
> + * Returns `true` if the hypervisor advertises its presence via SMCCC.
> + *
> + * When the function returns `false`, the caller shall not assume that
> + * there is no hypervisor running. Instead, the caller must fall back to
> + * other approaches if any are available.
> + */
> +bool arm_smccc_hyp_present(const uuid_t *hyp_uuid);
> +
> +#define SMCCC_RES_TO_UUID(r0, r1, r2, r3) \
> +	UUID_INIT( \
> +		cpu_to_le32(lower_32_bits(r0)), \
> +		cpu_to_le32(lower_32_bits(r1)) & 0xffff, \
> +		cpu_to_le32(lower_32_bits(r1)) >> 16, \
> +		cpu_to_le32(lower_32_bits(r2)) & 0xff, \
> +		(cpu_to_le32(lower_32_bits(r2)) >> 8) & 0xff, \
> +		(cpu_to_le32(lower_32_bits(r2)) >> 16) & 0xff, \
> +		(cpu_to_le32(lower_32_bits(r2)) >> 24) & 0xff, \
> +		cpu_to_le32(lower_32_bits(r3)) & 0xff, \
> +		(cpu_to_le32(lower_32_bits(r3)) >> 8) & 0xff, \
> +		(cpu_to_le32(lower_32_bits(r3)) >> 16) & 0xff, \
> +		(cpu_to_le32(lower_32_bits(r3)) >> 24) & 0xff \
> +	)
> +
> +#define UUID_TO_SMCCC_RES(uuid_init, regs) do { \
> +		const uuid_t uuid =3D uuid_init; \
> +		(regs)[0] =3D le32_to_cpu((u32)uuid.b[0] | (uuid.b[1] << 8) | \
> +						((uuid.b[2]) << 16) | ((uuid.b[3]) << 24));
> \
> +		(regs)[1] =3D le32_to_cpu((u32)uuid.b[4] | (uuid.b[5] << 8) | \
> +						((uuid.b[6]) << 16) | ((uuid.b[7]) << 24));
> \
> +		(regs)[2] =3D le32_to_cpu((u32)uuid.b[8] | (uuid.b[9] << 8) | \
> +						((uuid.b[10]) << 16) | ((uuid.b[11]) <<
> 24)); \
> +		(regs)[3] =3D le32_to_cpu((u32)uuid.b[12] | (uuid.b[13] << 8) | \
> +						((uuid.b[14]) << 16) | ((uuid.b[15]) <<
> 24)); \
> +	} while (0)
> +
> +#endif /* !__ASSEMBLER__ */
> +
>  /**
>   * struct arm_smccc_res - Result from SMC/HVC call
>   * @a0-a3 result values from registers 0 to 3
> --
> 2.43.0
>=20


