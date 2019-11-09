Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 863CFF5F83
	for <lists+linux-arch@lfdr.de>; Sat,  9 Nov 2019 15:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfKIO0m (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 9 Nov 2019 09:26:42 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36338 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfKIO0m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 9 Nov 2019 09:26:42 -0500
Received: by mail-ot1-f66.google.com with SMTP id f10so7714142oto.3;
        Sat, 09 Nov 2019 06:26:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fkse6mn+BlbyKaVzVIbzg4CVFkjF596d7A0VyrrgtRU=;
        b=nFyS+o87e/FWAnmqpwZbiiJKxtutgLkNwjvAongX5FrQROqYIVKJZi6ZoDP2MpigxA
         RMsRWqhc3CrR6z+KJXTLgmSc3XMo8R1lQ/+0kllXkbccPZ2cov+u0vHO6Vbfn+V603nl
         NNvlAOrhucViLbbjytXef50v6YCiNofD8byUwYKM5YCs7Jrq2yL+FBIJiLVK9PqlOnM3
         44EEsGJLBmgkvZ5T6N/VD39CFIXfmqPb/ZpZeJ5abEEDBlILhf2xuH1G89h+JbRSJqck
         7wp/NGYXT5SvoUB09whkYX4aPMoG6OEEpyeMlIe1xjC/UfUk1gu9z7Xkfp5o4F7qd/dt
         NVHA==
X-Gm-Message-State: APjAAAVaU0w9iSJnEC4kFcFRbqDvMr6K5T9fxaWyUWbbVh6JX9JfTHmQ
        Tq5/QEJ8wPeUNOsQqpTAkV4khR4AuLn9a90bHr8=
X-Google-Smtp-Source: APXvYqwpjgCj+NHQWmmo7wlASzZaObwnisMuzQQ68HgJW5L0F4ZE2XkJ/WLy2vxRTaOAABifbqXLM9wt0RfHZ30Isk4=
X-Received: by 2002:a9d:422:: with SMTP id 31mr13203157otc.107.1573309600743;
 Sat, 09 Nov 2019 06:26:40 -0800 (PST)
MIME-Version: 1.0
References: <1572938135-31886-1-git-send-email-rppt@kernel.org>
 <1572938135-31886-6-git-send-email-rppt@kernel.org> <20191108113917.a9c6ebb8373cc95fd684b734@linux-foundation.org>
In-Reply-To: <20191108113917.a9c6ebb8373cc95fd684b734@linux-foundation.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 9 Nov 2019 15:26:29 +0100
Message-ID: <CAMuHMdXdoFSVno4WT=F6Q1UwEaZ6AQJmhNUqPpYHJm6uh165iw@mail.gmail.com>
Subject: Re: [PATCH v4 05/13] m68k: mm: use pgtable-nopXd instead of 4level-fixup
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Rapoport <rppt@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Jeff Dike <jdike@addtoit.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>, Peter Rosin <peda@axentia.se>,
        Richard Weinberger <richard@nod.at>,
        Rolf Eike Beer <eike-kernel@sf-tec.de>,
        Russell King <linux@armlinux.org.uk>,
        Sam Creasey <sammy@sammy.net>,
        Vincent Chen <deanbo422@gmail.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-um@lists.infradead.org,
        sparclinux <sparclinux@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Andrew,

On Fri, Nov 8, 2019 at 8:39 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> On Tue,  5 Nov 2019 09:15:27 +0200 Mike Rapoport <rppt@kernel.org> wrote:
> > m68k has two or three levels of page tables and can use appropriate
> > pgtable-nopXd and folding of the upper layers.
> >
> > Replace usage of include/asm-generic/4level-fixup.h and explicit
> > definitions of __PAGETABLE_PxD_FOLDED in m68k with
> > include/asm-generic/pgtable-nopmd.h for two-level configurations and with
> > include/asm-generic/pgtable-nopud.h for three-lelve configurations and
> > adjust page table manipulation macros and functions accordingly.
>
> This one was messed up by linux-next changes in arch/m68k/mm/kmap.c.
> Can you please take a look?

You mean due to the rename and move of __iounmap() to __free_io_area()
in commit aa3a1664285d0bec ("m68k: rename __iounmap and mark it static")?

Commit 42d6c83d6180f800 ("m68k: mm: use pgtable-nopXd instead of
4level-fixup") in next-20191108 looks good to me.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
