Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75759E35DE
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2019 16:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409453AbfJXOpJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Oct 2019 10:45:09 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:24886 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407467AbfJXOpJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Oct 2019 10:45:09 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x9OEj0L2012214;
        Thu, 24 Oct 2019 23:45:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x9OEj0L2012214
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1571928302;
        bh=Iz5ljsY1vmLvI0mOS7EWijhyK4tTqgM6F86vrENgiVs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XuEpv6v+08+HEFUKt1nsno1ivURsuGaawR1uZ6//rOOtZvw8JXRildBiVB9W9XN+S
         wciR4xlZx1oPYgJohCAvfqLGQKPAD1Vk2v4MJhNFGxLsRR5okiWFVvZmIQumcV2zpq
         HukEpGBtMEObWMbHpOA9ynTMX/MIkHRXrD8j0/kJh6xE9jciWN5koDJ0+F+z3PkrQh
         7NQgACo7X2llADFk3iHwfTN0+KgXAdP4XBC8+qeD9NDLNt3W25R91kW02OwFUJiCuM
         ZvhsUhh4oQY9HfdHXGzof29LMuXvvNZKVK/D92rgp2OPF7WsyD22ZOKhhwgN7HlwOZ
         kOL6bpFHSMs5Q==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id q21so949524vsg.3;
        Thu, 24 Oct 2019 07:45:00 -0700 (PDT)
X-Gm-Message-State: APjAAAXBv2qly1OYItS2yPy0YbYmH0j5MQZZH91JTb3ihhOOIKgO7Vkw
        kwJahbNBuByz3Y9UDiA6S0qgGAz2OsGAoH1l7Pw=
X-Google-Smtp-Source: APXvYqwMmECxCcxI186HHSlk+trzDvWmCSjS3nuXCEEC9fv9GKq3Y9CX2QuL9vFeUeY4EpiP8jJ31MuCUnUXccmWpjo=
X-Received: by 2002:a67:e290:: with SMTP id g16mr6221500vsf.54.1571928299628;
 Thu, 24 Oct 2019 07:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571911976.git.michal.simek@xilinx.com> <a021f232968cfffe3f2d838da47214c6bbdeeedb.1571911976.git.michal.simek@xilinx.com>
In-Reply-To: <a021f232968cfffe3f2d838da47214c6bbdeeedb.1571911976.git.michal.simek@xilinx.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 24 Oct 2019 23:44:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQvZr48zXkyhii6E-wckYfakhh9gVD=DoBOt++TtPFEaw@mail.gmail.com>
Message-ID: <CAK7LNAQvZr48zXkyhii6E-wckYfakhh9gVD=DoBOt++TtPFEaw@mail.gmail.com>
Subject: Re: [PATCH 1/2] asm-generic: Make msi.h a mandatory include/asm header
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git@xilinx.com,
        Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@infradead.org>, longman@redhat.com,
        Bjorn Helgaas <helgaas@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jackie Liu <liuyun01@kylinos.cn>,
        Wesley Terpstra <wesley@sifive.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-riscv@lists.infradead.org,
        linux-arch <linux-arch@vger.kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Burton <paul.burton@mips.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        arcml <linux-snps-arc@lists.infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-mips@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 24, 2019 at 7:13 PM Michal Simek <michal.simek@xilinx.com> wrote:
>
> msi.h is generic for all architectures expect of x86 which has own version.

Maybe a typo?  "except"


Anyway, the code looks good to me.

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>


> Enabling MSI by including msi.h to architecture Kbuild is just additional
> step which doesn't need to be done.
> The patch was created based on request to enable MSI for Microblaze.
>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
> https://lore.kernel.org/linux-riscv/20191008154604.GA7903@infradead.org/
> ---
>  arch/arc/include/asm/Kbuild     | 1 -
>  arch/arm/include/asm/Kbuild     | 1 -
>  arch/arm64/include/asm/Kbuild   | 1 -
>  arch/mips/include/asm/Kbuild    | 1 -
>  arch/powerpc/include/asm/Kbuild | 1 -
>  arch/riscv/include/asm/Kbuild   | 1 -
>  arch/sparc/include/asm/Kbuild   | 1 -
>  include/asm-generic/Kbuild      | 1 +
>  8 files changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
> index 393d4f5e1450..1b505694691e 100644
> --- a/arch/arc/include/asm/Kbuild
> +++ b/arch/arc/include/asm/Kbuild
> @@ -17,7 +17,6 @@ generic-y += local64.h
>  generic-y += mcs_spinlock.h
>  generic-y += mm-arch-hooks.h
>  generic-y += mmiowb.h
> -generic-y += msi.h
>  generic-y += parport.h
>  generic-y += percpu.h
>  generic-y += preempt.h
> diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
> index 68ca86f85eb7..fa579b23b4df 100644
> --- a/arch/arm/include/asm/Kbuild
> +++ b/arch/arm/include/asm/Kbuild
> @@ -12,7 +12,6 @@ generic-y += local.h
>  generic-y += local64.h
>  generic-y += mm-arch-hooks.h
>  generic-y += mmiowb.h
> -generic-y += msi.h
>  generic-y += parport.h
>  generic-y += preempt.h
>  generic-y += seccomp.h
> diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
> index 98a5405c8558..bd23f87d6c55 100644
> --- a/arch/arm64/include/asm/Kbuild
> +++ b/arch/arm64/include/asm/Kbuild
> @@ -16,7 +16,6 @@ generic-y += local64.h
>  generic-y += mcs_spinlock.h
>  generic-y += mm-arch-hooks.h
>  generic-y += mmiowb.h
> -generic-y += msi.h
>  generic-y += qrwlock.h
>  generic-y += qspinlock.h
>  generic-y += serial.h
> diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
> index c8b595c60910..61b0fc2026e6 100644
> --- a/arch/mips/include/asm/Kbuild
> +++ b/arch/mips/include/asm/Kbuild
> @@ -13,7 +13,6 @@ generic-y += irq_work.h
>  generic-y += local64.h
>  generic-y += mcs_spinlock.h
>  generic-y += mm-arch-hooks.h
> -generic-y += msi.h
>  generic-y += parport.h
>  generic-y += percpu.h
>  generic-y += preempt.h
> diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
> index 64870c7be4a3..17726f2e46de 100644
> --- a/arch/powerpc/include/asm/Kbuild
> +++ b/arch/powerpc/include/asm/Kbuild
> @@ -10,4 +10,3 @@ generic-y += local64.h
>  generic-y += mcs_spinlock.h
>  generic-y += preempt.h
>  generic-y += vtime.h
> -generic-y += msi.h
> diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
> index 16970f246860..1efaeddf1e4b 100644
> --- a/arch/riscv/include/asm/Kbuild
> +++ b/arch/riscv/include/asm/Kbuild
> @@ -22,7 +22,6 @@ generic-y += kvm_para.h
>  generic-y += local.h
>  generic-y += local64.h
>  generic-y += mm-arch-hooks.h
> -generic-y += msi.h
>  generic-y += percpu.h
>  generic-y += preempt.h
>  generic-y += sections.h
> diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
> index b6212164847b..62de2eb2773d 100644
> --- a/arch/sparc/include/asm/Kbuild
> +++ b/arch/sparc/include/asm/Kbuild
> @@ -18,7 +18,6 @@ generic-y += mcs_spinlock.h
>  generic-y += mm-arch-hooks.h
>  generic-y += mmiowb.h
>  generic-y += module.h
> -generic-y += msi.h
>  generic-y += preempt.h
>  generic-y += serial.h
>  generic-y += trace_clock.h
> diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
> index adff14fcb8e4..ddfee1bd9dc1 100644
> --- a/include/asm-generic/Kbuild
> +++ b/include/asm-generic/Kbuild
> @@ -4,4 +4,5 @@
>  # (This file is not included when SRCARCH=um since UML borrows several
>  # asm headers from the host architecutre.)
>
> +mandatory-y += msi.h
>  mandatory-y += simd.h
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
