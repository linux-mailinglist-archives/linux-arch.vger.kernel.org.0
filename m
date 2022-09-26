Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F346B5EB2CF
	for <lists+linux-arch@lfdr.de>; Mon, 26 Sep 2022 23:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiIZVGz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Sep 2022 17:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiIZVGv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Sep 2022 17:06:51 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9DF72B7D
        for <linux-arch@vger.kernel.org>; Mon, 26 Sep 2022 14:06:49 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id l65so7900286pfl.8
        for <linux-arch@vger.kernel.org>; Mon, 26 Sep 2022 14:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=f5W2CsBm3S6047cP35+5+U3RG7E+g2lqROx7Y2z+RnU=;
        b=QyIhzfJH/p72mmYsDPGf5YMDPNfawpJF3huuyB3vtu+3GThn997ccN3tfTd69vbZG7
         7opuSMoPy9EcR+YCvXL8xjR9h0JoQopCktFWaP/kxgGB6JWQb7qHuDbDtJzfI58Vng8U
         YBDLEDm61bbMsMMKqVYKogyLSM/Fsj9G6oow7YlShifRlauVMY41ibCbzD1obJjcxag4
         SJc/vFRAsgywRNMBm7vHRPKixfiA9wafe1946GAfpqcYHAtOtsyvrAhm9qLZWqjXM3u6
         qlP9zk67EpPmCM4U4gx1FdwEuTlv0WxOCQ5n33C6mdeWU4Kh5a4Xb7Sm21ju0M38NyfN
         Nylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=f5W2CsBm3S6047cP35+5+U3RG7E+g2lqROx7Y2z+RnU=;
        b=cYPEaEKDM9M6Nz0m3BP4JeR4sUvbnC7+fErItNCjCOAaiEj+VMEF39Tp+TmPFBw1aC
         DQ0t3sWbh3Iy/CbYVTcgRbHgx+39EFauw3RrK0BIOetEvUIb6wyDa9jE6dStC7mTQD/O
         1cAeJ7NKHcFJgeJqXAwj/lGH+qUxYNLaoUDxMa/pm1NFTCzbAmTnkLqQilRcDesTloJ7
         dBdHWqcXTUz57jPcMHNdz2TDy+JR8U50oGh0csZ9eKbjXiR2jrjvUam/bdKfdBCKxYp3
         etaPcTGLe4eixqGY+qP94PXZ8kG/4AoYRADjSiOA+1rCSN8TCxeF5HcZSsvjb8PZSkDN
         LLgA==
X-Gm-Message-State: ACrzQf2M2p3mf37rWln74SGtX4OSMz3FRL6xViQC1S+tQbwUAKb8oIZy
        oDyEIDkXdmgbhgIdUcOQ2InZeY5astu3uzOMSjfRgQ==
X-Google-Smtp-Source: AMsMyM4tyzY3LpyEMB3UjBYicGHTIwsU+zykq3O+yRvv6jt50eX1TIcBzVvzNXei2JjjzYj0NBcCj7J9d5vW0ASmqIk=
X-Received: by 2002:a05:6a00:4c11:b0:53e:4f07:fce9 with SMTP id
 ea17-20020a056a004c1100b0053e4f07fce9mr26299896pfb.66.1664226407869; Mon, 26
 Sep 2022 14:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220924181915.3251186-3-masahiroy@kernel.org>
 <202209250350.jJ8vDPnH-lkp@intel.com> <CAK7LNAT9rrSZ2NfTB2G_YZUwE48NbDHPJbM4NbjtwSGWA1YR4Q@mail.gmail.com>
In-Reply-To: <CAK7LNAT9rrSZ2NfTB2G_YZUwE48NbDHPJbM4NbjtwSGWA1YR4Q@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 26 Sep 2022 14:06:36 -0700
Message-ID: <CAKwvOdk8s5y_QQ7Gvp9E=LdxBtNnn4zkCzu40sHexxEZwwfO5w@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] kbuild: list sub-directories in ./Kbuild
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 24, 2022 at 5:29 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Sun, Sep 25, 2022 at 5:28 AM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Masahiro,
> >
> > I love your patch! Perhaps something to improve:
> >
> > [auto build test WARNING on masahiroy-kbuild/for-next]
> > [cannot apply to arm64/for-next/core gerg-m68knommu/for-next geert-m68k/for-next deller-parisc/for-next powerpc/next s390/features tip/x86/core linus/master v6.0-rc6 next-20220923]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Masahiro-Yamada/kbuild-various-cleanups/20220925-022150
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git for-next
> > config: um-x86_64_defconfig
> > compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
> > reproduce (this is a W=1 build):
> >         # https://github.com/intel-lab-lkp/linux/commit/d721cc5614aaa17b2965db04e9319d4ef5f7eaf7
> >         git remote add linux-review https://github.com/intel-lab-lkp/linux
> >         git fetch --no-tags linux-review Masahiro-Yamada/kbuild-various-cleanups/20220925-022150
> >         git checkout d721cc5614aaa17b2965db04e9319d4ef5f7eaf7
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         make W=1 O=build_dir ARCH=um SUBARCH=x86_64 SHELL=/bin/bash
> >
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> > >> /usr/bin/ld: warning: ./arch/x86/um/vdso/vdso.o: missing .note.GNU-stack section implies executable stack
> >    /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
> >    /usr/bin/ld: warning: .tmp_vmlinux.kallsyms1 has a LOAD segment with RWX permissions
> >    /usr/bin/ld: warning: .tmp_vmlinux.kallsyms1.o: missing .note.GNU-stack section implies executable stack
> >    /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
> >    /usr/bin/ld: warning: .tmp_vmlinux.kallsyms2 has a LOAD segment with RWX permissions
> >    /usr/bin/ld: warning: .tmp_vmlinux.kallsyms2.o: missing .note.GNU-stack section implies executable stack
> >    /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
> >    /usr/bin/ld: warning: vmlinux has a LOAD segment with RWX permissions

See also:
https://lore.kernel.org/lkml/20220921064855.2841607-1-davidgow@google.com/

> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://01.org/lkp
>
>
>
>
>
>
>
>
> My compiler is slightly different
> (gcc (Ubuntu 11.2.0-19ubuntu1) 11.2.0), but
> I cannot reproduce it.
>
>
>
> Perhaps, 0day thought this is a new warning
> due to a slightly different path?
>
>
> [before]
> warning: arch/x86/um/vdso/vdso.o
>
> [after]
> warning: ./arch/x86/um/vdso/vdso.o
>
>
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Thanks,
~Nick Desaulniers
