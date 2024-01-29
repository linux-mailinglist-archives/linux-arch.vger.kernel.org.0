Return-Path: <linux-arch+bounces-1761-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA158405F1
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 14:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13F5C281AAD
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 13:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334B361688;
	Mon, 29 Jan 2024 13:04:02 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57795627E5;
	Mon, 29 Jan 2024 13:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706533442; cv=none; b=jJjV3NWEqLWsYgcvUYko8/sJNs+W3LbyvN/MipSd2Xb3/CkzmUBJix8MyG1lYJtv78nma+SOqBk38aOr0szq0a1HmJN0ZO1Gn/qpjBmo6pRfrTG2uHesU6MKADlB+fdRljvRNSijJu5/BZr8tO1J0S1a7wrtVqzPRWiO+6k+g7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706533442; c=relaxed/simple;
	bh=MW5KypFg1nPfOH+4Z7+YG9/XkLK+cVPVSXFwwG/gf9E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hl2CS7t2n56jw+0eeN2dUSa7casXH90d43P9jwfty0SuDl2nEQx4vl2QIh9jVYJYPow71gpQ9jlYCaCd8+r2YZFla0GK4qcDlwLBvpfYCCHdhV15xhKGkRJASD9hYmZ6MkRn6BbHnOOOs1OBIv9aa8R6I8oRSgJTCqe+z6q9cDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TNpM75yZdz6K9JK;
	Mon, 29 Jan 2024 21:00:51 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8F10A140A1B;
	Mon, 29 Jan 2024 21:03:55 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Jan
 2024 13:03:54 +0000
Date: Mon, 29 Jan 2024 13:03:54 +0000
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
Message-ID: <20240129130354.0000042b@Huawei.com>
In-Reply-To: <20240123092725.00004382@Huawei.com>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
	<E1rDOg2-00Dvjk-RI@rmk-PC.armlinux.org.uk>
	<CAJZ5v0ju1JHgpjuFLHZVs4NZiARG6iBZN_wza6c2e0kDhZjK0w@mail.gmail.com>
	<ZaURtUvWQyjYfiiO@shell.armlinux.org.uk>
	<20240122160227.00002d83@Huawei.com>
	<CAJZ5v0hamuXJ_w-TSmVb=5jGide=Lb7sCjbzzNb_rFuPrvkgxQ@mail.gmail.com>
	<Za6mHRJVjb6M1mun@shell.armlinux.org.uk>
	<20240123092725.00004382@Huawei.com>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 23 Jan 2024 09:27:25 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 22 Jan 2024 17:30:05 +0000
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
>=20
> > On Mon, Jan 22, 2024 at 05:22:46PM +0100, Rafael J. Wysocki wrote: =20
> > > On Mon, Jan 22, 2024 at 5:02=E2=80=AFPM Jonathan Cameron
> > > <Jonathan.Cameron@huawei.com> wrote:   =20
> > > >
> > > > On Mon, 15 Jan 2024 11:06:29 +0000
> > > > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > > >   =20
> > > > > On Mon, Dec 18, 2023 at 09:22:03PM +0100, Rafael J. Wysocki wrote=
:   =20
> > > > > > On Wed, Dec 13, 2023 at 1:49=E2=80=AFPM Russell King <rmk+kerne=
l@armlinux.org.uk> wrote:   =20
> > > > > > >
> > > > > > > From: James Morse <james.morse@arm.com>
> > > > > > >
> > > > > > > ACPI has two descriptions of CPUs, one in the MADT/APIC table=
, the other
> > > > > > > in the DSDT. Both are required. (ACPI 6.5's 8.4 "Declaring Pr=
ocessors"
> > > > > > > says "Each processor in the system must be declared in the AC=
PI
> > > > > > > namespace"). Having two descriptions allows firmware authors =
to get
> > > > > > > this wrong.
> > > > > > >
> > > > > > > If CPUs are described in the MADT/APIC, they will be brought =
online
> > > > > > > early during boot. Once the register_cpu() calls are moved to=
 ACPI,
> > > > > > > they will be based on the DSDT description of the CPUs. When =
CPUs are
> > > > > > > missing from the DSDT description, they will end up online, b=
ut not
> > > > > > > registered.
> > > > > > >
> > > > > > > Add a helper that runs after acpi_init() has completed to reg=
ister
> > > > > > > CPUs that are online, but weren't found in the DSDT. Any CPU =
that
> > > > > > > is registered by this code triggers a firmware-bug warning an=
d kernel
> > > > > > > taint.
> > > > > > >
> > > > > > > Qemu TCG only describes the first CPU in the DSDT, unless cpu=
-hotplug
> > > > > > > is configured.   =20
> > > > > >
> > > > > > So why is this a kernel problem?   =20
> > > > >
> > > > > So what are you proposing should be the behaviour here? What this
> > > > > statement seems to be saying is that QEMU as it exists today only
> > > > > describes the first CPU in DSDT.   =20
> > > >
> > > > This confuses me somewhat, because I'm far from sure which machines=
 this
> > > > is true for in QEMU.  I'm guessing it's a legacy thing with
> > > > some old distro version of QEMU - so we'll have to paper over it an=
yway
> > > > but for current QEMU I'm not sure it's true.
> > > >
> > > > Helpfully there are a bunch of ACPI table tests so I've been checki=
ng
> > > > through all the multi CPU cases.
> > > >
> > > > CPU hotplug not enabled.
> > > > pc/DSDT.dimmpxm  - 4x Processor entries.  -smp 4
> > > > pc/DSDT.acpihmat - 2x Processor entries.  -smp 2
> > > > q35/DSDT.acpihmat - 2x Processor entries. -smp 2
> > > > virt/DSDT.acpihmatvirt - 4x ACPI0007 entries -smp 4
> > > > q35/DSDT.acpihmat-noinitiator - 4 x Processor () entries -smp 4
> > > > virt/DSDT.topology - 8x ACPI0007 entries
> > > >
> > > > I've also looked at the code and we have various types of
> > > > CPU hotplug on x86 but they all build appropriate numbers of
> > > > Processor() entries in DSDT.
> > > > Arm likewise seems to build the right number of ACPI0007 entries
> > > > (and doesn't yet have CPU HP support).
> > > >
> > > > If anyone can add a reference on why this is needed that would be v=
ery
> > > > helpful.   =20
> > >=20
> > > Yes, it would.
> > >=20
> > > Personally, I would prefer to assume that it is not necessary until it
> > > turns out that (1) there is firmware with this issue actually in use
> > > and (2) updating the firmware in question to follow the specification
> > > is not practical.
> > >=20
> > > Otherwise, we'd make it easier to ship non-compliant firmware for no
> > > good reason.   =20
> >=20
> > If Salil can't come up with a reason, then I'm in favour of dropping
> > the patch like already done for patch 2. If the code change serves no
> > useful purpose, there's no point in making the change.
> >  =20
>=20
> Salil's out today, but I've messaged him to follow up later in the week.
>=20
> It 'might' be the odd cold plug path where QEMU half comes up, then extra
> CPUs are added, then it boots. (used by some orchestration frameworks)

I poked this on x86 - it only applies with hotplug enabled anyway so
same result as doing the hotplug later - All possible Processor() entries
already exist in DSDT. Hence this isn't the source of the mysterious
broken configuration.

If anyone does poke this path, the old discussion between James
and Salil provides some instructions (mostly the thread is about
another issue).
https://op-lists.linaro.org/archives/list/linaro-open-discussions@op-lists.=
linaro.org/thread/DNAGB2FB5ALVLV2BYWYOCLKGNF77PNXS/

Also on x86 a test involving smp 2,max-cpus=3D4 and adding cpu-id 3
(so skipping 2) doesn't boot. (this is without Salil's QEMU patches).
I guess there are some well known rules in there that I don't know about
and QEMU isn't preventing people shooting themselves in the foot.

As I'm concerned, drop this patch.
If there are platforms out there doing this wrong they'll surface once
we get this into more test farms (so linux-next).  If we need this
'fix' we can apply it when we have a problem firmware to point at.

Thanks,

Jonathan

> I don't have a set up for that and I won't get to creating one today anyw=
ay
> (we all love start of the year planning workshops!)

>=20
> I've +CC'd a few people have run tests on the various iterations of this
> work in the past.  Maybe one of them can shed some light on this?
>=20
> Jonathan
>=20
>=20
>=20
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


