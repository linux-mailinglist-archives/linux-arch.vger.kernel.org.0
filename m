Return-Path: <linux-arch+bounces-8966-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3EB9C375B
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 05:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3062E1C21587
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 04:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B252D150990;
	Mon, 11 Nov 2024 04:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Upp/TEjr"
X-Original-To: linux-arch@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azolkn19011026.outbound.protection.outlook.com [52.103.12.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D064714F11E;
	Mon, 11 Nov 2024 04:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731298406; cv=fail; b=tBegRnWcVKhqeLQSrX+cjJrrHmj8adef9veda1uhsfQTFwBlcSISfICCsTuTl4tWheN9SpA6eazlemvQjiSgMwGEbWcgOaEqL0Uj1ZiJQOBvJpWSK9s++w/8G/8Nbw1Ptg8qQG6xMaxbGMeR2wVqr3QI/vs6TRHgFnc3J2GA/os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731298406; c=relaxed/simple;
	bh=Tgy1WizHz6z1xPNPPBLB1ns2pAqNpXaxdi5WCIU+1jo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UMLarQGEQ0rFUp2eHeaGbL3ocToxD0AOAATXHkt7y2SLQXHvF4lv68ZbOAXCK/1vXTjToQX8NS1FLw5Pd45kgEAbcysCWaCsF7JbX1CHpEkgJ/DqiRgvJ6DLJBUHm87EkWuDnNhEP+f42siBA0FY1y65LuipcpooYH8eaPvtVL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Upp/TEjr; arc=fail smtp.client-ip=52.103.12.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UFsqcXNRHUy0exSdZ85CIKpNxxh2N+AAEk57mwRDQQbgu+jogGAI0g0ZVFcNb0/jzGwiMcOiHFsu8+ZP6lGW5+eDN9riW6ER0CJ3SDoQPlq5uNa0PLGq2sTJNyDP/ZPBpFJHj81mbgrzcsXIamruqSi5cCpVTZ7M0oqgDFt7ceiWyJP9Ky2ElMCDrXTtL3xat5D53vSHbwMRgrUlixC0AbpIoyokKDXyvgbtIs8cRj3wl9DBRoE+bC3JpByrQnvkTF7aMl2l8Wcm9aUuzjb4vx0FHTXRL0a88rmHly5/oEFiRA92QI+OM6uReEDmK5kfHUW0CMa6euXa6qxgfbNSNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qaVYvS+LUHKJNqBqfmGmbvsyKwIbvWowzBrD2C80D8=;
 b=gGesYUZzW1SzflVhiIyDo2aT2CFQw7K4z/i9zEh5kVsCyZrNyz0jUY30mHeAw+SVU7VMAYTGZlnrvnlZmInNmQ1ERHeu9YgWy3XXYooWtdixdu2IdNcWY+SarL7mM97b3D58pf5q+ypbz3qbZn8na14EFhWp8doCYzOTU1+V/4ScAdTjjdndfeyFS6B2ej9Uf9QvVzr1O9diWPN65ml6XdNPLJysM02mzJosKduiA40PsDOD61B4Zq6KgqXh7vmDaA3MVfuwU9SeaoTHbmE200hUaJ2CS4fF4H08KE/QPpF4xkhlAxizuO83C0d91rTJUH8u7yrZa0BVOqAYpGFbgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qaVYvS+LUHKJNqBqfmGmbvsyKwIbvWowzBrD2C80D8=;
 b=Upp/TEjrHqSX3bb7LeYjUZ1czVI7w+gqHW8MTeTILSJUOQ7Q5f/rLWwyr4VMTZj/piELhgtcgA9pUTgKppq0YjnJEyBEqo8lB7vwCbT5Uo7C0Nzv+FH7NoqWfwipf4+M6/gcDTA8GBaHR3w2nmQ3RRZ3MyuPMJtOpAPVN4wG6iyfMz5OopXmdCS3eULGFA1mQGtGSC3ptxiiVPscYyIg8ayDa9QePHvhuvwWM2GknIsIwTK4b79Rn2NMBgbEu5/3WwLyhGCfNKAXa17IA4QlaPntVF4mGqQLgDRv+KnsDPiFh5b7M9iOfbHX3M9cJhi9tMCpIf+mXTGLQFzxtn0gWQ==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by DM4PR02MB8958.namprd02.prod.outlook.com (2603:10b6:8:bf::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.20; Mon, 11 Nov 2024 04:13:22 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911%5]) with mapi id 15.20.8137.022; Mon, 11 Nov 2024
 04:13:22 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"luto@kernel.org" <luto@kernel.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"seanjc@google.com" <seanjc@google.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "joro@8bytes.org"
	<joro@8bytes.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "robh@kernel.org"
	<robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
	"muminulrussell@gmail.com" <muminulrussell@gmail.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
	"mukeshrathor@microsoft.com" <mukeshrathor@microsoft.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "apais@linux.microsoft.com"
	<apais@linux.microsoft.com>
Subject: RE: [PATCH v2 2/4] hyperv: Clean up unnecessary #includes
Thread-Topic: [PATCH v2 2/4] hyperv: Clean up unnecessary #includes
Thread-Index: AQHbMWTxIISlBJW0HEuIGHjj68d+8bKvpYLg
Date: Mon, 11 Nov 2024 04:13:22 +0000
Message-ID:
 <BN7PR02MB414866B87BAEA58AC50A8117D4582@BN7PR02MB4148.namprd02.prod.outlook.com>
References:
 <1731018746-25914-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1731018746-25914-3-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1731018746-25914-3-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|DM4PR02MB8958:EE_
x-ms-office365-filtering-correlation-id: ca1c49cf-c631-41c4-6291-08dd02072e52
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|19110799003|461199028|8062599003|15080799006|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZK9oTmy6oZBOEoPAiwdu4qy26WXaxLib0RM7J7F3OtzrIE8SVZxYC+M2Ghs1?=
 =?us-ascii?Q?yJQ4DKUQ5jAB3Ht9rjdprEL4LldnRhrT+aMuxHzbQRkFQIxbBIa97lN9lDmw?=
 =?us-ascii?Q?O92vVziAOs9vrnCPpddhyGUWbgHWRbu9Zr+QP3H0uqr5rZcfjfqh4mTgj3m8?=
 =?us-ascii?Q?Ucnc3/aE0Z4Q+4DnjnEs6Hm+lfDpOvEb7dXgIH6IwbDMrhAVzaXKkq3kh9Tk?=
 =?us-ascii?Q?WgSMwYDWs3WTII2vdj6WehiXCrjchqO+mIppx2pQLea1zN5K9rQeY0SBjtyW?=
 =?us-ascii?Q?jaF/Ps6gqoCSThDYk0PqYJ1G/oYuyCgxNhER/5+YB/06YoRn0+HKByS4tQkt?=
 =?us-ascii?Q?qdaNMZ0GDvqZyvjKBFUhvaY/HntC4IZCVMuKAJpFJ1OQKE/4A5GTGcGXnGoX?=
 =?us-ascii?Q?YMR6nWBHF28L6EsvgRshsnATh/JL73LMNML1/vUObbmQ3EYn7nk8WRBp8inR?=
 =?us-ascii?Q?bk415wRyyYDhpRqbDCyT3n5Q6RuUy+nlwdfza/BAcB5hlZl08Dl/b0JHsc1/?=
 =?us-ascii?Q?CspG4d39HIVHLw3EDcm8FkWGX514+nsajAS1DUF0B64bnhGYixZ9ByLcfzzT?=
 =?us-ascii?Q?b7lT7CljrRLP/pCvMTCqC4ROqR/2/egYLJC/OcQCpQwRhB3fdaOPp5VQv0DV?=
 =?us-ascii?Q?jX5t0DxKkRqTwh5rSzXGyxviBCjj1RQ9VvuZLheEOJB7Aka/+Kg2MsG9A5kk?=
 =?us-ascii?Q?fJcaqO6n2Jl9Xrh+9aFQJHHOHZFP45dO+fssjQtqwL5ZhHy9ULzc578W72AG?=
 =?us-ascii?Q?ssRp5Ks5/83aq9SYndXQBN54Qug+O9jCVKorQeM8ZayzTm8YaY2L+fhtULe4?=
 =?us-ascii?Q?JN0SIj0ZvcQXQj+LzQmJO6u3QSm/xBV32jhl1x48YYjjjNYm4WY9oKjSI0o9?=
 =?us-ascii?Q?6syM1KR2gZC3/4UQLAkeozOrYk44xChzWptab21sTNi1KOxhMKN968oKNjZL?=
 =?us-ascii?Q?lvfLiY63P9YVJpD8xfqfEHQJpEI9OQ5caHGui5yafGLLZAtZnpF2jv3cq2hC?=
 =?us-ascii?Q?y1KFpW8QMex2xhDHvgv1RH5wNQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ipHe8EtbSuG+B750ZUVkEP4xBcdpWoW34GorrNX7mpggv3PQaGGKmJRKJqHg?=
 =?us-ascii?Q?oBDDYtUSwD93wj0Q2PVLu2VyUJxKgNwwSx23AztLECcdI9PTnjZFhNcWnTF2?=
 =?us-ascii?Q?9tJEkcDI8Uup4jnAh5Re3JQgdRziyBxJGu9cdyv+YyDnvDTK6YbwPDdlRyuf?=
 =?us-ascii?Q?AU3d4xrRzB7BrSJFrfcaPiao4x2ZZU+FDNhYD18Os+ca2hnHUUN+aDEWI4s9?=
 =?us-ascii?Q?hS7TeTEHbhJYU4bheFJKis2dLhkNVuDxDQcA9BUQAuW7svmHOdLL9LKm8ljb?=
 =?us-ascii?Q?JtDo5klMSeM61Abz6UBcRY/bfLQynv3+M6oEcOMV2YmZsegx84g43RKvZR8N?=
 =?us-ascii?Q?sTDEtU4jpDtZ/HOEcB/c3OMsyohll3la0yb5nKKFfvwOc9T7EitPGDA6zvoL?=
 =?us-ascii?Q?ejCyCzKbk8apGzV8SkkWmoImFCciHo1aJmsNGpSQaRHeWRaXhNDZW1Kl9hHE?=
 =?us-ascii?Q?94adyOVP5VGGgh6SwYmpASwsYYyMGXCzvxaGQF+n+i+U4COatJZWp50DhJxN?=
 =?us-ascii?Q?bmBEnahAKPtEVHZTl+i/hB0ydtsRI8cDzEq9LPo/uFNiH8uvwGFgvP2ncr55?=
 =?us-ascii?Q?ZOVRywyZEWTMFQuZ0E64g90axWMK1VjohwlTYd2ZG98C4HiUb9/mV1f7lg1f?=
 =?us-ascii?Q?Mq6aJ4pxnPQBWEFNE2YiUkMa37DOEU68NltEHHbcmmBQqSXMgVB8yM0/3JYv?=
 =?us-ascii?Q?dDMSrPvg0QqVqyCYXiOqNPD6RC3UIhaJF52j3HLiNr4gCjeESdokxNNQaH1a?=
 =?us-ascii?Q?aTLkbb+j1dfTpMKpSKn2nuSHddbkH9qYKoCRuTrETa5RyFP15jax/4ohJwd7?=
 =?us-ascii?Q?sXFW2sEDLMI0t+bRodKHqAfwSNPyaeD941kHSBfhZDCnGklalMMbmb2weEHs?=
 =?us-ascii?Q?Cp16rbuTCTTiogoCNjMG5AY/MsITStTu0nI2uPjlkYph7SH3Imxrea99hDaa?=
 =?us-ascii?Q?xRqwRPs3GtdPZIDbWCl9FwT3W3oQEugTHotjq14MgK745iiD98ZsVl+hGxax?=
 =?us-ascii?Q?kdvpQFLgEUBAFLHOwQNeuvLi8d9oZ73ESAw11lhRGqpnoio9DqJhAeyaEvWs?=
 =?us-ascii?Q?jHWznCLjR0hDtYBHwenQ4lAyq44MPyVP4NVQPBnmrkmzsirk2lFgAOdGtC2D?=
 =?us-ascii?Q?kxI31N1zlq0MFX+H4d5tQ+OS9uSA/3/TdIa5L1UKyfwjE3CLDOhYK1dyodmW?=
 =?us-ascii?Q?Bn4I9U8lrB1kuwDlc8v21g0RsPBc0VgEAKJbaMIgsxKRnCVZ7fKyvi59840?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1c49cf-c631-41c4-6291-08dd02072e52
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 04:13:22.1242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB8958

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, Nov=
ember 7, 2024 2:32 PM
>=20
> Remove includes of linux/hyperv.h, mshyperv.h, and hyperv-tlfs.h where
> they are not used.
>=20
> Acked-by: Wei Liu <wei.liu@kernel.org>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  arch/arm64/hyperv/hv_core.c     | 1 -
>  arch/x86/hyperv/hv_apic.c       | 1 -
>  arch/x86/hyperv/hv_init.c       | 1 -
>  arch/x86/hyperv/hv_proc.c       | 1 -
>  arch/x86/hyperv/ivm.c           | 1 -
>  arch/x86/hyperv/mmu.c           | 1 -
>  arch/x86/include/asm/kvm_host.h | 1 -
>  arch/x86/include/asm/mshyperv.h | 1 -
>  arch/x86/mm/pat/set_memory.c    | 2 --
>  9 files changed, 10 deletions(-)
>=20
> diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
> index f1ebc025e1df..7a746a5a6b42 100644
> --- a/arch/arm64/hyperv/hv_core.c
> +++ b/arch/arm64/hyperv/hv_core.c
> @@ -11,7 +11,6 @@
>  #include <linux/types.h>
>  #include <linux/export.h>
>  #include <linux/mm.h>
> -#include <linux/hyperv.h>
>  #include <linux/arm-smccc.h>
>  #include <linux/module.h>
>  #include <asm-generic/bug.h>
> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> index 0569f579338b..f022d5f64fb6 100644
> --- a/arch/x86/hyperv/hv_apic.c
> +++ b/arch/x86/hyperv/hv_apic.c
> @@ -23,7 +23,6 @@
>  #include <linux/vmalloc.h>
>  #include <linux/mm.h>
>  #include <linux/clockchips.h>
> -#include <linux/hyperv.h>
>  #include <linux/slab.h>
>  #include <linux/cpuhotplug.h>
>  #include <asm/hypervisor.h>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 17a71e92a343..1a6354b3e582 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -27,7 +27,6 @@
>  #include <linux/version.h>
>  #include <linux/vmalloc.h>
>  #include <linux/mm.h>
> -#include <linux/hyperv.h>
>  #include <linux/slab.h>
>  #include <linux/kernel.h>
>  #include <linux/cpuhotplug.h>
> diff --git a/arch/x86/hyperv/hv_proc.c b/arch/x86/hyperv/hv_proc.c
> index 3fa1f2ee7b0d..b74c06c04ff1 100644
> --- a/arch/x86/hyperv/hv_proc.c
> +++ b/arch/x86/hyperv/hv_proc.c
> @@ -3,7 +3,6 @@
>  #include <linux/vmalloc.h>
>  #include <linux/mm.h>
>  #include <linux/clockchips.h>
> -#include <linux/hyperv.h>
>  #include <linux/slab.h>
>  #include <linux/cpuhotplug.h>
>  #include <linux/minmax.h>
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 60fc3ed72830..b56d70612734 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -7,7 +7,6 @@
>   */
>=20
>  #include <linux/bitfield.h>
> -#include <linux/hyperv.h>
>  #include <linux/types.h>
>  #include <linux/slab.h>
>  #include <asm/svm.h>
> diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
> index 1cc113200ff5..cc8c3bd0e7c2 100644
> --- a/arch/x86/hyperv/mmu.c
> +++ b/arch/x86/hyperv/mmu.c
> @@ -1,6 +1,5 @@
>  #define pr_fmt(fmt)  "Hyper-V: " fmt
>=20
> -#include <linux/hyperv.h>
>  #include <linux/log2.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index 4a68cb3eba78..3627eab994a3 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -24,7 +24,6 @@
>  #include <linux/pvclock_gtod.h>
>  #include <linux/clocksource.h>
>  #include <linux/irqbypass.h>
> -#include <linux/hyperv.h>
>  #include <linux/kfifo.h>
>=20
>  #include <asm/apic.h>
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 390c4d13956d..47ca48062547 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -9,7 +9,6 @@
>  #include <asm/hyperv-tlfs.h>
>  #include <asm/nospec-branch.h>
>  #include <asm/paravirt.h>
> -#include <asm/mshyperv.h>
>=20
>  /*
>   * Hyper-V always provides a single IO-APIC at this MMIO address.
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 44f7b2ea6a07..85fa0d4509f0 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -32,8 +32,6 @@
>  #include <asm/pgalloc.h>
>  #include <asm/proto.h>
>  #include <asm/memtype.h>
> -#include <asm/hyperv-tlfs.h>
> -#include <asm/mshyperv.h>
>=20
>  #include "../mm_internal.h"
>=20
> --
> 2.34.1

Looks good!

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

