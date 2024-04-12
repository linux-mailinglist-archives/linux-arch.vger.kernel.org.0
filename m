Return-Path: <linux-arch+bounces-3645-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673498A36E1
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 22:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89DF51C21BF4
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 20:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE9B1514E0;
	Fri, 12 Apr 2024 20:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Kz3jwuZA"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE671509B9;
	Fri, 12 Apr 2024 20:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712952992; cv=none; b=hiFQYShFdBSoejhndpyD+qBIt58w5Yu2odu4EFRIqHhqHMj7hKGjNICKyIJ0NqossLXYZc3hkLRBchtcUMJ4y6fooMgngLDLGYjlJbRQjfoKKO+QTplCt2t99P4zZ6QhG+rs6SpFn0fJOGHylP9MQ2NXjgaPSsCj9ajSo/FcTbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712952992; c=relaxed/simple;
	bh=dKNPqsjHMrgzMlxgRL62bo+88LDPLk0E891/+IWrzZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eim8kR8nTyi46nwR8ybxxfUBofr9Tp6qo/SUxBh60c9ddhU/D/tO/XnARSKgYGLbifwbVyJ8Gf8lhjJimkqspt4DDcMpflEu6716INg9mSOxi/i9fDFztPNRo65mnR4TQXlAq3yBXoA/cxTGiFgpkamqWPrNDNgBxCacurQWQQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Kz3jwuZA; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZGFvoma46BCyiMvqt+9PA9y7NlciWRVDAvZYb656yOE=; b=Kz3jwuZAGR4BAUvKYthmWGt7zK
	86TtebZmpad+x2kmBlT0FQJRoroGh6xBN22wxTgWoYLN0QUU2TAEzf9wwYNt4VcwidIi1ZZP8NfV+
	wGEq98FH6Eh2SVV2bpMFHKawXebvQF+a00O0xwrlH2depUqecvkemMa9PnVaszuHfP2Hi3E45dxrz
	AP+SVehvxgJYoj1dijJpNlfLmOGXUNtMQcawDCre4DnDAqnatxi4EiF8s8fkacM9Ug42J7jL9F2e2
	Z1chwhvtUSuRrnUcSkOPknR5P7RuKcXEGmuFCijvvZ8TJDaH2mLZqPmud+uEsdsMjI8ivzWunEML1
	RnOAQEYA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52314)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rvNJr-0002wV-1V;
	Fri, 12 Apr 2024 21:16:19 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rvNJo-00086J-Cq; Fri, 12 Apr 2024 21:16:16 +0100
Date: Fri, 12 Apr 2024 21:16:16 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, x86@kernel.org,
	Miguel Luis <miguel.luis@oracle.com>,
	James Morse <james.morse@arm.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linuxarm@huawei.com,
	justin.he@arm.com, jianyong.wu@arm.com
Subject: Re: [PATCH v5 03/18] ACPI: processor: Register deferred CPUs from
 acpi_processor_get_info()
Message-ID: <ZhmWkE+fCEG/WFoi@shell.armlinux.org.uk>
References: <20240412143719.11398-1-Jonathan.Cameron@huawei.com>
 <20240412143719.11398-4-Jonathan.Cameron@huawei.com>
 <CAJZ5v0gNvy2e=hOGQQ2kLpnrDr8=QGBax-E5odEJ=7BA8qW-9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gNvy2e=hOGQQ2kLpnrDr8=QGBax-E5odEJ=7BA8qW-9A@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Apr 12, 2024 at 08:30:40PM +0200, Rafael J. Wysocki wrote:
> On Fri, Apr 12, 2024 at 4:38 PM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > From: James Morse <james.morse@arm.com>
> >
> > The arm64 specific arch_register_cpu() call may defer CPU registration
> > until the ACPI interpreter is available and the _STA method can
> > be evaluated.
> >
> > If this occurs, then a second attempt is made in
> > acpi_processor_get_info(). Note that the arm64 specific call has
> > not yet been added so for now this will never be successfully
> > called.
> >
> > Systems can still be booted with 'acpi=off', or not include an
> > ACPI description at all as in these cases arch_register_cpu()
> > will not have deferred registration when first called.
> >
> > This moves the CPU register logic back to a subsys_initcall(),
> > while the memory nodes will have been registered earlier.
> > Note this is where the call was prior to the cleanup series so
> > there should be no side effects of moving it back again for this
> > specific case.
> >
> > [PATCH 00/21] Initial cleanups for vCPU HP.
> > https://lore.kernel.org/all/ZVyz%2FVe5pPu8AWoA@shell.armlinux.org.uk/
> >
> > e.g. 5b95f94c3b9f ("x86/topology: Switch over to GENERIC_CPU_DEVICES")
> >
> > Signed-off-by: James Morse <james.morse@arm.com>
> > Reviewed-by: Gavin Shan <gshan@redhat.com>
> > Tested-by: Miguel Luis <miguel.luis@oracle.com>
> > Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> > Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Joanthan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > v5: Update commit message to make it clear this is moving the
> >     init back to where it was until very recently.
> >
> >     No longer change the condition in the earlier registration point
> >     as that will be handled by the arm64 registration routine
> >     deferring until called again here.
> > ---
> >  drivers/acpi/acpi_processor.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> > index 93e029403d05..c78398cdd060 100644
> > --- a/drivers/acpi/acpi_processor.c
> > +++ b/drivers/acpi/acpi_processor.c
> > @@ -317,6 +317,18 @@ static int acpi_processor_get_info(struct acpi_device *device)
> >
> >         c = &per_cpu(cpu_devices, pr->id);
> >         ACPI_COMPANION_SET(&c->dev, device);
> > +       /*
> > +        * Register CPUs that are present. get_cpu_device() is used to skip
> > +        * duplicate CPU descriptions from firmware.
> > +        */
> > +       if (!invalid_logical_cpuid(pr->id) && cpu_present(pr->id) &&
> > +           !get_cpu_device(pr->id)) {
> > +               int ret = arch_register_cpu(pr->id);
> > +
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> >         /*
> >          *  Extra Processor objects may be enumerated on MP systems with
> >          *  less than the max # of CPUs. They should be ignored _iff
> > --
> 
> I am still unsure why there need to be two paths calling
> arch_register_cpu() in acpi_processor_get_info().
> 
> Just below the comment partially pulled into the patch context above,
> there is this code:
> 
> if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
>          int ret = acpi_processor_hotadd_init(pr);
> 
>         if (ret)
>                 return ret;
> }
> 
> For the sake of the argument, fold acpi_processor_hotadd_init() into
> it and drop the redundant _STA check from it:
> 
> if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
>         if (invalid_phys_cpuid(pr->phys_id))
>                 return -ENODEV;
> 
>         cpu_maps_update_begin();
>         cpus_write_lock();
> 
>        ret = acpi_map_cpu(pr->handle, pr->phys_id, pr->acpi_id, &pr->id);
>        if (ret) {
>                 cpus_write_unlock();
>                 cpu_maps_update_done();
>                 return ret;
>        }
>        ret = arch_register_cpu(pr->id);
>        if (ret) {
>                 acpi_unmap_cpu(pr->id);
> 
>                 cpus_write_unlock();
>                 cpu_maps_update_done();
>                 return ret;
>        }
>       pr_info("CPU%d has been hot-added\n", pr->id);
>       pr->flags.need_hotplug_init = 1;
> 
>       cpus_write_unlock();
>       cpu_maps_update_done();
> }
> 
> so I'm not sure why this cannot be combined with the new code.
> 
> Say acpi_map_cpu) / acpi_unmap_cpu() are turned into arch calls.
> What's the difference then?  The locking, which should be fine if I'm
> not mistaken and need_hotplug_init that needs to be set if this code
> runs after the processor driver has loaded AFAICS.

It is over this that I walked away from progressing this code, because
I don't think it's quite as simple as you make it out to be.

Yes, acpi_map_cpu() and acpi_unmap_cpu() are already arch implemented
functions, so Arm64 can easily provide stubs for these that do nothing.
That never caused me any concern.

What does cause me great concern though are the finer details. For
example, above you seem to drop the evaluation of _STA for the
"make_present" case - I've no idea whether that is something that
should be deleted or not (if it is something that can be deleted,
then why not delete it now?)

As for the cpu locking, I couldn't find anything in arch_register_cpu()
that depends on the cpu_maps_update stuff nor needs the cpus_write_lock
being taken - so I've no idea why the "make_present" case takes these
locks.

Finally, the "pr->flags.need_hotplug_init = 1" thing... it's not
obvious that this is required - remember that with Arm64's "enabled"
toggling, the "processor" is a slice of the system and doesn't
actually go away - it's just "not enabled" for use.

Again, as "processors" in Arm64 are slices of the system, they have
to be fully described in ACPI before the OS boots, and they will be
marked as being "present", which means they will be enumerated, and
the driver will be probed. Any processor that is not to be used will
not have its enabled bit set. It is my understanding that every
processor will result in the ACPI processor driver being bound to it
whether its enabled or not.

The difference between real hotplug and Arm64 hotplug is that real
hotplug makes stuff not-present (and thus unenumerable). Arm64 hotplug
makes stuff not-enabled which is still enumerable.

... or at least that is my understanding which may not be entirely
correct (which is why I stepped down because I feel totally out of
my depth with ACPI stuff.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

