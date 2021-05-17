Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED0438258C
	for <lists+linux-arch@lfdr.de>; Mon, 17 May 2021 09:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbhEQHna (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 May 2021 03:43:30 -0400
Received: from mail-vs1-f49.google.com ([209.85.217.49]:40880 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbhEQHna (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 May 2021 03:43:30 -0400
Received: by mail-vs1-f49.google.com with SMTP id o192so2628897vsd.7;
        Mon, 17 May 2021 00:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UQCnCHnuTGOUv4Xn5a0Aiay+N+Nu4F56YkpDcV2EHAE=;
        b=VLDmaGdCMqhscOxI87MqKVv5Y47JnitlYD3/hgPosIeCv2kayjl3OfV5UwKObJCuVY
         iiaauH9LO32cVCZTMNRJbQNjeY2SSGRgiH0RoBQNA15p30A7OZDRPcUTbzDVt/DChrpn
         gfcsfFGE13zygnHRzUTbDCnhUDQpg2gmluG72HuArhsTRnZFwhnNbIbMiKtm4LtbhpUf
         rxYMmHQYvj/oFSDyA66SIRk2rnxDxVZxFavVygLIsZqudloS7ivqyS77KUXdrCM8QOVK
         v+n7w4xIvLL11UB52P8ybkiLNdpShntzDhVuu1H40VTo6LPAJ7Vs6zapeUsde3+BM0pR
         yiMg==
X-Gm-Message-State: AOAM531OQh5F9MF2xmxaNcXHq6QvBZgjiLQ7TEgM7TtENx1pE05TdCK9
        TuUgG8jG1jAJSTLTVu6Un6+lZfXLN4lVhl6f46o=
X-Google-Smtp-Source: ABdhPJw1uawrtdGC5r811ckzuqrHCuKa2aLYEPaEyXVqSRjYUArXfwswdvyXpadVLtTHBByRvBxAhX2BvK3dzp74coo=
X-Received: by 2002:a67:f84f:: with SMTP id b15mr9140633vsp.40.1621237334116;
 Mon, 17 May 2021 00:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210514220942.879805-1-arnd@kernel.org> <20210514220942.879805-2-arnd@kernel.org>
In-Reply-To: <20210514220942.879805-2-arnd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 May 2021 09:42:02 +0200
Message-ID: <CAMuHMdXr6gxbJu+otHV=PhoXvM7aoshs_A-SVpTmYw1iDdiqsg@mail.gmail.com>
Subject: Re: [PATCH 1/5] asm-generic/uaccess.h: remove __strncpy_from_user/__strnlen_user
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Brian Cain <bcain@codeaurora.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Sid Manning <sidneym@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-um <linux-um@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 15, 2021 at 12:10 AM Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> This is a preparation for changing over architectures to the
> generic implementation one at a time. As there are no callers
> of either __strncpy_from_user() or __strnlen_user(), fold these
> into the strncpy_from_user() strnlen_user() functions to make

... and ...

> each implementation independent of the others.
>
> Many of these implementations have known bugs, but the intention
> here is to not change behavior at all and stay compatible with
> those bugs for the moment.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
