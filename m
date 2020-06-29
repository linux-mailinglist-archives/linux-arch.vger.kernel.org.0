Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5C620D634
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jun 2020 22:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732006AbgF2TSW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 15:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731870AbgF2TRm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 15:17:42 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8E7C0307A1;
        Mon, 29 Jun 2020 08:42:39 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id t18so3124611otq.5;
        Mon, 29 Jun 2020 08:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ByBiz3Yf8Ie7OVrqv/Mz9cEMnJyRfxViWcmC4BsTpCo=;
        b=hE0uYABTBummnjR4Ws7/8m9VVzWu3XAHX7c2WGmbGrae6o+12esgMGqEHBl4sl73+C
         AToMRiaGu1UVkN6DOweDnKiho6a8hv9J3XvoKydijrHEboTGALRT/TGeQckwC85r+b4J
         2Zw18I8VuJDeNxe3bifM4EJtPrXvUqSlhjN1qO2qKunLb61XO2XoQcnD32wfqTCgt4M4
         qD5BwJwOaUF+gQPy18XRVJlH05V+T7VbWoBAjJKR6IJZzaQwjLTk14QaP1C47epEVNId
         N8NjARUfAf/n6uX5Qr3IgkkCHJdghf7za3mZIYyyIDv8CttxvvDCJw+1wK4I4eGBWt50
         P2cA==
X-Gm-Message-State: AOAM533m/nSIvlk6XUAXMgV8JRrLeMfpbqqzPNRNzbHEdYH+T3ZNHbdE
        MVvWhQJ4846m4ksPjwoaF6YS5nNSR8//g+GmAMg=
X-Google-Smtp-Source: ABdhPJzZv9yrcqjQPIqNSuZYxDZ0MHssHdmPppPpB4X3a0jGl41oFltbqUVWyGPYv/nioiv+o7pFkroyCV6uhkj/ZSQ=
X-Received: by 2002:a05:6830:1451:: with SMTP id w17mr1241594otp.250.1593445359003;
 Mon, 29 Jun 2020 08:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200627143453.31835-1-rppt@kernel.org> <20200627143453.31835-7-rppt@kernel.org>
In-Reply-To: <20200627143453.31835-7-rppt@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 29 Jun 2020 17:42:28 +0200
Message-ID: <CAMuHMdWP07XqvgrXjCG+n5FssH3BwdDEWA4fD9TQgvVy93uMhQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] asm-generic: pgalloc: provide generic pgd_free()
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Joerg Roedel <joro@8bytes.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Stafford Horne <shorne@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        linux-um <linux-um@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Openrisc <openrisc@lists.librecores.org>,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jun 27, 2020 at 4:36 PM Mike Rapoport <rppt@kernel.org> wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> Most architectures define pgd_free() as a wrapper for free_page().
>
> Provide a generic version in asm-generic/pgalloc.h and enable its use for
> most architectures.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

For the m68k part:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
