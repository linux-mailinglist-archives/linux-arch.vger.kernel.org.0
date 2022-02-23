Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0C64C0E98
	for <lists+linux-arch@lfdr.de>; Wed, 23 Feb 2022 09:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239104AbiBWIzK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Feb 2022 03:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237307AbiBWIzI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Feb 2022 03:55:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37EE7C162;
        Wed, 23 Feb 2022 00:54:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 555FBB81EAA;
        Wed, 23 Feb 2022 08:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6BBC340FB;
        Wed, 23 Feb 2022 08:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645606479;
        bh=E/2Z4Vy9mxZGDI8XrK5Vjz10Eu6BNFSrCZQ+fcA0AuU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=imGt0TTBca8jC8OZdr7AeYQItk1jNw9+HsQXjcRpe7dvnhuuo+D2FGWv5SCqGxF/t
         89ZHbUAaf5SwjwTx7Mt4ZqPdNeElhdp8nWkV66UGwLRewTfdEoO8LiSGAM7Ldma7H4
         IkX6xbe87WEt8tIeJ5OQ30micEoR4LwOZ3+zYhBmkdQ9CAL8Z9ancmRC1vKkxuNvLL
         40T/YrsZW/YbGmUVbKtwuLF0XMrwHjgQ7saZ4nyjOp6WyL+W2AkU5ivkNQbkPPQZaN
         nvneaDydNHlO0ihSQqWE3wc7YdZxW8WaqK64QH2XemEL9z55fnGjfOa1ab1WWrEVD/
         LG4LyHVisZZfQ==
Received: by mail-vk1-f178.google.com with SMTP id l10so11872647vki.9;
        Wed, 23 Feb 2022 00:54:38 -0800 (PST)
X-Gm-Message-State: AOAM532x02H2LnMUijHE7jWNpaLlmO0E23Hefa5smmRg176HuzP0ytRj
        wkk8lgIEiVF8kmUvRuyvl3ASHY+ZhX5SvcXKsk0=
X-Google-Smtp-Source: ABdhPJwWW6G4x9OFAhhFWSWfocQLhP1I117Bx4K85d+PzjcITJADDiakZphcZmjJzU/UZPrPS/vziQCTmEPnC0Gezro=
X-Received: by 2002:a05:6122:24b:b0:320:a9b7:f709 with SMTP id
 t11-20020a056122024b00b00320a9b7f709mr12200542vko.2.1645606477843; Wed, 23
 Feb 2022 00:54:37 -0800 (PST)
MIME-Version: 1.0
References: <20220201150545.1512822-10-guoren@kernel.org> <mhng-c74f1c06-0caa-4a71-82fa-7cf58a1ac0ca@palmer-ri-x1c9>
In-Reply-To: <mhng-c74f1c06-0caa-4a71-82fa-7cf58a1ac0ca@palmer-ri-x1c9>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 23 Feb 2022 16:54:27 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS8EnPeTRj72UE2KehAqFEZ5PFVAQWgBvWRbLkGsOyXCg@mail.gmail.com>
Message-ID: <CAJF2gTS8EnPeTRj72UE2KehAqFEZ5PFVAQWgBvWRbLkGsOyXCg@mail.gmail.com>
Subject: Re: [PATCH V5 09/21] riscv: compat: Add basic compat data type implementation
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Anup Patel <anup@brainfault.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 23, 2022 at 9:42 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Tue, 01 Feb 2022 07:05:33 PST (-0800), guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Implement riscv asm/compat.h for struct compat_xxx,
> > is_compat_task, compat_user_regset, regset convert.
> >
> > The rv64 compat.h has inherited most of the structs
> > from the generic one.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > ---
> >  arch/riscv/include/asm/compat.h      | 129 +++++++++++++++++++++++++++
> >  arch/riscv/include/asm/thread_info.h |   1 +
> >  2 files changed, 130 insertions(+)
> >  create mode 100644 arch/riscv/include/asm/compat.h
> >
> > diff --git a/arch/riscv/include/asm/compat.h b/arch/riscv/include/asm/compat.h
> > new file mode 100644
> > index 000000000000..2ac955b51148
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/compat.h
> > @@ -0,0 +1,129 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +#ifndef __ASM_COMPAT_H
> > +#define __ASM_COMPAT_H
> > +
> > +#define COMPAT_UTS_MACHINE   "riscv\0\0"
> > +
> > +/*
> > + * Architecture specific compatibility types
> > + */
> > +#include <linux/types.h>
> > +#include <linux/sched.h>
> > +#include <linux/sched/task_stack.h>
> > +#include <asm-generic/compat.h>
> > +
> > +static inline int is_compat_task(void)
> > +{
> > +     return test_thread_flag(TIF_32BIT);
> > +}
> > +
> > +struct compat_user_regs_struct {
> > +     compat_ulong_t pc;
> > +     compat_ulong_t ra;
> > +     compat_ulong_t sp;
> > +     compat_ulong_t gp;
> > +     compat_ulong_t tp;
> > +     compat_ulong_t t0;
> > +     compat_ulong_t t1;
> > +     compat_ulong_t t2;
> > +     compat_ulong_t s0;
> > +     compat_ulong_t s1;
> > +     compat_ulong_t a0;
> > +     compat_ulong_t a1;
> > +     compat_ulong_t a2;
> > +     compat_ulong_t a3;
> > +     compat_ulong_t a4;
> > +     compat_ulong_t a5;
> > +     compat_ulong_t a6;
> > +     compat_ulong_t a7;
> > +     compat_ulong_t s2;
> > +     compat_ulong_t s3;
> > +     compat_ulong_t s4;
> > +     compat_ulong_t s5;
> > +     compat_ulong_t s6;
> > +     compat_ulong_t s7;
> > +     compat_ulong_t s8;
> > +     compat_ulong_t s9;
> > +     compat_ulong_t s10;
> > +     compat_ulong_t s11;
> > +     compat_ulong_t t3;
> > +     compat_ulong_t t4;
> > +     compat_ulong_t t5;
> > +     compat_ulong_t t6;
> > +};
> > +
> > +static inline void regs_to_cregs(struct compat_user_regs_struct *cregs,
> > +                              struct pt_regs *regs)
> > +{
> > +     cregs->pc       = (compat_ulong_t) regs->epc;
> > +     cregs->ra       = (compat_ulong_t) regs->ra;
> > +     cregs->sp       = (compat_ulong_t) regs->sp;
> > +     cregs->gp       = (compat_ulong_t) regs->gp;
> > +     cregs->tp       = (compat_ulong_t) regs->tp;
> > +     cregs->t0       = (compat_ulong_t) regs->t0;
> > +     cregs->t1       = (compat_ulong_t) regs->t1;
> > +     cregs->t2       = (compat_ulong_t) regs->t2;
> > +     cregs->s0       = (compat_ulong_t) regs->s0;
> > +     cregs->s1       = (compat_ulong_t) regs->s1;
> > +     cregs->a0       = (compat_ulong_t) regs->a0;
> > +     cregs->a1       = (compat_ulong_t) regs->a1;
> > +     cregs->a2       = (compat_ulong_t) regs->a2;
> > +     cregs->a3       = (compat_ulong_t) regs->a3;
> > +     cregs->a4       = (compat_ulong_t) regs->a4;
> > +     cregs->a5       = (compat_ulong_t) regs->a5;
> > +     cregs->a6       = (compat_ulong_t) regs->a6;
> > +     cregs->a7       = (compat_ulong_t) regs->a7;
> > +     cregs->s2       = (compat_ulong_t) regs->s2;
> > +     cregs->s3       = (compat_ulong_t) regs->s3;
> > +     cregs->s4       = (compat_ulong_t) regs->s4;
> > +     cregs->s5       = (compat_ulong_t) regs->s5;
> > +     cregs->s6       = (compat_ulong_t) regs->s6;
> > +     cregs->s7       = (compat_ulong_t) regs->s7;
> > +     cregs->s8       = (compat_ulong_t) regs->s8;
> > +     cregs->s9       = (compat_ulong_t) regs->s9;
> > +     cregs->s10      = (compat_ulong_t) regs->s10;
> > +     cregs->s11      = (compat_ulong_t) regs->s11;
> > +     cregs->t3       = (compat_ulong_t) regs->t3;
> > +     cregs->t4       = (compat_ulong_t) regs->t4;
> > +     cregs->t5       = (compat_ulong_t) regs->t5;
> > +     cregs->t6       = (compat_ulong_t) regs->t6;
> > +};
> > +
> > +static inline void cregs_to_regs(struct compat_user_regs_struct *cregs,
> > +                              struct pt_regs *regs)
> > +{
> > +     regs->epc       = (unsigned long) cregs->pc;
> > +     regs->ra        = (unsigned long) cregs->ra;
> > +     regs->sp        = (unsigned long) cregs->sp;
> > +     regs->gp        = (unsigned long) cregs->gp;
> > +     regs->tp        = (unsigned long) cregs->tp;
> > +     regs->t0        = (unsigned long) cregs->t0;
> > +     regs->t1        = (unsigned long) cregs->t1;
> > +     regs->t2        = (unsigned long) cregs->t2;
> > +     regs->s0        = (unsigned long) cregs->s0;
> > +     regs->s1        = (unsigned long) cregs->s1;
> > +     regs->a0        = (unsigned long) cregs->a0;
> > +     regs->a1        = (unsigned long) cregs->a1;
> > +     regs->a2        = (unsigned long) cregs->a2;
> > +     regs->a3        = (unsigned long) cregs->a3;
> > +     regs->a4        = (unsigned long) cregs->a4;
> > +     regs->a5        = (unsigned long) cregs->a5;
> > +     regs->a6        = (unsigned long) cregs->a6;
> > +     regs->a7        = (unsigned long) cregs->a7;
> > +     regs->s2        = (unsigned long) cregs->s2;
> > +     regs->s3        = (unsigned long) cregs->s3;
> > +     regs->s4        = (unsigned long) cregs->s4;
> > +     regs->s5        = (unsigned long) cregs->s5;
> > +     regs->s6        = (unsigned long) cregs->s6;
> > +     regs->s7        = (unsigned long) cregs->s7;
> > +     regs->s8        = (unsigned long) cregs->s8;
> > +     regs->s9        = (unsigned long) cregs->s9;
> > +     regs->s10       = (unsigned long) cregs->s10;
> > +     regs->s11       = (unsigned long) cregs->s11;
> > +     regs->t3        = (unsigned long) cregs->t3;
> > +     regs->t4        = (unsigned long) cregs->t4;
> > +     regs->t5        = (unsigned long) cregs->t5;
> > +     regs->t6        = (unsigned long) cregs->t6;
> > +};
> > +
> > +#endif /* __ASM_COMPAT_H */
> > diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
> > index 60da0dcacf14..9392e35c689d 100644
> > --- a/arch/riscv/include/asm/thread_info.h
> > +++ b/arch/riscv/include/asm/thread_info.h
> > @@ -91,6 +91,7 @@ struct thread_info {
> >  #define TIF_SECCOMP          8       /* syscall secure computing */
> >  #define TIF_NOTIFY_SIGNAL    9       /* signal notifications exist */
> >  #define TIF_UPROBE           10      /* uprobe breakpoint or singlestep */
> > +#define TIF_32BIT            11      /* 32bit process */
>
> Presumably that's just meant for 32-bit processes on rv64?  Probably
> best to have the comment say that explicitly.
/* compat-mode 32bit process */

>
> >  #define _TIF_SYSCALL_TRACE   (1 << TIF_SYSCALL_TRACE)
> >  #define _TIF_NOTIFY_RESUME   (1 << TIF_NOTIFY_RESUME)



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
