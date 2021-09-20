Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3AA4119AE
	for <lists+linux-arch@lfdr.de>; Mon, 20 Sep 2021 18:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbhITQVu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Sep 2021 12:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235902AbhITQVt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Sep 2021 12:21:49 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425FAC061574
        for <linux-arch@vger.kernel.org>; Mon, 20 Sep 2021 09:20:22 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id p29so69173695lfa.11
        for <linux-arch@vger.kernel.org>; Mon, 20 Sep 2021 09:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p6S4CYEe+OsYY46IgkJ+1TEXHqbYAus5AGqsEYFfN7E=;
        b=BrwGsZhT+O3aV2XhB18zof47KBPcf181XFlZ7xpdeBC77csZCShFo9Wnrr9HfEHZHd
         NR7wWnGg2pUE+b3gCqtFSMVFN3aNYTZi3knS61iefh0yLQoPaPKKQQIOrgF/ztIXY0+0
         SScFzMEtV71S0xGGX08itTfL4oRZe9EFBmVlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p6S4CYEe+OsYY46IgkJ+1TEXHqbYAus5AGqsEYFfN7E=;
        b=ktUXIpxmkUnUmgUKcJEVqonKdOiGs8qiCouraovoqYKYRg4HJgGAFsyJRYIW4lXzxm
         kfeEMyFNEaJkQ17wvrNq1D6JL8YtCqgzOG6kKkIJULvSZNYFNG9O7aqIcTw6vjggkPZQ
         g2IsElEBXpu5QloeU7s0I37kIZFfmSKMxRxIx8HyFxd8VhSSDRD/Pt0WhjVllxcn27VF
         FKKH+JI6nRzeM/JmdOYw/56LimhD5EilV/yzhYOHQt3TmZGI846UaP2EWGFr37ZBYZH7
         2Wdyrnac4V6rfQ/H0fhTGJVGnluwc8PTxAzRVmW69MBOFASiWdEbE3N9RwmUn3ZQ6GXY
         9jWQ==
X-Gm-Message-State: AOAM533YkSGIAZ2JzHD1xWX9iGzFW261SPyKq3sHyV5pv2zQ4WEdE5fw
        tJg2Y/Cm9eqnuTggVv0m27VeQsfVQ3Uj9Aac
X-Google-Smtp-Source: ABdhPJwawUJREvoMWz0VXvTUIJCXT3DDWVx3qLz1rbMgoVUlYCMlYFbaMaf27vwq7rLqy03YdM2ybA==
X-Received: by 2002:a19:7601:: with SMTP id c1mr18970752lff.448.1632154781413;
        Mon, 20 Sep 2021 09:19:41 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id y1sm1296054lfb.297.2021.09.20.09.19.41
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 09:19:41 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id t10so63620578lfd.8
        for <linux-arch@vger.kernel.org>; Mon, 20 Sep 2021 09:19:40 -0700 (PDT)
X-Received: by 2002:a2e:3309:: with SMTP id d9mr11340107ljc.249.1632154726138;
 Mon, 20 Sep 2021 09:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wirexiZR+VO=H3xemGKOMkh8OasmXaKXTKUmAKYCzi8AQ@mail.gmail.com>
 <20210920134424.GA346531@roeck-us.net>
In-Reply-To: <20210920134424.GA346531@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Sep 2021 09:18:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgheheFx9myQyy5osh79BAazvmvYURAtub2gQtMvLrhqQ@mail.gmail.com>
Message-ID: <CAHk-=wgheheFx9myQyy5osh79BAazvmvYURAtub2gQtMvLrhqQ@mail.gmail.com>
Subject: Re: Linux 5.15-rc2
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 20, 2021 at 6:44 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Details for build failures below. Several improvements since last week,
> but it looks like the alpha related pci_iounmap patches still need some
> tweaking (see error log at the very end).

Bah.

I thought I had tested sparc64, but I was wrong.

Silly me, I had only tested the 32-bit case.

That sparc64 thing is being particularly stupid: sparc64 uses
GENERIC_PCI_IOMAP, but declares its own empty pci_iounmap() because it
didn't use GENERIC_IOMAP that does this all right.

And because it didn't use the generic iomap code, it's all actually
entirely buggy, in that it seems to think that pci_iounmap() is about
unmapping ports (like ioport_unmap) and thus a no-op. But no,
pci_iounmap() is supposed to unmap anything that pci_iomap() mapped,
which includes the actual MMIO range too.

Basically, the whole idea of "pci_iomap()" is that you give it a PCI
device and the index to the BAR in that device, and it maps that BAR -
whether it is MMIO or PIO. And then you can use that __iomem pointer
for ioread*() and friends (or you can use readl()/writel() if you know
it was MMIO).

You can give it a maximum length if you want, but by default it just
maps the whole PCI BAR, so the default usage would just be

    void __iomem *map = pci_iomap(pdev, bar, 0);

And then you do whatever IO using that 'map' base pointer, and once
you're done you do "pci_iounmap()" on it all.

And then the trick most cases use is that they know that the PIO case
is just always a fixed map, so for PIO that "map/unmap" part os a
no-op. But generally ONLY for the PIO case.

And the sparc64 code seems to think it's only used for PIO, and makes
pci_iounmap() a no-op in general. Which is all kinds of completely
broken.

This is the same bug that the broken inline function in
<asm-generic/io.h> had, and that I added a big comment about in commit
316e8d79a095 ("pci_iounmap'2: Electric Boogaloo: try to make sense of
it all"):

+ * This code is odd, and the ARCH_HAS/ARCH_WANTS #define logic comes
+ * from legacy <asm-generic/io.h> header file behavior. In particular,
+ * it would seem to make sense to do the iounmap(p) for the non-IO-space
+ * case here regardless, but that's not what the old header file code
+ * did. Probably incorrectly, but this is meant to be bug-for-bug
+ * compatible.

but I intentionally didn't fix the bug in that commit, because I
wanted to just try to keep the odd old logic as closely as possible.

It looks like a big part of the "people do their own pci_iounmap()"
thing is that they do it badly and with bugs.

This was all meant to uncover and fix warnings, but it seems to be
uncovering bigger issues.

Of course, most of the time the "pci_iounmap()" only happens at driver
unload time, so it's basically only a kernel virtual memory mapping
leak, which may be why people didn't realize how buggy their own
implementations were.

What the normal GENERIC_IOMAP code does is:

 - it "fake maps" the PIO space at an invalid fixed virtual address

   Since we know that a PIO address on PCI is just a 16-bit number,
this fake virtual window is small and easy to do:

        /*
         * We encode the physical PIO addresses (0-0xffff) into the
         * pointer by offsetting them with a constant (0x10000) and
         * assuming that all the low addresses are always PIO. That means
         * we can do some sanity checks on the low bits, and don't
         * need to just take things for granted.
         */
        #define PIO_OFFSET      0x10000UL
        #define PIO_MASK        0x0ffffUL
        #define PIO_RESERVED    0x40000UL

   so the logic is basically that we can trivially test whether a
"void __iomem *" pointer is a PIO pointer or not: if the pointer value
is in that range of PIO_OFFSET..PIO_OFFSET+PIO_MASK range, it's PIO,
otherwise it's mmio.

 - the MMIO space acts using all the normal ioremap() logic, and we
can tell the end result apart from PIO with the above trivial thing.

 - the GENERIC_IOMAP code internally just has a IO_COND(adds, is_pio,
is_mmio) helper macro, which sets "port" for the is_pio case, and
"addr" for the is_mmio case, so you can do trivial things like this:

        unsigned int ioread8(const void __iomem *addr)
        {
                IO_COND(addr, return inb(port), return readb(addr));
                return 0xff;
        }

   which does the "inb(port)" for the PIO case, and the "readb(addr)"
for the MMIO case.

 - and lookie here what the GENERIC_IOMAP code for pci_iounmap() is:

        void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
        {
                IO_COND(addr, /* nothing */, iounmap(addr));
        }

  IOW, for the "is_pio" case it does nothing, and for the "is_mmio"
case it does "iounmap()".

So the GENERIC_IOMAP code is actually really simple and should just
work for pretty much everybody. All it requires is that fake kernel
virtual address range at PIO_OFFSET (you can override the default
values if you want - maybe your architecture really wants to put MMIO
in those virtual addresses, but I don't think there's a lot of reason
to generally want to do it)

But despite that, people think they should implement their own code,
and then they clearly get it HORRIBLY WRONG.

Anyway, this email ended up being a long explanation of what the code
_should_ do, in the hope that some enterprising kernel developer
decides "Oh, this sounds like an easy thing to fix". But you do need
to be able to test the end result at least a tiny bit.

Because I suspect that the real fix for sparc64 is to just get rid of
its broken non-GENERIC_IOMAP code, and just do "select GENERIC_IOMAP"

And I don't think sparc64 is the only architecture that should go "Oh,
I should just use GENERIC_IOMAP instead of implementing it badly by
hand".

Anyone?

               Linus
