Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13A4547736
	for <lists+linux-arch@lfdr.de>; Sat, 11 Jun 2022 20:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiFKSwX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 11 Jun 2022 14:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiFKSwX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 11 Jun 2022 14:52:23 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35D051E4F;
        Sat, 11 Jun 2022 11:52:21 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 25BIpjEH011672;
        Sun, 12 Jun 2022 03:51:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 25BIpjEH011672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654973506;
        bh=zLJrWba6O8CUY1xuhJ6ivmej01hRP1bnvnpSH4ux26s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IXWcwesD/nxGzxvQzIZaK04u2cwvrsGhABvGesycZYewNpw+z0+gWUxi2TOxUQ19k
         y/tzB1FdKBUsi9v4nEZsxNwLg8ix/3jK7M0THwPnwnVT6NPD3M62fFp9wlrW448PKj
         f9QoZ8NJr6ShNqrSg5MdFlNoZqS45nXJcwidROxyWbwVP8mYOF9TzE0h+FrubuntHd
         CdrD3c18BNoPUkMoaQl2W7/rU5UQ+7XINi8TE+2mo71z1sVd0fqSqi0iUTK5e+qa0a
         hmJ2nzpG7KRI8oIF0sUIeMmOZ2xb2BF1OfauKl3IYsFd4omsA7Z7pzpATAuUicyyKY
         n/JkAHF5/GeaA==
X-Nifty-SrcIP: [209.85.128.42]
Received: by mail-wm1-f42.google.com with SMTP id i17-20020a7bc951000000b0039c4760ec3fso2912177wml.0;
        Sat, 11 Jun 2022 11:51:46 -0700 (PDT)
X-Gm-Message-State: AOAM531IRHhiCio09WHac0izbzig2U/VwhyxOVFco6vEwT6MrXXBrAGc
        CVoNTqve4N3gvApwxdTt53k+i6guSqbYGAgqgbQ=
X-Google-Smtp-Source: ABdhPJx2/YzshhqCPp6iIKJydx/cOynVTXAgfqxHzDO3RhquZXaR7ESm5HK7cqGXTrNRCf8aUCzFm+cog/HiCeV4CdA=
X-Received: by 2002:a7b:ce04:0:b0:394:1f46:213 with SMTP id
 m4-20020a7bce04000000b003941f460213mr5884955wmc.157.1654973504935; Sat, 11
 Jun 2022 11:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220610183236.1272216-1-masahiroy@kernel.org>
In-Reply-To: <20220610183236.1272216-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 12 Jun 2022 03:51:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNARDLgNDtneabZezc3GAcQ4tZJPyK5+yKqsSuXDb6f+jXA@mail.gmail.com>
Message-ID: <CAK7LNARDLgNDtneabZezc3GAcQ4tZJPyK5+yKqsSuXDb6f+jXA@mail.gmail.com>
Subject: Re: [PATCH 0/7] Unify <linux/export.h> and <asm/export.h>, remove EXPORT_DATA_SYMBOL()
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Nicolas Pitre <npitre@baylibre.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alessio Igor Bogani <abogani@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Joe Perches <joe@perches.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jun 11, 2022 at 3:34 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
>
> This patch set refactors EXPORT_SYMBOL, <linux/export.h> and <asm/export.h>.
>
> You can still put EXPORT_SYMBOL() in *.S file, very close to the definition,
> but you do not need to care about whether it is a function or a data.
> Remove EXPORT_DATA_SYMBOL().
>


Sorry, please ignore this patch set.

With further testing for ia64,
I realized it was not working.





>
> Masahiro Yamada (7):
>   modpost: fix section mismatch check for exported init/exit sections
>   modpost: put get_secindex() call inside sec_name()
>   kbuild: generate struct kernel_symbol by modpost
>   ia64,export.h: replace EXPORT_DATA_SYMBOL* with EXPORT_SYMBOL*
>   checkpatch: warn if <asm/export.h> is included
>   modpost: merge sym_update_namespace() into sym_add_exported()
>   modpost: use null string instead of NULL pointer for default namespace
>
>  arch/ia64/include/asm/Kbuild    |   1 +
>  arch/ia64/include/asm/export.h  |   3 -
>  arch/ia64/kernel/head.S         |   2 +-
>  arch/ia64/kernel/ivt.S          |   2 +-
>  include/asm-generic/export.h    |  83 +------------------
>  include/linux/export-internal.h |  44 ++++++++++
>  include/linux/export.h          |  97 ++++++++--------------
>  kernel/module/internal.h        |  12 +++
>  kernel/module/main.c            |   1 -
>  scripts/Makefile.build          |   8 +-
>  scripts/check-local-export      |   4 +-
>  scripts/checkpatch.pl           |   7 ++
>  scripts/mod/modpost.c           | 139 +++++++++++++++++---------------
>  scripts/mod/modpost.h           |   1 +
>  14 files changed, 182 insertions(+), 222 deletions(-)
>  delete mode 100644 arch/ia64/include/asm/export.h
>
> --
> 2.32.0
>


-- 
Best Regards
Masahiro Yamada
