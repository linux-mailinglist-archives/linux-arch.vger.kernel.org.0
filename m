Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4450480E78
	for <lists+linux-arch@lfdr.de>; Wed, 29 Dec 2021 02:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbhL2BVI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Dec 2021 20:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238150AbhL2BVH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Dec 2021 20:21:07 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BA0C061574;
        Tue, 28 Dec 2021 17:21:07 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id v25so17214069pge.2;
        Tue, 28 Dec 2021 17:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ce+QRujFh6Z6jXwpwj96Ajoqinq3qkVE1ootEg0tvM4=;
        b=HR4+5gEvbRK0rU8/dntHoBj1g+0X3qKpLMsP358svmvVe4LU0yAyJLNGs3fCG1IxN5
         M/QTR8OXVpknffzN/8b3pOWH0ImhkhbIhkjgUWsWwTRZMZ2woqwqIa5115FbA6Nf6xT4
         TiKsVnkG1OLJDDZ06iwYnbvfkz/MJz2DtOV5zSZDVPVN2jIRsDW3XOaMugqlveDm5gnG
         bFN6SiWtJfdMPi0YTy0yZg20PhHPIvQQsScpgCUPn8k9cu6v+natJ9ebpk8jSRGpwixK
         MiRCzMxl519LQW1SjZgL9Y49JFwBww9vU7/YKwkn2coaccmwFAJf32w2Pk2xT9akAsgc
         lavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ce+QRujFh6Z6jXwpwj96Ajoqinq3qkVE1ootEg0tvM4=;
        b=3cAgaISPe6iDiOddkPv0lqlXrSy3AKpOXh3NtLmjTn9vWZEUcpXuoKnrtWdH+V5FCb
         lsW1e1fQl809DRHJdBld8g82kq3v6dBN07R5zT2Z4Z4XbvgxfBaE0pXFHLVrLrS76OKe
         P202ipesU6XjiINC5pJbU+jZCtRlerHK7jePd2cJUVPb6kcyIKESLokmwojC6flYM4k1
         L8DCrqwVO+nZKnKo1Q9hUI3Pj/csAsubrjbFq3CWHIV6OsG+KDhJgdGaEDY/dPzMcMyZ
         MIXv05XtEuzhmpz8HO2J8crMVgSIyKK2y+l7QAOuWfXjHTdCALHJ5aykfZeDvUUv0Kne
         yyZA==
X-Gm-Message-State: AOAM533De7O8yg0IW11cBjcxIOLGKjA/O+8KdOuc61KFdsYYCDvezfzR
        AGheKH0nrObwVumEDl0mKWM=
X-Google-Smtp-Source: ABdhPJx/po46hxln8jdEFq24zHXmQfZv0rMy1a+pao1gS+//RcuuYa1+uO7C36+ZKnR8X7vS6LfebQ==
X-Received: by 2002:a05:6a00:cca:b0:4ba:f5cc:538c with SMTP id b10-20020a056a000cca00b004baf5cc538cmr24584430pfv.60.1640740867094;
        Tue, 28 Dec 2021 17:21:07 -0800 (PST)
Received: from [10.1.1.24] (222-155-5-102-adsl.sparkbb.co.nz. [222.155.5.102])
        by smtp.gmail.com with ESMTPSA id cm20sm18920963pjb.28.2021.12.28.17.20.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Dec 2021 17:21:06 -0800 (PST)
Subject: Re: [RFC 02/32] Kconfig: introduce HAS_IOPORT option and select it as
 necessary
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
 <20211227164317.4146918-3-schnelle@linux.ibm.com>
 <CAMuHMdXk6VcDryekkMJ3aGFnw4LLWOWMi8M2PwjT81PsOsOBMQ@mail.gmail.com>
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
        Greg Ungerer <gerg@linux-m68k.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <d406b93a-0f76-d056-3380-65d459d05ea9@gmail.com>
Date:   Wed, 29 Dec 2021 14:20:38 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXk6VcDryekkMJ3aGFnw4LLWOWMi8M2PwjT81PsOsOBMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Geert, Niklas,



Am 28.12.2021 um 23:08 schrieb Geert Uytterhoeven:
> Hi Niklas,
>
> On Mon, Dec 27, 2021 at 5:44 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
>> We introduce a new HAS_IOPORT Kconfig option to gate support for
>> I/O port access. In a future patch HAS_IOPORT=n will disable compilation
>> of the I/O accessor functions inb()/outb() and friends on architectures
>> which can not meaningfully support legacy I/O spaces. On these platforms
>> inb()/outb() etc are currently just stubs in asm-generic/io.h which when
>> called will cause a NULL pointer access which some compilers actually
>> detect and warn about.
>>
>> The dependencies on HAS_IOPORT in drivers as well as ifdefs for
>> HAS_IOPORT specific sections will be added in subsequent patches on
>> a per subsystem basis. Then a final patch will ifdef the I/O access
>> functions on HAS_IOPORT thus turning any use not gated by HAS_IOPORT
>> into a compile-time warning.
>>
>> Link: https://lore.kernel.org/lkml/CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com/
>> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
>> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>
> Thanks for your patch!
>
>> --- a/arch/m68k/Kconfig
>> +++ b/arch/m68k/Kconfig
>> @@ -16,6 +16,7 @@ config M68K
>>         select GENERIC_CPU_DEVICES
>>         select GENERIC_IOMAP
>>         select GENERIC_IRQ_SHOW
>> +       select HAS_IOPORT
>>         select HAVE_AOUT if MMU
>>         select HAVE_ASM_MODVERSIONS
>>         select HAVE_DEBUG_BUGVERBOSE
>
> This looks way too broad to me: most m68k platform do not have I/O
> port access support.
>
> My gut feeling says:
>
>     select HAS_IOPORT if PCI || ISA
>
> but that might miss some intricate details...

In particular, this misses the Atari ROM port ISA adapter case -

	select HAS_IOPORT if PCI || ISA || ATARI_ROM_ISA

might do instead.

Cheers,

	Michael


>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
>
