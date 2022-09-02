Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A74A5AABA8
	for <lists+linux-arch@lfdr.de>; Fri,  2 Sep 2022 11:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbiIBJmE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Sep 2022 05:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbiIBJmC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Sep 2022 05:42:02 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF45A4E63F;
        Fri,  2 Sep 2022 02:41:51 -0700 (PDT)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 2829fccx032021;
        Fri, 2 Sep 2022 18:41:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 2829fccx032021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662111698;
        bh=Yu6q9CiU0SZ2y8yEyENS2Mjn2VsQqrhZ4sv/qS7Inu0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hOOYme3dsSbItMMKrdyZPuaHh6lUsJm1eOOS/YSxV1DlV2iWaXMvCnlVaeZjvJGxO
         4IVPvp8aEt27DScP+ufYRROYrYUYvuS5CeZqMirCNkVwfLaaJwTKIpYV1+fZPXj8t3
         eS0qw5WoKem4psdSrT+xbf5HNdBztvtpBWp3f7+ZSJO8sL/n1Cstwbw4oQOQjy/v1F
         ALZbLPFxBUtP4MXFDZl6363DWIc/V1JZsrUKB/qomVZduB3pzzWEYRdSVCdMu/39qp
         Sf0qC0EbaMEIQCvoL2SQXyaYbM07sNMpI6+6qO0oyzyHk9aLBYJFwppkUi+yC1ieWt
         tQIexKjHpnzbw==
X-Nifty-SrcIP: [209.85.160.43]
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-11edd61a9edso3429979fac.5;
        Fri, 02 Sep 2022 02:41:38 -0700 (PDT)
X-Gm-Message-State: ACgBeo2ZRBMhDomXY8t1TLqYc4AY973EwgygwZXbuc9T17Xd4Ww5d8TB
        vouwQ9E/vKmMwA0M0GNxZ3BhouvqifJGzjTN3XM=
X-Google-Smtp-Source: AA6agR4ucDwaCckZtMQtGkNmHwmMUQc6ZBkNxdQoU8K+chnV99uRpH70hKQYOGpqiQ0Wz/ZmZkBPbN/ucVX8p61BtG8=
X-Received: by 2002:a05:6870:f626:b0:10d:a798:f3aa with SMTP id
 ek38-20020a056870f62600b0010da798f3aamr1712772oab.194.1662111697432; Fri, 02
 Sep 2022 02:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220828024003.28873-1-masahiroy@kernel.org> <20220828024003.28873-6-masahiroy@kernel.org>
In-Reply-To: <20220828024003.28873-6-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 2 Sep 2022 18:41:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQsw2u4AYKg74GYaz3n4gvbTdF3dn9OUYWxCGXGjP5sQA@mail.gmail.com>
Message-ID: <CAK7LNAQsw2u4AYKg74GYaz3n4gvbTdF3dn9OUYWxCGXGjP5sQA@mail.gmail.com>
Subject: Re: [PATCH 05/15] kbuild: build init/built-in.a just once
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Sun, Aug 28, 2022 at 11:40 AM Masahiro Yamada <masahiroy@kernel.org> wrote:


> --- a/init/Makefile
> +++ b/init/Makefile
> @@ -19,20 +19,47 @@ mounts-y                    := do_mounts.o
>  mounts-$(CONFIG_BLK_DEV_RAM)   += do_mounts_rd.o
>  mounts-$(CONFIG_BLK_DEV_INITRD)        += do_mounts_initrd.o
>
> -# dependencies on generated files need to be listed explicitly
> -$(obj)/version.o: include/generated/compile.h
> +#
> +# UTS_VERSION
> +#
> +
> +smp-flag-$(CONFIG_SMP)                 := SMP
> +preempt-flag-$(CONFIG_PREEMPT_BUILD)   := PREEMPT
> +preempt-flag-$(CONFIG_PREEMPT_DYNAMIC) := PREEMPT_DYNAMIC
> +preempt-flag-$(CONFIG_PREEMPT_RT)      := PREEMPT_RT
> +
> +build-version = $(or $(KBUILD_BUILD_VERSION), $(build-version-auto))
> +build-timestamp = $(or $(KBUILD_BUILD_TIMESTAMP), $(build-timestamp-auto))
> +
> +# Maximum length of UTS_VERSION is 64 chars
> +filechk_uts_version = \
> +       utsver=$$(echo '$(pound)'"$(build-version)" $(smp-flag-y) $(preempt-flag-y) "$(build-timestamp)" | cut -b -64); \
> +       echo '$(pound)'define UTS_VERSION \""$${utsver}"\"
> +
> +#
> +# Build version.c with temporary UTS_VERSION
> +#
> +
> +$(obj)/utsversion-tmp.h: FORCE
> +       $(call filechk,uts_version)


I missed to clean up init/utsversion-tmp.h.

I patched like follows, and also added it to init/.gitignore.




diff --git a/init/Makefile b/init/Makefile
index 63f53d210cad..ba90eb817185 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -43,6 +43,8 @@ filechk_uts_version = \
 $(obj)/utsversion-tmp.h: FORCE
        $(call filechk,uts_version)

+clean-files += utsversion-tmp.h
+
 $(obj)/version.o: include/generated/compile.h $(obj)/utsversion-tmp.h
 CFLAGS_version.o := -include $(obj)/utsversion-tmp.h










-- 
Best Regards
Masahiro Yamada
