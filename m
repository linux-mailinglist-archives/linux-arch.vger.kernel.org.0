Return-Path: <linux-arch+bounces-1438-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D66838A44
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 10:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C5EC1F237D5
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 09:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AC959143;
	Tue, 23 Jan 2024 09:27:32 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4078059B4A;
	Tue, 23 Jan 2024 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706002052; cv=none; b=KXTmKcrPZMC7467urmHRikfGdT6qL2NMUbBUAOX++bb0lVUYCdjfz7qhJYcrqAEK5kYZNdV3HH8yku6jCfv0/ZVRInYA7FdsryA8miZ7jrpxdxcTiPn1Pinmzlouxumc83euLjX5qyzXNSAU2xVVb/o9r/0tAapIn1inV5Vf4hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706002052; c=relaxed/simple;
	bh=G0yzi1lG3fmcjNl/RGBz0t5QUu3R0RD1gtXtI6hWloQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GBjKR0ha1er+wuv6XsA0lRlisBqjMfFZnlRSx+1+OyTjIVVkKkXyZVbTOtbuO+XVvpSmtmHKA1xPK/WDy4KpiWK9wE9n42YPYE3kej1w3bdhyh0zeHjWXao9mtcRYbSiPePJKKcaUe2j0KlAoaoaM+G7ZdWDgrTGcxzG8wqSNeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TK1rm0gmyz6K6JX;
	Tue, 23 Jan 2024 17:24:56 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9EBF81406AD;
	Tue, 23 Jan 2024 17:27:26 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Jan
 2024 09:27:26 +0000
Date: Tue, 23 Jan 2024 09:27:25 +0000
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
	<justin.he@arm.com>, James Morse <james.morse@arm.com>,
	<vishnu@os.amperecomputing.com>, <miguel.luis@oracle.com>
Subject: Re: [PATCH RFC v3 03/21] ACPI: processor: Register CPUs that are
 online, but not described in the DSDT
Message-ID: <20240123092725.00004382@Huawei.com>
In-Reply-To: <Za6mHRJVjb6M1mun@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
	<E1rDOg2-00Dvjk-RI@rmk-PC.armlinux.org.uk>
	<CAJZ5v0ju1JHgpjuFLHZVs4NZiARG6iBZN_wza6c2e0kDhZjK0w@mail.gmail.com>
	<ZaURtUvWQyjYfiiO@shell.armlinux.org.uk>
	<20240122160227.00002d83@Huawei.com>
	<CAJZ5v0hamuXJ_w-TSmVb=5jGide=Lb7sCjbzzNb_rFuPrvkgxQ@mail.gmail.com>
	<Za6mHRJVjb6M1mun@shell.armlinux.org.uk>
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
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 22 Jan 2024 17:30:05 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Mon, Jan 22, 2024 at 05:22:46PM +0100, Rafael J. Wysocki wrote:
> > On Mon, Jan 22, 2024 at 5:02=E2=80=AFPM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote: =20
> > >
> > > On Mon, 15 Jan 2024 11:06:29 +0000
> > > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > > =20
> > > > On Mon, Dec 18, 2023 at 09:22:03PM +0100, Rafael J. Wysocki wrote: =
=20
> > > > > On Wed, Dec 13, 2023 at 1:49=E2=80=AFPM Russell King <rmk+kernel@=
armlinux.org.uk> wrote: =20
> > > > > >
> > > > > > From: James Morse <james.morse@arm.com>
> > > > > >
> > > > > > ACPI has two descriptions of CPUs, one in the MADT/APIC table, =
the other
> > > > > > in the DSDT. Both are required. (ACPI 6.5's 8.4 "Declaring Proc=
essors"
> > > > > > says "Each processor in the system must be declared in the ACPI
> > > > > > namespace"). Having two descriptions allows firmware authors to=
 get
> > > > > > this wrong.
> > > > > >
> > > > > > If CPUs are described in the MADT/APIC, they will be brought on=
line
> > > > > > early during boot. Once the register_cpu() calls are moved to A=
CPI,
> > > > > > they will be based on the DSDT description of the CPUs. When CP=
Us are
> > > > > > missing from the DSDT description, they will end up online, but=
 not
> > > > > > registered.
> > > > > >
> > > > > > Add a helper that runs after acpi_init() has completed to regis=
ter
> > > > > > CPUs that are online, but weren't found in the DSDT. Any CPU th=
at
> > > > > > is registered by this code triggers a firmware-bug warning and =
kernel
> > > > > > taint.
> > > > > >
> > > > > > Qemu TCG only describes the first CPU in the DSDT, unless cpu-h=
otplug
> > > > > > is configured. =20
> > > > >
> > > > > So why is this a kernel problem? =20
> > > >
> > > > So what are you proposing should be the behaviour here? What this
> > > > statement seems to be saying is that QEMU as it exists today only
> > > > describes the first CPU in DSDT. =20
> > >
> > > This confuses me somewhat, because I'm far from sure which machines t=
his
> > > is true for in QEMU.  I'm guessing it's a legacy thing with
> > > some old distro version of QEMU - so we'll have to paper over it anyw=
ay
> > > but for current QEMU I'm not sure it's true.
> > >
> > > Helpfully there are a bunch of ACPI table tests so I've been checking
> > > through all the multi CPU cases.
> > >
> > > CPU hotplug not enabled.
> > > pc/DSDT.dimmpxm  - 4x Processor entries.  -smp 4
> > > pc/DSDT.acpihmat - 2x Processor entries.  -smp 2
> > > q35/DSDT.acpihmat - 2x Processor entries. -smp 2
> > > virt/DSDT.acpihmatvirt - 4x ACPI0007 entries -smp 4
> > > q35/DSDT.acpihmat-noinitiator - 4 x Processor () entries -smp 4
> > > virt/DSDT.topology - 8x ACPI0007 entries
> > >
> > > I've also looked at the code and we have various types of
> > > CPU hotplug on x86 but they all build appropriate numbers of
> > > Processor() entries in DSDT.
> > > Arm likewise seems to build the right number of ACPI0007 entries
> > > (and doesn't yet have CPU HP support).
> > >
> > > If anyone can add a reference on why this is needed that would be very
> > > helpful. =20
> >=20
> > Yes, it would.
> >=20
> > Personally, I would prefer to assume that it is not necessary until it
> > turns out that (1) there is firmware with this issue actually in use
> > and (2) updating the firmware in question to follow the specification
> > is not practical.
> >=20
> > Otherwise, we'd make it easier to ship non-compliant firmware for no
> > good reason. =20
>=20
> If Salil can't come up with a reason, then I'm in favour of dropping
> the patch like already done for patch 2. If the code change serves no
> useful purpose, there's no point in making the change.
>=20

Salil's out today, but I've messaged him to follow up later in the week.

It 'might' be the odd cold plug path where QEMU half comes up, then extra
CPUs are added, then it boots. (used by some orchestration frameworks)
I don't have a set up for that and I won't get to creating one today anyway
(we all love start of the year planning workshops!)

I've +CC'd a few people have run tests on the various iterations of this
work in the past.  Maybe one of them can shed some light on this?

Jonathan





