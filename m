Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7D95AC1C6
	for <lists+linux-arch@lfdr.de>; Sun,  4 Sep 2022 02:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiIDAE1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 3 Sep 2022 20:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiIDAE0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 3 Sep 2022 20:04:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95B1295;
        Sat,  3 Sep 2022 17:04:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A2C0B80C7E;
        Sun,  4 Sep 2022 00:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03865C433D7;
        Sun,  4 Sep 2022 00:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662249859;
        bh=KoBcKASn8qA//k0q8Ko3Kw15nV3tnc0Cq8A9Lc6qS2M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NdxZRRaQDTmrzkWXFeVybd/TdF7FjscPT47/ARklt7ZgWR5S+22+TXu0dzkVPVhb1
         a31Cke7rub19cP4VJgeULHCBnvBfnbOSmyFnYFrC5z8nYwGc4/SYys88p9cU0HRLM8
         n11Ow83e4k1mzbNUcQ4U+sM7kNmFEeEO4ujAQRmSyzlK3WqCMPRN3eEDh8YFkPMRUs
         v3wFPU0WCJluAOT5bBymKqxvM3FA6TdQdil432D5MhA29TkldSBdR50cy17pSC95Zf
         pUBPHMeGbvJFjbxQ+7RplRCgdQ5pbRqMFcwU81X7NAXL5p3c2BnfJC1gR8eHhc3Hbr
         98UppoBmbfPng==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-11ee4649dfcso13895800fac.1;
        Sat, 03 Sep 2022 17:04:18 -0700 (PDT)
X-Gm-Message-State: ACgBeo3ImbrWYS8rXAVqfuwLFDcNih1t5g2M/PZ2dLmVkKuZUqFOHFf9
        +svcwsN/x6Bf0hCMeb4QGDT2WK51/5Ez2J8OIFc=
X-Google-Smtp-Source: AA6agR77EBLmMj9+Q0o/9QIp5FTxFDt+rkmb/qt7Y2jzmFtjgapjSdtfZhSF08/NbwXO8Vu04joLKLktUvxiUio0tnU=
X-Received: by 2002:a05:6870:7092:b0:11e:ff3a:d984 with SMTP id
 v18-20020a056870709200b0011eff3ad984mr5348554oae.19.1662249858171; Sat, 03
 Sep 2022 17:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220903163808.1954131-4-guoren@kernel.org> <202209040118.GmG1Lby1-lkp@intel.com>
In-Reply-To: <202209040118.GmG1Lby1-lkp@intel.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 4 Sep 2022 08:04:05 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQFYAth8WDwch-d1ASFEaKFJTuMrZgJEttOoBZtxay6nQ@mail.gmail.com>
Message-ID: <CAJF2gTQFYAth8WDwch-d1ASFEaKFJTuMrZgJEttOoBZtxay6nQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] riscv: Support HAVE_SOFTIRQ_ON_OWN_STACK
To:     kernel test robot <lkp@intel.com>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        luto@kernel.org, kbuild-all@lists.01.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
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

Oops, there is no warning with 6.0-rc3. But it's a bug, I fixed that by:

diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index afc8c030c222..5871eccbbd94 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -12,6 +12,7 @@
 #include <linux/syscalls.h>
 #include <linux/resume_user_mode.h>
 #include <linux/linkage.h>
+#include <linux/entry-common.h>

 #include <asm/ucontext.h>
 #include <asm/vdso.h>
@@ -272,7 +273,7 @@ static void handle_signal(struct ksignal *ksig,
struct pt_regs *regs)
        signal_setup_done(ret, ksig, 0);
 }

-void arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal)
+void arch_do_signal_or_restart(struct pt_regs *regs)
 {
        struct ksignal ksig;

On Sun, Sep 4, 2022 at 1:59 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on soc/for-next]
> [also build test WARNING on linus/master v6.0-rc3 next-20220901]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/guoren-kernel-org/riscv-Add-GENERIC_ENTRY-IRQ_STACKS-support/20220904-003954
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
> config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20220904/202209040118.GmG1Lby1-lkp@intel.com/config)
> compiler: riscv64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/6ed1ef93b372116f7d4586b13bfd352e19453740
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review guoren-kernel-org/riscv-Add-GENERIC_ENTRY-IRQ_STACKS-support/20220904-003954
>         git checkout 6ed1ef93b372116f7d4586b13bfd352e19453740
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> arch/riscv/kernel/irq.c:48:6: warning: no previous prototype for 'do_softirq_own_stack' [-Wmissing-prototypes]
>       48 | void do_softirq_own_stack(void)
>          |      ^~~~~~~~~~~~~~~~~~~~
>    arch/riscv/kernel/irq.c:74:25: warning: no previous prototype for 'handle_riscv_irq' [-Wmissing-prototypes]
>       74 | asmlinkage void noinstr handle_riscv_irq(struct pt_regs *regs)
>          |                         ^~~~~~~~~~~~~~~~
>    arch/riscv/kernel/irq.c:85:25: warning: no previous prototype for 'do_riscv_irq' [-Wmissing-prototypes]
>       85 | asmlinkage void noinstr do_riscv_irq(struct pt_regs *regs)
>          |                         ^~~~~~~~~~~~
>
>
> vim +/do_softirq_own_stack +48 arch/riscv/kernel/irq.c
>
>     47
>   > 48  void do_softirq_own_stack(void)
>     49  {
>     50          ulong *sp = per_cpu(irq_stack_ptr, smp_processor_id());
>     51
>     52          call_on_stack(NULL, sp, do_riscv_softirq, 0);
>     53  }
>     54  #endif /* CONFIG_PREEMPT_RT */
>     55
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp



-- 
Best Regards
 Guo Ren
