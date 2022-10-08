Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF065F8251
	for <lists+linux-arch@lfdr.de>; Sat,  8 Oct 2022 04:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiJHCQy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Oct 2022 22:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJHCQx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Oct 2022 22:16:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3659A8285B;
        Fri,  7 Oct 2022 19:16:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2958B8245F;
        Sat,  8 Oct 2022 02:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90EEBC43144;
        Sat,  8 Oct 2022 02:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665195409;
        bh=fJZiXIczXHKWSWOJREIPZZI4lyDP1osRfKH0d9gMG9w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XJdre88GuzkyX8miOvR5lz7t5nMrVg+RdgltnzIt7wijp9gBMVTJ5Ugj94xyDWOvT
         R7UFdbISnUHuUSzaVN1xGm8DM8NQ2SA76723qzSFI6O2mVqcAXL0E1P7kRCR+qH8UR
         yQXckh7ShWuPweU1ibuRee4wrAHXyPfhH8rL7ts5yP505HgqsGK2HFNvQj0akqKl0/
         gY8Ls0GkczDGLnRi/9nl/29QrOhsVIiSwCoJuylivZHNb7lLUXG0I/K0eMAwaXLNmr
         YafuAPSA2CNX7ychb2j3Pu9FOXHJIoT3dBu4skrfit9fXonENb7AJxXaH8q56IOB74
         kPYBqli3C+Zmg==
Received: by mail-oi1-f180.google.com with SMTP id t79so7511218oie.0;
        Fri, 07 Oct 2022 19:16:49 -0700 (PDT)
X-Gm-Message-State: ACrzQf3MtAb5vPqJtOiPBsmbvrLOlQ4VgKAH1wxRMSgK7KmnxYsXXYY6
        RuAmmbDbjHvSzzIQE3Hf6N6bBn5G+7L3Khgjqgo=
X-Google-Smtp-Source: AMsMyM4WITxFNS7eyExidUgQiJ5ich4TeNeqmzLVzbaZ1CMDMKDcOXm1GjRQmdAu1Nym8En0zhJcdL3W8uqF1Vnen3U=
X-Received: by 2002:a05:6808:151f:b0:350:1b5e:2380 with SMTP id
 u31-20020a056808151f00b003501b5e2380mr9188426oiw.112.1665195408646; Fri, 07
 Oct 2022 19:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20221002012451.2351127-1-guoren@kernel.org> <20221002012451.2351127-6-guoren@kernel.org>
 <YzrKQkK4Kfbd7Wik@FVFF77S0Q05N>
In-Reply-To: <YzrKQkK4Kfbd7Wik@FVFF77S0Q05N>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 8 Oct 2022 10:16:36 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQTWAGwdOta4_QQx0Q6h2OKjJuz43a_OWt0R9XVe3Rzbw@mail.gmail.com>
Message-ID: <CAJF2gTQTWAGwdOta4_QQx0Q6h2OKjJuz43a_OWt0R9XVe3Rzbw@mail.gmail.com>
Subject: Re: [PATCH V6 05/11] riscv: traps: Add noinstr to prevent
 instrumentation inserted
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, zouyipeng@huawei.com,
        bigeasy@linutronix.de, David.Laight@aculab.com,
        chenzhongjin@huawei.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 3, 2022 at 7:41 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Sat, Oct 01, 2022 at 09:24:45PM -0400, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Without noinstr the compiler is free to insert instrumentation (think
> > all the k*SAN, KCov, GCov, ftrace etc..) which can call code we're not
> > yet ready to run this early in the entry path, for instance it could
> > rely on RCU which isn't on yet, or expect lockdep state. (by peterz)
> >
> > Link: https://lore.kernel.org/linux-riscv/YxcQ6NoPf3AH0EXe@hirez.programming.kicks-ass.net/raw
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/kernel/traps.c | 4 ++--
> >  arch/riscv/mm/fault.c     | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> > index 635e6ec26938..588e17c386c6 100644
> > --- a/arch/riscv/kernel/traps.c
> > +++ b/arch/riscv/kernel/traps.c
> > @@ -92,9 +92,9 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
> >  }
> >
> >  #if defined(CONFIG_XIP_KERNEL) && defined(CONFIG_RISCV_ALTERNATIVE)
> > -#define __trap_section               __section(".xip.traps")
> > +#define __trap_section __noinstr_section(".xip.traps")
>
> I assume that for CONFIG_XIP_KERNEL, KPROBES is not possible, and so functions
> marked with __trap_section don't need to be excluded from kprobes.
>
> Is that assumption correct, or does something need to be done to inhibit that?
Correct!

In riscv, "we select HAVE_KPROBES if !XIP_KERNEL", so don't worry
about that. I don't think we could enable kprobe for XIP_KERNEL in the
future.

>
> Thanks,
> Mark.
>
> >  #else
> > -#define __trap_section
> > +#define __trap_section noinstr
> >  #endif
> >  #define DO_ERROR_INFO(name, signo, code, str)                                \
> >  asmlinkage __visible __trap_section void name(struct pt_regs *regs)  \
> > diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> > index f2fbd1400b7c..c7829289e806 100644
> > --- a/arch/riscv/mm/fault.c
> > +++ b/arch/riscv/mm/fault.c
> > @@ -203,7 +203,7 @@ static inline bool access_error(unsigned long cause, struct vm_area_struct *vma)
> >   * This routine handles page faults.  It determines the address and the
> >   * problem, and then passes it off to one of the appropriate routines.
> >   */
> > -asmlinkage void do_page_fault(struct pt_regs *regs)
> > +asmlinkage void noinstr do_page_fault(struct pt_regs *regs)
> >  {
> >       struct task_struct *tsk;
> >       struct vm_area_struct *vma;
> > --
> > 2.36.1
> >



-- 
Best Regards
 Guo Ren
