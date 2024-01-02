Return-Path: <linux-arch+bounces-1229-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 199B2821C3A
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jan 2024 14:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16DDB1C22025
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jan 2024 13:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998DEF9DA;
	Tue,  2 Jan 2024 13:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="134aR5P3"
X-Original-To: linux-arch@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2047.outbound.protection.outlook.com [40.107.8.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293B5FBE7;
	Tue,  2 Jan 2024 13:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9oBKDUfUIVu12zsIh63GmKkPu5XUDbVSByTfW8jMY6r2nAchXE8XmLsda5v/dHudqaHPuRbBTs4Mf2A+UtJpycGVjtr5E0b4RFFMVdQ7aH/jD8EeTpM7jZCeUOUMmr28aC71hDCEoRfbGWhYLg1ZP4JItvCitq2jdlkK2bmk7+/6+NCEMRL/O3h1eHTOUFZgDI6eq+gbDdWe9bV1sWixngB1L4FBfvXiFdDtaTdBp043335KVjKVasirT62QcVLi0hXC8bFmTCI5eNqkjHKsdS7LMJzPeFJq4v7EQMqgQu4S4ShClm0eiptwsmDE7CTlm5mZNx2xPa6S+dmh0kHpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMuVsC9AWHLuCDPaAYWLd7P5CRYYcbMwJnZESJk+FPk=;
 b=eB8P2I8GWuECLr64IQYEGKpFjXMQhUGxAnuIe/50id8o9pyfQdUSwOIC0UA/Ft0F7/QVFs07OZiPGCwQvt96ffZmU/1E1D8PokYGuLAF/uISTakqEWU0KTuzR24/jE26L/p8iLdT3fWj6OjXvHfVEd62w5pMMgx0JSHk7Rnf3vy7k7vdTtPsUgTxGgS/McfeRAVEOTFMrsd0nIvwLIJluFt0PSjtSWUyqZ+uYr/9ugRRw4K0JDIEtHMyxNXKueSQc/XrC7fbkVgft0cYk4o6cPAe8e78eimvSduNH2xLAHedJZsI1YbAEXI7w/tD0vKmE8kyX3kZ/ofIWLeFBB9ZyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMuVsC9AWHLuCDPaAYWLd7P5CRYYcbMwJnZESJk+FPk=;
 b=134aR5P3PD7wHdexO/YIQ1j8bJVjKQdXd5uHl1pRIs0CQae3ImdhMPlL41TmW00i0OJnbl0s+swqn+qXR2wpGyb7SKxbNQ0dI6qmx8ZfDuaE/vORcy3/l9bywzm9qwAiOi7oQcKesGE0ehd/8pmRkbCEUZK6vO91ujg2uv8rdJY=
Received: from DBBPR08MB6012.eurprd08.prod.outlook.com (2603:10a6:10:205::9)
 by DB9PR08MB7889.eurprd08.prod.outlook.com (2603:10a6:10:39c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 13:07:26 +0000
Received: from DBBPR08MB6012.eurprd08.prod.outlook.com
 ([fe80::1827:6361:a3a3:5831]) by DBBPR08MB6012.eurprd08.prod.outlook.com
 ([fe80::1827:6361:a3a3:5831%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 13:07:25 +0000
From: Jose Marinho <Jose.Marinho@arm.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, "Russell King (Oracle)"
	<rmk+kernel@armlinux.org.uk>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>,
	"acpica-devel@lists.linuxfoundation.org"
	<acpica-devel@lists.linuxfoundation.org>, "linux-csky@vger.kernel.org"
	<linux-csky@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-ia64@vger.kernel.org"
	<linux-ia64@vger.kernel.org>, "linux-parisc@vger.kernel.org"
	<linux-parisc@vger.kernel.org>, Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Jianyong Wu
	<Jianyong.Wu@arm.com>, Justin He <Justin.He@arm.com>, James Morse
	<James.Morse@arm.com>, Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
	nd <nd@arm.com>
Subject: RE: [PATCH RFC v3 20/21] ACPI: Add _OSC bits to advertise OS support
 for toggling CPU present/enabled
Thread-Topic: [PATCH RFC v3 20/21] ACPI: Add _OSC bits to advertise OS support
 for toggling CPU present/enabled
Thread-Index: AQHaL3ntNyOGqVAnrU+84Ux6biaSarDGiPtQ
Date: Tue, 2 Jan 2024 13:07:25 +0000
Message-ID:
 <DBBPR08MB60121770239F324D877847E18861A@DBBPR08MB6012.eurprd08.prod.outlook.com>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
	<E1rDOhS-00Dvla-7i@rmk-PC.armlinux.org.uk>
 <20231215171227.00006550@Huawei.com>
In-Reply-To: <20231215171227.00006550@Huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ts-tracking-id: 220FBD1A958A4349801F4D34C4EDB266.0
x-checkrecipientchecked: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR08MB6012:EE_|DB9PR08MB7889:EE_
x-ms-office365-filtering-correlation-id: 4d9fbb8a-6984-4296-f48b-08dc0b93c41d
nodisclaimer: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 inFwSiSfqBq197UYjfu0XSyRKJAoKu3KUrHuFZXp+YF6c7xb+Eq5FhjrADa9lBjBFgyRuc9FmIpPVrgZqscsCVZos7Se5k8EDOYo8yCruGiuB/gfKIT607pVOG9B9/+nIlw+qgbVHsPsaveH/o+c7DUrwqjMjc52bku7GS2tD8E2Sy/cMF9ezAWOPCFcqTAk1V5RiaO6oFG8bHL9u99SAFQ8iZJ+IkJmaidcRhzhIqhyx75HBxCGUWXX+l028ctsEnmpE3T9sxFkrdndq2PDqcZ7e17Lf/VvMYEGNlxbW4Qi6vYV2pa/KtZIyAvfVtlMWzukcTCFFBZLSfAJXb0qJ9hNO3OzH/Wr0LGNg4hiQVqzmnn7yVP0IKdL+kVuBZMML6G0hQnuGxNt6C7jukZt67ICoN+nyj1ToYvmm/lDofLUcALsdDVpboibNWsrWrNlP1DQaYA8+8LurcJzfS5eMrDy2jUvKp9HIAhvmd8SabxjJzBqFZuEHOJpPjVjju6+Au5H7QYkjrh6tAjmOlCzYBCZOIuySPUabGVV5/HS4pUPOMCSXMzG/rUIehK5SVa6839F/Mn5k9koIOMq4nzrvmzUseEOjaFp6qJNF0F4jls=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB6012.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(376002)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(26005)(71200400001)(122000001)(83380400001)(38100700002)(76116006)(110136005)(66946007)(66556008)(64756008)(66446008)(66476007)(316002)(54906003)(478600001)(966005)(86362001)(55016003)(5660300002)(2906002)(7416002)(52536014)(33656002)(8936002)(8676002)(4326008)(38070700009)(9686003)(6506007)(7696005)(53546011)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cgxOvH4N3jU5Zt7a4hQIG9cgUq/+HSUTZ8bZ3+Z3Lvtp6K2q7EXA3COqDmYy?=
 =?us-ascii?Q?VYSN7xK/cWaOTyuYg9TpKh2eVyV4wdOTKK/7S1pMhSBbHYQ3i2GuqsEGL2BE?=
 =?us-ascii?Q?EDvFygdzoldu4OYsBIRa5xvXwY6UlDImSQMQICzhaquUhZ6gublJErbKFfCW?=
 =?us-ascii?Q?do559/cAyv7QIFcqD2hCKL9kVfsGk/5VFQYLaoDu+geXEHcD7eIVX/ishNHT?=
 =?us-ascii?Q?hd4BmVNd7+TUmqNxaZrUduYWU9jy8o2wCMoF8yx/LS+MvhnBHhFzzykOy6vT?=
 =?us-ascii?Q?CqjBY9HgOgeW/+USkyYob2EAX0TOt1IAWD7gflNZR0O+zVJriYPcrHmpdeUg?=
 =?us-ascii?Q?iMiIOFZG0fpm3C+IuRJgfa/v0YFmKPH73zS+V05fJGWHeqhr0cZ9+1QLkxwR?=
 =?us-ascii?Q?+z7E/Zpl6b2SEIPt5WEaFaqGWbvPOb3772u32YROBSfTim19nplO4eWPnC2r?=
 =?us-ascii?Q?mztwMBb+iv7BXVXQsl2WL4St7csFGpeEhxsyCR4STpypt4mtMtdDyyrXFjBg?=
 =?us-ascii?Q?TQpVxtpOhJ/GQvhnSmbgf3xNkPqE2xHeReowyrThsSVOR4ND7ppVu4AVO99K?=
 =?us-ascii?Q?lGXNsNFHTl+xmLDb1AxGqUEF514yDUeHecUXPFo+ciibIQg13FJBjrx9y9S4?=
 =?us-ascii?Q?cpOI76rj5mT/1YbFXg+yiQKLwnYAfamcC3eYXsrcu2DmKA4CjPNkgY5UvVjw?=
 =?us-ascii?Q?aqL1bEu5osLpfLdjQTT0ov5dhqNNLyaNkmagh0WZYf1WF+MUPDE3lVm4KCmk?=
 =?us-ascii?Q?8kkNsmoxQT47SIEx9Irp7fH3ThViGr34Rtzht0vzw3fsgfPg5F7ArmWdEZCL?=
 =?us-ascii?Q?Xeoz5dEon95195xrqdcD+8bqXwG2DOQkmVzx34/SVtRwWZ1WofRA3fGzImIE?=
 =?us-ascii?Q?qIsDRALbdeKebyD74ZtfBoDdHSaTHZZo8hhCqS36/ucb72ijs83Ui58f156g?=
 =?us-ascii?Q?XejGl6p2uBaPlQXNjw+MpC5muCdaU13gHlAVituxABCbh/OhtwOMOYht3y5X?=
 =?us-ascii?Q?N110Xw72w2EwRPQQ1/KwPpmKymsZUxKAJpobO5JFMa0XnbOfcLsNPWzjjAzJ?=
 =?us-ascii?Q?eclwvLsJ7TzMXx9bFlttyw6gW/EHaF71LJ/O1WKvB4wuDY5I3dTIi5v+NKc5?=
 =?us-ascii?Q?obxhdloFmLPecFnqtUwxtDfc0MuyTGcBFCph7CcIh1ugblV0mnFpY3wOUF36?=
 =?us-ascii?Q?uXb6FC8sdA3mitq3TJls3p8zSAsIJwuMAHoYSsY/pggT8n/3ODKAwrYfwdbL?=
 =?us-ascii?Q?7Ht44exEVxuCCmMf0feqWB1FGcMZh8oxFQ5gvDDPJ/UADQhtzyQV7pA0Il/Z?=
 =?us-ascii?Q?fdKXBO74JKnCDscZjenkN01uDzP1+x42+fhzbxp+7KDafQCDEfYfKjYO2w+h?=
 =?us-ascii?Q?gwXDM1HVXlJs3qqchTH3SpkS238zu16++K3hgZ7j14WvCGL7EJHAfviUVPav?=
 =?us-ascii?Q?n4WTL1k5wIc2EFFQvXN0WPyezX2DNGLhBZ2cVcIAcZEK5KyG4Qzd4yHNGL9h?=
 =?us-ascii?Q?lSI9LD8KpNFLOV4xLRdtk1bYfUZf4+uRJg/waBUQQQ7RsNqF7d8a5PBXXbAX?=
 =?us-ascii?Q?hFTTE3i/4/yr3ICaQWcHxbHHFkXg8R2p+84cxjTK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB6012.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9fbb8a-6984-4296-f48b-08dc0b93c41d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2024 13:07:25.7742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KsnnOwg6YeGR0Q1+dONTA/Ydk2cIFdhhP9IIKR0oHRwCC5pMhdWv9ML7HZfxGmyI76jdVh98yrHaR71KGWq5Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7889

Hi Jonathan,

> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Friday, December 15, 2023 5:12 PM
> To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Cc: linux-pm@vger.kernel.org; loongarch@lists.linux.dev; linux-
> acpi@vger.kernel.org; linux-arch@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> riscv@lists.infradead.org; kvmarm@lists.linux.dev; x86@kernel.org; acpica=
-
> devel@lists.linuxfoundation.org; linux-csky@vger.kernel.org; linux-
> doc@vger.kernel.org; linux-ia64@vger.kernel.org; linux-
> parisc@vger.kernel.org; Salil Mehta <salil.mehta@huawei.com>; Jean-Philip=
pe
> Brucker <jean-philippe@linaro.org>; Jianyong Wu <Jianyong.Wu@arm.com>;
> Justin He <Justin.He@arm.com>; James Morse <James.Morse@arm.com>;
> Jose Marinho <Jose.Marinho@arm.com>; Samer El-Haj-Mahmoud <Samer.El-
> Haj-Mahmoud@arm.com>
> Subject: Re: [PATCH RFC v3 20/21] ACPI: Add _OSC bits to advertise OS
> support for toggling CPU present/enabled
>=20
> On Wed, 13 Dec 2023 12:50:54 +0000
> Russell King (Oracle) <rmk+kernel@armlinux.org.uk> wrote:
>=20
> > From: James Morse <james.morse@arm.com>
> >
> > Platform firmware can disabled a CPU, or make it not-present by making
> > an eject-request notification, then waiting for the os to make it
> > offline
> OS
>=20
> > and call _EJx. After the firmware updates _STA with the new status.
> >
> > Not all operating systems support this. For arm64 making CPUs
> > not-present has never been supported. For all ACPI architectures,
> > making CPUs disabled has recently been added. Firmware can't know what
> the OS has support for.
> >
> > Add two new _OSC bits to advertise whether the OS supports the _STA
> > enabled or present bits being toggled for CPUs. This will be important
> > for arm64 if systems that support physical CPU hotplug ever appear as
> > arm64 linux doesn't currently support this, so firmware shouldn't try.
> >
> > Advertising this support to firmware is useful for cloud orchestrators
> > to know whether they can scale a particular VM by adding CPUs.
> >
> > Signed-off-by: James Morse <james.morse@arm.com>
> > Tested-by: Miguel Luis <miguel.luis@oracle.com>
> > Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> > Tested-by: Jianyong Wu <jianyong.wu@arm.com>
>=20
> I'm very much in favor of this _OSC but it hasn't been accepted yet I thi=
nk...
> https://bugzilla.tianocore.org/show_bug.cgi?id=3D4481
>=20
> Jose? Github suggests you are the proposer on this.

The addition of these _OSC bits was proposed by us on the forum in question=
.
The forum opted to pause the definition until additional practical informat=
ion could be provided on the use-cases.

If anyone is interested in progressing the _OSC bit definition, you are inv=
ited to express that interest in the Bugzilla ticket.
Information that you should provide to increase the chances of the ticket b=
eing reopened:
- use-case for the new _OSC bits,
- what breaks (if anything) without the proposed _OSC bits.

We did receive additional comments:
- the proposed _OSC bits are not generic: the bits simply convey whether th=
e guest OS understands CPU hot-plug, but it says nothing about the number o=
f CPUs that the OS supports.
- There could be alternate schemes that do not rely on spec changes. E.g. t=
here could be a hypervisor IMPDEF mechanism to describe if an OS image supp=
orts CPU hot-plug.

>=20
> btw v4 looks ok but v5 in the tianocore github seems to have lost the act=
ual
> OSC part.

Agree that, if we do progress with this spec change, v4 is the correct form=
ulation we should adopt.=20

Regards,
Jose

>=20
> Jonathan
>=20
> > ---
> > I'm assuming Loongarch machines do not support physical CPU hotplug.
> >
> > Changes since RFC v3:
> >  * Drop ia64 changes
> >  * Update James' comment below "---" to remove reference to ia64
> >
> > Outstanding comment:
> >  https://lore.kernel.org/r/20230914175021.000018fd@Huawei.com
>=20
>=20
>=20
> > ---
> >  arch/x86/Kconfig              |  1 +
> >  drivers/acpi/Kconfig          |  9 +++++++++
> >  drivers/acpi/acpi_processor.c | 14 +++++++++++++-
> >  drivers/acpi/bus.c            | 16 ++++++++++++++++
> >  include/linux/acpi.h          |  4 ++++
> >  5 files changed, 43 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig index
> > 64fc7c475ab0..33fc4dcd950c 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -60,6 +60,7 @@ config X86
> >  	select ACPI_LEGACY_TABLES_LOOKUP	if ACPI
> >  	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
> >  	select ACPI_HOTPLUG_PRESENT_CPU		if ACPI_PROCESSOR
> && HOTPLUG_CPU
> > +	select ACPI_HOTPLUG_IGNORE_OSC		if ACPI &&
> HOTPLUG_CPU
> >  	select ARCH_32BIT_OFF_T			if X86_32
> >  	select ARCH_CLOCKSOURCE_INIT
> >  	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
> > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig index
> > 9c5a43d0aff4..020e7c0ab985 100644
> > --- a/drivers/acpi/Kconfig
> > +++ b/drivers/acpi/Kconfig
> > @@ -311,6 +311,15 @@ config ACPI_HOTPLUG_PRESENT_CPU
> >  	depends on ACPI_PROCESSOR && HOTPLUG_CPU
> >  	select ACPI_CONTAINER
> >
> > +config ACPI_HOTPLUG_IGNORE_OSC
> > +	bool
> > +	depends on ACPI_HOTPLUG_PRESENT_CPU
> > +	help
> > +	  Ignore whether firmware acknowledged support for toggling the CPU
> > +	  present bit in _STA. Some architectures predate the _OSC bits, so
> > +	  firmware doesn't know to do this.
> > +
> > +
> >  config ACPI_PROCESSOR_AGGREGATOR
> >  	tristate "Processor Aggregator"
> >  	depends on ACPI_PROCESSOR
> > diff --git a/drivers/acpi/acpi_processor.c
> > b/drivers/acpi/acpi_processor.c index ea12e70dfd39..5bb207a7a1dd
> > 100644
> > --- a/drivers/acpi/acpi_processor.c
> > +++ b/drivers/acpi/acpi_processor.c
> > @@ -182,6 +182,18 @@ static void __init acpi_pcc_cpufreq_init(void)
> > static void __init acpi_pcc_cpufreq_init(void) {}  #endif /*
> > CONFIG_X86 */
> >
> > +static bool acpi_processor_hotplug_present_supported(void)
> > +{
> > +	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_PRESENT_CPU))
> > +		return false;
> > +
> > +	/* x86 systems pre-date the _OSC bit */
> > +	if (IS_ENABLED(CONFIG_ACPI_HOTPLUG_IGNORE_OSC))
> > +		return true;
> > +
> > +	return osc_sb_hotplug_present_support_acked;
> > +}
> > +
> >  /* Initialization */
> >  static int acpi_processor_make_present(struct acpi_processor *pr)  {
> > @@ -189,7 +201,7 @@ static int acpi_processor_make_present(struct
> acpi_processor *pr)
> >  	acpi_status status;
> >  	int ret;
> >
> > -	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_PRESENT_CPU)) {
> > +	if (!acpi_processor_hotplug_present_supported()) {
> >  		pr_err_once("Changing CPU present bit is not supported\n");
> >  		return -ENODEV;
> >  	}
> > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c index
> > 72e64c0718c9..7122450739d6 100644
> > --- a/drivers/acpi/bus.c
> > +++ b/drivers/acpi/bus.c
> > @@ -298,6 +298,13 @@
> > EXPORT_SYMBOL_GPL(osc_sb_native_usb4_support_confirmed);
> >
> >  bool osc_sb_cppc2_support_acked;
> >
> > +/*
> > + * ACPI 6.? Proposed Operating System Capabilities for modifying CPU
> > + * present/enable.
> > + */
> > +bool osc_sb_hotplug_enabled_support_acked;
> > +bool osc_sb_hotplug_present_support_acked;
> > +
> >  static u8 sb_uuid_str[] =3D "0811B06E-4A27-44F9-8D60-3CBBC22E7B48";
> >  static void acpi_bus_osc_negotiate_platform_control(void)
> >  {
> > @@ -346,6 +353,11 @@ static void
> > acpi_bus_osc_negotiate_platform_control(void)
> >
> >  	if (!ghes_disable)
> >  		capbuf[OSC_SUPPORT_DWORD] |=3D OSC_SB_APEI_SUPPORT;
> > +
> > +	capbuf[OSC_SUPPORT_DWORD] |=3D
> OSC_SB_HOTPLUG_ENABLED_SUPPORT;
> > +	if (IS_ENABLED(CONFIG_ACPI_HOTPLUG_PRESENT_CPU))
> > +		capbuf[OSC_SUPPORT_DWORD] |=3D
> OSC_SB_HOTPLUG_PRESENT_SUPPORT;
> > +
> >  	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
> >  		return;
> >
> > @@ -383,6 +395,10 @@ static void
> acpi_bus_osc_negotiate_platform_control(void)
> >  			capbuf_ret[OSC_SUPPORT_DWORD] &
> OSC_SB_NATIVE_USB4_SUPPORT;
> >  		osc_cpc_flexible_adr_space_confirmed =3D
> >  			capbuf_ret[OSC_SUPPORT_DWORD] &
> OSC_SB_CPC_FLEXIBLE_ADR_SPACE;
> > +		osc_sb_hotplug_enabled_support_acked =3D
> > +			capbuf_ret[OSC_SUPPORT_DWORD] &
> OSC_SB_HOTPLUG_ENABLED_SUPPORT;
> > +		osc_sb_hotplug_present_support_acked =3D
> > +			capbuf_ret[OSC_SUPPORT_DWORD] &
> OSC_SB_HOTPLUG_PRESENT_SUPPORT;
> >  	}
> >
> >  	kfree(context.ret.pointer);
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h index
> > 00be66683505..c572abac803c 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -559,12 +559,16 @@ acpi_status acpi_run_osc(acpi_handle handle,
> struct acpi_osc_context *context);
> >  #define OSC_SB_NATIVE_USB4_SUPPORT		0x00040000
> >  #define OSC_SB_PRM_SUPPORT			0x00200000
> >  #define OSC_SB_FFH_OPR_SUPPORT			0x00400000
> > +#define OSC_SB_HOTPLUG_ENABLED_SUPPORT		0x00800000
> > +#define OSC_SB_HOTPLUG_PRESENT_SUPPORT		0x01000000
> >
> >  extern bool osc_sb_apei_support_acked;  extern bool
> > osc_pc_lpi_support_confirmed;  extern bool
> > osc_sb_native_usb4_support_confirmed;
> >  extern bool osc_sb_cppc2_support_acked;  extern bool
> > osc_cpc_flexible_adr_space_confirmed;
> > +extern bool osc_sb_hotplug_enabled_support_acked;
> > +extern bool osc_sb_hotplug_present_support_acked;
> >
> >  /* USB4 Capabilities */
> >  #define OSC_USB_USB3_TUNNELING			0x00000001


