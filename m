Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51BF34913C
	for <lists+linux-arch@lfdr.de>; Thu, 25 Mar 2021 12:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhCYLx3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Mar 2021 07:53:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229617AbhCYLxK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Mar 2021 07:53:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 88FFB61A24;
        Thu, 25 Mar 2021 11:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616673189;
        bh=NsPDV+Q0M1j6YnK0APDSgpnNUw2rzo4WQAGweu5O1S4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JIsJubSgNp1vQdOLfLqztFMepHItIrRXCBrjwk+j+ytnFJZWlZCcUW0CupFkIek8W
         ltKjtQMNwSem9aNt6oY2M6KlllnzYZ4Fouu0wXz/J3i1ckJ4mlPklCMB1+MsKxEyEx
         cUg2g7ciSim36p37MfZ18N+7MPm0ynVwFo5udnJd0XsaDwJDkgXhUReP3r+buDKQbh
         ELcpuw1dXd1PDf47AawJnnYQLbOTVU1U/P8sj6K2oT80Hugo1/bcY/9Mi8/704o0NS
         BkNynteEzm66DWlwMRYAzkmZpRZV7g0D94XYDoVkpYkJkrRmDWFJxAQAWSce2VOqK3
         wy9G1TU5g5srw==
Received: by mail-lj1-f176.google.com with SMTP id u9so2682173ljd.11;
        Thu, 25 Mar 2021 04:53:09 -0700 (PDT)
X-Gm-Message-State: AOAM533iiXq19jA2/32Aml/3okfiQlojGRCcK06OVT+e0Ns6cM0TT6Df
        ZJ/292qaw02a8DD4g6nZf4BQLbMHhtGtKke3NkA=
X-Google-Smtp-Source: ABdhPJxDid/H9g+ccXoiu4wXt6PEyymXG/HEfZErzfWdHRSCnezNgcD4AkGYRPbX9YdGN/eH3bMRH5bdykAWHGEAcCk=
X-Received: by 2002:a2e:9084:: with SMTP id l4mr5231252ljg.498.1616673187659;
 Thu, 25 Mar 2021 04:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <1616658937-82063-5-git-send-email-guoren@kernel.org>
 <202103251923.MFrI3wnb-lkp@intel.com> <CAJF2gTQgXzAB0NiTNTY1MvR=4BYx5+379W0PeOuHzayR3dWUng@mail.gmail.com>
In-Reply-To: <CAJF2gTQgXzAB0NiTNTY1MvR=4BYx5+379W0PeOuHzayR3dWUng@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 25 Mar 2021 19:52:55 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRiG+5f7y5HXe9EhfDWc3Q+pTEW_8sSFc0iGkbuMJO+NA@mail.gmail.com>
Message-ID: <CAJF2gTRiG+5f7y5HXe9EhfDWc3Q+pTEW_8sSFc0iGkbuMJO+NA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] riscv: Convert custom spinlock/rwlock to generic qspinlock/qrwlock
To:     kernel test robot <lkp@intel.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>, kbuild-all@lists.01.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        tech-unixplatformspec@lists.riscv.org,
        Michael Clark <michaeljclark@mac.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Anup Patel <anup@brainfault.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 5ca41152cf4b..894e170c503e 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -17,6 +17,14 @@
 #define __local_release_fence()
         \
        __asm__ __volatile__(RISCV_RELEASE_BARRIER "" ::: "memory")

+#ifdef CONFIG_32BIT
+#define __ASM_SLLIW "slli\t"
+#define __ASM_SRLIW "srli\t"
+#else
+#define __ASM_SLLIW "slliw\t"
+#define __ASM_SRLIW "srliw\t"
+#endif
+
 #define __xchg_relaxed(ptr, new, size)                                 \
 ({                                                                     \
        __typeof__(ptr) __ptr = (ptr);                                  \
@@ -31,14 +39,14 @@
                        __asm__ __volatile__ (                          \
                        "0:     lr.w    %0, (%4)        \n"             \
                        "       mv      %1, %0          \n"             \
-                       "       slliw   %1, %1, 16      \n"             \
-                       "       srliw   %1, %1, 16      \n"             \
+                       __ASM_SLLIW    "%1, %1, 16      \n"             \
+                       __ASM_SRLIW    "%1, %1, 16      \n"             \
                        "       mv      %2, %3          \n"             \
-                       "       slliw   %2, %2, 16      \n"             \
+                       __ASM_SLLIW    "%2, %2, 16      \n"             \
                        "       or      %1, %2, %1      \n"             \
                        "       sc.w    %2, %1, (%4)    \n"             \
                        "       bnez    %2, 0b          \n"             \
-                       "       srliw   %0, %0, 16      \n"             \
+                       __ASM_SRLIW    "%0, %0, 16      \n"             \
                        : "=&r" (__ret), "=&r" (tmp), "=&r" (__rc)      \
                        : "r" (__new), "r"(addr)                        \
                        : "memory");                                    \
@@ -46,14 +54,14 @@
                        __asm__ __volatile__ (                          \
                        "0:     lr.w    %0, (%4)        \n"             \
                        "       mv      %1, %0          \n"             \
-                       "       srliw   %1, %1, 16      \n"             \
-                       "       slliw   %1, %1, 16      \n"             \
+                       __ASM_SRLIW    "%1, %1, 16      \n"             \
+                       __ASM_SLLIW    "%1, %1, 16      \n"             \
                        "       mv      %2, %3          \n"             \
                        "       or      %1, %2, %1      \n"             \
                        "       sc.w    %2, %1, 0(%4)   \n"             \
                        "       bnez    %2, 0b          \n"             \
-                       "       slliw   %0, %0, 16      \n"             \
-                       "       srliw   %0, %0, 16      \n"             \
+                       __ASM_SLLIW    "%0, %0, 16      \n"             \
+                       __ASM_SRLIW    "%0, %0, 16      \n"             \
                        : "=&r" (__ret), "=&r" (tmp), "=&r" (__rc)      \
                        : "r" (__new), "r"(addr)                        \
                        : "memory");                                    \

On Thu, Mar 25, 2021 at 7:34 PM Guo Ren <guoren@kernel.org> wrote:
>
> haha, I forgot RV32, it needs a
>
> #ifdef RV32
>     srliw
> #else
>     srli
> #endif
>
> On Thu, Mar 25, 2021 at 7:16 PM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi,
> >
> > Thank you for the patch! Yet something to improve:
> >
> > [auto build test ERROR on tip/locking/core]
> > [also build test ERROR on linux/master linus/master v5.12-rc4 next-20210325]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch]
> >
> > url:    https://github.com/0day-ci/linux/commits/guoren-kernel-org/riscv-Add-qspinlock-qrwlock/20210325-155933
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 5965a7adbd72dd9b288c0911cb73719fed1efa08
> > config: riscv-rv32_defconfig (attached as .config)
> > compiler: riscv32-linux-gcc (GCC) 9.3.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://github.com/0day-ci/linux/commit/2bf2d117ab34b007089e20e1c46eff89b5da097e
> >         git remote add linux-review https://github.com/0day-ci/linux
> >         git fetch --no-tags linux-review guoren-kernel-org/riscv-Add-qspinlock-qrwlock/20210325-155933
> >         git checkout 2bf2d117ab34b007089e20e1c46eff89b5da097e
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=riscv
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    kernel/locking/qspinlock.c: Assembler messages:
> >    kernel/locking/qspinlock.c:184: Error: unrecognized opcode `srliw t1,t1,16'
> >    kernel/locking/qspinlock.c:185: Error: unrecognized opcode `slliw t1,t1,16'
> > >> kernel/locking/qspinlock.c:190: Error: unrecognized opcode `slliw a6,a6,16'
> > >> kernel/locking/qspinlock.c:191: Error: unrecognized opcode `srliw a6,a6,16'
> >    kernel/locking/qspinlock.c:184: Error: unrecognized opcode `slliw t1,t1,16'
> >    kernel/locking/qspinlock.c:185: Error: unrecognized opcode `srliw t1,t1,16'
> >    kernel/locking/qspinlock.c:187: Error: unrecognized opcode `slliw t3,t3,16'
> > >> kernel/locking/qspinlock.c:191: Error: unrecognized opcode `srliw a6,a6,16'
> >
> >
> > vim +190 kernel/locking/qspinlock.c
> >
> > 69f9cae90907e0 Peter Zijlstra (Intel  2015-04-24  187)
> > 59fb586b4a07b4 Will Deacon            2018-04-26  188  /**
> > 59fb586b4a07b4 Will Deacon            2018-04-26  189   * clear_pending - clear the pending bit.
> > 59fb586b4a07b4 Will Deacon            2018-04-26 @190   * @lock: Pointer to queued spinlock structure
> > 59fb586b4a07b4 Will Deacon            2018-04-26 @191   *
> > 59fb586b4a07b4 Will Deacon            2018-04-26  192   * *,1,* -> *,0,*
> > 59fb586b4a07b4 Will Deacon            2018-04-26  193   */
> > 59fb586b4a07b4 Will Deacon            2018-04-26  194  static __always_inline void clear_pending(struct qspinlock *lock)
> > 59fb586b4a07b4 Will Deacon            2018-04-26  195  {
> > 59fb586b4a07b4 Will Deacon            2018-04-26  196   atomic_andnot(_Q_PENDING_VAL, &lock->val);
> > 59fb586b4a07b4 Will Deacon            2018-04-26  197  }
> > 59fb586b4a07b4 Will Deacon            2018-04-26  198
> >
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
>
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
