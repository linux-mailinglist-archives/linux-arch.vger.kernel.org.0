Return-Path: <linux-arch+bounces-4420-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AB18C6776
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 15:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B3D281381
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 13:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8A5128832;
	Wed, 15 May 2024 13:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Jc0lvBID"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2053.outbound.protection.outlook.com [40.92.18.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A48126F33;
	Wed, 15 May 2024 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715780235; cv=fail; b=V6xxg18qdArwo18XOLmE3qlIioOjYxdJ6qB8YgmUrnQqXflWW4GpqxG9+uX5D7P04HEDboRNkoulgJTLZEfT1F0Tgxof/mh1ZSxev2AwbZtrfFIcIgknhraK54FgFvvXH55PGOR8+qDZikFKJRDQmCwKLwmIQPotRrBojKpQDvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715780235; c=relaxed/simple;
	bh=8nPlcV+S8VapaW9R6mva0XG+2MNwby2NNKWMs/VdSCQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HHtVGPNSEFTOblFPA1rTeoBYKPHQN+QCYBgB97q8GI59lIcVKp6mWxYGGH7QpkWYa2BrlVQ639nVe9Qxs44SIW2q1ztzBz2d5D0AhJOlsNIPYuE14vEnAwo9hrWVwwrg0NkMVddvyIL8q5H81Kvksg9bx26aZjf3aIuuEXRxaus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Jc0lvBID; arc=fail smtp.client-ip=40.92.18.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUNMr8ypM+kdtwVVfmJ6JQ7LP5/165KbKCwxNG/uLVOX4ErEzlvCZfl1twFRWA/8HGO87iwgUdloFSY+SmLXF/3kTlKmZTIZt9v1FeltY8xLCmnyfWFtoI3tsQLHRRxtYOm22Ky5Ue86hUANg9Dcq8dOwOaT5vvkJLGsPYbXeuydFq8ttGzv2S9XYz5cI5XGjNjZosPs7tdzeYJwFEQCZvALcz3dbsU6cZY/KInWRdTdqXFpapQOVl5SInGAPCON1mf6rYKRT5+PynYE6Nx3sLPuX8cqvlZCGLUge3qX009PNKOTLa8mEg8dL3HZjowWFYLWMAKGuyIDAZd+hp7dww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FoZ9wBa513cWCa5oiM3fRxdZZmwp6dPQe+xQVb4F41A=;
 b=XuCYS9r0OedteniVIZdsA4KG4zT6T4olCTWPGTuouC+0saAsViICjU6ZKSdQfSm81EJAUkdx6PqfkdD9nahjZwy8/TLC/IN4luPh5jFdIwC4ZUKodeKMsJOiRe1f60ZlvYmZz4OiH7tk4w4cGCNo3TSh7DAaO3RA3eoSM/T7Z/DdkXYce1N/hxJKOqAidS0yYF65hS6P1czA5lCh4mgmH42JOJhrMaPBAA+mFxkSm0dF6uWSymxiofsEojMCjBWhJMLEqG2CYIHIyD467Xsq6Zoghj21afr2AE9chJrpdX7D1FFJ3ewOoasHve2l3eUuHCCBfR/U8lTU9EJco3qulA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoZ9wBa513cWCa5oiM3fRxdZZmwp6dPQe+xQVb4F41A=;
 b=Jc0lvBIDbKCsyxeoNOHa2GNkHxFyUcEzzEnWPQsQQpYJA3fVE+w3H25bVg5f8Sz7UTY6Vc87fo02AeDkUbatCKVsy7FAUx+bDn3dRazcwVoDc6tjoHAJUkVFpLQ6x8t+iqRQQBYqD1lljE6Ka8gjVZjZoup7PlhQJV/whXEhbDNbaseHtdykTOvn9zdxS/hEq6NvyWawcWpnBN8jPNuu2+mauxGrw+s1TTxgu2xDbazlJ0NToyc/5AVKHQRQjmgKjhi0SJsKs6ZD9diaoulgsHMmWl8P027s2dScS2LZj2rChq4tMbk39mfZm9x7Zq2Ihos70nmqrUDNsMWfwpQNdA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB9491.namprd02.prod.outlook.com (2603:10b6:610:127::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Wed, 15 May
 2024 13:37:07 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 13:37:07 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>, "kw@linux.com"
	<kw@linux.com>, "kys@microsoft.com" <kys@microsoft.com>, "lenb@kernel.org"
	<lenb@kernel.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "will@kernel.org" <will@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "ssengar@microsoft.com" <ssengar@microsoft.com>, "sunilmut@microsoft.com"
	<sunilmut@microsoft.com>, "vdso@hexbites.dev" <vdso@hexbites.dev>
Subject: RE: [PATCH v2 2/6] drivers/hv: Enable VTL mode for arm64
Thread-Topic: [PATCH v2 2/6] drivers/hv: Enable VTL mode for arm64
Thread-Index: AQHaplCGevGI4HwmaE+AFdHRKNc30LGXiWwA
Date: Wed, 15 May 2024 13:37:06 +0000
Message-ID:
 <SN6PR02MB4157E15EFE263BBA3D8DFC51D4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240514224508.212318-1-romank@linux.microsoft.com>
 <20240514224508.212318-3-romank@linux.microsoft.com>
In-Reply-To: <20240514224508.212318-3-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [X7ZMbwVUB06tvBjKlza0W4RdJr+V6Q8d]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB9491:EE_
x-ms-office365-filtering-correlation-id: 2bd80f70-9858-4a99-548b-08dc74e41d28
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199019|102099023|440099019|3412199016;
x-microsoft-antispam-message-info:
 PgnWv6KUJpPCNxqTPA4BhmXNUMQS8uwx8h/LKcKpSxj1AbCs4gEU8I0JMFk0PKvvRfl9oOoKvLxEE9wjAZIUUWC2zrfPm+9ZxeBDXgwsMS5ERcaLSKxqzftTridjYof85tNpX/zpXvK855xYq1l7mDOK9ghpKEMbxkXuI/ohx8UYS7fzDsOK7tIdKPv5bwtkwayiKMgTCMwRdWqw+8Qs/AWGq70h3tojtalspVqekpoFuwvJhJJxF4bwISahUJIt8LCvHGCUEj1x4uxszBUeT93H0hNDPLGXJP1RBKFVd24G9ZyJTcKsggrFS46GITQTTM4OtF9Blt9pnjP8D/eUxIq1kdC+o/u3e9SeVlUKquOI5OGA2SrAiIGcCVfE8YwtShImyZgtcaPUbivWPcXWZw4oKE+OJHEoNgpustsXNjzPeJ3F4wvgs7/NwAuHAvDgt0GhF3Cac1MtEOSzxnAOH16brt6iUlz+UEFqmxvCKLrq5b1iA+IksMlg7B1R04MCvQWJohmPPUQ5yF1PWpk20lqVFlau+g57K3+yHzHh8C4muTQTVsx60GQj9sXPqCFY
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bTJl3bhDyt7Em3DZCHcY4lKv5wZO1eIiYQD2lgw85grlwesydApTfgLhdCNe?=
 =?us-ascii?Q?w8bSNZDa11wUqJIUrRW6SDBmGAMRteH8dWJ2u6Fp+yHkB5djSgHXWHLAUdWN?=
 =?us-ascii?Q?FTHIf5YBfOiXnjxY2mWRqaP7bBMqmgsaoBXGLDHh4GnJPtZ/Y+4flCjHIU1/?=
 =?us-ascii?Q?6vipyT899Rk09jsAhh/5f60IslqkG4WV7fInFMfj2eU5fjLrznsm9L9I8UWg?=
 =?us-ascii?Q?jh/Hasp6JKKyGIU6laJYhOb5PQG9B4u2wXyG5fCj0F/ca0WjN3lUzQLwdb5d?=
 =?us-ascii?Q?VbXX8I1c/CKeBkGFKtuNSNYiX7x+i7BRkbXLyGpL1X+2CKEydVtRib6CtGtZ?=
 =?us-ascii?Q?PHQvFhrrfAXeWV6MhoJpWX+dbSimrPa/wyz6rgd2M15AaueAyV7MXVzk7cJw?=
 =?us-ascii?Q?vqezPLPZauOAYdUHpmO/Wm6qXEkZxUO4sh/g46NL/fDMY7EiyQM65rP0b7SJ?=
 =?us-ascii?Q?Bq0m4jjE6IlFB9Dk64X25rLNPSCiyXaDBLYTxGHX1kAGXRrfSEgHbAN9sLpp?=
 =?us-ascii?Q?/vdtyH0jLBPkCS3My7mwzaQK6cwBxR7MC4rIpZN669o5402sd1Zt5x7yHEks?=
 =?us-ascii?Q?Gd+MC0zqtIe6154MuTvZ+cX3kTBHswjlgrHahM6cCFVZPF3/zIJ6NTeJ577A?=
 =?us-ascii?Q?XArq37uL9p8BNdkJuLZzf4OmI/AZbMWcQkm5WynlHDvqxi9oL/S2vOTG9HoR?=
 =?us-ascii?Q?NQV+0+vN21TKrKJsRYkOFIdgr8V4NGwggjdgNmdJ0c/avdCxylWKs19RJCq8?=
 =?us-ascii?Q?VTwj6NmRVPh8kspSspATivCNkBW4pa/NSPSoRwOkfGAGHrH29hkBurf2ojNy?=
 =?us-ascii?Q?P7Xyfb9Lh3Y8SCwSsTF6AD/euCjuG7+YPdIpnsCiWaP2idfkxbCgPluRaPmL?=
 =?us-ascii?Q?s/0EubP0I19ZSLFVFRMERz+kvT41r1/MEcQRiE3BrrSatt6jJ0b05CE99TUu?=
 =?us-ascii?Q?vQfhyUkGxwFuhB/dvjsW//otBo567io6Vf3Tq7eNaRx57ltoy9auixPSweQI?=
 =?us-ascii?Q?aymrsT8JMT/nBpUM5TJG1fw1H+7s7lJfXq/RKIwXtFXA6dsu+ZvjsjXCDMJi?=
 =?us-ascii?Q?Oew4DWAyt52soZXaI3qpoKpfO9jGE+NPWFDHdZcwjv334mmHM0/f0KIocUcl?=
 =?us-ascii?Q?UiMAkJSfO32HizGhvdM07QVks6/cj0Eg2Qfu5UQ7bP49tn4d2zcQou3BKBi2?=
 =?us-ascii?Q?nc0bHuq8d6TQY2QscI9Lx/0zBcc3F8mMVInRPeA24VBtcoNj0TJ50DGSDjE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd80f70-9858-4a99-548b-08dc74e41d28
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 13:37:06.9820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9491

From: Roman Kisel <romank@linux.microsoft.com> Sent: Tuesday, May 14, 2024 =
3:44 PM
>=20
> Kconfig dependencies for arm64 guests on Hyper-V require that be ACPI ena=
bled,
> and limit VTL mode to x86/x64. To enable VTL mode on arm64 as well, updat=
e the
> dependencies. Since VTL mode requires DeviceTree instead of ACPI, don't r=
equire
> arm64 guests on Hyper-V to have ACPI.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/hv/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 862c47b191af..a5cd1365e248 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -5,7 +5,7 @@ menu "Microsoft Hyper-V guest support"
>  config HYPERV
>  	tristate "Microsoft Hyper-V client drivers"
>  	depends on (X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
> -		|| (ACPI && ARM64 && !CPU_BIG_ENDIAN)
> +		|| (ARM64 && !CPU_BIG_ENDIAN)
>  	select PARAVIRT
>  	select X86_HV_CALLBACK_VECTOR if X86
>  	select OF_EARLY_FLATTREE if OF
> @@ -15,7 +15,7 @@ config HYPERV
>=20
>  config HYPERV_VTL_MODE
>  	bool "Enable Linux to boot in VTL context"
> -	depends on X86_64 && HYPERV
> +	depends on HYPERV
>  	depends on SMP
>  	default n
>  	help

These changes make it possible to build a normal VTL 0 Hyper-V
guest (i.e., CONFIG_HYPERV_VTL_MODE=3Dn) if CONFIG_ACPI is
not set, which won't work.  While we can say "don't do that", it
would be better if the Kconfig dependencies expressed that
requirement.

A possible fix is to remove the "depends on HYPERV" from
HYPERV_VTL_MODE.  Then for HYPERV, make
the "depends on ACPI" be conditional on !HYPERV_VTL_MODE
(for both ARM64 and X86).

I think we originally had "depends on HYPERV" in
HYPERV_VTL_MODE because there was a VTL-related function
in a non-Hyper-V code path, and we wanted to prevent that code
from running in non-Hyper-V environments.  But in practice, that
turned out not to work well because occasionally people would
do an "all config" build where both CONFIG_HYPERV and
CONFIG_HYPERV_VTL_MODE were set, and it would panic during
boot in their non-Hyper-V environment.  Such people were not
happy. :-(  So Saurabh made a relatively simple change (see commit
14058f72cf13e) that got the VTL code out of that non-Hyper-V code
path.  With that change, it shouldn't matter if someone sets
CONFIG_HYPERV_VTL_MODE=3Dy in a build where
CONFIG_HYPERV=3Dn.

At least that's my theory. :-)  Someone would need to check
it carefully.

Michael

