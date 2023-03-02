Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CECA6A801F
	for <lists+linux-arch@lfdr.de>; Thu,  2 Mar 2023 11:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjCBKoj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 2 Mar 2023 05:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCBKoi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2023 05:44:38 -0500
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BB923326;
        Thu,  2 Mar 2023 02:44:37 -0800 (PST)
Received: by mail-qv1-f45.google.com with SMTP id y12so11315786qvt.8;
        Thu, 02 Mar 2023 02:44:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHoXp6+7/Ivp8TZOu6tqpc5Wq/dN7ibmjBTE7vH9gt0=;
        b=V1w26lejq4etoWpdjRY/N7vXwkU110xRR9vdNWXocuxDEh2is7qpuXCHuRloLmACRh
         h3b7JmXpaW2JOggzAUGpXdulqFqKYuTDdpD5a+ixdjxb6RmfmXWVTTIYpDTvBDlcMsN+
         g81U3YIEI/qN+rzX6bhqVqkXBP0CCOIxRdYFXNH7TQA6Wf/sw2U50d0wePg7UTcQIMf9
         /dmhUPJjP70l9a0UsLFbxOwBu1Ry1Npa/rxatcufqfA7WxF7WNHL2P0j6bmBbGXGgmLN
         3ehcpQAnk+tMFMBEgLdfB+m8JSbhgA+NXsJBnK0yfQYsJNId8p56t+vEOM1pEmXMXult
         Q7sg==
X-Gm-Message-State: AO0yUKWesPCXDtM72VOcDEJjUdNCKlcbn3QW5FYLbdrdZQAQLrf4jhwM
        +xZePTsU5Q06ebeD9xNrItnWKHtZfYV/dA==
X-Google-Smtp-Source: AK7set+Pcbf+kbzASKr813lGTl/GIFWvlPxYYKF5wdNQqgW64s5FkeNDQx4sNN0YJFijJlHDVvILkA==
X-Received: by 2002:a05:6214:2a4a:b0:56e:fb4c:c1a5 with SMTP id jf10-20020a0562142a4a00b0056efb4cc1a5mr17866966qvb.18.1677753876295;
        Thu, 02 Mar 2023 02:44:36 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id bs17-20020a05620a471100b00706b09b16fasm10789131qkb.11.2023.03.02.02.44.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 02:44:35 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-536bf92b55cso418923057b3.12;
        Thu, 02 Mar 2023 02:44:34 -0800 (PST)
X-Received: by 2002:a5b:1cf:0:b0:a43:52fe:c36f with SMTP id
 f15-20020a5b01cf000000b00a4352fec36fmr4318975ybp.7.1677753853997; Thu, 02 Mar
 2023 02:44:13 -0800 (PST)
MIME-Version: 1.0
References: <20230302093539.372962-1-alexghiti@rivosinc.com>
 <CAMuHMdVC99kFpS9vL+HEqbXdDRMKVSW_t21X1p37d0oQufxKLw@mail.gmail.com> <c0dd1a6e-8e8e-5cdb-bc92-755462704edf@ghiti.fr>
In-Reply-To: <c0dd1a6e-8e8e-5cdb-bc92-755462704edf@ghiti.fr>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 2 Mar 2023 11:44:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVSJADwTSkOD2mG2yU0XeFd0QAUjojQDz5phWhkRcLGOg@mail.gmail.com>
Message-ID: <CAMuHMdVSJADwTSkOD2mG2yU0XeFd0QAUjojQDz5phWhkRcLGOg@mail.gmail.com>
Subject: Re: [PATCH v4 00/24] Remove COMMAND_LINE_SIZE from uapi
To:     Alexandre Ghiti <alex@ghiti.fr>
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
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Alex,

On Thu, Mar 2, 2023 at 11:09 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
> On 3/2/23 10:47, Geert Uytterhoeven wrote:
> > On Thu, Mar 2, 2023 at 10:35 AM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
> >> This all came up in the context of increasing COMMAND_LINE_SIZE in the
> >> RISC-V port.  In theory that's a UABI break, as COMMAND_LINE_SIZE is the
> >> maximum length of /proc/cmdline and userspace could staticly rely on
> >> that to be correct.
> >>
> >> Usually I wouldn't mess around with changing this sort of thing, but
> >> PowerPC increased it with a5980d064fe2 ("powerpc: Bump COMMAND_LINE_SIZE
> >> to 2048").  There are also a handful of examples of COMMAND_LINE_SIZE
> >> increasing, but they're from before the UAPI split so I'm not quite sure
> >> what that means: e5a6a1c90948 ("powerpc: derive COMMAND_LINE_SIZE from
> >> asm-generic"), 684d2fd48e71 ("[S390] kernel: Append scpdata to kernel
> >> boot command line"), 22242681cff5 ("MIPS: Extend COMMAND_LINE_SIZE"),
> >> and 2b74b85693c7 ("sh: Derive COMMAND_LINE_SIZE from
> >> asm-generic/setup.h.").
> >>
> >> It seems to me like COMMAND_LINE_SIZE really just shouldn't have been
> >> part of the uapi to begin with, and userspace should be able to handle
> >> /proc/cmdline of whatever length it turns out to be.  I don't see any
> >> references to COMMAND_LINE_SIZE anywhere but Linux via a quick Google
> >> search, but that's not really enough to consider it unused on my end.
> >>
> >> This issue was already considered in s390 and they reached the same
> >> conclusion in commit 622021cd6c56 ("s390: make command line
> >> configurable").
> >>
> >> The feedback on the v1 seemed to indicate that COMMAND_LINE_SIZE really
> >> shouldn't be part of uapi, so this now touches all the ports.  I've
> >> tried to split this all out and leave it bisectable, but I haven't
> >> tested it all that aggressively.
> >>
> >> Changes since v3 <https://lore.kernel.org/all/20230214074925.228106-1-alexghiti@rivosinc.com/>:
> >> * Added RB/AB
> >> * Added a mention to commit 622021cd6c56 ("s390: make command line
> >>    configurable") in the cover letter
> > Thanks for the update!
> >
> >   Apparently you forgot to add your own SoB?
>
> I do not know, should I? Palmer did all the work, I only fixed 3 minor
> things

If you are picking up patches, and submitting them to someone else
for upstream inclusion, you should add your own SoB.
https://elixir.bootlin.com/linux/latest/source/Documentation/process/submitting-patches.rst#L419

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
