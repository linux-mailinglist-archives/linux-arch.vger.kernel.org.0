Return-Path: <linux-arch+bounces-7989-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2F5998FB5
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 20:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42D981C24683
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 18:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13DF1CCB49;
	Thu, 10 Oct 2024 18:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GheaFGd1"
X-Original-To: linux-arch@vger.kernel.org
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazolkn19011025.outbound.protection.outlook.com [52.103.7.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B451A303E;
	Thu, 10 Oct 2024 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584494; cv=fail; b=Rk0O8U23M5VTuzs0addn/uZ1PiLXRhumInt3bbIBsRy8LQS81D0XTr40hheNX8TdA9g8l7RszcQM+Hj6y9G3vk/KsA6lE8PWceicEWHfMfAbr2p4uLwF70bat6zRyZ6bXaIUg58oUfjODy9aUYH3SSPSK0awq23jWm2MTsOBqss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584494; c=relaxed/simple;
	bh=noX6FyuVjxq7V+/g8eZdzuLegOyxugCQBWsOf6lnq58=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Reg1mOssalOLsTbZZ+C4s/C2o6Urj4tlmK8aul8xDPYoH14Ql3q1CT3vNMKkuC1hrCbC0UB3k7TZ/PakHDfR7imWEXwQX0W+ZPGanJt2P9sU53m/JCVpNgiEBUFGi8I9ZaXHikCSDH7aEhpS9c65y23B0xKljgF0cupvL736eL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GheaFGd1; arc=fail smtp.client-ip=52.103.7.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ewwpaDX5izSyNhb3Xjnk3Gpa+qEuBYpGBj19VCHU8yMMA5IOrROx+smVvF3aGIt6wel4gktn2MIEktyZRPB1Kx/b2J1qcvDlcP5Njq1UZYU3VIEXXLZXROmH7bNmQQGC0o/8aTQMxoaXAQIJdkfbVwmkYoNshXrUc2VTTFUq2WVDUA8g+Dqwsn8Xhj04TMUBIVVNpBgyCq70Pe/SMiCkTPrzcTP/IT1E1j0ffhmAue6/VEu8j0MY6PvwXtAW7DpRyp0tl/4EFnTnNOltWnuiQg/+LxPiwOivBssxFVjuLPMNWvba2VbzOibi0Bm/LcDHhvmxbrXt1MLG+rZHS3r55Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sr+nc7AY++tXOGAc+Ufu5zfZRflk7UdYks6SnelkzjI=;
 b=uIwh0ZnSoxJ38zhUYnkEaD8LDfYPH0coRybktWW7IpHums6zjk7OoFozAmE5nItIU5nF3D3ho/mmWVEmAMoh0flgEQH9pc14hBrIZ2eoqgQMb6UkrTEt+0rpA4O8Gf+N212ncg+LmFH/WoACe5DuAfAR21Y+/NNDfyVr5tzuDAF+faVxnWX9J++6d+W643aYMPHChlPei7zCMvHkoOSwWOhup2wfdsliIksNdmiPr8uAsVlGV2RFFq0b+AkI9Fs3bKiHQa/Sl2ciHRfUrfxtS49GUBe3IbBJAktU3ITI4uZDcMogssAR/pirXHf3YYOFg41KaEsSsvqS37SKl7nRPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sr+nc7AY++tXOGAc+Ufu5zfZRflk7UdYks6SnelkzjI=;
 b=GheaFGd1FMEEEaxmS8SrZSr5H0DXlWrNmHNTxvo5FVfCJtRAfzofo+iqWrWjYXofXQpGJgnchcl+FIC4D6jkhRSxkoGOOYWuxP0Q2t2hCbYtUAvIWVFWqm4I4dHIeBgCQOec0+2KZe7gIpyi2zWujSeDOOnaPrih6m2sv/7xR4t8XeTlKb6wG7fuoxdIcHFu25rVhE5kD0mKQED/6xkk25+vKniwS8Peiy2owFQ/z5yT7UQuUoHvlQp/nnZqgV1v9BqwV1jlcLyXN2IbFHByxqTi+WBcfw7DMPY9EqwsKbKHCdBkwSNl3WVz6zFhNitd14p3ykOK3momczHE92L63g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV3PR02MB10761.namprd02.prod.outlook.com (2603:10b6:408:281::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 18:21:28 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8026.020; Thu, 10 Oct 2024
 18:21:28 +0000
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
Subject: RE: [PATCH 0/5] Add new headers for Hyper-V Dom0
Thread-Topic: [PATCH 0/5] Add new headers for Hyper-V Dom0
Thread-Index: AQHbFc3gheIHrTrmm0yVUene//yVY7J/bLBw
Date: Thu, 10 Oct 2024 18:21:28 +0000
Message-ID:
 <SN6PR02MB4157F6EA7B2454D2F6CBF2ECD4782@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1727985064-18362-1-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1727985064-18362-1-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV3PR02MB10761:EE_
x-ms-office365-filtering-correlation-id: 59106c8f-f636-437a-ec4f-08dce9585bbb
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|15080799006|7042599007|461199028|19110799003|8062599003|440099028|3412199025|4302099013|56899033|1602099012|10035399004|102099032;
x-microsoft-antispam-message-info:
 aRFcZDHgQd8oYVvQEKvi4jLqOhsq91Ji6wIag2/nomFmbey9Gmjgw6TdR2BN5evGWZRxp+2dJ/pOriTPd15qZymkUyIJwWwutAyLAFWOG0tTVv+t7IvIGxBot/O44a/66ioHUuHkgGTunPqj/mhUe1lFkeu1W1TxZ/V1y6MMEjPgqmGrkomdsinf4U3jZgjUSmEPFKzEVGzGbDqmzEtQK5NHfFd4WzVvrWKxqBXDZXGLOhj4nPX8BKaplA2k8OIMqb80P/LHU9/gZuQhiQ80KqdbeGRHgDbGXIhWmMM1J26bQLakTbRdu9Uu8XFN4zwJeABFgFSaX7OC4+AOJj4+ruGvmFBLMnMrfUuAhtWz7OzMNH9iRLcqvNxwGhNUh4yfK9i6tzu+BoklxtQiYCi8mJwIePGNUHV7cZRTKrZLeTIx/FwKqgSu304J0LFuD9wQOFfOzsTTZ5ZH24v6Kgk6pAHVYckAWGok6AraY1hannB6FVJeNUmgB3tmjjsd2xEie03Z2NImRTnnwNsd5E4BKqIcvnX+3XP+tCiRsOPU4ycLzXraEBFNXAJys+jaHpYrEHg72urM9PonQG4czD3HQvA2sx6rM9eRHxSjoZsfAAhijyBtRSq5XmQYPURKX0S9ytI6mFIEykokYYH+dC5N459Iiak5QWe6TU7mwk6ew573fBE317WyeAZlZQFu766UCghVPK9I0iZFhqcb2dcEQP28yAqtVluPIdsdQz+y4zAUoNsu4LSb/40tjQrwufQyV5jOOLsaZEwxjZxyKvG4FDMRWjDr+B7d51RdsHEHduoSsD+NQXdZQnPbYeMygxaO2/i3Sm0iDF28iIzlzJtU+dRkP+ZGH4Ni7XWH2DVpoD7hbm3s/euL8xMLQ85OukH5MX24lnDmnt3pCyDkSUWU/CuykxBdI/w8Ijgb7MZxnCk=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?y+dEHloI1Y/ghQhxbscCatnBnrWYrUe/ZZ8QAw7F7j3upE7Brmsrogs83ONk?=
 =?us-ascii?Q?NvXxUQmQNH15TzS6lM3/h80mkUjnFcoUyllUnxbAx8E4oZ/ry00xpLJhgaJD?=
 =?us-ascii?Q?4K1Nkng8BrPGxaAX3F2mc4MyBHXDIPjEGb9k7VSXec6s84SHFiPmmCF25PqZ?=
 =?us-ascii?Q?2ZMfM++zUAHLgDhJiY7R3UA3LzzJP2nwrVLZdBNF0QjTwLhQxafgeyMwFYPa?=
 =?us-ascii?Q?ns9SbPmOVGZE2YeM2pgfZ6KiUn7KFPYMmYlRtGGkTx8cAjFhQRZC7rYBnSrI?=
 =?us-ascii?Q?0spYgDkY6A7R1Grl08rNsgGp5AurDeo+2cz7Hhsj06jH92X5RRa5dtDTLhF3?=
 =?us-ascii?Q?gfxR2XucQ2yuA51EajvVshHc277nLRwfItVj7y9oPlOaS09arcveKMlNWqoi?=
 =?us-ascii?Q?8VpWJLo8iXUWv61uc6IB8yQ5Pz0tYwehmLoHmpjp/JeGhSsJQwvcxFfoNmKQ?=
 =?us-ascii?Q?vs4w7w4uRFnYmK5UephbiJeuZo+sdKYZH/2DnpXZFI/H0Ym9yKfLtff1FJlD?=
 =?us-ascii?Q?PrtLMytwbDsi0YXH7m7x0zjdZMsa6PUkXEOGMLHkYq4000BRLS2W18bSYxGh?=
 =?us-ascii?Q?zh2BdWiPA2lLvjBsdAuoqQHDDuzNNZVid1L/oM0zVZtN6lk8IPgcoQ2mfhLr?=
 =?us-ascii?Q?qxIfjYN8HtuF70lSvV0Lh2pXQyjRwygvqepZG4x2wP7epLVdrQYWzLkICJPk?=
 =?us-ascii?Q?ShImQIiVCpN9jkWBjtRyVnmNeG1ZWt0KnKjLYkKQSJpWpw5qg9+PQXb8whvV?=
 =?us-ascii?Q?bC1DaxbCd6zSgTWm4fEpRs0OYYYXU8O/tTuqpq7rvwqchw+nJNou1LOMlUGn?=
 =?us-ascii?Q?3m3ZhMudCvWw1T3oigwe6mY4i6aDv/UdWUihylM1Ag4wDS9FkUYEeACmE9gt?=
 =?us-ascii?Q?Tb+D4Wyk1vUlj6qQXb9qOkLNbUSw5g7tDXnQlxM6Z4vcM5/FJ9eVmC5cVtu5?=
 =?us-ascii?Q?RLH8/3nq3pudVLGa8D6kI3J7rJ0AtxdKugcodwCQD77FdzrRNNj5ospoE9OI?=
 =?us-ascii?Q?XWk6cgG8XVYMwsL4MgV8KfZbedsmpRzTsodha+MLXcNxjosup4KkJnnl+3iK?=
 =?us-ascii?Q?eqEztzt6cYphUKg5/zS2UJG5ihPDiMeDmeYlk09k+J2i3zx0tbj8nix8qOuD?=
 =?us-ascii?Q?ekzy4decC7O6uQZIoOyUuIQ45Hz/InYo23IXLpar6jq0CXjk2cUiO51EuJ99?=
 =?us-ascii?Q?9frmI7so7/LNWSKjuvlWdUANBINHvcS6kKtDYukJJcNYqJXknNO0KnKk05M?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 59106c8f-f636-437a-ec4f-08dce9585bbb
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 18:21:28.4712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10761

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, Oct=
ober 3, 2024 12:51 PM
>=20
> To support Hyper-V Dom0 (aka Linux as root partition), many new
> definitions are required.
>=20
> The plan going forward is to directly import headers from
> Hyper-V. This is a more maintainable way to import definitions
> rather than via the TLFS doc. This patch series introduces
> new headers (hvhdk.h, hvgdk.h, etc, see patch #3) directly
> derived from Hyper-V code.
>=20
> This patch series replaces hyperv-tlfs.h with hvhdk.h, but only
> in Microsoft-maintained Hyper-V code where they are needed. This
> leaves the existing hyperv-tlfs.h in use elsewhere - notably for
> Hyper-V enlightenments on KVM guests.

Could you elaborate on why the bifurcation is necessary? Is it an
interim step until the KVM code can use the new scheme as well?
Also, does "Hyper-V enlightenments on KVM guests" refer to
nested KVM running at L1 on an L0 Hyper-V, and supporting L2 guests?
Or is it the more general KVM support for mimicking Hyper-V for
the purposes of running Windows guests? From these patches, it
looks like your intention is for all KVM support for Hyper-V
functionality to continue to use the existing hyperv-tlfs.h file.

>=20
> An intermediary header "hv_defs.h" is introduced to conditionally
> include either hyperv-tlfs.h or hvhdk.h. This is required because
> several headers which today include hyperv-tlfs.h, are shared
> between Hyper-V and KVM code (e.g. mshyperv.h).

Have you considered user space code that uses
include/linux/hyperv.h? Which of the two schemes will it use? That code
needs to compile correctly on x86 and ARM64 after your changes.
User space code includes the separate DPDK project, and some of the
tools in the kernel tree under tools/hv. Anything that uses the
uio_hv_generic.c driver falls into this category.

I think there's also user space code that is built for vDSO that might pull
in the .h files you are modifying. There are in-progress patches dealing
with vDSO include files, such as [1]. My general comment on vDSO
is to be careful in making #include file changes that it uses, but I'm
not knowledgeable enough on how vDSO is built to give specific
guidance. :-(

Michael

[1] https://lore.kernel.org/lkml/20241010135146.181175-1-vincenzo.frascino@=
arm.com/

>=20
> Summary:
> Patch 1-2: Cleanup patches
> Patch 3: Add the new headers (hvhdk.h, etc..) in include/hyperv/
> Patch 4: Add hv_defs.h and use it in mshyperv.h, svm.h,
>          hyperv_timer.h
> Patch 5: Switch to the new headers, only in Hyper-V code
>=20
> Nuno Das Neves (5):
>   hyperv: Move hv_connection_id to hyperv-tlfs.h
>   hyperv: Remove unnecessary #includes
>   hyperv: Add new Hyper-V headers
>   hyperv: Add hv_defs.h to conditionally include hyperv-tlfs.h or
>     hvhdk.h
>   hyperv: Use hvhdk.h instead of hyperv-tlfs.h in Hyper-V code
>=20
>  arch/arm64/hyperv/hv_core.c              |    3 +-
>  arch/arm64/hyperv/mshyperv.c             |    1 +
>  arch/arm64/include/asm/mshyperv.h        |    2 +-
>  arch/x86/entry/vdso/vma.c                |    1 +
>  arch/x86/hyperv/hv_apic.c                |    2 +-
>  arch/x86/hyperv/hv_init.c                |    3 +-
>  arch/x86/hyperv/hv_proc.c                |    4 +-
>  arch/x86/hyperv/hv_spinlock.c            |    1 +
>  arch/x86/hyperv/hv_vtl.c                 |    1 +
>  arch/x86/hyperv/irqdomain.c              |    1 +
>  arch/x86/hyperv/ivm.c                    |    2 +-
>  arch/x86/hyperv/mmu.c                    |    2 +-
>  arch/x86/hyperv/nested.c                 |    2 +-
>  arch/x86/include/asm/kvm_host.h          |    1 -
>  arch/x86/include/asm/mshyperv.h          |    3 +-
>  arch/x86/include/asm/svm.h               |    2 +-
>  arch/x86/include/asm/vdso/gettimeofday.h |    1 +
>  arch/x86/kernel/cpu/mshyperv.c           |    2 +-
>  arch/x86/kernel/cpu/mtrr/generic.c       |    1 +
>  arch/x86/kvm/vmx/vmx_onhyperv.h          |    1 -
>  arch/x86/mm/pat/set_memory.c             |    2 -
>  drivers/clocksource/hyperv_timer.c       |    2 +-
>  drivers/hv/channel.c                     |    1 +
>  drivers/hv/channel_mgmt.c                |    1 +
>  drivers/hv/connection.c                  |    1 +
>  drivers/hv/hv.c                          |    1 +
>  drivers/hv/hv_balloon.c                  |    5 +-
>  drivers/hv/hv_common.c                   |    2 +-
>  drivers/hv/hv_kvp.c                      |    1 -
>  drivers/hv/hv_snapshot.c                 |    1 -
>  drivers/hv/hv_util.c                     |    1 +
>  drivers/hv/hyperv_vmbus.h                |    1 -
>  drivers/hv/ring_buffer.c                 |    1 +
>  drivers/hv/vmbus_drv.c                   |    1 +
>  drivers/iommu/hyperv-iommu.c             |    1 +
>  drivers/net/hyperv/netvsc.c              |    1 +
>  drivers/pci/controller/pci-hyperv.c      |    1 +
>  include/asm-generic/hyperv-tlfs.h        |    9 +
>  include/asm-generic/mshyperv.h           |    2 +-
>  include/clocksource/hyperv_timer.h       |    2 +-
>  include/hyperv/hv_defs.h                 |   29 +
>  include/hyperv/hvgdk.h                   |   66 ++
>  include/hyperv/hvgdk_ext.h               |   46 +
>  include/hyperv/hvgdk_mini.h              | 1212 ++++++++++++++++++++++
>  include/hyperv/hvhdk.h                   |  733 +++++++++++++
>  include/hyperv/hvhdk_mini.h              |  310 ++++++
>  include/linux/hyperv.h                   |   12 +-
>  net/vmw_vsock/hyperv_transport.c         |    1 -
>  48 files changed, 2442 insertions(+), 40 deletions(-)
>  create mode 100644 include/hyperv/hv_defs.h
>  create mode 100644 include/hyperv/hvgdk.h
>  create mode 100644 include/hyperv/hvgdk_ext.h
>  create mode 100644 include/hyperv/hvgdk_mini.h
>  create mode 100644 include/hyperv/hvhdk.h
>  create mode 100644 include/hyperv/hvhdk_mini.h
>=20
> --
> 2.34.1
>=20


