Return-Path: <linux-arch+bounces-10659-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6343BA5A6F4
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 23:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B29487A1F01
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 22:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4A51E8323;
	Mon, 10 Mar 2025 22:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hsQ57vAi"
X-Original-To: linux-arch@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010007.outbound.protection.outlook.com [52.103.13.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B08A1E51F6;
	Mon, 10 Mar 2025 22:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741645107; cv=fail; b=eKAq750eD/vJdUwGxhFbQ2xU2KGqPdyO2AG3eyVaIu468ncQ+KrBY+eJiDhvSaVQNu/sOnCbp1K5beeGaTqGy6e1x1eDfR50yiUuBBU1+iv/hTLju/hTlJdvtDc70Ky3MMXTNmWoU/XjK29LJXoL5TCgTIjqZ9bbgU3AOfAeFmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741645107; c=relaxed/simple;
	bh=9eGqY5/Z664Kf3KxRPY9+JHj29spOpfkdVABajqn47Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uTDjjqoa6Yqydoaf8ARDSBbsPVwX11siS9QvrC5PDrsUmkCJnOHVD+oIJrU0uIFE/NNysPXRJ34O/fiPWc3Ks5+CvMB3DEdCUNhA3+8rFe9dE8u7MFnFGZiSTeafGIrBDtLFmjiEUz8xLc/6xIAxstUN6gF0yL++cMy/ufEkFQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hsQ57vAi; arc=fail smtp.client-ip=52.103.13.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjVf0cE5mMb105e+SqRA0Mu09UPLnmPwHmBx5LJ/KF+OL28OAiohJZNTIAD7M5ykZ1Gyc4BuMk+tdTT7x5AXgGwsCgtv3sHXR59OJfiJvQiqmXQep490ox4GNz5ZQiuonXNM/DDodRl76F+rK6Jv4uVNUE1wjjBA99FuyxolEYT4cHDOTJgvhVIseseGZva+DFDRk4w7dqOZXSpKsr4nTo8XD48UjP1HKCtJdaqp+i/4aQAhgii8nqRrXzMUVtefFgt851mgWJj3J34ilFssWtJIBVquuf7dGJVFA6qncZMUnw0w5z/dd06gd+/Rk9P4G143zjzL7jeE1FZ2Jf4UBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQB4EgUL9Tfr/pQZMuSyyXj6MaBdtJZJb/qBrYALqkw=;
 b=ArnpzOkOPeLHYBun3iui2+LPCAVA7e7D5RRkDIGc5a5Lr3y5vGaicoXxMVaSJYYuyou609zQuGeSU5ytMFCQoSEHfw7j2lK/ln32lSPGJAznpurxc02F0BrAHd+FZmdPxH8jVeXYRhDDW8NtrVN7jeQTL3fZrso+XSRZ+UmXzM35qO0SA1MGQxEGiuVuaZms7nrxxInIG+Q1NTZ4lSdbhtb/OFlQ4NB19UaNvygoTN8lFpu2JDlYSwuHrWnbDUv8jAeA6xxfXrNzJeBxIT1NPa8TeHKZyGRZc3CcFqbOMxIgzvSr1ZAQAH3eqPD8eCEpF/NVeWA9o1I9K61/yasrJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQB4EgUL9Tfr/pQZMuSyyXj6MaBdtJZJb/qBrYALqkw=;
 b=hsQ57vAiRqkoznXqjBKOA8YVFuT2AQUoFXLNHWuldMBPonuZTW5Mvh2WeBfRKr2Vrbth+wz3hi+ac/28AZy/nR1ZSdBnPcZoCIOqtZUrasjwWw0I8SywlFwgwU3+XKzAqir/BcdDB7cBcn6UeolGFZLGA/XlVw6iZCAB+MLIFMZStwsZBcqZ/8jcUtHcfHXYsbGbZKa5WoYmOABKQHrV/filxvFUB85b2TTWqdhe9OM1tH2OhbQ4rvsAreaqGXzjNuMxrmSPEML0oHEp0pBwudjV2mX9MdUhpI8kRipM45es2SSk4Sj/zE10K/vkaC/Tfuc1OgA+IgNzMZqhuEpegg==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by PH7PR02MB8929.namprd02.prod.outlook.com (2603:10b6:510:1fb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 22:18:20 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911%4]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 22:18:20 +0000
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
Thread-Index: AQHbj6zpmH+gYA9h/kGlfIiTOb0OO7NpvEQAgAMg+bCAAAf2gIAAB/GQ
Date: Mon, 10 Mar 2025 22:18:20 +0000
Message-ID:
 <BN7PR02MB4148FC15ADF0E49327262B92D4D62@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20250307220304.247725-1-romank@linux.microsoft.com>
 <20250307220304.247725-4-romank@linux.microsoft.com>
 <e0f81049-688e-4f53-a002-5d246281bf8d@app.fastmail.com>
 <BN7PR02MB41488C06B7E42830C700318DD4D62@BN7PR02MB4148.namprd02.prod.outlook.com>
 <119cfb59-d68b-4718-b7cb-90cba67827e8@app.fastmail.com>
In-Reply-To: <119cfb59-d68b-4718-b7cb-90cba67827e8@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|PH7PR02MB8929:EE_
x-ms-office365-filtering-correlation-id: b77af9fd-4164-4f0d-810f-08dd602176ee
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|461199028|8062599003|8060799006|19110799003|10035399004|440099028|102099032|3412199025|56899033;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?yQQILi6VrGtjaEFxoQlcm5yFV+3l9N/wrgIbOe8R4J+2fc/iwPSfrjuzGz?=
 =?iso-8859-2?Q?e7v3zYaMkdlRBGbepzGtbWon7m1DcNAo01yfxiKPGBWF2b9dLs6gZgIsMa?=
 =?iso-8859-2?Q?XzipWcGORnugvegdJq7uGDEfYKyXw2cDkcITiFmf0Rbdq58mIvGVjCrbvN?=
 =?iso-8859-2?Q?3Qer4rVipGfvXiAywuaVC6tIaeiRNeJqBjo8sECMgizLTRrrtLrT8ZsJp1?=
 =?iso-8859-2?Q?g6nFbNsFFNrWDN2MYashzQLhk0RciSbjv7kKOOWsvMd2/R7HoCxQsKR0Q8?=
 =?iso-8859-2?Q?7WCmybNOb9N6PCR0fNpkXiZgKD7PcakVXvDuXPRBlfIDPayc8TJfBFaOH/?=
 =?iso-8859-2?Q?UNISnO3Sn40YuiKRZ+eI19zcmElsuJT5Lyt0EotqbEP5tNWUjDtNZZHcEQ?=
 =?iso-8859-2?Q?1/6mt+LXXZgoEtQDhW7T01iTnYCdUoSDBe6SQQAYIbjYf7+cjz92pqhu56?=
 =?iso-8859-2?Q?M62LHAznkNy8a7Y8iYKlPTFsl/lV4JZu5iEf78W689iwJX88zareyruvlA?=
 =?iso-8859-2?Q?ho0rgHHhgwUR8COcMyws7tOfaclp33bMx7H8kdSU7QUwJxcP2BiJgWq4/X?=
 =?iso-8859-2?Q?fH1FLa/Im3NDNsT0GCy69R/+PgekBtVKkWMdiBZmKXn8gaePwbvZ87lX9n?=
 =?iso-8859-2?Q?4M97UxE3UiPSRdukF7GeX7jNTQkVwsFlG7173KIwLqBwhzKBMU3YhvhweE?=
 =?iso-8859-2?Q?ExqfW49Cl/GxUecwhI22ccILwqjk8nqRZjP090vtHJJwI5z/BKnYr/vSIl?=
 =?iso-8859-2?Q?IiUATMCPh3nWr1ofnEDqouvsgkYOh3xZ4l/g6BrgoMefnaeRchpg3yJqP6?=
 =?iso-8859-2?Q?HAQRztXck4ovk3SN3yYa763LUaYYsJ7tsbOHs2khong6UAq9gO0T6TxGdz?=
 =?iso-8859-2?Q?DVVWUPBHO3qRcUJt+GavY+owX8g4WZw2o3uwhz9jBDM3MZqJrEr7hj7pvZ?=
 =?iso-8859-2?Q?BVb0TRcduZDul5Pr+oZvxIgCGQO1YGsYMoTG4rTRmyVqohczchkxbb5cwq?=
 =?iso-8859-2?Q?nZlj52g7heOIlpPQ1WceTqTBSWe6t52EoCCzmE+xQdn2ydcfbXmFgYJ8Vh?=
 =?iso-8859-2?Q?2f6xnIVYv5Vud2u49+jsTuxQT2uLeURazh5fJuulOUSQwZzSSVmJX5k0OK?=
 =?iso-8859-2?Q?8SNIV7e5mPcCp1uddOXDNU8wr6RRM=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?DCstKJ9DzABdmuSpaUca+ctZ0ZsQukkvlQiWmEwxr/1atttSFFWytQ3ZAz?=
 =?iso-8859-2?Q?+tslEj6O+lNDvR2caPzKhia03smqL2+vk9Nr8PCKZA5ruZQnO2x3ICMJva?=
 =?iso-8859-2?Q?uffVOlPvNoEKFUQJ+y7jfgwdE7caWkf74Pkk+ZysES6CvvzWmRoChUpruA?=
 =?iso-8859-2?Q?7MfWE2gB3YEXRrkj/1HxW/iKK4AsWC7XLYkP7YGOqkmwBPTOT4umQdOra1?=
 =?iso-8859-2?Q?UbhpiKTgvWUKNKKQp/Rz2C+i5om46V1UxgAUarInKx4SzYjUCyjUknGa7n?=
 =?iso-8859-2?Q?nIgncTZIeiRidGRLmRpyzAA05ARsZcYmq20o0kSeSw7NBv6ANwou7OkxMh?=
 =?iso-8859-2?Q?0iEo9HIpNufauuXQfsVpfhMf96KqaugEgtfT6KnBpZa2+3dkCMGfuUBqkS?=
 =?iso-8859-2?Q?KEGzm+nKeHaeSu8/pU7h20MUWJiipBiN36MA32+MBTGlnRFuHyJzI4O1aL?=
 =?iso-8859-2?Q?t7gdyzLN7kZLcq2/vg9x+sxFWHg4726EZbqK3B5/V7hR8RTGuf/RlQU0vi?=
 =?iso-8859-2?Q?aSILwICVHIeNZd+sBTAcxSQROUXNOEWvMGskvquWztZGKpa3dE3ZMLo2ep?=
 =?iso-8859-2?Q?5mM6Pg7W7/avzWx2vit+yy5QWMyJIaI1parcDF5bxoUkZYlsiXd4A4ko9R?=
 =?iso-8859-2?Q?pCC0KwX7DKH05PSPyZXa7z6+h1lfuD21ZAn4FrAix4C3gfi1RM2wYDV+O5?=
 =?iso-8859-2?Q?QtuxIrayv21oS6mNnih/wPJ5t7iJSlCKAoFAH88vsv6GedUCgIzRU9eVN4?=
 =?iso-8859-2?Q?tJUQOwu+8hqYBqPbAAXzfs+38ZH0DOcpdpPY5J8oXIlLLBSRqIrdFLuqNC?=
 =?iso-8859-2?Q?LBUt2yULR9gRfoFA4643pFV+UOQq3eNY8TmtpQ5KtQS/w87aQM+AOKUSNA?=
 =?iso-8859-2?Q?9UlmzFhZbNu1DomNb3w+U41sUPNpLiRX2UKltBGjYqILqy//kJHKgKUJM9?=
 =?iso-8859-2?Q?WRX3VleGpKsbnC0Q4i/RVBbuy76Jdhc15wBr/pOHF77UzE8H3pnahU6y3K?=
 =?iso-8859-2?Q?PJrMsp8G7VtJ0+/dibjpySMe7EAnPlVfrl7XwNnxaucl19OCUfDHXCkB/e?=
 =?iso-8859-2?Q?xN1pQYMHg4EAK+UfmmPPDV4ZSxyXCDZyhNn96j1Kq/EyPifck/Up+MWuHZ?=
 =?iso-8859-2?Q?8SlYJqtLGLZgFN5b6SyN182j7ZIRbo21gOm+w9pQuhR0zyogEeQx6ORjZV?=
 =?iso-8859-2?Q?H6D7MU2hMFZhqqtgmzAI89n5tsC8FsXpaXPK2hFElMJbH2h/MwOnk8snjq?=
 =?iso-8859-2?Q?hqok0TyX2vERt+eY7BndHUumf7Hr2/Yom5FSW7jeg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b77af9fd-4164-4f0d-810f-08dd602176ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 22:18:20.1557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB8929

From: Arnd Bergmann <arnd@arndb.de> Sent: Monday, March 10, 2025 2:21 PM
>=20
> On Mon, Mar 10, 2025, at 22:01, Michael Kelley wrote:
> > From: Arnd Bergmann <arnd@arndb.de> Sent: Saturday, March 8, 2025 1:05 =
PM
> >> >  config HYPERV_VTL_MODE
> >> >  	bool "Enable Linux to boot in VTL context"
> >> > -	depends on X86_64 && HYPERV
> >> > +	depends on (X86_64 || ARM64)
> >> >  	depends on SMP
> >> > +	select OF_EARLY_FLATTREE
> >> > +	select OF
> >> >  	default n
> >> >  	help
> >>
> >> Having the dependency below the top-level Kconfig entry feels a little
> >> counterintuitive. You could flip that back as it was before by doing
> >>
> >>       select HYPERV_VTL_MODE if !ACPI
> >>       depends on ACPI || SMP
> >>
> >> in the HYPERV option, leaving the dependency on HYPERV in
> >> HYPERV_VTL_MODE.
> >
> > I would argue that we don't ever want to implicitly select
> > HYPERV_VTL_MODE because of some other config setting or
> > lack thereof.  VTL mode is enough of a special case that it should
> > only be explicitly selected. If someone omits ACPI, then HYPERV
> > should not be selectable unless HYPERV_VTL_MODE is explicitly
> > selected.
> >
> > The last line of the comment for HYPERV_VTL_MODE says
> > "A kernel built with this option must run at VTL2, and will not run
> > as a normal guest."  In other words, don't choose this unless you
> > 100% know that VTL2 is what you want.
>=20
> It sounds like the latter is the real problem: enabling a feature
> should never prevent something else from working. Can you describe
> what VTL context is and why it requires an exception to a rather
> fundamental rule here? If you build a kernel that runs on every
> single piece of arm64 hardware and every hypervisor, why can't
> you add HYPERV_VTL_MODE to that as an option?
>=20

VTL =3D Virtual Trust Level, and VSM =3D Virtual Secure Mode, are Hyper-V's
terminology for offering multiple execution environments with
hierarchical trust in the context of a single VM. A normal guest
operating system runs at VTL 0, and there are no other VTLs in use.
But in some environments, additional software may run as a paravisor
layer between the normal guest OS and the hypervisor. This software
runs at some other VTL > 0, and has a higher privilege level within
the VM than software running at VTL 0 (which is the lowest privilege).
VTL 2 is used today in the Azure cloud with CoCo VMs to run a
paravisor, and there may be other uses in the future. See [1] if you
want more details on VSM and VTLs. Also [2] for the CoCo VM use
case.

Ideally, a Linux kernel image could detect at runtime what VTL it is
running at, and "do the right thing". Unfortunately, on x86 Linux this
has proved difficult (or perhaps impossible) because the amount of
boot-time setup required to ask the question about the current VTL
is significant. The idiosyncrasies and historical baggage of x86 requires
that Linux do some x86-specific initialization steps for VTL > 0
before the question can be asked. Hence the introduction of
CONFIG_HYPERV_VTL_MODE, and the behavior that when it is
selected, the kernel image won't run normally in VTL 0.

I'll go out on a limb and say that I suspect on arm64 a runtime
determination based on querying the VTL *could* be made (though
I'm not the person writing the code). But taking advantage of that
on arm64 produces an undesirable dichotomy with x86.

Roman may have further thoughts on the topic, but that's
what I know about how we got here.

Michael

[1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlf=
s/vsm
[2] https://techcommunity.microsoft.com/blog/windowsosplatform/openhcl-the-=
new-open-source-paravisor/4273172

