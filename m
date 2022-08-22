Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0610D59BCF3
	for <lists+linux-arch@lfdr.de>; Mon, 22 Aug 2022 11:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbiHVJhI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Aug 2022 05:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbiHVJhG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Aug 2022 05:37:06 -0400
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFB631222;
        Mon, 22 Aug 2022 02:37:05 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id e4so7691203qvr.2;
        Mon, 22 Aug 2022 02:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=4HGc3LZLIVD8kqIdt1raEGvcbUqauzF4BNbgPe7E/m4=;
        b=C7ccB4CycVRJv72vSwLjvRDuXYNwbRaO9VvHK4Xdaerjtsy4KeGOjp0aFh770m4nu1
         HALlZR9QvNJfiOsRO3ho0/XJxdEYmEuFUShdODqhABDdZcxYk/KvOKnZlG6CJ1GmMTp3
         oM4oX2n3BcKGRICoPwzO9nGDIilquNXt6+p1eTgIRmWsjeYDOqOH2VVEkherztqYVDhD
         +kw9r0HAnQPafSAjUZ057D5EgDkGASae9QaIvs4La9CVKl3RNZapt493DCSm0VdhUHNE
         bxXF+YybYaLtcqp5vDLOlI6jVBm+FpsvLDMvoUOgp0JGht+638XGGiP7+UdEzlpkUWpI
         tEig==
X-Gm-Message-State: ACgBeo389od51o0C2+KWag4vY2tB6lEGtxdqr7uVjEHBp6Y5HJrbpI7v
        bnrj1hY1sZKZAQ/mfGrdst/oH2HEXhaEgA==
X-Google-Smtp-Source: AA6agR6GmlbC2f4z7hgwx5WbGHXNk19XFqFpchxiFKoaQl4FdGMGTS/MiKuCJrTmNkl/Lg7uhP4Jig==
X-Received: by 2002:a0c:b31a:0:b0:473:8062:b1b4 with SMTP id s26-20020a0cb31a000000b004738062b1b4mr14902520qve.85.1661161024315;
        Mon, 22 Aug 2022 02:37:04 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id x2-20020ae9e642000000b006b5e50057basm10169314qkl.95.2022.08.22.02.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 02:37:03 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-3376851fe13so243520667b3.6;
        Mon, 22 Aug 2022 02:37:03 -0700 (PDT)
X-Received: by 2002:a25:cbcf:0:b0:695:2d3b:366 with SMTP id
 b198-20020a25cbcf000000b006952d3b0366mr12458894ybg.365.1661161022925; Mon, 22
 Aug 2022 02:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220821113512.2056409-1-mail@conchuod.ie>
In-Reply-To: <20220821113512.2056409-1-mail@conchuod.ie>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 22 Aug 2022 11:36:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV_dpijX7YqSR+24wWDQr4roi7EBm1nbhJuWkoidAcCng@mail.gmail.com>
Message-ID: <CAMuHMdV_dpijX7YqSR+24wWDQr4roi7EBm1nbhJuWkoidAcCng@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add an asm-generic cpuinfo_op declaration
To:     Conor Dooley <mail@conchuod.ie>
Cc:     Michal Simek <monstr@monstr.eu>,
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
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
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

On Sun, Aug 21, 2022 at 1:36 PM Conor Dooley <mail@conchuod.ie> wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> RISC-V is missing a prototype for cpuinfo_op. Rather than adding yet
> another `extern const struct seq_operations cpuinfo_op;` to an arch
> specific header file, create an asm-generic variant and migrate the
> existing arch variants there too. Obv. there are other archs that use
> cpuinfo_op but don't declare it and surely also have the same warning?
> I went for the minimum change here, but would be perfectly happy to
> extend the change to all archs if this change is worthwhile. Or just
> make a header in arch/riscv, any of the three work for me!
>
> If this isn't the approach I should've gone for, any direction would
> be great :) I tried pushing this last weekend to get LKP to test it but
> I got neither a build success nor a build failure email from it, so
> I figured I may as well just send the patches..
>
> I wasn't too sure if this could be a single patch, so I split it out
> into a patch fixing the issue on RISC-V & copy-paste patches for each
> arch that I moved.

Thanks for your series!

> Conor Dooley (6):
>   asm-generic: add a cpuinfo_ops definition in shared code
>   microblaze: use the asm-generic version of cpuinfo_op
>   s390: use the asm-generic version of cpuinfo_op
>   sh: use the asm-generic version of cpuinfo_op
>   sparc: use the asm-generic version of cpuinfo_op
>   x86: use the asm-generic version of cpuinfo_op
>
>  arch/microblaze/include/asm/processor.h | 2 +-
>  arch/riscv/include/asm/processor.h      | 1 +
>  arch/s390/include/asm/processor.h       | 2 +-
>  arch/sh/include/asm/processor.h         | 2 +-
>  arch/sparc/include/asm/cpudata.h        | 3 +--
>  arch/x86/include/asm/processor.h        | 2 +-
>  include/asm-generic/processor.h         | 7 +++++++
>  7 files changed, 13 insertions(+), 6 deletions(-)
>  create mode 100644 include/asm-generic/processor.h

I was a bit surprised not to find fs/proc/cpuinfo.c in the diffstat
above. That file already has an external declaration for cpuinfo_op,
and uses it rather unconditionally (that is, if CONFIG_PROC_FS=y)
on all architectures.

So I think you can just move that to include/linux/processor.h, include
the latter everywhere, and drop all architecture-specific copies.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
