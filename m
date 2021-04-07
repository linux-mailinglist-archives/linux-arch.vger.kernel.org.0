Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD643356740
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 10:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345632AbhDGIyw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 04:54:52 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:41131 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349703AbhDGIxM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2021 04:53:12 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M1Yl9-1lS9AN1MRn-0034Af; Wed, 07 Apr 2021 10:43:08 +0200
Received: by mail-ot1-f47.google.com with SMTP id 68-20020a9d0f4a0000b02901b663e6258dso17263939ott.13;
        Wed, 07 Apr 2021 01:43:07 -0700 (PDT)
X-Gm-Message-State: AOAM533Dd0ClEcFro0aqnnX61V76Ru0dKrla0GERBoBHH9EkSR4/jA1l
        KjsXspYwrQQKRtzwmTw8mkVsbR4r3/mK4c+h3Zo=
X-Google-Smtp-Source: ABdhPJyEzzeePiTksGgoW6JxcSZ73Zq5OLkAoMy2RnSW8XEgaIbyDDdmoeKSyjV9qiGXc17VtYYeor2UEEylyRze7MQ=
X-Received: by 2002:a9d:758b:: with SMTP id s11mr2061872otk.305.1617784986795;
 Wed, 07 Apr 2021 01:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAJF2gTQNV+_txMHJw0cmtS-xcnuaCja-F7XBuOL_J0yN39c+uQ@mail.gmail.com>
 <YGG5c4QGq6q+lKZI@hirez.programming.kicks-ass.net> <CAJF2gTQUe237NY-kh+4_Yk4DTFJmA5_xgNQ5+BMpFZpUDUEYdw@mail.gmail.com>
 <YGHM2/s4FpWZiEQ6@hirez.programming.kicks-ass.net> <CAJF2gTRncV1+GT7nBpYkvfpyaG57o9ecaHBjoR6gEQAkG2ELrg@mail.gmail.com>
 <YGNNCEAMSWbBU+hd@hirez.programming.kicks-ass.net> <20210330223514.GE1171117@lianli.shorne-pla.net>
 <CAK8P3a0hj2pYr-CuNJkjO==RafZ=J+6kCo4HTWEwvvRXPcngJA@mail.gmail.com>
 <CAJF2gTRxPMURTE3M5WMQ_0q1yZ6K8nraGsFjGLUmpG9nYS_hng@mail.gmail.com> <20210406085626.GE3288043@lianli.shorne-pla.net>
In-Reply-To: <20210406085626.GE3288043@lianli.shorne-pla.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 7 Apr 2021 10:42:50 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Pf3TbGoVP7JP7gfPV-WDM8MHV_hdqSwNKKFDr1Sb3zQ@mail.gmail.com>
Message-ID: <CAK8P3a3Pf3TbGoVP7JP7gfPV-WDM8MHV_hdqSwNKKFDr1Sb3zQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
To:     Stafford Horne <shorne@gmail.com>
Cc:     Guo Ren <guoren@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Anup Patel <anup@brainfault.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:PmTwyMLNDw3MbtxJXND6wULilPufj1Rr7LxvRNWwVMx0KuqZ/7M
 ZzPLIXfGxqYz3RbTbz0HscLdlVr/oldvgKYrICHJjwdTY+EQpkfFv2Y+2mMWRcC8PdFLVLF
 kYIKEDdO4Idr98XRoEMBehSww26IUhuQVCpUJDpyFdxMw5XMfXbKZK5vQGnn3+gDJylFl6E
 V57sqwGdA+ENNzLyCT2qA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:f06RPnhyB94=:ifLiOCkPnY9l9pXL4RFEcb
 0Zp1KK0RhXvmZTDpr8syaMUSk51t26nYVE+bvUdTWDepTJkwidUG2eWzqrCBGo/PmbFk+qNaP
 sRksuQk1X3MzsgiJ91J5rPpdj6OlMwmhCX+qVTm/Cf2UA5OXxgsFV7REYfJ8tB3CriSXRWdnO
 xQfe4WQN7XEhh9F0rYCQr2ZcINGNfsiYHUsgpPuTFo0vVAWbEl33OrCq58YapUtU/b0qx7RU3
 rKNtJ1XI/4PFfR5ijFsMfh0BHZlfKvXXSZBpWCtWIgUb2GoBg8Asb3VV+qM4Iqydg+xblB2je
 puVy7ZiRgtx7Z/T4tyfxu5a2HoJG4mNpar88CjZgULnq76XsE5G3i0V4vvmpbQq39k96QEAz0
 md1LN54waqAo/0RQzm4rUMM1CIrGSxkQaCpakRymWPeoHMgX06izu98JMMqD5T+AqcmLSTG58
 2x3Oawb20xVtpIJEUMTvyBw/zWsK8+8neeakDSCy1d4HZRRAUBSd46YScttjlb+7dWWq4zTAi
 rPy9xM7y8N2ALmUBZrxo5xiloDA4aDXFodQ/FT2cTvzunTZotsZ2EZj+coucMV5JT3dHBB1u5
 IrUA/N9S0oc0hRD5nywZWRj9YZ09V4euxo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 6, 2021 at 10:56 AM Stafford Horne <shorne@gmail.com> wrote:
> On Tue, Apr 06, 2021 at 11:50:38AM +0800, Guo Ren wrote:
> > On Wed, Mar 31, 2021 at 3:23 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Wed, Mar 31, 2021 at 12:35 AM Stafford Horne <shorne@gmail.com> wrote:
> >
> > We shouldn't export xchg16/cmpxchg16(emulated by lr.w/sc.w) in riscv,
> > We should forbid these sub-word atomic primitive and lets the
> > programmers consider their atomic design.
>
> Fair enough, having the generic sub-word emulation would be something that
> an architecture can select to use/export.

I still have the feeling that we should generalize and unify the exact behavior
across architectures as much as possible here, while possibly also trying to
simplify the interface a little.

Looking through the various xchg()/cmpxchg() implementations, I find eight
distinct ways to do 8-bit and 16-bit atomics:

Full support:
      ia64, m68k (Atari only), x86, arm32 (v6k+), arm64

gcc/clang __sync_{val,bool}_compare_and_swap:
     s390

Emulated through ll/sc:
      alpha, powerpc

Emulated through cmpxchg loop:
      mips, openrisc, xtensa (xchg but not cmpxchg), sparc64 (cmpxchg_u8,
      xchg_u16 but not cmpxchg_u16 and xchg_u8!)

Emulated through local_irq_save (non SMP only):
        h8300, m68k (most), microblaze, mips, nds32, nios2

Emulated through hashed spinlock:
        parisc (8-bit only added in 2020, 16-bit still missing)

Forced compile-time error:
       arm32 (v4/v5/v6 non-SMP), arc, csky, riscv, parisc (16 bit), sparc32,
       sparc64, xtensa (cmpxchg)

Silently broken:
        hexagon

Since there are really only a handful of instances in the kernel
that use the cmpxchg() or xchg() on u8/u16 variables, it would seem
best to just disallow those completely and have a separate set of
functions here, with only 64-bit architectures using any variable-type
wrapper to handle both 32-bit and 64-bit arguments.

Interestingly, the s390 version using __sync_val_compare_and_swap()
seems to produce nice output on all architectures that have atomic
instructions, with any supported compiler, to the point where I think
we could just use that to replace most of the inline-asm versions except
for arm64:

#define cmpxchg(ptr, o, n)                                              \
({                                                                      \
        __typeof__(*(ptr)) __o = (o);                                   \
        __typeof__(*(ptr)) __n = (n);                                   \
        (__typeof__(*(ptr))) __sync_val_compare_and_swap((ptr),__o,__n);\
})

Not how gcc's acquire/release behavior of __sync_val_compare_and_swap()
relates to what the kernel wants here.

The gcc documentation also recommends using the standard
__atomic_compare_exchange_n() builtin instead, which would allow
constructing release/acquire/relaxed versions as well, but I could not
get it to produce equally good output. (possibly I was using it wrong)

       Arnd
