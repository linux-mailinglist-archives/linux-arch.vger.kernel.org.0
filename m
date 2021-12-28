Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C49480832
	for <lists+linux-arch@lfdr.de>; Tue, 28 Dec 2021 11:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbhL1KIa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Dec 2021 05:08:30 -0500
Received: from mail-pj1-f50.google.com ([209.85.216.50]:46909 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbhL1KI3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Dec 2021 05:08:29 -0500
Received: by mail-pj1-f50.google.com with SMTP id rj2-20020a17090b3e8200b001b1944bad25so16624366pjb.5;
        Tue, 28 Dec 2021 02:08:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1LdjVJCupkO66VZRPSdtPXWlxTkxQlblL8anKkt6w1Y=;
        b=ZxAXFS8epFPw09ZN0+5hygHuHtiZD15wSaBV6dxyVVAvNOnLiTLcLSpVzMBp3GRSKs
         lHONSdKRFsYbvSS2nNdc9qIlUsl6URjcppunLPl7poQwyhsAq54aQFG1T5efkgB0WTpj
         jszpoUuVcDSpiNtyCF/Iuv+E019pAkaqLrKm408xBzxLPCiT59hf7wA+OVGSqW1PuNBS
         IqNSrixAy/47uuKqQSMp71+oq4JVQ+fqDdr+cgWwUC+3FyMTTUmoEZUTFjwdwPeTFdkk
         2G9f/TmP0nFeemKqPiUCLCJcTYa9EtgokgorLJG3SqwEPSIAJjU+qr//95aOIB9Wm4dU
         Qcww==
X-Gm-Message-State: AOAM531kJlRu9ZXA2MVpfjDqV+WLIS9VCO+uQj4cWaFiXbaxO/6LYPJK
        cz0WDB9ZfFOUiA17tbzDs4KXNIakGRV9DA==
X-Google-Smtp-Source: ABdhPJwtJyt0BgB9nbPsBRAQG20xhRS7PITFUS4MEI44HL4ksxJALw2U9DOV/Yv9U25TYDqf80Z5gg==
X-Received: by 2002:a17:90b:1e07:: with SMTP id pg7mr25529252pjb.228.1640686108603;
        Tue, 28 Dec 2021 02:08:28 -0800 (PST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com. [209.85.216.52])
        by smtp.gmail.com with ESMTPSA id rm3sm15580381pjb.8.2021.12.28.02.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Dec 2021 02:08:28 -0800 (PST)
Received: by mail-pj1-f52.google.com with SMTP id rj2-20020a17090b3e8200b001b1944bad25so16624295pjb.5;
        Tue, 28 Dec 2021 02:08:27 -0800 (PST)
X-Received: by 2002:a05:6122:21a6:: with SMTP id j38mr6293010vkd.39.1640686096258;
 Tue, 28 Dec 2021 02:08:16 -0800 (PST)
MIME-Version: 1.0
References: <20211227164317.4146918-1-schnelle@linux.ibm.com> <20211227164317.4146918-3-schnelle@linux.ibm.com>
In-Reply-To: <20211227164317.4146918-3-schnelle@linux.ibm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Dec 2021 11:08:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXk6VcDryekkMJ3aGFnw4LLWOWMi8M2PwjT81PsOsOBMQ@mail.gmail.com>
Message-ID: <CAMuHMdXk6VcDryekkMJ3aGFnw4LLWOWMi8M2PwjT81PsOsOBMQ@mail.gmail.com>
Subject: Re: [RFC 02/32] Kconfig: introduce HAS_IOPORT option and select it as necessary
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
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
        Michael Schmitz <schmitzmic@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Niklas,

On Mon, Dec 27, 2021 at 5:44 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> We introduce a new HAS_IOPORT Kconfig option to gate support for
> I/O port access. In a future patch HAS_IOPORT=n will disable compilation
> of the I/O accessor functions inb()/outb() and friends on architectures
> which can not meaningfully support legacy I/O spaces. On these platforms
> inb()/outb() etc are currently just stubs in asm-generic/io.h which when
> called will cause a NULL pointer access which some compilers actually
> detect and warn about.
>
> The dependencies on HAS_IOPORT in drivers as well as ifdefs for
> HAS_IOPORT specific sections will be added in subsequent patches on
> a per subsystem basis. Then a final patch will ifdef the I/O access
> functions on HAS_IOPORT thus turning any use not gated by HAS_IOPORT
> into a compile-time warning.
>
> Link: https://lore.kernel.org/lkml/CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com/
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks for your patch!

> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -16,6 +16,7 @@ config M68K
>         select GENERIC_CPU_DEVICES
>         select GENERIC_IOMAP
>         select GENERIC_IRQ_SHOW
> +       select HAS_IOPORT
>         select HAVE_AOUT if MMU
>         select HAVE_ASM_MODVERSIONS
>         select HAVE_DEBUG_BUGVERBOSE

This looks way too broad to me: most m68k platform do not have I/O
port access support.

My gut feeling says:

    select HAS_IOPORT if PCI || ISA

but that might miss some intricate details...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
