Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FF35E9083
	for <lists+linux-arch@lfdr.de>; Sun, 25 Sep 2022 02:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiIYA3F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 24 Sep 2022 20:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIYA3F (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 24 Sep 2022 20:29:05 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB67422C8;
        Sat, 24 Sep 2022 17:29:02 -0700 (PDT)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 28P0Somb012364;
        Sun, 25 Sep 2022 09:28:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 28P0Somb012364
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664065730;
        bh=teoN08dMbj4BGI5ceTr9CEGn8HSHy4O/qsIjWD9XTek=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n9zmAOs++29wOrSxNKKdlO36rJ2ZEBx92sYjYI2SgBk1glbkJStjZ0yWI4v0Xb39j
         DM33c/vQv4h9eZJTxCdi72A/9hgkSDw/DTXSIMRtIaPBTH88o2vNWVLzgQkSKU4rs9
         TUHfCsmX6A6bJdrR/Z4QPy/UiBJlpuEfZjLPph+zT48qSXSIbufgQ8T0/3stxwmCH0
         D/V1D2SppM3K9sWPCWlmbVFJaXcZVBFoxIEo+DxPjr/Xm40ZnLDpVzsiXdTtdS5xKZ
         5U+pW11GmX5Ls+xoJ5tFGgyxCngBSLI9UDmTtwjIXg8Scfp9qGOo2OGdVqv/K9D+O5
         rStagbyjFqAmg==
X-Nifty-SrcIP: [209.85.160.52]
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-12803ac8113so5034595fac.8;
        Sat, 24 Sep 2022 17:28:50 -0700 (PDT)
X-Gm-Message-State: ACrzQf1enK0x6n9Fti6M8XnVz2ap6Qqd0HUBAO36xi8JBCdG//wRgsXG
        WYLVy7s2mkyFmT+14592Vz0pjYnwenp5Cn0HAEI=
X-Google-Smtp-Source: AMsMyM6j+dKYrDa6gn4KX0Ziz11lqVn60VOIPhxoWU03QtvNZ/YXLztstczWdHFgRxf9wyk1Rpq4B+CoaiXp3MY2WH0=
X-Received: by 2002:a05:6870:3103:b0:12d:5b7b:e6f2 with SMTP id
 v3-20020a056870310300b0012d5b7be6f2mr14215419oaa.194.1664065729340; Sat, 24
 Sep 2022 17:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220924181915.3251186-3-masahiroy@kernel.org> <202209250350.jJ8vDPnH-lkp@intel.com>
In-Reply-To: <202209250350.jJ8vDPnH-lkp@intel.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 25 Sep 2022 09:28:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT9rrSZ2NfTB2G_YZUwE48NbDHPJbM4NbjtwSGWA1YR4Q@mail.gmail.com>
Message-ID: <CAK7LNAT9rrSZ2NfTB2G_YZUwE48NbDHPJbM4NbjtwSGWA1YR4Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] kbuild: list sub-directories in ./Kbuild
To:     kernel test robot <lkp@intel.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 25, 2022 at 5:28 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Masahiro,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on masahiroy-kbuild/for-next]
> [cannot apply to arm64/for-next/core gerg-m68knommu/for-next geert-m68k/for-next deller-parisc/for-next powerpc/next s390/features tip/x86/core linus/master v6.0-rc6 next-20220923]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Masahiro-Yamada/kbuild-various-cleanups/20220925-022150
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git for-next
> config: um-x86_64_defconfig
> compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/intel-lab-lkp/linux/commit/d721cc5614aaa17b2965db04e9319d4ef5f7eaf7
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Masahiro-Yamada/kbuild-various-cleanups/20220925-022150
>         git checkout d721cc5614aaa17b2965db04e9319d4ef5f7eaf7
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=um SUBARCH=x86_64 SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> /usr/bin/ld: warning: ./arch/x86/um/vdso/vdso.o: missing .note.GNU-stack section implies executable stack
>    /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
>    /usr/bin/ld: warning: .tmp_vmlinux.kallsyms1 has a LOAD segment with RWX permissions
>    /usr/bin/ld: warning: .tmp_vmlinux.kallsyms1.o: missing .note.GNU-stack section implies executable stack
>    /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
>    /usr/bin/ld: warning: .tmp_vmlinux.kallsyms2 has a LOAD segment with RWX permissions
>    /usr/bin/ld: warning: .tmp_vmlinux.kallsyms2.o: missing .note.GNU-stack section implies executable stack
>    /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
>    /usr/bin/ld: warning: vmlinux has a LOAD segment with RWX permissions
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp








My compiler is slightly different
(gcc (Ubuntu 11.2.0-19ubuntu1) 11.2.0), but
I cannot reproduce it.



Perhaps, 0day thought this is a new warning
due to a slightly different path?


[before]
warning: arch/x86/um/vdso/vdso.o

[after]
warning: ./arch/x86/um/vdso/vdso.o




-- 
Best Regards
Masahiro Yamada
