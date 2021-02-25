Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31562325749
	for <lists+linux-arch@lfdr.de>; Thu, 25 Feb 2021 21:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbhBYUIQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Feb 2021 15:08:16 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:29223 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbhBYUIP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Feb 2021 15:08:15 -0500
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 11PK7K7L022783;
        Fri, 26 Feb 2021 05:07:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 11PK7K7L022783
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614283640;
        bh=3xVOangCnFZp2qQC/3neIi3ttH7WXnHRc82C0C7KERI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nKvJwgyzHqw1X744v4wOdnskQVcWSaxr+0O9GxE4aRwuaBQxJdVwtzlbCJhTx+8zR
         TR9+fF8IQPKz8LokLWq2n9DfPfGQ74PL8SShuDmR3F+Pxmp4sEgrnCsoOpJ44DNUOq
         UuQZfXSOk44ikQfceMVW2yZ+KFDgV5HU6Zws52x9of5OHgDBM5HVXUdSY/flZIuXFN
         hHmh4oPQDc+/Q4k+o1I+j9WMAvAlY1tjLKQMLYEUMPF2wuyDLRioQCf+Ca4sAmSWQ4
         o8cFOIdpGGgxCOXkuIc4NRaBGAMudC9Z9s2mG0uLJvdH0An14hapXXh1JzmxdySHIx
         9eboAAXHYag1Q==
X-Nifty-SrcIP: [209.85.216.48]
Received: by mail-pj1-f48.google.com with SMTP id b15so4197032pjb.0;
        Thu, 25 Feb 2021 12:07:20 -0800 (PST)
X-Gm-Message-State: AOAM53363KOAik83JsHYyKps1mlKtO6FZ7TTBn1mkHoWhX7vEqWGZIBZ
        oyPTrsdaJ4KL2WsoTgcRDb/CtfNclXYD57/lgGc=
X-Google-Smtp-Source: ABdhPJytSoow7skb1MRVCvHykNbEQNNnPYX5Ze/IuXX54Q0KLnGnXDwT+KH5SkD+nQXvJ46/ZknHf7m7w9VPFRpTCfo=
X-Received: by 2002:a17:90b:315:: with SMTP id ay21mr88171pjb.198.1614283639851;
 Thu, 25 Feb 2021 12:07:19 -0800 (PST)
MIME-Version: 1.0
References: <20210225160247.2959903-5-masahiroy@kernel.org> <202102260245.2UUwdoDK-lkp@intel.com>
In-Reply-To: <202102260245.2UUwdoDK-lkp@intel.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 26 Feb 2021 05:06:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ4gpD=wuASq42r+MznVeFo8wz0m=YMzmBLL67fdtOFpw@mail.gmail.com>
Message-ID: <CAK7LNAQ4gpD=wuASq42r+MznVeFo8wz0m=YMzmBLL67fdtOFpw@mail.gmail.com>
Subject: Re: [PATCH 4/4] kbuild: re-implement CONFIG_TRIM_UNUSED_KSYMS to make
 it work in one-pass
To:     kernel test robot <lkp@intel.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        kbuild-all@lists.01.org, Christoph Hellwig <hch@lst.de>,
        Jessica Yu <jeyu@kernel.org>, Nicolas Pitre <nico@fluxnic.net>,
        Sami Tolvanen <samitolvanen@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 26, 2021 at 3:47 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Masahiro,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on linus/master]
> [also build test WARNING on next-20210225]
> [cannot apply to kbuild/for-next asm-generic/master arm64/for-next/core m68k/for-next openrisc/for-next hp-parisc/for-next arc/for-next uclinux-h8/h8300-next nios2/for-linus v5.11]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Masahiro-Yamada/kbuild-build-speed-improvment-of-CONFIG_TRIM_UNUSED_KSYMS/20210226-000929
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 29c395c77a9a514c5857c45ceae2665e9bd99ac7
> config: powerpc-mpc8313_rdb_defconfig (attached as .config)
> compiler: powerpc-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/014940331790a8cd9bee92c7201494ec3217201e
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Masahiro-Yamada/kbuild-build-speed-improvment-of-CONFIG_TRIM_UNUSED_KSYMS/20210226-000929
>         git checkout 014940331790a8cd9bee92c7201494ec3217201e
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> scripts/module.lds.S:7:5: warning: "CONFIG_TRIM_UNUSED_KSYMS" is not defined, evaluates to 0 [-Wundef]

Thanks. This should be #ifdef, of course.



>        7 | #if CONFIG_TRIM_UNUSED_KSYMS
>          |     ^~~~~~~~~~~~~~~~~~~~~~~~
>
>
> vim +/CONFIG_TRIM_UNUSED_KSYMS +7 scripts/module.lds.S
>
>    > 7  #if CONFIG_TRIM_UNUSED_KSYMS
>      8  #include <generated/keep-ksyms.h>
>      9
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
Best Regards
Masahiro Yamada
