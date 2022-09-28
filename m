Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833B55ED7D6
	for <lists+linux-arch@lfdr.de>; Wed, 28 Sep 2022 10:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbiI1Idn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Sep 2022 04:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiI1IdQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2022 04:33:16 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79049019C;
        Wed, 28 Sep 2022 01:33:04 -0700 (PDT)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 28S8WkWP018062;
        Wed, 28 Sep 2022 17:32:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 28S8WkWP018062
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664353967;
        bh=pdvXxuZ3aBaOu0wH2+xtJ+wALAcqF6k5PeLWYOgeG6I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W6koqCLv8BxVMBNSx2U45HYIx0hWxZIPWutZFq2pzZkR2AnRw8baai/br2kkeAr13
         fNZDC3b/8oWAHMkO9P9lC2IBFSYyFfwgTNNePYMIBw85lBEb2wuzkui4pCXVM5oeSb
         ecuS2C5BZgyX5Y41e7y8yKRBza1/GlvJK2mrI1l4+J3KlyZWztu73Zfl8Clt5hq9Ez
         Q9Ddn1+IxOq4nPhFs5pM3eOQw8MqwV/SZujxNgxx4hOUVZd0B1Yo47VHoY8RJCQOU7
         wsEjocwDymsOAPmDbEpEL4o4hpa0RiuUpCGvLBdZpXe/P0C5lyWQx63rmJSNrdr+iW
         BMtg3LL5dq8SQ==
X-Nifty-SrcIP: [209.85.160.52]
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-131886d366cso4777931fac.10;
        Wed, 28 Sep 2022 01:32:46 -0700 (PDT)
X-Gm-Message-State: ACrzQf3yDq/PWEV8+rfj6Vu4fryi0wuXZFbc8AN7CDTY00Iawbvx7QPk
        0RXWe9mEu9rcl1fAyRO2+PeDz2vDzhebgHLikIA=
X-Google-Smtp-Source: AMsMyM7On7YMV++vQCuZhdVZol9C6aPMbbY63JBvqiVUUIvcRJYiPr2sBeMsxcI4mk+5rkvEoFS5XGO/LUoMbbU46YU=
X-Received: by 2002:a05:6870:c58b:b0:10b:d21d:ad5e with SMTP id
 ba11-20020a056870c58b00b0010bd21dad5emr4576130oab.287.1664353965529; Wed, 28
 Sep 2022 01:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220924181915.3251186-3-masahiroy@kernel.org>
 <202209250350.jJ8vDPnH-lkp@intel.com> <CAK7LNAT9rrSZ2NfTB2G_YZUwE48NbDHPJbM4NbjtwSGWA1YR4Q@mail.gmail.com>
 <CAKwvOdk8s5y_QQ7Gvp9E=LdxBtNnn4zkCzu40sHexxEZwwfO5w@mail.gmail.com>
In-Reply-To: <CAKwvOdk8s5y_QQ7Gvp9E=LdxBtNnn4zkCzu40sHexxEZwwfO5w@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 28 Sep 2022 17:32:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQWrOYZws4U5GpmzyAOWab2wdZi1mgK4wouEqH3KeAQiA@mail.gmail.com>
Message-ID: <CAK7LNAQWrOYZws4U5GpmzyAOWab2wdZi1mgK4wouEqH3KeAQiA@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] kbuild: list sub-directories in ./Kbuild
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     kernel test robot <lkp@intel.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 27, 2022 at 6:06 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sat, Sep 24, 2022 at 5:29 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > On Sun, Sep 25, 2022 at 5:28 AM kernel test robot <lkp@intel.com> wrote:
> > >
> > > Hi Masahiro,
> > >
> > > I love your patch! Perhaps something to improve:
> > >
> > > [auto build test WARNING on masahiroy-kbuild/for-next]
> > > [cannot apply to arm64/for-next/core gerg-m68knommu/for-next geert-m68k/for-next deller-parisc/for-next powerpc/next s390/features tip/x86/core linus/master v6.0-rc6 next-20220923]
> > > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > > And when submitting patch, we suggest to use '--base' as documented in
> > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > >
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Masahiro-Yamada/kbuild-various-cleanups/20220925-022150
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git for-next
> > > config: um-x86_64_defconfig
> > > compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
> > > reproduce (this is a W=1 build):
> > >         # https://github.com/intel-lab-lkp/linux/commit/d721cc5614aaa17b2965db04e9319d4ef5f7eaf7
> > >         git remote add linux-review https://github.com/intel-lab-lkp/linux
> > >         git fetch --no-tags linux-review Masahiro-Yamada/kbuild-various-cleanups/20220925-022150
> > >         git checkout d721cc5614aaa17b2965db04e9319d4ef5f7eaf7
> > >         # save the config file
> > >         mkdir build_dir && cp config build_dir/.config
> > >         make W=1 O=build_dir ARCH=um SUBARCH=x86_64 SHELL=/bin/bash
> > >
> > > If you fix the issue, kindly add following tag where applicable
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All warnings (new ones prefixed by >>):
> > >
> > > >> /usr/bin/ld: warning: ./arch/x86/um/vdso/vdso.o: missing .note.GNU-stack section implies executable stack
> > >    /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
> > >    /usr/bin/ld: warning: .tmp_vmlinux.kallsyms1 has a LOAD segment with RWX permissions
> > >    /usr/bin/ld: warning: .tmp_vmlinux.kallsyms1.o: missing .note.GNU-stack section implies executable stack
> > >    /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
> > >    /usr/bin/ld: warning: .tmp_vmlinux.kallsyms2 has a LOAD segment with RWX permissions
> > >    /usr/bin/ld: warning: .tmp_vmlinux.kallsyms2.o: missing .note.GNU-stack section implies executable stack
> > >    /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
> > >    /usr/bin/ld: warning: vmlinux has a LOAD segment with RWX permissions
>
> See also:
> https://lore.kernel.org/lkml/20220921064855.2841607-1-davidgow@google.com/



Ah, thank you.
My binutils version is 2.38, and
that is why I was not able to reproduce the issue.


With binutils 2.39, now I see the warnings in the mainline kernel.
My patch is not the root cause.



-- 
Best Regards
Masahiro Yamada
