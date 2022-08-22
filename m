Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97ED59BDC8
	for <lists+linux-arch@lfdr.de>; Mon, 22 Aug 2022 12:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbiHVKqZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Aug 2022 06:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbiHVKqH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Aug 2022 06:46:07 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B933121A;
        Mon, 22 Aug 2022 03:46:06 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id j6so7488738qkl.10;
        Mon, 22 Aug 2022 03:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1JBBO1Gon6h+53jLetxo2erRdLEP73QBoztcgKCnoH0=;
        b=SHNNDQgGLFHMoprNZ8RBRgbrsVmPUDYGa/CquB35xtF/i+lxhssclR7cjFrzNWs7gq
         1xxO4uG9f+wwwT65w92ktVAi4DOxSbUmAfpofkt+oGZC8NNRTE32XuOQaApLMI7EivGp
         ZELhtfEaasmSD1PLhjzc2HCz+SvJpEyAJ+YkwtQk2+IOqWYOa2vF0hm8izhBmd4hit+6
         eYFOGUHAAk3eU2z29NBjjd81Bmje4f1HVhFN5fZg/xcUnz9D/ABANREEXp2boRyAeCMv
         lnypZ2cHjTlmURHkddCriTZhPye5qLyj0TWZF60vGNfGv5Gl7/NOqVyLLem2dpgfm7db
         oe3g==
X-Gm-Message-State: ACgBeo219vGkbx+BZkBIl7uvPbsxz8sCpb1ZlwvZ0ezBCHoO7B5ePG1j
        i2XzR2wJDLn9w0hYDfb9Mqy4tkBbxOYaPg==
X-Google-Smtp-Source: AA6agR43/DF+QHVs/gjcNYpfs/qTULGMZ5RqXQ2tScC2xOSyT21xHyNMUPcvIviqn31tharS1g/VWw==
X-Received: by 2002:a05:620a:408a:b0:6bb:58dc:1e66 with SMTP id f10-20020a05620a408a00b006bb58dc1e66mr12493251qko.707.1661165164918;
        Mon, 22 Aug 2022 03:46:04 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id v16-20020a05620a0f1000b006b97151d2b3sm10725387qkl.67.2022.08.22.03.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 03:46:04 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-33387bf0c4aso280418437b3.11;
        Mon, 22 Aug 2022 03:46:04 -0700 (PDT)
X-Received: by 2002:a25:e004:0:b0:695:d8b6:57e7 with SMTP id
 x4-20020a25e004000000b00695d8b657e7mr510074ybg.380.1661165164007; Mon, 22 Aug
 2022 03:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220821113512.2056409-1-mail@conchuod.ie> <CAMuHMdV_dpijX7YqSR+24wWDQr4roi7EBm1nbhJuWkoidAcCng@mail.gmail.com>
 <ac6eacdf-81ad-42ec-3f3e-2db4c5ef76cf@microchip.com>
In-Reply-To: <ac6eacdf-81ad-42ec-3f3e-2db4c5ef76cf@microchip.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 22 Aug 2022 12:45:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWCXOqNjcK1ZrFA3jUtzv+PUqfEr-7PyZNg38-X+SG5Qw@mail.gmail.com>
Message-ID: <CAMuHMdWCXOqNjcK1ZrFA3jUtzv+PUqfEr-7PyZNg38-X+SG5Qw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add an asm-generic cpuinfo_op declaration
To:     Conor Dooley <Conor.Dooley@microchip.com>
Cc:     Conor Dooley <mail@conchuod.ie>, Michal Simek <monstr@monstr.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Conor,

On Mon, Aug 22, 2022 at 12:05 PM <Conor.Dooley@microchip.com> wrote:
> On 22/08/2022 10:36, Geert Uytterhoeven wrote:
> > On Sun, Aug 21, 2022 at 1:36 PM Conor Dooley <mail@conchuod.ie> wrote:
> >>   arch/microblaze/include/asm/processor.h | 2 +-
> >>   arch/riscv/include/asm/processor.h      | 1 +
> >>   arch/s390/include/asm/processor.h       | 2 +-
> >>   arch/sh/include/asm/processor.h         | 2 +-
> >>   arch/sparc/include/asm/cpudata.h        | 3 +--
> >>   arch/x86/include/asm/processor.h        | 2 +-
> >>   include/asm-generic/processor.h         | 7 +++++++
> >>   7 files changed, 13 insertions(+), 6 deletions(-)
> >>   create mode 100644 include/asm-generic/processor.h
> >
> > I was a bit surprised not to find fs/proc/cpuinfo.c in the diffstat
> > above. That file already has an external declaration for cpuinfo_op,
> > and uses it rather unconditionally (that is, if CONFIG_PROC_FS=y)
> > on all architectures.
> >
> > So I think you can just move that to include/linux/processor.h, include
> > the latter everywhere, and drop all architecture-specific copies.
>
> This is the sort of thing I was really hoping to hear, so fine by
> me.. When you say "everywhere", I assume you mean in every arch
> and not just the ones listed here that already have it in an arch
> specific header?

Yes, above every user, to silence the sparse "foo was not
declared. Should it be static?" warnings.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
