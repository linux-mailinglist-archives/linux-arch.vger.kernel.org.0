Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81C35130C89
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jan 2020 04:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgAFD1P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Jan 2020 22:27:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:45298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbgAFD1P (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 5 Jan 2020 22:27:15 -0500
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED6AC218AC;
        Mon,  6 Jan 2020 03:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578281234;
        bh=Zo+Fm8zO3lwsW6sZymHRh/4KsQXc6l1b/Ks9odphPR0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z0UwdeIDHhcH0bW8cMbIjnpqCStxe5BOfqJVW76lGxrpfgsRH/Q5lih0aZlEABzDm
         HWQaCImcVIi5OjEYe6PikuM8t2KLZVnbSDxhAcN/gg4q9UCZsitaCmAs7YI07pswKo
         teIg6PGUXySLYj4xI8Wf6fm+vkRcDmm/pqwRE70M=
Received: by mail-lf1-f46.google.com with SMTP id f15so35416333lfl.13;
        Sun, 05 Jan 2020 19:27:13 -0800 (PST)
X-Gm-Message-State: APjAAAVIHFBWBbVbG+dfgBB45WwviUUKcLYmZoh5tob+4URTToTnnKZL
        EQz4x2QQGkRmfp/uNdiOCobQ/cIDQ8MWql0GX7Q=
X-Google-Smtp-Source: APXvYqygCSR6wPl5Ag17BA0i6KBc166EX6D0V4oaPVYvRn207pSfZ3zxEP1EqHI7xIYOgn2TOflxuC6xqb3hUkXGgbA=
X-Received: by 2002:ac2:4476:: with SMTP id y22mr55916850lfl.169.1578281232059;
 Sun, 05 Jan 2020 19:27:12 -0800 (PST)
MIME-Version: 1.0
References: <20200105025215.2522-2-guoren@kernel.org> <202001052007.tXdAjjwN%lkp@intel.com>
In-Reply-To: <202001052007.tXdAjjwN%lkp@intel.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 6 Jan 2020 11:27:00 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTxu+rWAB2nZqQ8P-Z6xoFDi82ZSjHjjG-Ub99mU9yA-A@mail.gmail.com>
Message-ID: <CAJF2gTTxu+rWAB2nZqQ8P-Z6xoFDi82ZSjHjjG-Ub99mU9yA-A@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: Add vector ISA support
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        Anup Patel <Anup.Patel@wdc.com>, vincent.chen@sifive.com,
        zong.li@sifive.com, greentime.hu@sifive.com,
        Bin Meng <bmeng.cn@gmail.com>,
        Atish Patra <atish.patra@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <ren_guo@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

__uint128_t could work with gcc 8.1.

If compile the patch we need some small patch for binutils to support
several vector instructions, 0-day gcc need be updated in future.


On Sun, Jan 5, 2020 at 8:33 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v5.5-rc4 next-20191220]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/guoren-kernel-org/riscv-Fixup-obvious-bug-for-fp-regs-reset/20200105-105609
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git c420ddda506b80ec2686e405698d37fafeea3b7a
> config: riscv-rv32_defconfig (attached as .config)
> compiler: riscv32-linux-gcc (GCC) 7.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.5.0 make.cross ARCH=riscv
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    In file included from arch/riscv/include/asm/ptrace.h:9:0,
>                     from arch/riscv/include/asm/processor.h:11,
>                     from arch/riscv/include/asm/irqflags.h:10,
>                     from include/linux/irqflags.h:16,
>                     from arch/riscv/include/asm/bitops.h:14,
>                     from include/linux/bitops.h:26,
>                     from include/linux/kernel.h:12,
>                     from include/asm-generic/bug.h:19,
>                     from arch/riscv/include/asm/bug.h:75,
>                     from include/linux/bug.h:5,
>                     from include/linux/page-flags.h:10,
>                     from kernel/bounds.c:10:
> >> arch/riscv/include/uapi/asm/ptrace.h:75:2: error: unknown type name '__uint128_t'
>      __uint128_t v[32];
>      ^~~~~~~~~~~
>    make[2]: *** [kernel/bounds.s] Error 1
>    make[2]: Target '__build' not remade because of errors.
>    make[1]: *** [prepare0] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [sub-make] Error 2
>    507 real  2 user  5 sys  1.58% cpu   make prepare
>
> vim +/__uint128_t +75 arch/riscv/include/uapi/asm/ptrace.h
>
>     73
>     74  struct __riscv_v_state {
>   > 75          __uint128_t v[32];
>     76          unsigned long vstart;
>     77          unsigned long vxsat;
>     78          unsigned long vxrm;
>     79          unsigned long vl;
>     80          unsigned long vtype;
>     81  };
>     82
>
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation



--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
