Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678A84825F0
	for <lists+linux-arch@lfdr.de>; Fri, 31 Dec 2021 22:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbhLaVzz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Dec 2021 16:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbhLaVzz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Dec 2021 16:55:55 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F80EC061574;
        Fri, 31 Dec 2021 13:55:54 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id v16so24359721pjn.1;
        Fri, 31 Dec 2021 13:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=T1hx50UVDERByCQtA2jPhEceIqEPV53U/9yB8e5/FYk=;
        b=LjsOP7dtkJk8TTLzgH2x733jvWKdpcNmqgEkJGbhcliBN3P4mGcoa4RHGyc7AE+uv0
         1q6IiTtA1Dj+hFT4fbo5YFfHQJP3D3q9epLhg2FMsybdbsOcLxZAwPm0457fBAaRsDqQ
         IL99rj8gfeLcMykifXB/Gt0fb/qQevJBIrut1EB236pdFPwlsYQCiXgvL1uR2c1NkIEI
         s9mlOS/JU5lFDS2xWEDijv28JBOklmN0+7s5aGmoNcQDKeGvOeymMRfNiZGGdhERxmTx
         AwTYJpI5KYZX0tSyGEY8pkdXLvzdxOJEnG3qvPabZ4r2I9OhjOAaaBl0S4GhUjhjIInk
         c95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=T1hx50UVDERByCQtA2jPhEceIqEPV53U/9yB8e5/FYk=;
        b=MQpYCZnl/FYbNXR9jeSlzT1O5NwmGkJOiDshSsadb+Np6dzmFAiv5o0SKVJ+Dwj6YA
         2ugKrIxUJYTLp4pb66wmL1Ln41T6QlXSXL8y4nCzZzfEn4k7Viqz8Gt9X4XMPzswSYyb
         rKRl5GcD4XdIH/Dt/KPDD5zts5sFByo8t7Bddb+2LrzcGqiozUfEDTbti2Mvrwkkjjql
         leIP8svaLCeeFEsh5q0AzO8TnrmMSSE2wB8Iwp2xpLONK93D72h8S16F6GxrDD1Bse0j
         jDhKLvdg9FoKwzxRD/HP2DyS3so1U6rigsGusBp2oT4o8CU3hn9BISMxE76r0Tghi66/
         gBUQ==
X-Gm-Message-State: AOAM532+FBppVzOLcnKjqzq2fZHIG09gJTcpUYTqRJtQg1xwcAsoZxEv
        /vAx7Yh3rrG1k94Pn8JOFYs=
X-Google-Smtp-Source: ABdhPJz1F4nn7gYkCA3wVb/U0vH3yAlfu9Ov4LEv5tjkAkrde3xqL11hZ+AbHJ3jgiQyphWKkycvHA==
X-Received: by 2002:a17:902:bb97:b0:144:d5cb:969f with SMTP id m23-20020a170902bb9700b00144d5cb969fmr36731618pls.36.1640987753994;
        Fri, 31 Dec 2021 13:55:53 -0800 (PST)
Received: from [10.1.1.24] (222-155-5-102-adsl.sparkbb.co.nz. [222.155.5.102])
        by smtp.gmail.com with ESMTPSA id p186sm13526661pfp.128.2021.12.31.13.55.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Dec 2021 13:55:53 -0800 (PST)
Subject: Re: [RFC 02/32] Kconfig: introduce HAS_IOPORT option and select it as
 necessary
To:     Arnd Bergmann <arnd@kernel.org>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
 <20211227164317.4146918-3-schnelle@linux.ibm.com>
 <CAMuHMdXk6VcDryekkMJ3aGFnw4LLWOWMi8M2PwjT81PsOsOBMQ@mail.gmail.com>
 <d406b93a-0f76-d056-3380-65d459d05ea9@gmail.com>
 <CAK8P3a2j-OFUUp+haHoV4PyL-On4EASZ9+59SDqNqmL8Gv_k7Q@mail.gmail.com>
 <1f90f145-219e-1cad-6162-9959d43a27ad@gmail.com>
 <CAK8P3a3NqU-3nUZ9ve=QyPPB5Uep3eK+_hicjjSiP8VuL4FYfA@mail.gmail.com>
 <0211719b-8402-9865-8e5d-5c0a35715816@gmail.com>
 <CAK8P3a2GGGuP0miLRy8w2+8vdSsGRNioBHEZ-ervSBrYbuZ+5w@mail.gmail.com>
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
        Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        Openrisc <openrisc@lists.librecores.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <a635e885-c365-8bdc-bf3c-e74d7d39a786@gmail.com>
Date:   Sat, 1 Jan 2022 10:55:27 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2GGGuP0miLRy8w2+8vdSsGRNioBHEZ-ervSBrYbuZ+5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

Am 01.01.2022 um 05:04 schrieb Arnd Bergmann:
> On Wed, Dec 29, 2021 at 10:44 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> Am 30.12.2021 um 14:48 schrieb Arnd Bergmann:
>>> On Tue, Dec 28, 2021 at 11:15 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
>>> What some other architectures do is to rely on inb()/outb() to have a
>>> zero-based offset, and use an io_offset in PCI buses to ensure that a
>>> low port number on the bus gets translated into a pointer value for the
>>> virtual mapping in the kernel, which is then represented as an unsigned
>>> int.
>>
>> M54xx does just that for Coldfire:
>>
>> arch/m68k/include/asm/io_no.h:
>> #define PCI_IO_PA       0xf8000000              /* Host physical address */
>>
>> (used to set PCI BAR mappings, so matches your definition above).
>
> I think coldfire gets it right here, using PCI_IOBASE to find the start of
> the window and a zero io_offset:
>
> #define PCI_IOBASE ((void __iomem *) PCI_IO_PA)

Good - I bear that in mind if I ever get around to reactivating my 060 
accelerator and the PCI board for that.

>> All other (MMU) m68k users of inb()/outb() apply an io_offset in the
>> platform specific address translation:
>>
>> arch/m68k/include/asm/io_mm.h:
>>
>> #define q40_isa_io_base  0xff400000
>> #define enec_isa_read_base  0xfffa0000
>> #define enec_isa_write_base 0xfffb0000
>>
>> arch/m68k/include/asm/amigayle.h:
>>
>> #define GAYLE_IO                (0xa20000+zTwoBase)     /* 16bit and
>> even 8bit registers */
>> #define GAYLE_IO_8BITODD        (0xa30000+zTwoBase)     /* odd 8bit
>> registers */
>>
>> (all constants used in address translation inlines that are used by the
>> m68k inb()/outb() macros - you can call that the poor man's version of
>> PCI BAR mappings ...).
>
> This still looks like the same thing to me, where you have inb() take a
> zero-based port number, not a pointer. The effect is the same as the
> coldfire version, it just uses a custom inline function instead of the
> version from asm-generic/io.h.

Right.

>> So as long as support for any of the m68k PCI or ISA bridges is selected
>> in the kernel config, the appropriate IO space mapping is applied. If no
>> support for PCI or ISA bridges is selected, we already fall back to zero
>> offset mapping (but as far as I can tell, it shouldn't be possible to
>> build a kernel without bridge support but drivers that require it).
>
> Right.
>
>>> As this is indistinguishable from architectures that just don't have
>>> a base address for I/O ports (we unfortunately picked 0 as the default
>>> PCI_IOBASE value), my suggestion was to start marking architectures
>>> that may have this problem as using HAS_IOPORT in order to keep
>>> the existing behavior unchanged. If m68k does not suffer from this,
>>> making HAS_IOPORT conditional on those config options that actually
>>> need it would of course be best.
>>
>> Following your description, HAS_IOPORT would be required for neither of
>> PCI, ISA or ATARI_ROM_ISA ??
>
> For these three options, we definitely need HAS_IOPORT, which would
> imply that some version of inb()/outb() is provided. The difference between

Thanks for clarifying that (and to Niklas as well). Did sound a little 
counter-intuitive to me...

> using a custom PCI_IOBASE (or an open-coded equivalent) and using
> a zero PCI_IOBASE in combination with registering PCI using a custom
> io_offset is whether we can use drivers with hardcoded port numbers.
> These should depend on a different Kconfig symbol to be introduced
> (CONFIG_HARDCODED_IOPORT or similar) once we introduce them,
> and you could decide for m68k whether to allow those or not, I would
> assume you do want them in order to use certain legacy ISA drivers.

That's exactly the purpose (though we're overmuch pushing the envelope 
trying to accomodate legacy ISA drivers on too many platforms).

Cheers,

	Michael


>        Arnd
>
