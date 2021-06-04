Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A5139B786
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 13:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhFDLHU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 07:07:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229692AbhFDLHU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Jun 2021 07:07:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 23FD861159;
        Fri,  4 Jun 2021 11:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622804734;
        bh=F6qdZyzEiXprcFunaXrWBdEWvmBNTkX5sFnDNIAVD0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xo760dFfoA6jHGH4cw6Kt7dVLtRAxU+GtKkqVqk+C0OnZu3tXlLwUkixPeVaZyi4A
         K4zM2+iCl8dDTdB+ZDY8PGDD7yE491gP1glhtCdmKtimxTQqWIOoO+E1eUjcy4/PmR
         QTh8+IufqjF8El+xZJqXV88SkNMLzNeUlJWqWed2Ojj7gYHRx++R3mM5a4LAFdAjuB
         H7u9QLxkesGz+WGybxUwbQG2v7uGUiP6zVtM2YsnM6j5Py9BboKXP229KNN8fgVeCG
         FRmZFipqlKpPHutqnc+Wzx9jUDXkb8LK5rPQVggALSfSyoFoBd7mfTvB8fFj0fPxYp
         97TqtUP4rzn/g==
Date:   Fri, 4 Jun 2021 12:05:27 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        kernel-team@android.com
Subject: Re: [PATCH v8 02/19] arm64: Allow mismatched 32-bit EL0 support
Message-ID: <20210604110526.GF2318@willie-the-truck>
References: <20210602164719.31777-1-will@kernel.org>
 <20210602164719.31777-3-will@kernel.org>
 <20210603123715.GA48596@C02TD0UTHF1T.local>
 <20210603174413.GC1170@willie-the-truck>
 <20210604093808.GA64162@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604093808.GA64162@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 10:38:08AM +0100, Mark Rutland wrote:
> On Thu, Jun 03, 2021 at 06:44:14PM +0100, Will Deacon wrote:
> > On Thu, Jun 03, 2021 at 01:37:15PM +0100, Mark Rutland wrote:
> > > On Wed, Jun 02, 2021 at 05:47:02PM +0100, Will Deacon wrote:
> > > > diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> > > > index 338840c00e8e..603bf4160cd6 100644
> > > > --- a/arch/arm64/include/asm/cpufeature.h
> > > > +++ b/arch/arm64/include/asm/cpufeature.h
> > > > @@ -630,9 +630,15 @@ static inline bool cpu_supports_mixed_endian_el0(void)
> > > >  	return id_aa64mmfr0_mixed_endian_el0(read_cpuid(ID_AA64MMFR0_EL1));
> > > >  }
> > > >  
> > > > +const struct cpumask *system_32bit_el0_cpumask(void);
> > > > +DECLARE_STATIC_KEY_FALSE(arm64_mismatched_32bit_el0);
> > > > +
> > > >  static inline bool system_supports_32bit_el0(void)
> > > >  {
> > > > -	return cpus_have_const_cap(ARM64_HAS_32BIT_EL0);
> > > > +	u64 pfr0 = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
> > > > +
> > > > +	return static_branch_unlikely(&arm64_mismatched_32bit_el0) ||
> > > > +	       id_aa64pfr0_32bit_el0(pfr0);
> > > >  }
> > > 
> > > Note that read_sanitised_ftr_reg() has to do a bsearch() to find the
> > > arm64_ftr_reg, so this will make system_32bit_el0_cpumask() a fair
> > > amount more expensive than it needs to be.
> > 
> > I seriously doubt that it matters, but it did come up before and I proposed
> > a potential solution if it's actually a concern:
> > 
> > https://lore.kernel.org/r/20201202172727.GC29813@willie-the-truck
> > 
> > so if you can show that it's a problem, we can resurrect something like
> > that.
> 
> I'm happy to leave that for future. I raised this because elsewhere this
> is an issue when we need to avoid instrumentation; if that's not a
> concern here on any path then I am not aware of a functional issue.

I can't think of a reason why instrumentation would be an issue for any of
the current callers, but that's a good point to bear in mind.

> > > That said. I reckon this could be much cleaner if we maintained separate
> > > caps:
> > > 
> > > ARM64_ALL_CPUS_HAVE_32BIT_EL0
> > > ARM64_SOME_CPUS_HAVE_32BIT_EL0
> > > 
> > > ... and allow arm64_mismatched_32bit_el0 to be set dependent on
> > > ARM64_SOME_CPUS_HAVE_32BIT_EL0. With that, this can be simplified to:
> > > 
> > > static inline bool system_supports_32bit_el0(void)
> > > {
> > > 	return (cpus_have_const_cap(ARM64_ALL_CPUS_HAVE_32BIT_EL0)) ||
> > > 		static_branch_unlikely(&arm64_mismatched_32bit_el0))
> > 
> > Something similar was discussed in November last year but this falls
> > apart with late onlining because its not generally possible to tell whether
> > you've seen all the CPUs or not.
> 
> Ah; is that for when your boot CPU set is all AArch32-capable, but a
> late-onlined CPU is not?
> 
> I assume that we require at least one of the set of boot CPUs to be
> AArch32 cpable, and don't settle the compat hwcaps after userspace has
> started.

Heh, you assume wrong :)

When we allow the mismatch, then we do actually defer initialisation of
the compat hwcaps until we see a 32-bit CPU. That's fine, as they won't
be visible to userspace until then anyway (PER_LINUX32 is unavailable).

Will
