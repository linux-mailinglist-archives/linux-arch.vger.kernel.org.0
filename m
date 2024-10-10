Return-Path: <linux-arch+bounces-7990-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A35F998FBC
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 20:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB347283729
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 18:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55F71CDFCB;
	Thu, 10 Oct 2024 18:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="PLxP4z2p"
X-Original-To: linux-arch@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010014.outbound.protection.outlook.com [52.103.20.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902491A303E;
	Thu, 10 Oct 2024 18:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584515; cv=fail; b=mPXFvKupr5F3gAOs9DyYR7wXpeALqrDD5yXRGMOkgTjt9Qm99UnIVzimMRHyNxqe+/Ru3U+lwCmLL8jLK8VJZiU72wCjI+deF6Bs67Z/1iy0D0X7t2Aqgrc19MrJzCpvCTkFpRUON/raNWb9domU9l5b8lcxdWoqFWe7MuFZQhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584515; c=relaxed/simple;
	bh=3e3pTuM7zoh4DUiUrYaBwW5iK0qiBAa0yD4JLwsvjiA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KnTtFxGXHivFnz6AiH36WSq81LnpY4O7pWBGw1ZYPrdyRdddCs4fXjWuVkRLyFAEcryAN58P+gAd8Bl/AzT1KAgfimCUVeG+8C6b4Nf65XanCJxLmIZjujc5GSgl1NX+X8b1t0FiVctqHfFiNmN6irSa3Rj+uE4DlzpQUou0c7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=PLxP4z2p; arc=fail smtp.client-ip=52.103.20.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqPF/jduc5gc4QvTQGOWIc3A9vGJXDSi3M0Vd6I4soShYf8lTRncEw3tAHHL9t1DiHCv2qDf2kHuIl48SJGer6Y1MRALHucvR7ir+zPVBLy6+/5yoKY/VhAfZAfEJc7mpnzqiML7TKGpoMERY9VSMaD+SY99EzBFlhh52SOeMrWMebBPNb9vAs0RR8pq9hT7fhV9rd049u5UKyc7WdY0H/2yCfUwS1wSSQUCfSpWL2G5KwZIV/kg4U9hrrRcvukuEUN3+7kvUdSwnZNyysP4LM9Ht/WjPMsPgri/Dbfs0JL8nPP7fCFdkt6agBnX7gCu0wyOjP09mP/KekE9DzlIGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1ksaL0y7psaLFxyXpHyD0quBQfS4Jw9JpRU3O4SSks=;
 b=YGmUCd8UdSuyJDYh/I6gAB5smBEcFIHjzLyYSDYeWvKqgvuhBeNbArF9qSWm0TrzUkHC80F/iHksM8ywewkTxziuii1ab0mEENdKzZzHaJCwNqOAS2jZgi4Shchi4qmVPXJCIratx9xOH1KwPxYB7v5Sxm2nh05X5WMNhbxU6VPh5YNeWOmLL84OpAXMwwRXUvz31juBdf8dDbxnhO/1v15+OFeGZelDRBm9/sG8VOJM27dlTh11oprkk8cYrwaiHVoZ7nkYxsYDwze9Yejh2+Vfjqu5/9bx28ymf8SVAk2xVZXybRo9esU9Py+aMQZ8qcL7HPIKJCpNAJ65TkK0Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1ksaL0y7psaLFxyXpHyD0quBQfS4Jw9JpRU3O4SSks=;
 b=PLxP4z2ppZF8WNSAPIIrtQAnSe6DAzOERO9P27J1GAhXGmsvzAaa2OOSnV3ebI7aYmTshPf2RMVNO/eNrqo/E/SOsVgOUoNoPtmlC+vN41LyrSBTjnIJozI8SqVDb3NbFyZzKTw7osjOP5Z2tpubGDkUIFtZ7GHHjSvsX+kEh3N8bPPIY4Q07HgnSaTcIR9K/RUuXozvTfI7JUIQ/cgAfk2hWyNX/2AVLgNWMHA+l2zSHzD4fGbl2Hev4bKTy7RfyEJlW0Bd8zmLuu2Ehq0qQ9n1XGdLWAzzEVvBxO72suyow1Ds+hmWeuazjBzmmO3cLXNY8onwZKyOp8WWYXKFYQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV3PR02MB10761.namprd02.prod.outlook.com (2603:10b6:408:281::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 18:21:49 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8026.020; Thu, 10 Oct 2024
 18:21:48 +0000
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
	"mukeshrathor@microsoft.com" <mukeshrathor@microsoft.com>
Subject: RE: [PATCH 2/5] hyperv: Remove unnecessary #includes
Thread-Topic: [PATCH 2/5] hyperv: Remove unnecessary #includes
Thread-Index: AQHbFc3yiphzWSzLT0avsPkYapv3MrJ/VZ7g
Date: Thu, 10 Oct 2024 18:21:48 +0000
Message-ID:
 <SN6PR02MB41576686E491F8EEA9FDB5F3D4782@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1727985064-18362-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1727985064-18362-3-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1727985064-18362-3-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV3PR02MB10761:EE_
x-ms-office365-filtering-correlation-id: 58aa74dc-efb8-4c1f-4f1d-08dce9586786
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|15080799006|7042599007|461199028|19110799003|8062599003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 1lA1r9eVUGfdbLPnJiK+b3ck5tEFVX2r1FW/VBbPmdxRv6CQDz908eSbYIclJh7c0LQ4ZZqqnfwsg2wA0VfTcq1zP9HNiTAzqxWzdP///xhWRprNEGXIg4aiGrFyZRpX3OlLmEyO2Qo++OVIkL/Iwuu1Otefn+3k99TLeMiIB5+plVKncdg2qzCpk9naiGua1kTLZ340/YwxfWaHxF1/NBL37cAN52FPFtJxzwhmdweyrWJpDCaXQtox/vR7EPvTlWxrBKkhJhvKMMwh7lagmErJhtoYl5Izem9VmvL7sTGbyLewliBeUprhKHk8l1V28wYveYFviTa6mpbQvuYz1+1dN3fBj6A0flS0GkEcwbjDOug44arIg/W6DnLEVFODYvsoL7QwYETTAWRx9V9xmzmzrK0jFSiiYnNqP1qOeJmyipQ8dV/HdjtvebM+3/A/K9sjBQ20oAAY2rhFgBmyeXPW6GawH7wAcQ9aeWZbyCjTwWqyLkUZH6PXyCCQ4P2LZWwmF+YyOSxdJmGTt8vvGI4k4haNyv2Bje+ohEbiIHAT3OPuII71yqHVENAFH25gx5ss7iKuen+P3xm8uljoXmrWEuhO9DaIJpK/V758do6hVQxneG85u4TbMfDBmnKgn4GCkGeAt7aUEAd2Ar38lSjPqFRvII7L1IZpV/dqArZ8v4E3E6t2ymRYeKkEgvD8irpjSPXJdf3ixrhOhAa89hgDg0+cuJUPuC9xYM+rTcc=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3IZXbhDaeXuQ6KbmE1bwPniJwHbiYrWldUolyFx5Aug1aA7j0qd89kkyURgc?=
 =?us-ascii?Q?U5AlFVXTb53m/ugkoP6pKkKx7Ql82jX7coPfw7+trnuNCB68bwxIlIsxzQuJ?=
 =?us-ascii?Q?D9GDG1VEAXvMUBcLNLlJq2LSpjTe5n30vv14Q5AWCwDuJ+EjIVDu0OjH3nIo?=
 =?us-ascii?Q?s/iUiTpLYPlocNRYuUiro/Fd/h2YCeRx9i992DJOZFZ+/89dXQuvyEDKUFkZ?=
 =?us-ascii?Q?k+tCBYhw5bKmRRneUyiwOBS7eRzYzI0rQ1VuNZNlu6Opf+bsgWkmqxwBYwOA?=
 =?us-ascii?Q?2pBvxxRs+1d4Co+88il4kB3dwFOx4woJdsWjNcdrQx1l4+rsdc+T2PhCgQnj?=
 =?us-ascii?Q?Icqg0VYZAVgKyUNiJzo5sJHhIV0nPoadP/MDPM3qShK+DkAM6sZaa5e6q6E4?=
 =?us-ascii?Q?4Ib99TU8NqowsEokxddq+xM2AbPL/7Yl/KTIJLUZHcqzWksyAzgU1GtJwogt?=
 =?us-ascii?Q?iSpUDpfSE4vPFDL8uyvYjKj3GNkSwB1RU9Jqsu9deOHnzSLJ472xHK2N1fee?=
 =?us-ascii?Q?dS6PGQ6nBxMLmQIe4JQo3AR6Qle+x344NJvnIWavoT5C4nqihpxuzlevATgG?=
 =?us-ascii?Q?v7HEBkk/sj3/r/IptuqEvvP8bFJcPdC23Odkacirz1TeUHsBVdjjwwZx8Q73?=
 =?us-ascii?Q?AT2qxa0OKu7eJL95EfMyxGGJ0+dQXjuDs1/Joug06KQ6wMOacasi6q8zrSya?=
 =?us-ascii?Q?vNVnryptBlkdwxvbuir9xLAdmn1xiNtD6HIfCaFKq71x2B/I3ONhjjtYHntV?=
 =?us-ascii?Q?kWqcRQsl8SLL670uwNEUavJgKe/sV5TESkZQicHb4ngcjFZS1jVe5eiIBmtO?=
 =?us-ascii?Q?3rWcODIr4op4QtGT4it2mHe6p5alJn+51qJYGNF5qdehas9NdiPkLhn73UAl?=
 =?us-ascii?Q?K5x8hDVJdOUkxsdGccESqxvnWfWyOTA8sh57WRsSe0nyUGmKHlDErk7E8KYj?=
 =?us-ascii?Q?SdIM9I6kNlLPETZJVDPCq2RVYfLCALBqh7wQJmoa5CAUdJOYb6ak/7obCCmD?=
 =?us-ascii?Q?gIeaM3/Uwv4ng8iu/3lwJlmYx7+l0cdTlcmeFfb60/55OzWia59D8/u1nwMc?=
 =?us-ascii?Q?BUg7guCIFeV/ekPMI1SpnnEtk92fCg+J4Xzr9gctsY5k5mkOAlLFPFK6zY7b?=
 =?us-ascii?Q?b5f+bbrLcwBtTnP8bO7hOdIb+TVuo0c9iDfQoySqUydJI4YKovlBbcQAS4yi?=
 =?us-ascii?Q?HRFtUZrpPgqTy1oja7Drbw8yKiGp+lnJQDQHtkx9qsGGA4MLluWeixZdmTk?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 58aa74dc-efb8-4c1f-4f1d-08dce9586786
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 18:21:48.2427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10761

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, Oct=
ober 3, 2024 12:51 PM
>=20
> asm/hyperv-tlfs.h is already included implicitly wherever mshyperv.h
> or linux/hyperv.h is included. Remove those redundancies.

I've been under the impression that it is preferable to directly include
.h files for all definitions that a source code file uses, even if the
needed .h file is indirectly included by some other .h file. I looked throu=
gh
the coding style documentation, and didn't find anything addressing
this topic, so maybe I'm wrong. But I know I've seen patches to other
parts of the kernel that were changes to follow the direct inclusion
approach.  Direct inclusion is less fragile if the #include file nesting
structure changes (and perhaps removes the indirect inclusion).

The mshyperv.h and linux/hyperv.h dependency on hyperv-tlfs.h is
highly unlikely to change, so the chance of breakage is minimal. But
I wonder if your approach is going the wrong direction vs. preferred
kernel practices.

Michael

>=20
> Remove includes of linux/hyperv.h and mshyperv.h where they are not
> needed.
>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  arch/arm64/hyperv/hv_core.c        | 2 --
>  arch/x86/hyperv/hv_apic.c          | 1 -
>  arch/x86/hyperv/hv_init.c          | 2 --
>  arch/x86/hyperv/hv_proc.c          | 1 -
>  arch/x86/hyperv/ivm.c              | 1 -
>  arch/x86/hyperv/mmu.c              | 1 -
>  arch/x86/hyperv/nested.c           | 1 -
>  arch/x86/include/asm/kvm_host.h    | 1 -
>  arch/x86/include/asm/mshyperv.h    | 1 -
>  arch/x86/kernel/cpu/mshyperv.c     | 1 -
>  arch/x86/kvm/vmx/vmx_onhyperv.h    | 1 -
>  arch/x86/mm/pat/set_memory.c       | 2 --
>  drivers/clocksource/hyperv_timer.c | 1 -
>  drivers/hv/hv_balloon.c            | 2 --
>  drivers/hv/hv_common.c             | 1 -
>  drivers/hv/hv_kvp.c                | 1 -
>  drivers/hv/hv_snapshot.c           | 1 -
>  drivers/hv/hyperv_vmbus.h          | 1 -
>  net/vmw_vsock/hyperv_transport.c   | 1 -
>  19 files changed, 23 deletions(-)
>=20
> diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
> index f1ebc025e1df..9d1969b875e9 100644
> --- a/arch/arm64/hyperv/hv_core.c
> +++ b/arch/arm64/hyperv/hv_core.c
> @@ -11,11 +11,9 @@
>  #include <linux/types.h>
>  #include <linux/export.h>
>  #include <linux/mm.h>
> -#include <linux/hyperv.h>
>  #include <linux/arm-smccc.h>
>  #include <linux/module.h>
>  #include <asm-generic/bug.h>
> -#include <asm/hyperv-tlfs.h>
>  #include <asm/mshyperv.h>
>=20
>  /*
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
> index 17a71e92a343..fc3c3d76c181 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -19,7 +19,6 @@
>  #include <asm/sev.h>
>  #include <asm/ibt.h>
>  #include <asm/hypervisor.h>
> -#include <asm/hyperv-tlfs.h>
>  #include <asm/mshyperv.h>
>  #include <asm/idtentry.h>
>  #include <asm/set_memory.h>
> @@ -27,7 +26,6 @@
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
> diff --git a/arch/x86/hyperv/nested.c b/arch/x86/hyperv/nested.c
> index 9dc259fa322e..ee06d0315c24 100644
> --- a/arch/x86/hyperv/nested.c
> +++ b/arch/x86/hyperv/nested.c
> @@ -11,7 +11,6 @@
>=20
>=20
>  #include <linux/types.h>
> -#include <asm/hyperv-tlfs.h>
>  #include <asm/mshyperv.h>
>  #include <asm/tlbflush.h>
>=20
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
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index e0fd57a8ba84..8e8fd23b1439 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -20,7 +20,6 @@
>  #include <linux/random.h>
>  #include <asm/processor.h>
>  #include <asm/hypervisor.h>
> -#include <asm/hyperv-tlfs.h>
>  #include <asm/mshyperv.h>
>  #include <asm/desc.h>
>  #include <asm/idtentry.h>
> diff --git a/arch/x86/kvm/vmx/vmx_onhyperv.h
> b/arch/x86/kvm/vmx/vmx_onhyperv.h
> index eb48153bfd73..f4b081eb6521 100644
> --- a/arch/x86/kvm/vmx/vmx_onhyperv.h
> +++ b/arch/x86/kvm/vmx/vmx_onhyperv.h
> @@ -3,7 +3,6 @@
>  #ifndef __ARCH_X86_KVM_VMX_ONHYPERV_H__
>  #define __ARCH_X86_KVM_VMX_ONHYPERV_H__
>=20
> -#include <asm/hyperv-tlfs.h>
>  #include <asm/mshyperv.h>
>=20
>  #include <linux/jump_label.h>
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
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyp=
erv_timer.c
> index b2a080647e41..1b7de45a7185 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -23,7 +23,6 @@
>  #include <linux/acpi.h>
>  #include <linux/hyperv.h>
>  #include <clocksource/hyperv_timer.h>
> -#include <asm/hyperv-tlfs.h>
>  #include <asm/mshyperv.h>
>=20
>  static struct clock_event_device __percpu *hv_clock_event;
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index c38dcdfcb914..a120e9b80ded 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -28,8 +28,6 @@
>  #include <linux/sizes.h>
>=20
>  #include <linux/hyperv.h>
> -#include <asm/hyperv-tlfs.h>
> -
>  #include <asm/mshyperv.h>
>=20
>  #define CREATE_TRACE_POINTS
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 9c452bfbd571..a5217f837237 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -28,7 +28,6 @@
>  #include <linux/slab.h>
>  #include <linux/dma-map-ops.h>
>  #include <linux/set_memory.h>
> -#include <asm/hyperv-tlfs.h>
>  #include <asm/mshyperv.h>
>=20
>  /*
> diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
> index d35b60c06114..68e73ec7ab28 100644
> --- a/drivers/hv/hv_kvp.c
> +++ b/drivers/hv/hv_kvp.c
> @@ -27,7 +27,6 @@
>  #include <linux/connector.h>
>  #include <linux/workqueue.h>
>  #include <linux/hyperv.h>
> -#include <asm/hyperv-tlfs.h>
>=20
>  #include "hyperv_vmbus.h"
>  #include "hv_utils_transport.h"
> diff --git a/drivers/hv/hv_snapshot.c b/drivers/hv/hv_snapshot.c
> index 0d2184be1691..90fc935e89bd 100644
> --- a/drivers/hv/hv_snapshot.c
> +++ b/drivers/hv/hv_snapshot.c
> @@ -12,7 +12,6 @@
>  #include <linux/connector.h>
>  #include <linux/workqueue.h>
>  #include <linux/hyperv.h>
> -#include <asm/hyperv-tlfs.h>
>=20
>  #include "hyperv_vmbus.h"
>  #include "hv_utils_transport.h"
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 76ac5185a01a..321770d7ce25 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -15,7 +15,6 @@
>  #include <linux/list.h>
>  #include <linux/bitops.h>
>  #include <asm/sync_bitops.h>
> -#include <asm/hyperv-tlfs.h>
>  #include <linux/atomic.h>
>  #include <linux/hyperv.h>
>  #include <linux/interrupt.h>
> diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_tran=
sport.c
> index e2157e387217..f77f0ea1ddad 100644
> --- a/net/vmw_vsock/hyperv_transport.c
> +++ b/net/vmw_vsock/hyperv_transport.c
> @@ -13,7 +13,6 @@
>  #include <linux/hyperv.h>
>  #include <net/sock.h>
>  #include <net/af_vsock.h>
> -#include <asm/hyperv-tlfs.h>
>=20
>  /* Older (VMBUS version 'VERSION_WIN10' or before) Windows hosts have so=
me
>   * stricter requirements on the hv_sock ring buffer size of six 4K pages=
.
> --
> 2.34.1
>=20


