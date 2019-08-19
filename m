Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAA7E91F53
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2019 10:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfHSIuy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Aug 2019 04:50:54 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42136 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfHSIuy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Aug 2019 04:50:54 -0400
Received: by mail-oi1-f193.google.com with SMTP id o6so727679oic.9;
        Mon, 19 Aug 2019 01:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XvpHNQzLHQyAljD3a4MUdfT4ynucGZ6tzJYlGCkwzvk=;
        b=d3Sj8PDtyOeZxOqmTqu0aDvra7Z4V58JomEgODYDjA66YEUA2XF7lo2Uc2a+4u4NIf
         AtnEvivoN71ljm0vg/ZJTYPsR6IU+kWDGkeArY+Scm02R7ZL+dfEAINun3Q0FbA2kAHU
         xpeYrc6NV5lebMwHyZBj21V+BVuk3Iiy3NXv3Vwv4DWIN0kSlOF45mJjX0rWyH+SnbYR
         0zTUQcuTcc7obpSup+7Yr9mgeD5ydqWGJ7r2OXj4IIXLQY0v8dfa4aoDmmWz4gmeSXZE
         t+lHVyKkSvJUj1Y+DvdknE256LoTZTKTOHBaVHmBNscpreCSjGQKMn2meeHRK8Ulqw3E
         LhIQ==
X-Gm-Message-State: APjAAAU0gO1voHQ6vtArOYLiSXs1ldNEkYzJO4dx2U3CTQaaXlXOn56D
        MBA2yKpmoX2UWV+yN5O4H+QgP4zvsN5xm/drugE=
X-Google-Smtp-Source: APXvYqwmqcH0DTBSRr1W5PEboqZl9eNrRnGfwBz/22T1r10yVcw0KO4fHH9AZZHFDFACKa88tOO5vT/zZa40mMCQj8M=
X-Received: by 2002:a54:4618:: with SMTP id p24mr2849469oip.148.1566204653079;
 Mon, 19 Aug 2019 01:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190817073253.27819-1-hch@lst.de> <20190817073253.27819-4-hch@lst.de>
In-Reply-To: <20190817073253.27819-4-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 19 Aug 2019 10:50:41 +0200
Message-ID: <CAMuHMdVT3VSQ1S=YEoTjYzxwpavy+43XUWA-wzCO56FuHK6R-g@mail.gmail.com>
Subject: Re: [PATCH 03/26] m68k, microblaze: remove ioremap_fullcache
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Openrisc <openrisc@lists.librecores.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        alpha <linux-alpha@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        nios2-dev@lists.rocketboards.org, linux-riscv@lists.infradead.org,
        arcml <linux-snps-arc@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Aug 17, 2019 at 9:41 AM Christoph Hellwig <hch@lst.de> wrote:
> No callers of this function.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

>  arch/m68k/include/asm/kmap.h     | 7 -------

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
