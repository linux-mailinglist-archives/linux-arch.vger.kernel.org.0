Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A92325E00
	for <lists+linux-arch@lfdr.de>; Fri, 26 Feb 2021 08:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhBZHGM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Feb 2021 02:06:12 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:48295 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhBZHGA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Feb 2021 02:06:00 -0500
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 11Q74khb013013;
        Fri, 26 Feb 2021 16:04:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 11Q74khb013013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614323087;
        bh=x/mGpk1ym04OHsIfCCiDKSuFig6JjVl/bLcEZ8JxD60=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Xkgdf5MvmR6hgS+8QPHNJl+H8QSjIvfT9Mwu8ClGIaUhJxVbfCbwamjymkXJzsgyS
         LUKo0osm44bGDjIH/Wq1sLz8Pd1Prj4Zr3ZhC7Z5PSzFDlo03hzd0ccy1ziXl25HV2
         akQXdin3Os4gvIe4DoUcbNBM2J8i9z17jmi6/JbDbBfZQezVIm8iDDO+4siycNH6x4
         iAL34HjVQgApq6fL9n57LWbNV0WuiA+MvYtJ36uxgWddwzZWVB2zunMfXXZw1Tupyz
         B4IG1b54gWbGvmOuj5zPPs63ao8pnQk4Csg0FXlnjsz3jo2xS/BKbIvq3gyC0DcRuE
         8F++jiJHVRCiw==
X-Nifty-SrcIP: [209.85.216.44]
Received: by mail-pj1-f44.google.com with SMTP id t9so5449278pjl.5;
        Thu, 25 Feb 2021 23:04:47 -0800 (PST)
X-Gm-Message-State: AOAM533qPRbNTzRT+SnLdsbsr4mNkOrfhB7TajAuSn2mbAybNYb35MNg
        KwDRPDy+w2YAwVTJd4cxU5BVGPc4umMLvxucXBA=
X-Google-Smtp-Source: ABdhPJzp5pGZsGqBQHf0ap1RmLLZMw8yZd4cNsh1RkqQA4Uhk+8hUUC6gMR/ojA1XI0Cpoi+gVXJzr00cMyMWlIC1lM=
X-Received: by 2002:a17:902:e891:b029:e4:20d3:3d5c with SMTP id
 w17-20020a170902e891b02900e420d33d5cmr2002613plg.71.1614323086227; Thu, 25
 Feb 2021 23:04:46 -0800 (PST)
MIME-Version: 1.0
References: <20210225160247.2959903-5-masahiroy@kernel.org>
 <202102260245.2UUwdoDK-lkp@intel.com> <CAK7LNAQ4gpD=wuASq42r+MznVeFo8wz0m=YMzmBLL67fdtOFpw@mail.gmail.com>
 <CABCJKucvBBgi8zXe12+rCkv0p0ozpBGr5=9Q139k8EErMYUBwQ@mail.gmail.com>
In-Reply-To: <CABCJKucvBBgi8zXe12+rCkv0p0ozpBGr5=9Q139k8EErMYUBwQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 26 Feb 2021 16:04:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT5hqdkkbuS3y=VYF4utTUMsvowOFzsgXimW6ZKBcYs5A@mail.gmail.com>
Message-ID: <CAK7LNAT5hqdkkbuS3y=VYF4utTUMsvowOFzsgXimW6ZKBcYs5A@mail.gmail.com>
Subject: Re: [PATCH 4/4] kbuild: re-implement CONFIG_TRIM_UNUSED_KSYMS to make
 it work in one-pass
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     kernel test robot <lkp@intel.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        kbuild-all@lists.01.org, Christoph Hellwig <hch@lst.de>,
        Jessica Yu <jeyu@kernel.org>, Nicolas Pitre <nico@fluxnic.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 26, 2021 at 6:20 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> Hi Masahiro,
>
> On Thu, Feb 25, 2021 at 12:07 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > On Fri, Feb 26, 2021 at 3:47 AM kernel test robot <lkp@intel.com> wrote:
> > >
> > > Hi Masahiro,
> > >
> > > I love your patch! Perhaps something to improve:
> > >
> > > [auto build test WARNING on linus/master]
> > > [also build test WARNING on next-20210225]
> > > [cannot apply to kbuild/for-next asm-generic/master arm64/for-next/core m68k/for-next openrisc/for-next hp-parisc/for-next arc/for-next uclinux-h8/h8300-next nios2/for-linus v5.11]
> > > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > > And when submitting patch, we suggest to use '--base' as documented in
> > > https://git-scm.com/docs/git-format-patch]
> > >
> > > url:    https://github.com/0day-ci/linux/commits/Masahiro-Yamada/kbuild-build-speed-improvment-of-CONFIG_TRIM_UNUSED_KSYMS/20210226-000929
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 29c395c77a9a514c5857c45ceae2665e9bd99ac7
> > > config: powerpc-mpc8313_rdb_defconfig (attached as .config)
> > > compiler: powerpc-linux-gcc (GCC) 9.3.0
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # https://github.com/0day-ci/linux/commit/014940331790a8cd9bee92c7201494ec3217201e
> > >         git remote add linux-review https://github.com/0day-ci/linux
> > >         git fetch --no-tags linux-review Masahiro-Yamada/kbuild-build-speed-improvment-of-CONFIG_TRIM_UNUSED_KSYMS/20210226-000929
> > >         git checkout 014940331790a8cd9bee92c7201494ec3217201e
> > >         # save the attached .config to linux build tree
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All warnings (new ones prefixed by >>):
> > >
> > > >> scripts/module.lds.S:7:5: warning: "CONFIG_TRIM_UNUSED_KSYMS" is not defined, evaluates to 0 [-Wundef]
> >
> > Thanks. This should be #ifdef, of course.
>
> I applied this series and changed these from #if to #ifdef, but I
> still see the following build error with TRIM_UNUSED_KSYMS +
> OF_UNITTEST:
>
> In file included from drivers/of/unittest-data/testcases.dtb.S:1:
> ../include/asm-generic/vmlinux.lds.h:54:10: fatal error:
> 'generated/keep-ksyms.h' file not found
> #include <generated/keep-ksyms.h>
>          ^~~~~~~~~~~~~~~~~~~~~~~~
> 1 error generated.
>
> This is with x86_64_defconfig and scripts/config -e OF -e OF_UNITTEST
> -e TRIM_UNUSED_KSYMS.
>
> Sami

Thanks. I will fix it.
I will come back with v2
probably after v5.12-rc1 is tagged.





-- 
Best Regards
Masahiro Yamada
