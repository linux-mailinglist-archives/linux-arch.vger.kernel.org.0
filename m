Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E894695DFB
	for <lists+linux-arch@lfdr.de>; Tue, 14 Feb 2023 10:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjBNJEy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Feb 2023 04:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjBNJEd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Feb 2023 04:04:33 -0500
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201C223DA8;
        Tue, 14 Feb 2023 01:03:48 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a3so4334896ejb.3;
        Tue, 14 Feb 2023 01:03:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UXpQWLOfRB0cj7wBmiF/GaVLxY5OIU6uD4JxDn3mdPQ=;
        b=bv6SyqSt2ZAR9e4z+Xqs/vAo36xnkeAf5IfoRtXPIhtqTZNrf1R1bw6YlwFQ4JSye3
         wkh98QGI5Xu3SIzHQIfkB4AnPiy6OlbU4KuVDMA+aWVg42IPfRcTD12M9yF58AvUM5qD
         Gey7yBHL+ITL2YYBsP2yoP9Qok1qlICoWm3f9EVoWM5qoJ2EkndbmUfroZC/Ku6n4MJo
         EB/g02yNHTBkIY3xOiwkesMoWO61zd+f4ne35flzVZkev1c/4GBUHlu1wzb1sTBsSWl4
         mRZCbUhXxgsP/XKHcJOIGwhNGVVldTc5u9VgCvfwoLa8NaRavqegYvC1xp5tKCWFxq3N
         0DIw==
X-Gm-Message-State: AO0yUKWXeIbA5+99iVEE3Avnhwr4eK1n+kroqquBaCgdXlA5BOKEyY9f
        bTxVA8qrLOcBoP6G80ctppWLUz+0EuY5sehU
X-Google-Smtp-Source: AK7set8M+bIJlsf0efmGm4s8T7WdSb8sFmIkwjlMS3n/JJaAbw6h3ovvYG8xrWBRs+SSpaWAE+sd+Q==
X-Received: by 2002:a17:906:ad8e:b0:877:ef84:c7de with SMTP id la14-20020a170906ad8e00b00877ef84c7demr2012147ejb.61.1676365425263;
        Tue, 14 Feb 2023 01:03:45 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id n8-20020a1709065e0800b0087fa83790d8sm8073233eju.13.2023.02.14.01.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 01:03:45 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id c1so12534200edt.4;
        Tue, 14 Feb 2023 01:03:45 -0800 (PST)
X-Received: by 2002:a05:651c:4ca:b0:28e:54f:b187 with SMTP id
 e10-20020a05651c04ca00b0028e054fb187mr203743lji.5.1676365112291; Tue, 14 Feb
 2023 00:58:32 -0800 (PST)
MIME-Version: 1.0
References: <20230214074925.228106-1-alexghiti@rivosinc.com> <Y+tIl07KOOrGZ2Et@osiris>
In-Reply-To: <Y+tIl07KOOrGZ2Et@osiris>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Feb 2023 09:58:17 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVG4=UmKDa17dys9e3iGM75u4+13nQVyjMHK--aD6WKfw@mail.gmail.com>
Message-ID: <CAMuHMdVG4=UmKDa17dys9e3iGM75u4+13nQVyjMHK--aD6WKfw@mail.gmail.com>
Subject: Re: [PATCH v3 00/24] Remove COMMAND_LINE_SIZE from uapi
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Heiko,

On Tue, Feb 14, 2023 at 9:39 AM Heiko Carstens <hca@linux.ibm.com> wrote:
> On Tue, Feb 14, 2023 at 08:49:01AM +0100, Alexandre Ghiti wrote:
> > This all came up in the context of increasing COMMAND_LINE_SIZE in the
> > RISC-V port.  In theory that's a UABI break, as COMMAND_LINE_SIZE is the
> > maximum length of /proc/cmdline and userspace could staticly rely on
> > that to be correct.
> >
> > Usually I wouldn't mess around with changing this sort of thing, but
> > PowerPC increased it with a5980d064fe2 ("powerpc: Bump COMMAND_LINE_SIZE
> > to 2048").  There are also a handful of examples of COMMAND_LINE_SIZE
> > increasing, but they're from before the UAPI split so I'm not quite sure
> > what that means: e5a6a1c90948 ("powerpc: derive COMMAND_LINE_SIZE from
> > asm-generic"), 684d2fd48e71 ("[S390] kernel: Append scpdata to kernel
> > boot command line"), 22242681cff5 ("MIPS: Extend COMMAND_LINE_SIZE"),
> > and 2b74b85693c7 ("sh: Derive COMMAND_LINE_SIZE from
> > asm-generic/setup.h.").
> >
> > It seems to me like COMMAND_LINE_SIZE really just shouldn't have been
> > part of the uapi to begin with, and userspace should be able to handle
> > /proc/cmdline of whatever length it turns out to be.  I don't see any
> > references to COMMAND_LINE_SIZE anywhere but Linux via a quick Google
> > search, but that's not really enough to consider it unused on my end.
> >
> > The feedback on the v1 seemed to indicate that COMMAND_LINE_SIZE really
> > shouldn't be part of uapi, so this now touches all the ports.  I've
> > tried to split this all out and leave it bisectable, but I haven't
> > tested it all that aggressively.
>
> Just to confirm this assumption a bit more: that's actually the same
> conclusion that we ended up with when commit 3da0243f906a ("s390: make
> command line configurable") went upstream.

Commit 622021cd6c560ce7 ("s390: make command line configurable"),
I assume?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
