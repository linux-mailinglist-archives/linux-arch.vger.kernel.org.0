Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D10B5E999B
	for <lists+linux-arch@lfdr.de>; Mon, 26 Sep 2022 08:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbiIZGg3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Sep 2022 02:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbiIZGgC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Sep 2022 02:36:02 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2EEDF9B;
        Sun, 25 Sep 2022 23:35:37 -0700 (PDT)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 28Q6Z98M023619;
        Mon, 26 Sep 2022 15:35:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 28Q6Z98M023619
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664174109;
        bh=44eH+aJRD4kb7a/sBAIoIbN4tM4QpzduS3Oc5jWF0cA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JA7wjsoa5emabzSMfT9gMz5fvTDe0D99rsbZXbGl8bKQk9PcUZ/mIJK6WsO/82Tqt
         QSx4OpRQ54n2OMNxR3tESeh2fTmT7dsMpLrwUu7mJ61LqpWPPNGl6GKu6log47wGg2
         FYBnLu24GKIn8JzGeq5imYNBxcpI/QtF4ttwiPndSSR7GLWc6NRd+WW26Iidr/JUse
         Zi+afw6flpJYObJLRhk3JWUrldDHICDY1rTOBY3dXQ+Pqiy/NCw/LItuHpa30T1fS6
         NNwRccsJcY2d4N/6iW9SBfKPp/KeVUFeWgzT/31SW1LuqPddxSoPbOIafTALt3DbUo
         aA/ESRY+jTMHw==
X-Nifty-SrcIP: [209.85.160.50]
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-12803ac8113so8000776fac.8;
        Sun, 25 Sep 2022 23:35:09 -0700 (PDT)
X-Gm-Message-State: ACrzQf2qqI+2kzi8o4Mm3+37vhO8l/cVQnRorcM6o2i3o1u1Axk3H4R2
        zRc5lnbO9wZM/PVUuD5WgbyXc70J+KNtLAFnb4U=
X-Google-Smtp-Source: AMsMyM5nsiQbYnKEjk6ON7K9Xsbl+NsHX9f/ZF2hI0K78moxWk9I+PrSV5t6gvkzbkJFQPLytPxVWwWTY+4HwBT3krQ=
X-Received: by 2002:a05:6870:c58b:b0:10b:d21d:ad5e with SMTP id
 ba11-20020a056870c58b00b0010bd21dad5emr11223766oab.287.1664174108461; Sun, 25
 Sep 2022 23:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220926012609.3976305-1-masahiroy@kernel.org>
In-Reply-To: <20220926012609.3976305-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 26 Sep 2022 15:34:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNASkcs8gdi-pRf5EYs6PDOgTK-HLoWCsqiWTDUX-kS-bcg@mail.gmail.com>
Message-ID: <CAK7LNASkcs8gdi-pRf5EYs6PDOgTK-HLoWCsqiWTDUX-kS-bcg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: suppress warnings for single builds of
 vmlinux.lds, *.a, etc.
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 26, 2022 at 10:27 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> vmlinux-deps is unneeded because the dependency can directly list
> $(KBUILD_LDS) $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS)
>
> Do not cancel the rule; building an individual vmlinux.lds, built-in.a,
> or lib.a is working now, but the warning "overriding recipe for target"
> is shown.
>
> Without this patch:
>
>   $ make arch/x86/kernel/vmlinux.lds
>   Makefile:1798: warning: overriding recipe for target 'arch/x86/kernel/vmlinux.lds'
>   Makefile:1162: warning: ignoring old recipe for target 'arch/x86/kernel/vmlinux.lds'
>     [ snip ]
>     LDS     arch/x86/kernel/vmlinux.lds
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---


I take this back.


After testing this, I noticed vmlinux was not correctly rebuilt.





>
>  Makefile | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 244c07f1cc70..3e6974b4ebf2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1118,7 +1118,8 @@ endif
>  export KBUILD_VMLINUX_OBJS KBUILD_VMLINUX_LIBS
>  export KBUILD_LDS          := arch/$(SRCARCH)/kernel/vmlinux.lds
>
> -vmlinux-deps := $(KBUILD_LDS) $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS)
> +# The actual objects are generated when descending.
> +$(sort $(KBUILD_LDS) $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS)): .
>
>  # Recurse until adjust_autoksyms.sh is satisfied
>  PHONY += autoksyms_recursive
> @@ -1157,10 +1158,6 @@ vmlinux: scripts/link-vmlinux.sh vmlinux.o $(KBUILD_LDS) FORCE
>
>  targets := vmlinux
>
> -# The actual objects are generated when descending,
> -# make sure no implicit rule kicks in
> -$(sort $(vmlinux-deps)): . ;
> -
>  filechk_kernel.release = \
>         echo "$(KERNELVERSION)$$($(CONFIG_SHELL) $(srctree)/scripts/setlocalversion $(srctree))"
>
> --
> 2.34.1
>


-- 
Best Regards
Masahiro Yamada
