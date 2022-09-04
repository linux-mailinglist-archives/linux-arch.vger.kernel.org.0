Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC825AC3F4
	for <lists+linux-arch@lfdr.de>; Sun,  4 Sep 2022 12:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiIDKkc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 4 Sep 2022 06:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbiIDKkb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 4 Sep 2022 06:40:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273982A276;
        Sun,  4 Sep 2022 03:40:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BED8BB80D63;
        Sun,  4 Sep 2022 10:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C30C4314A;
        Sun,  4 Sep 2022 10:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662288027;
        bh=QvekvzTHziUiAlppqzOc2503IrEaR87Amqi+A2N8Wbo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lWIFglzecdpNXDWI4IMKk1ezBgmV9MIPsn5+kBZRDzrxI4epuXV+BaX49nWQlFuoQ
         CzGigb9q83kkFaaH84x1q6lKA6n7vlJ//F7BBdlGOS8ly+vDJ3CVbN4Yi7IgfsV8ml
         ZhRmETx/9KE5j/l2kRHtXH4D4tfBBtSu+N9hbghGNr8aPVzKxXI7Xceo3tIX9mVxsa
         mlazkVPe//f3fr4UI/m5/ap9q00k3RTqxVIZtwyDPJlZ4LnIuiJwOrayKT4fJpTEEH
         rx0LQ5h0YMYCc+pDMqU542E724ROg4Bg1QtmIN8PITAT3BxaKD3Un3T/ubo5LZF/fG
         HdxQ3iDgX4VZg==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-11f34610d4aso15549993fac.9;
        Sun, 04 Sep 2022 03:40:27 -0700 (PDT)
X-Gm-Message-State: ACgBeo0FnVJ1FWWZfJIhOh8SPfTV3oJ9TI9clNeVul24q5MRpAhVCUaM
        zvHSKRQBOT/qxfoBKwohwelAdC/MCRdmh0NHfKw=
X-Google-Smtp-Source: AA6agR6sAHYb4ljI9RHXksbswRfpihbmkms10dn4bovNyYlfRGc7CVPKnpnoNgXAoLNEX7VZY1o7Q2k2oR8tSaiBMJA=
X-Received: by 2002:a05:6870:7092:b0:11e:ff3a:d984 with SMTP id
 v18-20020a056870709200b0011eff3ad984mr6115401oae.19.1662288026365; Sun, 04
 Sep 2022 03:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220904072637.8619-1-guoren@kernel.org> <bdac65bd-175f-3f09-ae46-97d4fcc77d6f@microchip.com>
In-Reply-To: <bdac65bd-175f-3f09-ae46-97d4fcc77d6f@microchip.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 4 Sep 2022 18:40:14 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSOdZCDAk7Gq1-7cxYTXabVbZoarEPk=jh4Ss-L3zAsLQ@mail.gmail.com>
Message-ID: <CAJF2gTSOdZCDAk7Gq1-7cxYTXabVbZoarEPk=jh4Ss-L3zAsLQ@mail.gmail.com>
Subject: Re: [PATCH V2 0/6] riscv: Add GENERIC_ENTRY, IRQ_STACKS support
To:     Conor.Dooley@microchip.com
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, heiko@sntech.de,
        jszhang@kernel.org, lazyparser@gmail.com, falcon@tinylab.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        guoren@linux.alibaba.com
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

On Sun, Sep 4, 2022 at 6:17 PM <Conor.Dooley@microchip.com> wrote:
>
> Hey Guo Ren,
> (off topic: is Guo or Ren your given name?)
>
> This series seems to introduce a build warning:
>
> arch/riscv/kernel/irq.c:17:1: warning: symbol 'irq_stack_ptr' was not declared. Should it be static?
>
> One more comment below:
>
> On 04/09/2022 08:26, guoren@kernel.org wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The patches convert riscv to use the generic entry infrastructure from
> > kernel/entry/*. Add independent irq stacks (IRQ_STACKS) for percpu to
> > prevent kernel stack overflows. Add the HAVE_SOFTIRQ_ON_OWN_STACK
> > feature for the IRQ_STACKS config. You can try it directly with [1].
> >
> > [1] https://github.com/guoren83/linux/tree/generic_entry_v2
> >
> > Changes in V2:
> >  - Fixup compile error by include "riscv: ptrace: Remove duplicate
> >    operation"
> >   https://lore.kernel.org/linux-riscv/20220903162328 .1952477-2-guoren@kernel.org/T/#u
>
> I find this really confusing. The same patch is in two different series?
Generic entry needn't TIF_SYSCALL_TRACE. So it depends on "riscv:
ptrace: Remove duplicate"

> Is the above series no longer required & this is a different approach?
Above series cleanup ptrace_disable, we still need that.

> Thanks,
> Conor.
>
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
>


-- 
Best Regards
 Guo Ren
