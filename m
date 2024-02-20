Return-Path: <linux-arch+bounces-2501-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D511385BF99
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 16:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065CB1C20B17
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 15:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F7E74E15;
	Tue, 20 Feb 2024 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Xy5iv0Wr"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D75376020;
	Tue, 20 Feb 2024 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708442057; cv=none; b=CnBlQdVFUqyL+VOhxwF/dd/K7b9aUgVcNOl0NIFY6Oo00ZPiKnpK3jvquHdgisU5kksRSLMUfuYZS/ORznq9dY07RRXFBYF8VDIYkw8QoJKzTFkJU4c4hkcU64qUqZo/Mp6DbZ6+WXhTPMxQ7/nHBWNqcxOMOebLVOLEt6PTQ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708442057; c=relaxed/simple;
	bh=EerVHanUz2tefY83Hs9lDDnTHX9i7fSD2ZbOIE+Yu88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjgmYzBoJ1KrSLSAEyP8cJzx51Q6ZPS9NSwT1j2zxdZeoB2PY51VIRlYPGoijTc2cckRZwh0Fd1FWWmigEmla4KO3udTFC8qlCvTRLMemxygb65FLyJn98cRDzMXRUiDpVxF6hMvEZ9C3qKL7y25YT07oHN9NjgbrjJLhPZAB1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Xy5iv0Wr; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qgc8OUZCtZPjwVAIjMqiHy7ikwaI1Mbu1Mp1IdFRzDs=; b=Xy5iv0WrTLeAO0Yk5KZRnMdKyj
	P5Il3QQ+baeCRbUTHw+M2pQGpzCvY2kVMWyp3dXDSELRc5Ju3nfd11YBuUEHjVI4tFW2/xraLQejU
	8tft/vHldbP7aGpknVnTEenRzyIrR0qgmIZkTDpzWNYBWSARs/hgaqJkstanzehwL6LPfJLIeqFLo
	gUb/82YcOQPZlEGA8PE5OTomL+YF+FqTubxG54uf45edRw2uSwN7RfBx+Du1NGHDAZjqfMWrmpglo
	yS8bLYhbsuhKYbVHwDGhCbqZMUPo3WgWbTMTAIMeCbEX6XIBN4y0pMZBZKVgW6FRGfRXxX28yVi92
	FpAy11Fw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45522)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rcRoq-00033P-2v;
	Tue, 20 Feb 2024 15:14:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rcRok-0000xX-ST; Tue, 20 Feb 2024 15:13:58 +0000
Date: Tue, 20 Feb 2024 15:13:58 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
	x86@kernel.org, acpica-devel@lists.linuxfoundation.org,
	linux-csky@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
	Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	jianyong.wu@arm.com, justin.he@arm.com,
	James Morse <james.morse@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH RFC v4 02/15] ACPI: processor: Register all CPUs from
 acpi_processor_get_info()
Message-ID: <ZdTBtt0oR6Q1RcAB@shell.armlinux.org.uk>
References: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk>
 <E1rVDmU-0027YP-Jz@rmk-PC.armlinux.org.uk>
 <CAJZ5v0iiJpUWq5GMSnKFWQTzn_bdwoQz9m=hDaXNg4Lj_ePF4g@mail.gmail.com>
 <ZdSMk93c1I6x973h@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZdSMk93c1I6x973h@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Feb 20, 2024 at 11:27:15AM +0000, Russell King (Oracle) wrote:
> On Thu, Feb 15, 2024 at 08:22:29PM +0100, Rafael J. Wysocki wrote:
> > On Wed, Jan 31, 2024 at 5:50 PM Russell King <rmk+kernel@armlinux.org.uk> wrote:
> > > diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> > > index cf7c1cca69dd..a68c475cdea5 100644
> > > --- a/drivers/acpi/acpi_processor.c
> > > +++ b/drivers/acpi/acpi_processor.c
> > > @@ -314,6 +314,18 @@ static int acpi_processor_get_info(struct acpi_device *device)
> > >                         cpufreq_add_device("acpi-cpufreq");
> > >         }
> > >
> > > +       /*
> > > +        * Register CPUs that are present. get_cpu_device() is used to skip
> > > +        * duplicate CPU descriptions from firmware.
> > > +        */
> > > +       if (!invalid_logical_cpuid(pr->id) && cpu_present(pr->id) &&
> > > +           !get_cpu_device(pr->id)) {
> > > +               int ret = arch_register_cpu(pr->id);
> > > +
> > > +               if (ret)
> > > +                       return ret;
> > > +       }
> > > +
> > >         /*
> > >          *  Extra Processor objects may be enumerated on MP systems with
> > >          *  less than the max # of CPUs. They should be ignored _iff
> > 
> > This is interesting, because right below there is the following code:
> > 
> >     if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
> >         int ret = acpi_processor_hotadd_init(pr);
> > 
> >         if (ret)
> >             return ret;
> >     }
> > 
> > and acpi_processor_hotadd_init() essentially calls arch_register_cpu()
> > with some extra things around it (more about that below).
> > 
> > I do realize that acpi_processor_hotadd_init() is defined under
> > CONFIG_ACPI_HOTPLUG_CPU, so for the sake of the argument let's
> > consider an architecture where CONFIG_ACPI_HOTPLUG_CPU is set.
> > 
> > So why are the two conditionals that almost contradict each other both
> > needed?  It looks like the new code could be combined with
> > acpi_processor_hotadd_init() to do the right thing in all cases.
> > 
> > Now, acpi_processor_hotadd_init() does some extra things that look
> > like they should be done by the new code too.
> > 
> > 1. It checks invalid_phys_cpuid() which appears to be a good idea to me.
> > 
> > 2. It uses locking around arch_register_cpu() which doesn't seem
> > unreasonable either.
> > 
> > 3. It calls acpi_map_cpu() and I'm not sure why this is not done by
> > the new code.
> > 
> > The only thing that can be dropped from it is the _STA check AFAICS,
> > because acpi_processor_add() won't even be called if the CPU is not
> > present (and not enabled after the first patch).
> > 
> > So why does the code not do 1 - 3 above?
> 
> Honestly, I'm out of my depth with this and can't answer your
> questions - and I really don't want to try fiddling with this code
> because it's just too icky (even in its current form in mainline)
> to be understandable to anyone who hasn't gained a detailed knowledge
> of this code.
> 
> It's going to require a lot of analysis - how acpi_map_cpuid() behaves
> in all circumstances, what this means for invalid_logical_cpuid() and
> invalid_phys_cpuid(), what paths will be taken in each case. This code
> is already just too hairy for someone who isn't an experienced ACPI
> hacker to be able to follow and I don't see an obvious way to make it
> more readable.
> 
> James' additions make it even more complex and less readable.

As an illustration of the problems I'm having here, I was just writing
a reply to this with a suggestion of transforming this code ultimately
to:

	if (!get_cpu_device(pr->id)) {
		int ret;

		if (!invalid_logical_cpuid(pr->id) && cpu_present(pr->id))
			ret = acpi_processor_make_enabled(pr);
		else
			ret = acpi_processor_make_present(pr);

		if (ret)
			return ret;
	}

(acpi_processor_make_present() would be acpi_processor_hotadd_init()
and acpi_processor_make_enabled() would be arch_register_cpu() at this
point.)

Then I realised that's a bad idea - because we really need to check
that pr->id is valid before calling get_cpu_device() on it, so this
won't work. That leaves us with:

	int ret;

	if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
		/* x86 et.al. path */
		ret = acpi_processor_make_present(pr);
	} else if (!get_cpu_device(pr->id)) {
		/* Arm64 path */
		ret = acpi_processor_make_enabled(pr);
	} else {
		ret = 0;
	}

	if (ret)
		return ret;

Now, the next transformation would be to move !get_cpu_device(pr->id)
into acpi_processor_make_enabled() which would eliminate one of those
if() legs.

Now, if we want to somehow make the call to arch_regster_cpu() common
in these two paths, the next question is what are the _precise_
semantics of acpi_map_cpu(), particularly with respect to it
modifying pr->id. Is it guaranteed to always give the same result
for the same processor described in ACPI? What acpi_map_cpu() anyway,
I can find no documentation for it.

Then there's the question whether calling acpi_unmap_cpu() should be
done on the failure path if arch_register_cpu() fails, which is done
for the x86 path but not the Arm64 path. Should it be done for the
Arm64 path? I've no idea, but as Arm64 doesn't implement either of
these two functions, I guess they could be stubbed out and thus be
no-ops - but then we open a hole where if pr->id is invalid, we
end up passing that invalid value to arch_register_cpu() which I'm
quite sure will explode with a negative CPU number.

So, to my mind, what you're effectively asking for is a total rewrite
of all the code in and called by acpi_processor_get_info()... and that
is not something I am willing to do (because it's too far outside of
my knowledge area.)

As I said in my reply to patch 1, I think your comments on patch 2
make Arm64 vcpu hotplug unachievable in a reasonable time frame, and
certainly outside the bounds of what I can do to progress this.

So, at this point I'm going to stand down from further participation
with this patch set as I believe I've reached the limit of what I can
do to progress it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

