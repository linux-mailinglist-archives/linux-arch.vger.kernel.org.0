Return-Path: <linux-arch+bounces-1417-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58426836D20
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 18:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BDCCB29895
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 17:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197FF4D5A8;
	Mon, 22 Jan 2024 16:02:34 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552013E479;
	Mon, 22 Jan 2024 16:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705939354; cv=none; b=Rwzu8Dclo0PlUkoy6lIeD1MXAoFqViOPGQPt2vtlgYs2O7qJ1VeeKDKhtSQV2NiyF4oKTDPsZKZbVsPv7HpcDaGwtUONmREuN7SNZg3u9LCdhYVeY+KG/csBc3TnXmEeyaH3Fo6otiDTM88L8me+5eUQeT1xWJPozIVxBhkR5NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705939354; c=relaxed/simple;
	bh=DfvUc1kkTAgFV9KbBC0HUkcLxAbVIJv/dK2TEfAAtq8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=huohQdLaAwTIeg4SefLPIdvnoGWvp3do1yJx7cTMDlZTyBgl7jbP9P6p+WOPRQpMIHLQ1XUAb/sO+pTBym6ra5RdOwUxezcDNjRbo5/JArobeXfSZ8PbQxc9HyaniDo1kBlpE0JCiqqwk9pkJ6+p3C4g4Wcz1kPAKLwZ6cCa7aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TJZg429vPz6K6FL;
	Tue, 23 Jan 2024 00:00:00 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 89AC3140B2F;
	Tue, 23 Jan 2024 00:02:28 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Jan
 2024 16:02:27 +0000
Date: Mon, 22 Jan 2024 16:02:27 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
	<kvmarm@lists.linux.dev>, <x86@kernel.org>,
	<acpica-devel@lists.linuxfoundation.org>, <linux-csky@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
	<linux-parisc@vger.kernel.org>, Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>, <jianyong.wu@arm.com>,
	<justin.he@arm.com>, James Morse <james.morse@arm.com>
Subject: Re: [PATCH RFC v3 03/21] ACPI: processor: Register CPUs that are
 online, but not described in the DSDT
Message-ID: <20240122160227.00002d83@Huawei.com>
In-Reply-To: <ZaURtUvWQyjYfiiO@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
	<E1rDOg2-00Dvjk-RI@rmk-PC.armlinux.org.uk>
	<CAJZ5v0ju1JHgpjuFLHZVs4NZiARG6iBZN_wza6c2e0kDhZjK0w@mail.gmail.com>
	<ZaURtUvWQyjYfiiO@shell.armlinux.org.uk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 15 Jan 2024 11:06:29 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Mon, Dec 18, 2023 at 09:22:03PM +0100, Rafael J. Wysocki wrote:
> > On Wed, Dec 13, 2023 at 1:49=E2=80=AFPM Russell King <rmk+kernel@armlin=
ux.org.uk> wrote: =20
> > >
> > > From: James Morse <james.morse@arm.com>
> > >
> > > ACPI has two descriptions of CPUs, one in the MADT/APIC table, the ot=
her
> > > in the DSDT. Both are required. (ACPI 6.5's 8.4 "Declaring Processors"
> > > says "Each processor in the system must be declared in the ACPI
> > > namespace"). Having two descriptions allows firmware authors to get
> > > this wrong.
> > >
> > > If CPUs are described in the MADT/APIC, they will be brought online
> > > early during boot. Once the register_cpu() calls are moved to ACPI,
> > > they will be based on the DSDT description of the CPUs. When CPUs are
> > > missing from the DSDT description, they will end up online, but not
> > > registered.
> > >
> > > Add a helper that runs after acpi_init() has completed to register
> > > CPUs that are online, but weren't found in the DSDT. Any CPU that
> > > is registered by this code triggers a firmware-bug warning and kernel
> > > taint.
> > >
> > > Qemu TCG only describes the first CPU in the DSDT, unless cpu-hotplug
> > > is configured. =20
> >=20
> > So why is this a kernel problem? =20
>=20
> So what are you proposing should be the behaviour here? What this
> statement seems to be saying is that QEMU as it exists today only
> describes the first CPU in DSDT.

This confuses me somewhat, because I'm far from sure which machines this
is true for in QEMU.  I'm guessing it's a legacy thing with
some old distro version of QEMU - so we'll have to paper over it anyway
but for current QEMU I'm not sure it's true.

Helpfully there are a bunch of ACPI table tests so I've been checking
through all the multi CPU cases.

CPU hotplug not enabled.
pc/DSDT.dimmpxm  - 4x Processor entries.  -smp 4
pc/DSDT.acpihmat - 2x Processor entries.  -smp 2
q35/DSDT.acpihmat - 2x Processor entries. -smp 2
virt/DSDT.acpihmatvirt - 4x ACPI0007 entries -smp 4
q35/DSDT.acpihmat-noinitiator - 4 x Processor () entries -smp 4=20
virt/DSDT.topology - 8x ACPI0007 entries

I've also looked at the code and we have various types of
CPU hotplug on x86 but they all build appropriate numbers of
Processor() entries in DSDT.
Arm likewise seems to build the right number of ACPI0007 entries
(and doesn't yet have CPU HP support).

If anyone can add a reference on why this is needed that would be very
helpful.

>=20
> As this patch series changes when arch_register_cpu() gets called (as
> described in the paragraph above) we obviously need to preserve the
> _existing_ behaviour to avoid causing regressions. So, if changing the
> kernel causes user visible regressions (e.g. sysfs entries to
> disappear) then it obviously _is_ a kernel problem that needs to be
> solved.
>=20
> We can't say "well fix QEMU then" without invoking the wrath of Linus.

Overall I'm fine with the defensive nature of this patch as there
'might' be firmware out there with this problem - I just can't establish
that there is!  If anyone else recalls the history of this then give
a shout.  I vaguely wondered if this was an ia64 thing but nope, QEMU
never generated tables for ia64 before dropping support back in QEMU 2.11


>=20
> > > Signed-off-by: James Morse <james.morse@arm.com>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Reviewed-by: Gavin Shan <gshan@redhat.com>
> > > Tested-by: Miguel Luis <miguel.luis@oracle.com>
> > > Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> > > Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > ---
> > >  drivers/acpi/acpi_processor.c | 19 +++++++++++++++++++
> > >  1 file changed, 19 insertions(+)
> > >
> > > diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_proces=
sor.c
> > > index 6a542e0ce396..0511f2bc10bc 100644
> > > --- a/drivers/acpi/acpi_processor.c
> > > +++ b/drivers/acpi/acpi_processor.c
> > > @@ -791,6 +791,25 @@ void __init acpi_processor_init(void)
> > >         acpi_pcc_cpufreq_init();
> > >  }
> > >
> > > +static int __init acpi_processor_register_missing_cpus(void)
> > > +{
> > > +       int cpu;
> > > +
> > > +       if (acpi_disabled)
> > > +               return 0;
> > > +
> > > +       for_each_online_cpu(cpu) {
> > > +               if (!get_cpu_device(cpu)) {
> > > +                       pr_err_once(FW_BUG "CPU %u has no ACPI namesp=
ace description!\n", cpu);
> > > +                       add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_=
STILL_OK);
> > > +                       arch_register_cpu(cpu); =20
> >=20
> > Which part of this code is related to ACPI? =20
>=20
> That's a good question, and I suspect it would be more suited to being
> placed in drivers/base/cpu.c except for the problem that the error
> message refers to ACPI.
>=20
> As long as we keep the acpi_disabled test, I guess that's fine.
> cpu_dev_register_generic() there already tests acpi_disabled.
>=20
Moving it seems fine to me.

Jonathan


