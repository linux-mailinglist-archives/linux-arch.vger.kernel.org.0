Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502C6481837
	for <lists+linux-arch@lfdr.de>; Thu, 30 Dec 2021 02:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbhL3Bsj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Dec 2021 20:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbhL3Bsj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Dec 2021 20:48:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1D7C061574;
        Wed, 29 Dec 2021 17:48:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86D2E6153E;
        Thu, 30 Dec 2021 01:48:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B23C36AE1;
        Thu, 30 Dec 2021 01:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640828918;
        bh=81MO7TacqQe8I5ko0Q8CwbDD4h/99BabB8aCDnWo0lQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jV/ycMyovnmu9pbcNLGboBsGNIaWSzFTvzZh+Mx9BwCcRQ4wkFdLiGVgRkSKcn1av
         ACLs6uhvkNBtfi0XHerEvqHG9aDTvnP0DnkZJ23UYJg1+rpYpog6ujNkprLhWymjWQ
         hVule2DRwuMYA/yBJYRWrQwKgFOWg5pmJP5humJTKlsctrnxGtyKKZV5MSDWgxD4iF
         I5CuYOMx73K52jL6eCERvW0K/qJG/CffLHmjFLJmfkBjIdmKueJ2GntN8tpN5P6Axu
         +/iJu6EgjHsacUxqabHsXc98pimqrGXyEBPg4rn/eSXczdd7VTgu9//4yKsbFR5Bjg
         v0Y95G8jR3CDw==
Received: by mail-ed1-f51.google.com with SMTP id z29so92390390edl.7;
        Wed, 29 Dec 2021 17:48:37 -0800 (PST)
X-Gm-Message-State: AOAM530OpLJ1IYviklCTU8VkdA4pUW5FJ1KdT+R3XO0MKZs3RJLmTmzG
        dtm/uwS2c5wclM3VztcRc9KsNAhfDVWfcqgCzoA=
X-Google-Smtp-Source: ABdhPJzYCdRT3l8EecUhPG5EkJz2cutHHKG9LloyzIQNKSKV94+pfG1Ig6YswCjGB6BOha4SzAwDhMxmrauWo4kartQ=
X-Received: by 2002:a5d:6989:: with SMTP id g9mr22454231wru.12.1640828906053;
 Wed, 29 Dec 2021 17:48:26 -0800 (PST)
MIME-Version: 1.0
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
 <20211227164317.4146918-3-schnelle@linux.ibm.com> <CAMuHMdXk6VcDryekkMJ3aGFnw4LLWOWMi8M2PwjT81PsOsOBMQ@mail.gmail.com>
 <d406b93a-0f76-d056-3380-65d459d05ea9@gmail.com> <CAK8P3a2j-OFUUp+haHoV4PyL-On4EASZ9+59SDqNqmL8Gv_k7Q@mail.gmail.com>
 <1f90f145-219e-1cad-6162-9959d43a27ad@gmail.com>
In-Reply-To: <1f90f145-219e-1cad-6162-9959d43a27ad@gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 29 Dec 2021 20:48:23 -0500
X-Gmail-Original-Message-ID: <CAK8P3a3NqU-3nUZ9ve=QyPPB5Uep3eK+_hicjjSiP8VuL4FYfA@mail.gmail.com>
Message-ID: <CAK8P3a3NqU-3nUZ9ve=QyPPB5Uep3eK+_hicjjSiP8VuL4FYfA@mail.gmail.com>
Subject: Re: [RFC 02/32] Kconfig: introduce HAS_IOPORT option and select it as necessary
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Karol Gugala <kgugala@antmicro.com>,
        Jeff Dike <jdike@addtoit.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Brian Cain <bcain@codeaurora.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, openrisc@lists.librecores.org,
        linux-s390@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 28, 2021 at 11:15 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Am 29.12.2021 um 16:41 schrieb Arnd Bergmann:
> > On Tue, Dec 28, 2021 at 8:20 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
> I'd hope not - we spent some effort to make sure setting ATARI_ROM_ISA
> does not affect other m68k platforms when e.g. building multiplatform
> kernels.

Ok

> Replacing inb() by readb() without any address translation won't do much
> good for m68k though - addresses in the traditional ISA I/O port range
> would hit the (unmapped) zero page.

Correct, this is exactly the problem that Niklas is trying to solve here:
we do have drivers that hit this bug, and on s390 clang actually produces
a compile-time error for drivers that cause a NULL pointer dereference
this way.

What some other architectures do is to rely on inb()/outb() to have a
zero-based offset, and use an io_offset in PCI buses to ensure that a
low port number on the bus gets translated into a pointer value for the
virtual mapping in the kernel, which is then represented as an unsigned
int.

As this is indistinguishable from architectures that just don't have
a base address for I/O ports (we unfortunately picked 0 as the default
PCI_IOBASE value), my suggestion was to start marking architectures
that may have this problem as using HAS_IOPORT in order to keep
the existing behavior unchanged. If m68k does not suffer from this,
making HAS_IOPORT conditional on those config options that actually
need it would of course be best.

         Arnd
