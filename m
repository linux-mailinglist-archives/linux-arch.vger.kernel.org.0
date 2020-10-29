Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E9F29F7BB
	for <lists+linux-arch@lfdr.de>; Thu, 29 Oct 2020 23:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725562AbgJ2WUz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Oct 2020 18:20:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgJ2WUz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Oct 2020 18:20:55 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A9E920FC3;
        Thu, 29 Oct 2020 22:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604010054;
        bh=m6TaEjMK+QnqqWJRKbHR4HNUhM+htkEzN2vpPYuV/ig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AquyTaaIwXdM7oCx1yP7tkJzjIkU7McGO9nPvj7cWnmqqZ2SFc6UNsEVGfipmgEPd
         Zfp3NRESpNQ9lnU7qL/F4Rd5WXQVEKUezkPQZycyxHDF+p1m829RTveEg2PS9Sfpuj
         JYrbesNpIItYr+ozKBo0YffQxCyZ5xiPwtLDUza0=
Date:   Thu, 29 Oct 2020 22:20:48 +0000
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>, kernel-team@android.com
Subject: Re: [PATCH 2/6] arm64: Allow mismatched 32-bit EL0 support
Message-ID: <20201029222048.GD31375@willie-the-truck>
References: <20201027215118.27003-1-will@kernel.org>
 <20201027215118.27003-3-will@kernel.org>
 <20201028111204.GB13345@gaia>
 <20201028111713.GA27927@willie-the-truck>
 <20201028112206.GD13345@gaia>
 <20201028112343.GD27927@willie-the-truck>
 <20201028114945.GE13345@gaia>
 <20201028124049.GC28091@willie-the-truck>
 <20201028185620.GK13345@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028185620.GK13345@gaia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 28, 2020 at 06:56:21PM +0000, Catalin Marinas wrote:
> On Wed, Oct 28, 2020 at 12:40:49PM +0000, Will Deacon wrote:
> > On Wed, Oct 28, 2020 at 11:49:46AM +0000, Catalin Marinas wrote:
> > > On Wed, Oct 28, 2020 at 11:23:43AM +0000, Will Deacon wrote:
> > > > On Wed, Oct 28, 2020 at 11:22:06AM +0000, Catalin Marinas wrote:
> > > > > On Wed, Oct 28, 2020 at 11:17:13AM +0000, Will Deacon wrote:
> > > > > > On Wed, Oct 28, 2020 at 11:12:04AM +0000, Catalin Marinas wrote:
> > > Anyway, I see your reasoning behind the late CPUs but I don't
> > > particularly like abusing the cpufeature support to pretend a
> > > SYSTEM_FEATURE is available before knowing any CPU has it (maybe we do
> > > it in other cases, I haven't checked).
> > 
> > Hmm, but that's exactly what this cmdline option is about. We pretend that
> > the system has 32-bit EL0 when normally we would say that we don't.
> 
> So that's more about force-enabling 32-bit irrespective of whether any
> CPU supports it (not just in the mismatched/asymmetric case). Of course,
> if the aarch32_el0 mask is empty, the apps would get SIGKILL'ed.

Yes, but given that we can't generally rule out a 32-bit CPU coming online
late, I don't think we should pretend that we're in a position to detect
a 64-bit-only system.

> > > Could we not instead add a new feature for asymmetric support that's
> > > defined as ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE? This would be allowed
> > > for late CPUs and we keep the system_supports_32bit_el0() unchanged.
> > 
> > I really don't think this gains us anything.
> 
> It saves us having to explain to someone passing this option on a TX2
> why personality(PER_LINUX32) and even execve() appear to work (well,
> until SIGKILL). The lscpu tool, for example, uses personality() to
> display whether the CPUs support 32-bit.

It really doesn't save us having to explain what this option does: it will
need to be documented regardless. If you pass this option on TX2 then, yes,
you get access to the PER_LINUX32 personality because that's what this
option does. If you don't like that, don't pass the option! It's like
passing "nosmp" and being surprised that you only have one CPU online.

> Also with PER_LINUX32, /proc/cpuinfo shows the 32-bit HWCAPs. We have
> compat_elf_hwcap pre-populated with some stuff which is entirely untrue
> if AArch32 is missing.
> 
> Thinking about the COMPAT_HWCAPs, do we actually populate them properly
> on an asymmetric system if the boot CPU is not AArch32-capable? In my
> original patch I had to defer populating boot_cpu_data with AArch32
> information until a capable CPU was found. If not,
> update_32bit_cpu_features() will set most 32-bit features to 0.

I think there are two interesting aspects to the COMPAT_HWCAPS:

 1. Both my patches and the patches from Qais seem to get this wrong, so
    the set of reported 32-bit caps is too small. I'll look at fixing this
    for v2.

 2. The 32-bit hwcaps are exposed by the PER_LINUX32 personality, and so
    have to be fixed at boot *even if the boot CPUs are all 64-bit-only*.
    This means that if the first 32-bit-capable core is onlined late, then
    it will only get the base capabilities, but I think that's fine and
    consistent with our overall handling of hwcaps (which cannot appear
    dynamically to userspace).

> > The current users of system_supports_32bit_el0() are:
> > 
> >   - The ELF loader
> >   - CPU feature sanitisation code
> >   - Personality syscall
> 
> There three need a relaxed system_supports_32bit_el0(), so we could
> change it to check a new relaxed feature.
> 
> >   - KVM
> 
> Here I think we need the stronger guarantee, no 32-bit allowed in
> guests (the original symmetric feature check).

Right, and I handle this in these patches. But the point is really that
the majority of the users of system_supports_32bit_el0() are actually
interested in the asymmetric case and it doesn't make sense to call that out
separately. If it's the naming you object to, we could rename
system_supports_32bit_el0() to something else? Adding a new cap just adds
complexity that we don't need.

> > and, afaict, all of these would need to check the new feature if we added
> > it.  I think it would also mean that at least one 32-bit capable CPU would
> > have to boot early in order for the new feature to be advertised, which
> > feels like an artificial restriction to me, particularly as you could just
> > offline it immediately.
> 
> How strong requirement is to allow late CPUs here? I think we'd miss the
> COMPAT_HWCAPs as we no longer populate them once user-space started,
> they are actually setup via smp_cpus_done() -> setup_cpu_features().

I think the requirement is to be as consistent as possible and not introduce
more new behaviours than we really have to. Allowing late onlining of cores
but fixing the (compat) hwcaps during boot is fine.

Will
