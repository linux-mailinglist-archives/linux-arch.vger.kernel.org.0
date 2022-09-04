Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197BC5AC410
	for <lists+linux-arch@lfdr.de>; Sun,  4 Sep 2022 13:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbiIDLFh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 4 Sep 2022 07:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiIDLFg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 4 Sep 2022 07:05:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA75432D85;
        Sun,  4 Sep 2022 04:05:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6186060F63;
        Sun,  4 Sep 2022 11:05:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA2BC43142;
        Sun,  4 Sep 2022 11:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662289532;
        bh=K4+vScggM2EV2pgo7YlzZVyHFKhrScIEqSPeoPwXFmg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qEbp8Y1rPsMAPQEHmx3Iqc8skXgGHkWIu4d8pizi/7MYtcpj4RE4U3bC0uG0Gv+LX
         fJRNTCVGmRfEfT6PhSsiyLGxHYkNAtZl/umdVaMiT0v1qL+meNyWTuurP17//TbZSu
         PWAQ/Nu+qPipNEDmyn9Rb0xpf0kfkeorStcamYXdlfpOOPwqSJVIOeGdoX3zR1vlrr
         hf6mchIX3nuOO9nxTUy+Dn/SynzFo3bfNrJuQNJvORtL+LoPnYU0EQVf/RqD8wWb7F
         nEQ3ejUgLvV8ruCeJa3hx2M/MpLW47yXgsPDUAaGl0YRrfAgzL1SIw8LP4rmBjOGiF
         p3R89Jak14kPA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1272fc7f51aso2355566fac.12;
        Sun, 04 Sep 2022 04:05:32 -0700 (PDT)
X-Gm-Message-State: ACgBeo2qREMplpWrk2Tfnt4jPNf0rokS3odm7FEXcPMCXJGsTjVLYfSv
        Ic1BemPmZVHhqGJhwanhZOLUGmOe3AjKax2lzec=
X-Google-Smtp-Source: AA6agR5em28Nke+ymvWJLH5tNCVE9mGs7sOBHIp9Y9/1hyIoiIOMyGS3DYeVmncLqQ00+S/CpLllRUFRYkewJP0d+Yw=
X-Received: by 2002:a05:6870:7092:b0:11e:ff3a:d984 with SMTP id
 v18-20020a056870709200b0011eff3ad984mr6156094oae.19.1662289531884; Sun, 04
 Sep 2022 04:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220904072637.8619-1-guoren@kernel.org> <bdac65bd-175f-3f09-ae46-97d4fcc77d6f@microchip.com>
In-Reply-To: <bdac65bd-175f-3f09-ae46-97d4fcc77d6f@microchip.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 4 Sep 2022 19:05:20 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTvsWycqjx9joy6mRq_M4pgAPDy30ZhwKCsMC8HF6pKSQ@mail.gmail.com>
Message-ID: <CAJF2gTTvsWycqjx9joy6mRq_M4pgAPDy30ZhwKCsMC8HF6pKSQ@mail.gmail.com>
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
My name is written in Guo Ren / guoren. Don't separate them. In China,
no one calls me Guo or Ren separately, it makes me strange.

>
> This series seems to introduce a build warning:
>
> arch/riscv/kernel/irq.c:17:1: warning: symbol 'irq_stack_ptr' was not declared. Should it be static?
I don't have that warning. But you are right, it should be static.
Thank you. I will fix it in the next version of the patch.

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
> >    https://lore.kernel.org/linux-riscv/20220903162328.1952477-2-guoren@kernel.org/T/#u
>
> I find this really confusing. The same patch is in two different series?
> Is the above series no longer required & this is a different approach?
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
