Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FF655272F
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jun 2022 00:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239945AbiFTWxn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jun 2022 18:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344951AbiFTWxl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2022 18:53:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206901B7;
        Mon, 20 Jun 2022 15:53:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A36C361355;
        Mon, 20 Jun 2022 22:53:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114A2C341CB;
        Mon, 20 Jun 2022 22:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765619;
        bh=6G+6q4zHYBGjnmMtsdzXowzp8gLzUye2gO6TAFTUuVg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RlurRfthBbHG0QKrSaqkDnFxNTulZgDBa3HW8F5uMjAi6DL5lQbfN/673BZZW14Rr
         ZlfXZ6Q84lQMKbox6qv8IcEEMPqEeNXvT7+avZ3DpFcwzLzClV7LosUMeUSdhEo8K1
         d8wlQ7I5DtDJhk+HIyCZv+G3g1//eaQixcGq+ShKvyv5ritAc6Z2RUzsL3JW5Yahfa
         nPA5QJBZCyof/RLKoRDP8pqZjaEAUMSAbIZiQsNH6LHBJAFoYFlDrYx5GDUFUgIsgO
         uK+jGCxRBDn+C6WFKoI9kevf7qoMxjdZvjQnkRB+zcWehFKjJS1IehWKubRqQlxflm
         HavOy+ouAZdAA==
Received: by mail-vs1-f42.google.com with SMTP id h38so3901474vsv.7;
        Mon, 20 Jun 2022 15:53:38 -0700 (PDT)
X-Gm-Message-State: AJIora/MZ103gwKPuQUIlmAykzFnTQY1u1cME7tWXG4tsScXqnLJpT12
        H1v1y8GR2JKFyRzSxYR4IgICQ09KhCiIk6kKv3M=
X-Google-Smtp-Source: AGRyM1u0f0NVLjA/l56D/lpGr6oa55BZUDUWetp5N07H9ytLdmyD5b1ysI6OYN7x/d64Xg9hd4PNkTsKrw918AcrBr4=
X-Received: by 2002:a67:f958:0:b0:354:3f56:8a2d with SMTP id
 u24-20020a67f958000000b003543f568a2dmr1586127vsq.59.1655765617887; Mon, 20
 Jun 2022 15:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220620155404.1968739-1-guoren@kernel.org> <202206210303.Vjl4rpPv-lkp@intel.com>
In-Reply-To: <202206210303.Vjl4rpPv-lkp@intel.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 21 Jun 2022 06:53:26 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT_uicsJM66a+31d1DUvt=iLq2WDJjnD=2DNzBTFiu9kg@mail.gmail.com>
Message-ID: <CAJF2gTT_uicsJM66a+31d1DUvt=iLq2WDJjnD=2DNzBTFiu9kg@mail.gmail.com>
Subject: Re: [PATCH V5] riscv: Add qspinlock support
To:     kernel test robot <lkp@intel.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Is it a clang problem? GCC is okay. I would appreciate any help on the problem.

On Tue, Jun 21, 2022 at 3:58 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on soc/for-next]
> [also build test ERROR on linus/master v5.19-rc2 next-20220617]
> [cannot apply to tip/locking/core]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/guoren-kernel-org/riscv-Add-qspinlock-support/20220620-235653
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
> config: riscv-rv32_defconfig (https://download.01.org/0day-ci/archive/20220621/202206210303.Vjl4rpPv-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project af6d2a0b6825e71965f3e2701a63c239fa0ad70f)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install riscv cross compiling tool for clang build
>         # apt-get install binutils-riscv-linux-gnu
>         # https://github.com/intel-lab-lkp/linux/commit/326f4a13941845b6ef1c4f4eaba049fe265f52bf
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review guoren-kernel-org/riscv-Add-qspinlock-support/20220620-235653
>         git checkout 326f4a13941845b6ef1c4f4eaba049fe265f52bf
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv prepare
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All error/warnings (new ones prefixed by >>):
>
>    In file included from arch/riscv/kernel/asm-offsets.c:10:
>    In file included from include/linux/mm.h:7:
>    In file included from include/linux/gfp.h:6:
>    In file included from include/linux/mmzone.h:8:
>    In file included from include/linux/spinlock.h:62:
>    In file included from include/linux/lockdep.h:14:
>    In file included from include/linux/smp.h:13:
>    In file included from include/linux/cpumask.h:13:
>    In file included from include/linux/atomic.h:7:
> >> arch/riscv/include/asm/atomic.h:299:1: error: expected expression
>    ATOMIC_OPS()
>    ^
>    arch/riscv/include/asm/atomic.h:292:2: note: expanded from macro 'ATOMIC_OPS'
>            ATOMIC_OP(int,   , 4)
>            ^
>    arch/riscv/include/asm/atomic.h:249:9: note: expanded from macro 'ATOMIC_OP'
>            return __xchg_relaxed(&(v->counter), n, size);                  \
>                   ^
>    arch/riscv/include/asm/cmpxchg.h:21:3: note: expanded from macro '__xchg_relaxed'
>                    u32 temp;                                               \
>                    ^
>    In file included from arch/riscv/kernel/asm-offsets.c:10:
>    In file included from include/linux/mm.h:7:
>    In file included from include/linux/gfp.h:6:
>    In file included from include/linux/mmzone.h:8:
>    In file included from include/linux/spinlock.h:62:
>    In file included from include/linux/lockdep.h:14:
>    In file included from include/linux/smp.h:13:
>    In file included from include/linux/cpumask.h:13:
>    In file included from include/linux/atomic.h:7:
> >> arch/riscv/include/asm/atomic.h:299:1: error: use of undeclared identifier 'temp'; did you mean 'bcmp'?
>    arch/riscv/include/asm/atomic.h:292:2: note: expanded from macro 'ATOMIC_OPS'
>            ATOMIC_OP(int,   , 4)
>            ^
>    arch/riscv/include/asm/atomic.h:249:9: note: expanded from macro 'ATOMIC_OP'
>            return __xchg_relaxed(&(v->counter), n, size);                  \
>                   ^
>    arch/riscv/include/asm/cmpxchg.h:31:28: note: expanded from macro '__xchg_relaxed'
>                            : "=&r" (__ret), "=&r" (temp), "+A" (*__ptr)    \
>                                                    ^
>    include/linux/string.h:159:12: note: 'bcmp' declared here
>    extern int bcmp(const void *,const void *,__kernel_size_t);
>               ^
>    In file included from arch/riscv/kernel/asm-offsets.c:10:
>    In file included from include/linux/mm.h:7:
>    In file included from include/linux/gfp.h:6:
>    In file included from include/linux/mmzone.h:8:
>    In file included from include/linux/spinlock.h:62:
>    In file included from include/linux/lockdep.h:14:
>    In file included from include/linux/smp.h:13:
>    In file included from include/linux/cpumask.h:13:
>    In file included from include/linux/atomic.h:7:
> >> arch/riscv/include/asm/atomic.h:299:1: error: invalid lvalue in asm output
>    ATOMIC_OPS()
>    ^~~~~~~~~~~~
>    arch/riscv/include/asm/atomic.h:292:2: note: expanded from macro 'ATOMIC_OPS'
>            ATOMIC_OP(int,   , 4)
>            ^~~~~~~~~~~~~~~~~~~~~
>    arch/riscv/include/asm/atomic.h:249:9: note: expanded from macro 'ATOMIC_OP'
>            return __xchg_relaxed(&(v->counter), n, size);                  \
>                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/riscv/include/asm/cmpxchg.h:31:28: note: expanded from macro '__xchg_relaxed'
>                            : "=&r" (__ret), "=&r" (temp), "+A" (*__ptr)    \
>                                                    ^~~~
>    In file included from arch/riscv/kernel/asm-offsets.c:10:
>    In file included from include/linux/mm.h:7:
>    In file included from include/linux/gfp.h:6:
>    In file included from include/linux/mmzone.h:8:
>    In file included from include/linux/spinlock.h:62:
>    In file included from include/linux/lockdep.h:14:
>    In file included from include/linux/smp.h:13:
>    In file included from include/linux/cpumask.h:13:
>    In file included from include/linux/atomic.h:7:
> >> arch/riscv/include/asm/atomic.h:299:1: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
>    arch/riscv/include/asm/atomic.h:292:2: note: expanded from macro 'ATOMIC_OPS'
>            ATOMIC_OP(int,   , 4)
>            ^
>    arch/riscv/include/asm/atomic.h:249:9: note: expanded from macro 'ATOMIC_OP'
>            return __xchg_relaxed(&(v->counter), n, size);                  \
>                   ^
>    arch/riscv/include/asm/cmpxchg.h:22:7: note: expanded from macro '__xchg_relaxed'
>                    u32 shif = ((ulong)__ptr & 2) ? 16 : 0;                 \
>                        ^
>    In file included from arch/riscv/kernel/asm-offsets.c:10:
>    In file included from include/linux/mm.h:700:
>    In file included from include/linux/huge_mm.h:8:
>    In file included from include/linux/fs.h:33:
>    In file included from include/linux/percpu-rwsem.h:7:
>    In file included from include/linux/rcuwait.h:6:
>    In file included from include/linux/sched/signal.h:6:
>    include/linux/signal.h:97:11: warning: array index 3 is past the end of the array (which contains 2 elements) [-Warray-bounds]
>                    return (set->sig[3] | set->sig[2] |
>                            ^        ~
>    include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
>            unsigned long sig[_NSIG_WORDS];
>            ^
>    In file included from arch/riscv/kernel/asm-offsets.c:10:
>    In file included from include/linux/mm.h:700:
>    In file included from include/linux/huge_mm.h:8:
>    In file included from include/linux/fs.h:33:
>    In file included from include/linux/percpu-rwsem.h:7:
>    In file included from include/linux/rcuwait.h:6:
>    In file included from include/linux/sched/signal.h:6:
>    include/linux/signal.h:97:25: warning: array index 2 is past the end of the array (which contains 2 elements) [-Warray-bounds]
>                    return (set->sig[3] | set->sig[2] |
>                                          ^        ~
>    include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
>            unsigned long sig[_NSIG_WORDS];
>            ^
>    In file included from arch/riscv/kernel/asm-offsets.c:10:
>    In file included from include/linux/mm.h:700:
>    In file included from include/linux/huge_mm.h:8:
>    In file included from include/linux/fs.h:33:
>    In file included from include/linux/percpu-rwsem.h:7:
>    In file included from include/linux/rcuwait.h:6:
>    In file included from include/linux/sched/signal.h:6:
>    include/linux/signal.h:113:11: warning: array index 3 is past the end of the array (which contains 2 elements) [-Warray-bounds]
>                    return  (set1->sig[3] == set2->sig[3]) &&
>                             ^         ~
>    include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
>            unsigned long sig[_NSIG_WORDS];
>            ^
>    In file included from arch/riscv/kernel/asm-offsets.c:10:
>    In file included from include/linux/mm.h:700:
>    In file included from include/linux/huge_mm.h:8:
>    In file included from include/linux/fs.h:33:
>    In file included from include/linux/percpu-rwsem.h:7:
>    In file included from include/linux/rcuwait.h:6:
>    In file included from include/linux/sched/signal.h:6:
>    include/linux/signal.h:113:27: warning: array index 3 is past the end of the array (which contains 2 elements) [-Warray-bounds]
>                    return  (set1->sig[3] == set2->sig[3]) &&
>                                             ^         ~
>    include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
>            unsigned long sig[_NSIG_WORDS];
>            ^
>    In file included from arch/riscv/kernel/asm-offsets.c:10:
>    In file included from include/linux/mm.h:700:
>    In file included from include/linux/huge_mm.h:8:
>    In file included from include/linux/fs.h:33:
>    In file included from include/linux/percpu-rwsem.h:7:
>    In file included from include/linux/rcuwait.h:6:
>    In file included from include/linux/sched/signal.h:6:
>    include/linux/signal.h:114:5: warning: array index 2 is past the end of the array (which contains 2 elements) [-Warray-bounds]
>                            (set1->sig[2] == set2->sig[2]) &&
>                             ^         ~
>    include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
>            unsigned long sig[_NSIG_WORDS];
>            ^
>    In file included from arch/riscv/kernel/asm-offsets.c:10:
>    In file included from include/linux/mm.h:700:
>    In file included from include/linux/huge_mm.h:8:
>    In file included from include/linux/fs.h:33:
>    In file included from include/linux/percpu-rwsem.h:7:
>    In file included from include/linux/rcuwait.h:6:
>    In file included from include/linux/sched/signal.h:6:
>    include/linux/signal.h:114:21: warning: array index 2 is past the end of the array (which contains 2 elements) [-Warray-bounds]
>                            (set1->sig[2] == set2->sig[2]) &&
>                                             ^         ~
>    include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
>            unsigned long sig[_NSIG_WORDS];
>            ^
>    In file included from arch/riscv/kernel/asm-offsets.c:10:
>    In file included from include/linux/mm.h:700:
>    In file included from include/linux/huge_mm.h:8:
>    In file included from include/linux/fs.h:33:
>    In file included from include/linux/percpu-rwsem.h:7:
>    In file included from include/linux/rcuwait.h:6:
>    In file included from include/linux/sched/signal.h:6:
>    include/linux/signal.h:156:1: warning: array index 3 is past the end of the array (which contains 2 elements) [-Warray-bounds]
>    _SIG_SET_BINOP(sigorsets, _sig_or)
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/signal.h:137:8: note: expanded from macro '_SIG_SET_BINOP'
>                    a3 = a->sig[3]; a2 = a->sig[2];                         \
>                         ^      ~
>
>
> vim +299 arch/riscv/include/asm/atomic.h
>
> fab957c11efe2f Palmer Dabbelt 2017-07-10  298
> 5ce6c1f3535fa8 Andrea Parri   2018-03-09 @299  ATOMIC_OPS()
> fab957c11efe2f Palmer Dabbelt 2017-07-10  300
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp



--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
