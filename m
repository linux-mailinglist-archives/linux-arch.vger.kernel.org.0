Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81CB4F1448
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 14:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbiDDMFi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 08:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235825AbiDDMFh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 08:05:37 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2915B13D00;
        Mon,  4 Apr 2022 05:03:36 -0700 (PDT)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 234C35in013154;
        Mon, 4 Apr 2022 21:03:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 234C35in013154
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649073785;
        bh=cYOB7J11OLRn7aFvVMIumWfoXHkQ4OzFX0PbA3VO7go=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KHXz8Cs68h1XcpEDzsubLC3YYf27mAVsOCZYwDLqQKUqbqVIkkeRLNFyKpIkK6gOU
         NrjzFNcYq4M2r/QzGueMLgkuBZmJySsBxuHxYA0yn+PsjZ/49N13iq7bGMvy/1z5Ki
         dvhlt2057VsfnRUwnOE1c8Eo6smXSfUTallcCHfmg+GLCi2IUR7uNiu+vaJd8tJOJC
         TAGjTxrw/CFSIZgmCLeOzuXgq8jRUcIuH2UI1fWWv5K+ghdEFnT1ag2adPpK2lPbSD
         cXXehBJ/MRrj8RF/b04SSr5Ct2DXN3FYRyNnXIjzK1pm8sPz3idgFC81X0YIH/bc6F
         1HXH0+9LpRXzw==
X-Nifty-SrcIP: [209.85.215.177]
Received: by mail-pg1-f177.google.com with SMTP id z128so8162117pgz.2;
        Mon, 04 Apr 2022 05:03:05 -0700 (PDT)
X-Gm-Message-State: AOAM5304q91tzo3AzL3yf5vQ15Lek2ERPuebqH4pFZTpNwfUXovsGxGl
        /inoifyd9uWTuztE8CrlsjFSFYQaOcgfRXDhyDg=
X-Google-Smtp-Source: ABdhPJzad6AD6rgmT/Ppidg7yhei7YljM/K+Fj4Jn9kf94XdsX7RbzCXT6OLn4kbcowqqesakcNu/lMf6qBuM2b3sqA=
X-Received: by 2002:a05:6a02:182:b0:374:5a57:cbf9 with SMTP id
 bj2-20020a056a02018200b003745a57cbf9mr25171181pgb.616.1649073784656; Mon, 04
 Apr 2022 05:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220404061948.2111820-8-masahiroy@kernel.org>
 <202204041919.bIUKxOch-lkp@intel.com> <CAK7LNASGcNZx9Ec5jxn-Dy9YA1oVrHvnHs5Yp9r1DWbEZ=MVQA@mail.gmail.com>
In-Reply-To: <CAK7LNASGcNZx9Ec5jxn-Dy9YA1oVrHvnHs5Yp9r1DWbEZ=MVQA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 4 Apr 2022 21:02:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNARLF0+zb_czaK2vp8fuCn0297ijvKLpuFh7fXstrh7Qxw@mail.gmail.com>
Message-ID: <CAK7LNARLF0+zb_czaK2vp8fuCn0297ijvKLpuFh7fXstrh7Qxw@mail.gmail.com>
Subject: Re: [PATCH 7/8] posix_types.h: add __kernel_uintptr_t to UAPI posix_types.h
To:     kernel test robot <lkp@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 4, 2022 at 8:51 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Mon, Apr 4, 2022 at 8:31 PM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Masahiro,
> >
> > I love your patch! Perhaps something to improve:
> >
> > [auto build test WARNING on linus/master]
> > [also build test WARNING on linux/master v5.18-rc1 next-20220404]
> > [cannot apply to soc/for-next drm/drm-next powerpc/next uclinux-h8/h8300-next s390/features arnd-asm-generic/master]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Masahiro-Yamada/UAPI-make-more-exported-headers-self-contained-and-put-them-into-test-coverage/20220404-142226
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git be2d3ecedd9911fbfd7e55cc9ceac5f8b79ae4cf
> > config: i386-randconfig-a006 (https://download.01.org/0day-ci/archive/20220404/202204041919.bIUKxOch-lkp@intel.com/config)
> > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://github.com/intel-lab-lkp/linux/commit/e8154d995f34b79843e473d85645fb543d554e7f
> >         git remote add linux-review https://github.com/intel-lab-lkp/linux
> >         git fetch --no-tags linux-review Masahiro-Yamada/UAPI-make-more-exported-headers-self-contained-and-put-them-into-test-coverage/20220404-142226
> >         git checkout e8154d995f34b79843e473d85645fb543d554e7f
> >         # save the config file to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash sound/soc/fsl/
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> > >> sound/soc/fsl/imx-audmux.c:148:40: warning: format specifies type 'unsigned long' but the argument has type 'uintptr_t' (aka 'unsigned int') [-Wformat]
> >                    snprintf(buf, sizeof(buf), "ssi%lu", i);
> >                                                   ~~~   ^
> >                                                   %u
> >    1 warning generated.
> >
>
> Hmm, we highly relied on the fact that the pointer size and
> the 'long' size are the same.
> (for both 32-bit and 64-bit).
>
> So,  using %lu specifier for printing 'uintptr_t' seems correct.
>
>   typedef   unsigned long    __kernel_uintptr_t;
>
> is OK from the kernel space perspective,
> but I do not know the impact to the userspace.
>
> Arnd, any thoughts?


I think we should do the same as
 int-ll64.h vs  int-l64.h


We completely switched to int-ll64.h for the kernel space,
but some architectures export int-l64.h

For example,

  arch/mips/include/uapi/asm/types.h





>
>
>
>
>
>
> > vim +148 sound/soc/fsl/imx-audmux.c
> >
> > 7b4e08a77f0cbf arch/arm/plat-mxc/audmux-v2.c Mark Brown         2010-01-11  139
> > b8909783a22b4f sound/soc/fsl/imx-audmux.c    Lars-Peter Clausen 2014-04-24  140  static void audmux_debugfs_init(void)
> > 7b4e08a77f0cbf arch/arm/plat-mxc/audmux-v2.c Mark Brown         2010-01-11  141  {
> > e5f89768e9bc1f sound/soc/fsl/imx-audmux.c    Mark Brown         2014-08-01  142         uintptr_t i;
> > 7b4e08a77f0cbf arch/arm/plat-mxc/audmux-v2.c Mark Brown         2010-01-11  143         char buf[20];
> > 7b4e08a77f0cbf arch/arm/plat-mxc/audmux-v2.c Mark Brown         2010-01-11  144
> > 7b4e08a77f0cbf arch/arm/plat-mxc/audmux-v2.c Mark Brown         2010-01-11  145         audmux_debugfs_root = debugfs_create_dir("audmux", NULL);
> > 7b4e08a77f0cbf arch/arm/plat-mxc/audmux-v2.c Mark Brown         2010-01-11  146
> > 409b78cc17a4a3 sound/soc/fsl/imx-audmux.c    Torben Hohn        2012-07-18  147         for (i = 0; i < MX31_AUDMUX_PORT7_SSI_PINS_7 + 1; i++) {
> > e5f89768e9bc1f sound/soc/fsl/imx-audmux.c    Mark Brown         2014-08-01 @148                 snprintf(buf, sizeof(buf), "ssi%lu", i);
> > 227ab8baa15bdd sound/soc/fsl/imx-audmux.c    Greg Kroah-Hartman 2019-06-14  149                 debugfs_create_file(buf, 0444, audmux_debugfs_root,
> > 227ab8baa15bdd sound/soc/fsl/imx-audmux.c    Greg Kroah-Hartman 2019-06-14  150                                     (void *)i, &audmux_debugfs_fops);
> > 7b4e08a77f0cbf arch/arm/plat-mxc/audmux-v2.c Mark Brown         2010-01-11  151         }
> > 7b4e08a77f0cbf arch/arm/plat-mxc/audmux-v2.c Mark Brown         2010-01-11  152  }
> > 3bc34a6143359d arch/arm/plat-mxc/audmux.c    Richard Zhao       2012-03-05  153
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://01.org/lkp
>
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Best Regards
Masahiro Yamada
