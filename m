Return-Path: <linux-arch+bounces-10569-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF172A56F74
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 18:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE0DF164A7F
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 17:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D819C23F296;
	Fri,  7 Mar 2025 17:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="UOOFFYBG"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2044.outbound.protection.outlook.com [40.92.22.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB2E21ADD1;
	Fri,  7 Mar 2025 17:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369496; cv=fail; b=uRslT4tJSWdRQ51rq1Zb59Fs3X0RD/ABfASnM3cu6zGKegLm3MdMtzSU0YadBTEtAmu5Ad0N9mcg9Iz1m+FthVH+XOjD2gCnjBH6jA6AXu9BfKM9DNoNOCGegTxsYWOVS21a9oCe4pCbDL7xdy0elX2AgTCMiSiOxIxGyG/J+iY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369496; c=relaxed/simple;
	bh=YjdBO6n1h84M5Z4f9a9kE+NtOolu8wQQ2N4pV+0+GsA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cwjMcwoagJPjiyPVD1GGJGDZkadidphgE11bg3QLBQlETLWLLjlvc54/GrDmg/FANe5hxL0VUn+HHzbFXg0b6LTuEiuYxVrPVGGrZI3LuOJropeqnMWkvddtxAH0soS2XOtdyHmz0xz60KHdZxj0m18JGrQ2JOaNO+rzUIkf8rE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=UOOFFYBG; arc=fail smtp.client-ip=40.92.22.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTLApNqDNCW/n9lhmNMaqeTR5LcRQw0DarZQmlt8As2Q1AL2WT7ouYzPGyMQiMPyD2SVOmnRm0vMsd05IkqRcrHjODdw19dw7oaQNSSTpGQ16FdGhHXCCw0WpoHCMLIR7JeAwbPfE3G7liCicn7Rl2Ixq6i1pGvS+lOA1pSEsaFmW785Bk3/UK2f+N7XzqSfvDJCbivPhhr5O+NHS6c0GedgY5cBvLX4L7SFYR4+7MVUFWvh9DLVSi0M/3Oc3aqwCMau8sGgOw9+OnvbkNnpK47hTXZCUiW/0I4UydJbhYmlzbMUGWSbKn+iO/u6+an/9DWSt8g/1kxwTrGOPJWWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxaRTV+2u2c565c4AuFhOsryXHN0KWdm59m1dKiohYc=;
 b=oLyIaat2uZBieIzqYkINJsq1KiadhSRK/daqYf/k0QmLl8/iJPRFDKHFresw5eVUEDrbqSIwa/oEmpDX4sc0DP83lAFUzhGqTydymTy6VBt8OPzl1ZdEvud1TIgSIa6bLGCP64pikjK9zssX/G2gh29tB5qrl8ek1uW/0OebnL0PzNELYLBkhHQ0SQ1KcSsj1kvnTk4VBpdIqcG0wbCiF4kMf6H3OFp12kfqcXi8mGk0VjTqreEIMVcXP5jExWrfs+b/jnKrhH5J16/nLuWTuU1YCMc95ILaeqPl+JJIkJqb6hrf0LcKFq6iIf3VRqJimbco+ddM71GBqET+FgLz7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxaRTV+2u2c565c4AuFhOsryXHN0KWdm59m1dKiohYc=;
 b=UOOFFYBG7kjnZIKSPYSAFhKY24YYN12OGyaQHhqVURH1rVixOroSOCfnibZ0Z5y5XY98usbJiLoU1lHwr2Di2B4u6Qajmr4Q1U3IipOaj5UUcRphRkhAd5l1F00ySPsr3q5tfzggXPeVimVVNI0I3hyim91QAaTZkHg/HjiBAY88d9RTKTgmEnsf7feUOsn/EGfX6rXjzrKvS3rS7Fhc9aNrb+jjzP8bzOMyvX4quOnn7imLr8KIFkfTxmIwwPJ35WsHXc0PNgaS1vyOdApTRh99hgFPY/S7MBFW/5N4X7KmJuj9IxQZUClKi1us3sk2/Dmuc15DAyDTXZ2mVwbfVQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BL3PR02MB7970.namprd02.prod.outlook.com (2603:10b6:208:355::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 17:44:50 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 17:44:50 +0000
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
Subject: RE: [PATCH v5 08/10] x86: hyperv: Add mshv_handler irq handler and
 setup function
Thread-Topic: [PATCH v5 08/10] x86: hyperv: Add mshv_handler irq handler and
 setup function
Thread-Index: AQHbiKNt6Dmf5ml0nkycDSKgcIRUw7Nn/hsg
Date: Fri, 7 Mar 2025 17:44:50 +0000
Message-ID:
 <SN6PR02MB415730AA9A9BFFBB9A62F195D4D52@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-9-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1740611284-27506-9-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BL3PR02MB7970:EE_
x-ms-office365-filtering-correlation-id: 600fd99e-7ad6-4356-19f3-08dd5d9fc2c1
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|15080799006|8060799006|8062599003|461199028|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kz6jOW7e5OUAOq6DABWsud/pzw+EsIOnIucx25Vx9LkGFcKcR45NXL8pAnXO?=
 =?us-ascii?Q?nGFJg/bNJp9CTTJBbWig4/I9u6Ups1kX0ihB8Gnr13SWOKna2In/XVYhOryk?=
 =?us-ascii?Q?NPtsRL2iYaQZjrqHVPc05Eh/WRYnJtZa9TXbONN0qW+2glL+O2UJT3hSnPB0?=
 =?us-ascii?Q?o4J1+cwTUidPHZz8ENkepJt4d5N7HZE98CKUjA9dAwbZmut2NYeB7zO+csmE?=
 =?us-ascii?Q?bZ6ScIseVte2wo8WdEkafqssAjSpkMwgsXqF5uI5uBr6agQbehbeCfNUNrdv?=
 =?us-ascii?Q?11Ab5WfR9QwnspqqDGApdrCiBuyfY1GCHLkDD+a7XSFpJLLiBEOmPrIYkebL?=
 =?us-ascii?Q?A6iRypknumQ5HUL/oD2GoXNJr+B43WAcfIxuEvYi1oBfV0cFkhGHbYDrFb21?=
 =?us-ascii?Q?iQmAppGA9jnGQVg5JVtxXbzCI7aijvyInvnjXlgCFbnC5q0gZvWUfXz2QKrV?=
 =?us-ascii?Q?D2C+47O6IIBNJHtxySzB9bSHed+44zH+jJEZWKLxRatuI+THInwhL/Pp9RKd?=
 =?us-ascii?Q?hoeJDmVoQExTDVKhGAIkm4H5ksZFOphLOfoNZzanWNolaVn7seWvJ/8MCcO0?=
 =?us-ascii?Q?GR/Em530BdxyaELa57bbXJXAj8f4TArZYBXGRU8dNVD5hW45i8Pay7OpGTlU?=
 =?us-ascii?Q?1pfz/kSPUbk8FpQCzKj2tgYT2SKvNt0fJiCd2WXiWnYXdfvVb57xAbqe5sCN?=
 =?us-ascii?Q?gug6pBgf+FaETHftKsKmw7yomNTNqt2AtUKbJdU3QgpyFp2L27kN8+KhYriq?=
 =?us-ascii?Q?Qdd9NRiuvqLVvtVda6zcg/0ZjooIy6a6AINpiielgLFfoJercGnNyWr5MFEB?=
 =?us-ascii?Q?1fjdy2FCnGw792E+saYDOYrHmiq8lxojllHUcSrBubc0f1ljWZK8fNA9BYjU?=
 =?us-ascii?Q?yvF6gz9Qo8n29kgpWzXHTT4y4OMZ6OVfae0aXgb/kWAUeSbJXSls+lEKb9Rj?=
 =?us-ascii?Q?WtQMtFLnuNCJJDufhskUP7x8Mx+6WJw2bR5WZmZdQbx8tQStkzbI01sGMTud?=
 =?us-ascii?Q?TMz7Na0MhAzgewdtOTFy+L+pSMKePTwCAOtqPICUSOQq0As=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DcV42RIjh4FDcwHEL89pKM0xrqrVrmzRNXrmdgTZtzQu83CgFItojQjgfT97?=
 =?us-ascii?Q?DR6cgr0CkusWgOjsMPramFUI9cL+IMRKrZGn8lbEkJXXJEZ1z8wTMF2nTOM/?=
 =?us-ascii?Q?tBeaiphNt4nZ1l/eeVtTKnKKxBqYltYCldeWlZHABDrA4NZ+KW0ggQ0aRBLe?=
 =?us-ascii?Q?NkGLNlNFc6lQz7Ai5ba5/OKH8KwejECVd/XxQAWdnsXg2Rh87KKsYXe8N5rq?=
 =?us-ascii?Q?n/0UrQjB4YTioNoolgrNG07Z35uz62iT036qAa024W75HwbMuIi25ZE0sQUP?=
 =?us-ascii?Q?3llBKNh3VEF7CCFjVH/0rg3C0eArsOv/bbJKueXaAzViC+J+WZjwql5WcMs5?=
 =?us-ascii?Q?8x1erBExR+HaLNTvWzVTGTwyUPTRB6v6N5Mvnw3EWJ3QYmXC6re7HNvPTfGx?=
 =?us-ascii?Q?RQPnNJzXLx6sI/Y+jw/H9zRjymhwOvBzOHPje9UtMbLBDMGu5glk0DGQ/64x?=
 =?us-ascii?Q?SndS1SqMHi0hmqwzB5zqOwiaMM2hMOj/IfJ7voMWlSD1Bw2G+MtgecpNqH7o?=
 =?us-ascii?Q?rsUebBn8sXlGeV92LcTHerKmasoCHBFF+L2XUP9L/4Re+LIie3iVizLmv4QB?=
 =?us-ascii?Q?9vUh8wa+7mCYAmJyz7xDsLdBtjfufYay8SK9u411WBuov4ioqOtPaGu75+oj?=
 =?us-ascii?Q?r73h9vmPV2Em4mTKlIONGk1BEHfpWviMPcEe3DDmJu3lp2Mtrb6j1irGtuw3?=
 =?us-ascii?Q?9uFk/uVfI7HQbZcpqdTjJr0LyfBVxbBgVvOXZMOg/ruRCgM625tY4gsXXotw?=
 =?us-ascii?Q?EN4crVqhRMk9xw7N8cZuIJJEo2JQVa2uqF/MpIoYXdCAcq5KNK72M5y5Sq29?=
 =?us-ascii?Q?2FhaCe308ga3O4R9BRovgPYVokUhG3o6T4kLhTqasvKNKiE0Vx/EUsIf/w93?=
 =?us-ascii?Q?DwpWZ91cDnUUm88Fu9WGmCVb7j6NqGJJ8/myI2mDWbu4gqo8SMathJZwmuBd?=
 =?us-ascii?Q?nzP2TATD2OoaqEiK9Js/Y5XTzmekFM5g3A245JTDKzAzmVNek4aw1nSTARZH?=
 =?us-ascii?Q?uF78qtxMeVeb4sbZJq85TgMOhTV1Smp4uEBpXaNKV8Hyd9GUqNZqtj4QPLy/?=
 =?us-ascii?Q?eKBlVZUfQHiq4l1gcMEuOBzd6LUSlahtOcRyIz2GmWZaqii++DbLGFYyL2dj?=
 =?us-ascii?Q?XoSDSPSRvaE7qFcOdVV8mwJ774xKEHDPv0Z5a7lAIHZ3p1Zph3gKdz2pY02+?=
 =?us-ascii?Q?rDssaWcJeO5bkjMZYkN5z9pdYFQneTd+LWwMEXvKz+Z68j6LaI/AA3FNTp4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 600fd99e-7ad6-4356-19f3-08dd5d9fc2c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 17:44:50.4952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB7970

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, Fe=
bruary 26, 2025 3:08 PM

>=20
> This will handle SYNIC interrupts such as intercepts, doorbells, and
> scheduling messages intended for the mshv driver.

Could you provide a bit more detailed commit message? How does
the mshv_handler() relate to the vmbus_handler()? From the code
mshv_handler() goes first, and I'm assuming it processes what it
knows about (intercepts, doorbells, scheduling messages?) and
then hands off control to the vmbus_handler() to handle the usual
VMbus-related message and channel interrupts. But it would be
nice to have the commit message or code comments describe the
overall intent and any obscure aspects of the relationship.

And avoid references to "This" or "This patch". :-)

>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Wei Liu <wei.liu@kernel.org>
> Reviewed-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 9 +++++++++
>  drivers/hv/hv_common.c         | 5 +++++
>  include/asm-generic/mshyperv.h | 1 +
>  3 files changed, 15 insertions(+)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 0116d0e96ef9..616e9a5d77b4 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -107,6 +107,7 @@ void hv_set_msr(unsigned int reg, u64 value)
>  }
>  EXPORT_SYMBOL_GPL(hv_set_msr);
>=20
> +static void (*mshv_handler)(void);
>  static void (*vmbus_handler)(void);
>  static void (*hv_stimer0_handler)(void);
>  static void (*hv_kexec_handler)(void);
> @@ -117,6 +118,9 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
>  	struct pt_regs *old_regs =3D set_irq_regs(regs);
>=20
>  	inc_irq_stat(irq_hv_callback_count);
> +	if (mshv_handler)
> +		mshv_handler();
> +
>  	if (vmbus_handler)
>  		vmbus_handler();
>=20
> @@ -126,6 +130,11 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
>  	set_irq_regs(old_regs);
>  }
>=20
> +void hv_setup_mshv_handler(void (*handler)(void))
> +{
> +	mshv_handler =3D handler;
> +}
> +
>  void hv_setup_vmbus_handler(void (*handler)(void))
>  {
>  	vmbus_handler =3D handler;
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 2763cb6d3678..f5a07fd9a03b 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -677,6 +677,11 @@ void __weak hv_remove_vmbus_handler(void)
>  }
>  EXPORT_SYMBOL_GPL(hv_remove_vmbus_handler);
>=20
> +void __weak hv_setup_mshv_handler(void (*handler)(void))
> +{
> +}
> +EXPORT_SYMBOL_GPL(hv_setup_mshv_handler);
> +
>  void __weak hv_setup_kexec_handler(void (*handler)(void))
>  {
>  }
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index 1f46d19a16aa..a05f12e63ccd 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -208,6 +208,7 @@ void hv_setup_kexec_handler(void (*handler)(void));
>  void hv_remove_kexec_handler(void);
>  void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs));
>  void hv_remove_crash_handler(void);
> +void hv_setup_mshv_handler(void (*handler)(void));
>=20
>  extern int vmbus_interrupt;
>  extern int vmbus_irq;
> --
> 2.34.1


