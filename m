Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552DD4B0DBD
	for <lists+linux-arch@lfdr.de>; Thu, 10 Feb 2022 13:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241686AbiBJMpv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 10 Feb 2022 07:45:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241647AbiBJMpv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Feb 2022 07:45:51 -0500
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7ACBF48;
        Thu, 10 Feb 2022 04:45:52 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id c36so2922603uae.13;
        Thu, 10 Feb 2022 04:45:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+hZIUujqvuEu4DLoVrRx+zoFH3RE8l04FFsuqOBtXpk=;
        b=7XdvBNnPmpFlNIPF6r0O2jq3fex88k+WAr/yANIAwkl+qU3IdUTJkXuiT+mbXJU/8f
         5TM+ebhMx6fvzcNoEwhpne4K/Wpnl6G4uCci8UYwV9qnuW2D4MIl5lNTtxu2tkm8YOYj
         eSOOVn0ICthNc4LDEmg96YNYw+BmHJ8tT6io+vWpJbldZYpNZwdZsStst3PezlZzuHI2
         4THAn7ExEjQy3ZSEDeSIe9/11dtc+EMwIr4U6WGFINDiB9twSPqiUtg/Hqwm/AepgyXM
         bxrwgMigsMtRBDJ23DPm8Wj6UCAFvNEErsfidvOhpHsc9Az6vjTWfeplt/l4f0GA6m1l
         P1gg==
X-Gm-Message-State: AOAM533QZ2oNYHaGfst6ZvPrHKv7d6kIq23LOz2deDm3OBMOD5hXO4E/
        FTf/P57ujn8lVKncBScEopRQGdvu+qyHhQ==
X-Google-Smtp-Source: ABdhPJwfRWkXPJ8j52OLJfhDNRtW9+RCa9z+PVVrx/HMgb64Qm8I8tQ4BIMF0/oDG5XYBNiSnj7FMg==
X-Received: by 2002:ab0:731a:: with SMTP id v26mr2369382uao.68.1644497151634;
        Thu, 10 Feb 2022 04:45:51 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id l24sm293850vkm.27.2022.02.10.04.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 04:45:51 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id r20so6292703vsn.0;
        Thu, 10 Feb 2022 04:45:51 -0800 (PST)
X-Received: by 2002:a67:a401:: with SMTP id n1mr2193894vse.38.1644497151058;
 Thu, 10 Feb 2022 04:45:51 -0800 (PST)
MIME-Version: 1.0
References: <20220210021129.3386083-1-masahiroy@kernel.org> <20220210021129.3386083-2-masahiroy@kernel.org>
In-Reply-To: <20220210021129.3386083-2-masahiroy@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 10 Feb 2022 13:45:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUgz_5OLStQ+XO3k-qmb=edYUBZPb6GF369Drk0JF1paA@mail.gmail.com>
Message-ID: <CAMuHMdUgz_5OLStQ+XO3k-qmb=edYUBZPb6GF369Drk0JF1paA@mail.gmail.com>
Subject: Re: [PATCH 1/6] signal.h: add linux/signal.h and asm/signal.h to UAPI
 compile-test coverage
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 10, 2022 at 3:36 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> linux/signal.h and asm/signal.h are currently excluded from the UAPI
> compile-test because of the errors like follows:
>
>     HDRTEST usr/include/asm/signal.h
>   In file included from <command-line>:
>   ./usr/include/asm/signal.h:103:9: error: unknown type name ‘size_t’
>     103 |         size_t ss_size;
>         |         ^~~~~~
>
> The errors can be fixed by replacing size_t with __kernel_size_t.
>
> Then, remove the no-header-test entries from user/include/Makefile.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

>  arch/m68k/include/uapi/asm/signal.h    | 2 +-

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
