Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E10D4F1416
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 13:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbiDDLys (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 07:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbiDDLyq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 07:54:46 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322053D4AD;
        Mon,  4 Apr 2022 04:52:50 -0700 (PDT)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 234BqaZG031207;
        Mon, 4 Apr 2022 20:52:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 234BqaZG031207
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649073157;
        bh=o0CEGSP1e2YYpsGI9az2WVUOPk6c9w9P3gfAdmyO7Uc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E8MfobFZVK8ZZQxYLzbKJ6zp1q6Sz3Uw800RrK88o11Qk16QEHemyg9CKKKiQ7uiT
         1xHRg/FRY6+WKeEHsJ92EGpEpOKsnckht/eN4Sd7ErsOcsEukYbtIBE/lsjz1YXatz
         HcsUkX2qUeTRSLUVFUyGEjeWIt1q8aTP4hWd0neGzjB2EqNEXYckgH1qDxCobLninL
         ma7XvS47Hejkma4NhSSHb24Gg3mz3+SntT7tic0co7uxiaI5ZRJMqZVpAD9yErVv7r
         xaFewky1AfsFFiOFFhK+rJf5Bna5NDr5tqxgtIOOUr+MOrsS+Ud/xcZpGR5JFWwAYl
         rvWzFtp+CBsBQ==
X-Nifty-SrcIP: [209.85.215.171]
Received: by mail-pg1-f171.google.com with SMTP id l129so8140745pga.3;
        Mon, 04 Apr 2022 04:52:37 -0700 (PDT)
X-Gm-Message-State: AOAM5317X9XCWcIw/mmeOS32enlZffnoHpuGGYamClejjyravdqxaRLA
        WBTI7oEFNkjYvyBub4kST8u4pm43UJ/4Q2rdhaY=
X-Google-Smtp-Source: ABdhPJxpAflZ1zo/RzYQsDKbvL0aW1WHiC5n5tXhyZV4CBgRWCQ+qf1g/lRvJc/P5xo9O9x3afv09Iky27mpQ0iF8RA=
X-Received: by 2002:a05:6a00:a02:b0:4fd:f9dd:5494 with SMTP id
 p2-20020a056a000a0200b004fdf9dd5494mr6135238pfh.68.1649073156402; Mon, 04 Apr
 2022 04:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220404061948.2111820-8-masahiroy@kernel.org> <202204041919.bIUKxOch-lkp@intel.com>
In-Reply-To: <202204041919.bIUKxOch-lkp@intel.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 4 Apr 2022 20:51:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNASGcNZx9Ec5jxn-Dy9YA1oVrHvnHs5Yp9r1DWbEZ=MVQA@mail.gmail.com>
Message-ID: <CAK7LNASGcNZx9Ec5jxn-Dy9YA1oVrHvnHs5Yp9r1DWbEZ=MVQA@mail.gmail.com>
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

On Mon, Apr 4, 2022 at 8:31 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Masahiro,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on linus/master]
> [also build test WARNING on linux/master v5.18-rc1 next-20220404]
> [cannot apply to soc/for-next drm/drm-next powerpc/next uclinux-h8/h8300-next s390/features arnd-asm-generic/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Masahiro-Yamada/UAPI-make-more-exported-headers-self-contained-and-put-them-into-test-coverage/20220404-142226
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git be2d3ecedd9911fbfd7e55cc9ceac5f8b79ae4cf
> config: i386-randconfig-a006 (https://download.01.org/0day-ci/archive/20220404/202204041919.bIUKxOch-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/e8154d995f34b79843e473d85645fb543d554e7f
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Masahiro-Yamada/UAPI-make-more-exported-headers-self-contained-and-put-them-into-test-coverage/20220404-142226
>         git checkout e8154d995f34b79843e473d85645fb543d554e7f
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash sound/soc/fsl/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> sound/soc/fsl/imx-audmux.c:148:40: warning: format specifies type 'unsigned long' but the argument has type 'uintptr_t' (aka 'unsigned int') [-Wformat]
>                    snprintf(buf, sizeof(buf), "ssi%lu", i);
>                                                   ~~~   ^
>                                                   %u
>    1 warning generated.
>

Hmm, we highly relied on the fact that the pointer size and
the 'long' size are the same.
(for both 32-bit and 64-bit).

So,  using %lu specifier for printing 'uintptr_t' seems correct.

  typedef   unsigned long    __kernel_uintptr_t;

is OK from the kernel space perspective,
but I do not know the impact to the userspace.

Arnd, any thoughts?






> vim +148 sound/soc/fsl/imx-audmux.c
>
> 7b4e08a77f0cbf arch/arm/plat-mxc/audmux-v2.c Mark Brown         2010-01-11  139
> b8909783a22b4f sound/soc/fsl/imx-audmux.c    Lars-Peter Clausen 2014-04-24  140  static void audmux_debugfs_init(void)
> 7b4e08a77f0cbf arch/arm/plat-mxc/audmux-v2.c Mark Brown         2010-01-11  141  {
> e5f89768e9bc1f sound/soc/fsl/imx-audmux.c    Mark Brown         2014-08-01  142         uintptr_t i;
> 7b4e08a77f0cbf arch/arm/plat-mxc/audmux-v2.c Mark Brown         2010-01-11  143         char buf[20];
> 7b4e08a77f0cbf arch/arm/plat-mxc/audmux-v2.c Mark Brown         2010-01-11  144
> 7b4e08a77f0cbf arch/arm/plat-mxc/audmux-v2.c Mark Brown         2010-01-11  145         audmux_debugfs_root = debugfs_create_dir("audmux", NULL);
> 7b4e08a77f0cbf arch/arm/plat-mxc/audmux-v2.c Mark Brown         2010-01-11  146
> 409b78cc17a4a3 sound/soc/fsl/imx-audmux.c    Torben Hohn        2012-07-18  147         for (i = 0; i < MX31_AUDMUX_PORT7_SSI_PINS_7 + 1; i++) {
> e5f89768e9bc1f sound/soc/fsl/imx-audmux.c    Mark Brown         2014-08-01 @148                 snprintf(buf, sizeof(buf), "ssi%lu", i);
> 227ab8baa15bdd sound/soc/fsl/imx-audmux.c    Greg Kroah-Hartman 2019-06-14  149                 debugfs_create_file(buf, 0444, audmux_debugfs_root,
> 227ab8baa15bdd sound/soc/fsl/imx-audmux.c    Greg Kroah-Hartman 2019-06-14  150                                     (void *)i, &audmux_debugfs_fops);
> 7b4e08a77f0cbf arch/arm/plat-mxc/audmux-v2.c Mark Brown         2010-01-11  151         }
> 7b4e08a77f0cbf arch/arm/plat-mxc/audmux-v2.c Mark Brown         2010-01-11  152  }
> 3bc34a6143359d arch/arm/plat-mxc/audmux.c    Richard Zhao       2012-03-05  153
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp



-- 
Best Regards
Masahiro Yamada
