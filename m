Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D822435E0F4
	for <lists+linux-arch@lfdr.de>; Tue, 13 Apr 2021 16:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239357AbhDMOH4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Apr 2021 10:07:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230435AbhDMOH4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Apr 2021 10:07:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2C576128C;
        Tue, 13 Apr 2021 14:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618322856;
        bh=/rQtgFZmv2p/wc/NfFyEt515Ew2Rh/no+mxrEu1oqmg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uyopM934FkXBH2o0na6lnTj15QMpy3jDjv4D1988Wk8lzD3hoD6qpl9fomxNBbMJw
         XabrMFhqxKz5vaW1ui5t91yGD0jWYaPhbDPA/qjesuIqeJqGdgjO0hJ8sCQ9ldUiDc
         Bkcgtm+ZgG9SyczgMCT8asyvqGeDU5GChj78OLeqVC2O/Rf9LANiYBRZPzXzdHIOzu
         SoNrSwJF8KFszXzJ+k3nLQm0eTbSEM6xaQtMW9aHDJI20NrZLL6jt8Idztu9euyn5n
         HeKSYEebArN4XMZqhnXdnDhjQLQHb3tA18XqT8EZL99gqDHEAJcEA5AwzTtZckpjK4
         zIpVVoTUF+qCA==
Received: by mail-oi1-f176.google.com with SMTP id d12so17069837oiw.12;
        Tue, 13 Apr 2021 07:07:36 -0700 (PDT)
X-Gm-Message-State: AOAM5332wV4A6D3b3y6IZa68ng1/nFN7t1HeqbUI4kzYzRKhc6fp3E0S
        Isr0ihVATQGnpiitRwyNY1PabODNwhl9aT4imZc=
X-Google-Smtp-Source: ABdhPJzez6cFFrm7KA5oVrV1D6W2CEu4be89gYpgJtrS3Na7zboRdC7VXyYr4Ul1q/el5Sty6633joh79LViIc3vqBg=
X-Received: by 2002:aca:4284:: with SMTP id p126mr142280oia.178.1618322856211;
 Tue, 13 Apr 2021 07:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210413115439.1011560-1-schnelle@linux.ibm.com>
 <CAK8P3a1WTZOYpJ2TSjnbytQJWgtfwkQ8bXXdnqCnOn6ugJqN_w@mail.gmail.com>
 <84ab737edbe13d390373850bf317920b3a486b87.camel@linux.ibm.com>
 <CAK8P3a2NR2nhEffFQJdMq2Do_g2ji-7p3+iWyzw+aXD6gov05w@mail.gmail.com>
 <11ead5c2c73c42cbbeef32966bc7e5c2@AcuMS.aculab.com> <CAK8P3a3PK9zyeP4ymELtc2ZYnymECoACiigw9Za+pvSJpCk5=g@mail.gmail.com>
In-Reply-To: <CAK8P3a3PK9zyeP4ymELtc2ZYnymECoACiigw9Za+pvSJpCk5=g@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 13 Apr 2021 22:07:24 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT53uXXF7aU8+Sr6KZ-+OYDrtESQi8G-tcFZ2c0QnJ+bw@mail.gmail.com>
Message-ID: <CAJF2gTT53uXXF7aU8+Sr6KZ-+OYDrtESQi8G-tcFZ2c0QnJ+bw@mail.gmail.com>
Subject: Re: [PATCH] asm-generic/io.h: Silence -Wnull-pointer-arithmetic
 warning on PCI_IOBASE
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Laight <David.Laight@aculab.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 13, 2021 at 9:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Apr 13, 2021 at 3:06 PM David Laight <David.Laight@aculab.com> wrote:
> >
> > From: Arnd Bergmann
> > > Sent: 13 April 2021 13:58
> > ...
> > > The remaining ones (csky, m68k, sparc32) need to be inspected
> > > manually to see if they currently support PCI I/O space but in
> > > fact use address zero as the base (with large resources) or they
> > > should also turn the operations into a NOP.
> >
> > I'd expect sparc32 to use an ASI to access PCI IO space.
> > I can't quite remember whether IO space was supported at all.
>
> I see this bit in arch/sparc/kernel/leon_pci.c
>
>  * PCI Memory and Prefetchable Memory is direct-mapped. However I/O Space is
>  * accessed through a Window which is translated to low 64KB in PCI space, the
>  * first 4KB is not used so 60KB is available.
> ...
>         pci_add_resource_offset(&resources, &info->io_space,
>                                 info->io_space.start - 0x1000);
>
> which means that there is I/O space, which gets accessed through whichever
> method readb() uses. Having the offset equal to the resource means that
> the '(void *)0' start is correct.
>
> As this leaves only two others, I checked those as well:
>
> csky does not actually have a PCI host bridge driver at the moment, so
> we don't care about breaking port access on it it, and I would suggest
> leaving I/O port access disabled. (Added Guo Ren to Cc for confirmation).
Yes, we haven't reserved the PCI_IO region in the VM layout.

>
> m68k only supports PCI on coldfire M54xx, and this variant does set
> a PCI_IOBASE after all. The normal MMU based m68k have no PCI
> and do define their out inb/outb/..., so nothing changes for them.
>
> To summarize: only sparc32 needs to set PCI_IOBASE to zero, everyone
> else should just WARN_ONCE() or return 0xff/0xffff/0xffffffff.
>
>         Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
