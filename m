Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9AB419283
	for <lists+linux-arch@lfdr.de>; Mon, 27 Sep 2021 12:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbhI0KvQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Sep 2021 06:51:16 -0400
Received: from linux.microsoft.com ([13.77.154.182]:40456 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233917AbhI0KvO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Sep 2021 06:51:14 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by linux.microsoft.com (Postfix) with ESMTPSA id C91B920B4846;
        Mon, 27 Sep 2021 03:49:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C91B920B4846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1632739772;
        bh=VZvw/wIlq/UcIn6rQL0WGXaz3mDbsqOb4IhjmRl4FHY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Pw7JHDXW5hAtNU1o+qCli2Bl5b7+zDkuD+JHUDwagxb7XcKsBrCOm4nWD7s3RqNNx
         T5R3SD7qZVctJCrTpSZ9BBTH0fIRnR1iZdfUEmgC6yDdg6NqqhIHApsgcHo9kTS4Ns
         BJ0NKbmav13sVT5kQEe5hvU0jwYc7kJXpxCT1wjk=
Received: by mail-pj1-f47.google.com with SMTP id h12so1799595pjj.1;
        Mon, 27 Sep 2021 03:49:32 -0700 (PDT)
X-Gm-Message-State: AOAM533x5OWQGq63CW5Ay3yS8HXhRe79lJcWSPisZMXOBwIqr2bfO/nU
        9H6FNB3RiOZopd6b6RvZ9zHIC0eJD0NcB5/jhuA=
X-Google-Smtp-Source: ABdhPJwWrdUZbG6u6ik5z6zlzTdgcwT/NZeHyQQPSrmqvewNPKVfDBt9KV1cs+l0aSm29Sx+YJjL60kJr8YCPUPBr04=
X-Received: by 2002:a17:902:7e8a:b0:13d:95e2:d9c2 with SMTP id
 z10-20020a1709027e8a00b0013d95e2d9c2mr21933306pla.8.1632739772259; Mon, 27
 Sep 2021 03:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210919192104.98592-3-mcroce@linux.microsoft.com> <202109200526.YYwdkOeI-lkp@intel.com>
In-Reply-To: <202109200526.YYwdkOeI-lkp@intel.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Mon, 27 Sep 2021 12:48:56 +0200
X-Gmail-Original-Message-ID: <CAFnufp2bhWVd-SdSaK3ppFNkoBpJa+-0+kSrWzdxrmYNjyM+Zg@mail.gmail.com>
Message-ID: <CAFnufp2bhWVd-SdSaK3ppFNkoBpJa+-0+kSrWzdxrmYNjyM+Zg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] riscv: optimized memmove
To:     kernel test robot <lkp@intel.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 20, 2021 at 12:06 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Matteo,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on linux/master]
> [also build test ERROR on linus/master v5.15-rc1 next-20210917]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Matteo-Croce/riscv-optimized-mem-functions/20210920-032303
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git bdb575f872175ed0ecf2638369da1cb7a6e86a14
> config: riscv-randconfig-r004-20210919 (attached as .config)
> compiler: riscv64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/9a948fd7d78a58890608e9dd0f77e5ff84f36e3e
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Matteo-Croce/riscv-optimized-mem-functions/20210920-032303
>         git checkout 9a948fd7d78a58890608e9dd0f77e5ff84f36e3e
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    arch/riscv/lib/string.c: In function '__memmove':
> >> arch/riscv/lib/string.c:89:7: error: inlining failed in call to 'always_inline' 'memcpy': function body can be overwritten at link time
>       89 | void *memcpy(void *dest, const void *src, size_t count) __weak __alias(__memcpy);
>          |       ^~~~~~
>    arch/riscv/lib/string.c:99:24: note: called from here
>       99 |                 return memcpy(dest, src, count);
>          |                        ^~~~~~~~~~~~~~~~~~~~~~~~
>
>
> vim +89 arch/riscv/lib/string.c
>
> 86c5866e9b7fdd Matteo Croce 2021-09-19  88
> 86c5866e9b7fdd Matteo Croce 2021-09-19 @89  void *memcpy(void *dest, const void *src, size_t count) __weak __alias(__memcpy);
> 86c5866e9b7fdd Matteo Croce 2021-09-19  90  EXPORT_SYMBOL(memcpy);
> 9a948fd7d78a58 Matteo Croce 2021-09-19  91
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

How can we fix this? Maybe calling __memcpy() instead?

-- 
per aspera ad upstream
