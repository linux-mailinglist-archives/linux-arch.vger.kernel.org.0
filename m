Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3A22EF884
	for <lists+linux-arch@lfdr.de>; Fri,  8 Jan 2021 21:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbhAHUFO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Jan 2021 15:05:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:42758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728591AbhAHUFN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 Jan 2021 15:05:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC7BD23AC1;
        Fri,  8 Jan 2021 20:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610136272;
        bh=T47xtOEvTBHFkDBTqXburOGKEuBqJ+GKMtIQp3kkTNY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u416JfembgemnbQkoIWkdxx5ZHHdtNAOGt7/pTfFlk/cy/X4qzRaT+GMJveRaG1EC
         ekeVlUsf/P6hOz7oQ1AYlvbhtl7hcwbBcgdvtqXZs5YoIgTghEqIUU760hBI/4MDqG
         EcqHBQLrJdwIVANM+//WMmG7LGQaRuTLhow+JbSN5kidmT5YhtJiufKT4LqOvPtLxI
         v/lAmRkKn0BtCZ6KDkq4YaF4n1fJSTGfhNzc2izW0DzlYielG09q7mjM4rO91TNe3h
         DKV8JxtZVzAWTK2oC0cs4D56JUFTS+PZyqoOp/4OtJKxvRgI2F+FT+lzLj/pg69UI0
         3L8CrHcVZP5rw==
Received: by mail-oi1-f178.google.com with SMTP id d203so12742055oia.0;
        Fri, 08 Jan 2021 12:04:31 -0800 (PST)
X-Gm-Message-State: AOAM532BsWdwXBNAg5TSpba0edTOwsHiv/L9Zg/5gMeUbi8+YrYGPvFI
        vXUwSNnQTIziBavw9qkaNZ36IybF0qQkYkqQYMM=
X-Google-Smtp-Source: ABdhPJxATZPVdRGw1Y77MsH/MzYIApYMZo97oQswnKgdRlnEmvjHBpySt2ml5Cwi7JuuWKd5G8aDQOgtoh+EFcUDiKE=
X-Received: by 2002:aca:fd91:: with SMTP id b139mr3239039oii.67.1610136271246;
 Fri, 08 Jan 2021 12:04:31 -0800 (PST)
MIME-Version: 1.0
References: <20210108092024.4034860-1-arnd@kernel.org> <20210108093258.GB4031@willie-the-truck>
 <CAK8P3a27y_EM6s3SwH1e6FR7bqeT3PEoLbxSWPyZ=4BzqAjceg@mail.gmail.com> <20210108185047.GB5457@willie-the-truck>
In-Reply-To: <20210108185047.GB5457@willie-the-truck>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 8 Jan 2021 21:04:14 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2CfL5CsLcqtb8mOjUmZyRu_RPLj-qHOV3yfwmHHcO+5Q@mail.gmail.com>
Message-ID: <CAK8P3a2CfL5CsLcqtb8mOjUmZyRu_RPLj-qHOV3yfwmHHcO+5Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: make atomic helpers __always_inline
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 8, 2021 at 7:50 PM Will Deacon <will@kernel.org> wrote:
> On Fri, Jan 08, 2021 at 11:26:53AM +0100, Arnd Bergmann wrote:
> >
> > a) fully inline it as the __always_inline attribute does
> > b) not inline it at all, treating it as a regular static function
> > c) create a specialized version with different calling conventions
> >
> > In this case, clang goes with option c when it notices that all
> > callers pass the same constant pointer. This means we have a
> > synthetic
> >
> > static noinline long arch_atomic64_or(long i)
> > {
> >         return __lse_ll_sc_body(atomic64_fetch_or, i, &numa_nodes_parsed);
> > }
> >
> > which is a few bytes shorter than option b as it saves a load in the
> > caller. This function definition however violates the kernel's rules
> > for section references, as the synthetic version is not marked __init.
>
> Ah, I was hoping the compiler would've sorted that out, but then again, how
> would it know? But doesn't this mean that whenever we get one caller passing
> something like an __initdata pointer to a function, then that function needs
> to be __always_inline for everybody? It feels like a slippery slope
> considering the incentive to go back and replace it with 'inline' if the
> caller goes away is very small.

It showed up after UBSAN was enabled, which changed in the inlining rules.
I think we've had similar cases in the past, and worked around them in the
same way. IIRC there were two or three such instances this time, and only
in functions that are supposed to be only a handful of instructions long.

One thing I did not try though was to look at the object file to find
out why it has done this. Here is the generated assembler code for reference:

        .p2align        2                               // -- Begin
function arch_atomic64_or
        .type   arch_atomic64_or,@function
arch_atomic64_or:                       // @arch_atomic64_or
// %bb.0:
        hint    #25
        stp     x29, x30, [sp, #-48]!           // 16-byte Folded Spill
        stp     x20, x19, [sp, #32]             // 16-byte Folded Spill
        mov     x19, x1
        mov     x20, x0
        str     x21, [sp, #16]                  // 8-byte Folded Spill
        mov     x29, sp
        //APP
        1:      b               .Ltmp2
                .pushsection    __jump_table, "aw"
                .align          3
                .long           1b - ., .Ltmp2 - .
                .quad           arm64_const_caps_ready+1 - .
                .popsection

        //NO_APP
// %bb.1:
        mov     w21, wzr
.LBB19_2:
        adrp    x0, system_uses_lse_atomics.______f
        eor     w1, w21, #0x1
        add     x0, x0, :lo12:system_uses_lse_atomics.______f
        mov     w2, #1
        mov     w3, wzr
        bl      ftrace_likely_update
        tbnz    w21, #0, .LBB19_7
// %bb.3:
        //APP
        1:      b               .Ltmp3
                .pushsection    __jump_table, "aw"
                .align          3
                .long           1b - ., .Ltmp3 - .
                .quad           cpu_hwcap_keys+81 - .
                .popsection

        //NO_APP
// %bb.4:
        mov     w21, #1
.LBB19_5:
        adrp    x0, system_uses_lse_atomics.______f.20
        add     x0, x0, :lo12:system_uses_lse_atomics.______f.20
        mov     w2, #1
        mov     w1, w21
        mov     w3, wzr
        bl      ftrace_likely_update
        cbz     w21, .LBB19_7
// %bb.6:
        //APP
        .arch_extension lse
        stset   x20, [x19]

        //NO_APP
        b       .LBB19_8
.LBB19_7:
        //APP
        // atomic64_or
        b       3f
        .subsection     1
3:
        prfm    pstl1strm, [x19]
1:      ldxr    x8, [x19]
        orr     x8, x8, x20
        stxr    w9, x8, [x19]
        cbnz    w9, 1b
        b       4f
        .previous
4:

        //NO_APP
.LBB19_8:
        ldp     x20, x19, [sp, #32]             // 16-byte Folded Reload
        ldr     x21, [sp, #16]                  // 8-byte Folded Reload
        ldp     x29, x30, [sp], #48             // 16-byte Folded Reload
        hint    #29
        ret
.Ltmp2:                                 // Block address taken
.LBB19_9:
        mov     w21, #1
        b       .LBB19_2
.Ltmp3:                                 // Block address taken
.LBB19_10:
        mov     w21, wzr
        b       .LBB19_5
.Lfunc_end19:
        .size   arch_atomic64_or, .Lfunc_end19-arch_atomic64_or
                                        // -- End function
        .section        .init.text,"ax",@progbits
        .p2align        2                               // -- Begin
function early_cpu_to_node


Admittedly, now that I look at the output, I tend to agree with the
compiler that it should not be inlined and my approach was wrong!

And indeed, CONFIG_UBSAN does not even change the contents of
the function, but it does reduce the amount of inlining overall, so
without UBSAN it does not happen.

This patch actually avoids the out-of-line version as well
and also produces simpler code, leaving the effect of static_branch
working, though still suffering from the ftrace_likely_update()
update.

diff --git a/arch/arm64/include/asm/lse.h b/arch/arm64/include/asm/lse.h
index 5d10051c3e62..2b83b66d8767 100644
--- a/arch/arm64/include/asm/lse.h
+++ b/arch/arm64/include/asm/lse.h
@@ -19,7 +19,7 @@
 extern struct static_key_false cpu_hwcap_keys[ARM64_NCAPS];
 extern struct static_key_false arm64_const_caps_ready;

-static inline bool system_uses_lse_atomics(void)
+static __always_inline bool system_uses_lse_atomics(void)
 {
        return (static_branch_likely(&arm64_const_caps_ready)) &&
                static_branch_likely(&cpu_hwcap_keys[ARM64_HAS_LSE_ATOMICS]);

> Didn't we used to #define inline as __always_inline to avoid this situation?

Yes, that was the case in the past, except on x86, which had
CONFIG_OPTIMIZE_INLINING as an option. These two commits
subsequently changed the behavior to let the compiler make the
decision instead:

889b3c1245de ("compiler: remove CONFIG_OPTIMIZE_INLINING entirely")
ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING forcibly")

      Arnd
