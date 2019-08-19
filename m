Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02DFC91F71
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2019 10:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfHSI4Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Aug 2019 04:56:16 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44977 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfHSI4P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Aug 2019 04:56:15 -0400
Received: by mail-oi1-f195.google.com with SMTP id k22so733476oiw.11;
        Mon, 19 Aug 2019 01:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6G5Q8MNHtBsxtM0EYIY9kLhACl1vZMsZYLOG6VK87LE=;
        b=p8IDsKsxecsmx7fA/TTSwpImLS1tvufbE81mL0ENZCxFmwOm6ZTCcplHbeUnxeD/pg
         Bqxopf5eFqGy6WSmadBN2o1GHJ60mkNTs5hV00d2pHhxkrz2A6CfTlqKqmxqmtqa8uU6
         TsrPcK3lN4viGY25py0Jujpu4G3MWzmsibWEa03dT3RfO3gPAQyKVpAmV68p1uIdPfdt
         bZymL6c4xYAfParRwXNWFTEpXAU3VL77msA/P8eIe6r8AW3jnkXftjDw44j/HCIUySIX
         xb9CkGBP5kfnc88KvttpetzGqjZWSdNqA5haMq8KV4g0y/OM/ECTzoQvdfUdOp4C6l5M
         1qUw==
X-Gm-Message-State: APjAAAVY0UTbGPGSM+XHHPMA9pWsFCvkH6VhP9z1VK6cGr4YpfwKGDpG
        /WBbXaEtx36iHlkJ3xbs7WcJz0dbHb7QaSuP2H0=
X-Google-Smtp-Source: APXvYqwNkMBh58jQZs/taAE8CIPOk6D0evfJ20SfbPqDG1zrFPybSy7xKWIfKgi9aIO2Yy6HJzobqI2PMgSWcaN0QpY=
X-Received: by 2002:a54:478d:: with SMTP id o13mr12702951oic.54.1566204974376;
 Mon, 19 Aug 2019 01:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190817073253.27819-1-hch@lst.de> <20190817073253.27819-9-hch@lst.de>
In-Reply-To: <20190817073253.27819-9-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 19 Aug 2019 10:56:02 +0200
Message-ID: <CAMuHMdWyXGjokWi7tn9JHCTz9YMb_vHn6XKeE7KzH5n-54Sy0A@mail.gmail.com>
Subject: Re: [PATCH 08/26] m68k: simplify ioremap_nocache
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org, nios2-dev@lists.rocketboards.org,
        Openrisc <openrisc@lists.librecores.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Christoph,

On Sat, Aug 17, 2019 at 9:48 AM Christoph Hellwig <hch@lst.de> wrote:
> Just define ioremap_nocache to ioremap instead of duplicating the
> inline.  Also defined ioremap_uc in terms of ioremap instead of
> the using a double indirection.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

BTW, shouldn't we get rid of the sole user of ioremap_uc(), too?
Seems to make a difference on x86 only, where it is "strongly uncached"
(whatever that may mean ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
