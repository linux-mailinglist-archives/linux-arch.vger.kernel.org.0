Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7B032566F
	for <lists+linux-arch@lfdr.de>; Thu, 25 Feb 2021 20:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbhBYTN6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Feb 2021 14:13:58 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:35782 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbhBYTK4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Feb 2021 14:10:56 -0500
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 11PJ9Bkd013829;
        Fri, 26 Feb 2021 04:09:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 11PJ9Bkd013829
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614280152;
        bh=zg1EEkrl/wm9+TnhN4C32Tty7U9ZLaDHf5C7lX9aPew=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1xgeBpZ3CUbQ/fWk3kKZX6sHSLKL2GUlmmPqnwen6i0bvDJXbDMJi+SC9qxhnGFtD
         1b/enygjOZ0cgPYM3i6EdgaZA+tRPdhdovhhyYwwaICZmj1C6eqYZxT0mI0P17jhCA
         dHpE2SFjRwvPAQCcqtf24ZWYPXqj6RbVIG5A3jwq2FTWLrPbDtarR3ZN6YwNTsVqUc
         SEQuL2LlaERn1arlxOew3EPyR4EHUlnAj6BvsE/5nNnZTdn34dVTP7JQnm8CnNoJft
         ECTLam3yIqCNGIN4OvnbqApPO6Er2xdJcnSrWwZwSRiiNCGklwFMBksm4oBapUVNDI
         v4phVsR3VzxSw==
X-Nifty-SrcIP: [209.85.215.172]
Received: by mail-pg1-f172.google.com with SMTP id e6so4434429pgk.5;
        Thu, 25 Feb 2021 11:09:11 -0800 (PST)
X-Gm-Message-State: AOAM530LIJXf0ls4NimBqqsz7ijk80FY2D1OHV2uheiOl1autYyfvLei
        X94zBw2C/mB9Tiqt3nVOA5GE+AIQ+x4s+hr50ns=
X-Google-Smtp-Source: ABdhPJzS1WbAxMEt7joUmN9ZapNyyOeIYXnC+SmaepLH4w9wg3+sUyEHzRmu8OE6ooVIgiIVRH7yqtpc/I4PUKaelTE=
X-Received: by 2002:a62:d454:0:b029:1ed:a6d6:539d with SMTP id
 u20-20020a62d4540000b02901eda6d6539dmr4660956pfl.63.1614280150840; Thu, 25
 Feb 2021 11:09:10 -0800 (PST)
MIME-Version: 1.0
References: <20210225160247.2959903-1-masahiroy@kernel.org>
 <20210225160247.2959903-2-masahiroy@kernel.org> <CABCJKufovCMH9iyA9hFjq1Pt4VNWEPid+rqNWtTvYPTC19LfeA@mail.gmail.com>
In-Reply-To: <CABCJKufovCMH9iyA9hFjq1Pt4VNWEPid+rqNWtTvYPTC19LfeA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 26 Feb 2021 04:08:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNASVrpN2CoUZt7Yj++wTv2C1vMioA4nAZkHLrPkQGGLj9g@mail.gmail.com>
Message-ID: <CAK7LNASVrpN2CoUZt7Yj++wTv2C1vMioA4nAZkHLrPkQGGLj9g@mail.gmail.com>
Subject: Re: [PATCH 1/4] kbuild: fix UNUSED_KSYMS_WHITELIST for Clang LTO
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>, Nicolas Pitre <nico@fluxnic.net>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 26, 2021 at 2:46 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> Hi Masahiro,
>
> On Thu, Feb 25, 2021 at 8:03 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Commit fbe078d397b4 ("kbuild: lto: add a default list of used symbols")
> > does not work as expected if the .config file has already specified
> > CONFIG_UNUSED_KSYMS_WHITELIST="my/own/white/list" before enabling
> > CONFIG_LTO_CLANG.
> >
> > So, the user-supplied whitelist and LTO-specific white list must be
> > independent of each other.
> >
> > I refactored the shell script so CONFIG_MODVERSIONS and CONFIG_CLANG_LTO
> > handle whitelists in the same way.
> >
> > Fixes: fbe078d397b4 ("kbuild: lto: add a default list of used symbols")
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  init/Kconfig                    |  1 -
> >  scripts/gen_autoksyms.sh        | 33 ++++++++++++++++++++++++---------
> >  scripts/lto-used-symbollist.txt |  5 -----
> >  3 files changed, 24 insertions(+), 15 deletions(-)
> >  delete mode 100644 scripts/lto-used-symbollist.txt
>
> > +
> > +ksym_wl=
> >  if [ -n "$CONFIG_UNUSED_KSYMS_WHITELIST" ]; then
> >         # Use 'eval' to expand the whitelist path and check if it is relative
> >         eval ksym_wl="$CONFIG_UNUSED_KSYMS_WHITELIST"
> > @@ -40,16 +57,14 @@ cat > "$output_file" << EOT
> >  EOT
> >
> >  [ -f modules.order ] && modlist=modules.order || modlist=/dev/null
> > -sed 's/ko$/mod/' $modlist |
> > -xargs -n1 sed -n -e '2{s/ /\n/g;/^$/!p;}' -- |
> > -cat - "$ksym_wl" |
> > +
> > +{
> > +       sed 's/ko$/mod/' $modlist | xargs -n1 sed -n -e '2p'
> > +       echo "$needed_symbols"
> > +       [ -n "$ksym_wl" ] && cat "$ksym_wl"
> > +} | sed -e 's/ /\n/g' | sed -n -e '/^$/!p' |
> >  # Remove the dot prefix for ppc64; symbol names with a dot (.) hold entry
> >  # point addresses.
> >  sed -e 's/^\.//' |
> >  sort -u |
> >  sed -e 's/\(.*\)/#define __KSYM_\1 1/' >> "$output_file"
> > -
> > -# Special case for modversions (see modpost.c)
> > -if [ -n "$CONFIG_MODVERSIONS" ]; then
> > -       echo "#define __KSYM_module_layout 1" >> "$output_file"
> > -fi
> > diff --git a/scripts/lto-used-symbollist.txt b/scripts/lto-used-symbollist.txt
> > deleted file mode 100644
> > index 38e7bb9ebaae..000000000000
> > --- a/scripts/lto-used-symbollist.txt
> > +++ /dev/null
> > @@ -1,5 +0,0 @@
> > -memcpy
> > -memmove
> > -memset
> > -__stack_chk_fail
> > -__stack_chk_guard
> > --
> > 2.27.0
> >
> >
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 0bf5b340b80e..351161326e3c 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -2277,7 +2277,6 @@ config TRIM_UNUSED_KSYMS
> >  config UNUSED_KSYMS_WHITELIST
> >         string "Whitelist of symbols to keep in ksymtab"
> >         depends on TRIM_UNUSED_KSYMS
> > -       default "scripts/lto-used-symbollist.txt" if LTO_CLANG
> >         help
> >           By default, all unused exported symbols will be un-exported from the
> >           build when TRIM_UNUSED_KSYMS is selected.
> > diff --git a/scripts/gen_autoksyms.sh b/scripts/gen_autoksyms.sh
> > index d54dfba15bf2..b74d5949fea6 100755
> > --- a/scripts/gen_autoksyms.sh
> > +++ b/scripts/gen_autoksyms.sh
> > @@ -19,7 +19,24 @@ esac
> >  # We need access to CONFIG_ symbols
> >  . include/config/auto.conf
> >
> > -ksym_wl=/dev/null
> > +needed_symbols=
> > +
> > +# Special case for modversions (see modpost.c)
> > +if [ -n "$CONFIG_MODVERSIONS" ]; then
> > +       needed_symbols="$needed_symbols module_layout"
> > +fi
> > +
> > +# With CONFIG_LTO_CLANG, LLVM bitcode has not yet been compiled into a binary
> > +# when the .mod files are generated, which means they don't yet contain
> > +# references to certain symbols that will be present in the final binaries.
> > +if [ -n "$CONFIG_LTO_CLANG" ]; then
> > +       # intrinsic functions
> > +       needed_symbols="$needed_symbols memcpy memmove memset"
> > +       # stack protector symbols
> > +       needed_symbols="$needed_symbols __stack_chk_fail __stack_chk_guard"
> > +fi
>
> Thank you for the patch!
>
> Arnd just reported that _mcount is also needed with some
> configurations. Would you mind including that in the next version?
>
> https://lore.kernel.org/r/20210225143456.3829513-1-arnd@kernel.org/

Sure, I can even pick it up
although that patch was not addressed to me or kbuild ML.



-- 
Best Regards
Masahiro Yamada
