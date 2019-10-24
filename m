Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5D5E31A0
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2019 13:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409253AbfJXL6C (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Oct 2019 07:58:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36749 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfJXL6C (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Oct 2019 07:58:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id w18so25218111wrt.3
        for <linux-arch@vger.kernel.org>; Thu, 24 Oct 2019 04:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sE8dYDZ43uZW3CSaouzmc97GKxsc1NiNnmUnj69tzU8=;
        b=pDTGfi6bXHPfy5hLd7zNYlXI50UaSGepOYCqi5tI6BLWmzW8lRWx56uE0Y5x7YhsBR
         65fUPvCKtOT/c7TGkvfqBUb8EwLVtJ15WDS2wFyQqnStf4IXbVuplMrIpd2GbADpG6Uv
         eJA6etjUMC/uwf/SHn/8kRZlwWxwMKIcK4yl4/NIXVylbnFaSHb/Z7tNHpppbDh0DPnT
         IYfHg3OCR7Aurp1UItAI3oKKkhFvuQDQPJJoV9iLwWEafnXObFtFpnmYSALaFr9ciy+Z
         5M0+jqUt2E7hBFDBdZA5/TvT/tA0nrcgVjZCemrHOsg6wHIc8JaeUKntRWFCNXw2Z2Px
         l3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sE8dYDZ43uZW3CSaouzmc97GKxsc1NiNnmUnj69tzU8=;
        b=n+mdNrOsknEEqtLDmeWOT+OqUSVjh7epuBJZ8JsmdE/DnUohYYEZCBWBA5GUNBoZ1I
         ufo91NfGnBPtumCo/1kFxFacJdXwt7quTrJC15DemR+rOXPPIlxntGbRRQMRof77Vi0p
         oCDTVGmvg7pjgvpS3lTPoNX3Hz+fyIdBLyMZ/wsTA3zE8R2rfDAICtrNScVkj4zKaJIE
         zxet9rReJycUXJa9gYFdqnHO4FaL/HwyYKKGnbGZrkXKu2UPvJOF0xoA+GguBr5qfHIN
         SM7tfbaZTgj01EBh68NHjTkU9nQ7d/0P7hfGhMzcyy5EojmPY6mQWHDmoPeEe6TryBcu
         FKJA==
X-Gm-Message-State: APjAAAWbdDBG7pvT+xLjbAJMbVoG+cAU2EJLO3pITYtTb2QmucePlXbu
        sJR7TA0jl+o5vBJzXiVNlDHr4KLBxuWcBoON1nXyQA==
X-Google-Smtp-Source: APXvYqxCWykqlCtcbo2oAz/obGIym8n44EFhTY0cRrap+xA3DbeXo1ewTzn14mqT2s2yZho5e+W2ev3mBydXfhmtL3o=
X-Received: by 2002:adf:8289:: with SMTP id 9mr3745748wrc.0.1571918276763;
 Thu, 24 Oct 2019 04:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <20191019022048.28065-1-richard.henderson@linaro.org>
 <20191019022048.28065-2-richard.henderson@linaro.org> <20191024113239.GC4300@lakrids.cambridge.arm.com>
In-Reply-To: <20191024113239.GC4300@lakrids.cambridge.arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 24 Oct 2019 13:57:52 +0200
Message-ID: <CAKv+Gu9uoJk8iqGASP3KvZK+4GMo=5ckD5DSzdOAmCJuOQNiUA@mail.gmail.com>
Subject: Re: [PATCH 1/1] arm64: Implement archrandom.h for ARMv8.5-RNG
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Richard Henderson <richard.henderson@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Richard, Mark,

Thanks for picking this up. I was literally about to hit send on a
series of my own implementing the same (or actually, I did hit send
but ARM FossMail rejected it).

On Thu, 24 Oct 2019 at 13:32, Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi Richard,
>
> On Fri, Oct 18, 2019 at 07:20:48PM -0700, Richard Henderson wrote:
> > Expose the ID_AA64ISAR0.RNDR field to userspace, as the
> > RNG system registers are always available at EL0.
> >
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >  Documentation/arm64/cpu-feature-registers.rst |  2 +
> >  arch/arm64/include/asm/archrandom.h           | 76 +++++++++++++++++++
> >  arch/arm64/include/asm/cpucaps.h              |  3 +-
> >  arch/arm64/include/asm/sysreg.h               |  1 +
> >  arch/arm64/kernel/cpufeature.c                | 34 +++++++++
> >  arch/arm64/Kconfig                            | 12 +++
> >  drivers/char/Kconfig                          |  4 +-
>
> I suspect that we may need KVM changes -- e.g. the ability to hide this
> from guests.
>

These instructions are unconditionally enabled (if implemented) all
the way down to EL0, so I'm not sure if there is a lot of meaningful
hiding we can do here.

> >  7 files changed, 129 insertions(+), 3 deletions(-)
> >  create mode 100644 arch/arm64/include/asm/archrandom.h
> >
> > diff --git a/Documentation/arm64/cpu-feature-registers.rst b/Documentation/arm64/cpu-feature-registers.rst
> > index 2955287e9acc..78d6f5c6e824 100644
> > --- a/Documentation/arm64/cpu-feature-registers.rst
> > +++ b/Documentation/arm64/cpu-feature-registers.rst
> > @@ -117,6 +117,8 @@ infrastructure:
> >       +------------------------------+---------+---------+
> >       | Name                         |  bits   | visible |
> >       +------------------------------+---------+---------+
> > +     | RNDR                         | [63-60] |    y    |
> > +     +------------------------------+---------+---------+
> >       | TS                           | [55-52] |    y    |
> >       +------------------------------+---------+---------+
> >       | FHM                          | [51-48] |    y    |
> > diff --git a/arch/arm64/include/asm/archrandom.h b/arch/arm64/include/asm/archrandom.h
> > new file mode 100644
> > index 000000000000..80369898e274
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/archrandom.h
> > @@ -0,0 +1,76 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ASM_ARCHRANDOM_H
> > +#define _ASM_ARCHRANDOM_H
> > +
> > +#include <asm/cpufeature.h>
> > +
> > +/* Unconditional execution of RNDR and RNDRRS.  */
> > +
> > +static inline bool arm_rndr(unsigned long *v)
> > +{
> > +     int pass;
> > +
> > +     asm("mrs %0, s3_3_c2_c4_0\n\t"  /* RNDR */
> > +         "cset %w1, ne"
> > +         : "=r"(*v), "=r"(pass));
> > +     return pass != 0;
> > +}
>
> Please give this a menmoic in <asm/sysreg.h>, i.e.
>
> #define SYS_RNDR        sys_reg(3, 3, 2, 4, 0)
>
> ... and make this function:
>
> static inline bool read_rndr(unsigned long *v)
> {
>         unsigned long pass;
>
>         /*
>          * Reads of RNDR set PSTATE.NZCV to 0b0000 upon success, and set
>          * PSTATE.NZCV to 0b0100 otherwise.
>          */
>         asm volatile(
>                 __mrs_s("%0", SYS_RNDR) "\n"
>         "       cset %1, ne\n"
>         : "=r" (*v), "=r" (pass);
>         :
>         : "cc");
>
>         return pass;
> }
>
> Note that the cc clobber is important in case this gets inlined!
>
> > +
> > +static inline bool arm_rndrrs(unsigned long *v)
> > +{
> > +     int pass;
> > +
> > +     asm("mrs %0, s3_3_c2_c4_1\n\t"  /* RNDRRS */
> > +         "cset %w1, ne"
> > +         : "=r"(*v), "=r"(pass));
> > +     return pass != 0;
> > +}
>
> Likewise, in <asm/sysreg.h>, add:
>
> #define SYS_RNDRRS      sys_reg(3, 3, 2, 4, 1)
>
> ...and here have:
>
> static inline bool read_rndrrs(unsigned long *v)
> {
>         unsigned long pass;
>
>         /*
>          * Reads of RNDRRS set PSTATE.NZCV to 0b0000 upon success, and
>          * set PSTATE.NZCV to 0b0100 otherwise.
>          */
>         asm volatile (
>                 __mrs_s("%0", SYS_RNDRRS) "\n"
>         "       cset %w1, ne\n"
>         : "=r" (*v), "=r" (pass)
>         :
>         : "cc");
>
>         return pass;
> }
>
> > +
> > +#ifdef CONFIG_ARCH_RANDOM
> > +
> > +/*
> > + * Note that these two interfaces, random and random_seed, are strongly
> > + * tied to the Intel instructions RDRAND and RDSEED.  RDSEED is the
> > + * "enhanced" version and has stronger guarantees.  The ARMv8.5-RNG
> > + * instruction RNDR corresponds to RDSEED, thus we put our implementation
> > + * into the random_seed set of functions.
> > + *

Is that accurate? The ARM ARM says that RNDR is backed by a DRBG which

""
...is reseeded after an IMPLEMENTATION DEFINED number of random
numbers has been generated and read
using the RNDR register.
"""

which means that you cannot rely on this reseeding to take place at all.

So the way I read this, RNDR ~= RDRAND and RNDRRS ~= RDSEED, and we
should wire up the functions below accordingly.

> > + * Note as well that Intel does not have an instruction that corresponds
> > + * to the RNDRRS instruction, so there's no generic interface for that.
> > + */
> > +static inline bool arch_has_random(void)
> > +{
> > +     return false;
> > +}
> > +
> > +static inline bool arch_get_random_long(unsigned long *v)
> > +{
> > +     return false;
> > +}
> > +
> > +static inline bool arch_get_random_int(unsigned int *v)
> > +{
> > +     return false;
> > +}
> > +
> > +static inline bool arch_has_random_seed(void)
> > +{
> > +     return cpus_have_const_cap(ARM64_HAS_RNG);
> > +}
> > +
> > +static inline bool arch_get_random_seed_long(unsigned long *v)
> > +{
> > +     /* If RNDR fails, attempt to re-seed with RNDRRS.  */
> > +     return arch_has_random_seed() && (arm_rndr(v) || arm_rndrrs(v));
> > +}
>
> Here we clobber the value at v even if the reads of RNDR and RNDRRS
> failed. Is that ok?
>
> Maybe we want the accessors to only assign to v upon success.
>

I'd be more comfortable with this if arch_get_random_*() were
annotated as __must_check, and the assignment only done conditionally.

> > +
> > +static inline bool arch_get_random_seed_int(unsigned int *v)
> > +{
> > +     unsigned long vl = 0;
> > +     bool ret = arch_get_random_seed_long(&vl);
> > +     *v = vl;
> > +     return ret;
> > +}
> > +
> > +#endif /* CONFIG_ARCH_RANDOM */
> > +#endif /* _ASM_ARCHRANDOM_H */
> > diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
> > index f19fe4b9acc4..2fc15765d25d 100644
> > --- a/arch/arm64/include/asm/cpucaps.h
> > +++ b/arch/arm64/include/asm/cpucaps.h
> > @@ -52,7 +52,8 @@
> >  #define ARM64_HAS_IRQ_PRIO_MASKING           42
> >  #define ARM64_HAS_DCPODP                     43
> >  #define ARM64_WORKAROUND_1463225             44
> > +#define ARM64_HAS_RNG                                45
> >
> > -#define ARM64_NCAPS                          45
> > +#define ARM64_NCAPS                          46
> >
> >  #endif /* __ASM_CPUCAPS_H */
> > diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> > index 972d196c7714..7a0c159661cd 100644
> > --- a/arch/arm64/include/asm/sysreg.h
> > +++ b/arch/arm64/include/asm/sysreg.h
> > @@ -539,6 +539,7 @@
> >                        ENDIAN_SET_EL1 | SCTLR_EL1_UCI  | SCTLR_EL1_RES1)
> >
> >  /* id_aa64isar0 */
> > +#define ID_AA64ISAR0_RNDR_SHIFT              60
> >  #define ID_AA64ISAR0_TS_SHIFT                52
> >  #define ID_AA64ISAR0_FHM_SHIFT               48
> >  #define ID_AA64ISAR0_DP_SHIFT                44
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index cabebf1a7976..34b9731e1fab 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -119,6 +119,7 @@ static void cpu_enable_cnp(struct arm64_cpu_capabilities const *cap);
> >   * sync with the documentation of the CPU feature register ABI.
> >   */
> >  static const struct arm64_ftr_bits ftr_id_aa64isar0[] = {
> > +     ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_RNDR_SHIFT, 4, 0),
> >       ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_TS_SHIFT, 4, 0),
> >       ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_FHM_SHIFT, 4, 0),
> >       ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_DP_SHIFT, 4, 0),
> > @@ -1261,6 +1262,27 @@ static bool can_use_gic_priorities(const struct arm64_cpu_capabilities *entry,
> >  }
> >  #endif
> >
> > +#ifdef CONFIG_ARCH_RANDOM
> > +static bool can_use_rng(const struct arm64_cpu_capabilities *entry, int scope)
> > +{
> > +     unsigned long tmp;
> > +     int i;
> > +
> > +     if (!has_cpuid_feature(entry, scope))
> > +             return false;
> > +
> > +     /*
> > +      * Re-seed from the true random number source.
> > +      * If this fails, disable the feature.
> > +      */
> > +     for (i = 0; i < 10; ++i) {
> > +             if (arm_rndrrs(&tmp))
> > +                     return true;
> > +     }
>
> The ARM ARM (ARM DDI 0487E.a) says:
>
> | Reseeded Random Number. Returns a 64-bit random number which is
> | reseeded from the True Random Number source at an IMPLEMENTATION
> | DEFINED rate.
>
> ... and:
>
> | If the instruction cannot return a genuine random number in a
> | reasonable period of time, PSTATE.NZCV is set to 0b0100 and the data
> | value returned in UNKNOWN.
>
> ... so it's not clear to me if the retry logic makes sense. Naively I'd
> expect "reasonable period of time" to include 10 attempts.
>
> Given we'll have to handle failure elsewhere, I suspect that it might be
> best to assume that this works until we encounter evidence to the
> contrary.
>

The architecture isn't very clear about what a reasonable period of
time is, but the fact that it can fail transiently suggests that
trying it only once doesn't make a lot of sense. However, I'm not sure
whether having a go at probe time is helpful in deciding whether we
can use it at all, and I'd be inclined to drop this test altogether.
This is especially true since we cannot stop EL0 or VMs at EL1 using
the instruction.

> > +     return false;
> > +}
> > +#endif
> > +
> >  static const struct arm64_cpu_capabilities arm64_features[] = {
> >       {
> >               .desc = "GIC system register CPU interface",
> > @@ -1560,6 +1582,18 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
> >               .sign = FTR_UNSIGNED,
> >               .min_field_value = 1,
> >       },
> > +#endif
> > +#ifdef CONFIG_ARCH_RANDOM
> > +     {
> > +             .desc = "Random Number Generator",
> > +             .capability = ARM64_HAS_RNG,
> > +             .type = ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE,
>
> I strongly suspect we're going to encounter systems where this feature
> is mismatched, such that this can't be a boto CPU feature.
>
> If we need entropy early in boot, we could detect if the boot CPU had
> the feature, and seed the pool using it, then later make use of a
> system-wide capability.
>


> Thanks,
> Mark.
>
> > +             .matches = can_use_rng,
> > +             .sys_reg = SYS_ID_AA64ISAR0_EL1,
> > +             .field_pos = ID_AA64ISAR0_RNDR_SHIFT,
> > +             .sign = FTR_UNSIGNED,
> > +             .min_field_value = 1,
> > +     },
> >  #endif
> >       {},
> >  };
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 950a56b71ff0..a035c178102a 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -1421,6 +1421,18 @@ config ARM64_PTR_AUTH
> >
> >  endmenu
> >
> > +menu "ARMv8.5 architectural features"
> > +
> > +config ARCH_RANDOM
> > +     bool "Enable support for random number generation"
> > +     default y
> > +     help
> > +       Random number generation (part of the ARMv8.5 Extensions)
> > +       provides a high bandwidth, cryptographically secure
> > +       hardware random number generator.
> > +
> > +endmenu
> > +
> >  config ARM64_SVE
> >       bool "ARM Scalable Vector Extension support"
> >       default y
> > diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> > index df0fc997dc3e..f26a0a8cc0d0 100644
> > --- a/drivers/char/Kconfig
> > +++ b/drivers/char/Kconfig
> > @@ -539,7 +539,7 @@ endmenu
> >
> >  config RANDOM_TRUST_CPU
> >       bool "Trust the CPU manufacturer to initialize Linux's CRNG"
> > -     depends on X86 || S390 || PPC
> > +     depends on X86 || S390 || PPC || ARM64
> >       default n
> >       help
> >       Assume that CPU manufacturer (e.g., Intel or AMD for RDSEED or
> > @@ -559,4 +559,4 @@ config RANDOM_TRUST_BOOTLOADER
> >       device randomness. Say Y here to assume the entropy provided by the
> >       booloader is trustworthy so it will be added to the kernel's entropy
> >       pool. Otherwise, say N here so it will be regarded as device input that
> > -     only mixes the entropy pool.
> > \ No newline at end of file
> > +     only mixes the entropy pool.
> > --
> > 2.17.1
> >
