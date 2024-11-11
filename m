Return-Path: <linux-arch+bounces-8964-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6E39C374F
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 05:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76201B21548
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 04:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A893714AD2B;
	Mon, 11 Nov 2024 04:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Nucc2/qX"
X-Original-To: linux-arch@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010004.outbound.protection.outlook.com [52.103.13.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408F432C8E;
	Mon, 11 Nov 2024 04:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731298384; cv=fail; b=Kh9qHdNT13vdRPQPFD7T+VkzQhyMJHJ9PNCQ9Ngtij49CNiASHpgLrmA6HmBgCGAceN9ihsvRULsv4oAyAHrJiTyUXU6NCf7n/YGaEJVac7mma80YSf8vC/tptUCOStIh31sFo6Lrc0Cd/2h6J0UHa29PO8gW6Tt3LayPoNfpNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731298384; c=relaxed/simple;
	bh=JuqL43/qKe0VaaSb9TzBx9BJWSFA0q7iS1ocUrcmNAo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bnOtsY+wAhh3e8Dsw1b0SeetFqkDlM03nQqF7lKAnCB37fFPpAp2OkpUQzqNHtHOoHhriieZU0ADJTF2ZqVwDtxloBDSLeFSDFCVjdt+e4aYl5ftoL45bIL7OB61K1UG2Agh1nIk+ZVQntPiZPJGGqN3Sqbo0eqgzKAt5AkPCro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Nucc2/qX; arc=fail smtp.client-ip=52.103.13.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jn0YBVCzXre1XWw99AmXDT7ouwMfPWuovwXPK6mNKJ8RzL5RXcSoY/XWu8m54/bAefhiwUaV43DuSlj9rg8q+DSWHthWxDf+vugz296o3mZ0bWCNjijafwT/U8ts068dtwMQzg+YMinLxq5LImYzft4ZEV+65osjX9XwlKyg1Nwxf48mo1KLOqdH6iAErBgAV9VNV6kSuToNTxyPBA077590I46FHb2lJ5iitxqU5JmrmH52REA+SZx/2uKRHsH8mZfdQHWFc2P+CQQbonKVjMBaUHa11SrVAlqFgEtuXDNQBFaoe5RoyMG/vCjEm3p0OsRQWjKG68hsdAIWbWN5Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cn1OFLs8aKAcwxJqP4RzepmFb1rBTfCV3GS5MviBTG8=;
 b=GpXA8NOiC/utmjg2DIyoUnl82etCKKr5KMoQ/XzPSrBv756F0MfG5bbR5XVB/E2/4oH/2zWkG0d7SnCU8vk5lTwPhMs3r/j+gY8JNijIwOpUjiyx0N+DsxN9OWG7PYxr9lKVrB481VFvpdd5olnSGe6UQ+V/AtjiemsWBfzvj5UfU/4UokJk8TY92fpesN9HVEJzW+vNeLIgszmpBbhiQwJntfuA3XYONBz6yrKLr+FqK67X4T+BODbiH4BUey80c/FpYs3Mdc4ZOQdhgLrFvau8nWTIshhlaiawAZx99C2aaCOgQ/DW4OxMVjj7Lc1oOpTckoUuPw9FYWxDYExRkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cn1OFLs8aKAcwxJqP4RzepmFb1rBTfCV3GS5MviBTG8=;
 b=Nucc2/qXC0+mAptNAD7mXdEV8YPDRZRN4Ny4skqbaL+yfQl+wPr0eRdiwiv4Bvpn9Ith4LozLIP+u0zvVTgKeud1SxbK3DUZceqGvPaQ2NpuvaPGy6IxiOjqp41gKVoA3C4/vcN3j+D9WvxgGvrRZwf1B3KNLadlkkPXj/v/tsGWfAcV7+hFgzdqVLsq7FWQ+Nse7qgj/I5y7obeKGpMxzOE8u48tFp04k2K5vVE4hcvYOHTSTNLmCHq/K6YVWDW35yuyLwa3fAqgFSa8ONiSt9IR5oIZuF+S/3Wwz4xzmsgFRZhHru3YrRHylS3eTzVg5B1SL0Tndo4rLo8alwbhw==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by DM4PR02MB8958.namprd02.prod.outlook.com (2603:10b6:8:bf::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.20; Mon, 11 Nov 2024 04:12:59 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911%5]) with mapi id 15.20.8137.022; Mon, 11 Nov 2024
 04:12:59 +0000
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
Subject: RE: [PATCH v2 0/4] Add new headers for Hyper-V Dom0
Thread-Topic: [PATCH v2 0/4] Add new headers for Hyper-V Dom0
Thread-Index: AQHbMWTyoKCBm8ky3ECkxBZdOyPiHbKvoZXA
Date: Mon, 11 Nov 2024 04:12:59 +0000
Message-ID:
 <BN7PR02MB41485DAD2E066D417FE12020D4582@BN7PR02MB4148.namprd02.prod.outlook.com>
References:
 <1731018746-25914-1-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1731018746-25914-1-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|DM4PR02MB8958:EE_
x-ms-office365-filtering-correlation-id: 8d49f5a1-435b-42f4-36b8-08dd020720d6
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|19110799003|461199028|8062599003|15080799006|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?R6sI6fsq0spx8yzJ6siXFXSWC1R2KBgWQJDHzWbKBbMbntI46a2GrSgXYtog?=
 =?us-ascii?Q?7PysAl86lZogiSYnUJDzs3CNipD0SoiYhBNBRHzY/ChGSX0TxzRMnxxFERJL?=
 =?us-ascii?Q?X9D/YovaOIuBTGHfqfA05dbbNYVXvuFN9UCdS5jcGor7It7TMNm6e3TWmzkG?=
 =?us-ascii?Q?M/GL6XEOfEDfsKHTqtEUguhrqu0d8mnTrX4LKax8++eb95zP2Wq4GQ33fn5p?=
 =?us-ascii?Q?i4UrCWgEAKunz0QgiY8HQRy2tMK/mzXFQsYfZ8kSaE6MUmevemtAAokt7hsy?=
 =?us-ascii?Q?UTuzp/60U0kZ6umcSUslz6giR1+jRz+JyvUoLeVTXrMJzzA3lKrSjR/e31EK?=
 =?us-ascii?Q?gAWtFnzL/xHQAr0zGc1Coktfr4S7JLJkDVHAcVwiQovzlE3joYhgbD4tyAIK?=
 =?us-ascii?Q?gUsrbFMFeN2sCOsALtjIOyQHgu6bdHNLYDpYm5Mtpxpav2pk12dMeGU5MeiV?=
 =?us-ascii?Q?YppVEqgTQoTGM/8K1IoBD/F6xnQorypZ+z/Ga/I95nnrFWW0NKHgJk/sP8J6?=
 =?us-ascii?Q?tCbtwnDpY/46i9zjdhhO6xPA1V/J2qy0XnT5OUH30RO0dzb8X8t4O4OgL1Uv?=
 =?us-ascii?Q?Kar+AhvrURYfLQD+ImF/lKMVtf4AIvVrgfSvUBqPVqkosoj4Pijl7jYd/Lpi?=
 =?us-ascii?Q?50ghjaihbE8dTWMSaOK5z32LNx6TfGt8aJvfliG3n7N5bQR2eDfS29NJ5sE5?=
 =?us-ascii?Q?IIoqi5JXv2R1bXeX29JT/lkVa4C3kH1K67ifYYWXvbT/T2K5bppSUlP1i4KL?=
 =?us-ascii?Q?lnTCexvIUSUR0Ru+V+rOj7u10dmd1Wp57UA0kGlu/susjXLC2NtpIodT+Wvc?=
 =?us-ascii?Q?vxZ2/LhElO4s4lmtS3iWDODcpZGZ35zktwx9rNXIA2RK8DvH1SsDzeinALA7?=
 =?us-ascii?Q?2JTWZUZ73c0GRN/sz/sbd9wVf3gqKA1dcaO6iIAduLjiqFJA4ZIHFbjpl7yQ?=
 =?us-ascii?Q?PaSC5QSDry0LFTJY1m0pjBXJdOORcYrq3yVPr25LegrcX3lnfpRR9dxqD8dT?=
 =?us-ascii?Q?DYgqPjIRYrQF2oBuObsAqwCS6A=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8YvsAJGp7aAhOS1LqofTNP0fCbhd+ZHKmmvxsAPzLgNuJ94JPpnbRMRfHvC3?=
 =?us-ascii?Q?TXM4cN2c3k/eX3M5DBwME0NYvQbY8+/0JG04iYVZV7r/Ex0vGJtD3bQIw3Wk?=
 =?us-ascii?Q?W52JK1un3m6u1WOQqx2aPWyGpmhROYlqQmTJRYlRX83v8zCqopaNgdWFHlm6?=
 =?us-ascii?Q?q42w+gv/O79oYdozqj7X7FUSarMHJGH3gIOkir1A1Lmb6AYaepQFSMkBncaW?=
 =?us-ascii?Q?eRdi4Qe2KpGOIn5m30asuZTWhUBXz4wAiNA4VuxBft81WNmh5GnwWGeMdR5U?=
 =?us-ascii?Q?nIj7tTdSkjDdurj89Xkw+rTMCHAHruXv/tD/i1R29qFhYoSsOORO+MHo4LdI?=
 =?us-ascii?Q?Cf1nGEl03SjHTHKni4W4DatqqiIKa9Vc4UF0e413EEiq6xW1deZM3ca7GFQR?=
 =?us-ascii?Q?zysFsfUaGMXzzaFroZBQFxbt6IwrvEPDkRkO6iTbKlmlF3/Qf/9VA9Xf6aYl?=
 =?us-ascii?Q?F6KDZUVXXsnz6eyXa6muwG81hkPh3Bojx2anbnRRY47736YdbYx4Ac7cl30k?=
 =?us-ascii?Q?yHP79EnvWJo+2x6mLAeUx6AV4xxIMwjQ74ezBNLX2NwtrSccRRg13pNiTCmR?=
 =?us-ascii?Q?ZNcgx9URu9x7GkJFesDfIvsmlTX4zZ0vD+b9rYqN83mZcHomhuf1g7b+jHwI?=
 =?us-ascii?Q?IlXzY6PyMJjQd0Wm7mDnejSUQpUWWKpLhA7Gt2+8WtrEuetFEi6TRGQCi08Z?=
 =?us-ascii?Q?mY/E1vlMR/6UtB3clJuDtZAvufqgg9hgS+ClI9auKsqPuSSuu9gB/0wn4/Bc?=
 =?us-ascii?Q?XarDo0EXv2cVpy2U+9BmqprJjOcHqGnIkMkIAArSqqjbe8syqMzRxVMeALRj?=
 =?us-ascii?Q?QISpBGcjvsCISL827o1mqZuTY2TuMiOM9ScaiVhLlHDas2g/jRb0k6w+Pems?=
 =?us-ascii?Q?VjLGegRB4dKc7aW38Yvp2VOrcVelkv0/fUyEhAWX2W+Qv9PYgpyXg7Wf6+sQ?=
 =?us-ascii?Q?JjWxZMvJQKEfnRIQWJsTnIvgXzHZh223pb2VBXKM6wDDW7q1y8dD7hd1FLjT?=
 =?us-ascii?Q?JH4tU1iGJqtiMCg6uolbTzwXNNFHdT4vSF7uZ0jzw8dXLDNAvAV/cpYN7QY/?=
 =?us-ascii?Q?Mw/RtO9nnzor4P9gHa1f2pixx0RHDPH8t0A5WtRw8Xx82xcbrtJKky7pJM/M?=
 =?us-ascii?Q?yHgW6qe2ylVIVqG1rxgEmYkA4um9rtKK12IZ+TqLHAZYRzmTk2zBI6L1MvoW?=
 =?us-ascii?Q?CwIF+FNqt7JPw5D+XdrFi7Q94mbiZUnYvMZUsIRwgBLt9IpeAsJGd61uPlE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d49f5a1-435b-42f4-36b8-08dd020720d6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 04:12:59.5005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB8958

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, Nov=
ember 7, 2024 2:32 PM
>=20
> To support Hyper-V Dom0 (aka Linux as root partition), many new
> definitions are required.

Using "dom0" terminology here and in the Subject: line is likely to
be confusing to folks who aren't intimately involved in Hyper-V work.
Previous Linux kernel commit messages and code for running in the
Hyper-V root partition use "root partition" terminology, and I couldn't
find "dom0" having been used before. "root partition" would be more
consistent, and it also matches the public documentation for Hyper-V.
"dom0" is Xen specific terminology, and having it show up in Hyper-V
patches would be confusing for the casual reader. I know "dom0" has
been used internally at Microsoft as shorthand for "Hyper-V root
partition", but it's probably best to completely avoid such shorthand
in public Linux kernel patches and code.

Just my $.02 ....

>=20
> The plan going forward is to directly import definitions from
> Hyper-V code without waiting for them to land in the TLFS document.
> This is a quicker and more maintainable way to import definitions,
> and is a step toward the eventual goal of exporting headers directly
> from Hyper-V for use in Linux.
>=20
> This patch series introduces new headers (hvhdk.h, hvgdk.h, etc,
> see patch #3) derived directly from Hyper-V code. hyperv-tlfs.h is
> replaced with hvhdk.h (which includes the other new headers)
> everywhere.
>=20
> No functional change is expected.
>=20
> Summary:
> Patch 1-2: Minor cleanup patches
> Patch 3: Add the new headers (hvhdk.h, etc..) in include/hyperv/
> Patch 4: Switch to the new headers
>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
> Changelog:
> v2:
> - Rework the series to simply use the new headers everywhere
>   instead of fiddling around to keep hyperv-tlfs.h used in some
>   places, suggested by Michael Kelley and Easwar Hariharan

Thanks! That should be simpler all around.

Michael

> - Fix compilation errors with some configs by adding missing
>   definitions and changing some names, thanks to Simon Horman for
>   catching those
> - Add additional definitions to the new headers to support them now
>   replacing hyperv-tlfs.h everywhere
> - Add additional context in the commit messages for patches #3 and #4
> - In patch #2, don't remove indirect includes. Only remove includes
>   which truly aren't used, suggested by Michael Kelley
>=20
> ---
> Nuno Das Neves (4):
>   hyperv: Move hv_connection_id to hyperv-tlfs.h
>   hyperv: Clean up unnecessary #includes
>   hyperv: Add new Hyper-V headers in include/hyperv
>   hyperv: Switch from hyperv-tlfs.h to hyperv/hvhdk.h
>=20
>  arch/arm64/hyperv/hv_core.c        |    3 +-
>  arch/arm64/hyperv/mshyperv.c       |    4 +-
>  arch/arm64/include/asm/mshyperv.h  |    2 +-
>  arch/x86/hyperv/hv_apic.c          |    1 -
>  arch/x86/hyperv/hv_init.c          |   21 +-
>  arch/x86/hyperv/hv_proc.c          |    3 +-
>  arch/x86/hyperv/ivm.c              |    1 -
>  arch/x86/hyperv/mmu.c              |    1 -
>  arch/x86/hyperv/nested.c           |    2 +-
>  arch/x86/include/asm/kvm_host.h    |    3 +-
>  arch/x86/include/asm/mshyperv.h    |    3 +-
>  arch/x86/include/asm/svm.h         |    2 +-
>  arch/x86/kernel/cpu/mshyperv.c     |    2 +-
>  arch/x86/kvm/vmx/hyperv_evmcs.h    |    2 +-
>  arch/x86/kvm/vmx/vmx_onhyperv.h    |    2 +-
>  arch/x86/mm/pat/set_memory.c       |    2 -
>  drivers/clocksource/hyperv_timer.c |    2 +-
>  drivers/hv/hv_balloon.c            |    4 +-
>  drivers/hv/hv_common.c             |    2 +-
>  drivers/hv/hv_kvp.c                |    2 +-
>  drivers/hv/hv_snapshot.c           |    2 +-
>  drivers/hv/hyperv_vmbus.h          |    2 +-
>  include/asm-generic/hyperv-tlfs.h  |    9 +
>  include/asm-generic/mshyperv.h     |    2 +-
>  include/clocksource/hyperv_timer.h |    2 +-
>  include/hyperv/hvgdk.h             |  303 +++++++
>  include/hyperv/hvgdk_ext.h         |   46 +
>  include/hyperv/hvgdk_mini.h        | 1295 ++++++++++++++++++++++++++++
>  include/hyperv/hvhdk.h             |  733 ++++++++++++++++
>  include/hyperv/hvhdk_mini.h        |  310 +++++++
>  include/linux/hyperv.h             |   11 +-
>  net/vmw_vsock/hyperv_transport.c   |    2 +-
>  32 files changed, 2729 insertions(+), 52 deletions(-)
>  create mode 100644 include/hyperv/hvgdk.h
>  create mode 100644 include/hyperv/hvgdk_ext.h
>  create mode 100644 include/hyperv/hvgdk_mini.h
>  create mode 100644 include/hyperv/hvhdk.h
>  create mode 100644 include/hyperv/hvhdk_mini.h
>=20
> --
> 2.34.1


