Return-Path: <linux-arch+bounces-10651-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EF7A5A577
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 22:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 761F47A6744
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 21:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90EC1DF991;
	Mon, 10 Mar 2025 21:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Cwjc3gM1"
X-Original-To: linux-arch@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19011028.outbound.protection.outlook.com [52.103.14.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4161D7994;
	Mon, 10 Mar 2025 21:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640510; cv=fail; b=WoFrqqiO07XawWdKLCtPh+fFd74X5BDNI5/fK+nMV/UYBUb+joygab1leL2G/Z7dnixOgiJCoISszRHYFV+OBSZEl/hMc8rKRkeE92CekKoVEUROruwqwvSP68gS2CrVUTrE6ABaAs5AbBKzdeRfIWNfdfLFyeNof3peUkqMOIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640510; c=relaxed/simple;
	bh=mei0vUIwLqNS17scsXNxr3lVn+loG8C3FOJBGpaUfUg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KQd+DkUw+0R0N9GXc2Uc75NWqVRjselF7PU/iSG3kJ0lJ62LhO2yX2w7lXkrP3QWkVl6cxpKA7larqo499rQq+rQ8+4CVMeN5PXlipdonNQmQwrJNn83/YmMrP9OK7IPLwLy2C9nZ3XfAkdHkw6z0ZMYn/sfUl44oOsvXq2WOlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Cwjc3gM1; arc=fail smtp.client-ip=52.103.14.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2NJblJ6VhllOJRfUK7eNUNnM0HBR0Lh28tWFCdXiJLsz/EYxh7WNAPvzSidCjQxzOcH6x9CfnviVDE0bpF9tkyOYz8OwySW+iPzyYyu8OdiI6BoIVI+EspkkTgAwdRX4NXu2eSVQIy9RAkmURL81/6FywD0JGEV3WV6OuZQ5JP0aKBdupdSy2KidoeHqWXGWdmRWT81Px/OXp+jCG2jKMDY2je3X4K+Arm+vvVuM+7O3lrnDhOz/+jjj19/AyugoYAAt5Xdy97Lol73rzchE17viJ14d2cYKyiiHse8A0EYym1W6VQN2FrxgeESuA9COZ8bo1kmHRj/GxqH8UAclw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOjhH8PjIg6kBmhPNKgfXY6zMMp03rtAP8TfoVS+cVs=;
 b=cjNWSRaba48DEn16j6I5OA3Hh4njtOpLwDQAkn73A4Sm1ayp2OQJXOnoXGOGHNDUILM4tJXAehaxGx0fgxjjKIuXGW4mRYv2Qm3LbfuSbDWX3+4rinHKtu8eSfe3zNCSAcFgIapmPFDX3Ko9k1XpzLAUKvOFx6xNj6lYjjuokCHoZDeJeJ0JDdMnynoWvvX5adbA5C8MyZRjcbPQYNnDNfTHUP2ZqmMZSvKmvf6R9eEOdvW+OVx0i3cLR3z5TI38OSlrWskJSggNDvu/2C9okZTq6t5KaEi5FhgZluElyntqmwm5IlXet2X0c/qcRP/8Ge2JKJ/fgz+pXKwCuJCfsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOjhH8PjIg6kBmhPNKgfXY6zMMp03rtAP8TfoVS+cVs=;
 b=Cwjc3gM17lM86t2aVRP7EUTUSJs2RSIh+GPscR6P4e3s1WlO93k3fDd2SzD0HhFr/kp0FJwKOcmDX8Z9CBMPpN6kFJmfXeoe0ySAac93qPol3TUDkuo2g2xg8zxpjfYtE2GgvIArP7pwtD7Gs4EXYt3xGcqd/8wXnsuSoeIqc1SGm9XUbdObyqOslhqkZyrXzHIrujzDnX/6T0CZG1HxCXI/GkT/OPmDwSsvSFgy6s2OWz7mAMwPv12WqnAPamD7oQgrsjxnSXA2gXK4E28ktiRUCsMv0gCCeiivqGEhWEHfGCIdPIXAGo/D0BfDSXfIQRuAiPIqb9IpsPW0JNZoIQ==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by MW4PR02MB7236.namprd02.prod.outlook.com (2603:10b6:303:72::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 21:01:42 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911%4]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 21:01:42 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Arnd Bergmann <arnd@arndb.de>, Roman Kisel <romank@linux.microsoft.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley
	<conor+dt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Dexuan Cui
	<decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Joey Gouly <joey.gouly@arm.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>, Len Brown <lenb@kernel.org>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Marc
 Zyngier <maz@kernel.org>, Ingo Molnar <mingo@redhat.com>, Oliver Upton
	<oliver.upton@linux.dev>, "Rafael J . Wysocki" <rafael@kernel.org>, Rob
 Herring <robh@kernel.org>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, Sudeep Holla <sudeep.holla@arm.com>, Suzuki K
 Poulose <suzuki.poulose@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Wei
 Liu <wei.liu@kernel.org>, Will Deacon <will@kernel.org>, Zenghui Yu
	<yuzenghui@huawei.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v5 03/11] Drivers: hv: Enable VTL mode for
 arm64
Thread-Topic: [PATCH hyperv-next v5 03/11] Drivers: hv: Enable VTL mode for
 arm64
Thread-Index: AQHbj6zpmH+gYA9h/kGlfIiTOb0OO7NpvEQAgAMg+bA=
Date: Mon, 10 Mar 2025 21:01:42 +0000
Message-ID:
 <BN7PR02MB41488C06B7E42830C700318DD4D62@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20250307220304.247725-1-romank@linux.microsoft.com>
 <20250307220304.247725-4-romank@linux.microsoft.com>
 <e0f81049-688e-4f53-a002-5d246281bf8d@app.fastmail.com>
In-Reply-To: <e0f81049-688e-4f53-a002-5d246281bf8d@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|MW4PR02MB7236:EE_
x-ms-office365-filtering-correlation-id: 29c79212-4e59-45b8-25c2-08dd6016c272
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|8062599003|461199028|8060799006|19110799003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?NywOq99eMtEU7k3N6u2iDjRd7vDScWD46d4fuozC+5GIL26oYrXAJzstWL?=
 =?iso-8859-2?Q?YWj2Z9th8BW1fTKa+tHmoc32pkN7qLCa8oZNWvXij4LTAk1aXHdVTOeT8C?=
 =?iso-8859-2?Q?bu41zvfrg3wPLjnRbkFKM5U8tqKhOY1E7O45b+sZ84YPwD9Ig42b457H/d?=
 =?iso-8859-2?Q?7P0F6Q3FEB39MnUXtMraxLiI3d1bQyCHtQz4pIxAkLz3T+mm9izi4xFt5y?=
 =?iso-8859-2?Q?jb07H9nhnVwgVYBy/nk1a7Wk2ZMPDOOCMdJ0USn0zHSkrqPV1nCSynsYNZ?=
 =?iso-8859-2?Q?uFgPDoCKq8iQpYPohv9JMSRmlFuYKzRIMyIFHpKh1FgQCZ6gKn2JYZUlMM?=
 =?iso-8859-2?Q?K1nGsnz+X0PCAO7yY4HxTT7F4D48+D6vRgRJO1umTAQ+WQY/xxcvDPUtSi?=
 =?iso-8859-2?Q?sjtVC2AlC2/3J3lxievZR9wkESW3GgYOp9dIeCuSQpqY2MwrWnFiOMxSc+?=
 =?iso-8859-2?Q?wsV2sWvM2xeidNKIQqraeR4dDjn8BKixgQtTSK8/nnfUTjpQLTHoc14Of2?=
 =?iso-8859-2?Q?5V0jcMarGQx2ekZgC/0pmkRyF/6PxzdfRXd/ec1e8tMQAhEAamrHC58XIk?=
 =?iso-8859-2?Q?AOpnm7KsHOudwJmuy5Chab4iCIf4YJGL1nTSnBTop31KfupaQaKG6pZoPa?=
 =?iso-8859-2?Q?f9jDCXpnJeE5XPlvXvJhnFtK685VM3Oc8d5BFuZH2pHodnwnY5Dd+M/0xd?=
 =?iso-8859-2?Q?qmKBzEdq2KAdm968ohk5u9Y5Ouvo/82j/zFamaT5qI7d+thNOlaiFJ5pqq?=
 =?iso-8859-2?Q?6tHIdYEY1LVQE+lSWEHQX3PPLcypOWjOJb4Ka/NfA8gz8ihaUaeZiOve/M?=
 =?iso-8859-2?Q?raOP+nkjwZc22AxojIW2cQVBBYSpoedeVGvBG9QXynlilqLcJ7ZYEtFOTU?=
 =?iso-8859-2?Q?dQ/oW0uXU80JBXv2Aigwaw4GKCjj6rUnhjgW2/u/OES5ykM5hUCP+Cc5SO?=
 =?iso-8859-2?Q?jYP7iCQTg6MGtRtnvN1ifIGeArbmueLYoU2mqkkcisMku3we8paCcN9qYa?=
 =?iso-8859-2?Q?hk9cyYpS3PqU2xLEfvI7T3t9Cx7KHBzDY98/NMPoWCTl4DqRNioI3lXq/+?=
 =?iso-8859-2?Q?GechPnnvKtyhv55iVrydPaI=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?G8tr5+G/2Go7/9P5OYb56G0qk8/zYDuhS0WD0rywdFsPyNh+TClDgER4ex?=
 =?iso-8859-2?Q?8JS8ESRAezs3V7xPaL7WqjiZ72X78BF8as5zhpSzg0VCejpnD5HC6u8/YB?=
 =?iso-8859-2?Q?0vfGV8Os1szcmPyvz1QDIQZ/WNeJMwaO1MOuumZsrO4vyD9ovUt98EMIWN?=
 =?iso-8859-2?Q?+rexg1NvrT47iBPIQWEhm6CyAoDMaklHzikXzC2IhrCNVG5EOreAG/tTpo?=
 =?iso-8859-2?Q?w9mBRwSbipnj8HBnzAhw6wD1izpcOuMvGNWqQxh12IRUM/Za8w7qfaj5eE?=
 =?iso-8859-2?Q?1ZEtipOjr2gSCXXRRECp6gKmCIx8ACfFv9L2BSlPaiowNZziRbU2OUQwLt?=
 =?iso-8859-2?Q?T2mYq/XT4/TqRYkGHFEcUw2rQpRLud+NDSsKD1sePIusDBZO3ZOrZNAb2h?=
 =?iso-8859-2?Q?wLBgCm2X/tdBRoyi9BZPYsgF9WDNfMW/1tAY/uHw+3sbS1dQ2J7ve0I+M4?=
 =?iso-8859-2?Q?dwvpB9QCzVMpjCxxa24ml4SiTSQO3Ntb1NZNhp3raSUPqVZbkLzDb/pHAp?=
 =?iso-8859-2?Q?BX9bCBtHu85MEmtKX16Vmeb+ikIJcDHwGh4QxpGIW/0c3YQDGJ8FnGewCk?=
 =?iso-8859-2?Q?/nAPkKHT9aiuWyDp//hobnVRdSJaQbIb0O8KAh1CdV1RU4pmFNFtAbB2gC?=
 =?iso-8859-2?Q?+XPGGazNYLaD9XPxN1aIdpbfBoV5xaofLvRsmWQy8tFswTJ53Trn031JTv?=
 =?iso-8859-2?Q?Va6lrRHWusYjKGCIAU1Pxvzanm+NgLhN+rR9a7tHMHKo2XerRiEiK9Y27y?=
 =?iso-8859-2?Q?UkJM2nkycKoDt9v6DBujJuYOu8oiqNzVE2/1G/lCDB62UF/+/R8OWTfxeA?=
 =?iso-8859-2?Q?vx9CUNpAS/CRXa+rcksu+74N6pNFRoeEhV7Hx1kbonezvXxrvCFz07l2ty?=
 =?iso-8859-2?Q?uVKW2FytV+tx8yWg/E78w4CWNb+b66gPaNMy8enx6D0YR6r601fyolvOq/?=
 =?iso-8859-2?Q?esqBQIuCTD6bVe23qD95GqSLTrIiShO9h1E0Jh+dSe8tttInhdb4a/vo6w?=
 =?iso-8859-2?Q?eKqMys5grrhMpO46B9shhfUoKbtluE0HnoJ91dXoAroEraa6IACx1RKl5/?=
 =?iso-8859-2?Q?O88M32Tx97aJxTLpDKyweIjO4RnGukuJ1sMDZJxPekdqjsKgd7hOSYC9vd?=
 =?iso-8859-2?Q?agW2mk8IJc7YBsJjVhIVONzFR7f4EOhtUdo2JH+O/ahhshVW7mT61TI5Yo?=
 =?iso-8859-2?Q?ra3nmMUEZQ9t7H9RqyZ2tbBaHfwRkOWaQMmheDz11shMKosA34g4fyrQ1s?=
 =?iso-8859-2?Q?Gxe6spLpWjbNy7xPd3EHCs/iLxcAFfxqW9taBzh/8=3D?=
Content-Type: text/plain; charset="iso-8859-2"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c79212-4e59-45b8-25c2-08dd6016c272
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 21:01:42.3802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7236

From: Arnd Bergmann <arnd@arndb.de> Sent: Saturday, March 8, 2025 1:05 PM
>=20
> On Fri, Mar 7, 2025, at 23:02, Roman Kisel wrote:
> > @@ -5,18 +5,20 @@ menu "Microsoft Hyper-V guest support"
> >  config HYPERV
> >  	tristate "Microsoft Hyper-V client drivers"
> >  	depends on (X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
> > -		|| (ACPI && ARM64 && !CPU_BIG_ENDIAN)
> > +		|| (ARM64 && !CPU_BIG_ENDIAN)
> > +	depends on (ACPI || HYPERV_VTL_MODE)
> >  	select PARAVIRT
> >  	select X86_HV_CALLBACK_VECTOR if X86
> > -	select OF_EARLY_FLATTREE if OF
> >  	help
> >  	  Select this option to run Linux as a Hyper-V client operating
> >  	  system.
> >
> >  config HYPERV_VTL_MODE
> >  	bool "Enable Linux to boot in VTL context"
> > -	depends on X86_64 && HYPERV
> > +	depends on (X86_64 || ARM64)
> >  	depends on SMP
> > +	select OF_EARLY_FLATTREE
> > +	select OF
> >  	default n
> >  	help
>=20
> Having the dependency below the top-level Kconfig entry feels a little
> counterintuitive. You could flip that back as it was before by doing
>=20
>       select HYPERV_VTL_MODE if !ACPI
>       depends on ACPI || SMP
>=20
> in the HYPERV option, leaving the dependency on HYPERV in
> HYPERV_VTL_MODE.

I would argue that we don't ever want to implicitly select
HYPERV_VTL_MODE because of some other config setting or
lack thereof.  VTL mode is enough of a special case that it should
only be explicitly selected. If someone omits ACPI, then HYPERV
should not be selectable unless HYPERV_VTL_MODE is explicitly
selected.

The last line of the comment for HYPERV_VTL_MODE says
"A kernel built with this option must run at VTL2, and will not run
as a normal guest."  In other words, don't choose this unless you
100% know that VTL2 is what you want.

Michael

>=20
> Is OF_EARLY_FLATTREE actually needed on x86?
>=20
>       Arnd

