Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDE1E7158
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2019 13:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfJ1M3R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Oct 2019 08:29:17 -0400
Received: from foss.arm.com ([217.140.110.172]:39418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727503AbfJ1M3R (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 Oct 2019 08:29:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 705DB1F1;
        Mon, 28 Oct 2019 05:29:16 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CD743F6C4;
        Mon, 28 Oct 2019 05:29:15 -0700 (PDT)
Date:   Mon, 28 Oct 2019 12:29:09 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Richard Henderson <richard.henderson@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will@kernel.org, Dave.Martin@arm.com, linux-arch@vger.kernel.org,
        ard.biesheuvel@linaro.org
Subject: Re: [PATCH 1/1] arm64: Implement archrandom.h for ARMv8.5-RNG
Message-ID: <20191028122908.GA48742@lakrids.cambridge.arm.com>
References: <20191019022048.28065-1-richard.henderson@linaro.org>
 <20191019022048.28065-2-richard.henderson@linaro.org>
 <20191024113239.GC4300@lakrids.cambridge.arm.com>
 <bdadd4bf-1848-bef1-89c3-2d594cf3be16@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bdadd4bf-1848-bef1-89c3-2d594cf3be16@linaro.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Oct 27, 2019 at 01:14:15PM +0100, Richard Henderson wrote:
> On 10/24/19 1:32 PM, Mark Rutland wrote:
> >> +static inline bool arch_get_random_seed_long(unsigned long *v)
> >> +{
> >> +	/* If RNDR fails, attempt to re-seed with RNDRRS.  */
> >> +	return arch_has_random_seed() && (arm_rndr(v) || arm_rndrrs(v));
> >> +}
> > 
> > Here we clobber the value at v even if the reads of RNDR and RNDRRS
> > failed. Is that ok?
> 
> The x86 inline asm does, so I should think it is ok.

Ok. Could we please note that in the commit message? That way it
shouldn't be asked again in review. :)

Otherwise, doing the assignment conditional would be nice. The compiler
should be able to optimize away the conditional when it would be
clobbered, and we could get a compiler warning for the case where an
uninitialized value would be consumed.

> >> +#ifdef CONFIG_ARCH_RANDOM
> >> +static bool can_use_rng(const struct arm64_cpu_capabilities *entry, int scope)
> >> +{
> >> +	unsigned long tmp;
> >> +	int i;
> >> +
> >> +	if (!has_cpuid_feature(entry, scope))
> >> +		return false;
> >> +
> >> +	/*
> >> +	 * Re-seed from the true random number source.
> >> +	 * If this fails, disable the feature.
> >> +	 */
> >> +	for (i = 0; i < 10; ++i) {
> >> +		if (arm_rndrrs(&tmp))
> >> +			return true;
> >> +	}
> > 
> > The ARM ARM (ARM DDI 0487E.a) says:
> > 
> > | Reseeded Random Number. Returns a 64-bit random number which is
> > | reseeded from the True Random Number source at an IMPLEMENTATION
> > | DEFINED rate.
> > 
> > ... and:
> > 
> > | If the instruction cannot return a genuine random number in a
> > | reasonable period of time, PSTATE.NZCV is set to 0b0100 and the data
> > | value returned in UNKNOWN.
> > 
> > ... so it's not clear to me if the retry logic makes sense. Naively I'd
> > expect "reasonable period of time" to include 10 attempts.
> > 
> > Given we'll have to handle failure elsewhere, I suspect that it might be
> > best to assume that this works until we encounter evidence to the
> > contrary.
> 
> Compare arch/x86/kernel/cpu/rdrand.c (x86_init_rdrand) and
> arch/powerpc/platforms/powernv/rng.c (initialize_darn).

One thing to bear in mind here is that for arm64 we're likely to have a
larger envelope of implementations, and unlike x86 and powerpc we're at
the mercy of second-party integration.

> Both existing implementations have a small loop testing to see of the hardware
> passes its own self-check at startup.  Perhaps it's simply paranoia, but it
> didn't seem untoward to check.

My concern is that whatever loop bound we choose could fall either side
of that "reasonable period" on some implementations, so whether or not
we detect the RNG will be effectively random.

The current wording of the ARM ARM suggests "a reasonable period of
time" could be larger than a few iterations of the loop:

| The definition of “reasonable period of time” is IMPLEMENTATION
| DEFINED. The expectation is that software might use this as an
| opportunity to reschedule or run a different routine, perhaps after a
| small number of retries have failed to return a valid value.

Given that, I'd be happier if we always trusted the ID register to
determine the presence of the RNG, and failing the check only resulted
in a pr_warn() that the RNG might not be producing entropy at a
sufficient rate.

We might need more architectural guidance/clarification here, given that
seems to not be in line with expectations on other architectures.

> >> +#ifdef CONFIG_ARCH_RANDOM
> >> +	{
> >> +		.desc = "Random Number Generator",
> >> +		.capability = ARM64_HAS_RNG,
> >> +		.type = ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE,
> > 
> > I strongly suspect we're going to encounter systems where this feature
> > is mismatched, such that this can't be a boto CPU feature.
> > 
> > If we need entropy early in boot, we could detect if the boot CPU had
> > the feature, and seed the pool using it, then later make use of a
> > system-wide capability.
> 
> In the meantime, what do you suggest I place here and in
> arch_has_random_seed(), so that it's at least detected early enough for the
> boot cpu, but does not require support from all cpus?

I'd suggest first doing the generic all-cpus support, with the boot CPU
being a separate special case.

For the boot CPU we might only need a separate callback to seed that
entropy into the main pool. That can either check a local cap or read
the ID register directly.

How much entropy are we liable to consume before bringing up
secondaries? IIRC that's for things like allocator randomization, and I
presume that seeding the main pool would be sufficient for that.

Thanks,
Mark.
