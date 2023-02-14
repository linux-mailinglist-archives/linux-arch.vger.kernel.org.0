Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51590695DDD
	for <lists+linux-arch@lfdr.de>; Tue, 14 Feb 2023 10:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjBNJCM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Feb 2023 04:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjBNJCE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Feb 2023 04:02:04 -0500
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B17020D21;
        Tue, 14 Feb 2023 01:02:03 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id z37so7482591ljq.8;
        Tue, 14 Feb 2023 01:02:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vo1pwF0Y3+477kchtQyZldRaytGfE/r9ZXPNmjOtQDY=;
        b=r+s1yIoBt4yRF8npNo/PbSLgqntQ4KtO2CBvGbsiQLvg7WSH7S5naxeOd9d57N0ZmS
         QNrs/VnBQfuwEH5+c/liqXuWCgsod0rz0svcG0RHUo46Zy5zOdp9ujxZ4TLNAvwpeBbU
         hZQ85bD6BO8IdWUSCItzQLqGGRNiOC9NS71Kahin7Owg0vKvOQH/B63bfUqdVUj1mlOY
         sE2/FBpF5kvRNC1uzYBLUcdhkbWXRXsUqkdqoxAf/MI7A8CGqOnXGesXX3R0vjO3Li5s
         WwM1/ToHxO/UyiRYjJzP5JnsCiXZGtql0Y2B25RpSAvATXrjs34iuaWJnzdq/wNr4jE5
         wKMQ==
X-Gm-Message-State: AO0yUKUufCak3haT8rcEa/GHFK/K8YLUlMKXOcUROEWv+q26bO/DM2aE
        +QDuRxb4KpqMEao6ZTYABllmrOBM/kJrLPTz
X-Google-Smtp-Source: AK7set+i1aSRulxubkI6MCPt8lQsjWweJ91XvEgMaPgQYDnzYWLzmBG1auYJgiLbbiF2tFfVGJ516w==
X-Received: by 2002:a2e:864a:0:b0:289:d1dd:b9f with SMTP id i10-20020a2e864a000000b00289d1dd0b9fmr1227113ljj.47.1676365320642;
        Tue, 14 Feb 2023 01:02:00 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id s3-20020a05651c048300b0029054907de5sm2222877ljc.101.2023.02.14.01.01.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 01:01:59 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id v17so22524579lfd.7;
        Tue, 14 Feb 2023 01:01:59 -0800 (PST)
X-Received: by 2002:a2e:9448:0:b0:293:5264:ad89 with SMTP id
 o8-20020a2e9448000000b002935264ad89mr149971ljh.37.1676365308893; Tue, 14 Feb
 2023 01:01:48 -0800 (PST)
MIME-Version: 1.0
References: <20230214074925.228106-1-alexghiti@rivosinc.com> <20230214074925.228106-16-alexghiti@rivosinc.com>
In-Reply-To: <20230214074925.228106-16-alexghiti@rivosinc.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Feb 2023 10:01:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVQeh4ZqSmVXkNJTOCZ_Ywi0b0JiGpg2EQFRWZXzkNeyw@mail.gmail.com>
Message-ID: <CAMuHMdVQeh4ZqSmVXkNJTOCZ_Ywi0b0JiGpg2EQFRWZXzkNeyw@mail.gmail.com>
Subject: Re: [PATCH v3 15/24] m68k: Remove empty <uapi/asm/setup.h>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
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
        linux-arch@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
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

On Tue, Feb 14, 2023 at 9:05 AM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
