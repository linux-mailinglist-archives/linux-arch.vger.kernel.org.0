Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A5B7A2D0A
	for <lists+linux-arch@lfdr.de>; Sat, 16 Sep 2023 03:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237832AbjIPB1B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Sep 2023 21:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237819AbjIPB0m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Sep 2023 21:26:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47B3912F
        for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2023 18:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694827550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a841Dj9MVAHe6LjBb/D3WBLUQoc5e6SIAZrfTaBUOzc=;
        b=Faj0gjzdeOSNK18cnOOy0KN2ADRXVDtt/ZMyScrXCtTxyB5DZ3BjJoWt6R1p75NTvbBabP
        6R+2mIdVtK4+WYJTchwjjZQ7O8ZvjtPt63AoMOCZBpNkN9QPOHZZS0x3I+Umma7pQRWeG8
        n1OEh3O1OU6KP5B2Kxdywnndq1/cwUM=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-uninxFk2OrKFhhWhN76ZIg-1; Fri, 15 Sep 2023 21:25:48 -0400
X-MC-Unique: uninxFk2OrKFhhWhN76ZIg-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6c0d445555eso3676734a34.0
        for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2023 18:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694827548; x=1695432348;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a841Dj9MVAHe6LjBb/D3WBLUQoc5e6SIAZrfTaBUOzc=;
        b=EWIqEZsSnMxcpR8f+xx1zpCI0qUkYFH22nxmvIx57sLARKoYZ2+70a4j3x5+0RFlYX
         H6/i6H4nv9HBeT6tAHWThaszS/TDG2ASx51YwOAZbi+LctaM+u+xQlTF/ENg2VTtzqeh
         RttWkkzpIVjy91lwooam2vOXWwoCJpCeKOHpAYi38MuH9tpsWmwOF30LkLk5yosEx0TV
         KLMDeNaBal+RlChFUs2/XdNMqCNAGdZbCV4HEKUpWZM8gs2BahUway9y+gwNDlwdT5gM
         pQh2eUPqqRMx+ek3f8yA1GL19io12k8zGf2fzNVzSxBkCY/X1XfJpcOz53hLe5G/fUsI
         3IHA==
X-Gm-Message-State: AOJu0Yy0N+oSu5qE551qrPfavohBEjp6gp0SYM/5o/JUfn9rCo14u/SB
        A1IH1Kuri+dWy9gJy/3ZGQageD+s/ek0dX3WeDpa46NfA6FvnKQXHuV0rzr8NTQnwhXKwRAJhgS
        LGReoSNOp2GJ0YBwBWbnm4g==
X-Received: by 2002:a05:6830:1e5c:b0:6b9:1af3:3307 with SMTP id e28-20020a0568301e5c00b006b91af33307mr3240715otj.17.1694827547981;
        Fri, 15 Sep 2023 18:25:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/U7QGt/zB+NEyg+/yyYN+WrebgCYeIPjC/Iw6wpK8vc1LFQt+wzF39sF5ABwfBunU6FyGiw==
X-Received: by 2002:a05:6830:1e5c:b0:6b9:1af3:3307 with SMTP id e28-20020a0568301e5c00b006b91af33307mr3240694otj.17.1694827547715;
        Fri, 15 Sep 2023 18:25:47 -0700 (PDT)
Received: from redhat.com ([2804:1b3:a803:677d:42e9:f426:9422:f020])
        by smtp.gmail.com with ESMTPSA id d5-20020a05683018e500b006b9443ce478sm2192319otf.27.2023.09.15.18.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 18:25:47 -0700 (PDT)
Date:   Fri, 15 Sep 2023 22:25:37 -0300
From:   Leonardo Bras <leobras@redhat.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        conor.dooley@microchip.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V11 03/17] riscv: Use Zicbop in arch_xchg when available
Message-ID: <ZQUEEckIEbtxwLEG@redhat.com>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-4-guoren@kernel.org>
 <ZQF3qS1KRYAt3coC@redhat.com>
 <CAJF2gTT5s2-vhgrxnkE1EGqJMvXn8ftYrrwRMdJH1tjEqAv5kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTT5s2-vhgrxnkE1EGqJMvXn8ftYrrwRMdJH1tjEqAv5kQ@mail.gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 15, 2023 at 08:36:31PM +0800, Guo Ren wrote:
> On Wed, Sep 13, 2023 at 4:50 PM Leonardo Bras <leobras@redhat.com> wrote:
> >
> > On Sun, Sep 10, 2023 at 04:28:57AM -0400, guoren@kernel.org wrote:
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > Cache-block prefetch instructions are HINTs to the hardware to
> > > indicate that software intends to perform a particular type of
> > > memory access in the near future. Enable ARCH_HAS_PREFETCHW and
> > > improve the arch_xchg for qspinlock xchg_tail.
> > >
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > ---
> > >  arch/riscv/Kconfig                 | 15 +++++++++++++++
> > >  arch/riscv/include/asm/cmpxchg.h   |  4 +++-
> > >  arch/riscv/include/asm/hwcap.h     |  1 +
> > >  arch/riscv/include/asm/insn-def.h  |  5 +++++
> > >  arch/riscv/include/asm/processor.h | 13 +++++++++++++
> > >  arch/riscv/kernel/cpufeature.c     |  1 +
> > >  6 files changed, 38 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index e9ae6fa232c3..2c346fe169c1 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -617,6 +617,21 @@ config RISCV_ISA_ZICBOZ
> > >
> > >          If you don't know what to do here, say Y.
> > >
> > > +config RISCV_ISA_ZICBOP
> > > +     bool "Zicbop extension support for cache block prefetch"
> > > +     depends on MMU
> > > +     depends on RISCV_ALTERNATIVE
> > > +     default y
> > > +     help
> > > +        Adds support to dynamically detect the presence of the ZICBOP
> > > +        extension (Cache Block Prefetch Operations) and enable its
> > > +        usage.
> > > +
> > > +        The Zicbop extension can be used to prefetch cache block for
> > > +        read/write/instruction fetch.
> > > +
> > > +        If you don't know what to do here, say Y.
> > > +
> > >  config TOOLCHAIN_HAS_ZIHINTPAUSE
> > >       bool
> > >       default y
> > > diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> > > index 702725727671..56eff7a9d2d2 100644
> > > --- a/arch/riscv/include/asm/cmpxchg.h
> > > +++ b/arch/riscv/include/asm/cmpxchg.h
> > > @@ -11,6 +11,7 @@
> > >
> > >  #include <asm/barrier.h>
> > >  #include <asm/fence.h>
> > > +#include <asm/processor.h>
> > >
> > >  #define __arch_xchg_masked(prepend, append, r, p, n)                 \
> > >  ({                                                                   \
> > > @@ -25,6 +26,7 @@
> > >                                                                       \
> > >       __asm__ __volatile__ (                                          \
> > >              prepend                                                  \
> > > +            PREFETCHW_ASM(%5)                                        \
> > >              "0:      lr.w %0, %2\n"                                  \
> > >              "        and  %1, %0, %z4\n"                             \
> > >              "        or   %1, %1, %z3\n"                             \
> > > @@ -32,7 +34,7 @@
> > >              "        bnez %1, 0b\n"                                  \
> > >              append                                                   \
> > >              : "=&r" (__retx), "=&r" (__rc), "+A" (*(__ptr32b))       \
> > > -            : "rJ" (__newx), "rJ" (~__mask)                          \
> > > +            : "rJ" (__newx), "rJ" (~__mask), "rJ" (__ptr32b)         \
> > >              : "memory");                                             \
> > >                                                                       \
> > >       r = (__typeof__(*(p)))((__retx & __mask) >> __s);               \
> > > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> > > index b7b58258f6c7..78b7b8b53778 100644
> > > --- a/arch/riscv/include/asm/hwcap.h
> > > +++ b/arch/riscv/include/asm/hwcap.h
> > > @@ -58,6 +58,7 @@
> > >  #define RISCV_ISA_EXT_ZICSR          40
> > >  #define RISCV_ISA_EXT_ZIFENCEI               41
> > >  #define RISCV_ISA_EXT_ZIHPM          42
> > > +#define RISCV_ISA_EXT_ZICBOP         43
> > >
> > >  #define RISCV_ISA_EXT_MAX            64
> > >
> > > diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/insn-def.h
> > > index 6960beb75f32..dc590d331894 100644
> > > --- a/arch/riscv/include/asm/insn-def.h
> > > +++ b/arch/riscv/include/asm/insn-def.h
> > > @@ -134,6 +134,7 @@
> > >
> > >  #define RV_OPCODE_MISC_MEM   RV_OPCODE(15)
> > >  #define RV_OPCODE_SYSTEM     RV_OPCODE(115)
> > > +#define RV_OPCODE_PREFETCH   RV_OPCODE(19)
> > >
> > >  #define HFENCE_VVMA(vaddr, asid)                             \
> > >       INSN_R(OPCODE_SYSTEM, FUNC3(0), FUNC7(17),              \
> > > @@ -196,4 +197,8 @@
> > >       INSN_I(OPCODE_MISC_MEM, FUNC3(2), __RD(0),              \
> > >              RS1(base), SIMM12(4))
> > >
> > > +#define CBO_prefetchw(base)                                  \
> > > +     INSN_R(OPCODE_PREFETCH, FUNC3(6), FUNC7(0),             \
> > > +            RD(x0), RS1(base), RS2(x0))
> > > +
> >
> > I understand that here you create the instruction via bitfield, following
> > the ISA, and this enables using instructions not available on the
> > toolchain.
> >
> > It took me some time to find the document with this instruction, so please
> > add this to the commit msg:
> >
> > https://github.com/riscv/riscv-CMOs/blob/master/specifications/cmobase-v1.0.pdf
> > Page 23.
> >
> > IIUC, the instruction is "prefetch.w".
> >
> > Maybe I am missing something, but in the document the rs2 field
> > (PREFETCH.W) contains a 0x3, while the above looks to have a 0 instead.
> >
> > rs2 field = 0x0 would be a prefetch.i (instruction prefetch) instead.
> >
> > Is the above correct, or am I missing something?
> Oh, you are right. My fault, thx for pointing out. It should be:
> +       INSN_R(OPCODE_PREFETCH, FUNC3(6), FUNC7(0),             \
> +              RD(x0), RS1(base), RS2(x3))

Now I am curious to check if / how will this impact performance. :)
(Please let me know)


> 
> >
> >
> > Thanks!
> > Leo
> >
> > >  #endif /* __ASM_INSN_DEF_H */
> > > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> > > index de9da852f78d..7ad3a24212e8 100644
> > > --- a/arch/riscv/include/asm/processor.h
> > > +++ b/arch/riscv/include/asm/processor.h
> > > @@ -12,6 +12,8 @@
> > >  #include <vdso/processor.h>
> > >
> > >  #include <asm/ptrace.h>
> > > +#include <asm/insn-def.h>
> > > +#include <asm/hwcap.h>
> > >
> > >  #ifdef CONFIG_64BIT
> > >  #define DEFAULT_MAP_WINDOW   (UL(1) << (MMAP_VA_BITS - 1))
> > > @@ -103,6 +105,17 @@ static inline void arch_thread_struct_whitelist(unsigned long *offset,
> > >  #define KSTK_EIP(tsk)                (ulong)(task_pt_regs(tsk)->epc)
> > >  #define KSTK_ESP(tsk)                (ulong)(task_pt_regs(tsk)->sp)
> > >
> > > +#define ARCH_HAS_PREFETCHW
> > > +#define PREFETCHW_ASM(base)  ALTERNATIVE(__nops(1), \
> > > +                                         CBO_prefetchw(base), \
> > > +                                         0, \
> > > +                                         RISCV_ISA_EXT_ZICBOP, \
> > > +                                         CONFIG_RISCV_ISA_ZICBOP)
> > > +static inline void prefetchw(const void *ptr)
> > > +{
> > > +     asm volatile(PREFETCHW_ASM(%0)
> > > +             : : "r" (ptr) : "memory");
> > > +}
> > >
> > >  /* Do necessary setup to start up a newly executed thread. */
> > >  extern void start_thread(struct pt_regs *regs,
> > > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > > index ef7b4fd9e876..e0b897db0b97 100644
> > > --- a/arch/riscv/kernel/cpufeature.c
> > > +++ b/arch/riscv/kernel/cpufeature.c
> > > @@ -159,6 +159,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
> > >       __RISCV_ISA_EXT_DATA(h, RISCV_ISA_EXT_h),
> > >       __RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
> > >       __RISCV_ISA_EXT_DATA(zicboz, RISCV_ISA_EXT_ZICBOZ),
> > > +     __RISCV_ISA_EXT_DATA(zicbop, RISCV_ISA_EXT_ZICBOP),
> > >       __RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
> > >       __RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
> > >       __RISCV_ISA_EXT_DATA(zifencei, RISCV_ISA_EXT_ZIFENCEI),
> > > --
> > > 2.36.1
> > >
> >
> 
> 
> -- 
> Best Regards
>  Guo Ren
> 

