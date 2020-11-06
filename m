Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3752A9695
	for <lists+linux-arch@lfdr.de>; Fri,  6 Nov 2020 14:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgKFNAO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Nov 2020 08:00:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:37942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbgKFNAO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Nov 2020 08:00:14 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2D97206D5;
        Fri,  6 Nov 2020 13:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604667613;
        bh=lX1ny0BvLC9sf0tZM/Ti8m72ZG3A2SzGNA3W2p8D6qM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p05dIDyNKI2adFCO50sGaAdCfnivGtj2abD3VJZC9B1L8243B805KjX1qM/m/IAGy
         p3gAzQDYXkeqbqK0PKGBmOehSvGfWhSj1X02PZJmyOZ+gGvBX6xJS2duALGmkPGF+4
         qNYZcD/u2FPsJQj48QADrxc6RivhfhCwZKUSy0Wg=
Date:   Fri, 6 Nov 2020 13:00:07 +0000
From:   Will Deacon <will@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
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
Message-ID: <20201106130007.GA10605@willie-the-truck>
References: <20201028112343.GD27927@willie-the-truck>
 <20201028114945.GE13345@gaia>
 <20201028124049.GC28091@willie-the-truck>
 <20201028185620.GK13345@gaia>
 <20201029222048.GD31375@willie-the-truck>
 <20201030111846.GC23196@gaia>
 <20201030161353.GC32582@willie-the-truck>
 <20201102114444.GC21082@gaia>
 <20201105213846.GA8600@willie-the-truck>
 <20201106125425.u6qoswsjfskyxtoo@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106125425.u6qoswsjfskyxtoo@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 06, 2020 at 12:54:25PM +0000, Qais Yousef wrote:
> Hi Will
> 
> On 11/05/20 21:38, Will Deacon wrote:
> > On Mon, Nov 02, 2020 at 11:44:45AM +0000, Catalin Marinas wrote:
> > > On Fri, Oct 30, 2020 at 04:13:53PM +0000, Will Deacon wrote:
> > > > On Fri, Oct 30, 2020 at 11:18:47AM +0000, Catalin Marinas wrote:
> > > > > On Thu, Oct 29, 2020 at 10:20:48PM +0000, Will Deacon wrote:
> > > > > >     This means that if the first 32-bit-capable core is onlined late, then
> > > > > >     it will only get the base capabilities, but I think that's fine and
> > > > > >     consistent with our overall handling of hwcaps (which cannot appear
> > > > > >     dynamically to userspace).
> > > > > 
> > > > > Yes but such bare 32-bit mode is entirely useless and I don't think we
> > > > > should even pretend we have 32-bit. The compat hwcaps here would be
> > > > > "half thumb fastmult edsp tls idiva idivt lpae evtstrm", statically
> > > > > filled in. It's missing major bits like "vfp" and "neon" which are
> > > > > necessary for the general purpose 32-bit EABI.
> > > > 
> > > > So? If we found such a CPU during boot, would we refuse to online it because
> > > > we consider it "entirely useless"? No!
> > > 
> > > We _do_ online it but as a 64-bit only CPU if there were no early 32-bit
> > > CPUs since we are not updating the compat hwcaps anyway (and that's
> > > handled automatically by WEAK_LOCAL_CPU_FEATURE; we do this in a few
> > > places already).
> > > 
> > > > That said, given that it's _very_
> > > > likely for the late CPUs to support vfp and neon, we could set those caps
> > > > speculatively if the 64-bit cores have fpsimd (late onlining would be
> > > > prevented for cores lacking those). Does the architecture allow you to
> > > > implement both AArch64 and AArch32 at EL0, but only have fpsimd for AArch64?
> > > 
> > > Probably not but I don't want to butcher the cpufeature support further
> > > and have compat hwcaps derived from ID_AA64* regs. I find this hack even
> > > worse and I'd rather live with the partial hwcap information (and hope
> > > user space doesn't read hwcaps anyway ;)).
> > > 
> > > I don't see why we should change this code further when the requirement
> > > to the mobile vendors is to simply allow a 32-bit CPU to come up early.
> > > 
> > > > > As I said above, I think we would be even more inconsistent w.r.t.
> > > > > HWCAPs if we require at least one early AArch32-capable CPU, otherwise
> > > > > don't expose 32-bit at all. I don't see what we gain by allowing all
> > > > > 32-bit CPUs to come in late, other than maybe saving an entry in the
> > > > > cpufeature array.
> > > > 
> > > > It's a combination of there not being a good reason to prevent the
> > > > late-onlining and not gaining anything from the additional feature (I've
> > > > already shown why it doesn't help with the vast majority of callsites).
> > > 
> > > I underlined above, this is not about preventing late onlining, only
> > > preventing late 32-bit support. Late AArch32-capable CPUs will be
> > > onlined just fine, only that if we haven't got any prior 32-bit CPU, we
> > > no longer report the feature and the sysfs mask.
> > 
> > Ok. Then we're in agreement about not preventing late-onlining. The problem
> > then is that the existing 32-bit EL0 capability is a SYSTEM cap so even with
> > your diff, we still have an issue if you boot on the CPUs that support
> > 32-bit and then try to online a 64-bit-only core (it will fail).
> > 
> > So I think we do need my changes to the existing cap, but perhaps we
> > could return false from system_supports_32bit_el0() until we've actually
> > seen a 32-bit capable core. That way you would keep the existing behaviour
> > on TX2, and we wouldn't get any unusual late-onlining failures.
> > 
> > I've hacked something together that seems to work, so I'll clean it up and
> > post it tomorrow. I've spotted a couple of pre-existing issues at the same
> > time, so I need to fix those first (WEAK_LOCAL_CPU_FEATURE doesn't set the
> > cap for late CPUs and failed onlining causes RCU stalls).
> 
> FWIW I have my v3 over here in case it's of any help. It solves the problem of
> HWCAP discovery when late AArch32 CPU is booted by populating boot_cpu_date
> with 32bit features then.
> 
> 	git clone https://git.gitlab.arm.com/linux-arm/linux-qy.git -b asym-aarch32-upstream-v3 origin/asym-aarch32-upstream-v3

Cheers, I've done something similar. I was hoping to post it today, but I've
been side-tracked with bug fixing this morning. The main headache I ended up
with was allowing late-onlining of 64-bit-only CPUs if all the boot CPUs
are 32-bit capable. What do you do in that case?

Will
