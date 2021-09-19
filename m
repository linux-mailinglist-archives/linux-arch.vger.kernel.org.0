Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481EF410D79
	for <lists+linux-arch@lfdr.de>; Sun, 19 Sep 2021 23:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbhISVaM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 Sep 2021 17:30:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229790AbhISVaM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 19 Sep 2021 17:30:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11CB06101C;
        Sun, 19 Sep 2021 21:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632086926;
        bh=gHRybIXxp07bcxXRiDOgWRi6Hl0pBM5+8SHJr3SOA/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZsCH5R8A1aLBT5Sn4Yvqh7vQXI7Tl4vw/e0jR2aflSvE6R0l4BYvjM6gcgA9LLVkD
         3Q0uiGCLKVnI51B5N6y0CY0wwvLImaPLDg5gr/wmXv9tiZ0io7E41qj5h9Mk6xDi0l
         cFqFoK4vUQ4KI+H7CxDcoU26/kIy6Aa4ioynd2Y0RsJXDtYdNbDP/b01A/n6BYsL1/
         g9CE2idqh39r8ryCbIZGpHB44F5EOBfyRHhq6EonyUJoNvMRXuuaZGBAXrEonzsUkq
         ZKT/XpZzM+vj87Qv/DMx5zbLdbhCn4pcTcqzAZYfBZmGZ83gZaAid3XFvp+/uoCajU
         /5brOeUdovKow==
Date:   Sun, 19 Sep 2021 14:28:41 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Ulrich Teichert <krypton@ulrich-teichert.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        llvm@lists.linux.dev
Subject: Re: Odd pci_iounmap() declaration rules..
Message-ID: <YUeriU9EIJ5hiFjL@archlinux-ax161>
References: <CAHk-=wjRrh98pZoQ+AzfWmsTZacWxTJKXZ9eKU2X_0+jM=O8nw@mail.gmail.com>
 <YUdti08rLzfDZy8S@ls3530>
 <CAHk-=wgKc5TY-LiAjog5VKNUQ84CSZyPu+FQekMHDar=kdSW=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgKc5TY-LiAjog5VKNUQ84CSZyPu+FQekMHDar=kdSW=Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 19, 2021 at 11:05:35AM -0700, Linus Torvalds wrote:
> On Sun, Sep 19, 2021 at 10:04 AM Helge Deller <deller@gmx.de> wrote:
> >
> > Can you test if it fixes your alpha build (with GENERIC_PCI_IOMAP=y) as
> > well?
> 
> Yup. With this I can do that "enable GENERIC_PCI_IOMAP
> unconditionally" thing on alpha, and the one off EISA/PCI driver now
> builds cleanly without PCI.
> 
> I applied it directly (along with the alpha patch to GENERIC_PCI_IOMAP).
> 
> I have now looked at a number of drivers and architectures that I had
> happily forgotten _all_ about long long ago.
> 
> It's been kind of fun, but I sure can't claim it has been really _productive_.

Commit 9caea0007601 ("parisc: Declare pci_iounmap() parisc version only
when CONFIG_PCI enabled") causes the following build error on arm64 with
Fedora's config, which CKI initially reported:

https://src.fedoraproject.org/rpms/kernel/raw/rawhide/f/kernel-aarch64-fedora.config
https://lore.kernel.org/r/cki.E3FB2299E5.UQ0I0LMEXJ@redhat.com/
https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/datawarehouse-public/2021/09/19/373372721/build_aarch64_redhat%3A1603258426/build.log

In file included from ./arch/arm64/include/asm/io.h:185,
                 from ./include/linux/io.h:13,
                 from ./include/acpi/acpi_io.h:5,
                 from ./include/linux/acpi.h:35,
                 from ./include/acpi/apei.h:9,
                 from ./include/acpi/ghes.h:5,
                 from ./include/linux/arm_sdei.h:8,
                 from arch/arm64/kernel/asm-offsets.c:10:
./include/asm-generic/io.h:1059:21: error: static declaration of 'pci_iounmap' follows non-static declaration
 1059 | #define pci_iounmap pci_iounmap
      |                     ^~~~~~~~~~~
./include/asm-generic/io.h:1060:20: note: in expansion of macro 'pci_iounmap'
 1060 | static inline void pci_iounmap(struct pci_dev *dev, void __iomem *p)
      |                    ^~~~~~~~~~~
In file included from ./include/asm-generic/io.h:19,
                 from ./arch/arm64/include/asm/io.h:185,
                 from ./include/linux/io.h:13,
                 from ./include/acpi/acpi_io.h:5,
                 from ./include/linux/acpi.h:35,
                 from ./include/acpi/apei.h:9,
                 from ./include/acpi/ghes.h:5,
                 from ./include/linux/arm_sdei.h:8,
                 from arch/arm64/kernel/asm-offsets.c:10:
./include/asm-generic/pci_iomap.h:21:13: note: previous declaration of 'pci_iounmap' with type 'void(struct pci_dev *, void *)'
   21 | extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
      |             ^~~~~~~~~~~
make[2]: *** [scripts/Makefile.build:121: arch/arm64/kernel/asm-offsets.s] Error 1
make[2]: Target '__build' not remade because of errors.
make[1]: *** [Makefile:1219: prepare0] Error 2
make[1]: Target 'all' not remade because of errors.
make: *** [Makefile:350: __build_one_by_one] Error 2
make: Target 'olddefconfig' not remade because of errors.
make: Target 'all' not remade because of errors.

Sorry, I do not have time at the moment to look at it (family Sunday and
whatnot) but I wanted to be sure you were aware of it.

Cheers,
Nathan
