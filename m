Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2712CDCF6
	for <lists+linux-arch@lfdr.de>; Thu,  3 Dec 2020 19:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387555AbgLCSBa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Dec 2020 13:01:30 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:37912 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbgLCSBa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Dec 2020 13:01:30 -0500
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 0B3I09j7020577;
        Fri, 4 Dec 2020 03:00:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 0B3I09j7020577
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1607018410;
        bh=Q8rUUiuQPCHtIjHKZ25iSma0yE471Wc2ZwPZ52EYpXA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c8s94mdsXSLOpVko39GE94yfv+2gzeMV/HXHNgIMkxeaqs8gjTvHpyvc2Xc0x9pOj
         AOo5icsDHKvZetFGaTQCnk0cKQ64JBO/QcME0MIpJmNR70qzQGBLDVLMQriKEtrf09
         yv65KIKeqMTg7CQGAkp2+G7PJhG/gZuWBLu3nsI5/gRf3JF1p4iFNrgeogUg5sMZDX
         OxZGYC0MUVzIDtPDfvYm6yrGA+cQgoxRX8vOCyoRkUFyfnh//b803fH+Mwg1ZMkR4k
         +6+9QN+iT25bS1Wl0RaAhdLej2oBMXB47uOpVd1xqElr2bZakypeGE/bv0usqrCRg6
         ibM489qfF/Jbg==
X-Nifty-SrcIP: [209.85.216.53]
Received: by mail-pj1-f53.google.com with SMTP id r9so1507333pjl.5;
        Thu, 03 Dec 2020 10:00:09 -0800 (PST)
X-Gm-Message-State: AOAM5302niKOsGTtmVehzsma3d7+g3OkyPv0KsbggUz8WKbmYHkZAHL4
        QH1DVsIcf1jYWrDHa+pjcSqnX3WWMAbFlhr8Ano=
X-Google-Smtp-Source: ABdhPJyWwlayA/XR+Bnh4a5mDodnSKw0H8nrbACrY1JSJtlwr6wE2FkK0g+IV8XwwRNT2lr2uJVlldeyzgyNeL0U9xo=
X-Received: by 2002:a17:90a:fa0c:: with SMTP id cm12mr265364pjb.87.1607018409010;
 Thu, 03 Dec 2020 10:00:09 -0800 (PST)
MIME-Version: 1.0
References: <20201013003203.4168817-1-samitolvanen@google.com>
 <20201013003203.4168817-15-samitolvanen@google.com> <202010141549.412F2BF0@keescook>
In-Reply-To: <202010141549.412F2BF0@keescook>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 4 Dec 2020 02:59:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT350QjusoYCQEHDdoxAfTZjj82xp86O1qoNF=0u0PN-g@mail.gmail.com>
Message-ID: <CAK7LNAT350QjusoYCQEHDdoxAfTZjj82xp86O1qoNF=0u0PN-g@mail.gmail.com>
Subject: Re: [PATCH v6 14/25] kbuild: lto: remove duplicate dependencies from
 .mod files
To:     Kees Cook <keescook@chromium.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 15, 2020 at 7:50 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Oct 12, 2020 at 05:31:52PM -0700, Sami Tolvanen wrote:
> > With LTO, llvm-nm prints out symbols for each archive member
> > separately, which results in a lot of duplicate dependencies in the
> > .mod file when CONFIG_TRIM_UNUSED_SYMS is enabled. When a module
> > consists of several compilation units, the output can exceed the
> > default xargs command size limit and split the dependency list to
> > multiple lines, which results in used symbols getting trimmed.
> >
> > This change removes duplicate dependencies, which will reduce the
> > probability of this happening and makes .mod files smaller and
> > easier to read.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
>
> Hi Masahiro,
>
> This appears to be a general improvement as well. This looks like it can
> land without depending on the rest of the series.

It cannot.
Adding "sort -u" is pointless without the rest of the series
since the symbol duplication happens only with Clang LTO.

This is not a solution.
"reduce the probability of this happening" well describes it.

I wrote a different patch.



> -Kees
>
> > ---
> >  scripts/Makefile.build | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index ab0ddf4884fd..96d6c9e18901 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -266,7 +266,7 @@ endef
> >
> >  # List module undefined symbols (or empty line if not enabled)
> >  ifdef CONFIG_TRIM_UNUSED_KSYMS
> > -cmd_undef_syms = $(NM) $< | sed -n 's/^  *U //p' | xargs echo
> > +cmd_undef_syms = $(NM) $< | sed -n 's/^  *U //p' | sort -u | xargs echo
> >  else
> >  cmd_undef_syms = echo
> >  endif
> > --
> > 2.28.0.1011.ga647a8990f-goog
> >
>
> --
> Kees Cook
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/202010141549.412F2BF0%40keescook.



-- 
Best Regards
Masahiro Yamada
