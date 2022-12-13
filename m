Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE2264B50E
	for <lists+linux-arch@lfdr.de>; Tue, 13 Dec 2022 13:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbiLMMWY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Dec 2022 07:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235605AbiLMMWX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Dec 2022 07:22:23 -0500
X-Greylist: delayed 336 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 13 Dec 2022 04:22:21 PST
Received: from condef-07.nifty.com (condef-07.nifty.com [202.248.20.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAFCBB4;
        Tue, 13 Dec 2022 04:22:21 -0800 (PST)
Received: from conssluserg-04.nifty.com ([10.126.8.83])by condef-07.nifty.com with ESMTP id 2BDCDaMo002832;
        Tue, 13 Dec 2022 21:13:36 +0900
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 2BDCDLx9026781;
        Tue, 13 Dec 2022 21:13:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 2BDCDLx9026781
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1670933602;
        bh=jPEostDy9/vEakl3XTQVCX9XEz9FU/Jk6r+V9qKfjuM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XkNtsEc2kUycZSbesW77QvhHxPLP+HrgS5y2pZh2Fd3AVApyqQByCoNUJx8cQ8pIW
         Z8FsuqyhbWCQjsP22d50IQ04MeKJrSmGXO5fc01qf8sFSfZ6jK0MbeOSCcW6b152oS
         CWPREXqmPpXeWbq/NEgQZoQra0IJyqECITY0PtI0Gc3MOx/zzoRBUPr8CMUqJ6fKHE
         UJSXMs2+9AHdB3oq4f6ZrhZmTWr2NPl2BvFR1aZh1Jy54JCSE391pPYAFD/lhEixUZ
         EiP/b7/FiQycEvqIXuwLvzoGvOBPZLHdqjtfX0kPUX09g3eWcNl4Akq/z77q0D9WSd
         +8FTc86AocKBw==
X-Nifty-SrcIP: [209.85.210.54]
Received: by mail-ot1-f54.google.com with SMTP id v19-20020a9d5a13000000b0066e82a3872dso9131256oth.5;
        Tue, 13 Dec 2022 04:13:21 -0800 (PST)
X-Gm-Message-State: ANoB5plwf/ZKM7javm3u8024Q22wmGipfjajHGrY83RI3R+AJVS78lrt
        gvFkGsYSmiUucq3XC80ewGCdeDZ1PMadai1Wwc4=
X-Google-Smtp-Source: AA0mqf49GboRoHKfWueMtOx43I//pF5NCXtfCT1dwFlEom7xK6kmRBG/C/T/6hUEeQlY1UGliE3yoMjpLOmtuyXm0eo=
X-Received: by 2002:a9d:6748:0:b0:670:64b2:ae66 with SMTP id
 w8-20020a9d6748000000b0067064b2ae66mr4036347otm.225.1670933600853; Tue, 13
 Dec 2022 04:13:20 -0800 (PST)
MIME-Version: 1.0
References: <20221012181841.333325-1-masahiroy@kernel.org>
In-Reply-To: <20221012181841.333325-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 13 Dec 2022 21:12:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNATncU_o3JDi4k-F4ALOb3LbVZbSmA4X6kfkHf2fb1omUg@mail.gmail.com>
Message-ID: <CAK7LNATncU_o3JDi4k-F4ALOb3LbVZbSmA4X6kfkHf2fb1omUg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: raise minimum supported version of
 binutils to 2.25
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 13, 2022 at 3:19 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Binutils 2.23 was released in 2012. Almost 10 years old.
>
> We already require GCC 5.1, released in 2015.
>
> Bump the binutils version to 2.25, which was released one year before
> GCC 5.1.
>
> With this applied, some subsystems can start to clean up code.
> Examples:
>   arch/arm/Kconfig.assembler
>   arch/mips/vdso/Kconfig
>   arch/powerpc/Makefile
>   arch/x86/Kconfig.assembler
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>



I will pick this up to the kbuild tree
because it got Linus' ack.






> ---
>
>  Documentation/process/changes.rst | 4 ++--
>  scripts/min-tool-version.sh       | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
> index 9844ca3a71a6..ef540865ad22 100644
> --- a/Documentation/process/changes.rst
> +++ b/Documentation/process/changes.rst
> @@ -35,7 +35,7 @@ Rust (optional)        1.62.0           rustc --version
>  bindgen (optional)     0.56.0           bindgen --version
>  GNU make               3.82             make --version
>  bash                   4.2              bash --version
> -binutils               2.23             ld -v
> +binutils               2.25             ld -v
>  flex                   2.5.35           flex --version
>  bison                  2.0              bison --version
>  pahole                 1.16             pahole --version
> @@ -119,7 +119,7 @@ Bash 4.2 or newer is needed.
>  Binutils
>  --------
>
> -Binutils 2.23 or newer is needed to build the kernel.
> +Binutils 2.25 or newer is needed to build the kernel.
>
>  pkg-config
>  ----------
> diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
> index 8766e248ffbb..4e5b45d9b526 100755
> --- a/scripts/min-tool-version.sh
> +++ b/scripts/min-tool-version.sh
> @@ -14,7 +14,7 @@ fi
>
>  case "$1" in
>  binutils)
> -       echo 2.23.0
> +       echo 2.25.0
>         ;;
>  gcc)
>         echo 5.1.0
> --
> 2.34.1
>


-- 
Best Regards
Masahiro Yamada
