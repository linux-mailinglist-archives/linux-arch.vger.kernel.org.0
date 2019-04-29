Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79324E11A
	for <lists+linux-arch@lfdr.de>; Mon, 29 Apr 2019 13:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfD2LNu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Apr 2019 07:13:50 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38514 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbfD2LNu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Apr 2019 07:13:50 -0400
Received: by mail-qk1-f196.google.com with SMTP id g141so1301153qke.5;
        Mon, 29 Apr 2019 04:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x28FrJjCiQBqslkV+zQDusUSdhRwlePNuGMIarDkv/M=;
        b=KjFCx3f8TeZtNxQPZkuirjnLjg6sgQ4GVdqWeB9Xb4jgwKvXSwejAP8d0Ve9GxJHqy
         +5zh/Y7cF5oUq3nm6ZcwLXIC1tAWVlykQA2GLEdezucoGIj0geG9CvfkbqMgPh4WRGkB
         uXwCoY3pcUah5nME6m8J7dvCxkdCojs1mzQPkcPGYem2VvoHn2su0X3rz5R/lzWzKnUL
         yXcVmDp1piq2OBXcX8xaChlcOEocEh8ATEOSa9jIlnoOoPRZ/NGhIIAm26MzWCSADvCW
         JvmVnbOOln+DqXgO2KOlzR988WAySKsCXKIQVEoWGols5OPUb1raZu6rT6VQiBWOzdem
         N/qA==
X-Gm-Message-State: APjAAAVNs2GkOcAT/YHJfEBavVm/Jo/KZ+v9uod842lvrlyP+gnVQ0Zo
        kFmj60FFngIU5bWU8msY8Vwyhi+caBrciDp0xi8=
X-Google-Smtp-Source: APXvYqz5Mm4SyC+HruUyK9z+7pLahPm2GOCckLoU5T6jy4fQSPbtU+ocNRTAYbZOsAs2wlbEba/EZ/7vwNo/tqCKHl4=
X-Received: by 2002:a37:c402:: with SMTP id d2mr34106774qki.291.1556536429180;
 Mon, 29 Apr 2019 04:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190427153222.GA9613@jerusalem> <20190427202150.GB9613@jerusalem>
 <CAMuHMdXNCxHP=BWPOy70LjNJoMH+zy7yYOHj29gYt79_5=4ffg@mail.gmail.com>
 <CAK8P3a2F6KW3M7ZaK=WL8429j_z=y_wXrx6rthxni8vBmsMPyg@mail.gmail.com>
 <c75092d5-0bbf-cd8e-d0a2-ff1384ac5a48@linux-m68k.org> <CAMuHMdUC6zXH5SUEChDNHHJL2=Aq6XfRebFWK0JtH5zDWMSVgQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUC6zXH5SUEChDNHHJL2=Aq6XfRebFWK0JtH5zDWMSVgQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Apr 2019 13:13:32 +0200
Message-ID: <CAK8P3a0gex0ffvX9zQDV=N7g6q7UAxxYRn2PeAbbAgrd1wTvQg@mail.gmail.com>
Subject: Re: endianness swapped
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Angelo Dureghello <angelo@sysam.it>,
        Logan Gunthorpe <logang@deltatee.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 29, 2019 at 10:44 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Sun, Apr 28, 2019 at 3:59 PM Greg Ungerer <gerg@linux-m68k.org> wrote:
> > On 28/4/19 7:21 pm, Arnd Bergmann wrote:
> > > On Sun, Apr 28, 2019 at 10:46 AM Geert Uytterhoeven
> > > <geert@linux-m68k.org> wrote:
> > >>
> > >> Orthogonal to how Coldfire's read[wl]() should be fixed, I find it a bit
> > >> questionable to swap data twice on big endian architectures.
> > >
> > > I would expect that the compiler is capable of detecting a double
> > > swap and optimize it out. Even if it can't, there are not that many
> > > instances of io{read,write}{16,32}be in the kernel, so the increase
> > > in kernel image size from a double swap should be limited to a
> > > few extra instructions, and the runtime overhead should be
> > > negligible compared to the bus access.
>
> Probably the overhead is not negligible on old m68k...

Maybe the I/O devices are faster than I expected then. I was guessing
that there is still a factor of 100x or more between going to an on-chip
bus and single byterev register-to-register instruction.

I did notice that __arch_swab32() is an inline assembly, so the
compiler has no way of eliminating the double swap, but
setting CONFIG_ARCH_USE_BUILTIN_BSWAP makes it
do the right thing.

      Arnd
