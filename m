Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8C72A97DE
	for <lists+linux-arch@lfdr.de>; Fri,  6 Nov 2020 15:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgKFOsl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Nov 2020 09:48:41 -0500
Received: from foss.arm.com ([217.140.110.172]:39910 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbgKFOsl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Nov 2020 09:48:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F387147A;
        Fri,  6 Nov 2020 06:48:39 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F8953F66E;
        Fri,  6 Nov 2020 06:48:38 -0800 (PST)
Date:   Fri, 6 Nov 2020 14:48:35 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "kernel-team@android.com" <kernel-team@android.com>
Subject: Re: [PATCH 2/6] arm64: Allow mismatched 32-bit EL0 support
Message-ID: <20201106144835.q363ezyse4vc5kdg@e107158-lin.cambridge.arm.com>
References: <20201028114945.GE13345@gaia>
 <20201028124049.GC28091@willie-the-truck>
 <20201028185620.GK13345@gaia>
 <20201029222048.GD31375@willie-the-truck>
 <20201030111846.GC23196@gaia>
 <20201030161353.GC32582@willie-the-truck>
 <20201102114444.GC21082@gaia>
 <20201105213846.GA8600@willie-the-truck>
 <20201106125425.u6qoswsjfskyxtoo@e107158-lin.cambridge.arm.com>
 <20201106130007.GA10605@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201106130007.GA10605@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/06/20 13:00, Will Deacon wrote:
> On Fri, Nov 06, 2020 at 12:54:25PM +0000, Qais Yousef wrote:
> > Hi Will
> > 
> > On 11/05/20 21:38, Will Deacon wrote:
> > > On Mon, Nov 02, 2020 at 11:44:45AM +0000, Catalin Marinas wrote:
> > > > On Fri, Oct 30, 2020 at 04:13:53PM +0000, Will Deacon wrote:
> > > > > On Fri, Oct 30, 2020 at 11:18:47AM +0000, Catalin Marinas wrote:
> > > > > > On Thu, Oct 29, 2020 at 10:20:48PM +0000, Will Deacon wrote:
> > > > > > >     This means that if the first 32-bit-capable core is onlined late, then
> > > > > > >     it will only get the base capabilities, but I think that's fine and
> > > > > > >     consistent with our overall handling of hwcaps (which cannot appear
> > > > > > >     dynamically to userspace).
> > > > > > 
> > > > > > Yes but such bare 32-bit mode is entirely useless and I don't think we
> > > > > > should even pretend we have 32-bit. The compat hwcaps here would be
> > > > > > "half thumb fastmult edsp tls idiva idivt lpae evtstrm", statically
> > > > > > filled in. It's missing major bits like "vfp" and "neon" which are
> > > > > > necessary for the general purpose 32-bit EABI.
> > > > > 
> > > > > So? If we found such a CPU during boot, would we refuse to online it because
> > > > > we consider it "entirely useless"? No!
> > > > 
> > > > We _do_ online it but as a 64-bit only CPU if there were no early 32-bit
> > > > CPUs since we are not updating the compat hwcaps anyway (and that's
> > > > handled automatically by WEAK_LOCAL_CPU_FEATURE; we do this in a few
> > > > places already).
> > > > 
> > > > > That said, given that it's _very_
> > > > > likely for the late CPUs to support vfp and neon, we could set those caps
> > > > > speculatively if the 64-bit cores have fpsimd (late onlining would be
> > > > > prevented for cores lacking those). Does the architecture allow you to
> > > > > implement both AArch64 and AArch32 at EL0, but only have fpsimd for AArch64?
> > > > 
> > > > Probably not but I don't want to butcher the cpufeature support further
> > > > and have compat hwcaps derived from ID_AA64* regs. I find this hack even
> > > > worse and I'd rather live with the partial hwcap information (and hope
> > > > user space doesn't read hwcaps anyway ;)).
> > > > 
> > > > I don't see why we should change this code further when the requirement
> > > > to the mobile vendors is to simply allow a 32-bit CPU to come up early.
> > > > 
> > > > > > As I said above, I think we would be even more inconsistent w.r.t.
> > > > > > HWCAPs if we require at least one early AArch32-capable CPU, otherwise
> > > > > > don't expose 32-bit at all. I don't see what we gain by allowing all
> > > > > > 32-bit CPUs to come in late, other than maybe saving an entry in the
> > > > > > cpufeature array.
> > > > > 
> > > > > It's a combination of there not being a good reason to prevent the
> > > > > late-onlining and not gaining anything from the additional feature (I've
> > > > > already shown why it doesn't help with the vast majority of callsites).
> > > > 
> > > > I underlined above, this is not about preventing late onlining, only
> > > > preventing late 32-bit support. Late AArch32-capable CPUs will be
> > > > onlined just fine, only that if we haven't got any prior 32-bit CPU, we
> > > > no longer report the feature and the sysfs mask.
> > > 
> > > Ok. Then we're in agreement about not preventing late-onlining. The problem
> > > then is that the existing 32-bit EL0 capability is a SYSTEM cap so even with
> > > your diff, we still have an issue if you boot on the CPUs that support
> > > 32-bit and then try to online a 64-bit-only core (it will fail).
> > > 
> > > So I think we do need my changes to the existing cap, but perhaps we
> > > could return false from system_supports_32bit_el0() until we've actually
> > > seen a 32-bit capable core. That way you would keep the existing behaviour
> > > on TX2, and we wouldn't get any unusual late-onlining failures.
> > > 
> > > I've hacked something together that seems to work, so I'll clean it up and
> > > post it tomorrow. I've spotted a couple of pre-existing issues at the same
> > > time, so I need to fix those first (WEAK_LOCAL_CPU_FEATURE doesn't set the
> > > cap for late CPUs and failed onlining causes RCU stalls).
> > 
> > FWIW I have my v3 over here in case it's of any help. It solves the problem of
> > HWCAP discovery when late AArch32 CPU is booted by populating boot_cpu_date
> > with 32bit features then.
> > 
> > 	git clone https://git.gitlab.arm.com/linux-arm/linux-qy.git -b asym-aarch32-upstream-v3 origin/asym-aarch32-upstream-v3
> 
> Cheers, I've done something similar. I was hoping to post it today, but I've
> been side-tracked with bug fixing this morning. The main headache I ended up
> with was allowing late-onlining of 64-bit-only CPUs if all the boot CPUs
> are 32-bit capable. What do you do in that case?

Do you mean if CPUs 0-3 were 32bit capable and we boot with maxcpus=4 then
attempt to bring the remaining 64bit-only cpus online later?

Haven't tried that tbh. What symptoms do you expect to see? I can try it out.
I'm off for the remainder of the day, but can spend few mins to run an
experiment for sure.

Thanks

--
Qais Yousef
