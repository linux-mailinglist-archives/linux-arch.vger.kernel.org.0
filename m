Return-Path: <linux-arch+bounces-1366-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2512F82C26D
	for <lists+linux-arch@lfdr.de>; Fri, 12 Jan 2024 16:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6EB828303F
	for <lists+linux-arch@lfdr.de>; Fri, 12 Jan 2024 15:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724BB6E2DE;
	Fri, 12 Jan 2024 15:04:06 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BA26E2C5;
	Fri, 12 Jan 2024 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TBPrs1VcSz6FGMn;
	Fri, 12 Jan 2024 23:02:05 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 445D41400CB;
	Fri, 12 Jan 2024 23:04:01 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Jan
 2024 15:04:00 +0000
Date: Fri, 12 Jan 2024 15:03:59 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	<linux-pm@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, <acpica-devel@lists.linuxfoundation.org>,
	<linux-csky@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-ia64@vger.kernel.org>, <linux-parisc@vger.kernel.org>, Salil Mehta
	<salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	<jianyong.wu@arm.com>, <justin.he@arm.com>, James Morse <james.morse@arm.com>
Subject: Re: [PATCH RFC v3 02/21] ACPI: processor: Add support for
 processors described as container packages
Message-ID: <20240112150359.0000733f@Huawei.com>
In-Reply-To: <CAJZ5v0g2CFPrSfNzHKBz_Spwt304QEQtR6w57VR11i5APPrD8Q@mail.gmail.com>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
	<E1rDOfx-00Dvje-MS@rmk-PC.armlinux.org.uk>
	<CAJZ5v0iB0bS6nmjQ++pV1zp5YSGuigbffK5VD3wsX+8bY9MA5w@mail.gmail.com>
	<20240111175908.00002f46@Huawei.com>
	<ZaA3l4yjgCXxSiVg@shell.armlinux.org.uk>
	<20240112092520.00001278@Huawei.com>
	<CAJZ5v0g2CFPrSfNzHKBz_Spwt304QEQtR6w57VR11i5APPrD8Q@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 12 Jan 2024 16:01:40 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Fri, Jan 12, 2024 at 10:25=E2=80=AFAM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Thu, 11 Jan 2024 18:46:47 +0000
> > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > =20
> > > On Thu, Jan 11, 2024 at 05:59:08PM +0000, Jonathan Cameron wrote: =20
> > > > On Mon, 18 Dec 2023 21:17:34 +0100
> > > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > > > =20
> > > > > On Wed, Dec 13, 2023 at 1:49=E2=80=AFPM Russell King <rmk+kernel@=
armlinux.org.uk> wrote: =20
> > > > > >
> > > > > > From: James Morse <james.morse@arm.com> =20
> > > >
> > > > Done some digging + machine faking.  This is mid stage results at b=
est.
> > > >
> > > > Summary: I don't think this patch is necessary.  If anyone happens =
to be in
> > > > the mood for testing on various platforms, can you drop this patch =
and
> > > > see if everything still works.
> > > >
> > > > With this patch in place, and a processor container containing
> > > > Processor() objects acpi_process_add is called twice - once via
> > > > the path added here and once via acpi_bus_attach etc.
> > > >
> > > > Maybe it's a left over from earlier approaches to some of this? =20
> > >
> > > From what you're saying, it seems that way. It would be really good to
> > > get a reply from James to see whether he agrees - or at least get the
> > > reason why this patch is in the series... but I suspect that will nev=
er
> > > come.
> > > =20
> > > > Both cases are covered by the existing handling without this.
> > > >
> > > > I'm far from clear on why we need this patch.  Presumably
> > > > it's the reference in the description on it breaking for
> > > > Processor Package containing Processor() objects that matters
> > > > after a move... I'm struggling to find that move though! =20
> > >
> > > I do know that James did a lot of testing, so maybe he found some
> > > corner case somewhere which made this necessary - but without input
> > > from James, we can't know that.
> > >
> > > So, maybe the right way forward on this is to re-test the series
> > > with this patch dropped, and see whether there's any ill effects.
> > > It should be possible to resurect the patch if it does turn out to
> > > be necessary.
> > >
> > > Does that sound like a good way forward?
> > >
> > > Thanks.
> > > =20
> >
> > Yes that sounds like the best plan. Note this patch can only make a
> > difference on non arm64 arches because it's a firmware bug to combine
> > Processor() with a GICC entry in APIC/MADT.  To even test on ARM64
> > you have to skip the bug check.
> >
> > https://elixir.bootlin.com/linux/latest/source/drivers/acpi/processor_c=
ore.c#L101
> >
> >         /* device_declaration means Device object in DSDT, in the
> >          * GIC interrupt model, logical processors are required to
> >          * have a Processor Device object in the DSDT, so we should
> >          * check device_declaration here
> >          */
> > //      if (device_declaration && (gicc->uid =3D=3D acpi_id)) {
> >         if (gicc->uid =3D=3D acpi_id) {
> >                 *mpidr =3D gicc->arm_mpidr;
> >                 return 0;
> >         }
> >
> > Only alternative is probably to go history diving and try and
> > find another change that would have required this and is now gone.
> >
> > The ACPI scanning code has had a lot of changes whilst this work has
> > been underway.  More than possible that this was papering over some
> > issue that has long since been fixed. I can't find any deliberate
> > functional changes, but there is some code generalization that 'might'
> > have side effects in this area. Rafael, any expectation that anything
> > changed in how scanning processor containers works? =20
>=20
> There have been changes, but I can't recall when exactly without some
> git history research.
>=20
> In any case, it is always better to work on top of the current
> mainline code IMO.

Absolutely - just in this case the series has been rebased for=20
a few years because the standards discussions took far far too long!

Jonathan



