Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D5E5BDDB0
	for <lists+linux-arch@lfdr.de>; Tue, 20 Sep 2022 08:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiITG4m convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 20 Sep 2022 02:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiITG4k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Sep 2022 02:56:40 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296C75EDC2;
        Mon, 19 Sep 2022 23:56:39 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id a20so1080946qtw.10;
        Mon, 19 Sep 2022 23:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=jnB/DbrbGanbxVwCjd/Ml8VBjC8cTxJXPqA4S/aHfpE=;
        b=n3FlpmJHbWKDiWPnCuS9WndvYCjqD2D5AqnbX8XU/2CwawPRfS5/8hslhrwDcS3cUu
         NehdqU/7ee7V95hHdT7ghw14f33EVoH+SmdkJFrUJp0SRGj/OvLbUx76p4haTfAXZmpR
         TYKkpkzjclzhme3417BCXtOYX5XlOgs9W2YhowpauyqV3eFLz2BykuYH3Vt3fEcJ1wk1
         sSIc9uyUM1BDR6nBXUWtH2eZqqjxRwn05AS4+P2ilbbqpAgM7Iw3WAtr7eH0+ibiy+N6
         w5fFzxiiTdz4Cjmjf9H+T4FQtSVkYKanEyOR1Ym9t4bfQNl+vHKM5mLw6RI3G+DkIo8B
         7i/g==
X-Gm-Message-State: ACrzQf2muwLwbbJwhAwUjIlpYMmuzI70PVnR+56V/gFAZhTuBmQMdIqK
        ljpvwjQ4d3mPrymOwNf0hTdYtBUP6d+U4g==
X-Google-Smtp-Source: AMsMyM5FqYt8OOxPbMGEsrFS7bqntT3+t0AdnjIRq9M3N8yEHYbDFwLyw3zmUNgv9ogpcN6sZV14qg==
X-Received: by 2002:a05:622a:1189:b0:35b:b923:3667 with SMTP id m9-20020a05622a118900b0035bb9233667mr17971066qtk.165.1663656998011;
        Mon, 19 Sep 2022 23:56:38 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id fx9-20020a05622a4ac900b003434e47515csm426025qtb.7.2022.09.19.23.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 23:56:37 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id c9so2038880ybf.5;
        Mon, 19 Sep 2022 23:56:37 -0700 (PDT)
X-Received: by 2002:a25:3746:0:b0:6b1:4a12:b2d5 with SMTP id
 e67-20020a253746000000b006b14a12b2d5mr15187723yba.89.1663656997347; Mon, 19
 Sep 2022 23:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220906061313.1445810-1-masahiroy@kernel.org>
 <20220906061313.1445810-8-masahiroy@kernel.org> <20220919225053.GA769506@roeck-us.net>
In-Reply-To: <20220919225053.GA769506@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 20 Sep 2022 08:56:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUxrXgJ7HHgk1vSyg6_S8TN3RvEW=QNgH9U0UueM41N-Q@mail.gmail.com>
Message-ID: <CAMuHMdUxrXgJ7HHgk1vSyg6_S8TN3RvEW=QNgH9U0UueM41N-Q@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] kbuild: use obj-y instead extra-y for objects
 placed at the head
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Günter,

On Tue, Sep 20, 2022 at 12:59 AM Guenter Roeck <linux@roeck-us.net> wrote:
> On Tue, Sep 06, 2022 at 03:13:12PM +0900, Masahiro Yamada wrote:
> > The objects placed at the head of vmlinux need special treatments:
> >
> >  - arch/$(SRCARCH)/Makefile adds them to head-y in order to place
> >    them before other archives in the linker command line.
> >
> >  - arch/$(SRCARCH)/kernel/Makefile adds them to extra-y instead of
> >    obj-y to avoid them going into built-in.a.
> >
> > This commit gets rid of the latter.
> >
> > Create vmlinux.a to collect all the objects that are unconditionally
> > linked to vmlinux. The objects listed in head-y are moved to the head
> > of vmlinux.a by using 'ar m'.
> >
> > With this, arch/$(SRCARCH)/kernel/Makefile can consistently use obj-y
> > for builtin objects.
> >
> > There is no *.o that is directly linked to vmlinux. Drop unneeded code
> > in scripts/clang-tools/gen_compile_commands.py.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Where does this R-b come from? It was not present in Yamada-san's
posting. Added by b4?

> The following build failure is seen when building m68k:defconfig in
> next-20220919.

[...]

> # first bad commit: [6676e2cdd7c339dc40331faccbaac1112d2c1d78] kbuild: use obj-y instead extra-y for objects placed at the head

I did provide my R-b on Yamada-san's fix for this issue, which was
sent later in this thread.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
