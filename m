Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3322D3490B3
	for <lists+linux-arch@lfdr.de>; Thu, 25 Mar 2021 12:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhCYLiM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Mar 2021 07:38:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231241AbhCYLfD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Mar 2021 07:35:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68AA861A32;
        Thu, 25 Mar 2021 11:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616672102;
        bh=8LNmhoq6g6CBU2dxDceorKNyEZNIJTXJgc3Og50BKL0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZqR83NaJGhYCXRddW4LKTd24rNy3oRaOuUOijIZtdYSsmVNqtLnKcYzHx5FP9Hz5n
         Jabze/8c1Vo9bw50rF9C4kzuUMkb8zDePlPOC8Bwn9HmvCY647yNAnPV6xbK6BPa6x
         ZjxMxkUk7npt9nc9g31qTk79aoJwgQAgYuiH7quJGCXCmA4Q2PeliF7q/P38csyx72
         PJKBRt5tJjVsN7HW91CA38/TSM8XVkwOqYFS/ASJi/jIoKEbQ9E21t+VkjVNezbSeC
         fXJNB2pnXtQ6RYzS6qzeneHhjUc0Gp2nJXZCcGkNQPbUvLGsvZUn8xupkbhvd1xSFa
         AuEp4Jy88kGUQ==
Received: by mail-lj1-f177.google.com with SMTP id f16so2694816ljm.1;
        Thu, 25 Mar 2021 04:35:02 -0700 (PDT)
X-Gm-Message-State: AOAM530mnMXy9jKJKPzD2cp+n8h/qrN+K4zwEF6nynFP184deNwaFesv
        vHP1wVMMK8j+tofgw0Tocl8oCU4g/cxpkFiKZC0=
X-Google-Smtp-Source: ABdhPJzy6pR5fzFckmoZlwY42m9Hxg36LHc0Jsrh71m4xFAi2Ymec/Am/f5GaTmsOKLPYwxZ2BEgR+OXjtEQltf/jyU=
X-Received: by 2002:a2e:9e8e:: with SMTP id f14mr5260832ljk.285.1616672100472;
 Thu, 25 Mar 2021 04:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <1616658937-82063-5-git-send-email-guoren@kernel.org> <202103251923.MFrI3wnb-lkp@intel.com>
In-Reply-To: <202103251923.MFrI3wnb-lkp@intel.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 25 Mar 2021 19:34:49 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQgXzAB0NiTNTY1MvR=4BYx5+379W0PeOuHzayR3dWUng@mail.gmail.com>
Message-ID: <CAJF2gTQgXzAB0NiTNTY1MvR=4BYx5+379W0PeOuHzayR3dWUng@mail.gmail.com>
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

haha, I forgot RV32, it needs a

#ifdef RV32
    srliw
#else
    srli
#endif

On Thu, Mar 25, 2021 at 7:16 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on tip/locking/core]
> [also build test ERROR on linux/master linus/master v5.12-rc4 next-20210325]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/guoren-kernel-org/riscv-Add-qspinlock-qrwlock/20210325-155933
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 5965a7adbd72dd9b288c0911cb73719fed1efa08
> config: riscv-rv32_defconfig (attached as .config)
> compiler: riscv32-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/2bf2d117ab34b007089e20e1c46eff89b5da097e
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review guoren-kernel-org/riscv-Add-qspinlock-qrwlock/20210325-155933
>         git checkout 2bf2d117ab34b007089e20e1c46eff89b5da097e
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=riscv
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    kernel/locking/qspinlock.c: Assembler messages:
>    kernel/locking/qspinlock.c:184: Error: unrecognized opcode `srliw t1,t1,16'
>    kernel/locking/qspinlock.c:185: Error: unrecognized opcode `slliw t1,t1,16'
> >> kernel/locking/qspinlock.c:190: Error: unrecognized opcode `slliw a6,a6,16'
> >> kernel/locking/qspinlock.c:191: Error: unrecognized opcode `srliw a6,a6,16'
>    kernel/locking/qspinlock.c:184: Error: unrecognized opcode `slliw t1,t1,16'
>    kernel/locking/qspinlock.c:185: Error: unrecognized opcode `srliw t1,t1,16'
>    kernel/locking/qspinlock.c:187: Error: unrecognized opcode `slliw t3,t3,16'
> >> kernel/locking/qspinlock.c:191: Error: unrecognized opcode `srliw a6,a6,16'
>
>
> vim +190 kernel/locking/qspinlock.c
>
> 69f9cae90907e0 Peter Zijlstra (Intel  2015-04-24  187)
> 59fb586b4a07b4 Will Deacon            2018-04-26  188  /**
> 59fb586b4a07b4 Will Deacon            2018-04-26  189   * clear_pending - clear the pending bit.
> 59fb586b4a07b4 Will Deacon            2018-04-26 @190   * @lock: Pointer to queued spinlock structure
> 59fb586b4a07b4 Will Deacon            2018-04-26 @191   *
> 59fb586b4a07b4 Will Deacon            2018-04-26  192   * *,1,* -> *,0,*
> 59fb586b4a07b4 Will Deacon            2018-04-26  193   */
> 59fb586b4a07b4 Will Deacon            2018-04-26  194  static __always_inline void clear_pending(struct qspinlock *lock)
> 59fb586b4a07b4 Will Deacon            2018-04-26  195  {
> 59fb586b4a07b4 Will Deacon            2018-04-26  196   atomic_andnot(_Q_PENDING_VAL, &lock->val);
> 59fb586b4a07b4 Will Deacon            2018-04-26  197  }
> 59fb586b4a07b4 Will Deacon            2018-04-26  198
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
