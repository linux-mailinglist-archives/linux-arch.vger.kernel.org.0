Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93058660F51
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jan 2023 15:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjAGOHT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 7 Jan 2023 09:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjAGOHS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 7 Jan 2023 09:07:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E4A1DA;
        Sat,  7 Jan 2023 06:07:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A980FB810B3;
        Sat,  7 Jan 2023 14:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619F9C433F0;
        Sat,  7 Jan 2023 14:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673100433;
        bh=F1hP8g2fzdDqRR2w8HNEctZh13x2gOYdrnKuo+tRbq8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J7onqgmwPR0ivFaP4KIaTdgxxD1J/fTSy6XVPr87B9Ez0lH6Nv4DgP2Cf6sn09+Kf
         RBZj2BkvO7U8RLZKLmP3u/j9m1YsMn112RwB55VVawGHsunj+2/moF9wQkWJyzddpi
         TT6ytGRVPNP7iXm2gbL83qbUlLaNMmuVcaeIkyCjFl2PBMFuBfgKDUHZyARczqEBLY
         zAf6m6UHpd6Uja9iovde5nFi3DT+HYjYulUdp6QNwaWhMdypNxoosz+RVzfpZ0JyXs
         4Mx9azyG7AkbfOLNmVMrf311WAMd9YVazgKuN+uKQ+xyA92AqZpsqOsTCk4p0BAtbq
         ZisA6IdPjLbbA==
Received: by mail-ed1-f54.google.com with SMTP id v30so5944424edb.9;
        Sat, 07 Jan 2023 06:07:13 -0800 (PST)
X-Gm-Message-State: AFqh2krm19acHfZzxOx5xu523UCQv47S8V0joud6tNV8J3eqIgzbqZw7
        wAGwhMaQcRkMoV4OlTKvX2zvJljnGJLXkoQodOs=
X-Google-Smtp-Source: AMrXdXu3fbi11GqZl1RyUp6JPcz+JbDhnHRVbhhN+VoBiGErX7+96Vu5wFXrEMs6Pf/5erfI8shRQKZnuF1zeRVZ0hM=
X-Received: by 2002:a50:cc0a:0:b0:470:44ed:aff2 with SMTP id
 m10-20020a50cc0a000000b0047044edaff2mr6824154edi.103.1673100431593; Sat, 07
 Jan 2023 06:07:11 -0800 (PST)
MIME-Version: 1.0
References: <20230107113838.3969149-5-guoren@kernel.org> <202301072027.oxrCrTTy-lkp@intel.com>
In-Reply-To: <202301072027.oxrCrTTy-lkp@intel.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 7 Jan 2023 22:07:00 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQDQgWuj4fUTXMdqoLzJD7=pMFkGtqDSdr2e4ss6BxvNg@mail.gmail.com>
Message-ID: <CAJF2gTQDQgWuj4fUTXMdqoLzJD7=pMFkGtqDSdr2e4ss6BxvNg@mail.gmail.com>
Subject: Re: [PATCH -next V13 4/7] riscv: entry: Convert to generic entry
To:     kernel test robot <lkp@intel.com>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        luto@kernel.org, conor.dooley@microchip.com, heiko@sntech.de,
        jszhang@kernel.org, lazyparser@gmail.com, falcon@tinylab.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, mark.rutland@arm.com, ben@decadent.org.uk,
        bjorn@kernel.org, oe-kbuild-all@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Yipeng Zou <zouyipeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Yes, these are caused by W=1, and I would wait a while to update the
next version of the patchset.

Here is the fix:

diff --git a/arch/riscv/include/asm/asm-prototypes.h
b/arch/riscv/include/asm/asm-prototypes.h
index ef386fcf3939..61ba8ed43d8f 100644
--- a/arch/riscv/include/asm/asm-prototypes.h
+++ b/arch/riscv/include/asm/asm-prototypes.h
@@ -27,5 +27,7 @@ DECLARE_DO_ERROR_INFO(do_trap_break);

 asmlinkage unsigned long get_overflow_stack(void);
 asmlinkage void handle_bad_stack(struct pt_regs *regs);
+asmlinkage void do_page_fault(struct pt_regs *regs);
+asmlinkage void do_irq(struct pt_regs *regs);

 #endif /* _ASM_RISCV_PROTOTYPES_H */
diff --git a/arch/riscv/include/asm/entry-common.h
b/arch/riscv/include/asm/entry-common.h
index 994ed48e8eb8..6e4dee49d84b 100644
--- a/arch/riscv/include/asm/entry-common.h
+++ b/arch/riscv/include/asm/entry-common.h
@@ -5,6 +5,7 @@

 #include <asm/stacktrace.h>

-extern void handle_page_fault(struct pt_regs *regs);
+void handle_page_fault(struct pt_regs *regs);
+void handle_break(struct pt_regs *regs);

 #endif /* _ASM_RISCV_ENTRY_COMMON_H */
diff --git a/arch/riscv/kernel/head.h b/arch/riscv/kernel/head.h
index 726731ada534..a556fdaafed9 100644
--- a/arch/riscv/kernel/head.h
+++ b/arch/riscv/kernel/head.h
@@ -10,7 +10,6 @@

 extern atomic_t hart_lottery;

-asmlinkage void do_page_fault(struct pt_regs *regs);
 asmlinkage void __init setup_vm(uintptr_t dtb_pa);
 #ifdef CONFIG_XIP_KERNEL
 asmlinkage void __init __copy_data(void);
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index a7b6bd0df497..2e365084417e 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -12,6 +12,7 @@
 #include <linux/syscalls.h>
 #include <linux/resume_user_mode.h>
 #include <linux/linkage.h>
+#include <linux/entry-common.h>

 #include <asm/ucontext.h>
 #include <asm/vdso.h>
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index e04593c6cfe3..a44e7d15311c 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -15,6 +15,7 @@
 #include <linux/uaccess.h>
 #include <linux/kprobes.h>
 #include <linux/kfence.h>
+#include <linux/entry-common.h>

 #include <asm/ptrace.h>
 #include <asm/tlbflush.h>
~

On Sat, Jan 7, 2023 at 8:58 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on next-20230106]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/guoren-kernel-org/compiler_types-h-Add-__noinstr_section-for-noinstr/20230107-194127
> patch link:    https://lore.kernel.org/r/20230107113838.3969149-5-guoren%40kernel.org
> patch subject: [PATCH -next V13 4/7] riscv: entry: Convert to generic entry
> config: riscv-allyesconfig
> compiler: riscv64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/82d3616db033b052abe2dc3b1481ef5ce474b7ab
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review guoren-kernel-org/compiler_types-h-Add-__noinstr_section-for-noinstr/20230107-194127
>         git checkout 82d3616db033b052abe2dc3b1481ef5ce474b7ab
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/ arch/riscv/mm/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> arch/riscv/kernel/signal.c:277:6: warning: no previous prototype for 'arch_do_signal_or_restart' [-Wmissing-prototypes]
>      277 | void arch_do_signal_or_restart(struct pt_regs *regs)
>          |      ^~~~~~~~~~~~~~~~~~~~~~~~~
> --
> >> arch/riscv/kernel/traps.c:196:6: warning: no previous prototype for 'handle_break' [-Wmissing-prototypes]
>      196 | void handle_break(struct pt_regs *regs)
>          |      ^~~~~~~~~~~~
>    arch/riscv/kernel/traps.c:264:35: warning: no previous prototype for 'do_page_fault' [-Wmissing-prototypes]
>      264 | asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
>          |                                   ^~~~~~~~~~~~~
>    arch/riscv/kernel/traps.c:275:35: warning: no previous prototype for 'do_irq' [-Wmissing-prototypes]
>      275 | asmlinkage __visible noinstr void do_irq(struct pt_regs *regs)
>          |                                   ^~~~~~
> --
> >> arch/riscv/mm/fault.c:207:6: warning: no previous prototype for 'handle_page_fault' [-Wmissing-prototypes]
>      207 | void handle_page_fault(struct pt_regs *regs)
>          |      ^~~~~~~~~~~~~~~~~
>
>
> vim +/arch_do_signal_or_restart +277 arch/riscv/kernel/signal.c
>
>    276
>  > 277  void arch_do_signal_or_restart(struct pt_regs *regs)
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests



-- 
Best Regards
 Guo Ren
