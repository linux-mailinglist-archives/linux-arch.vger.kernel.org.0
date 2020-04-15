Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E4B1AAFDF
	for <lists+linux-arch@lfdr.de>; Wed, 15 Apr 2020 19:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411384AbgDOReg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Apr 2020 13:34:36 -0400
Received: from condef-08.nifty.com ([202.248.20.73]:18867 "EHLO
        condef-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411377AbgDORed (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Apr 2020 13:34:33 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Apr 2020 13:34:31 EDT
Received: from conssluserg-01.nifty.com ([10.126.8.80])by condef-08.nifty.com with ESMTP id 03FHLUkd013640
        for <linux-arch@vger.kernel.org>; Thu, 16 Apr 2020 02:21:30 +0900
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 03FHKijl024678;
        Thu, 16 Apr 2020 02:20:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 03FHKijl024678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1586971245;
        bh=TGORWEVV9JU/a8b7dPxPrCBb0+qo0qmf1iyasgy2yYM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fmvusO6ZeNrZor8/By+628dDxGrOMFdo1ogCH4r8MTOI3jUCrZ7zGhUqaYJTXw4BP
         Z+YTt07uUCQLMVGq50OKCfn/n+NR7tvK8YEZtappPGHnfY5e01oa4idtWmIZogw+0V
         /tuTwTT7bqFPxyVJWT6SRPsqjGyO+snZP11NfN8eSPJ8RL/8g/K8iltTDtsn0YsgKI
         ImFVn+koPmZfvrCat+Th+M5ri12+crKktE5TEtJnPTtGM4tTp38HH4vwdb3DNQBymz
         p6C7e5MCmHS0ihk5uDkIMIJV5h8bH7qfs6CoCmxqPgjhnWjlSZug1+j4/a/16fcYHP
         wbeQfXri7ZhNA==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id g184so386593vsc.0;
        Wed, 15 Apr 2020 10:20:44 -0700 (PDT)
X-Gm-Message-State: AGi0PuZuEDeD9+9tiE1ELC+ZmX3jhFDJmmL6TeZuwTk+6BTd6x/Xcxib
        lrvOTeJyoz6eaoviSofKviu/OCioV0ib39R1Lzk=
X-Google-Smtp-Source: APiQypI/bnEQDxUgaDyhDXxMhi5qAMztdNfkzonR1JQLp3foqu0/1E/k9cBdOx843NkNSdPctvkZyEkGUIawy7SJw6k=
X-Received: by 2002:a05:6102:2007:: with SMTP id p7mr5485487vsr.181.1586971243575;
 Wed, 15 Apr 2020 10:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200415165218.20251-1-will@kernel.org> <20200415165218.20251-2-will@kernel.org>
In-Reply-To: <20200415165218.20251-2-will@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 16 Apr 2020 02:20:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNATMDkey2ckTfuCysVPVUAbZa5C8oBBqWtE1ura+rnCbKg@mail.gmail.com>
Message-ID: <CAK7LNATMDkey2ckTfuCysVPVUAbZa5C8oBBqWtE1ura+rnCbKg@mail.gmail.com>
Subject: Re: [PATCH v3 01/12] compiler/gcc: Emit build-time warning for GCC
 prior to version 4.8
To:     Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 16, 2020 at 1:52 AM Will Deacon <will@kernel.org> wrote:
>
> Prior to version 4.8, GCC may miscompile READ_ONCE() by erroneously
> discarding the 'volatile' qualifier:
>
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145
>
> We've been working around this using some nasty hacks which make
> READ_ONCE() both horribly complicated and also prevent us from enforcing
> that it is only used on scalar types. Since GCC 4.8 is pretty old for
> kernel builds now, emit a warning if we detect it during the build.


This patch is unneeded since you will remove GCC 4.8 support
in 11/12.

Please move 11/12 to the head of this series,
and remove all noise changes.

Thanks.






> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  init/Kconfig            | 4 ++--
>  scripts/Kconfig.include | 9 +++++++++
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 9e22ee8fbd75..816b8b4a5e9e 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -9,11 +9,11 @@ config DEFCONFIG_LIST
>         default "arch/$(SRCARCH)/configs/$(KBUILD_DEFCONFIG)"
>
>  config CC_IS_GCC
> -       def_bool $(success,$(CC) --version | head -n 1 | grep -q gcc)
> +       def_bool $(cc-is-gcc)
>
>  config GCC_VERSION
>         int
> -       default $(shell,$(srctree)/scripts/gcc-version.sh $(CC)) if CC_IS_GCC
> +       default $(gcc-version) if CC_IS_GCC
>         default 0
>
>  config LD_VERSION
> diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
> index c264da2b9b30..5261e9d6b50b 100644
> --- a/scripts/Kconfig.include
> +++ b/scripts/Kconfig.include
> @@ -54,3 +54,12 @@ $(error-if,$(success, $(LD) -v | grep -q gold), gold linker '$(LD)' not supporte
>  cc-option-bit = $(if-success,$(CC) -Werror $(1) -E -x c /dev/null -o /dev/null,$(1))
>  m32-flag := $(cc-option-bit,-m32)
>  m64-flag := $(cc-option-bit,-m64)
> +
> +# gcc version including patch level
> +gcc-version := $(shell,$(srctree)/scripts/gcc-version.sh $(CC))
> +
> +# Return y if the compiler is GCC, n otherwise
> +cc-is-gcc := $(success,$(CC) --version | head -n 1 | grep -q gcc)
> +
> +# Warn if the compiler is GCC prior to 4.8
> +$(warning-if,$(if-success,[ $(gcc-version) -lt 40800 ],$(cc-is-gcc),n),"Your compiler is old and may miscompile the kernel due to https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145 - please upgrade it.")
> --
> 2.26.0.110.g2183baf09c-goog
>


-- 
Best Regards
Masahiro Yamada
