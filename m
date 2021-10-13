Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A991042C861
	for <lists+linux-arch@lfdr.de>; Wed, 13 Oct 2021 20:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237600AbhJMSMs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Oct 2021 14:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbhJMSMs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Oct 2021 14:12:48 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E6CC061570
        for <linux-arch@vger.kernel.org>; Wed, 13 Oct 2021 11:10:44 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y15so15631860lfk.7
        for <linux-arch@vger.kernel.org>; Wed, 13 Oct 2021 11:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N5TEQck0sZT4Ta6tLRdPV0UEutrCTFu6Cme/v+Sjxeo=;
        b=SaBwLltyOmUvlw+l0jpPn7wVhVSDwOsS8Hu5rEK9OpOug+BYojmm5wqKNl0BTrxZaQ
         3h1GTB5AWGNWSheykrLTlOKQc/h7OJN0mmXmyVOTNL1j3vc+i5dyekCsELRnoZWlrrB9
         Iw7hrQBF+bsu/Fyt8bUUy/myKxarefszUTnNk6HsDIaaLmRgo/fCZ3UybZoXGAWoLjky
         j0sOhUYP/lnrNgPIAH09BzTXQDDMj8YUBb9nVfrk6jb4Ra2LBOb4mPLa9aH4rVv7Z3a+
         DaSfJ3Buol8PVepBofHzT48F3ygzpBC8vjNwkHrUJfEWpm0g2FewUZzsX1bHyeCdzjgK
         NNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N5TEQck0sZT4Ta6tLRdPV0UEutrCTFu6Cme/v+Sjxeo=;
        b=A0fE4/IJkRCqsV/9gvWwwuoi6s58YF6xKryRkWlCTaH4Sl+PjHUHnSGr2noeh72L6Q
         W9No1jj0dTbpGAhB+fk4ob2YQw4H7fyskP2vRJl55uZYmEIgUThR0qN69Pp0Db+gk6H2
         uZozGkcFnC5CnE6S/H9j/Unu71rGTAYHd36UB1j1n5GvzrxedfYwKTBbW/B5TU4Slgix
         FfjauLVOQSAKjefulyg/yoI7ZmHn147iuYI/Sgm8mGe6IXkwjV0nI/Fvg3IZ1VD2bh+W
         RgaH0dDS1byJ02gq3BNew9grpe6P+kUlIqXNt4WPmBJOgunRa4gNh4jPkn8e+PThefpR
         fTCQ==
X-Gm-Message-State: AOAM532sfyEulWyd40uMMdCX8amYgxH29lR1V1oAfdIAZkscpWY3wrg9
        rw0+oYAVbVwsy2qc3yvHexWF72iAYpsMZ4Mcjh2Q6Q==
X-Google-Smtp-Source: ABdhPJw5L7jyVnMlYlOYxjOH7TmSjBEYG/z0/c0zDFSzwpz1g92FtKbr0u/AksA/tbj34qCNAzrLecP/Pacty/C8bC0=
X-Received: by 2002:a05:6512:4c7:: with SMTP id w7mr517901lfq.444.1634148642379;
 Wed, 13 Oct 2021 11:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211013175742.1197608-1-keescook@chromium.org> <20211013175742.1197608-3-keescook@chromium.org>
In-Reply-To: <20211013175742.1197608-3-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 13 Oct 2021 11:10:31 -0700
Message-ID: <CAKwvOdmczBu286Ju2+gZK2h=hmELeX0K55pMOwMK4dtH89bU9g@mail.gmail.com>
Subject: Re: [PATCH 2/4] x86/boot: Allow a "silent" kaslr random byte fetch
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@suse.de>, Josh Poimboeuf <jpoimboe@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <jroedel@suse.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Abaci Robot <abaci@linux.alibaba.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Miroslav Benes <mbenes@suse.cz>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 13, 2021 at 10:57 AM Kees Cook <keescook@chromium.org> wrote:
>
> Under earlyprintk, each RNG call produces a debug report line. To support
> the future FGKASLR feature, which will fetch random bytes during function
> shuffling, this is not useful information (each line is identical and
> tells us nothing new), needlessly spamming the console. Instead, allow
> for a NULL "purpose" to suppress the debug reporting.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/x86/lib/kaslr.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/lib/kaslr.c b/arch/x86/lib/kaslr.c
> index a53665116458..2b3eb8c948a3 100644
> --- a/arch/x86/lib/kaslr.c
> +++ b/arch/x86/lib/kaslr.c
> @@ -56,11 +56,14 @@ unsigned long kaslr_get_random_long(const char *purpose)
>         unsigned long raw, random = get_boot_seed();
>         bool use_i8254 = true;
>
> -       debug_putstr(purpose);
> -       debug_putstr(" KASLR using");
> +       if (purpose) {
> +               debug_putstr(purpose);
> +               debug_putstr(" KASLR using");
> +       }
>
>         if (has_cpuflag(X86_FEATURE_RDRAND)) {
> -               debug_putstr(" RDRAND");
> +               if (purpose)
> +                       debug_putstr(" RDRAND");
>                 if (rdrand_long(&raw)) {
>                         random ^= raw;
>                         use_i8254 = false;
> @@ -68,7 +71,8 @@ unsigned long kaslr_get_random_long(const char *purpose)
>         }
>
>         if (has_cpuflag(X86_FEATURE_TSC)) {
> -               debug_putstr(" RDTSC");
> +               if (purpose)
> +                       debug_putstr(" RDTSC");
>                 raw = rdtsc();
>
>                 random ^= raw;
> @@ -76,7 +80,8 @@ unsigned long kaslr_get_random_long(const char *purpose)
>         }
>
>         if (use_i8254) {
> -               debug_putstr(" i8254");
> +               if (purpose)
> +                       debug_putstr(" i8254");
>                 random ^= i8254();
>         }
>
> @@ -86,7 +91,8 @@ unsigned long kaslr_get_random_long(const char *purpose)
>             : "a" (random), "rm" (mix_const));
>         random += raw;
>
> -       debug_putstr("...\n");
> +       if (purpose)
> +               debug_putstr("...\n");
>
>         return random;
>  }
> --
> 2.30.2
>


-- 
Thanks,
~Nick Desaulniers
