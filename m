Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5535ADD19
	for <lists+linux-arch@lfdr.de>; Tue,  6 Sep 2022 03:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbiIFBzq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Sep 2022 21:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiIFBzp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 21:55:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA962B610;
        Mon,  5 Sep 2022 18:55:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC60B61157;
        Tue,  6 Sep 2022 01:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E01C43470;
        Tue,  6 Sep 2022 01:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662429343;
        bh=pfS9CNoNEvfoyh2//nxqJD7uVg2c1QLB5aCtER50Z68=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=loW/9YLv0rlmMEisudZVQNOFn1n6b22KNurVwZJY2+3OBiucKcZmNwklJUdkYGpQ6
         WJdaxBb2Z+A2Zh0WRY5pZA57oUPw5K81bx1BQ8tKj00cHB94sa4qe5msnzBY1LtVkT
         S51UUNMUOw0qDOdJ37JDmiNhsuxw+sY+Id2r1uFqfi028kLd31FORnYLfUL90x+KN5
         KbJWTwNsBBHF21RQ3qWP8kheVIfcbrOsFRhVKhsVVWoqvi8BbnZbVzK/EPoaCENT/B
         9q/LLsRJK3ZxBN7glmWf9O7WKIbsRQdLvP+2SSZBBxSMzfGN2l/Ad0X+uGkdQhhkbS
         P9DYMVM3K1cZA==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1272fc7f51aso11690236fac.12;
        Mon, 05 Sep 2022 18:55:43 -0700 (PDT)
X-Gm-Message-State: ACgBeo0MuBU+jmoncMVKgSnlJHrfJYEaZCxfzVupwrLrExJqaSjvFXk4
        sLiGXT+Xf36DgkuXjlD7vo7uqMPRe0yVkilde1g=
X-Google-Smtp-Source: AA6agR7+5Qkc1US3xZc6AzhwYNjNc26fVd4ocphyutdMyyGHQ7xzYM2uClin5e5pQtitt6PZnV/fiLM2jxFlHInyKGc=
X-Received: by 2002:a05:6870:7092:b0:11e:ff3a:d984 with SMTP id
 v18-20020a056870709200b0011eff3ad984mr10071831oae.19.1662429342398; Mon, 05
 Sep 2022 18:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220904072637.8619-1-guoren@kernel.org> <YxX3CZQEe86u052D@xhacker>
In-Reply-To: <YxX3CZQEe86u052D@xhacker>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 6 Sep 2022 09:55:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTYgKPMTUaHZn1n7qPmW3cPkxmx5xPurdGSg1h4tMqNqQ@mail.gmail.com>
Message-ID: <CAJF2gTTYgKPMTUaHZn1n7qPmW3cPkxmx5xPurdGSg1h4tMqNqQ@mail.gmail.com>
Subject: Re: [PATCH V2 0/6] riscv: Add GENERIC_ENTRY, IRQ_STACKS support
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, lazyparser@gmail.com, falcon@tinylab.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
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

On Mon, Sep 5, 2022 at 9:27 PM Jisheng Zhang <jszhang@kernel.org> wrote:
>
> On Sun, Sep 04, 2022 at 03:26:31AM -0400, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The patches convert riscv to use the generic entry infrastructure from
> > kernel/entry/*. Add independent irq stacks (IRQ_STACKS) for percpu to
>
> Amazing! You read my mind. I planed to do similar series this week, as
I'm happy you liked it.

> can be seen, I didn't RESEND the riscv irqstack patch, I planed to add
> irqstack after generic entry. Thanks for this series.
>
> Will read and test your patches soon. A minor comments below.
Thx, any tests and reviews are helpful.

>
> > prevent kernel stack overflows. Add the HAVE_SOFTIRQ_ON_OWN_STACK
> > feature for the IRQ_STACKS config. You can try it directly with [1].
> >
> > [1] https://github.com/guoren83/linux/tree/generic_entry_v2
> >
> > Changes in V2:
> >  - Fixup compile error by include "riscv: ptrace: Remove duplicate
> >    operation"
> >    https://lore.kernel.org/linux-riscv/20220903162328.1952477-2-guoren@kernel.org/T/#u
> >  - Fixup compile warning
> >    Reported-by: kernel test robot <lkp@intel.com>
> >  - Add test repo link in cover letter
> >
> > Guo Ren (6):
> >   riscv: ptrace: Remove duplicate operation
> >   riscv: convert to generic entry
> >   riscv: Support HAVE_IRQ_EXIT_ON_IRQ_STACK
> >   riscv: Support HAVE_SOFTIRQ_ON_OWN_STACK
> >   riscv: elf_kexec: Fixup compile warning
> >   riscv: compat_syscall_table: Fixup compile warning
>
> It's better to move these two patches ahead of patch2.
Okay.

>
> >
> >  arch/riscv/Kconfig                    |  10 +
> >  arch/riscv/include/asm/csr.h          |   1 -
> >  arch/riscv/include/asm/entry-common.h |   8 +
> >  arch/riscv/include/asm/irq.h          |   3 +
> >  arch/riscv/include/asm/ptrace.h       |  10 +-
> >  arch/riscv/include/asm/stacktrace.h   |   5 +
> >  arch/riscv/include/asm/syscall.h      |   6 +
> >  arch/riscv/include/asm/thread_info.h  |  15 +-
> >  arch/riscv/include/asm/vmap_stack.h   |  28 +++
> >  arch/riscv/kernel/Makefile            |   1 +
> >  arch/riscv/kernel/elf_kexec.c         |   4 +
> >  arch/riscv/kernel/entry.S             | 255 +++++---------------------
> >  arch/riscv/kernel/irq.c               |  75 ++++++++
> >  arch/riscv/kernel/ptrace.c            |  41 -----
> >  arch/riscv/kernel/signal.c            |  21 +--
> >  arch/riscv/kernel/sys_riscv.c         |  26 +++
> >  arch/riscv/kernel/traps.c             |  11 ++
> >  arch/riscv/mm/fault.c                 |  12 +-
> >  18 files changed, 250 insertions(+), 282 deletions(-)
> >  create mode 100644 arch/riscv/include/asm/entry-common.h
> >  create mode 100644 arch/riscv/include/asm/vmap_stack.h
> >
> > --
> > 2.36.1
> >



-- 
Best Regards
 Guo Ren
