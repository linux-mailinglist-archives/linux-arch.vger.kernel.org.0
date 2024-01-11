Return-Path: <linux-arch+bounces-1349-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD1A82B2A6
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jan 2024 17:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 921211C2345D
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jan 2024 16:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF7C4EB2C;
	Thu, 11 Jan 2024 16:17:14 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C47751C48;
	Thu, 11 Jan 2024 16:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T9qW95bKGz6D8jQ;
	Fri, 12 Jan 2024 00:14:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id BAB0D1400CB;
	Fri, 12 Jan 2024 00:17:08 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 11 Jan
 2024 16:17:08 +0000
Date: Thu, 11 Jan 2024 16:17:07 +0000
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
Subject: Re: [PATCH RFC v3 02/21] ACPI: processor: Add support for
 processors described as container packages
Message-ID: <20240111161707.000059f6@Huawei.com>
In-Reply-To: <ZZ1woQkpMMCWVnXc@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
	<E1rDOfx-00Dvje-MS@rmk-PC.armlinux.org.uk>
	<CAJZ5v0iB0bS6nmjQ++pV1zp5YSGuigbffK5VD3wsX+8bY9MA5w@mail.gmail.com>
	<ZZ1q+7GXqnMMwKNR@shell.armlinux.org.uk>
	<CAJZ5v0jvuTAMak-x=ekphwgNsUWABGRcDPb8D4QB=KhfyC76Sg@mail.gmail.com>
	<ZZ1woQkpMMCWVnXc@shell.armlinux.org.uk>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 9 Jan 2024 16:13:21 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Tue, Jan 09, 2024 at 05:05:15PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Jan 9, 2024 at 4:49=E2=80=AFPM Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote: =20
> > >
> > > On Mon, Dec 18, 2023 at 09:17:34PM +0100, Rafael J. Wysocki wrote: =20
> > > > On Wed, Dec 13, 2023 at 1:49=E2=80=AFPM Russell King <rmk+kernel@ar=
mlinux.org.uk> wrote: =20
> > > > >
> > > > > From: James Morse <james.morse@arm.com>
> > > > >
> > > > > ACPI has two ways of describing processors in the DSDT. From ACPI=
 v6.5,
> > > > > 5.2.12:
> > > > >
> > > > > "Starting with ACPI Specification 6.3, the use of the Processor()=
 object
> > > > > was deprecated. Only legacy systems should continue with this usa=
ge. On
> > > > > the Itanium architecture only, a _UID is provided for the Process=
or()
> > > > > that is a string object. This usage of _UID is also deprecated si=
nce it
> > > > > can preclude an OSPM from being able to match a processor to a
> > > > > non-enumerable device, such as those defined in the MADT. From AC=
PI
> > > > > Specification 6.3 onward, all processor objects for all architect=
ures
> > > > > except Itanium must now use Device() objects with an _HID of ACPI=
0007,
> > > > > and use only integer _UID values."
> > > > >
> > > > > Also see https://uefi.org/specs/ACPI/6.5/08_Processor_Configurati=
on_and_Control.html#declaring-processors
> > > > >
> > > > > Duplicate descriptions are not allowed, the ACPI processor driver=
 already
> > > > > parses the UID from both devices and containers. acpi_processor_g=
et_info()
> > > > > returns an error if the UID exists twice in the DSDT. =20
> > > >
> > > > I'm not really sure how the above is related to the actual patch.
> > > > =20
> > > > > The missing probe for CPUs described as packages =20
> > > >
> > > > It is unclear what exactly is meant by "CPUs described as packages".
> > > >
> > > > From the patch, it looks like those would be Processor() objects
> > > > defined under a processor container device.
> > > > =20
> > > > > creates a problem for
> > > > > moving the cpu_register() calls into the acpi_processor driver, a=
s CPUs
> > > > > described like this don't get registered, leading to errors from =
other
> > > > > subsystems when they try to add new sysfs entries to the CPU node.
> > > > > (e.g. topology_sysfs_init()'s use of topology_add_dev() via cpuhp)
> > > > >
> > > > > To fix this, parse the processor container and call acpi_processo=
r_add()
> > > > > for each processor that is discovered like this. =20
> > > >
> > > > Discovered like what?
> > > > =20
> > > > > The processor container
> > > > > handler is added with acpi_scan_add_handler(), so no detach call =
will
> > > > > arrive. =20
> > > >
> > > > The above requires clarification too. =20
> > >
> > > The above comments... yea. As I didn't write the commit description, =
but
> > > James did, and James has basically vanished, I don't think these can =
be
> > > answered, short of rewriting the entire commit message, with me spend=
ing
> > > a lot of time with the ACPI specification trying to get the terminolo=
gy
> > > right - because at lot of the above on the face of it seems to be thi=
ngs
> > > to do with wrong terminology being used.
> > >
> > > I wasn't expecting this level of issues with this patch set, and I now
> > > feel completely out of my depth with this series. I'm wondering wheth=
er
> > > I should even continue with it, since I don't have the ACPI knowledge
> > > to address a lot of these comments. =20
> >=20
> > Well, sorry about this.
> >=20
> > I met James at the LPC last year, so he seems to be still around, in
> > some way at least.. =20
>=20
> On the previous posting, I wanted James to comment on some of the
> feedback from Jonathan, and despite explicitly asking, there has been
> nothing but radio silence ever since James' last post of this series.
>=20
> So, I now deem this work to be completely dead in the water, and not
> going to happen - not unless others can input on your comments.
>=20
I'll take another pass at this and see which comments I can resolve.
Will need a few additional test setups so may take a few days.

So far I've established that QEMU uses Processor for x86 and
ACPI0007 for arm64.  Goody, at least that simplifies testing
the various options.

Jonathan


