Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63873D46EF
	for <lists+linux-arch@lfdr.de>; Sat, 24 Jul 2021 11:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbhGXJEc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 24 Jul 2021 05:04:32 -0400
Received: from mail-vs1-f45.google.com ([209.85.217.45]:33790 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbhGXJEc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 24 Jul 2021 05:04:32 -0400
Received: by mail-vs1-f45.google.com with SMTP id j19so2481829vso.0;
        Sat, 24 Jul 2021 02:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=keAmZ2CPCYhvSQ4mOFSu6xYJjSpZyH/RHb87AkV/yrs=;
        b=R/IP32YKksYg5gZWhO3ZZEs8inZlz2wkXLlM1kl027VKqG/fRFquq9pnP/r9mRx6Uu
         9NhN6sziKpC/mzGB2CgjFPLmuV4e4SzslFUlLEBTed+13wleyVk3eqhDzCVSvAL2lWQY
         1OgmrvaZeto+2C9ulNM2aGVjc4D/+aTMW3SXDrFJNs5mUhVib24SR8e/JTU1y2q/cumC
         Mhveb8cyQmXg/ph+4KJVPLhC4FuCTLiU30Gw0+HSwq99RirGh5RhGhIZ7rdcRKeCRJog
         VdUdqrA6yp2CipcNDGMwOd192CzsVcreWzbsDbJfV9FVjBTsQ9z4FPCPFaloc3xHztrv
         eIqA==
X-Gm-Message-State: AOAM532al6VzDfm6Gk3RUBeoqmH3MAi3+VLsuewibiZbhSjS+hBlwate
        ZSv9Sn8GJL2SfioJ7rwYj6gqg97X56VTszEh0KE=
X-Google-Smtp-Source: ABdhPJx/VMaxoCtidt2JUmSZoVwy1uJ8nMQedSbWMl9RC/U3GJflf2tGEudtsRyYEnzq9MLjJYaEo+n0/LkpOXoH+rA=
X-Received: by 2002:a05:6102:2828:: with SMTP id ba8mr7652479vsb.18.1627119902711;
 Sat, 24 Jul 2021 02:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210722124814.778059-1-arnd@kernel.org> <20210722124814.778059-10-arnd@kernel.org>
In-Reply-To: <20210722124814.778059-10-arnd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 24 Jul 2021 11:44:51 +0200
Message-ID: <CAMuHMdWjZWMtXqyLWPsCvNphoc2ZHut+UiwLuqDtG7Vir0OR2A@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] asm-generic: reverse GENERIC_{STRNCPY_FROM,STRNLEN}_USER
 symbols
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Brian Cain <bcain@codeaurora.org>,
        Chris Zankel <chris@zankel.net>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>, Jeff Dike <jdike@addtoit.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Richard Weinberger <richard@nod.at>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-csky@vger.kernel.org,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        linux-um <linux-um@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 22, 2021 at 2:50 PM Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Most architectures do not need a custom implementation, and in most
> cases the generic implementation is preferred, so change the polariy
> on these Kconfig symbols to require architectures to select them when
> they provide their own version.
>
> The new name is CONFIG_ARCH_HAS_{STRNCPY_FROM,STRNLEN}_USER.
>
> The remaining architectures at the moment are: ia64, mips, parisc,
> s390, um and xtensa. We should probably convert these as well, but
> I was not sure how far to take this series.
>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: linux-ia64@vger.kernel.org
> Cc: linux-mips@vger.kernel.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-um@lists.infradead.org
> Cc: linux-xtensa@linux-xtensa.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

>  arch/m68k/Kconfig                 |  2 --

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
