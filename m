Return-Path: <linux-arch+bounces-1444-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08797838F9C
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 14:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7E32850FC
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 13:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A7A5F872;
	Tue, 23 Jan 2024 13:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fpto1vRE"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A736169F;
	Tue, 23 Jan 2024 13:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015460; cv=none; b=LBWd2nuAqkBDKFpEdXFGDmM0WiWMawIgaO3tuG1f6yMXFxF2HFWMIVIpxwhWpOwpcQ1fkWtOPnDX19TBh52fBEzDlFSSyjNfyHAN2YMq1VZGAMdhzhzL8CHNq5Xe/TBmw5w4qOCz/lfwlOfcqKbjmVutrEkA+iERQErCionIz+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015460; c=relaxed/simple;
	bh=5h4c0yLpAWhh9wDVnrtG83khZHw2xEkAxReFMbgcYiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6QeSZc530vylYdrYrkOvI82BFKnjUJSKtnpkZqkELuK6MCJH254E6lnGH1dpsDgkEam1gOaQACN4jq/nHgl1vGHTjVQKfIjd90notiquunR92/B/7tK6oZiRWMz+q1LilBYBJEkLpa2QgEYuAyMtnuPVXpPtg9qdsoQFEm77qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fpto1vRE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fSr5mFfM4iUU6EsOYToTuq8gdRk30qQl8QQSg63i70E=; b=fpto1vRE8xiQfC1uHZjgB53IU1
	JLS4uiEkPBr6x1Klv4TNndrOnG/ui4aqzwG/Y2eqKlYIDHpeJacttqDhXV2KGhFFEn9acxBpxIouu
	tOH2aiHL34vwZDnDTt45uqhH4MS/X5syanHIDBqUfCGS4JuKsSQ/+MMkvnURyhmYGdLkZ9t3oZuqF
	XWRtZTgH2zKCxX4SfzUOlORMQvFyeJrKaOho9uAsnq3WH6zRTINuWSRJ4XEYkmi4DaXRKgTQN+Kz8
	8qrlri2JBWoJpsiLMJuWZcj5/RLx3sn8Pm1uwiDKuFDLblQQ1Lq/w4uAOvqo/kJ0weC6iYY1dCIMz
	idqciouw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46192)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rSGYC-0002Qx-1y;
	Tue, 23 Jan 2024 13:10:48 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rSGY8-0001yi-Ln; Tue, 23 Jan 2024 13:10:44 +0000
Date: Tue, 23 Jan 2024 13:10:44 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
	James Morse <james.morse@arm.com>
Subject: Re: [PATCH RFC v3 17/21] ACPI: add support to register CPUs based on
 the _STA enabled bit
Message-ID: <Za+61Jikkxh2BinY@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
 <E1rDOhC-00DvlI-Pp@rmk-PC.armlinux.org.uk>
 <ZYBDJG1g7SH7AiM1@shell.armlinux.org.uk>
 <20240102145320.000062f9@Huawei.com>
 <20240123102603.00004244@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123102603.00004244@Huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 23, 2024 at 10:26:03AM +0000, Jonathan Cameron wrote:
> On Tue, 2 Jan 2024 14:53:20 +0000
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
> > On Mon, 18 Dec 2023 13:03:32 +0000
> > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > 
> > > On Wed, Dec 13, 2023 at 12:50:38PM +0000, Russell King wrote:  
> > > > From: James Morse <james.morse@arm.com>
> > > > 
> > > > acpi_processor_get_info() registers all present CPUs. Registering a
> > > > CPU is what creates the sysfs entries and triggers the udev
> > > > notifications.
> > > > 
> > > > arm64 virtual machines that support 'virtual cpu hotplug' use the
> > > > enabled bit to indicate whether the CPU can be brought online, as
> > > > the existing ACPI tables require all hardware to be described and
> > > > present.
> > > > 
> > > > If firmware describes a CPU as present, but disabled, skip the
> > > > registration. Such CPUs are present, but can't be brought online for
> > > > whatever reason. (e.g. firmware/hypervisor policy).
> > > > 
> > > > Once firmware sets the enabled bit, the CPU can be registered and
> > > > brought online by user-space. Online CPUs, or CPUs that are missing
> > > > an _STA method must always be registered.    
> > > 
> > > ...
> > >   
> > > > @@ -526,6 +552,9 @@ static void acpi_processor_post_eject(struct acpi_device *device)
> > > >  		acpi_processor_make_not_present(device);
> > > >  		return;
> > > >  	}
> > > > +
> > > > +	if (cpu_present(pr->id) && !(sta & ACPI_STA_DEVICE_ENABLED))
> > > > +		arch_unregister_cpu(pr->id);    
> > > 
> > > This change isn't described in the commit log, but seems to be the cause
> > > of the build error identified by the kernel build bot that is fixed
> > > later in this series. I'm wondering whether this should be in a
> > > different patch, maybe "ACPI: Check _STA present bit before making CPUs
> > > not present" ?  
> > 
> > Would seem a bit odd to call arch_unregister_cpu() way before the code
> > is added to call the matching arch_registers_cpu()
> > 
> > Mind you this eject doesn't just apply to those CPUs that are registered
> > later I think, but instead to all.  So we run into the spec hole that
> > there is no way to identify initially 'enabled' CPUs that might be disabled
> > later.
> > 
> > > 
> > > Or maybe my brain isn't working properly (due to being Covid positive.)
> > > Any thoughts, Jonathan?  
> > 
> > I'll go with a resounding 'not sure' on where this change belongs.
> > I blame my non existent start of the year hangover.
> > Hope you have recovered!
> 
> Looking again, I think you were right, move it to that earlier patch.

I'm having second thoughts - because this patch introduces the
arch_register_cpu() into the acpi_processor_add() path (via
acpi_processor_get_info() and acpi_processor_make_enabled(), so isn't
it also correct to add arch_unregister_cpu() to the detach/post_eject
path as well? If we add one without the other, doesn't stuff become
a bit asymetric?

Looking more deeply at these changes, I'm finding it isn't easy to
keep track of everything that's going on here.

We had attach()/detach() callbacks that were nice and symetrical.
How we have this post_eject() callback that makes things asymetrical.

We have the attach() method that registers the CPU, but no detach
method, instead having the post_eject() method. On the face of it,
arch_unregister_cpu() doesn't look symetric unless one goes digging
more in the code - by that, I mean arch_register_cpu() only gets
called of present=1 _and_ enabled=1. However, arch_unregister_cpu()
gets called buried in acpi_processor_make_not_present(), called when
present=0, and then we have this new one to handle the case where
enabled=0. It is not obvious that arch_unregister_cpu() is the reverse
of what happens with arch_register_cpu() here.

Then we have the add() method allocating pr->throttling.shared_cpu_map,
and acpi_processor_make_not_present() freeing it. From what I read in
ACPI v6.5, enabled is not allowed to be set without present. So, if
_STA reports that a CPU that had present=1 enabled=1, but then is
later reported to be enabled=0 (which we handle by calling only
arch_unregister_cpu()) then what happens when _STA changes to
enabled=1 later? Does add() get called? If it does, this would cause
a new acpi_processor structure to be allocated and the old one to be
leaked... I hope I'm wrong about add() being called - but if it isn't,
how does enabled going from 0->1 get handled... and if we are handling
its 1->0 transition separately from present, then surely we should be
handling that.

Maybe I'm just getting confused, but I've spent much of this morning
trying to unravel all this... and I'm of the opinion that this isn't a
sign of a good approach.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

