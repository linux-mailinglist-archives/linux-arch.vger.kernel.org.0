Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFD05EE5B0
	for <lists+linux-arch@lfdr.de>; Wed, 28 Sep 2022 21:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbiI1Taf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Sep 2022 15:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbiI1Tae (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2022 15:30:34 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF758980F;
        Wed, 28 Sep 2022 12:30:33 -0700 (PDT)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 28SJUIZ0023087;
        Thu, 29 Sep 2022 04:30:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 28SJUIZ0023087
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664393419;
        bh=P+mo1kAnSpuWBcJQBFI24YMS/Mo+9UYb3U5TZ6VU0KQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vCcZf2q3W/WQnJwbZP6Rt3Urp3Eaig7wqUKLSKcsoKbnyfGDC2bYNvYSEZNxdjYhj
         B+5kdUfRebUSLi6j0ddJ/Fli9GMhE4lJ++Tg7wFRx82bcVJNFtEGuHz4YWwwwDWnbo
         0u0GYZyz51QcefmEruDJCD7wIto90IDlmMgw+mICyJhAqp/sCvH7IWtmpu6HsPi5gF
         lrn0w6t4mqFnFGagNXRd7bl0I8KFybo36u2pg1TsYA6OTVXo6c7ZWw1qe3MvjKXxvf
         Tx5JnfIO1kEFWV9ttuftcWWl9QzWBLdXgcINF8s+KMZwQPh0K4vBQbW7Cd9EK0MCCj
         RxfugBfJtQ6Cg==
X-Nifty-SrcIP: [209.85.210.54]
Received: by mail-ot1-f54.google.com with SMTP id cy15-20020a056830698f00b0065c530585afso1115795otb.2;
        Wed, 28 Sep 2022 12:30:18 -0700 (PDT)
X-Gm-Message-State: ACrzQf0aJxqsGwBxJGxueWVz7HIyxLYIhLAFhBRxcpi22flbjbuu/kRq
        w9Yk/ivgm1wCb+iWkISNf+RMPNtBZCNmfp9uKkY=
X-Google-Smtp-Source: AMsMyM5gnuffA1b3nRhl0cvz2YH2ANAIyN8tapXvX58e7uoc6gKZycodp72r+5Den7g8RFUU7B7dKmeXxV/+HCes/4c=
X-Received: by 2002:a05:6830:3115:b0:658:ea61:249c with SMTP id
 b21-20020a056830311500b00658ea61249cmr15615036ots.225.1664393417324; Wed, 28
 Sep 2022 12:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220928063947.299333-1-masahiroy@kernel.org> <20220928063947.299333-4-masahiroy@kernel.org>
In-Reply-To: <20220928063947.299333-4-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 29 Sep 2022 04:29:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNASLf0Jbyfu7HB1qLRbc6-3QeZiw3okb6O+c5YhHA-a_bA@mail.gmail.com>
Message-ID: <CAK7LNASLf0Jbyfu7HB1qLRbc6-3QeZiw3okb6O+c5YhHA-a_bA@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] kbuild: generate KSYMTAB entries by modpost
To:     linux-kbuild@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicolas Pitre <npitre@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 28, 2022 at 3:41 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Commit 7b4537199a4a ("kbuild: link symbol CRCs at final link, removing
> CONFIG_MODULE_REL_CRCS") made modpost output CRCs in the same way
> whether the EXPORT_SYMBOL() is placed in *.c or *.S.
>
> This commit applies a similar approach to the entire data structure of
> EXPORT_SYMBOL() for further cleanups. The EXPORT_SYMBOL() compilation
> is split into two stages.
>
> When a source file is compiled, EXPORT_SYMBOL() is converted into a
> dummy symbol in the .discard.export_symbol section.
>
> For example,
>
>     EXPORT_SYMBOL(foo);
>     EXPORT_SYMBOL_NS_GPL(bar, BAR_NAMESPACE);
>
> will be encoded into the following assembly code:
>
>     .section .discard.export_symbol
>     __export_symbol.foo:
>             .asciz ""
>     .previous
>
>     .section .discard.export_symbol
>     __export_symbol_gpl.bar:
>             .asciz "BAR_NAMESPACE"
>     .previous
>
> They are just markers to tell modpost the name, license, and namespace
> of the symbols. They will be dropped from the final vmlinux and modules
> because the section name starts with ".discard.".
>
> Then, modpost extracts all the information about EXPORT_SYMBOL() from the
> .discard.export_symbol section, and generates C code:
>
>     KSYMTAB_FUNC(foo, "", "");
>     KSYMTAB_FUNC(bar, "_gpl", "BAR_NAMESPACE");
>
> KSYMTAB_FUNC() (or KSYMTAB_DATA() if it is data) is expanded to struct
> kernel_symbol that will be linked to the vmlinux or a module.
>
> With this change, EXPORT_SYMBOL() works in the same way for *.c and *.S
> files, providing the following benefits.
>
> [1] Deprecate EXPORT_DATA_SYMBOL()
>
> In the old days, EXPORT_SYMBOL() was only available in C files. To export
> a symbol in *.S, EXPORT_SYMBOL() was placed in a separate *.c file.
> arch/arm/kernel/armksyms.c is one example written in the classic manner.
>
> Commit 22823ab419d8 ("EXPORT_SYMBOL() for asm") removed this limitation.
> Since then, EXPORT_SYMBOL() can be placed close to the symbol definition
> in *.S files. It was a nice improvement.
>
> However, as that commit mentioned, you need to use EXPORT_DATA_SYMBOL()
> for data objects on some architectures.
>
> In the new approach, modpost checks symbol's type (STT_FUNC or not),
> and outputs KSYMTAB_FUNC() or KSYMTAB_DATA() accordingly.
>
> There are only two users of EXPORT_DATA_SYMBOL:
>
>   EXPORT_DATA_SYMBOL_GPL(empty_zero_page)    (arch/ia64/kernel/head.S)
>   EXPORT_DATA_SYMBOL(ia64_ivt)               (arch/ia64/kernel/ivt.S)
>
> They are transformed as follows and output into .vmlinux.export.c
>
>   KSYMTAB_DATA(empty_zero_page, "_gpl", "");
>   KSYMTAB_DATA(ia64_ivt, "", "");
>
> The other EXPORT_SYMBOL users in ia64 assembly are output as
> KSYMTAB_FUNC().
>
> EXPORT_DATA_SYMBOL() is now deprecated.
>
> [2] merge <linux/export.h> and <asm-generic/export.h>
>
> There are two similar header implementations:
>
>   include/linux/export.h        for .c files
>   include/asm-generic/export.h  for .S files
>
> Ideally, the functionality should be consistent between them, but they
> tend to diverge.
>
> Commit 8651ec01daed ("module: add support for symbol namespaces.") did
> not support the namespace for *.S files.
>
> This commit shifts the essential implementation part to C, which supports
> EXPORT_SYMBOL_NS() for *.S files.
>
> <asm/export.h> and <asm-generic/export.h> will remain as a wrapper of
> <linux/export.h> for a while.
>
> They will be removed after #include <asm/export.h> directives are all
> replaced with #include <linux/export.h>.
>
> [3] Implement CONFIG_TRIM_UNUSED_KSYMS in one-pass algorithm (by a later commit)
>
> When CONFIG_TRIM_UNUSED_KSYMS is enabled, Kbuild recursively traverses
> the directory tree to determine which EXPORT_SYMBOL to trim. If an
> EXPORT_SYMBOL turns out to be unused by anyone, Kbuild begins the
> second traverse, where some source files are recompiled with their
> EXPORT_SYMBOL() tuned into a no-op.
>
> We can do this better now; modpost can selectively emit KSYMTAB entries
> that are really used by modules.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>



After some more tests, I noticed this introduced
false positive warnings:

  ERROR: modpost: phy_init .init.text vmlinux: EXPORT_SYMBOL used for
init symbol. Remove __init or EXPORT_SYMBOL.
  ERROR: modpost: phy_exit .exit.text vmlinux: EXPORT_SYMBOL used for
exit symbol. Remove __exit or EXPORT_SYMBOL.


If I find how to fix it, I will send v4.





-- 
Best Regards
Masahiro Yamada
