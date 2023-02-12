Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C1A693857
	for <lists+linux-arch@lfdr.de>; Sun, 12 Feb 2023 17:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjBLQNY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 12 Feb 2023 11:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBLQNX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Feb 2023 11:13:23 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C060111E81;
        Sun, 12 Feb 2023 08:13:22 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-16ab8581837so12596940fac.4;
        Sun, 12 Feb 2023 08:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m9JNrWha4YKLX9rD9uaO4Le+Z0yMwIJejyvjLhFB0mM=;
        b=RPfdfqoXr1Cw8prltm7TREoupX5eaNpNd+CDIlDXf9L709PnPoKQLyqZ+zboWylzWR
         vxu85Zr3W8llfd+943ctWIFMuj/eUOowqYJKaVeMEAuOZh7DSd87i28bvDxNAQ6PoOwC
         wXW2mjy0Nv7rWdLT7K6lR96N0WQft3GWf2KAFrqyzdPjhTZH7LFIYRkc0u2koR60TrCD
         1hpxf+WoKXg0JbOE+h0e0CkhGndeecaH5fbwJ/zhVif01anzu3CRcpBwMXBGR6L77UGt
         T0ZqZhaH9160JyrIQvfc6bBDGV0wnlmjvzDTuOmCpyHfThC29vCqk4lTBNsczBdn8qUd
         qBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9JNrWha4YKLX9rD9uaO4Le+Z0yMwIJejyvjLhFB0mM=;
        b=pgVrLQ0TtL6Y1aeMbU/cj5pgmiN3b9wgXaXsWtBGoWPC8Hv00vm4ikwrFK5VvWH5Mc
         CYKn2xP0M4IrvO/4nKMUSmmyn+4CkpzZ1ahPkKQAgieSKT3hgkbrg0EBj9+T+bmi/FSg
         h+p4Ko1zU+a/kw3GtiF/mId8mgFipikeRTREJ3cpXkiysNAbswcr1EB5zE9ZrUHWHylt
         p8jYzr/a0yiChnltVFK+uDZ50zzqrujMqGkWuCCTADsgcqLhLCiZLCMkHRlusTy/MXf1
         xqlrVqKqEdPM7xtWK+SsppGCNZ8JXvd/9gwNqxxNvWmCs9R7qb3rzpu1EP8PTtTKm4p9
         DdYw==
X-Gm-Message-State: AO0yUKXYSK0FMa6uiD5G2zZ+pWI1Cfs+D7vrmet9sEQ6CFUXT5oZR2JQ
        Z37vCKKmWW8wijDTf1nd5GA=
X-Google-Smtp-Source: AK7set9kfP8sfCh4EsN95J/ZdmLAzZQPNePNkWSy8sPECM/cP6PHARZOJXcrMxdY1LlBw1JK0pRDxg==
X-Received: by 2002:a05:6870:b48d:b0:16d:ec6a:71ec with SMTP id y13-20020a056870b48d00b0016dec6a71ecmr2441541oap.27.1676218402068;
        Sun, 12 Feb 2023 08:13:22 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n2-20020a056870844200b0010c727a3c79sm3225235oak.26.2023.02.12.08.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 08:13:21 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 12 Feb 2023 08:13:20 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Brian Cain <bcain@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rich Felker <dalias@libc.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vineet Gupta <vgupta@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        x86@kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v2 4/4] mm, arch: add generic implementation of
 pfn_valid() for FLATMEM
Message-ID: <20230212161320.GA3784076@roeck-us.net>
References: <20230129124235.209895-1-rppt@kernel.org>
 <20230129124235.209895-5-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230129124235.209895-5-rppt@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jan 29, 2023 at 02:42:35PM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> Every architecture that supports FLATMEM memory model defines its own
> version of pfn_valid() that essentially compares a pfn to max_mapnr.
> 
> Use mips/powerpc version implemented as static inline as a generic
> implementation of pfn_valid() and drop its per-architecture definitions.
> 

With this patch in the tree, sh4 and sh4eb qemu emulations no longer boot.
Reverting this patch fixes the problem.

Guenter

---
# bad: [6ba8a227fd19d19779005fb66ad7562608e1df83] Add linux-next specific files for 20230210
# good: [4ec5183ec48656cec489c49f989c508b68b518e3] Linux 6.2-rc7
git bisect start 'HEAD' 'v6.2-rc7'
# good: [94613f0efc69ed41f9229ef5c294db3ec37145da] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect good 94613f0efc69ed41f9229ef5c294db3ec37145da
# good: [19e62c715fe70dae4582c2874ed3e66715d09af6] Merge branch 'rcu/next' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
git bisect good 19e62c715fe70dae4582c2874ed3e66715d09af6
# good: [5d8b7ecef7f4a681b6e5538db59ff26c389c0ab6] Merge branch 'for-next' of https://gitlab.com/peda-linux/mux.git
git bisect good 5d8b7ecef7f4a681b6e5538db59ff26c389c0ab6
# good: [c349bf6ec83903b20fe570c5609b9a864a64e09c] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git
git bisect good c349bf6ec83903b20fe570c5609b9a864a64e09c
# good: [5a06a9f17454df38f35672be522ff5eb9b4277d2] selftest: add testing unsharing and counting ksm zero page
git bisect good 5a06a9f17454df38f35672be522ff5eb9b4277d2
# bad: [f5d115a7b06e5661ed5218ffa9a2644c4ff1c135] Merge branch 'mm-nonmm-unstable' into mm-everything
git bisect bad f5d115a7b06e5661ed5218ffa9a2644c4ff1c135
# bad: [acb018d6ea0c055381fba7dddaef386ee28f8075] mm/vmalloc.c: allow vread() to read out vm_map_ram areas
git bisect bad acb018d6ea0c055381fba7dddaef386ee28f8075
# good: [1a5d9782ac969dc6e61c6786500b5160603188ea] mm/mmap: remove __vma_adjust()
git bisect good 1a5d9782ac969dc6e61c6786500b5160603188ea
# good: [4b32363697de957dcc890b6245bec3f58903639a] arm: include asm-generic/memory_model.h from page.h rather than memory.h
git bisect good 4b32363697de957dcc890b6245bec3f58903639a
# bad: [328cf3fa6682ce6a4de6f8bb8009c833dc33f3c8] mm/migrate: convert isolate_movable_page() to use folios
git bisect bad 328cf3fa6682ce6a4de6f8bb8009c833dc33f3c8
# bad: [b704c765b08cabe82adf76a4d1a74f3688eee410] mm/mempolicy: convert queue_pages_pmd() to queue_folios_pmd()
git bisect bad b704c765b08cabe82adf76a4d1a74f3688eee410
# bad: [e5734c8b0edfd2a053a5c256189586a3b1e9f63d] mm, arch: add generic implementation of pfn_valid() for FLATMEM
git bisect bad e5734c8b0edfd2a053a5c256189586a3b1e9f63d
# good: [ad8aecea034c591b9754bc5908da9719853aa7fa] mips: drop definition of pfn_valid() for DISCONTIGMEM
git bisect good ad8aecea034c591b9754bc5908da9719853aa7fa
# first bad commit: [e5734c8b0edfd2a053a5c256189586a3b1e9f63d] mm, arch: add generic implementation of pfn_valid() for FLATMEM
