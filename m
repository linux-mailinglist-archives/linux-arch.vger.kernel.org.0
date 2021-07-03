Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF7B3BA8A8
	for <lists+linux-arch@lfdr.de>; Sat,  3 Jul 2021 14:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhGCMPR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 3 Jul 2021 08:15:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230209AbhGCMPR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 3 Jul 2021 08:15:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 092FA61934;
        Sat,  3 Jul 2021 12:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625314364;
        bh=1mLMGaBe3T8PNBo9Ly3kN5L7hm+00YAjMpTfySrZV6c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oFAhw8N4IyGvi+9Wdqp1rBC20SM5p55/NOmWMbKMhsxdFEaI2fUVVfmLo0tUtEokC
         20R3S9EpwD2vZRpPjVDTkargqOVbOe33P3EhxOwhuNMZZY45WVmUpYiGuqDDDndg8i
         6sFCbeJFaM0C7BePLbRhJqwkO1KmQECBYOvUO0zmW28SuHzZ9qoSRyN2fq1j5IUKBx
         ICTlU80cr/+o2MJmaEjD4ad8nU8RYE303v4dnliAZSxnk5pEJOiFzIylay/7/dQNb8
         2Y3EZgjS4sHhhvXr/guu9l1MWIG2/7QUUP6YOJIdqkpdStR1z7DBYCEtFySPkSO3bq
         OyDFkHDIQhwaw==
Received: by mail-wr1-f51.google.com with SMTP id m18so15902732wrv.2;
        Sat, 03 Jul 2021 05:12:43 -0700 (PDT)
X-Gm-Message-State: AOAM53177Q7+34ieDTtHC6Hhe+qNGCWwV+r58LD2qdeh6gwrG/gCIi6W
        +iZewo6JIXHanKXruX05Wh4RhphtQWU2eWq9qpw=
X-Google-Smtp-Source: ABdhPJwS6gLKtPhQQw/E1An+ku1VAUkH19/T5eobnv1cwbE+QhHFDXqG/Y51TtT8umGbGQ6iIX6J8dC+VcwxiT/GBZk=
X-Received: by 2002:a5d:6485:: with SMTP id o5mr5183612wri.286.1625314362622;
 Sat, 03 Jul 2021 05:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2oZ-+qd3Nhpy9VVXCJB3DU5N-y-ta2JpP0t6NHh=GVXw@mail.gmail.com>
 <CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com>
In-Reply-To: <CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sat, 3 Jul 2021 14:12:26 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1D5DzmNGsEPQomkyMCmMrtD6pQ11JRMh78vbY53edp-Q@mail.gmail.com>
Message-ID: <CAK8P3a1D5DzmNGsEPQomkyMCmMrtD6pQ11JRMh78vbY53edp-Q@mail.gmail.com>
Subject: Re: [GIT PULL 1/2] asm-generic: rework PCI I/O space access
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 2, 2021 at 9:42 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Jul 2, 2021 at 6:48 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > A rework for PCI I/O space access from Niklas Schnelle:
>
> I pulled this, but then I ended up unpulling.
>
> I don't absolutely _hate_ the concept, but I really find this to be
> very unpalatable:
>
>   #if !defined(inb) && !defined(_inb)
>   #define _inb _inb
>   static inline u8 _inb(unsigned long addr)
>   {
>   #ifdef PCI_IOBASE
>         u8 val;
>
>         __io_pbr();
>         val = __raw_readb(PCI_IOBASE + addr);
>         __io_par(val);
>         return val;
>   #else
>         WARN_ONCE(1, "No I/O port support\n");
>         return ~0;
>   #endif
>   }
>   #endif
>
> because honestly, the notion of a run-time warning for a compile-time
> "this cannot work" is just wrong.

Ok, fair enough, back to the drawing board then.

> If the platform doesn't have inb/outb, and you compile some driver
> that uses them, you don't want a run-time warning. Particularly since
> in many cases nobody will ever run it, and the main use case was to do
> compile-testing across a wide number of platforms.
>
> So if the platform doesn't have inb/outb, they simply should not be
> declared, and there should be a *compile-time* error. That is
> literally a lot more useful, and it avoids this extra code.

I tried adding a Kconfig option over a decade ago, but at the time
gave up when I couldn't still get drivers/ide and the 8250 uart driver
to build in a sensible way that would still allow the MMIO based
variants to work, but leave out the PIO accessors. With drivers/ide
gone, and the drivers/tty/serial/ having gone through many changes,
it's probably easier now.

I could imagine adding a CONFIG_LEGACY_PCI that controls
whether we have any pre-PCIe devices or those PCIe drivers
that need PIO accessors other than ioport_map()/pci_iomap().

This can then select a CONFIG_IOPORT, which controls whether
inb/outb etc are provided. x86 and anything that uses inb/outb for
non-PCI devices would select it as well.

> Extra code that not only doesn't add value, but that actually
> *subtracts* value is not code I really want to pull.

What happened here specifically is that the asm-generic version
is definitely broken and can cause a NULL pointer dereference
on platforms that used to fall back to NULL PCI_IOBASE.

The latest clang does complain about those drivers with a
correct warning (not an error) that shows up in s390 allmodconfig
builds. Niklas' original version of the patch tried to shut up the
warning but did not address the dangerous behavior, which I
did not find sufficient either.

The version we got here makes it no longer crash the kernel, but
I see your point that the runtime warning is still wrong. I'll have
a look at what it would take to guard all inb/outb callers with a
Kconfig conditional, and will report back after that.

      Arnd
