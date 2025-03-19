Return-Path: <linux-arch+bounces-10979-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25407A69BD2
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 23:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 547FF188A8FB
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 22:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAF9217709;
	Wed, 19 Mar 2025 22:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hthE3dox"
X-Original-To: linux-arch@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19010002.outbound.protection.outlook.com [52.103.11.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB5D215792;
	Wed, 19 Mar 2025 22:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742422316; cv=fail; b=plv4UzygNsx8SpdsvyYiTMgS1eBf7qOOXMgWOJbOPUMmlPXShSaRswNpiUMyiVgyMnvrMFdCtwzgq4i/illffOLFt5JdzsCc3g0M6rJE+LyLNc5M864VH33mCWEGwRly2lIFZ8ETBZBIoVWsfzfVnzAXUR5RIjXBCSo6rmkdS8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742422316; c=relaxed/simple;
	bh=Kn1a+I9o5gWGBnwjbvINiP8JzYWG+91LuaX1edVJuG4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ti6hg8LOQaMlTZud183c7Qkl7076ZETu+qJfSngZbIBrXkH0lqVlGGXv8GD0N5UachWMlrb9R5lGzJdVFbZQdQunpoy8ysjKOL2hPhgIn24lfDyTu5FTMHHu2I2OJbPLeENz2+x/COVz2w4oNHiP5Yb/5KjxJO038HHlW71QP2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hthE3dox; arc=fail smtp.client-ip=52.103.11.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RC9Kvqq4x7xPerd5dbf3bPTog1wY8mR+KCxy/G3IgfGXp7qazpTe4yx0S5qPbVhj1dyRJ0RvzXqdHHGvvLWMHpfDgp6rq7MUK4tpTk/xxUTLNogt5NvntlCRTL7kLEO3VKL7bwwMXlfxo8PrgWubdCGAAmsPbvzMCZjsXg40yxyymctDk+1opb8+lT1sPbbrWMShq2f9R6B4c8ZnO3ITAcQpakFSwJI4pWvw0/P9s2CUGZzZ2UzzrH+iD8oU9e7Xxly4BCabyF8j3QYpMfrNA3ndSY9RV/ZDKXZ2PFb5plmKBdBD6kIfpythVpHYCqKU7rPj1SifhIcEpcHPqS/REw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQFCOMB/MiULmPkh5Xy/rPPwUgUOby8wHm3uz+yfWkc=;
 b=eNH8T+alDBEzsJC7urgJdOFmT3NSaUtiyg1t2qz9VMQVIdcTAK/7pKZ9oppma2n32ybz9GlMM+B1VsGK48KF9ShgBPTNQooggBcBNMApPJ9GVOAnJFLEvUuG8dKSch6u49RlKkPzU0oeJwIjwB3pDDlYw4FzbqBV16jMkRexMCU/kg54R07Gm4rYRslZpkkH6jgRBWKStHveo5bQRr0HJzRnSkawC2aqBdNHxhBPAT/DxdldbZCIIx+NqTGiI/aAU8SFhVYAbkh+tPaGFdgEId8Vx619PSdkVRbjcuq6CZBtPzfptC7yA7qaztwrQhZkmAZhCFFvakGeNJSCswUGgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQFCOMB/MiULmPkh5Xy/rPPwUgUOby8wHm3uz+yfWkc=;
 b=hthE3doxrZR9614ReNP46tI0aweiWfuKHZysx47YSed8irq/M42qozIybZgjE67kFs8jQbx6/dK5eunNApxZq3x6teRQ4zJ6lX0OpHrNKmd34dx0bS1aWN8lsATThQfncDRrtQj1j6Pa2NMwejGW62UzTRu6xKAClX07aiJtqfVpyB0eDqJlUhosClrAhvP1mGHFGV9hpt6lXUMAEJ7n3yry/IzD58S9BMW6ZEmzHSUWhC3wj2Z/ot8eeaIf+9Lg9xxVTro7PVFGWS9W6qEs5OzB1ofSh15aVimqSNPJAUBCgvDLrr/3uI1VnJbQuUog21fNPpGzOaN1bLwck5qAeA==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by CH0PR02MB8167.namprd02.prod.outlook.com (2603:10b6:610:10c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 22:11:50 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911%4]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 22:11:50 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Mark Rutland <mark.rutland@arm.com>, Roman Kisel
	<romank@linux.microsoft.com>
CC: "arnd@arndb.de" <arnd@arndb.de>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"joey.gouly@arm.com" <joey.gouly@arm.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "kw@linux.com" <kw@linux.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "lenb@kernel.org" <lenb@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"maz@kernel.org" <maz@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
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
	<linux-pci@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v6 02/11] arm64: hyperv: Use SMCCC to detect
 hypervisor presence
Thread-Topic: [PATCH hyperv-next v6 02/11] arm64: hyperv: Use SMCCC to detect
 hypervisor presence
Thread-Index: AQHblUAkoBBQzsRuEEy6HcktK4WqQrN3N46AgAPUpyA=
Date: Wed, 19 Mar 2025 22:11:50 +0000
Message-ID:
 <BN7PR02MB414871F1A3D8EF3809391F2FD4D92@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20250315001931.631210-1-romank@linux.microsoft.com>
 <20250315001931.631210-3-romank@linux.microsoft.com>
 <Z9gJlQgV3hm1kxY0@J2N7QTR9R3.cambridge.arm.com>
In-Reply-To: <Z9gJlQgV3hm1kxY0@J2N7QTR9R3.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|CH0PR02MB8167:EE_
x-ms-office365-filtering-correlation-id: 229cfce5-568f-499c-4c76-08dd67330c29
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|8060799006|461199028|15080799006|19110799003|41001999003|3412199025|102099032|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GPNdOqi++imkAfkZkUaYXRz9UV5S6znkgcvOZRNEGPuuQ/atYyquKkVkcXgl?=
 =?us-ascii?Q?9c/PqOg6Uar8T7CG3KnOCuN/4P0cxnkXETXbaw1oNH5csn0Oz1hNhpsm6y15?=
 =?us-ascii?Q?D8gHahv0NpucjnJYvvfOH5TS15VLIBAMmyZm9l4872827DYclehrQPkY4A5+?=
 =?us-ascii?Q?5o/rnxCKfsMe3D/vgQHqXM0xq3OMgq6BSgXZj+evEPJImQf8WS+BgeuiLaJh?=
 =?us-ascii?Q?/Tia4qgEh1CnJSlemDNZqxoZ/tDSY5bGKFUzwm/prjiNOnOn6rSbMhEmMapU?=
 =?us-ascii?Q?6vPSFU4E6gTD7Wu5yyseusKRmBh3QGjDbBtxOjRikDwruNCJYXO5Mf+XVNdw?=
 =?us-ascii?Q?uYZItLplpJk0LM+KrfujHexSOj/ufFRPJ2HnoP/RVO019CGVqduI/o1A4JlD?=
 =?us-ascii?Q?xRkPMEIL2WbgEy1fKKq1L4tqHRbmrlwg7k44la9QZEpxauTwGcWXdj6HL1xf?=
 =?us-ascii?Q?9GFlxaU3GZO9wkoHAoUZHcc/JDya0sKSNMkedBzxpummVDKu7apKXDYuM8cC?=
 =?us-ascii?Q?WZfcqCHVCtRRjoNTz5+g1gUWenvAZNrsvj/QhKpc2zyDJERSArkg+9RlsTfr?=
 =?us-ascii?Q?QTTELp5LIPED8beqgQ6cqn53FXoA05JsX15WFTKxazRQZFXKWcNFj0Zg/3td?=
 =?us-ascii?Q?d5YoABI/Cm5fLDoTURJ7hodyD+g9Sgw99cUbrUyKVwsHta6GNsSoWH9OD67b?=
 =?us-ascii?Q?Q1Mpa3Z6cLSfY2vnKq/vr9TDDmAquS6yIKKQx8m8W6GCJ3LmqcWuM7+8J0PF?=
 =?us-ascii?Q?WKeBV1K78n2A4eGfihQpJgeYU0URQwGk5R6hDQCJK1xvnWlNupo11QhWpKgT?=
 =?us-ascii?Q?DjIV0OjHicYYHd754tWUojz2SlGrDLhxIPeiruHp4k/QmuKbMzsxHgdJByc/?=
 =?us-ascii?Q?whG1dqbJNpg/59OHXJyxFJhEHXFnIIEJWEDXflYiEEhO0h3uxxVldR+Ae/3L?=
 =?us-ascii?Q?oaGBb35+ucNE8ULk9Lj2V2U4/OD4lxtwD9l1pEHGUX5qvF6RGe3mhd7waU4K?=
 =?us-ascii?Q?bh8wOFQDVWseJl8PyqT/fG8q57xs6iTSY0x3tq4097xAuKG12TeqdF4DdE2p?=
 =?us-ascii?Q?eN/pwOkqcSGf2KCtlZChvl9oyAMTG8Tcgkn2ZDlOmPjOTvR70myAIYjZrr1H?=
 =?us-ascii?Q?CV16sw9r93gh?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FrfF+qz+U2b94+727QUO675a2+QZC1MuPWEyOBMc7WjvL3hxqje3G4tEFTC/?=
 =?us-ascii?Q?XdGG4OtH/kuHgmxmzCtWFbZgZc0z7v+Io/Fr+Wp9aJAwtlLeAvOZS5ZarmrK?=
 =?us-ascii?Q?KrI7YByOC84Y4RYJIrVcnZ65tyQwvdlEYHhPncMW3xScfnV7Ysp/bQ1kCmx3?=
 =?us-ascii?Q?EMdycTj1PK0jaEuuQUcm/xWeOH/AXNzCFSZaktEtob8CarrgUWbpgLX2ydWC?=
 =?us-ascii?Q?WHq0UrEto2+Hw3NQ7LKivejGdAfyIgnCagrMDt7wm2BNApzyO71Auczl4YOx?=
 =?us-ascii?Q?2sH1XmtYiY2uGLNhd2GQw006OaeZdk/SMHCoWgM6H1ZsXcXLyfaizj8RMRX0?=
 =?us-ascii?Q?G7E0b9fz/XxARQzKXT30CalN/4lfb407pqJRs6MgJx0OU+lddcdb84KSHhTW?=
 =?us-ascii?Q?4PIgMn+1nsf2YiU4go+Osy7QKG/Qjf8Q9rXGBTCjLqNOroVhizFrrXpZFvoP?=
 =?us-ascii?Q?fe5TvzMi3xlkQ7na+tc5CvivEnBvgawMaIBbEHoRwmcprYLQCof6w8HxSmxm?=
 =?us-ascii?Q?9995TzcbA6AxF6kSsRYSsp7MiWILuwZKZOww5RUfS98qQwR6v5ycrqLXaY1O?=
 =?us-ascii?Q?gxkbh3wmgV5WUU/I5qxCY2JjeCtiHpcqdXExjLZveWuFkIhVh+SXcW2RFdvQ?=
 =?us-ascii?Q?7kdxtxuvXUR9gmbXNRHrfSNzZQDxb8oFZsbsFkIzWlRMKHxFGCq9eff9P3/s?=
 =?us-ascii?Q?6ilQdEud2GJvYEcn6xKxOWbef9QGomA3wqOf6NwwulkTGwm997aWbuAu2FLI?=
 =?us-ascii?Q?RskdUZ594yqzAOeCgdcEDIZrvWmadFnN+OOiCoYtJq4zrpLtRRFqPjP03BDc?=
 =?us-ascii?Q?2h71bbx8SjkC7UgGfdRT0RLvvVuqKxTVzqYWOEVD5rorF9srHfsGSlPXiwlG?=
 =?us-ascii?Q?pZd5+gfh5zJqr+huyom1VGx8klxtn5LdBLmsVT6iN0FpVHBb8mKGKbIF6UBM?=
 =?us-ascii?Q?7AV0RFiMcsgwFHHv9GHBUunkbXpwMpWRMglKZ1YDl9a7i3gvoBJIFw/R1AX5?=
 =?us-ascii?Q?TbWmfIS4OMaYg4kWwUzLmgkVzJwZRRF+1ZB2oBfkDq2k16VVhTfbOmmO5/H7?=
 =?us-ascii?Q?9sHHunYfMRVGLlCh+85rA5lmfAo0QNC8GO9tO/7IYb2DWT8kzb1cdBBCe45l?=
 =?us-ascii?Q?f4xSYjnywM8qNg7HvPzaAf5aUcBng1Xo5CipzvFHFuY85lY4p4OBxktG0bR9?=
 =?us-ascii?Q?9Jr7P5zTnWRgX/bblPZPZMK6r8+1TDcAa4fXg7gAUsI7bNaecm0O1/uHP64?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 229cfce5-568f-499c-4c76-08dd67330c29
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 22:11:50.1092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8167

From: Mark Rutland <mark.rutland@arm.com> Sent: Monday, March 17, 2025 4:38=
 AM
>=20
> On Fri, Mar 14, 2025 at 05:19:22PM -0700, Roman Kisel wrote:
> > The arm64 Hyper-V startup path relies on ACPI to detect
> > running under a Hyper-V compatible hypervisor. That
> > doesn't work on non-ACPI systems.
> >
> > Hoist the ACPI detection logic into a separate function. Then
> > use the vendor-specific hypervisor service call (implemented
> > recently in Hyper-V) via SMCCC in the non-ACPI case.
> >
> > Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> > Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> > ---
> >  arch/arm64/hyperv/mshyperv.c | 43 +++++++++++++++++++++++++++++++-----
> >  1 file changed, 38 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.=
c
> > index 2265ea5ce5ad..c5b03d3af7c5 100644
> > --- a/arch/arm64/hyperv/mshyperv.c
> > +++ b/arch/arm64/hyperv/mshyperv.c
> > @@ -27,6 +27,41 @@ int hv_get_hypervisor_version(union
> hv_hypervisor_version_info *info)
> >  	return 0;
> >  }
> >
> > +static bool __init hyperv_detect_via_acpi(void)
> > +{
> > +	if (acpi_disabled)
> > +		return false;
> > +#if IS_ENABLED(CONFIG_ACPI)
> > +	/*
> > +	 * Hypervisor ID is only available in ACPI v6+, and the
> > +	 * structure layout was extended in v6 to accommodate that
> > +	 * new field.
> > +	 *
> > +	 * At the very minimum, this check makes sure not to read
> > +	 * past the FADT structure.
> > +	 *
> > +	 * It is also needed to catch running in some unknown
> > +	 * non-Hyper-V environment that has ACPI 5.x or less.
> > +	 * In such a case, it can't be Hyper-V.
> > +	 */
> > +	if (acpi_gbl_FADT.header.revision < 6)
> > +		return false;
> > +	return strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8) =
=3D=3D 0;
> > +#else
> > +	return false;
> > +#endif
> > +}
> > +
>=20
> The 'acpi_disabled' variable doesn't exist for !CONFIG_ACPI, so its use
> prior to the ifdeffery looks misplaced.

FWIW, include/linux/acpi.h has=20

#define acpi_disabled 1

when !CONFIG_ACPI.  But I agree that using a stub is better.

Michael

>=20
> Usual codestyle is to avoid ifdeffery if possible, using IS_ENABLED().
> Otherwise, use a stub, e.g.
>=20
> | #ifdef CONFIG_ACPI
> | static bool __init hyperv_detect_via_acpi(void)
> | {
> | 	if (acpi_disabled)
> | 		return false;
> |
> | 	if (acpi_gbl_FADT.header.revision < 6)
> | 		return false;
> |
> | 	return strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8) =
=3D=3D 0;
> | }
> | #else
> | static inline bool hyperv_detect_via_acpi(void) { return false; }
> | #endif
>=20
> Mark.
>=20
> > +static bool __init hyperv_detect_via_smccc(void)
> > +{
> > +	uuid_t hyperv_uuid =3D UUID_INIT(
> > +		0x4d32ba58, 0x4764, 0xcd24,
> > +		0x75, 0x6c, 0xef, 0x8e,
> > +		0x24, 0x70, 0x59, 0x16);
> > +
> > +	return arm_smccc_hyp_present(&hyperv_uuid);
> > +}
> > +
> >  static int __init hyperv_init(void)
> >  {
> >  	struct hv_get_vp_registers_output	result;
> > @@ -35,13 +70,11 @@ static int __init hyperv_init(void)
> >
> >  	/*
> >  	 * Allow for a kernel built with CONFIG_HYPERV to be running in
> > -	 * a non-Hyper-V environment, including on DT instead of ACPI.
> > +	 * a non-Hyper-V environment.
> > +	 *
> >  	 * In such cases, do nothing and return success.
> >  	 */
> > -	if (acpi_disabled)
> > -		return 0;
> > -
> > -	if (strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8))
> > +	if (!hyperv_detect_via_acpi() && !hyperv_detect_via_smccc())
> >  		return 0;
> >
> >  	/* Setup the guest ID */
> > --
> > 2.43.0
> >


