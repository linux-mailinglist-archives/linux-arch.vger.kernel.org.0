Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E2A481903
	for <lists+linux-arch@lfdr.de>; Thu, 30 Dec 2021 04:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbhL3DpO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Dec 2021 22:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbhL3DpO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Dec 2021 22:45:14 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13111C06173E;
        Wed, 29 Dec 2021 19:45:14 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id q3so15979815pfs.7;
        Wed, 29 Dec 2021 19:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=5E1c4uav1w29ypwAHwbdxz4O+xfES0SpMBM/hIdsoE0=;
        b=WbuJzdZv6QdxI4sm1uAN5RK2dB/vxRRAL3AviYD6SfM29AlUSb5I5hMDIqugVgl6q5
         V/7xuA/EOm2Dv0zChCOeqZsFvsMIm7UeuFMBWZAvuAVpy5VWIbHsXe0LO+k7wbZT9XA+
         bKo1QUX3kp7MeKzCaqX8Qy0FWsFH26Y65uXLR/vaqgIBvGoVcBkMmv2ha7gL/lhC+wsc
         9IDoT4MY3JFxvbdNQp9rzst5K+jmfgdTuMjjeHVOo5kymPqz9E6EMIfWlGg4R2VCRufH
         r5zUkrJO0E2MYAcArK0leS4VFV7M5hYte5KRuaiLgKGVmb4cT/v9GFrgNcGmE2q7OUEY
         IqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=5E1c4uav1w29ypwAHwbdxz4O+xfES0SpMBM/hIdsoE0=;
        b=X/iQ5/eOga69xI1DYGh5N3MTn224+V3Z/T8cxkTwhmBJ3mWR8jP0KAKW1Plw9cnf5P
         z2UOeeDxEc1AOXgpXtEK3wnLZ0UD9kLty1VaQSEMSWOehsPywcm11Ut0awjGw8Wzerf9
         9ohNdvsfFUjlaG25eA9yD8KZqtww/BPBid+pel0alr2aEY5kg2ejO8jW0Uu5vQsGEOfF
         NA43jY9K6SQq9+ZnNCk9yglCIeGcL+Bz6KzPSls9TxKzTBZ27q9Q3wET5hSA7bAXExVq
         CkItPwS7wMmEYWZe3yWZaf2JSzoHrO+VT08Ctwp4sFDRbFiqp6zbIEtnDzBtsF5hcgaJ
         JaQA==
X-Gm-Message-State: AOAM532Tc8VGjitRcNmeD4uV2zdxK4eN/FRFV81Oc3HQz5bDMXHqk6CX
        KIdqx7cWrViWXfNtodKOhAk=
X-Google-Smtp-Source: ABdhPJzhu0vR0ubHbZDDMdnE240kX84aNyi3i3N9D1mBlwe522lCZMc1R9id41niT15FZfmjs4s+bA==
X-Received: by 2002:a63:10a:: with SMTP id 10mr26111733pgb.170.1640835913587;
        Wed, 29 Dec 2021 19:45:13 -0800 (PST)
Received: from [10.1.1.24] (222-155-5-102-adsl.sparkbb.co.nz. [222.155.5.102])
        by smtp.gmail.com with ESMTPSA id pg12sm29480602pjb.4.2021.12.29.19.44.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Dec 2021 19:45:12 -0800 (PST)
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
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <0211719b-8402-9865-8e5d-5c0a35715816@gmail.com>
Date:   Thu, 30 Dec 2021 16:44:45 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3NqU-3nUZ9ve=QyPPB5Uep3eK+_hicjjSiP8VuL4FYfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

Am 30.12.2021 um 14:48 schrieb Arnd Bergmann:
> On Tue, Dec 28, 2021 at 11:15 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> Am 29.12.2021 um 16:41 schrieb Arnd Bergmann:
>>> On Tue, Dec 28, 2021 at 8:20 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> I'd hope not - we spent some effort to make sure setting ATARI_ROM_ISA
>> does not affect other m68k platforms when e.g. building multiplatform
>> kernels.
>
> Ok
>
>> Replacing inb() by readb() without any address translation won't do much
>> good for m68k though - addresses in the traditional ISA I/O port range
>> would hit the (unmapped) zero page.
>
> Correct, this is exactly the problem that Niklas is trying to solve here:
> we do have drivers that hit this bug, and on s390 clang actually produces
> a compile-time error for drivers that cause a NULL pointer dereference
> this way.

Thanks for clarifying - I only saw Geert's CC and failed to go back to 
the start of the thread.

> What some other architectures do is to rely on inb()/outb() to have a
> zero-based offset, and use an io_offset in PCI buses to ensure that a
> low port number on the bus gets translated into a pointer value for the
> virtual mapping in the kernel, which is then represented as an unsigned
> int.

M54xx does just that for Coldfire:

arch/m68k/include/asm/io_no.h:
#define PCI_IO_PA	0xf8000000		/* Host physical address */

(used to set PCI BAR mappings, so matches your definition above).

All other (MMU) m68k users of inb()/outb() apply an io_offset in the 
platform specific address translation:

arch/m68k/include/asm/io_mm.h:

#define q40_isa_io_base  0xff400000
#define enec_isa_read_base  0xfffa0000
#define enec_isa_write_base 0xfffb0000

arch/m68k/include/asm/amigayle.h:

#define GAYLE_IO                (0xa20000+zTwoBase)     /* 16bit and 
even 8bit registers */
#define GAYLE_IO_8BITODD        (0xa30000+zTwoBase)     /* odd 8bit 
registers */

(all constants used in address translation inlines that are used by the 
m68k inb()/outb() macros - you can call that the poor man's version of 
PCI BAR mappings ...).

So as long as support for any of the m68k PCI or ISA bridges is selected 
in the kernel config, the appropriate IO space mapping is applied. If no 
support for PCI or ISA bridges is selected, we already fall back to zero 
offset mapping (but as far as I can tell, it shouldn't be possible to 
build a kernel without bridge support but drivers that require it).

>
> As this is indistinguishable from architectures that just don't have
> a base address for I/O ports (we unfortunately picked 0 as the default
> PCI_IOBASE value), my suggestion was to start marking architectures
> that may have this problem as using HAS_IOPORT in order to keep
> the existing behavior unchanged. If m68k does not suffer from this,
> making HAS_IOPORT conditional on those config options that actually
> need it would of course be best.

Following your description, HAS_IOPORT would be required for neither of 
PCI, ISA or ATARI_ROM_ISA ??

Cheers,

	Michael


>
>          Arnd
>
