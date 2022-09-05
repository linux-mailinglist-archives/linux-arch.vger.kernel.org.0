Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D125AD3D8
	for <lists+linux-arch@lfdr.de>; Mon,  5 Sep 2022 15:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiIEN1Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Sep 2022 09:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbiIEN1Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 09:27:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150FF48E8E;
        Mon,  5 Sep 2022 06:27:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0C68B811A3;
        Mon,  5 Sep 2022 13:27:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A847EC433D6;
        Mon,  5 Sep 2022 13:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662384440;
        bh=FhrsajGQQIMz9z7n/XSvu9LOzvT3rIds+CNm2LlWuAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QlEXsJuD6yKRFA2zpqB08a91w2o064RANecRM8htACkXyOzCYwv3hTFbYDn1ZYM7m
         BiV01d18Eq2We60S2jv2iGajjbE3w0JcEEEB/L/DKOUvLbaJtha7bVk58Xnoamvs1X
         5VgJtzHJ3E0lHsZCtjTD62iHnylBcCmU6tVsxkvcsTeedmhWk6SS7b2KqY7d9RRmNI
         PYhCRlN8m6uduMYYJTWHO9IZitkiVjLAJYT1CD+p+hih1HSLL/UlVjuj9SdXHdjCnw
         SyTGsImzi09L3HxcFVNjJSoe2ENcmxhWwskL2hvCClR2fFuoSFpPG/Jq36C1hs5R0H
         mjBKKSC6OlZ/w==
Date:   Mon, 5 Sep 2022 21:18:01 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, lazyparser@gmail.com, falcon@tinylab.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V2 0/6] riscv: Add GENERIC_ENTRY, IRQ_STACKS support
Message-ID: <YxX3CZQEe86u052D@xhacker>
References: <20220904072637.8619-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220904072637.8619-1-guoren@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 04, 2022 at 03:26:31AM -0400, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The patches convert riscv to use the generic entry infrastructure from
> kernel/entry/*. Add independent irq stacks (IRQ_STACKS) for percpu to

Amazing! You read my mind. I planed to do similar series this week, as
can be seen, I didn't RESEND the riscv irqstack patch, I planed to add
irqstack after generic entry. Thanks for this series.

Will read and test your patches soon. A minor comments below.

> prevent kernel stack overflows. Add the HAVE_SOFTIRQ_ON_OWN_STACK
> feature for the IRQ_STACKS config. You can try it directly with [1].
> 
> [1] https://github.com/guoren83/linux/tree/generic_entry_v2
> 
> Changes in V2:
>  - Fixup compile error by include "riscv: ptrace: Remove duplicate
>    operation"
>    https://lore.kernel.org/linux-riscv/20220903162328.1952477-2-guoren@kernel.org/T/#u
>  - Fixup compile warning
>    Reported-by: kernel test robot <lkp@intel.com>
>  - Add test repo link in cover letter
> 
> Guo Ren (6):
>   riscv: ptrace: Remove duplicate operation
>   riscv: convert to generic entry
>   riscv: Support HAVE_IRQ_EXIT_ON_IRQ_STACK
>   riscv: Support HAVE_SOFTIRQ_ON_OWN_STACK
>   riscv: elf_kexec: Fixup compile warning
>   riscv: compat_syscall_table: Fixup compile warning

It's better to move these two patches ahead of patch2.

> 
>  arch/riscv/Kconfig                    |  10 +
>  arch/riscv/include/asm/csr.h          |   1 -
>  arch/riscv/include/asm/entry-common.h |   8 +
>  arch/riscv/include/asm/irq.h          |   3 +
>  arch/riscv/include/asm/ptrace.h       |  10 +-
>  arch/riscv/include/asm/stacktrace.h   |   5 +
>  arch/riscv/include/asm/syscall.h      |   6 +
>  arch/riscv/include/asm/thread_info.h  |  15 +-
>  arch/riscv/include/asm/vmap_stack.h   |  28 +++
>  arch/riscv/kernel/Makefile            |   1 +
>  arch/riscv/kernel/elf_kexec.c         |   4 +
>  arch/riscv/kernel/entry.S             | 255 +++++---------------------
>  arch/riscv/kernel/irq.c               |  75 ++++++++
>  arch/riscv/kernel/ptrace.c            |  41 -----
>  arch/riscv/kernel/signal.c            |  21 +--
>  arch/riscv/kernel/sys_riscv.c         |  26 +++
>  arch/riscv/kernel/traps.c             |  11 ++
>  arch/riscv/mm/fault.c                 |  12 +-
>  18 files changed, 250 insertions(+), 282 deletions(-)
>  create mode 100644 arch/riscv/include/asm/entry-common.h
>  create mode 100644 arch/riscv/include/asm/vmap_stack.h
> 
> -- 
> 2.36.1
> 
