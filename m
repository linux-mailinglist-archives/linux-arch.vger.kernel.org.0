Return-Path: <linux-arch+bounces-4064-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1442F8B706E
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2024 12:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3852285847
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2024 10:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F6512C7FA;
	Tue, 30 Apr 2024 10:45:41 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F0D12C530;
	Tue, 30 Apr 2024 10:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714473941; cv=none; b=hDvxBB5qZ8/2KSNa/TK8ImjAXzS4k40IefGP1YpNJUkBXPKIbolQ+2xxxoa8RTHhknFdS3SKoXafQGg6OwjG7kf0HdXKif6WLSzl5FgwirYpBllF2dkt5cdJtDV3TAoDJ8/p40IdH1w9jU4RVxV+fh0MDcECVCaX5GcA55MR/4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714473941; c=relaxed/simple;
	bh=8UiQvrMBFWHfk3jz4LDaQ1Ux2UhIMOTbXigwIyYX8UE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OOPzzY5xAG8u0zDVizxkwfDO0nLSn4SNzTF/2TiANCrz1Q0MhJ0f96wHuZMJweDtjRQuhzIdVbbArC9mL09KQT4HQi48N0ooS0d0ZdnMG44EvriwigrU41ZMDW2WVMUZKOuXklD3OG3KSfq7GqCYUNikrl8YjdqWKtAyejQfNhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VTGxW6T5Sz6J74t;
	Tue, 30 Apr 2024 18:42:55 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3BD24140B3C;
	Tue, 30 Apr 2024 18:45:36 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 30 Apr
 2024 11:45:35 +0100
Date: Tue, 30 Apr 2024 11:45:34 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Gavin Shan <gshan@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>, <linux-pm@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, Russell King <linux@armlinux.org.uk>, Miguel Luis
	<miguel.luis@oracle.com>, James Morse <james.morse@arm.com>, Salil Mehta
	<salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <linuxarm@huawei.com>, <justin.he@arm.com>,
	<jianyong.wu@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, "Sudeep
 Holla" <sudeep.holla@arm.com>
Subject: Re: [PATCH v8 04/16] ACPI: processor: Move checks and availability
 of acpi_processor earlier
Message-ID: <20240430114534.0000600e@huawei.com>
In-Reply-To: <CAJZ5v0i5jpJswD7KV5RPm_HvzB+B=Rt3gY0s_Z3fn5wbJz0ebw@mail.gmail.com>
References: <20240426135126.12802-1-Jonathan.Cameron@huawei.com>
	<20240426135126.12802-5-Jonathan.Cameron@huawei.com>
	<80a2e07f-ecb2-48af-b2be-646f17e0e63e@redhat.com>
	<20240430102838.00006e04@Huawei.com>
	<20240430111341.00003dba@huawei.com>
	<CAJZ5v0i5jpJswD7KV5RPm_HvzB+B=Rt3gY0s_Z3fn5wbJz0ebw@mail.gmail.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 30 Apr 2024 12:17:38 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Tue, Apr 30, 2024 at 12:13=E2=80=AFPM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Tue, 30 Apr 2024 10:28:38 +0100
> > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > =20
> > > On Tue, 30 Apr 2024 14:17:24 +1000
> > > Gavin Shan <gshan@redhat.com> wrote:
> > > =20
> > > > On 4/26/24 23:51, Jonathan Cameron wrote: =20
> > > > > Make the per_cpu(processors, cpu) entries available earlier so th=
at
> > > > > they are available in arch_register_cpu() as ARM64 will need acce=
ss
> > > > > to the acpi_handle to distinguish between acpi_processor_add()
> > > > > and earlier registration attempts (which will fail as _STA cannot
> > > > > be checked).
> > > > >
> > > > > Reorder the remove flow to clear this per_cpu() after
> > > > > arch_unregister_cpu() has completed, allowing it to be used in
> > > > > there as well.
> > > > >
> > > > > Note that on x86 for the CPU hotplug case, the pr->id prior to
> > > > > acpi_map_cpu() may be invalid. Thus the per_cpu() structures
> > > > > must be initialized after that call or after checking the ID
> > > > > is valid (not hotplug path).
> > > > >
> > > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > >
> > > > > ---
> > > > > v8: On buggy bios detection when setting per_cpu structures
> > > > >      do not carry on.
> > > > >      Fix up the clearing of per cpu structures to remove unwanted
> > > > >      side effects and ensure an error code isn't use to reference=
 them.
> > > > > ---
> > > > >   drivers/acpi/acpi_processor.c | 79 +++++++++++++++++++++-------=
-------
> > > > >   1 file changed, 48 insertions(+), 31 deletions(-)
> > > > >
> > > > > diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_pr=
ocessor.c
> > > > > index ba0a6f0ac841..3b180e21f325 100644
> > > > > --- a/drivers/acpi/acpi_processor.c
> > > > > +++ b/drivers/acpi/acpi_processor.c
> > > > > @@ -183,8 +183,38 @@ static void __init acpi_pcc_cpufreq_init(voi=
d) {}
> > > > >   #endif /* CONFIG_X86 */
> > > > >
> > > > >   /* Initialization */
> > > > > +static DEFINE_PER_CPU(void *, processor_device_array);
> > > > > +
> > > > > +static bool acpi_processor_set_per_cpu(struct acpi_processor *pr,
> > > > > +                                struct acpi_device *device)
> > > > > +{
> > > > > + BUG_ON(pr->id >=3D nr_cpu_ids); =20
> > > >
> > > > One blank line after BUG_ON() if we need to follow original impleme=
ntation. =20
> > >
> > > Sure unintentional - I'll put that back.
> > > =20
> > > > =20
> > > > > + /*
> > > > > +  * Buggy BIOS check.
> > > > > +  * ACPI id of processors can be reported wrongly by the BIOS.
> > > > > +  * Don't trust it blindly
> > > > > +  */
> > > > > + if (per_cpu(processor_device_array, pr->id) !=3D NULL &&
> > > > > +     per_cpu(processor_device_array, pr->id) !=3D device) {
> > > > > +         dev_warn(&device->dev,
> > > > > +                  "BIOS reported wrong ACPI id %d for the proces=
sor\n",
> > > > > +                  pr->id);
> > > > > +         /* Give up, but do not abort the namespace scan. */ =20
> > > >
> > > > It depends on how the return value is handled by the caller if the =
namespace
> > > > is continued to be scanned. The caller can be acpi_processor_hotadd=
_init()
> > > > and acpi_processor_get_info() after this patch is applied. So I thi=
nk this
> > > > specific comment need to be moved to the caller. =20
> > >
> > > Good point. This gets messy and was an unintended change.
> > >
> > > Previously the options were:
> > > 1) acpi_processor_get_info() failed for other reasons - this code was=
 never called.
> > > 2) acpi_processor_get_info() succeeded without acpi_processor_hotadd_=
init (non hotplug)
> > >    this code then ran and would paper over the problem doing a bunch =
of cleanup under err.
> > > 3) acpi_processor_get_info() succeeded with acpi_processor_hotadd_ini=
t called.
> > >    This code then ran and would paper over the problem doing a bunch =
of cleanup under err.
> > >
> > > We should maintain that or argue cleanly against it.
> > >
> > > This isn't helped the the fact I have no idea which cases we care abo=
ut for that bios
> > > bug handling.  Do any of those bios's ever do hotplug?  Guess we have=
 to try and maintain
> > > whatever protection this was offering.
> > >
> > > Also, the original code leaks data in some paths and I have limited i=
dea
> > > of whether it is intentional or not. So to tidy the issue up that you=
've identified
> > > I'll need to try and make that code consistent first.
> > >
> > > I suspect the only way to do that is going to be to duplicate the all=
ocations we
> > > 'want' to leak to deal with the bios bug detection.
> > >
> > > For example acpi_processor_get_info() failing leaks pr and pr->thrott=
ling.shared_cpu_map
> > > before this series. After this series we need pr to leak because it's=
 used for the detection
> > > via processor_device_array.
> > >
> > > I'll work through this but it's going to be tricky to tell if we get =
right.
> > > Step 1 will be closing the existing leaks and then we will have somet=
hing
> > > consistent to build on.
> > > =20
> > I 'think' that fixing the original leaks makes this all much more strai=
ght forward.
> > That return 0 for acpi_processor_get_info() never made sense as far as =
I can tell.
> > The pr isn't used after this point.
> >
> > What about something along lines of.
> >
> > diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processo=
r.c
> > index 161c95c9d60a..97cff4492304 100644
> > --- a/drivers/acpi/acpi_processor.c
> > +++ b/drivers/acpi/acpi_processor.c
> > @@ -392,8 +392,10 @@ static int acpi_processor_add(struct acpi_device *=
device,
> >         device->driver_data =3D pr;
> >
> >         result =3D acpi_processor_get_info(device);
> > -       if (result) /* Processor is not physically present or unavailab=
le */
> > -               return 0;
> > +       if (result) { /* Processor is not physically present or unavail=
able */
> > +               result =3D 0; =20
>=20
> As per my previous message (just sent) this should be an error code,
> as returning 0 from acpi_processor_add() is generally problematic.
Ok. I'll switch to that, but as a separate precusor patch. Independent of
the memory leak fixes.

Jonathan

>=20
> > +               goto err_free_throttling_mask;
> > +       }
> >
> >         BUG_ON(pr->id >=3D nr_cpu_ids);
> > =20


