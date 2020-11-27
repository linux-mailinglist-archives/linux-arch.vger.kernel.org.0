Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD61B2C6416
	for <lists+linux-arch@lfdr.de>; Fri, 27 Nov 2020 12:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbgK0Lud (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Nov 2020 06:50:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:60232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbgK0Luc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Nov 2020 06:50:32 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BCF621D46;
        Fri, 27 Nov 2020 11:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606477831;
        bh=LtVP95hrMMclG30wUBaX1D+fuXhT9e1/YraMHggZoh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=baVlIfO4opAFzmlCelU1RQ/Ds6muHOTAl+KSi62Xbp8/MIWJqKnE0Ve3lP4Y6gy7P
         b+esiDjwFAuzVUsRCaxta69kKtcv3ECBwbgqVWIQJ7E16ksrQR+LQ0mwbI0qq294ts
         mqWKmcetdnshC1gijJOw7q0zMyvniz8Fltl0Snzk=
Date:   Fri, 27 Nov 2020 11:50:24 +0000
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v4 02/14] arm64: Allow mismatched 32-bit EL0 support
Message-ID: <20201127115024.GA20564@willie-the-truck>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-3-will@kernel.org>
 <d7dfc12ca87d65fad79bfe2cd697a28d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7dfc12ca87d65fad79bfe2cd697a28d@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 27, 2020 at 10:25:06AM +0000, Marc Zyngier wrote:
> On 2020-11-24 15:50, Will Deacon wrote:
> > When confronted with a mixture of CPUs, some of which support 32-bit
> > applications and others which don't, we quite sensibly treat the system
> > as 64-bit only for userspace and prevent execve() of 32-bit binaries.
> > 
> > Unfortunately, some crazy folks have decided to build systems like this
> > with the intention of running 32-bit applications, so relax our
> > sanitisation logic to continue to advertise 32-bit support to userspace
> > on these systems and track the real 32-bit capable cores in a cpumask
> > instead. For now, the default behaviour remains but will be tied to
> > a command-line option in a later patch.
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  arch/arm64/include/asm/cpucaps.h    |   2 +-
> >  arch/arm64/include/asm/cpufeature.h |   8 ++-
> >  arch/arm64/kernel/cpufeature.c      | 106 ++++++++++++++++++++++++++--
> >  3 files changed, 107 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/cpucaps.h
> > b/arch/arm64/include/asm/cpucaps.h
> > index e7d98997c09c..e6f0eb4643a0 100644
> > --- a/arch/arm64/include/asm/cpucaps.h
> > +++ b/arch/arm64/include/asm/cpucaps.h
> > @@ -20,7 +20,7 @@
> >  #define ARM64_ALT_PAN_NOT_UAO			10
> >  #define ARM64_HAS_VIRT_HOST_EXTN		11
> >  #define ARM64_WORKAROUND_CAVIUM_27456		12
> > -#define ARM64_HAS_32BIT_EL0			13
> > +#define ARM64_HAS_32BIT_EL0_DO_NOT_USE		13
> >  #define ARM64_HARDEN_EL2_VECTORS		14
> >  #define ARM64_HAS_CNP				15
> >  #define ARM64_HAS_NO_FPSIMD			16
> > diff --git a/arch/arm64/include/asm/cpufeature.h
> > b/arch/arm64/include/asm/cpufeature.h
> > index 97244d4feca9..f447d313a9c5 100644
> > --- a/arch/arm64/include/asm/cpufeature.h
> > +++ b/arch/arm64/include/asm/cpufeature.h
> > @@ -604,9 +604,15 @@ static inline bool
> > cpu_supports_mixed_endian_el0(void)
> >  	return id_aa64mmfr0_mixed_endian_el0(read_cpuid(ID_AA64MMFR0_EL1));
> >  }
> > 
> > +const struct cpumask *system_32bit_el0_cpumask(void);
> > +DECLARE_STATIC_KEY_FALSE(arm64_mismatched_32bit_el0);
> > +
> >  static inline bool system_supports_32bit_el0(void)
> >  {
> > -	return cpus_have_const_cap(ARM64_HAS_32BIT_EL0);
> > +	u64 pfr0 = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
> > +
> > +	return id_aa64pfr0_32bit_el0(pfr0) ||
> > +	       static_branch_unlikely(&arm64_mismatched_32bit_el0);
> 
> nit: swapping the two sides of this expression has the potential
> for slightly better code, resulting in better performance on
> these asymmetric systems. Not a big real, but since this lands
> on the fast path on vcpu exit, I'll take every bit of optimisation.

I'll swap 'em, thanks.

Will
