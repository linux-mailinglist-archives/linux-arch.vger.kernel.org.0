Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8B22A0AE2
	for <lists+linux-arch@lfdr.de>; Fri, 30 Oct 2020 17:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgJ3QOB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Oct 2020 12:14:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgJ3QOB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Oct 2020 12:14:01 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D73B206FA;
        Fri, 30 Oct 2020 16:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604074439;
        bh=ywikaYdRiQXniE64iyK/LcRo1wbh9lpmPAH9bB5n1fE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yr9JwkixYuMK7TzQlmStjXDhBdqB3R6vD6xmVxPTnCiWiW3eYeS/t7UsZJ/6sEpyw
         lTEvG/tKOc7PEzgg415xqVMe5NxrXJ2oVURTzTvs/QgbUkpLa0wMci/5ILOlHRGdBw
         TLvv4rI3qIDUP27stZgiKfVhCn4vdotwbYX8q9MQ=
Date:   Fri, 30 Oct 2020 16:13:53 +0000
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
Message-ID: <20201030161353.GC32582@willie-the-truck>
References: <20201027215118.27003-3-will@kernel.org>
 <20201028111204.GB13345@gaia>
 <20201028111713.GA27927@willie-the-truck>
 <20201028112206.GD13345@gaia>
 <20201028112343.GD27927@willie-the-truck>
 <20201028114945.GE13345@gaia>
 <20201028124049.GC28091@willie-the-truck>
 <20201028185620.GK13345@gaia>
 <20201029222048.GD31375@willie-the-truck>
 <20201030111846.GC23196@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030111846.GC23196@gaia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 30, 2020 at 11:18:47AM +0000, Catalin Marinas wrote:
> On Thu, Oct 29, 2020 at 10:20:48PM +0000, Will Deacon wrote:
> > On Wed, Oct 28, 2020 at 06:56:21PM +0000, Catalin Marinas wrote:
> > > On Wed, Oct 28, 2020 at 12:40:49PM +0000, Will Deacon wrote:
> > > > On Wed, Oct 28, 2020 at 11:49:46AM +0000, Catalin Marinas wrote:
> > > > > On Wed, Oct 28, 2020 at 11:23:43AM +0000, Will Deacon wrote:
> > > > > > On Wed, Oct 28, 2020 at 11:22:06AM +0000, Catalin Marinas wrote:
> > > > > > > On Wed, Oct 28, 2020 at 11:17:13AM +0000, Will Deacon wrote:
> > > > > > > > On Wed, Oct 28, 2020 at 11:12:04AM +0000, Catalin Marinas wrote:
> > > > > Anyway, I see your reasoning behind the late CPUs but I don't
> > > > > particularly like abusing the cpufeature support to pretend a
> > > > > SYSTEM_FEATURE is available before knowing any CPU has it (maybe we do
> > > > > it in other cases, I haven't checked).
> > > > 
> > > > Hmm, but that's exactly what this cmdline option is about. We pretend that
> > > > the system has 32-bit EL0 when normally we would say that we don't.
> > > 
> > > So that's more about force-enabling 32-bit irrespective of whether any
> > > CPU supports it (not just in the mismatched/asymmetric case). Of course,
> > > if the aarch32_el0 mask is empty, the apps would get SIGKILL'ed.
> > 
> > Yes, but given that we can't generally rule out a 32-bit CPU coming online
> > late, I don't think we should pretend that we're in a position to detect
> > a 64-bit-only system.
> 
> No, we can't pretend it's a 64-bit only system but the kernel could
> insist that 32-bit is not available if CPUs come in late. And since we
> won't add late compat HWCAPs, I think allowing late 32-bit CPUs is a
> pretty useless feature (see more below; of course, we allow those late
> CPUs but they'd only run 64-bit apps).

Why should we insist on this? It doesn't gain us anything in the kernel and
I don't think we should police userspace just because we can (the presence
of the command-line option is indicative that we should really be letting
userspace get on with it).

> > > > > Could we not instead add a new feature for asymmetric support that's
> > > > > defined as ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE? This would be allowed
> > > > > for late CPUs and we keep the system_supports_32bit_el0() unchanged.
> > > > 
> > > > I really don't think this gains us anything.
> > > 
> > > It saves us having to explain to someone passing this option on a TX2
> > > why personality(PER_LINUX32) and even execve() appear to work (well,
> > > until SIGKILL). The lscpu tool, for example, uses personality() to
> > > display whether the CPUs support 32-bit.
> > 
> > It really doesn't save us having to explain what this option does: it will
> > need to be documented regardless. If you pass this option on TX2 then, yes,
> > you get access to the PER_LINUX32 personality because that's what this
> > option does. If you don't like that, don't pass the option! It's like
> > passing "nosmp" and being surprised that you only have one CPU online.
> 
> I see this analogy the other way around, you pass "allow_smp" on a UP
> system and the kernel pretends there are more CPUs available, only that
> the app gets SIGKILL'ed if it ends up on the fake core. Well, if it's
> properly documented and people read it, we could live with this.

The bottom line is that passing command-line options can make things look
different and so we need to document what they do. I don't think we're
disagreeing here.

> > > Also with PER_LINUX32, /proc/cpuinfo shows the 32-bit HWCAPs. We have
> > > compat_elf_hwcap pre-populated with some stuff which is entirely untrue
> > > if AArch32 is missing.
> > > 
> > > Thinking about the COMPAT_HWCAPs, do we actually populate them properly
> > > on an asymmetric system if the boot CPU is not AArch32-capable? In my
> > > original patch I had to defer populating boot_cpu_data with AArch32
> > > information until a capable CPU was found. If not,
> > > update_32bit_cpu_features() will set most 32-bit features to 0.
> > 
> > I think there are two interesting aspects to the COMPAT_HWCAPS:
> > 
> >  1. Both my patches and the patches from Qais seem to get this wrong, so
> >     the set of reported 32-bit caps is too small. I'll look at fixing this
> >     for v2.
> 
> I had it addressed in my original patch and Qais' first post on lakml.
> It deferred filling in the 32-bit part of boot_cpu_data until the first
> encounter of a 32-bit CPU.
> 
> I suggested we drop the cpuinfo_arm64.aarch32_valid member entirely but
> I think we should have made it a static variable in cpuinfo_store_cpu()
> or somewhere around there and still populate the 32-bit part of
> boot_cpu_data.

OK, I haven't looked into the reason for this yet.

> >  2. The 32-bit hwcaps are exposed by the PER_LINUX32 personality, and so
> >     have to be fixed at boot *even if the boot CPUs are all 64-bit-only*.
> 
> Note that the kernel rejects PER_LINUX32 if the system is 64-bit only.
> With this option, arguably the 64-bit personality() ABI is slightly
> changed. It doesn't matter much, only for lscpu reporting 32-bit
> support when it's not there.

I think this is just a consequence of enabling this option.

> >     This means that if the first 32-bit-capable core is onlined late, then
> >     it will only get the base capabilities, but I think that's fine and
> >     consistent with our overall handling of hwcaps (which cannot appear
> >     dynamically to userspace).
> 
> Yes but such bare 32-bit mode is entirely useless and I don't think we
> should even pretend we have 32-bit. The compat hwcaps here would be
> "half thumb fastmult edsp tls idiva idivt lpae evtstrm", statically
> filled in. It's missing major bits like "vfp" and "neon" which are
> necessary for the general purpose 32-bit EABI.

So? If we found such a CPU during boot, would we refuse to online it because
we consider it "entirely useless"? No! That said, given that it's _very_
likely for the late CPUs to support vfp and neon, we could set those caps
speculatively if the 64-bit cores have fpsimd (late onlining would be
prevented for cores lacking those). Does the architecture allow you to
implement both AArch64 and AArch32 at EL0, but only have fpsimd for AArch64?

> Yes, in theory you can run an applications that don't make use of FP but
> are there such apps still around? Even worse, I think not having
> HWCAP_VFP or HWCAP_NEON should lead to a SIGILL if executing such
> instructions but I have a suspicion they'd work just fine. So our compat
> ABI in this case is no longer consistent with what we'd expose on a
> symmetric system.

In general, we already have this case for other capabilities where the
architecture doesn't provide us with controls to disable instructions at
EL0, so I don't think this is something new. However, given that we can
trap fp, then I agree that this should be consistent with the caps.

> > > How strong requirement is to allow late CPUs here? I think we'd miss the
> > > COMPAT_HWCAPs as we no longer populate them once user-space started,
> > > they are actually setup via smp_cpus_done() -> setup_cpu_features().
> > 
> > I think the requirement is to be as consistent as possible and not introduce
> > more new behaviours than we really have to. Allowing late onlining of cores
> > but fixing the (compat) hwcaps during boot is fine.
> 
> As I said above, I think we would be even more inconsistent w.r.t.
> HWCAPs if we require at least one early AArch32-capable CPU, otherwise
> don't expose 32-bit at all. I don't see what we gain by allowing all
> 32-bit CPUs to come in late, other than maybe saving an entry in the
> cpufeature array.

It's a combination of there not being a good reason to prevent the
late-onlining and not gaining anything from the additional feature (I've
already shown why it doesn't help with the vast majority of callsites).

Will
