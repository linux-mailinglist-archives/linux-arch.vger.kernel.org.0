Return-Path: <linux-arch+bounces-3647-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1DC8A3817
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 23:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 623B51C21FA7
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 21:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37D2152181;
	Fri, 12 Apr 2024 21:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0t/OqIJP"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79984C6E;
	Fri, 12 Apr 2024 21:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712958799; cv=none; b=R7c0QZkEDf8yCZLBVpw/8iq+mairjdvUK0NX383MalHmzhJGR7AmT+MdfJB2oiLAZK+1/hnk3LE7nituF2ilXQavR0z01kBkE8fGQw/Kl4g751vxale2OFr6d54q5cGpYvqnATNHh90GdcpEgYdn6tFQerSOe7divTcctug2YdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712958799; c=relaxed/simple;
	bh=BdSgFGJhHjO9WwlsJu1tsTeYhSN720SIteIMwqhFm6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqFtTupi6vVWRssflCZ0olAyqyRFWXWgN4qifh2zhGKfCX9y3QfiyqTpB9vk3j/Cd+lVJJOQqzgFe1Wl+Q2ybWgB2+DBSS1K4cH6ek+ZJ2OwsjPk4kAAognWvVGc1XkFPG++a6m8XEnBnVJWVQHUR34/Tga6hCfRteAaz+xGsZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0t/OqIJP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CZ7buMYJSXIP580elkv8hxx7dXMmZwdM9xCS76aVbcE=; b=0t/OqIJP7/pbdbiU9u7ayT81ol
	oNznj0f9koAzv6RbQ2O3iOraCWKj5XVO0ILq0RXzSDKtgsDi9DyJjRUk0cHu2d4VfgHxz6aOzhEI9
	AYhAMUnbG6tf8TmuM5U4Z/1tJeKmGN2cYEYCW0SzFAAP7COlTFkyqAsKRsR2OYnikLUlfVzYdn7iL
	c+r1zujZB3pbvVUIUBGuJw77ToEjGuQpxhnVCp86aCR/ShVF6XSi11EbnjYXz3y9kfu6kGeuVZmj+
	+AwCn5M9G8SVchw7Wtvy90bgmx4ICqICtJqcFO6ok5ObRbSdos9P0pSdbQgRGsUVLj1vA6lW3K57i
	S3355MCw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52302)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rvOpU-00031N-1A;
	Fri, 12 Apr 2024 22:53:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rvOpP-00089G-Ut; Fri, 12 Apr 2024 22:53:00 +0100
Date: Fri, 12 Apr 2024 22:52:59 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
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
Message-ID: <ZhmtO6zBExkQGZLk@shell.armlinux.org.uk>
References: <20240412143719.11398-1-Jonathan.Cameron@huawei.com>
 <20240412143719.11398-4-Jonathan.Cameron@huawei.com>
 <CAJZ5v0gNvy2e=hOGQQ2kLpnrDr8=QGBax-E5odEJ=7BA8qW-9A@mail.gmail.com>
 <ZhmWkE+fCEG/WFoi@shell.armlinux.org.uk>
 <87bk6ez4hj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bk6ez4hj.ffs@tglx>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Apr 12, 2024 at 10:54:32PM +0200, Thomas Gleixner wrote:
> On Fri, Apr 12 2024 at 21:16, Russell King (Oracle) wrote:
> > On Fri, Apr 12, 2024 at 08:30:40PM +0200, Rafael J. Wysocki wrote:
> >> Say acpi_map_cpu) / acpi_unmap_cpu() are turned into arch calls.
> >> What's the difference then?  The locking, which should be fine if I'm
> >> not mistaken and need_hotplug_init that needs to be set if this code
> >> runs after the processor driver has loaded AFAICS.
> >
> > It is over this that I walked away from progressing this code, because
> > I don't think it's quite as simple as you make it out to be.
> >
> > Yes, acpi_map_cpu() and acpi_unmap_cpu() are already arch implemented
> > functions, so Arm64 can easily provide stubs for these that do nothing.
> > That never caused me any concern.
> >
> > What does cause me great concern though are the finer details. For
> > example, above you seem to drop the evaluation of _STA for the
> > "make_present" case - I've no idea whether that is something that
> > should be deleted or not (if it is something that can be deleted,
> > then why not delete it now?)
> >
> > As for the cpu locking, I couldn't find anything in arch_register_cpu()
> > that depends on the cpu_maps_update stuff nor needs the cpus_write_lock
> > being taken - so I've no idea why the "make_present" case takes these
> > locks.
> 
> Anything which updates a CPU mask, e.g. cpu_present_mask, after early
> boot must hold the appropriate write locks. Otherwise it would be
> possible to online a CPU which just got marked present, but the
> registration has not completed yet.

Yes. As far as I've been able to determine, arch_register_cpu()
doesn't manipulate any of the CPU masks. All it seems to be doing
is initialising the struct cpu, registering the embedded struct
device, and setting up the sysfs links to its NUMA node.

There is nothing obvious in there which manipulates any CPU masks, and
this is rather my fundamental point when I said "I couldn't find
anything in arch_register_cpu() that depends on ...".

If there is something, then comments in the code would be a useful aid
because it's highly non-obvious where such a manipulation is located,
and hence why the locks are necessary.

> > Finally, the "pr->flags.need_hotplug_init = 1" thing... it's not
> > obvious that this is required - remember that with Arm64's "enabled"
> > toggling, the "processor" is a slice of the system and doesn't
> > actually go away - it's just "not enabled" for use.
> >
> > Again, as "processors" in Arm64 are slices of the system, they have
> > to be fully described in ACPI before the OS boots, and they will be
> > marked as being "present", which means they will be enumerated, and
> > the driver will be probed. Any processor that is not to be used will
> > not have its enabled bit set. It is my understanding that every
> > processor will result in the ACPI processor driver being bound to it
> > whether its enabled or not.
> >
> > The difference between real hotplug and Arm64 hotplug is that real
> > hotplug makes stuff not-present (and thus unenumerable). Arm64 hotplug
> > makes stuff not-enabled which is still enumerable.
> 
> Define "real hotplug" :)
> 
> Real physical hotplug does not really exist. That's at least true for
> x86, where the physical hotplug support was chased for a while, but
> never ended up in production.
> 
> Though virtualization happily jumped on it to hot add/remove CPUs
> to/from a guest.
> 
> There are limitations to this and we learned it the hard way on X86. At
> the end we came up with the following restrictions:
> 
>     1) All possible CPUs have to be advertised at boot time via firmware
>        (ACPI/DT/whatever) independent of them being present at boot time
>        or not.
> 
>        That guarantees proper sizing and ensures that associations
>        between hardware entities and software representations and the
>        resulting topology are stable for the lifetime of a system.
> 
>        It is really required to know the full topology of the system at
>        boot time especially with hybrid CPUs where some of the cores
>        have hyperthreading and the others do not.
> 
> 
>     2) Hot add can only mark an already registered (possible) CPU
>        present. Adding non-registered CPUs after boot is not possible.
> 
>        The CPU must have been registered in #1 already to ensure that
>        the system topology does not suddenly change in an incompatible
>        way at run-time.
> 
> The same restriction would apply to real physical hotplug. I don't think
> that's any different for ARM64 or any other architecture.

This makes me wonder whether the Arm64 has been barking up the wrong
tree then, and whether the whole "present" vs "enabled" thing comes
from a misunderstanding as far as a CPU goes.

However, there is a big difference between the two. On x86, a processor
is just a processor. On Arm64, a "processor" is a slice of the system
(includes the interrupt controller, PMUs etc) and we must enumerate
those even when the processor itself is not enabled. This is the whole
reason there's a difference between "present" and "enabled" and why
there's a difference between x86 cpu hotplug and arm64 cpu hotplug.
The processor never actually goes away in arm64, it's just prevented
from being used.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

