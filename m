Return-Path: <linux-arch+bounces-1350-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BDB82B46B
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jan 2024 18:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D01E1F2393E
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jan 2024 17:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDFC52F90;
	Thu, 11 Jan 2024 17:59:16 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F05852F6A;
	Thu, 11 Jan 2024 17:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T9snT06zPz6J6XT;
	Fri, 12 Jan 2024 01:57:17 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 48896140595;
	Fri, 12 Jan 2024 01:59:10 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 11 Jan
 2024 17:59:09 +0000
Date: Thu, 11 Jan 2024 17:59:08 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Russell King <rmk+kernel@armlinux.org.uk>, <linux-pm@vger.kernel.org>,
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
Message-ID: <20240111175908.00002f46@Huawei.com>
In-Reply-To: <CAJZ5v0iB0bS6nmjQ++pV1zp5YSGuigbffK5VD3wsX+8bY9MA5w@mail.gmail.com>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
	<E1rDOfx-00Dvje-MS@rmk-PC.armlinux.org.uk>
	<CAJZ5v0iB0bS6nmjQ++pV1zp5YSGuigbffK5VD3wsX+8bY9MA5w@mail.gmail.com>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 18 Dec 2023 21:17:34 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Wed, Dec 13, 2023 at 1:49=E2=80=AFPM Russell King <rmk+kernel@armlinux=
.org.uk> wrote:
> >
> > From: James Morse <james.morse@arm.com>

Done some digging + machine faking.  This is mid stage results at best.

Summary: I don't think this patch is necessary.  If anyone happens to be in
the mood for testing on various platforms, can you drop this patch and
see if everything still works.

With this patch in place, and a processor container containing
Processor() objects acpi_process_add is called twice - once via
the path added here and once via acpi_bus_attach etc.

Maybe it's a left over from earlier approaches to some of this?


> >
> > ACPI has two ways of describing processors in the DSDT. From ACPI v6.5,
> > 5.2.12:
> >
> > "Starting with ACPI Specification 6.3, the use of the Processor() object
> > was deprecated. Only legacy systems should continue with this usage. On
> > the Itanium architecture only, a _UID is provided for the Processor()
> > that is a string object. This usage of _UID is also deprecated since it
> > can preclude an OSPM from being able to match a processor to a
> > non-enumerable device, such as those defined in the MADT. From ACPI
> > Specification 6.3 onward, all processor objects for all architectures
> > except Itanium must now use Device() objects with an _HID of ACPI0007,
> > and use only integer _UID values."

Well, we definitely don't care about Itanium any more so most of this is ir=
relevant
and can be scrubbed going forwards!

Otherwise I think we only care about Device() and Processor() being two thi=
ngs
that might be seen to describe CPUs and they may or may not be in a
Processor container.

> >
> > Also see https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and=
_Control.html#declaring-processors
> >
> > Duplicate descriptions are not allowed, the ACPI processor driver alrea=
dy
> > parses the UID from both devices and containers. acpi_processor_get_inf=
o()
> > returns an error if the UID exists twice in the DSDT. =20
>=20
> I'm not really sure how the above is related to the actual patch.

This is nasty.  They key is that with this patch in place, we are actually
adding them twice if they are are instantiated via Processor() in a process=
or
container.  So this reference is explaining why we don't get two lots regis=
tered.

This patch should call out explicitly why we want to do it twice
(I'm assuming on a temporary baseis).

>=20
> > The missing probe for CPUs described as packages =20
>=20
> It is unclear what exactly is meant by "CPUs described as packages".
>=20
> From the patch, it looks like those would be Processor() objects
> defined under a processor container device.
Agreed.

>=20
> > creates a problem for
> > moving the cpu_register() calls into the acpi_processor driver, as CPUs
> > described like this don't get registered, leading to errors from other
> > subsystems when they try to add new sysfs entries to the CPU node.
> > (e.g. topology_sysfs_init()'s use of topology_add_dev() via cpuhp)
> >
> > To fix this, parse the processor container and call acpi_processor_add()
> > for each processor that is discovered like this. =20
>=20
> Discovered like what?
Doesn't add any info.

"To fix this, parse the processor container and call acpi_processor_add() f=
or
each processor found."

>=20
> > The processor container
> > handler is added with acpi_scan_add_handler(), so no detach call will
> > arrive. =20
>=20
> The above requires clarification too.
>=20
> > Qemu TCG describes CPUs using processor devices in a processor containe=
r.

Hmm. This isn't so clear cut.

For ARM it does it nicely with ACPI0007 etc. For x86 it is still
Processor() under some circumstances... (why exactly doesn't matter here
- it's all legacy mess).

To poke this I hacked the arm virt qemu platform to use Processor() in a
container so I could like for like comparisons.

The logic that injects a HID into Processor() objects means the existing
handlers get fired without this patch.  I'm going to assume that might
not be the case later in this patch set, but I've not found where it
is broken yet :(


> > For more information, see build_cpus_aml() in Qemu hw/acpi/cpu.c and
> > https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.=
html#processor-container-device
> >
> > Signed-off-by: James Morse <james.morse@arm.com>
> > Tested-by: Miguel Luis <miguel.luis@oracle.com>
> > Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> > Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> > ---
> > Outstanding comments:
> >  https://lore.kernel.org/r/20230914145353.000072e2@Huawei.com
> >  https://lore.kernel.org/r/50571c2f-aa3c-baeb-3add-cd59e0eddc02@redhat.=
com
> > ---
> >  drivers/acpi/acpi_processor.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processo=
r.c
> > index 4fe2ef54088c..6a542e0ce396 100644
> > --- a/drivers/acpi/acpi_processor.c
> > +++ b/drivers/acpi/acpi_processor.c
> > @@ -626,9 +626,31 @@ static struct acpi_scan_handler processor_handler =
=3D {
> >         },
> >  };
> >
> > +static acpi_status acpi_processor_container_walk(acpi_handle handle,
> > +                                                u32 lvl,
> > +                                                void *context,
> > +                                                void **rv)
> > +{
> > +       struct acpi_device *adev;
> > +       acpi_status status;
> > +
> > +       adev =3D acpi_get_acpi_dev(handle);
> > +       if (!adev)
> > +               return AE_ERROR; =20
>=20
> Why is the reference counting needed here?
>=20
> Wouldn't acpi_fetch_acpi_dev() suffice?
You are the expert here :)  I can't see why the reference is needed
so would be fine with dropping it.

>=20
> Also, should the walk really be terminated on the first error?

If this patch makes sense things will probably blow up later but no
worse than before so sure, keep going.

>=20
> > +
> > +       status =3D acpi_processor_add(adev, &processor_device_ids[0]);
> > +       acpi_put_acpi_dev(adev);
> > +
> > +       return status;
> > +}
> > +
> >  static int acpi_processor_container_attach(struct acpi_device *dev,
> >                                            const struct acpi_device_id =
*id)
> >  {
> > +       acpi_walk_namespace(ACPI_TYPE_PROCESSOR, dev->handle,
> > +                           ACPI_UINT32_MAX, acpi_processor_container_w=
alk,
> > +                           NULL, NULL, NULL); =20
>=20
> This covers processor objects only, so why is this not needed for
> processor devices defined under a processor container object?

Both cases are covered by the existing handling without this.

I'm far from clear on why we need this patch.  Presumably
it's the reference in the description on it breaking for
Processor Package containing Processor() objects that matters
after a move... I'm struggling to find that move though!



>=20
> It is not obvious, so it would be nice to add a comment explaining the
> difference.
>=20
> > +
> >         return 1;
> >  }
> >
> > -- =20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


