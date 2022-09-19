Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82195BCBC9
	for <lists+linux-arch@lfdr.de>; Mon, 19 Sep 2022 14:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiISM3E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Sep 2022 08:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiISM3D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Sep 2022 08:29:03 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1969115FF4;
        Mon, 19 Sep 2022 05:29:03 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id j10so17608118qtv.4;
        Mon, 19 Sep 2022 05:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=FbhO57AaIFpfTc6EAzSsAME+3Gcdi6/bOYBJsrWkC7o=;
        b=maRjSF8q2ZhoES3aHJR2lQH0gg8LKiVkYylXG0csTkMbKolSP82hJRkfl68wGMPzTt
         FmTPB3+9nJCAkDOGIyzbc3Jynx0lMFuH2z0JUjFpk5Wv8iaB4ru98F6lnF27XJMKjRSj
         eM5ZdJztAZ91p58nYmx0IlVm2OyPJeQXnyxG6FDZEyXyTSaBuLgQVywQZMTNfElZDuE2
         aSjAb93VLbS3zJoDToFrh7zr+P78K/YxZA3L9GcZKNOMPPCQsBEdosmp7zBbM8Kjij1y
         mRqkTThwDOPAWf7SWI/lJ6DkDyRxxfQMpH+ubcq45aEEkXAX+puOgeIxtfHRf5AOJKv6
         QT/Q==
X-Gm-Message-State: ACrzQf0xQKqHrAGEUBk2AaGs04AMSUsMAnngu612a5BMPTUe+bHraApK
        9PU3Yp4qugRgq2EpvjAYhb0n/dULiEg+iA==
X-Google-Smtp-Source: AMsMyM55ZR/IUkKVRdgLg6L3Ks/uuOSdBLGdEC+8NkfBYNTZ5AhtMsf23Rp/sBpMG/OFhNSHTAyXEg==
X-Received: by 2002:a05:622a:183:b0:35c:c65a:61e7 with SMTP id s3-20020a05622a018300b0035cc65a61e7mr14406550qtw.371.1663590542038;
        Mon, 19 Sep 2022 05:29:02 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id bb18-20020a05622a1b1200b0035bb84a4150sm10363491qtb.71.2022.09.19.05.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 05:29:01 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 125so20974644ybt.12;
        Mon, 19 Sep 2022 05:29:01 -0700 (PDT)
X-Received: by 2002:a25:8e84:0:b0:696:466c:baa with SMTP id
 q4-20020a258e84000000b00696466c0baamr13228969ybl.604.1663590541439; Mon, 19
 Sep 2022 05:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220906061313.1445810-1-masahiroy@kernel.org>
 <20220906061313.1445810-8-masahiroy@kernel.org> <CAMuHMdUpY92WGNqTOV0-jaB+q1q0nS4wxkhrC8jb-uGU9KbogQ@mail.gmail.com>
 <CAK7LNATqy4DCAB2LuK7dpiYDjRciXHE_E6gAvHHfvYAfe9CqGg@mail.gmail.com>
In-Reply-To: <CAK7LNATqy4DCAB2LuK7dpiYDjRciXHE_E6gAvHHfvYAfe9CqGg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 19 Sep 2022 14:28:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX2+q4m7c8Ph2CLoOFdfMGD+UgbYmTjdX8bgcfqcU4aOA@mail.gmail.com>
Message-ID: <CAMuHMdX2+q4m7c8Ph2CLoOFdfMGD+UgbYmTjdX8bgcfqcU4aOA@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] kbuild: use obj-y instead extra-y for objects
 placed at the head
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Yamada-san,

On Mon, Sep 19, 2022 at 2:18 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> On Mon, Sep 19, 2022 at 5:10 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Sep 6, 2022 at 8:15 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > The objects placed at the head of vmlinux need special treatments:
> > >
> > >  - arch/$(SRCARCH)/Makefile adds them to head-y in order to place
> > >    them before other archives in the linker command line.
> > >
> > >  - arch/$(SRCARCH)/kernel/Makefile adds them to extra-y instead of
> > >    obj-y to avoid them going into built-in.a.
> > >
> > > This commit gets rid of the latter.
> > >
> > > Create vmlinux.a to collect all the objects that are unconditionally
> > > linked to vmlinux. The objects listed in head-y are moved to the head
> > > of vmlinux.a by using 'ar m'.
> > >
> > > With this, arch/$(SRCARCH)/kernel/Makefile can consistently use obj-y
> > > for builtin objects.
> > >
> > > There is no *.o that is directly linked to vmlinux. Drop unneeded code
> > > in scripts/clang-tools/gen_compile_commands.py.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Thanks for the report.
>
> I will squash the following:
>
>
>
> diff --git a/arch/m68k/kernel/Makefile b/arch/m68k/kernel/Makefile
> index 1755e6cd309f..af015447dfb4 100644
> --- a/arch/m68k/kernel/Makefile
> +++ b/arch/m68k/kernel/Makefile
> @@ -16,7 +16,7 @@ obj-$(CONFIG_SUN3X)   := head.o
>  obj-$(CONFIG_VIRT)     := head.o
>  obj-$(CONFIG_SUN3)     := sun3-head.o
>
> -obj-y  := entry.o irq.o module.o process.o ptrace.o
> +obj-y  += entry.o irq.o module.o process.o ptrace.o
>  obj-y  += setup.o signal.o sys_m68k.o syscalltable.o time.o traps.o
>
>  obj-$(CONFIG_MMU_MOTOROLA) += ints.o vectors.o

Thank you, that fixed the build.

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
