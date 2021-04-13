Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FEE35DF91
	for <lists+linux-arch@lfdr.de>; Tue, 13 Apr 2021 14:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238400AbhDMM6R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Apr 2021 08:58:17 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:59125 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240505AbhDMM6R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Apr 2021 08:58:17 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N94uf-1lZosF0bMF-0168Am; Tue, 13 Apr 2021 14:57:56 +0200
Received: by mail-wm1-f47.google.com with SMTP id o9-20020a1c41090000b029012c8dac9d47so1236047wma.1;
        Tue, 13 Apr 2021 05:57:56 -0700 (PDT)
X-Gm-Message-State: AOAM533Vhq4O/cymIHocG+GwgiYuvrD7WLhF/gPucLoH8LqHu5J7RreD
        Bl6JJz8HTLXyji44JnC/KheiN6x6PTy5YRV8Lkc=
X-Google-Smtp-Source: ABdhPJxTQZ7MuH8+gU54fvl5PqqUtAVuKR2Nq7J+aH8L83oc2Ox6+tJXCnKAoNROOSga1LhxVL51YnmncU3MpdLYGCI=
X-Received: by 2002:a05:600c:19cf:: with SMTP id u15mr3941758wmq.43.1618318675780;
 Tue, 13 Apr 2021 05:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210413115439.1011560-1-schnelle@linux.ibm.com>
 <CAK8P3a1WTZOYpJ2TSjnbytQJWgtfwkQ8bXXdnqCnOn6ugJqN_w@mail.gmail.com> <84ab737edbe13d390373850bf317920b3a486b87.camel@linux.ibm.com>
In-Reply-To: <84ab737edbe13d390373850bf317920b3a486b87.camel@linux.ibm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 13 Apr 2021 14:57:39 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2NR2nhEffFQJdMq2Do_g2ji-7p3+iWyzw+aXD6gov05w@mail.gmail.com>
Message-ID: <CAK8P3a2NR2nhEffFQJdMq2Do_g2ji-7p3+iWyzw+aXD6gov05w@mail.gmail.com>
Subject: Re: [PATCH] asm-generic/io.h: Silence -Wnull-pointer-arithmetic
 warning on PCI_IOBASE
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:E6mmaWCUfZfPbht3GMZr0hjzJ+RdY38JXsps0lawqf7LlqiLXsq
 6fnk3imQuI+wUkUelFvV5mXbgdXzRdEAqllXZ07Q6Ccw7Ilacv+NtDFeldM4knPxm20Cl91
 WOOlfONeBG9xoH9D8mIBztq/G3s9X5uM6K2dNWRQ7USdd7gXd3aNRYOz8BsE/oOHL1v5MnZ
 eR9RYfaCIZojTwk6EDgxw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VUhORDKfbxA=:+EAiGk9nv0aPd3XeVTW1yJ
 XhNc8pyGr83T4ajx2YO9Oc6vlzeNZIVFzpzS6B8W1SFdPCQPuLTTGqbfVM+Z0R5LOCKbi91Ur
 vJqXa+MLCeLpwF2POzpnez+eBV05J1j4CkMyA8oREKa3IS8t24vNctwjhXkqhRmrD3n8BCpeR
 hTj84sgXYawlBTnTPoAGdJu+jlAuCZpMMnOFWK0UFMLrgCPX3EplPPjtM3/hIMiMaLkrGKmMC
 MV3ZglUqTK5nmRQ3E+8LucDniOEqwVy0RQDarUL6Oa/iP0LVIxYdddwUfEBKETQ8fjNI23NM7
 bJWcIZ5VWv+EMcAf5hrVuiqvDuVjgxm+8wrnp+fUcD30DGif+btx4bXw5nyEVOshfCCtPuBDj
 7rLJzbMDdTfntQ8mIWvNJw0VubCHcdWaPEOuE9EblQ+ZXfgOMjH10HNAAgeKnm1p+2eDpAIeD
 4KXo/FVI0TZpiMt6ONKwmv2hcD5qmxFqWhg0q3IUWXpyfNXsFvWSbUBYcT6/O9S8Mf3Hesq0z
 D5M3gUUM+6+A5QrTlSvzCb5AmF8V7EaPzcIgIlX6h1u5RaX7Wy0AuQnUHalNJfObsZUyGFd9e
 N9KgT/7puOMLsjP6aY5TxCDejDxAvQLFtg0pwyOvaSoTxD5eOh7AtM+Qvu9Tl0RtvMEECw3oH
 hn14=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 13, 2021 at 2:38 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> On Tue, 2021-04-13 at 14:26 +0200, Arnd Bergmann wrote:
> > I think the real underlying problem is that '0' is a particularly bad
> > default value,
> > we should not have used this one in asm-generic, or maybe have left it as
> > mandatory to be defined by an architecture to a sane value. Note that
> > architectures that don't actually support I/O ports will cause a NULL
> > pointer dereference when loading a legacy driver, which is exactly what clang
> > is warning about here. Architectures that to support I/O ports in PCI typically
> > map them at a fixed location in the virtual address space and should put that
> > location here, rather than adding the pointer value to the port resources.
> >
> > What we might do instead here would be move the definition into those
> > architectures that actually define the base to be at address zero, with a
> > comment explaining why this is a bad location, and then changing the
> > inb/outb style helpers to either an empty function or a WARN_ONCE().
> >
> > On which architectures do you see the problem? How is the I/O port
> > actually mapped there?
>
> I'm seeing this on s390 which indeed has no I/O port support at all.
> I'm not sure how many others there are but I feel like us having to
> define these functions as empty is also kind of awkward. Maybe we could
> put them into the asm-generic/io.h for the case that PCI_IOBASE is not
> defined? Then at least every platform not supporting I/O ports would
> share them.

Yes, I meant doing this in the asm-generic version, something like

#if !defined(inb) && !defined(_inb)
#define _inb _inb
static inline u8 _inb(unsigned long addr)
{
#ifdef PCI_IOBASE
        u8 val;

        __io_pbr();
        val = __raw_readb(PCI_IOBASE + addr);
        __io_par(val);
        return val;
#else
        WARN_ONCE(1, "No I/O port support");
        return 0xff;
#endif
}
#endif

And follow up with a separate patch that moves the
"#define PCI_IOBASE ((void __iomem *)0)" into the architectures
that would currently see it, i.e. those that include asm-generic/io.h
but define neither inb/_inb nor PCI_IOBASE:

$ git grep -l asm-generic/io.h | xargs grep -wL inb | xargs grep -L PCI_IOBASE
arch/arc/include/asm/io.h
arch/csky/include/asm/io.h
arch/h8300/include/asm/io.h
arch/m68k/include/asm/io.h
arch/nds32/include/asm/io.h
arch/nios2/include/asm/io.h
arch/openrisc/include/asm/io.h
arch/s390/include/asm/io.h
arch/sparc/include/asm/io_32.h
arch/um/include/asm/io.h

Out of these, I see that arc, h8300, nds32, nios2, openrisc, and um
never set CONFIG_HAVE_PCI, so these would all be better off
leaving PCI_IOBASE undefined and getting the WARN_ONCE.

The remaining ones (csky, m68k, sparc32) need to be inspected
manually to see if they currently support PCI I/O space but in
fact use address zero as the base (with large resources) or they
should also turn the operations into a NOP.

         Arnd
