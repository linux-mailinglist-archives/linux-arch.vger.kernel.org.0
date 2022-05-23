Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F28D531956
	for <lists+linux-arch@lfdr.de>; Mon, 23 May 2022 22:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244009AbiEWSoi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 May 2022 14:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243314AbiEWSoZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 May 2022 14:44:25 -0400
Received: from condef-08.nifty.com (condef-08.nifty.com [202.248.20.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE74F6A079;
        Mon, 23 May 2022 11:27:18 -0700 (PDT)
Received: from conssluserg-04.nifty.com ([10.126.8.83])by condef-08.nifty.com with ESMTP id 24NI6ipB016156;
        Tue, 24 May 2022 03:06:44 +0900
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 24NI5KXv002937;
        Tue, 24 May 2022 03:05:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 24NI5KXv002937
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653329121;
        bh=xyfMz2s6K1FqS7FKBYD4t23CA7hAJBCjnd+TynP5fZY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wLWMHJLOejJIXhpVDGf9HNSx+SpTPVQUXvZhixAqDXV0z7z7XYTc7NHsjSVsRdrzO
         5gFFxjxAUV70SlzCQBQA5zl5Eo9n3JLjoa+Z6Z6R/1GbKTffwLWtZu+guZMreSmFOo
         7q4VUHA2w4OzRP2FjYyb0e0KAjEyh94eDs+96SgIZ2UVW9GimqGFg1VqKzrk/kK8OQ
         AcR2aj6xN3Rb2zu003g+PPx3SfgMH1DkkD+0tPAJpqKgRxHuThQsY/RooKKGvP/DEB
         4EQhtFDGmBM6nCZxh15asv7RHHDlLkbFfBaqLcp135Okm0y8QUoLxGBd96f1e5nsjk
         5xNLqrgDzpRng==
X-Nifty-SrcIP: [209.85.215.173]
Received: by mail-pg1-f173.google.com with SMTP id 137so14345838pgb.5;
        Mon, 23 May 2022 11:05:20 -0700 (PDT)
X-Gm-Message-State: AOAM530DxU7nDVS7Z5BXL7oz+xUhCMQ2pSYLP0vvfRhu4WCSqnnmZ8f2
        koha5Px06Y1k+zW+TD4rzjR4rsyWMMZOi9kth9M=
X-Google-Smtp-Source: ABdhPJx5Lme6JhQ7OKXuXU7KdkCmDLJQv7tFwa3fzbZTWXsLVHVozSYCDjkmkCCK6F2tBUWOu/ge6oucCPgm4OmGxhg=
X-Received: by 2002:a63:fc5e:0:b0:3db:5804:f3b with SMTP id
 r30-20020a63fc5e000000b003db58040f3bmr21273043pgk.126.1653329119628; Mon, 23
 May 2022 11:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220209185752.1226407-1-alexandr.lobakin@intel.com> <20220209185752.1226407-2-alexandr.lobakin@intel.com>
In-Reply-To: <20220209185752.1226407-2-alexandr.lobakin@intel.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 24 May 2022 03:04:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT3QTfkYLFTBKLxghY_gBQZmud3-4UJMK3tA9eOV4UeTg@mail.gmail.com>
Message-ID: <CAK7LNAT3QTfkYLFTBKLxghY_gBQZmud3-4UJMK3tA9eOV4UeTg@mail.gmail.com>
Subject: Re: [PATCH v10 01/15] modpost: fix removing numeric suffixes
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     linux-hardening@vger.kernel.org, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Bruce Schlobohm <bruce.schlobohm@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        live-patching@vger.kernel.org,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 10, 2022 at 3:59 AM Alexander Lobakin
<alexandr.lobakin@intel.com> wrote:
>
> `-z unique-symbol` linker flag which is planned to use with FG-KASLR
> to simplify livepatching (hopefully globally later on) triggers the
> following:
>
> ERROR: modpost: "param_set_uint.0" [vmlinux] is a static EXPORT_SYMBOL
>
> The reason is that for now the condition from remove_dot():
>
> if (m && (s[n + m] == '.' || s[n + m] == 0))
>
> which was designed to test if it's a dot or a '\0' after the suffix
> is never satisfied.
> This is due to that `s[n + m]` always points to the last digit of a
> numeric suffix, not on the symbol next to it (from a custom debug
> print added to modpost):
>
> param_set_uint.0, s[n + m] is '0', s[n + m + 1] is '\0'
>
> So it's off-by-one and was like that since 2014.
> Fix this for the sake of upcoming features, but don't bother
> stable-backporting, as it's well hidden -- apart from that LD flag,
> can be triggered only by GCC LTO which never landed upstream.
>
> Fixes: fcd38ed0ff26 ("scripts: modpost: fix compilation warning")
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> ---
>  scripts/mod/modpost.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 6bfa33217914..4648b7afe5cc 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1986,7 +1986,7 @@ static char *remove_dot(char *s)
>
>         if (n && s[n]) {
>                 size_t m = strspn(s + n + 1, "0123456789");
> -               if (m && (s[n + m] == '.' || s[n + m] == 0))
> +               if (m && (s[n + m + 1] == '.' || s[n + m + 1] == 0))
>                         s[n] = 0;
>
>                 /* strip trailing .lto */
> --
> 2.34.1
>

This trivial patch has not been picked up yet.

I can apply this to my tree, if you want.

Please let me know your thoughts.


-- 
Best Regards
Masahiro Yamada
