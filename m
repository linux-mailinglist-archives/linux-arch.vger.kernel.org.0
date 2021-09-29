Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE23D41CAD8
	for <lists+linux-arch@lfdr.de>; Wed, 29 Sep 2021 19:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244400AbhI2RGE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Sep 2021 13:06:04 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:40892 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243396AbhI2RGE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Sep 2021 13:06:04 -0400
Received: by mail-pj1-f44.google.com with SMTP id d4-20020a17090ad98400b0019ece228690so4673579pjv.5;
        Wed, 29 Sep 2021 10:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y2x6S7nH9jaik0J6Z6GU8rfIpZ/ztNMY7uEdNTzinB8=;
        b=pdy/2zfn3z3Ciyqpf7Iqk25y8cotet/Jv0J62CWHcXPJtp17tbGRkI/uqK2ICsgIp6
         j8fFdohYFbDTmcPvHLu+/vW2k0ryeHo4Ep9scLFJyXje8yd5k14xR7M/M9g3JtNN6Wiv
         f4URg+6cVs504vsxIdVx32WLF+obbAfWhSTiIV8ORY53TJ8WJQlACrQfhXvOGY3XMWJw
         PhTMyq+Tn7l8otju1CmW7CxJnsEIQgO1PZ2fSEoO1fuQlpKecQOezBMbSGJ2N7VENcjo
         4M8EhfZ/YSwEuuzuM/KCeCsh6Ucb7NvGE5OTOL64zeoSaUy1x/9a4Ri9txnOGdtaC3EG
         wVYQ==
X-Gm-Message-State: AOAM530g4FNH5CMIMyy1bR2iZMvLIaVeh1S9zxibxac+MCMAue4VbVFi
        aIH4N2eWRfedzp0i8KxhjxRRLEpkThen2427d8w=
X-Google-Smtp-Source: ABdhPJxT8uO+Fpw/lmKF8geLN6eHCgcaUhnslCjW0B2FOboNDfjtzqhoq/qeUW03OjhljwftVbkdKlD3NO8xEjkvSLk=
X-Received: by 2002:a17:90b:390:: with SMTP id ga16mr7637268pjb.185.1632935062753;
 Wed, 29 Sep 2021 10:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210919192104.98592-3-mcroce@linux.microsoft.com>
 <202109200526.YYwdkOeI-lkp@intel.com> <CAFnufp2bhWVd-SdSaK3ppFNkoBpJa+-0+kSrWzdxrmYNjyM+Zg@mail.gmail.com>
In-Reply-To: <CAFnufp2bhWVd-SdSaK3ppFNkoBpJa+-0+kSrWzdxrmYNjyM+Zg@mail.gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Wed, 29 Sep 2021 19:04:11 +0200
Message-ID: <CANBLGcyxwKCkFD2Z3S8SiWRWcVgshGxgT1YyVcJrc6DHUV4r2w@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] riscv: optimized memmove
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     kernel test robot <lkp@intel.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 27 Sept 2021 at 12:49, Matteo Croce <mcroce@linux.microsoft.com> wrote:
>
> On Mon, Sep 20, 2021 at 12:06 AM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Matteo,
> >
> > Thank you for the patch! Yet something to improve:
> >
> > [auto build test ERROR on linux/master]
> > [also build test ERROR on linus/master v5.15-rc1 next-20210917]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch]
> >
> > url:    https://github.com/0day-ci/linux/commits/Matteo-Croce/riscv-optimized-mem-functions/20210920-032303
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git bdb575f872175ed0ecf2638369da1cb7a6e86a14
> > config: riscv-randconfig-r004-20210919 (attached as .config)
> > compiler: riscv64-linux-gcc (GCC) 11.2.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://github.com/0day-ci/linux/commit/9a948fd7d78a58890608e9dd0f77e5ff84f36e3e
> >         git remote add linux-review https://github.com/0day-ci/linux
> >         git fetch --no-tags linux-review Matteo-Croce/riscv-optimized-mem-functions/20210920-032303
> >         git checkout 9a948fd7d78a58890608e9dd0f77e5ff84f36e3e
> >         # save the attached .config to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    arch/riscv/lib/string.c: In function '__memmove':
> > >> arch/riscv/lib/string.c:89:7: error: inlining failed in call to 'always_inline' 'memcpy': function body can be overwritten at link time
> >       89 | void *memcpy(void *dest, const void *src, size_t count) __weak __alias(__memcpy);
> >          |       ^~~~~~
> >    arch/riscv/lib/string.c:99:24: note: called from here
> >       99 |                 return memcpy(dest, src, count);
> >          |                        ^~~~~~~~~~~~~~~~~~~~~~~~
> >
> >
> > vim +89 arch/riscv/lib/string.c
> >
> > 86c5866e9b7fdd Matteo Croce 2021-09-19  88
> > 86c5866e9b7fdd Matteo Croce 2021-09-19 @89  void *memcpy(void *dest, const void *src, size_t count) __weak __alias(__memcpy);
> > 86c5866e9b7fdd Matteo Croce 2021-09-19  90  EXPORT_SYMBOL(memcpy);
> > 9a948fd7d78a58 Matteo Croce 2021-09-19  91
> >
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
> How can we fix this? Maybe calling __memcpy() instead?

Yes, that fixes building with CONFIG_FORTIFY_SOURCE=y for me. Kasan
already wraps memmove itself, so it should be fine to call __memcpy
directly.

/Emil
