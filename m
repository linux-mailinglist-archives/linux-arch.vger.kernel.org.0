Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22F10F1D52
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2019 19:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732534AbfKFSQu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Nov 2019 13:16:50 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34492 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfKFSQu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Nov 2019 13:16:50 -0500
Received: by mail-ot1-f68.google.com with SMTP id t4so10187912otr.1;
        Wed, 06 Nov 2019 10:16:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=15BA2o2ULwBaZdW2cSXzi/G8aVSlqB+lkO94w9/s3/8=;
        b=IhfUpr9wbh2dqqy3wfVbtjwf5TKoKKu14JKU99UdJ7IAymPGavaet6wix0tNmtZYyJ
         3sRFXjWeQi3G/XggTfwxWgGbKQV81cf9eHXfJU3H4iiKzx53GbRsszo8W1+eBim1dDbW
         L71kf1LbUhZEsgQYI3OizxdrLiIxB49wxK4FAe3cX8vxFQmc1hQtTaVH6vDZF/cgyefE
         Um7e4qtZfCir/CgS3FzNF/+lJiZQu6RMfkc4l8AQnaShu6k/H+RqR2GFaoH99SjvCw8J
         AUD4FyQI/gMdRakxPabcNGNbpvEqGGvbczVAWsUwp0+iSEjkOdVGshftMX/P/oREqaB7
         deSQ==
X-Gm-Message-State: APjAAAWMzcocIT7OXGjJlzNcwNsV3xsz+Z7ePx909db1rabhM+EeQ+8f
        YiG8+TO094I8giBKNB50Shqv/ZTk6MxfeyToPkA=
X-Google-Smtp-Source: APXvYqyJzH2QJnGyQxa9UcvqsSRwLOqnLR39MniE098RrjM8S3f0LW/gsjuzU8BhMp3pbPwutON3uAZxVc/hg56lCG0=
X-Received: by 2002:a9d:191e:: with SMTP id j30mr2894554ota.297.1573064209066;
 Wed, 06 Nov 2019 10:16:49 -0800 (PST)
MIME-Version: 1.0
References: <20191029064834.23438-12-hch@lst.de> <mhng-33ea9141-2440-4a2d-8133-62094486fc48@palmer-si-x1c4>
In-Reply-To: <mhng-33ea9141-2440-4a2d-8133-62094486fc48@palmer-si-x1c4>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Nov 2019 19:16:38 +0100
Message-ID: <CAMuHMdVuDp_8UDeWv8tdPAH5JS84=-yfwZjOk-YQcoYKM9za+w@mail.gmail.com>
Subject: Re: [PATCH 11/21] asm-generic: don't provide ioremap for CONFIG_MMU
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        Vincent Chen <deanbo422@gmail.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Greentime Hu <green.hu@gmail.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Guan Xuetao <gxt@pku.edu.cn>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Michal Simek <monstr@monstr.eu>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-mips@vger.kernel.org, alpha <linux-alpha@vger.kernel.org>,
        nios2-dev@lists.rocketboards.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Palmer,

On Wed, Nov 6, 2019 at 7:11 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> It looks like the difference in prototype between the architectures is between
>
>     void __iomem *ioremap(resource_size_t, size_t)
>     void __iomem *ioremap(phys_addr_t, size_t)
>     void __iomem *ioremap(phys_addr_t, unsigned long)
>     void __iomem *ioremap(unsigned long, unsigned long)
>
> shouldn't they all just be that first one?  In other words, wouldn't it be
> better to always provide the generic ioremap prototype and unify the ports
> instead?

Agreed. But I'd go for the second one.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
