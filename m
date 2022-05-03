Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C623517BB3
	for <lists+linux-arch@lfdr.de>; Tue,  3 May 2022 03:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiECBcY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 May 2022 21:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiECBcW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 May 2022 21:32:22 -0400
X-Greylist: delayed 233 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 02 May 2022 18:28:50 PDT
Received: from condef-01.nifty.com (condef-01.nifty.com [202.248.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FEF60D6;
        Mon,  2 May 2022 18:28:50 -0700 (PDT)
Received: from conssluserg-05.nifty.com ([10.126.8.84])by condef-01.nifty.com with ESMTP id 24313Ssi000782;
        Tue, 3 May 2022 10:03:28 +0900
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 2430wEQd008425;
        Tue, 3 May 2022 09:58:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 2430wEQd008425
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651539495;
        bh=X5yyCYnmChLJWpoXfwlLy3Yqy1jj1u5sgNOnl2YeT+8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aRZ+3CIUS9z02RmoL6+keYfwec6SGR8l55vY8O7YN/YD8fA9t+YbxYUoUg3cqIxOz
         7fS/W0toHGLlh1J4q5O+BQW6cZfc82tuWAsBNfozPKIZGpxDw7kwWVv9jFEWbg6Vb3
         KSDrXCCPSLt2n56dM78W27r4IOXaYu1FDzEHhUH+prkClQWxpLjguUIksVR23AGl6K
         9yMsGHR4nUxEUogDPdvGUI6jkjCesNhgh3oMFMjeYD8RcmtcZx2e3HWRv1v0yRUBBs
         SCu/OdFZwzKhNaAD3DHa8+QbV/qS+xAznq2ut1qKO3k63WknYCuACGNW2ZUWMNC3/f
         +1wneat+0RA+A==
X-Nifty-SrcIP: [209.85.216.49]
Received: by mail-pj1-f49.google.com with SMTP id cq17-20020a17090af99100b001dc0386cd8fso776908pjb.5;
        Mon, 02 May 2022 17:58:14 -0700 (PDT)
X-Gm-Message-State: AOAM531QEn2sAb+gni98iwGRuMK6bwuLy5czofNjjNHx7mbY8CAF9q2v
        dpooWwn3PwcRPyBmIAIATsNmE22tns5RTGIcpuA=
X-Google-Smtp-Source: ABdhPJz+NT1ytlT70sSlhO329TCvsmWaO6n7IEVV8ssLDz1hwnrwWgFpFLcb6+3gsOZ1Cyq8cWbiLDuibQJ8QIabxoU=
X-Received: by 2002:a17:90a:e517:b0:1d7:5bbd:f9f0 with SMTP id
 t23-20020a17090ae51700b001d75bbdf9f0mr2001475pjy.77.1651539493892; Mon, 02
 May 2022 17:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220209185752.1226407-1-alexandr.lobakin@intel.com> <20220209185752.1226407-2-alexandr.lobakin@intel.com>
In-Reply-To: <20220209185752.1226407-2-alexandr.lobakin@intel.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 3 May 2022 09:57:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS0SLmpCHB8W=D6kGmfb5S+ESjY674P6q7RiO7faD=wqQ@mail.gmail.com>
Message-ID: <CAK7LNAS0SLmpCHB8W=D6kGmfb5S+ESjY674P6q7RiO7faD=wqQ@mail.gmail.com>
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


Acked-by: Masahiro Yamada <masahiroy@kernel.org>



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


-- 
Best Regards
Masahiro Yamada
