Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D386CB24F
	for <lists+linux-arch@lfdr.de>; Tue, 28 Mar 2023 01:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjC0X1W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Mar 2023 19:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjC0X1U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Mar 2023 19:27:20 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EA11735
        for <linux-arch@vger.kernel.org>; Mon, 27 Mar 2023 16:27:17 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id ja10so9992101plb.5
        for <linux-arch@vger.kernel.org>; Mon, 27 Mar 2023 16:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112; t=1679959637;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N2eblIxdQ9eOajS6/9yChFGcTXWeq8mZSAJTCIeHQXY=;
        b=mSsEZy+QoYngsMsw/2Jz0S09cAdM0iXBxtW/mBHosjtX0poiCu2kyTcaQejbYhhzgH
         BodbMLgRYvDBdu1+a5kZbPvJga7qwB0L+RN/Te0f6a2vVvNmOWh9opkBxQTGgk9xHtoE
         +3QlwG36rJQBRYxZy33BzakBa6Mlf7GHOxK5eXLwm1NA0zpBCw6PJobS/GevFDde1dqS
         OIwDySPSVDzyh84P0w+XfHwjsT3IGVs6U58WcUCDfOQ257MxYPxBN5MJ9+U83uxl688r
         w4UtfqzAFjJE6/BUVcSJpcyQZusGemeVNQMlgsiZzE5lUQxcFIU3Q2ySFotCTRvaXXMi
         FKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679959637;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2eblIxdQ9eOajS6/9yChFGcTXWeq8mZSAJTCIeHQXY=;
        b=T2noKxE6DMqUdROBql4oaMmHMjCiK+rRQfDN7jhl7BDGl1GKBjZgDSb1F/cxqI3Qox
         Yo1bnrrvcFyabZCdNug2e5Uldp4x6o1Gz8X0IJeK6GDWiwai8b/FWLYwlE+POWmkHgnE
         KGYM56OSoZbpWpZYDxB4jQlqJ3DUP9p5B14qP8xyMjg8SHsQLrw6M4TojBtPggWgf6mR
         BrQYg/VsIzort9/1I5kkdyBtPADYaW5s3es0bLWQBA5sHKP5bYg66gHs2ZPRGA3u3rYT
         atwRYyDAQLMhHN8BklilvarLfxEvyhTXkiSVfrr7rrnqPT7stRvEGu+0QrU/oiKqq8dp
         5iuA==
X-Gm-Message-State: AAQBX9dFg6XXy0LV+CFejOGXVftdtYmoCHxulzgH+EADqo7vV/qBdPlK
        efrW5xGejdLXh+Gboto9fZBJoQ==
X-Google-Smtp-Source: AKy350ash46+zS5HPV0mseKB44rDQqXTs34uI7+J2wuTGftbjJa1uJDZ88OMdYf5up5wVKZkB5paqQ==
X-Received: by 2002:a17:902:ce83:b0:1a1:ad5e:bdb2 with SMTP id f3-20020a170902ce8300b001a1ad5ebdb2mr16855552plg.57.1679959636953;
        Mon, 27 Mar 2023 16:27:16 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id bj4-20020a170902850400b001a076568da9sm2638780plb.216.2023.03.27.16.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 16:27:16 -0700 (PDT)
Date:   Mon, 27 Mar 2023 16:27:16 -0700 (PDT)
X-Google-Original-Date: Mon, 27 Mar 2023 16:24:24 PDT (-0700)
Subject:     Re: [PATCH -next V17 0/7] riscv: Add GENERIC_ENTRY support
In-Reply-To: <20230222033021.983168-1-guoren@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>, guoren@kernel.org,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        Conor Dooley <conor.dooley@microchip.com>, heiko@sntech.de,
        jszhang@kernel.org, lazyparser@gmail.com, falcon@tinylab.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, Mark Rutland <mark.rutland@arm.com>,
        ben@decadent.org.uk, bjorn@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        guoren@linux.alibaba.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     guoren@kernel.org
Message-ID: <mhng-edcee57b-ffdc-4073-ae4f-91bd91ff2d5c@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 21 Feb 2023 19:30:14 PST (-0800), guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> The patches convert riscv to use the generic entry infrastructure from
> kernel/entry/*. Some optimization for entry.S with new .macro and merge
> ret_from_kernel_thread into ret_from_fork.
>
> The 1,2 are the preparation of generic entry. 3~7 are the main part
> of generic entry.
>
> All tested with rv64, rv32, rv64 + 32rootfs, all are passed.
>
> You can directly try it with:
> [1] https://github.com/guoren83/linux/tree/generic_entry_v17
>
> Any reviews and tests are helpful.
>
> v17:
>  - Rebase on newest palmer/for-next 20230222
>  - Modify save_from_x6_to_x31/restore_from_x6_to_x31 to fit
>    ftrace size reduce patch in for-next.
>
> v16:
> https://lore.kernel.org/linux-riscv/20230204070213.753369-1-guoren@kernel.org/
>  - Re-order commit tags for "compiler_types.h: Add __noinstr_section()
>    for noinstr" (Thx Miguel)
>
> v15:
> https://lore.kernel.org/linux-riscv/20230126172516.1580058-1-guoren@kernel.org/
>  - Fixup compile error for !MMU (Thx Conor)
>  - Rebase on riscv for-next (20230127)
>
> v14:
> https://lore.kernel.org/linux-riscv/20230112095848.1464404-1-guoren@kernel.org/
>  - Fixup W=1 warning reported by kernel test robot <lkp@intel.com>
>
> v13:
> https://lore.kernel.org/linux-riscv/20230107113838.3969149-1-guoren@kernel.org/
>  - Remove noinstr for original do_page_fault
>  - Centralize all the necesarily-noinstr bits in
>    arch/riscv/kernel/traps.c
>
> v12:
> https://lore.kernel.org/linux-riscv/20230103033531.2011112-1-guoren@kernel.org/
>  - Rebase on newest for-next-20230103 (Linux 6.2-rc1)
>  - Add Reviewed-by: Björn Töpel
>
> v11:
> https://lore.kernel.org/linux-riscv/20221210171141.1120123-1-guoren@kernel.org/
>  - Rebase on newest for-next-20221211
>  - Remove stack optimization patch series
>  - Optimize comments
>  - Replace ENTRY with SYM_CODE/FUNC_START in entry.S
>
> v10:
> https://lore.kernel.org/linux-riscv/20221208025816.138712-1-guoren@kernel.org/
>  - Rebase on palmer/for-next branch (20221208)
>  - Remove unrelated patches from the series (Suggested-by: Bjorn)
>  - Fixup Typos.
>
> v9:
> https://lore.kernel.org/linux-riscv/20221130034059.826599-1-guoren@kernel.org/
>  - Fixup NR_syscalls check (by Ben Hutchings)
>  - Add Tested-by: Jisheng Zhang
>
> v8:
> https://lore.kernel.org/linux-riscv/20221103075047.1634923-1-guoren@kernel.org/
>  - Rebase on palmer/for-next branch (20221102)
>  - Add save/restore_from_x5_to_x31 .macro (JishengZhang)
>  - Consolidate ret_from_kernel_thread into ret_from_fork (JishengZhang)
>  - Optimize __noinstr_section comment (JiangshanLai)
>
> v7:
> https://lore.kernel.org/linux-riscv/20221015114702.3489989-1-guoren@kernel.org/
>  - Fixup regs_irqs_disabled with SR_PIE
>  - Optimize stackleak_erase -> stackleak_erase_on_task_stack (Thx Mark
>    Rutland)
>  - Add BUG_ON(!irqs_disabled()) in trap handlers
>  - Using regs_irqs_disabled in __do_page_fault
>  - Remove unnecessary irq disable in ret_from_exception and add comment
>
> v6:
> https://lore.kernel.org/linux-riscv/20221002012451.2351127-1-guoren@kernel.org/
>  - Use THEAD_SIZE_ORDER for thread size adjustment in kconfig (Thx Arnd)
>  - Move call_on_stack to inline style (Thx Peter Zijlstra)
>  - Fixup fp chain broken (Thx Chen Zhongjin)
>  - Remove common entry modification, and fixup page_fault entry (Thx
>    Peter Zijlstra)
>  - Treat some traps as nmi entry (Thx Peter Zijlstra)
>
> v5:
> https://lore.kernel.org/linux-riscv/20220918155246.1203293-1-guoren@kernel.org/
>  - Add riscv own stackleak patch instead of generic entry modification
>    (by Mark Rutland)
>  - Add EXPERT dependency for THREAD_SIZE (by Arnd)
>  - Add EXPERT dependency for IRQ_STACK (by Sebastian, David Laight)
>  - Corrected __trap_section (by Peter Zijlstra)
>  - Add Tested-by (Yipeng Zou)
>  - Use CONFIG_SOFTIRQ_ON_OWN_STACK replace "#ifndef CONFIG_PREEMPT_RT"
>  - Fixup systrace_enter compile error
>  - Fixup exit_to_user_mode_prepare preempt_disable warning
>
> V4:
> https://lore.kernel.org/linux-riscv/20220908022506.1275799-1-guoren@kernel.org/
>  - Fixup entry.S with "la" bug (by Conor.Dooley)
>  - Fixup missing noinstr bug (by Peter Zijlstra)
>
> V3:
> https://lore.kernel.org/linux-riscv/20220906035423.634617-1-guoren@kernel.org/
>  - Fixup CONFIG_COMPAT=n compile error
>  - Add THREAD_SIZE_ORDER config
>  - Optimize elf_kexec.c warning fixup
>  - Add static to irq_stack_ptr definition
>
> V2:
> https://lore.kernel.org/linux-riscv/20220904072637.8619-1-guoren@kernel.org/
>  - Fixup compile error by include "riscv: ptrace: Remove duplicate
>    operation"
>  - Fixup compile warning
>    Reported-by: kernel test robot <lkp@intel.com>
>  - Add test repo link in cover letter
>
> V1:
> https://lore.kernel.org/linux-riscv/20220903163808.1954131-1-guoren@kernel.org/
>
> Guo Ren (3):
>   riscv: ptrace: Remove duplicate operation
>   riscv: entry: Add noinstr to prevent instrumentation inserted
>   riscv: entry: Convert to generic entry
>
> Jisheng Zhang (3):
>   riscv: entry: Remove extra level wrappers of trace_hardirqs_{on,off}
>   riscv: entry: Consolidate ret_from_kernel_thread into ret_from_fork
>   riscv: entry: Consolidate general regs saving/restoring
>
> Lai Jiangshan (1):
>   compiler_types.h: Add __noinstr_section() for noinstr
>
>  arch/riscv/Kconfig                      |   1 +
>  arch/riscv/include/asm/asm-prototypes.h |   2 +
>  arch/riscv/include/asm/asm.h            |  61 +++++
>  arch/riscv/include/asm/csr.h            |   1 -
>  arch/riscv/include/asm/entry-common.h   |  11 +
>  arch/riscv/include/asm/ptrace.h         |  10 +-
>  arch/riscv/include/asm/stacktrace.h     |   5 +
>  arch/riscv/include/asm/syscall.h        |  21 ++
>  arch/riscv/include/asm/thread_info.h    |  13 +-
>  arch/riscv/kernel/Makefile              |   2 -
>  arch/riscv/kernel/entry.S               | 321 +++---------------------
>  arch/riscv/kernel/head.h                |   1 -
>  arch/riscv/kernel/mcount-dyn.S          |  57 +----
>  arch/riscv/kernel/process.c             |   5 +-
>  arch/riscv/kernel/ptrace.c              |  44 ----
>  arch/riscv/kernel/signal.c              |  29 +--
>  arch/riscv/kernel/trace_irq.c           |  27 --
>  arch/riscv/kernel/trace_irq.h           |  11 -
>  arch/riscv/kernel/traps.c               | 144 +++++++++--
>  arch/riscv/mm/fault.c                   |   6 +-
>  include/linux/compiler_types.h          |  15 +-
>  21 files changed, 289 insertions(+), 498 deletions(-)
>  create mode 100644 arch/riscv/include/asm/entry-common.h
>  delete mode 100644 arch/riscv/kernel/trace_irq.c
>  delete mode 100644 arch/riscv/kernel/trace_irq.h

Thanks, this is on for-next.
